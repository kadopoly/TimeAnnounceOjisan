#!/bin/sh

#
# This is free and unencumbered software released into the public domain.
# 
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
# 
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
# 
# For more information, please refer to <http://unlicense.org/>
#


# EDIT THESE USER VALUES
uname=user      # your username
notify=yes      # do you want a notification OSD? ( yes / no )
engine=festival # which speech engine you use     ( festival / google )

pid=$( pgrep -u ${uname} gnome-session )
dbus=$( grep -z DBUS_SESSION_BUS_ADDRESS /proc/${pid}/environ | sed 's/DBUS_SESSION_BUS_ADDRESS=//' )

export DISPLAY=:0.0
export XAUTHORITY=/home/${uname}/.Xauthority
export DBUS_SESSION_BUS_ADDRESS=$dbus

TIME_H_NOW=`/usr/bin/date '+%H' | sed -e 's/0\([0-9]\)/\1/g'`
TIME_M_NOW=`/usr/bin/date '+%M'`
TITLE="${TIME_H_NOW}:${TIME_M_NOW}"

if [ ${TIME_M_NOW} = '00' ]
then
	BODY="It's ${TIME_H_NOW} o'clock."
else
	BODY="It's ${TIME_H_NOW}:${TIME_M_NOW}."
fi

if [ ${notify} = 'yes' ]
then
	sudo -u ${uname} /usr/bin/notify-send "${TITLE}" "${BODY}"
fi

SPEECH_TEXT=`echo ${BODY} | sed -e "s/0\([0-9]\)/\1/g" -e "s/:/,/"`
if [ ${engine} = 'festival' ]
then
	echo ${SPEECH_TEXT} | /usr/bin/festival --tts
else
	TTS_URL=`echo "http://translate.google.com/translate_tts?tl=en&q=${SPEECH_TEXT}" | sed -e "s/ /+/g"`
	wget ${TTS_URL} -q -U Mozilla -O /tmp/_time_notify_tmp.mp3
	/usr/bin/mpg123 /tmp/_time_notify_tmp.mp3 > /dev/null
fi


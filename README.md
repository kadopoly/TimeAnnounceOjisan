TimeAnnounceOjisan
==================

A *ShellScript* for *Mac*-like Time Announcement

# Quickstart

1. Satisfy the requirements. ( See *Requirements* )
2. Just download the script and put it anywhere you want.
3. Edit variables. ( See *Variables* )
4. Schedule a `cron` job for the script.
5. Now, forget about it and have a cup of coffee! Time will tell.


# Requirements

## Notification OSD

- Gnome 3, dbus
 - On the other environments, modify `pid` variable
- libnotify

## Announcement

- [Festival][festival], a speech synthesis system
 - If you use *Google Translate TTS API*, this is **not required**.
- wget
- mpg123
 - these two are required, if you use Google Translate TTS API.

## Optional Requirement for Scheduled Jobs
- cron

[festival]: https://wiki.archlinux.org/index.php/Festival "Festival - ArchWiki"


# Variables

There are a few variables you *need* to edit.

- `uname` 
 - your username: ( e.g., `Taro` )
- `notify`
 - `yes` / `no`
 - whether you want the notification OSD or not
- `engine`
 - `festival` / `google`
 - which speech engine you use
 - Google's one is unofficial. Use it at *your own risk*.

Open the script, and edit these values. You will find them at the top.


# Detailed Installation

First, place the script into any folder you want to. In this instruction, it is `/home/Taro/`.

Then, open it and edit like this:


```sh
uname=Taro      # your username
notify=yes      # do you want a notification OSD? ( yes / no )
engine=festival # which speech engine you use     ( festival / google )
```

Finally, set up a scheduled job using `crontab`. If you want announcement once every hour, it would be:

```
0 * * * * /home/Taro/announce.sh
```

Done! Enjoy!


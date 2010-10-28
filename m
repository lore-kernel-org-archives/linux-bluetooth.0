Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 28 Oct 2010 17:02:48 +0530
Message-ID: <AANLkTimTzSMQW3cJQPphWgTBKgn0fbN7zui7tRA1enmi@mail.gmail.com>
Subject: Unable to get on D-Bus: bluez 4.77
From: Puneet Pant <pant.puneet464@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have compiled Bluez 4.77. But I'm getting the following error when
trying to start Bluetooth Daemon:

root@puneet-VirtualBox:/home/puneet/packages/bluez-4.77/src#
dbus-daemon --system
root@puneet-VirtualBox:/home/puneet/packages/bluez-4.77/src# ./bluetoothd -nd
bluetoothd[11819]: Bluetooth deamon 4.77
bluetoothd[11819]: src/main.c:parse_config() parsing main.conf
bluetoothd[11819]: src/main.c:parse_config() discovto=0
bluetoothd[11819]: src/main.c:parse_config() pairto=0
bluetoothd[11819]: src/main.c:parse_config() pageto=8192
bluetoothd[11819]: src/main.c:parse_config() name=%h-%d
bluetoothd[11819]: src/main.c:parse_config() class=0x000100
bluetoothd[11819]: src/main.c:parse_config() discov_interval=0
bluetoothd[11819]: src/main.c:parse_config() Key file does not have
key 'DeviceID'
bluetoothd[11819]: Unable to get on D-Bus


I've built kernel version 2.6.36-rc7 with LE patches from Ville Tervo
and am running it on an Ubuntu 10.10 distribution. Installed Dbus
Library version is 1.2.24 (I have also tried with 1.4.0, but get same
error)

I have tried to google around on this but couldn't find anything
relevant that could fix this issue.
Can someone kindly suggest if this is related to my linux pc
configuration or more of Bluez issue?

Thanks in advance.
Puneet

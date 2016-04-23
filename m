Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 23 Apr 2016 10:19:31 +0300
Message-ID: <CADrC6Gxef2A=EsVLxG-izD4xBKvrBW85wOzybuZCrr-OL52VSw@mail.gmail.com>
Subject: bluez dbus ble connection problem when a filter is set
From: =?UTF-8?B?SGFra8SxIEfDtsOnZW/En2x1?= <hakki@bir618.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

raspberry pi 3
bluez v5.39
testing platform client/bluetoothctl

I have a ble peripheral device advertising a custom uuid.
Within bluetoothctl when I try to connect to it after a filter is set,
one third of the time I get an error.
There is no problem if no filter is set, turning scanning off before
the connect command does not help.

Here is an example flow within bluetoothctl

[bluetooth]# set-scan-filter-uuids f655b638-fead-4268-b07c-e5d79d09b22b
SetDiscoveryFilter success
[bluetooth]# scan on
Discovery started
[CHG] Controller B8:27:EB:37:3F:CD Discovering: yes
[NEW] Device CF:05:30:F2:6F:5E CF-05-30-F2-6F-5E
[bluetooth]# connect CF:05:30:F2:6F:5E
Attempting to connect to CF:05:30:F2:6F:5E
[CHG] Device CF:05:30:F2:6F:5E Connected: yes
Failed to connect: org.bluez.Error.Failed
[CHG] Device CF:05:30:F2:6F:5E Connected: no


Any ideas? Thanks in advance, cheers

hakkig

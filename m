Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Wilson Perez <wilsonpp@gmail.com>
Date: Mon, 19 Sep 2016 11:19:30 -0400
Message-ID: <CALe7QMD7xAu3dJWY6SBg5DLRhkYUw8GSmkL9Ktm7ix=AxD9fqQ@mail.gmail.com>
Subject: hciconfig piscan timeout issue
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm having an issue with hciconfig in Bluez 5.41 when making my
bluetooth device discoverable by means of the piscan command.  By
executing the following:
hciconfig hci0 piscan
the bluetooth device is configured as discoverable but it remains
discoverable until the system is rebooted or the noscan command is
executed.

I have set:
DiscoverableTimeout = 30
in /etc/bluetooth/main.conf and verified the setting is read and the
timer configured accordingly by running bluetoothd in debug mode but
it does not appear like the timer is executed.  I have also tried
unsuccessfully several other settings including commenting out the
line to use the default value of 180.

If I run:
dbus-send --system --dest=org.bluez --print-reply /org/bluez/hci0
org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1
string:Discoverable variant:boolean:true
to make the bluetooth device discoverable, the DiscoverableTimeout
timer works as expected.

Is there anything I'm missing that is causing this unexpected behavior
in Bluez 5.41?

Thanks in advance.

Wilson

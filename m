Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Can no longer connect to audio stream with bluez > 0.96 and
 pulseaudio-2
Date: Fri, 20 Jul 2012 17:19:32 +0000
Message-ID: <654DF80AD31A344E93DBCC6280BD6DEF8598CFFC@NL0230MBX08N1.DIR.slb.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using bluez-0.96 and pulseaudio-1.xx I could use bluetooth headphones without problems using blueman-1.23 to connect to an a2dp sink.

With bluez-0.99/0.101 and pulseaudio-2 I can no longer connect and blueman gives the following error:

Stream setup failed

I see that bluez has moved to the MediaEndpoint format and that I need a /usr/local/etc/bluetooth/audio.conf for the first time, but things still don't work (details below), am I doing something wrong?

Regards
John
-----------------------------
audio.conf

[General]
Enable=Source,Sink,Headset,Gateway,Control,Media

$ echo "0000" | simple-agent hci0 00:1B:66:00:31:88
Release
New device (/org/bluez/8112/hci0/dev_00_1B_66_00_31_88)

$ pulseaudio -vv

D: [pulseaudio] dbus-util.c: Successfully connected to D-Bus system bus f0e34796d5401d46e695407a00000013 as :1.53
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.freedesktop.DBus, path=/org/freedesktop/DBus, member=NameAcquired
D: [pulseaudio] bluetooth-util.c: Registering /MediaEndpoint/HFPAG on adapter /org/bluez/8112/hci0.
D: [pulseaudio] bluetooth-util.c: Registering /MediaEndpoint/HFPHS on adapter /org/bluez/8112/hci0.
D: [pulseaudio] bluetooth-util.c: Registering /MediaEndpoint/A2DPSource on adapter /org/bluez/8112/hci0.
D: [pulseaudio] bluetooth-util.c: Registering /MediaEndpoint/A2DPSink on adapter /org/bluez/8112/hci0.
I: [pulseaudio] module.c: Loaded "module-bluetooth-discover" (index: #6; argument: "").

$ dbus-send --print-reply --system --dest=org.bluez /org/bluez/8112/hci0/dev_00_1B_66_00_31_88 org.bluez.AudioSink.Connect
Error org.bluez.Error.Failed: Stream setup failed

D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.AudioSink, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: property 'State' changed to value 'connecting'
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.Audio, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: property 'State' changed to value 'connecting'
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.Device, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.AudioSink, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: property 'State' changed to value 'disconnected'
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.Audio, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: property 'State' changed to value 'disconnected'
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.AudioSink, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.AudioSink, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: property 'State' changed to value 'disconnected'
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.Device, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged



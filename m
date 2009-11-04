Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 4 Nov 2009 01:14:02 -0700
Message-ID: <f9d2a5e10911040014p238a14lb14a1a3d45942e44@mail.gmail.com>
Subject: Bluetooth audio via pulse doesn't function unless I chant the magic
	incantations
From: Russ Dill <russ.dill@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have ubuntu lucid (its just karmic+2.6.32-rc5) and I can only get
pulseaudio to detect my Sony DR-BT50 headset if I send some dbus
commands:

addr=00:1a:80:67:63:2c
hci=$(dbus-send --print-reply --system --dest=org.bluez /
org.bluez.Manager.DefaultAdapter | tail -n 1 | cut -f 2 -d '"')
dev=$(dbus-send --print-reply --system --dest=org.bluez $hci
org.bluez.Adapter.FindDevice string:$addr | tail -n 1 | cut -f 2 -d
'"')
dbus-send --print-reply --system --dest=org.bluez $dev org.bluez.Audio.Connect

Additionally, the device shows up under the gnome bluetooth-properties
applet under "Known devices" with the gold star and the keys. The
connected plug doesn't appear until I exec the above commands.
Clicking the plug without the above commands does nothing.

bluez 4.51-0ubuntu2
libbluetooth3 4.51-0ubuntu2
pulseaudio 1:0.9.19-0ubuntu4
pulseaudio-module-bluetooth 1:0.9.19-0ubuntu4

hci0:	Type: USB
	BD Address: 00:16:CF:F7:04:20 ACL MTU: 1017:8 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN
	RX bytes:142026 acl:16520 sco:0 events:10116 errors:0
	TX bytes:33958806 acl:39854 sco:0 commands:73 errors:0

(after above commands)

Connections:
	< ACL 00:1A:80:67:63:2C handle 11 state 1 lm MASTER

How can I get my machine to automatically pair with this headset?

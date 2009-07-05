Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sun, 5 Jul 2009 12:24:34 +0200
Subject: udev rule bluetooth.rules
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E06CCC1A4@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ref bluez-4.43 /etc/udev/bluetooth.rules:

# Run helper every time a Bluetooth device appears
# On remove actions, bluetoothd should go away by itself
ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd --udev"

Shouldn't this be of the format /etc/udev/rules.d/xx-bluetooth.rules so that it starts in the correct order - i.e. after dbus?

Is it possible to have a udev rule check that dbus is running before executing?

Regards, John



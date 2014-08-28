Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 28 Aug 2014 15:47:19 -0700
Message-ID: <CAO+8wm_qbHMA8RZmiGQUw-55TDWCXvm+f2zrLCCYXXv7CcL08g@mail.gmail.com>
Subject: connecting to a Motion 2in1 wiimote clone
From: Kameron Larsen <kroylar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

I'm having some difficulty in scanning and connecting to a device
using bluetoothctl. The device in question is a Motion 2in1 Wiimote.
Its basically a cheap chinese wiimote clone.

When I try to scan using bluetoothctl the device never shows up. When
I try to scan using "hcitool scan --iac=liac", the device shows up as:

2A:04:84:80:13:41 Nintendo RVL-CNT-01

The device cannot be connected to in bluetoothctl but I can connect
using "hcitool cc 2A:04:84:80:13:41". If I connect using hctitool and
then immediately use "pair 2A:04:84:80:13:41" in bluetoothctl. It
looks like the device pairs but the wiimote disconnects before
finishing the process. If I then run "trust 2A:04:84:80:13:41",
bluetoothctl will show that the device connects anytime I press any
button, and then shortly disconnects.

hcidump reveals that the something is wating for additional data but
it is not receiving what it expects.  Because this data was never
received the pairing process is left incomplete. However I can
reconnect by pressing any button on the remote. Whenever I do, it will
automatically disconnect after several seconds.

Scouring the code, I've come to realize that this remote is not
responding to sdp queries and therefore bluez does not know what
services it supports. My logs show this error:

2A:04:84:80:13:41: error updating services: Input/output error (5)

Without knowing the services (ie, HID) it fails in connect_event_cb
with the following error:

Refusing input device connect: No such file or directory (2)

I've very new to bluetooth and bluez. Does anyone know if there are
other methods of scanning for a device's services? I'm able to modify
the code and try patches.

-Kameron

Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Dec 2008 19:11:14 +0100
From: Christian Birchinger <joker@netswarm.net>
To: linux-bluetooth@vger.kernel.org
Subject: How to avoid PS3 SIXAXIS mouse functionality
Message-ID: <20081205181114.GA31660@netswarm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

After some nasty workarounds i managed to configure the
Playstation 3 gamepad in bluetooth mode in a way that a
single press on the "PS" button registers the device as
bluetooth HID gamepad and is ready to use.

I'm using bluez-utils-3.36 with the input plugin.

The problem is that the gamepad also re registred as
a mouse input device:

/proc/bus/input/devices:
N: Name="PLAYSTATION(R)3 Controller"
H: Handlers=mouse1 event7 js2 

dbus info:
method return sender=:1.51 -> dest=:1.70 reply_serial=2
array [
  string "/org/bluez/input/gamepad0"
]

While js and event is perfect, the mouse part causes
problems because it's not really a mouse device. You
cannot relativly control the mouse pointer. It only
gets temporarily moved when the left analog stick gets
moved then snaps back.

The big annoyance here is that i depend on evdev support
in X and that automaticaly adds everything as mouse when
detected. I did not manage to stop that behavious yet
(tested with AutoAddDevices==false in ServerFlags).

The old "hidd" daemon did only add js and event (no mouse).
This somehow tells me the gamepad doesn't tell the daemon
that it's also a mouse, but the new input plugin makes
something up (of course i could be wrong here).

In USB mode those gamepads also only get registred as
event and js devices (not mouse).

Can i somehow avoid that input.so in bluez-utils-3.36 adds
mouse support to gamepads?

Thanks for your help
Christian

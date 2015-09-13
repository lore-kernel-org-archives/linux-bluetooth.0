Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Elliot Saba <staticfloat@gmail.com>
Date: Sat, 12 Sep 2015 22:58:20 -0700
Message-ID: <CAGGi21YVrRB06R8ahxRLBZ=xZkNKGnCsetL1xUQx9DPLeAGGXA@mail.gmail.com>
Subject: Understanding connecting to BLE keyboard
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello there, I recently obtained a Microsoft Designer BLE
keyboard/mouse, and I thought I would attempt to connect it up to my
Linux box for fun.  Needless to say, I've met with some problems,
primarily with the authentication mechanisms I believe.

First off, I am using bluez 5.23 on SteamOS (A debian derivative) with
a Broadcom BCM4352 controller.

When attempting to connect to the bluetooth keyboard using my OSX
machine, it prompts me to enter a PIN, and after doing so, things are
fine and dandy.  When using gnome-bluetooth to attempt to connect, it
thinks about it for a little bit, and then reverts to its previous
status ("Not Set Up") rather than prompting me for a PIN or anything
like that.

When attempting to connect via the command line using bluetoothctl,
(First I start a KeyboardOnly agent, then scan for the device, then
"trust" it, then "pair" it) bluetoothctl initially reports the
connection has succeeded, but then immediately disconnects and prints
out the error "org.bluez.Error.AuthenticationCanceled".

When attempting to connect via the command line using gatttool in
interactive mode, I run into similar issues; I can type "connect" and
it initially reports success, but any command I then type to query the
device immediately reports "Command Failed: Disconnected".

Is there some way I can increase the amount of debugging information
available to me in order to try and track down exactly what's going
wrong here?  I admit that my knowledge of the proper way to connect
this device in linux is shaky at best, and I would "Read The Manual"
if I knew where to look for it.  Pointers on where to go to read up on
this whole process are definitely welcome.

Thank you for your time,
-E

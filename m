Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 3 Mar 2011 18:42:10 +0100
Message-ID: <AANLkTimCFW3bZkmm_B8VfViMC1A+rDjWRnE5OSB7eCCJ@mail.gmail.com>
Subject: New device driver: Nintendo Wii Remote
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

The Nintendo Wii Remote (short Wiimote) is the remote for the Nintedo
Wii console and communicates via bluetooth. There have been many
approaches to write linux drivers (incomplete list:
http://wiibrew.org/wiki/Wiimote/Library), however, they all are
written as separate libraries and not as device drivers. This has the
disadvantage, that the application must actively connect to the
wiimote (probably performing a bt-inquiry beforehand) instead of
listening for incoming connections.
The latter one can be achieved by listening on the HID l2cap channels
(psm 0x11 and 0x13), though, the wiimote does not follow the HID
standard. Since the bluez input-plugin listens on these ports, the
driver needs to be integrated into the bluez-daemon or kernel to work
properly.

I intend to adjust the sources to fit into the linux device driver
model, however, my question is whether to integrate the driver into
the bluez-daemon (probably via fakehid.c in the input-plugin) or
whether to write a kernel device driver? It would also be nice to get
some feedback whether my integration would work and whether there is a
chance that this patch gets merged upstream.

My current device driver runs as daemon in background and provides
access to connected wiimotes via uinput (evdev). It works only if the
"input-plugin" is disabled, though. Sources are available at:
https://github.com/dvdhrm/xwiimote
The main driver function "start_driver" takes two file descriptors
(both l2cap channels) as arguments and runs the driver as new process.
This allows easy integration into the fakehid.c bluez infrastructure.
My suggestion would be integrating this driver into the input-plugin
via fakehid.c and providing input events via uinput. In the next days
I will put together a patch fore the most basic wiimote functionality
so keypresses will be available via /dev/input/eventX, unless you say
this is a bad idea and it should be integrated via some different
interface. More complex components like the accelerometer, IR-sensor
and extensions may be added later.

http://wiibrew.org/wiki/Wiimote Shows reverse-engineered protocol details
http://wiibrew.org/wiki/Wiimote/Library Lists common protocol implementations
http://en.wikipedia.org/wiki/Wiimote Description of the device

Writing the driver as separate plugin is currently not possible,
because this plugin would depend on another plugin (input-plugin) and
there is currently no way to get symbols from other plugins. If the
fakehid.c interface is changed to provide access for other plugins to
add fake-device-descriptions to "struct fake_hid fake_hid_table", the
driver could be implemented as separate plugin.

David

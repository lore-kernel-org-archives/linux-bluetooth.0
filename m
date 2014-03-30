Return-Path: <cyrus@holtmann.org>
Message-ID: <53386DC2.7090805@gmail.com>
Date: Sun, 30 Mar 2014 20:17:22 +0100
From: Andrea <mariofutire@gmail.com>
MIME-Version: 1.0
To: Antonio Ospite <ao2@ao2.it>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Controlling LEDs and rumble on sixaxis
References: <53164362.4060102@gmail.com> <20140304231118.3500abb703a7c1a7679d01f1@ao2.it>
In-Reply-To: <20140304231118.3500abb703a7c1a7679d01f1@ao2.it>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/03/14 22:11, Antonio Ospite wrote:
> 
> With older kernels you can already set LEDs and rumble by sending the
> HID output report 01 via hidraw (actually there is a regression
> preventing that via BT in some versions). See the code in the BlueZ
> sixaxis plugin or in the newer linux kernel for the report format.

hi

after a while I managed to try to use the LEDs.
I'm using linux 3.13.6 with this hack (modified for PS3 usb id)

http://www.spinics.net/lists/linux-bluetooth/msg42955.html

as the good one is too complicated to back port to 3.13

http://article.gmane.org/gmane.linux.kernel.input/34896

(is it going to make it in 3.15?)

This is all via Bluetooth, using bluez 5.16

Results:
	1) using /dev/hidraw0 LEDs work like a charm
	2) I don't think my kernel supports /sys/class/leds as I can't find anything there
	3) rumble does not work. I've tried various combination of the bytes 2 to 5
	   (e.g. 0xfe, 0x00, 0xfe, 0xff) but nothing happens. do I need the full patch?
	   or the hack is enough?
	4) ff: tried fftest and nothing happens: this is the output

Force feedback test program.
HOLD FIRMLY YOUR WHEEL OR JOYSTICK TO PREVENT DAMAGES

Device /dev/input/event0 opened
Axes query:
Effects: Periodic Rumble
Number of simultaneous effects: 16
Upload effects[1]: Invalid argument
Upload effects[2]: Invalid argument
Upload effects[3]: Invalid argument
Enter effect number, -1 to exit
1
Now Playing: Constant Force
Enter effect number, -1 to exit


Any idea what else is missing to make rumble work?


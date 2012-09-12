Return-Path: <cyrus@holtmann.org>
Message-ID: <5050F5A9.5090401@butterbrot.org>
Date: Wed, 12 Sep 2012 22:50:49 +0200
From: Florian Echtler <floe@butterbrot.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Wii Balance Board vs. bluez
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

I'm having some issues getting the Wii Balance Board to work with a 
recent Linux Bluetooth stack (Ubuntu 12.04, Kernel 3.2, bluez-4.101).

After some minor patching [1], I've successfully paired the board with 
my machine. Automatic reconnect (when hitting the large front button) is 
also working.

However, the hid-wiimote driver, even the one I "backported" from kernel 
3.5, apparently doesn't really support the balance board so far. I do 
get 5 new device nodes as /dev/input/event*, but none of them actually 
report any data from the weight sensors.

Alternatively, I've tried the cwiid userspace library. This does work, 
however, I have to un-pair the board from bluetoothd first and put it 
into discoverable mode using the button on the bottom side, which is 
pretty inconvenient. If I keep the pairing active, the board will 
reconnect to bluetoothd itself and cwiid can't open a second L2CAP 
connection, AFAICT.

So, my two questions are:

- Is anybody currently working on integrating the balance board into 
hid-wiimote?

- Is there a way to retrieve the existing automatic connection from 
bluetoothd and pass it to a second userspace process (i.e., cwiid)?

Thanks!
Florian


[1] https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/1049266
-- 
SENT FROM MY DEC VT50 TERMINAL

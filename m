Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 17 Jun 2009 16:15:29 +0200
Subject: RE: Passkey-Agent for bluez 4.xx
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E06A02357@NL0105EXC01V01.eur.slb.com>
References: <20090513154809.GK6984@titan.makhutov-it.de>
	 <d89ddf300905132146t31b860ddtb43e3371f094f79b@mail.gmail.com>
	 <6AC5A55546F64545AE996F8200E3AC4E06A01AA4@NL0105EXC01V01.eur.slb.com>
 <d89ddf300906162327p20cce116r7f98be97ef4d4808@mail.gmail.com>
In-Reply-To: <d89ddf300906162327p20cce116r7f98be97ef4d4808@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


-----Original Message-----
From: Brad Midgley [mailto:bmidgley@gmail.com]
Sent: 17 June, 2009 10:28
To: John Frankish
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Passkey-Agent for bluez 4.xx

John,

> ..but what next - do I specify the bt address of the device I would like to pair with PIN 5555, or?

make your laptop discoverable and connect to it from the other device.
That was the purpose of this script, to set the pin for incoming
connections.

To make it discoverable, use the kde or gnome applet for bluetooth or
have a look at bluez-4.26/test/test-discovery for a headless machine.

--
Brad Midgley

----

Thanks, but I'm confused here - using ./simple-agent hci0 <remote address> wakes up the remote device and prompts the user to enter a PIN on the remote device.

What I don't understand is why, when using this:

# bluetoothd -dn
bluetoothd[6044]: Bluetooth daemon 4.41
bluetoothd[6044]: Enabling debug information
bluetoothd[6044]: parsing main.conf
bluetoothd[6044]: discovto=0
bluetoothd[6044]: pairto=0
bluetoothd[6044]: pageto=8192
bluetoothd[6044]: name=box
bluetoothd[6044]: class=0x000100
bluetoothd[6044]: discov_interval=0

..that the remote device cannot see "box" when it can see every other device in the vicinity

Regards, John

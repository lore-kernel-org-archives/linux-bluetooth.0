Return-Path: <jylhar@ac.tut.fi>
From: =?iso-8859-1?Q?Riikka_Jylh=E4?= <jylhar@ac.tut.fi>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] USB-drivers
Date: Mon, 4 Aug 2003 15:41:15 +0300
Message-ID: <000201c35a85$b18576d0$ae2ae682@ac.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <1059999322.1747.95.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

Thanks for your reply,

-----Original Message-----
> You need to apply a patch for using two ISOC URB's
> per TX and RX path.=20

Is this included in patch-2.4.21-mh2.gz. There is "Quirk for devices
with no ISOC endpoints" at the Changelog. There is ISOC mentioned but is
this the right patch or do I have to use the one I remember sawing
somewhere in the bluez-developers mail-archive?

> And the alternate configuration for the ISOC
> interface must be set correctly according to the voice setting.

How do I do that?

> At the moment this is only tested with CSR dongles, but I can play and
> record audio data with my headset in 8 and 16 bit quality. And it
seems
> that the BlueCore02 produces better audio than the BlueCore01b.

What audio formats are supported? Am I able to send .wav and .mp3
sounds?


> Using an UART based device is mostly no option, because the bandwith
is
> not enough for sending SCO packets over the HCI link. But it is
working
> with the 3Com and Xircom PCMCIA cards.

.. poor me only having TDK and Socket PCMCIA cards

> Regards
>
> Marcel

--
Riikka Jylh=E4

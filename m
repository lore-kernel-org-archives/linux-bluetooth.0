Return-Path: <ac2crp@blueyonder.co.uk>
Message-ID: <004101c34531$42d0a570$fd02a8c0@troll>
From: "Cozza" <ac2crp@blueyonder.co.uk>
To: "Marcel Holtmann" <marcel@rvs.uni-bielefeld.de>, "James Courtier-Dutton" <James@superbug.demon.co.uk>
Cc: "bluez Dev" <bluez-devel@lists.sourceforge.net>
References: 
	<3F02DBA9.1060305@superbug.demon.co.uk>	<004701c34153$0e650ba0$fd02a8c0@trol
	l>	<3F062FF5.7020703@superbug.demon.co.uk>	<3F08719F.70708@superbug.demon.co
	.uk> <1057524249.6946.83.camel@pegasus>
	<3F089E7B.4030606@superbug.demon.co.uk> <1057529783.6946.88.camel@pegasus>
Subject: Re: [Bluez-devel] Bluetooth headset problems.
Date: Tue, 8 Jul 2003 10:13:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,

Sorry for not replying earlier!

I managed to get a TDK Bluetooth PC Card working successfully for both
record and playback with the headset.

This has a Bluecore chip too - I used the same hstest code and the same
kernel code. For this reason I suspect that the problem is with the USB
driver. Everything was the same in the working and non working versions,
except the PC card worked and the USB didn't. There was a minor variation in
the Bluecore firmware on the cards, but the USB device works successfully
under windows, so I don't think this is the issue.

If you like, you could mail me your modified driver and I'll see if I have
any luck recording with it. I have a working headset and code, so that might
be one less unknown if that is any use.

The 'running out of urb' problem you found sounds feasible. I printed out
the USB spec but have never quite got around to reading it yet :-(

Incidentally, the TDK Bluetooth card doesn't work with bluez by default - I
ended up patching the Linux PCMCIA Serial driver (serial_cs.o) in order to
make it work with Bluez. Once it has recognised the card, just treat the
card as a BCSP based device on the appropriate serial port using hciattach.

I shall investigate how to send a patch for the serial_cs driver and then
support for this card can be added into the latest Kernel.

Regards,

Colin

> > Question: Has anyone got a bluetooth headset working with the hstest
> > bluez tool and playing sound out of the headset speakers ?
> > I just want to double check that this is just a usb problem still.

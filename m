Return-Path: <James@superbug.demon.co.uk>
Message-ID: <3F089E7B.4030606@superbug.demon.co.uk>
Date: Sun, 06 Jul 2003 23:11:07 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
CC: Cozza <ac2crp@blueyonder.co.uk>, bluez Dev <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth headset problems.
References: 
	<3F02DBA9.1060305@superbug.demon.co.uk>	<004701c34153$0e650ba0$fd02a8c0@trol
	l>	<3F062FF5.7020703@superbug.demon.co.uk>
		<3F08719F.70708@superbug.demon.co.uk> <1057524249.6946.83.camel@pegasus>
In-Reply-To: <1057524249.6946.83.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
> 
>>If anyone is interested, the fix for recording required 2 urbs for each 
>>isoc connection. The current cvs only uses 1 urb for isoc connections, 
>>so the usbcore fills one urb in real time, and then when it is full, 
>>sends it to hci_usb.c via a callback. Once hci_usb.c has finished with 
>>the urb it sends it back to the usbcore to get refilled. The problem is 
>>that while hci_usb.c is processing the urb, usbcore has no urb to put 
>>real time audio samples in, so it just drops them. If 2 urbs are used, 
>>if hci_usb.c is processing one, usbcore always has another to place 
>>samples in. As long as hci_usb.c does not hold on to it's urb for too 
>>long, all is ok. This fix was discovered by comparing the alsa 
>>snd-usb-audio driver with the hci_usb.c driver.
> 
> 
> this sounds reasonable to me. Currently I have replaced the ZERO_PACKET
> compile option with a module parameter, which allows you to change this
> easily at runtime. I will push this together with a new driver for a non
> H2 compatible USB device.
> 
> It is also a good idea to remove the SCO compile option, because it is
> not really needed and we can safely enable SCO for all H2 devies with
> ISOC endpoints. If you are working on a patch for full SCO support,
> please take care of this.
> 
> Regards
> 
> Marcel
> 
> 
I would prefer it if you would take care of the things you are 
suggesting. I am still quite far from providing a patch, because I 
cannot get playback to work(only recording works). I would prefer to 
stay focused on getting the playback working, rather than get diverted 
to changing compile options and the like.

Question: Has anyone got a bluetooth headset working with the hstest 
bluez tool and playing sound out of the headset speakers ?
I just want to double check that this is just a usb problem still.

Cheers
James

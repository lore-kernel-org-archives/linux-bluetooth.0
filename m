Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth headset problems.
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Cozza <ac2crp@blueyonder.co.uk>, bluez Dev <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3F08719F.70708@superbug.demon.co.uk>
References: <3F02DBA9.1060305@superbug.demon.co.uk>
	<004701c34153$0e650ba0$fd02a8c0@troll>
	<3F062FF5.7020703@superbug.demon.co.uk>
	<3F08719F.70708@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1057524249.6946.83.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 06 Jul 2003 22:44:02 +0200

Hi James,

> If anyone is interested, the fix for recording required 2 urbs for each 
> isoc connection. The current cvs only uses 1 urb for isoc connections, 
> so the usbcore fills one urb in real time, and then when it is full, 
> sends it to hci_usb.c via a callback. Once hci_usb.c has finished with 
> the urb it sends it back to the usbcore to get refilled. The problem is 
> that while hci_usb.c is processing the urb, usbcore has no urb to put 
> real time audio samples in, so it just drops them. If 2 urbs are used, 
> if hci_usb.c is processing one, usbcore always has another to place 
> samples in. As long as hci_usb.c does not hold on to it's urb for too 
> long, all is ok. This fix was discovered by comparing the alsa 
> snd-usb-audio driver with the hci_usb.c driver.

this sounds reasonable to me. Currently I have replaced the ZERO_PACKET
compile option with a module parameter, which allows you to change this
easily at runtime. I will push this together with a new driver for a non
H2 compatible USB device.

It is also a good idea to remove the SCO compile option, because it is
not really needed and we can safely enable SCO for all H2 devies with
ISOC endpoints. If you are working on a patch for full SCO support,
please take care of this.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

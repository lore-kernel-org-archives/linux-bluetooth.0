Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <004701c34153$0e650ba0$fd02a8c0@troll>
From: "Cozza" <ac2crp@blueyonder.co.uk>
To: "James Courtier-Dutton" <James@superbug.demon.co.uk>, "bluez Dev" <bluez-devel@lists.sourceforge.net>
References: <3F02DBA9.1060305@superbug.demon.co.uk>
Subject: Re: [Bluez-devel] Bluetooth headset problems.
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Thu, 3 Jul 2003 12:05:47 +0100

Hi,

I believe that there is a problem with the hci-usb driver. I performed some
brief investigations which I posted earlier to this mailing list.

Are you using a USB device? I've used the same code and Bluetooth headset
with a PC card Bluetooth adaptor and everything worked fine.

Both Bluetooth devices use the CSR chipset, but the UART one using the BCSP
protocol works whereas the USB one misses half the data packets, as you
suggest.

My earlier message was posted on 20th June, entitled "SCO problem with USB
devices" - I'd be interested to see if your problem looks the same. I think
it possibly is, from what you've posted.

I haven't yet got around to investigating the problem with the USB stack -
but I have the same problem, if it helps! If you are in a rush, then PC card
devices seem to work at the moment...

Regards,

Colin




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

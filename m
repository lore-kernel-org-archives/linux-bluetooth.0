Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael McConnell <soruk@eridani.co.uk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BlueWiFly
In-Reply-To: <1145285388.26498.19.camel@localhost>
Message-ID: <Pine.LNX.4.44.0604171603360.7931-100000@zeskia.int.eridani.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 17 Apr 2006 16:06:00 +0100 (BST)

On Mon, 17 Apr 2006, Marcel Holtmann wrote:

> Hi Mahtab,
> 
> > Does anybody use this solution from SunCore supporting both bluetooth
> > and Wi-Fi in a single bluetooth USB dongle (Bluetooth v1.2 + 802.11g)?
> > http://www.suncore.com.tw/bluewifly%20introduction.htm
> > 
> > It comes with support for Microsoft only. I think I certainly need a
> > driver for Wi-Fi to make this work in Linux (Microsoft also uses the
> > driver provided by the manufacturers). But for bluetooth, some reviews
> > say, Microsoft built-in stack can also drive it (regardless of the
> > driver porvided by BlueWiFLy). So I am presuming BlueZ can do the
> > same.
> > 
> > Should there be any issues with module-loading as the USB comes with
> > both Wi-Fi and Bluetooth support?
> 
> I don't think that you will have any problems with the Bluetooth part of
> this dongle. However the output of /proc/bus/usb/devices always helps to
> identify this dongle.
> 
> If the WiFi part is supported by Linux is the more important question,
> because this is always a little bit unclear.

If not natively supported, you may still find the WiFi part of the device
works with ndiswrapper (ndiswrapper.sf.net).  I use that route for both a
Sitecom PCMCIA adaptor and a Belkin USB one.

(I have both because my laptop only has USB1.1 therefore the localnet access 
performance is horrendous with the USB adaptor, but when out and about it's 
useful to be able to put it on an extension cable to get the best signal 
possible.)

-- Michael "Soruk" McConnell
   Eridani Star System

   MailStripper - http://mailstripper.eridani.co.uk/ - SMTP spam filter
   Mail Me Anywhere - http://www.MailMeAnywhere.com/ - Mobile email



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

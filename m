Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Bornet <Olivier.Bornet@smartdata.ch>
Cc: Charles Bueche <charles@bueche.ch>, Edd Dumbill <edd@usefulinc.com>,
   Peter Klausler <peter@klausler.com>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20031204163551.GG7164@smartdata.ch>
References: <20031204135740.GB7164@smartdata.ch>
	 <1070547014.24158.190.camel@pegasus>  <20031204163551.GG7164@smartdata.ch>
Content-Type: text/plain
Message-Id: <1070557432.24162.221.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 04 Dec 2003 18:03:52 +0100

Hi Olivier,

> > Do you know how to access the display of the diNovo mediapad?
> 
> Unfortunately, no. Has far as I known, this is not part of the HID
> profile. This is a "special" modified version by Logitech. I already
> have asked for this, without success at this time.

maybe someone with very good HID knowledge can decode the HID descriptor
and find an answer. Or we must use a protocol analyser to sniff the HIDP
packets.

> Also, for switching from USB to BT the "Bluetooth HUB", I will look with
> Logitech if we can have the specification for doing this switch. Hope I
> will have more success.

I have some response from CSR according the switch from HID to HCI mode.
This fits perfect for the EPoX dongle, but the Logitech dongle is quite
more complex. It presents a USB hub, two USB HID devices and four extra
HID devices with Windows XP.

However I actually don't how to implement the switch in Linux by now,
but I will take a look at it.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

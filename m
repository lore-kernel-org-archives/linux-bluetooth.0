Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200408121011.i7CABsAo028549@news01.csr.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] it is possible to change the N inquiry <256 
In-reply-to: "0|20c|=|ima|2U"'s message of "Thu, 12 Aug 2004 02:20:25 PDT."
             <20040812092026.8225.qmail@web51805.mail.yahoo.com>
From: Peter Stephenson <pws@csr.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 12 Aug 2004 11:11:53 +0100

> what I'm trying to do is that I want to speed up the discovery process.
> As stated by Somil before, the device inquires 256 times or for 2.56 s
> using one Train and then switches to a different Train. There are two
> Inquiry Train (called as Train A or Train B).

If you have a Bluetooth 1.2 scanning device, you will be able to use
interlaced inquiry scan on it (HCI_write_inquiry_scan_type interlaced).
This has the same effect.  In fact, it works better than switching
trains on the inquirer because inquiry is quite inefficient and losing
frames on a particular train can have a big impact on the likelihood of
finding a device.

Of course, this requires the other end to co-operate, so there's not a
lot you can do on the inquiring side.

pws


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

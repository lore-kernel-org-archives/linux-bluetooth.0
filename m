Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BNEP kernel oops
From: Marcel Holtmann <marcel@holtmann.org>
To: "Williams, Richard" <Richard.Williams@VITRONICS.com>
Cc: "Bluez-Devel (E-mail)" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A4028BB8@goofy.vitronics.com>
References: <A1F0D47583A2D711919F00600819B3A4028BB8@goofy.vitronics.com>
Content-Type: text/plain
Message-Id: <1092423277.4501.12.camel@pegasus>
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
Date: Fri, 13 Aug 2004 20:54:37 +0200

Hi Richard,

> I am developing an application for a single board computer running an X-scale processor with a BT dongle in the USB port. 
> 
> I have the following:
> Linux 2.4.26, with the patch-2.4.26-mh2.gz patch applied. 
> bluez-libs-2.8
> bluez-utils-2.8
> 
> I've cross-compiled all this for the X-scale and everything seems to work OK for rfcomm connections. 
> However as soon as I try to create a PAN connection to a remote device, I get a kernel panic. 
> The remote device is an iPAQ 5550 with built-in BT, running OPIE. The iPAQ does not crash.

verify if a previous kernel (2.4.26-mh1 or 2.4.26) worked without a
kernel oops.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Headset Problems
From: Marcel Holtmann <marcel@holtmann.org>
To: Brandon Wiley <blanu@synapthein.org>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20040821081408.GA4969@synapthein.org>
References: <20040821081408.GA4969@synapthein.org>
Content-Type: text/plain
Message-Id: <1093077490.3650.1.camel@notepaq>
Mime-Version: 1.0
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
Date: Sat, 21 Aug 2004 10:38:11 +0200

Hi Brandon,

> I'm trying to access my GN6110 headset using the hstest program on Linux
> 2.6.2 with bluez-utils 2.1.0.

install at least Linux kernel 2.6.8 and bluez-utils-2.10. Check with
"hciconfig hci0 revision" if your SCO traffic is routed over HCI.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

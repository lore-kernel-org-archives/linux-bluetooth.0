Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Little Hexdump-Patch for hcidump
From: Marcel Holtmann <marcel@holtmann.org>
To: Till Harbaum <harbaum@beecon.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200408261844.20194.harbaum@beecon.de>
References: <50BF37ECE4954A4BA18C08D0C2CF88CB2364EC@exmail1.se.axis.com>
	 <200408261844.20194.harbaum@beecon.de>
Content-Type: text/plain
Message-Id: <1093539822.2581.32.camel@pegasus>
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
Date: Thu, 26 Aug 2004 19:03:42 +0200

Hi Till,

> in every new release of hcidump i have been replacing the built-in 
> hexdump routine with my own one (giving the address and ascii as well).
> 
> Perhaps you want to use this replacement in hcidump/parser/parser.c
> 
> The hex output is very useful for me and e.g. just being able to see ascii 
> strings inside rfcomm payload is something i really often need.
> 
> Feel free to include it into the public version if you like to ...

please send me a patch (diff -u) and adjust a little bit your coding
style to match the other sources of hcidump.

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

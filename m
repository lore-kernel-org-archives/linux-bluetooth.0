Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sdp patch
From: Marcel Holtmann <marcel@holtmann.org>
To: Simon Vogl <vogl@soft.uni-linz.ac.at>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <403B08B4.1000602@soft.uni-linz.ac.at>
References: <403B08B4.1000602@soft.uni-linz.ac.at>
Content-Type: text/plain
Message-Id: <1077624690.2880.40.camel@pegasus>
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
Date: Tue, 24 Feb 2004 13:11:30 +0100

Hi Simon,

> in my quest to turn my computer into a handsfree device, I may propose
> the following patch to sdp:

your patch fails against the current CVS.

	Hunk #1 FAILED at 94.
	Hunk #2 FAILED at 125.
	Hunk #3 FAILED at 163.
	3 out of 3 hunks FAILED -- saving rejects to file include/sdp.h.rej
	patching file tools/listattr.c
	Hunk #1 FAILED at 209.
	1 out of 1 hunk FAILED -- saving rejects to file tools/listattr.c.rej
	patching file tools/sdptool.c
	Hunk #1 FAILED at 438.
	patch: **** malformed patch at line 122:  

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

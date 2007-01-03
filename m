Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <459BD2C1.8090208@xmission.com>
Date: Wed, 03 Jan 2007 08:58:57 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: jbarnett@pobox.com, BlueZ development <bluez-devel@lists.sourceforge.net>
References: <mailman.341782.1167746753.8777.bluez-devel@lists.sourceforge.net>
	<1167793130.3356.17.camel@localhost>
In-Reply-To: <1167793130.3356.17.camel@localhost>
Subject: Re: [Bluez-devel] Problems with Dell BCM2045 USB device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Jon

> new ALSA definitions. Adding the declaration:
> #include <sound/typedefs.h>
> fixed compiling the module.

adding this in breaks compilation under 2.6.17 so btsco would need an 
interested volunteer to come up with the right precompiler condition.

BCM2045 etc support has been rather hit-or-miss and I can't see what is 
missing.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

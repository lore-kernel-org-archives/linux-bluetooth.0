Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 30 Jun 2006 00:28:09 -0400
From: john hood <cgull@glup.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060630042809.GA30894@glup.org>
Mime-Version: 1.0
Subject: [Bluez-users] setting bdaddr on ISSC adapters
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Like so many before me, I ended up with an ISSC USB adapter with an
address of 11:11:11:11:11:11.  This is the adapter manufacturer being
cheap and omitting the USD $.10 EEPROM chip, and the firmware using
that address as a default in lieu of anything better.

This annoyed me, so I played around with the bdaddr program in
bluez-utils.  I found that the MAC address can be set with the same
commands used for "Ericsson" adapters.  One small patch later, I had
set a new MAC address on that adapter, at least until it's powered off.

Marcel Holtmann has coded up a more complete solution in the CVS
source (it'll be in the next released version), but here is a minimal
patch that will apply to later 2.x versions of bluez-utils.  If it
doesn't apply automatically, patching by hand should be fairly
obvious.

--- bdaddr.c.orig	2005-10-29 19:04:29.000000000 -0400
+++ bdaddr.c	2006-06-28 23:35:04.000000000 -0400
@@ -249,6 +249,8 @@
 	{ 10,		csr_write_bd_addr,	csr_reset_device	},
 	{ 13,		ti_write_bd_addr,	NULL,			},
 	{ 18,		zeevo_write_bd_addr,	NULL			},
+	/* ISSC dongles seem to work with ericson commands. */
+	{ 57,		ericsson_write_bd_addr,	NULL			},
 	{ 65535,	NULL,			NULL			},
 };
 

After running this patched bdaddr, you'll need to do 'hciconfig hci0
reset' to get the new address to show.

It's only been tested on two or three adapters so far.  Since the ISSC
adapters with these default MAC addresses (11:11:11:11:11:11 or
22:22:22:22:22:22) apparently have no writeable, nonvolatile storage,
there should be no risk of making unrecoverable changes to the
adapter.

I suggest taking the MAC address of the machine's first ethernet
adapter, setting bit 2 of the first byte to 1 to get a
"locally-administered" address that will be unique, and setting that
on your adapter.

Setting the MAC address to something unique and valid should clear up
some difficulties with PAN networking (I can't test this), and allow
using more than 1 of these dongles together (I can't test this
either).

If you have any problems with this, let Marcel and I know.

  --jh

-- 
[bicycle] spokes are like kennedy assassins,            John Hood,     cgull
they don't act alone.  you have to root out the                            @
entire conspiracy.  --mark weaver (of california)                   glup.org

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

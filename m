Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 17 Jul 2007 22:16:09 +0300
From: Mikko Rapeli <mikko.rapeli@iki.fi>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070717191609.GG1376@nalle>
Mime-Version: 1.0
Subject: [Bluez-devel] apply rfcomm oops fix?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,

This bugzilla entry http://bugzilla.kernel.org/show_bug.cgi?id=7509 has
been open for a while and my fix proposal this. I think it makes sence
for rfcomm socket ioctl, which releases the device, to gracefully
(tty_v)hangup the tty layer too. Could this be applied or is there some
problem with this one liner?

--- linux-2.6.22-rc5.orig/net/bluetooth/rfcomm/tty.c	2007-07-01 14:20:00.000000000 +0300
+++ linux-2.6.22-rc5/net/bluetooth/rfcomm/tty.c	2007-07-01 13:55:35.000000000 +0300
@@ -395,6 +397,10 @@
 	if (req.flags & (1 << RFCOMM_HANGUP_NOW))
 		rfcomm_dlc_close(dev->dlc, 0);
 
+	/* Be nice and shut down tty(s) synchronously before
+	 * freeing rfcomm_dev */
+	if (dev->tty) tty_vhangup(dev->tty);
+
 	rfcomm_dev_del(dev);
 	rfcomm_dev_put(dev);
 	return 0;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

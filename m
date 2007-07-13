Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 13 Jul 2007 10:50:27 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: bluez-devel@lists.sf.net
Message-ID: <20070713085027.GA12954@esaurito.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Subject: [Bluez-devel] [patch] correction for pand.1 manpage
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
attached there's a patch to correct pand.1 manpage to reflect current behaviour

filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

A child of five would understand this. Send someone to fetch a child of five.
-- Groucho Marx

--5mCyUwZo2JvN/JJP
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="001_pand_manpage.patch"

Index: pand/pand.1
===================================================================
--- pand/pand.1	(revision 481)
+++ pand/pand.1	(working copy)
@@ -73,5 +73,5 @@
 Disconnect automatically on exit
 
 .SH SCRIPTS
-pand will execute \fB/etc/bluetooth/pan/dev-up\fR \fIdevice\fR \fIdestination\fR when
-the interface becomes available.
+The devup/devdown script will be called with bluetooth device as first argument
+and bluetooth destination address as second argument.

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--5mCyUwZo2JvN/JJP--

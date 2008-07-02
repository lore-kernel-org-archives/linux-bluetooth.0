Return-Path: <cyrus@holtmann.org>
Message-ID: <486BD582.9050004@aircable.net>
Date: Wed, 02 Jul 2008 16:22:42 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------060407000003010304080608"
Subject: [Bluez-devel] [PATCH] CreateBonding while periodic scanning
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

This is a multi-part message in MIME format.
--------------060407000003010304080608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

I've sent this patch before, but for some reason I didn't got either a 
positive or even negative response.

Problem is like this, when we're doing a periodic scan we should be able 
to do bonding, but according to the code we can't, so then something is 
wrong, either we can't do periodic scanning, or we need to fix a bug.

This patch tries to fix this bug, and applies against 3.35.

Thanks,
Manuel Naranjo
Wireless Cables Inc

--------------060407000003010304080608
Content-Type: text/plain;
 name="adapter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adapter.patch"

--- hcid/adapter.c.orig	2008-06-28 19:59:50.000000000 -0300
+++ hcid/adapter.c	2008-06-28 20:05:47.000000000 -0300
@@ -2792,7 +2792,7 @@
 	str2ba(address, &bdaddr);
 
 	/* check if there is a pending discover: requested by D-Bus/non clients */
-	if (adapter->discov_active || (adapter->pdiscov_active && !adapter->pinq_idle))
+	if (adapter->discov_active)
 		return in_progress(msg, "Discover in progress");
 
 	pending_remote_name_cancel(adapter);

--------------060407000003010304080608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--------------060407000003010304080608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------060407000003010304080608--

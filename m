Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <464B36D4.80702@access-company.com>
Date: Wed, 16 May 2007 18:52:36 +0200
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------000008010807000805090607"
Subject: [Bluez-devel] Fix for disconnection in new serial service
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
--------------000008010807000805090607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I find a little bug preventing disconnection in new serial service.

Fred

-- 
-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic                   Access Company
Software engineer
Mail : mailto:frederic.danis@access-company.com
-----------------------------------------------


--------------000008010807000805090607
Content-Type: text/x-patch;
 name="disconnection_serial.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="disconnection_serial.patch"

Index: serial/manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/serial/manager.c,v
retrieving revision 1.36
diff -a -u -r1.36 manager.c
--- serial/manager.c	15 May 2007 17:07:22 -0000	1.36
+++ serial/manager.c	16 May 2007 16:46:38 -0000
@@ -254,6 +254,7 @@
 
 	node->io_id = g_io_add_watch(io, G_IO_ERR | G_IO_NVAL | G_IO_HUP,
 					(GIOFunc) rfcomm_disconnect_cb, node);
+	g_io_channel_set_close_on_unref(io, TRUE);
 
 	connected_nodes = g_slist_append(connected_nodes, node);
 

--------------000008010807000805090607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------000008010807000805090607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------000008010807000805090607--

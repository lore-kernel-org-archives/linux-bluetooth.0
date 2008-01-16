Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-SV0bIh16KOD9IA4G2I93"
Date: Wed, 16 Jan 2008 15:57:57 +0000
Message-Id: <1200499077.26259.42.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Use latest API in sendto
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


--=-SV0bIh16KOD9IA4G2I93
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Little one-liner to allow bluetooth-sendto to work with the latest
obex-data-server.

--=-SV0bIh16KOD9IA4G2I93
Content-Disposition: attachment; filename=bluez-gnome-sendto-fix.patch
Content-Type: text/x-patch; name=bluez-gnome-sendto-fix.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/sendto/main.c,v
retrieving revision 1.11
diff -u -p -r1.11 main.c
--- main.c	22 Dec 2007 00:09:17 -0000	1.11
+++ main.c	16 Jan 2008 15:56:30 -0000
@@ -353,7 +353,7 @@ int main(int argc, char *argv[])
 	dbus_g_proxy_begin_call(proxy, "CreateBluetoothSession",
 				create_notify, filename, NULL,
 				G_TYPE_STRING, address, G_TYPE_STRING, "opp",
-				G_TYPE_BOOLEAN, FALSE, G_TYPE_INVALID);
+				G_TYPE_INVALID);
 
 	gtk_main();
 

--=-SV0bIh16KOD9IA4G2I93
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-SV0bIh16KOD9IA4G2I93
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-SV0bIh16KOD9IA4G2I93--

Return-Path: <cyrus@holtmann.org>
Message-ID: <20080310143609.exuwdzs9gk4w48ss@wmlab.csie.ncu.edu.tw>
Date: Mon, 10 Mar 2008 14:36:09 +0800
From: Ming-I Hsieh <mihs@wmlab.csie.ncu.edu.tw>
To: bluez devel <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_6r5qu0bn4hwk"
Subject: [Bluez-devel] [PATCH] bluez-gnome access volatile while
	adapter-changed
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

This message is in MIME format.

--=_6r5qu0bn4hwk
Content-Type: text/plain;
	charset=big5;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi, all

This is a patch for this bug. This bug adddress at  
bluetooth-device-select.c. While the dongle could be removed/inserted,  
the gnome-applet may crash due to access a 0x0 priv.

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.


--=_6r5qu0bn4hwk
Content-Type: text/x-patch;
	charset=UTF-8;
	name="inquiry-crash.patch"
Content-Disposition: attachment;
	filename="inquiry-crash.patch"
Content-Transfer-Encoding: 7bit

--- gnome/common/bluetooth-device-selection.c.orig	2008-03-10 14:18:37.000000000 +0800
+++ gnome/common/bluetooth-device-selection.c	2008-03-10 14:16:00.000000000 +0800
@@ -322,6 +322,9 @@
 	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
 	char *adapter;
 
+	// skip if no priv
+	if (priv == NULL) return;
+
 	g_object_get (gobject, "default-adapter", &adapter, NULL);
 
 	if (adapter == NULL) {

--=_6r5qu0bn4hwk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=_6r5qu0bn4hwk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=_6r5qu0bn4hwk--

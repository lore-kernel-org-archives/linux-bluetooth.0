Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: pascal@pabr.org
Date: Wed, 13 Feb 2008 15:46:00 +0100
Message-ID: <fouvr8$2i8$1@ger.gmane.org>
References: <fourq4$ivu$1@ger.gmane.org> <1202910039.7664.407.camel@violet>
Mime-Version: 1.0
In-Reply-To: <1202910039.7664.407.camel@violet>
Subject: [Bluez-devel] [PATCH] bluetooth: hidraw support for Bluetooth HID
	devices
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

From: "Pascal A. Brisset" <pascal@pabr.org>

This patch exposes Bluetooth HID peripherals to userspace
through the hidraw API, in addition to the input subsystem.
This improves consistency between hidp and usbhid.

Signed-off-by: "Pascal A. Brisset" <pascal@pabr.org>

--- linux-2.6.24.2/net/bluetooth/hidp/core.c.orig	2008-02-13 15:18:41.000000000 +0100
+++ linux-2.6.24.2/net/bluetooth/hidp/core.c	2008-02-13 15:17:27.000000000 +0100
@@ -40,6 +40,7 @@

 #include <linux/input.h>
 #include <linux/hid.h>
+#include <linux/hidraw.h>

 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -589,6 +590,8 @@ static int hidp_session(void *arg)
 	if (session->hid) {
 		if (session->hid->claimed & HID_CLAIMED_INPUT)
 			hidinput_disconnect(session->hid);
+		if (session->hid->claimed & HID_CLAIMED_HIDRAW)
+			hidraw_disconnect(session->hid);
 		hid_free_device(session->hid);
 	}

@@ -741,6 +744,8 @@ static inline void hidp_setup_hid(struct

 	if (hidinput_connect(hid) == 0)
 		hid->claimed |= HID_CLAIMED_INPUT;
+	if (hidraw_connect(hid) == 0)
+		hid->claimed |= HID_CLAIMED_HIDRAW;
 }

 int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <cyrus@holtmann.org>
From: Lamarque Vieira Souza <lamarque@gmail.com>
To: marcel@holtmann.org
Subject: [PATCH] Fix for Acer  Bluetooth Optical Rechargeable Mouse
Date: Sat, 28 Mar 2009 19:45:49 -0300
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200903281945.49625.lamarque@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix a problem with Acer Bluetooth Optical Rechargeable Mouse where 
the cursor gets stuck at screen's upper-left corner. Even the touchpad of my 
notebook (Acer Ferrari 4005) cannot move the cursor when the bluetooth mouse 
is turned on. Using an input session instead of hid session solves this 
problem although the cursor moves a little sluggishly with the bluetooth 
mouse. It moves correctly using the touchpad. I do not know if there is a 
better implementation or a quirk for this problem, if it exists let me know.

Signed-off-by: Lamarque V. Souza <lamarque@gmail.com>
---

--- linux-2.6.29/net/bluetooth/hidp/core.c	2009-03-28 16:55:43.023380377 -0300
+++ linux-2.6.29-lvs/net/bluetooth/hidp/core.c	2009-03-28 19:22:14.896228520 
-0300
@@ -832,7 +832,10 @@ int hidp_add_connection(struct hidp_conn
 	session->flags   = req->flags & (1 << HIDP_BLUETOOTH_VENDOR_ID);
 	session->idle_to = req->idle_to;
 
-	if (req->rd_size > 0) {
+	/* Lamarque: Acer  Bluetooth Optical Rechargeable Mouse (0458:0058) does not 
work properly with hid session. */
+	if (req->rd_size > 0 && (
+	    req->vendor  != 0x0458 ||
+	    req->product != 0x0058)) {
 		err = hidp_setup_hid(session, req);
 		if (err && err != -ENODEV)
 			goto err_skb;

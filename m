Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 2/4] device: Fix missing PDUs during encryption procedure
Date: Mon, 28 Jan 2013 20:48:09 -0300
Message-Id: <1359416891-12740-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1359416891-12740-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1359416891-12740-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case the remote device sends an ATT PDU while encryption is going
on, we may lose it because the ATT socket (with security level medium),
would only be attached when encryption finishes.
---
 src/device.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/src/device.c b/src/device.c
index ceaa575..0d2d3ee 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3167,7 +3167,6 @@ int device_connect_le(struct btd_device *dev)
 {
 	struct btd_adapter *adapter = dev->adapter;
 	struct att_callbacks *attcb;
-	BtIOSecLevel sec_level;
 	GIOChannel *io;
 	GError *gerr = NULL;
 	char addr[18];
@@ -3185,21 +3184,18 @@ int device_connect_le(struct btd_device *dev)
 	attcb->success = att_success_cb;
 	attcb->user_data = dev;
 
-	if (dev->paired)
-		sec_level = BT_IO_SEC_MEDIUM;
-	else
-		sec_level = BT_IO_SEC_LOW;
-
 	/*
 	 * This connection will help us catch any PDUs that comes before
-	 * pairing finishes
+	 * pairing finishes. Its security level is low, because we don't
+	 * want to miss any PDU that may come before the encryption
+	 * procedure finishes
 	 */
 	io = bt_io_connect(att_connect_cb, attcb, NULL, &gerr,
 			BT_IO_OPT_SOURCE_BDADDR, adapter_get_address(adapter),
 			BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
 			BT_IO_OPT_DEST_TYPE, dev->bdaddr_type,
 			BT_IO_OPT_CID, ATT_CID,
-			BT_IO_OPT_SEC_LEVEL, sec_level,
+			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 			BT_IO_OPT_INVALID);
 
 	if (io == NULL) {
-- 
1.8.1.1


Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 5/5] android/gatt: Fix not handling service change ccc write execute
Date: Wed, 14 Jan 2015 10:19:41 +0100
Message-Id: <1421227181-1498-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1421227181-1498-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1421227181-1498-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds prepare and execute write handling on Service Change CCC
descriptor. It also protect CCC from remote sending invalid prepare
write offset and value with invalid length.

PTS can use this embeded service's ccc descriptor if no such descriptors
are added by the user. It tests descriptor writes for both, invalid
offset and invalid value length errors in TC_GAW_SR_BI_27_C and
TC_GAW_SR_BI_34_C respectively.
---
 android/gatt.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b749705..593e5c1 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -171,6 +171,8 @@ struct gatt_device {
 	struct queue *autoconnect_apps;
 
 	struct queue *pending_requests;
+	bool wait_svc_change_execute_write;
+	uint16_t svc_change_ccc;
 };
 
 struct app_connection {
@@ -6599,6 +6601,28 @@ static uint8_t write_execute_request(const uint8_t *cmd, uint16_t cmd_len,
 	uint8_t value;
 	struct pending_request *data;
 
+	/* handle embeded ccc */
+	if (dev->wait_svc_change_execute_write) {
+		dev->wait_svc_change_execute_write = false;
+
+		if (!dec_exec_write_req(cmd, cmd_len, &value))
+			return ATT_ECODE_INVALID_PDU;
+
+		if (value)
+			bt_store_gatt_ccc(&dev->bdaddr, dev->svc_change_ccc);
+
+		if (!pending_execute_write()) {
+			size_t mtu;
+			uint16_t len;
+			uint8_t *rsp = g_attrib_get_buffer(dev->attrib, &mtu);
+
+			len = enc_exec_write_resp(rsp);
+			g_attrib_send(dev->attrib, 0, rsp, len, NULL, NULL,
+									NULL);
+			return 0;
+		}
+	}
+
 	/*
 	 * Check if there was any write prep before.
 	 * TODO: Try to find better error code if possible
@@ -6992,6 +7016,7 @@ static void gatt_srvc_change_write_cb(struct gatt_db_attribute *attrib,
 					void *user_data)
 {
 	struct gatt_device *dev;
+	uint8_t *prep_val;
 
 	dev = find_device_by_addr(bdaddr);
 	if (!dev) {
@@ -7005,15 +7030,35 @@ static void gatt_srvc_change_write_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
-	/* 2 octets are expected as CCC value */
-	if (len != 2) {
-		gatt_db_attribute_write_result(attrib, id,
+	/* Out of bound sanity check */
+	if (offset + len > 2) {
+		if (offset > 1)
+			gatt_db_attribute_write_result(attrib, id,
+						ATT_ECODE_INVALID_OFFSET);
+		else
+			gatt_db_attribute_write_result(attrib, id,
 						ATT_ECODE_INVAL_ATTR_VALUE_LEN);
 		return;
 	}
 
-	/* Set services changed indication value */
-	bt_store_gatt_ccc(bdaddr, get_le16(value));
+	switch (opcode) {
+	case ATT_OP_PREP_WRITE_REQ:
+		dev->wait_svc_change_execute_write = true;
+		prep_val = (uint8_t *) &dev->svc_change_ccc;
+
+		memcpy(prep_val + offset, value, len);
+
+		break;
+	default:
+		/* 2 octets are expected as CCC value */
+		if (len != 2)
+			gatt_db_attribute_write_result(attrib, id,
+						ATT_ECODE_INVAL_ATTR_VALUE_LEN);
+
+		/* Set services changed indication value */
+		bt_store_gatt_ccc(bdaddr, get_le16(value));
+		break;
+	}
 
 	gatt_db_attribute_write_result(attrib, id, 0);
 }
-- 
1.9.1


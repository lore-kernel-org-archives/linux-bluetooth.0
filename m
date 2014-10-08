Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH v4 2/3] shared/gatt-client: Add CSRK part to support signed write
Date: Wed,  8 Oct 2014 16:54:38 +0800
Message-Id: <1412758479-13214-3-git-send-email-chao.jie.gu@intel.com>
In-Reply-To: <1412758479-13214-1-git-send-email-chao.jie.gu@intel.com>
References: <1412758479-13214-1-git-send-email-chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/gatt-client.c |   26 +++++++++++++++++++++-----
 src/shared/gatt-client.h |    3 +++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 03d722f..e476f92 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1765,19 +1765,26 @@ bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
 					uint16_t value_handle,
 					bool signed_write,
-					uint8_t *value, uint16_t length) {
+					uint8_t *value, uint16_t length)
+{
 	uint8_t pdu[2 + length];
 
 	if (!client)
 		return 0;
 
-	/* TODO: Support this once bt_att_send supports signed writes. */
-	if (signed_write)
-		return 0;
-
 	put_le16(value_handle, pdu);
 	memcpy(pdu + 2, value, length);
 
+	if (signed_write) {
+		if (bt_att_local_csrk_is_valid(client->att))
+			return bt_att_send(client->att,
+					BT_ATT_OP_SIGNED_WRITE_CMD,
+					pdu, sizeof(pdu), NULL, NULL, NULL);
+		else
+			return 0;
+
+	}
+
 	return bt_att_send(client->att, BT_ATT_OP_WRITE_CMD, pdu, sizeof(pdu),
 							NULL, NULL, NULL);
 }
@@ -2258,3 +2265,12 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 	client->need_notify_cleanup = true;
 	return true;
 }
+
+bool bt_gatt_client_set_local_csrk(struct bt_gatt_client *client,
+							uint8_t key[16])
+{
+	if (!client)
+		return false;
+
+	return bt_att_set_local_csrk(client->att, true, key);
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 6807f6b..ca0a7e8 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -162,3 +162,6 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
 				bt_gatt_client_destroy_func_t destroy);
 bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 							unsigned int id);
+
+bool bt_gatt_client_set_local_csrk(struct bt_gatt_client *client,
+							uint8_t key[16]);
-- 
1.7.10.4


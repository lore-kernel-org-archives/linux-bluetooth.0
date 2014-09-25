Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH v2 2/3] shared/gatt-client: Add CSRK part to support signed write
Date: Thu, 25 Sep 2014 16:28:57 +0800
Message-Id: <1411633738-19108-3-git-send-email-chao.jie.gu@intel.com>
In-Reply-To: <1411633738-19108-1-git-send-email-chao.jie.gu@intel.com>
References: <1411633738-19108-1-git-send-email-chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch Add set CSRK function for btgatt-client tool and
check CSRK valid before bt_att_send signed write command to
remote side.

---
 src/shared/gatt-client.c |   28 +++++++++++++++++++++++-----
 src/shared/gatt-client.h |    5 +++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 6dc8e95..d5ff994 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1753,19 +1753,26 @@ bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
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
+		if (bt_att_csrk_is_valid(client->att, LOCAL_CSRK))
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
@@ -2246,3 +2253,14 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 	client->need_notify_cleanup = true;
 	return true;
 }
+
+bool bt_gatt_client_set_csrk(struct bt_gatt_client *client,
+				enum bt_csrk_type type,
+				bool valid_csrk,
+				uint8_t key[16])
+{
+	if (!client)
+		return false;
+
+	return bt_att_set_csrk(client->att, type, valid_csrk, key);
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 6807f6b..f05ecd9 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -162,3 +162,8 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
 				bt_gatt_client_destroy_func_t destroy);
 bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 							unsigned int id);
+
+bool bt_gatt_client_set_csrk(struct bt_gatt_client *client,
+				enum bt_csrk_type type,
+				bool valid_csrk,
+				uint8_t key[16]);
-- 
1.7.10.4


Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/9] shared/gatt-client: Fix read long value
Date: Tue, 27 Jan 2015 14:03:26 +0200
Message-Id: <1422360212-19812-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1422360212-19812-1-git-send-email-luiz.dentz@gmail.com>
References: <1422360212-19812-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Bluetooth 4.2 vol 3, part F, ch 3.2.9 states: "The maximum length of an
attribute value shall be 512 octets." therefore the code should never
attempt to read past that length.
---
 src/shared/att-types.h   |  1 +
 src/shared/gatt-client.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 8b6d537..97c12ff 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -29,6 +29,7 @@
 
 #define BT_ATT_DEFAULT_LE_MTU	23
 #define BT_ATT_MAX_LE_MTU	517
+#define BT_ATT_MAX_VALUE_LEN	512
 
 /* ATT protocol opcodes */
 #define BT_ATT_OP_ERROR_RSP	      		0x01
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 1acd34f..04fb4cb 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1927,8 +1927,8 @@ struct read_long_op {
 	struct bt_gatt_client *client;
 	int ref_count;
 	uint16_t value_handle;
-	size_t orig_offset;
-	size_t offset;
+	uint16_t orig_offset;
+	uint16_t offset;
 	struct queue *blobs;
 	bt_gatt_client_read_callback_t callback;
 	void *user_data;
@@ -1950,6 +1950,10 @@ static struct blob *create_blob(const uint8_t *data, uint16_t len,
 	if (!blob)
 		return NULL;
 
+	/* Truncate if the data would exceed maximum length */
+	if (offset + len > BT_ATT_MAX_VALUE_LEN)
+		len = BT_ATT_MAX_VALUE_LEN - offset;
+
 	blob->data = malloc(len);
 	if (!blob->data) {
 		free(blob);
@@ -2050,8 +2054,8 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
 	}
 
 	queue_push_tail(op->blobs, blob);
-	op->offset += length;
-	if (op->offset > UINT16_MAX)
+	op->offset += blob->length;
+	if (op->offset >= BT_ATT_MAX_VALUE_LEN)
 		goto success;
 
 	if (length >= bt_att_get_mtu(op->client->att) - 1) {
-- 
2.1.0


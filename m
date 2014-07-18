Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 11/11] shared/gatt: Implement notification/indication helper.
Date: Fri, 18 Jul 2014 14:13:57 -0700
Message-Id: <1405718037-15401-12-git-send-email-armansito@chromium.org>
In-Reply-To: <1405718037-15401-1-git-send-email-armansito@chromium.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements bt_gatt_register, which sets up internal callbacks for
incoming notifications and indications, parses the PDU and provides it to the
upper layer. It also automatically sends out a confirmation when an indication
is received.
---
 src/shared/gatt-helpers.c | 64 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 5afe91e..f82bb59 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1375,11 +1375,71 @@ bool bt_gatt_write_long_value(struct bt_att *att, bool reliable,
 	return true;
 }
 
+struct notify_data {
+	struct bt_att *att;
+	bt_gatt_notify_callback_t callback;
+	void *user_data;
+	bt_gatt_destroy_func_t destroy;
+};
+
+static void notify_data_destroy(void *data)
+{
+	struct notify_data *notd = data;
+
+	if (notd->destroy)
+		notd->destroy(notd->user_data);
+
+	free(notd);
+}
+
+static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct notify_data *data = user_data;
+	bool indication;
+	uint16_t value_handle;
+	const uint8_t *value = NULL;
+
+	indication = (opcode == BT_ATT_OP_HANDLE_VAL_IND);
+	value_handle = get_le16(pdu);
+
+	if (length > 2)
+		value = pdu + 2;
+
+	if (data->callback)
+		data->callback(value_handle, value, length - 2, data->user_data);
+
+	if (indication)
+		bt_att_send(data->att, BT_ATT_OP_HANDLE_VAL_CONF, NULL, 0,
+							NULL, NULL, NULL);
+}
+
 unsigned int bt_gatt_register(struct bt_att *att, bool indications,
 					bt_gatt_notify_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	/* TODO */
-	return false;
+	struct notify_data *data;
+	uint8_t opcode;
+	unsigned int id;
+
+	if (!att)
+		return 0;
+
+	data = new0(struct notify_data, 1);
+	if (!data)
+		return 0;
+
+	data->att = att;
+	data->callback = callback;
+	data->user_data = user_data;
+	data->destroy = destroy;
+
+	opcode = indications ? BT_ATT_OP_HANDLE_VAL_IND : BT_ATT_OP_HANDLE_VAL_NOT;
+
+	id = bt_att_register(att, opcode, notify_cb, data, notify_data_destroy);
+	if (!id)
+		free(data);
+
+	return id;
 }
-- 
2.0.0.526.g5318336


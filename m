Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	claudio.takahasi@openbossa.org, anderson.lizardo@openbossa.org,
	armansito@chromium.org,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 05/10] android/gatt: Add helper to create characteristic op data
Date: Sun, 13 Apr 2014 00:00:26 +0200
Message-Id: <1397340031-29711-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds helper to create data needed for read/write
characteristic
---
 android/gatt.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index adba29e..9d45968 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1871,6 +1871,25 @@ struct char_op_data {
 	uint8_t primary;
 };
 
+static struct char_op_data *create_char_op_data(int32_t conn_id,
+						const struct element_id *s_id,
+						const struct element_id *ch_id,
+						bool primary)
+{
+	struct char_op_data *d;
+
+	d = new0(struct char_op_data, 1);
+	if (!d)
+		return NULL;
+
+	d->conn_id = conn_id;
+	d->srvc_id = s_id;
+	d->char_id = ch_id;
+	d->primary = primary;
+
+	return d;
+}
+
 static void send_client_read_char_notify(int32_t status, const uint8_t *pdu,
 						uint16_t len, int32_t conn_id,
 						const struct element_id *s_id,
@@ -1948,18 +1967,14 @@ static void handle_client_read_characteristic(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cb_data = new0(struct char_op_data, 1);
+	cb_data = create_char_op_data(cmd->conn_id, &srvc->id, &ch->id,
+						cmd->srvc_id.is_primary);
 	if (!cb_data) {
 		error("gatt: Cannot allocate cb data");
 		status = HAL_STATUS_NOMEM;
 		goto failed;
 	}
 
-	cb_data->conn_id = cmd->conn_id;
-	cb_data->primary = cmd->srvc_id.is_primary;
-	cb_data->srvc_id = &srvc->id;
-	cb_data->char_id = &ch->id;
-
 	if (!gatt_read_char(dev->attrib, ch->ch.value_handle,
 						read_char_cb, cb_data)) {
 		error("gatt: Cannot read characteristic with inst_id: %d",
@@ -2051,18 +2066,14 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cb_data = new0(struct char_op_data, 1);
+	cb_data = create_char_op_data(cmd->conn_id, &srvc->id, &ch->id,
+						cmd->srvc_id.is_primary);
 	if (!cb_data) {
 		error("gatt: Cannot allocate call data");
 		status = HAL_STATUS_NOMEM;
 		goto failed;
 	}
 
-	cb_data->conn_id = cmd->conn_id;
-	cb_data->primary = cmd->srvc_id.is_primary;
-	cb_data->srvc_id = &srvc->id;
-	cb_data->char_id = &ch->id;
-
 	if (!gatt_write_char(dev->attrib, ch->ch.value_handle, cmd->value,
 					cmd->len, write_char_cb, cb_data)) {
 		error("gatt: Cannot read characteristic with inst_id: %d",
-- 
1.8.4


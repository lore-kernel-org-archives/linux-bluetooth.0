Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	claudio.takahasi@openbossa.org, anderson.lizardo@openbossa.org,
	armansito@chromium.org,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 03/10] android/gatt: Add helper to create descr_data
Date: Sun, 13 Apr 2014 00:00:24 +0200
Message-Id: <1397340031-29711-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 243e02f..d04294c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2155,6 +2155,27 @@ static void read_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	free(cb_data);
 }
 
+static struct desc_data *create_desc_data(int32_t conn_id,
+						const struct element_id *s_id,
+						const struct element_id *ch_id,
+						const struct element_id *d_id,
+						uint8_t primary)
+{
+	struct desc_data *d;
+
+	d = new0(struct desc_data, 1);
+	if (!d)
+		return NULL;
+
+	d->conn_id = conn_id;
+	d->srvc_id = s_id;
+	d->char_id = ch_id;
+	d->descr_id = d_id;
+	d->primary = primary;
+
+	return d;
+}
+
 static void handle_client_read_descriptor(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_read_descriptor *cmd = buf;
@@ -2203,7 +2224,8 @@ static void handle_client_read_descriptor(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cb_data = new0(struct desc_data, 1);
+	cb_data = create_desc_data(conn_id, &srvc->id, &ch->id, &descr->id,
+								primary);
 	if (!cb_data) {
 		error("gatt: Read descr. could not allocate callback data");
 
@@ -2211,12 +2233,6 @@ static void handle_client_read_descriptor(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cb_data->conn_id = conn_id;
-	cb_data->srvc_id = &srvc->id;
-	cb_data->char_id = &ch->id;
-	cb_data->descr_id = &descr->id;
-	cb_data->primary = primary;
-
 	if (!gatt_read_char(dev->attrib, descr->handle, read_desc_cb,
 								cb_data)) {
 		free(cb_data);
@@ -2330,7 +2346,8 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cb_data = new0(struct desc_data, 1);
+	cb_data = create_desc_data(conn_id, &srvc->id, &ch->id, &descr->id,
+								primary);
 	if (!cb_data) {
 		error("gatt: Write descr. could not allocate callback data");
 
@@ -2338,12 +2355,6 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cb_data->conn_id = conn_id;
-	cb_data->srvc_id = &srvc->id;
-	cb_data->char_id = &ch->id;
-	cb_data->descr_id = &descr->id;
-	cb_data->primary = primary;
-
 	if (!gatt_write_char(dev->attrib, descr->handle, cmd->value, cmd->len,
 						write_descr_cb, cb_data)) {
 		free(cb_data);
-- 
1.8.4


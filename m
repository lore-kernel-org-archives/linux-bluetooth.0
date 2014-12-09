Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 24/25] android/scpp: Keep track on write operation
Date: Tue,  9 Dec 2014 16:11:46 +0100
Message-Id: <1418137907-16981-25-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/scpp.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/android/scpp.c b/android/scpp.c
index d83ac51..448c7a5 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -142,6 +142,28 @@ static void discover_desc(struct bt_scpp *scpp, GAttrib *attrib,
 	free(req);
 }
 
+static void write_char(struct bt_scpp *scan, GAttrib *attrib, uint16_t handle,
+					const uint8_t *value, size_t vlen,
+					GAttribResultFunc func,
+					gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(scan, user_data);
+	if (!req)
+		return;
+
+	id = gatt_write_char(attrib, handle, value, vlen, func, req);
+
+	if (set_and_store_gatt_req(scan, req, id))
+		return;
+
+	error("scpp: Could not read char");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
 static void scpp_free(struct bt_scpp *scan)
 {
 	bt_scpp_detach(scan);
@@ -239,22 +261,25 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu,
 				refresh_value_cb, scan, NULL);
 }
 
-static void write_ccc(GAttrib *attrib, uint16_t handle, void *user_data)
+static void write_ccc(struct bt_scpp *scan, GAttrib *attrib, uint16_t handle,
+								void *user_data)
 {
 	uint8_t value[2];
 
 	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
 
-	gatt_write_char(attrib, handle, value, sizeof(value), ccc_written_cb,
+	write_char(scan, attrib, handle, value, sizeof(value), ccc_written_cb,
 								user_data);
 }
 
 static void discover_descriptor_cb(uint8_t status, GSList *descs,
 								void *user_data)
 {
-	struct bt_scpp *scan = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_scpp *scan = req->user_data;
 	struct gatt_desc *desc;
 
+	destroy_gatt_req(req);
 
 	if (status != 0) {
 		error("Discover descriptors failed: %s", att_ecode2str(status));
@@ -264,7 +289,7 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 	/* There will be only one descriptor on list and it will be CCC */
 	desc = descs->data;
 
-	write_ccc(scan->attrib, desc->handle, scan);
+	write_ccc(scan, scan->attrib, desc->handle, scan);
 }
 
 static void refresh_discovered_cb(uint8_t status, GSList *chars,
-- 
1.8.4


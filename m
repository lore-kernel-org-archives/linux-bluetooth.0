Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Yunhan Wang <yunhanw@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yunhan Wang <yunhanw@google.com>
Subject: [PATCH BlueZ 2/3] gatt: Do UpdateMTU when write comes in
Date: Thu, 14 Sep 2017 16:47:47 -0700
Message-Id: <20170914234748.79584-2-yunhanw@google.com>
In-Reply-To: <20170914234748.79584-1-yunhanw@google.com>
References: <20170914234748.79584-1-yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add mtu in external_chrc strcutre, and call UpdateMTU when MTU exchange complete and write comes in
---
 src/gatt-database.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 61eed71d6..2658ac207 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -122,6 +122,7 @@ struct external_chrc {
 	struct queue *pending_reads;
 	struct queue *pending_writes;
 	unsigned int ntfy_cnt;
+	uint16_t mtu;
 };
 
 struct external_desc {
@@ -1678,6 +1679,12 @@ static struct pending_op *send_read(struct btd_device *device,
 	return NULL;
 }
 
+static void update_mtu_setup_cb(DBusMessageIter *iter, void *user_data)
+{
+	struct external_chrc *chrc = user_data;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &chrc->mtu);
+}
+
 static void write_setup_cb(DBusMessageIter *iter, void *user_data)
 {
 	struct pending_op *op = user_data;
@@ -2090,12 +2097,17 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 	struct external_chrc *chrc = user_data;
 	struct btd_device *device;
 	struct queue *queue;
+	uint16_t mtu;
 
 	if (chrc->attrib != attrib) {
 		error("Write callback called with incorrect attribute");
 		goto fail;
 	}
 
+	mtu = bt_att_get_mtu(att);
+	chrc->mtu = mtu;
+	g_dbus_proxy_method_call(chrc->proxy, "UpdateMTU", update_mtu_setup_cb, NULL, user_data, NULL);
+
 	device = att_get_device(att);
 	if (!device) {
 		error("Unable to find device object");
-- 
2.14.1.690.gbb1197296e-goog


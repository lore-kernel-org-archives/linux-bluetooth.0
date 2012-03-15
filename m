Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH v2 1/6] att: add remote btd_device to ATT read/write callbacks
Date: Thu, 15 Mar 2012 12:49:14 +0200
Message-Id: <1331808559-12880-2-git-send-email-arik@wizery.com>
In-Reply-To: <1331808559-12880-1-git-send-email-arik@wizery.com>
References: <1331808559-12880-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows us to identify the remote device that made the ATT
read/write.
---
 attrib/att.h           |    6 ++++--
 plugins/gatt-example.c |    3 ++-
 src/attrib-server.c    |   19 ++++++++++++++-----
 time/server.c          |    6 ++++--
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index dc266f1..70f3d91 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -130,8 +130,10 @@ struct attribute {
 	bt_uuid_t uuid;
 	int read_reqs;
 	int write_reqs;
-	uint8_t (*read_cb)(struct attribute *a, gpointer user_data);
-	uint8_t (*write_cb)(struct attribute *a, gpointer user_data);
+	uint8_t (*read_cb)(struct attribute *a, gpointer user_data,
+				gpointer device);
+	uint8_t (*write_cb)(struct attribute *a, gpointer user_data,
+				gpointer device);
 	gpointer cb_user_data;
 	int len;
 	uint8_t *data;
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index f026761..ad5b844 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -92,7 +92,8 @@ static gint adapter_cmp(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
-static uint8_t battery_state_read(struct attribute *a, gpointer user_data)
+static uint8_t battery_state_read(struct attribute *a, gpointer user_data,
+				  struct btd_device *device)
 {
 	struct btd_adapter *adapter = user_data;
 	uint8_t value;
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 6268fe4..0bf88f9 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -76,6 +76,7 @@ struct gatt_channel {
 	gboolean encrypted;
 	struct gatt_server *server;
 	guint cleanup_id;
+	struct btd_device *device;
 };
 
 struct group_elem {
@@ -112,6 +113,9 @@ static void channel_free(struct gatt_channel *channel)
 	if (channel->cleanup_id)
 		g_source_remove(channel->cleanup_id);
 
+	if (channel->device)
+		btd_device_unref(channel->device);
+
 	g_attrib_unref(channel->attrib);
 	g_free(channel);
 }
@@ -452,7 +456,8 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 								a->read_reqs);
 
 		if (status == 0x00 && a->read_cb)
-			status = a->read_cb(a, a->cb_user_data);
+			status = a->read_cb(a, a->cb_user_data,
+					    channel->device);
 
 		if (status) {
 			g_slist_free_full(groups, g_free);
@@ -541,7 +546,8 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 								a->read_reqs);
 
 		if (status == 0x00 && a->read_cb)
-			status = a->read_cb(a, a->cb_user_data);
+			status = a->read_cb(a, a->cb_user_data,
+					    channel->device);
 
 		if (status) {
 			g_slist_free(types);
@@ -753,7 +759,7 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 	status = att_check_reqs(channel, ATT_OP_READ_REQ, a->read_reqs);
 
 	if (status == 0x00 && a->read_cb)
-		status = a->read_cb(a, a->cb_user_data);
+		status = a->read_cb(a, a->cb_user_data, channel->device);
 
 	if (status)
 		return enc_error_resp(ATT_OP_READ_REQ, handle, status, pdu,
@@ -796,7 +802,7 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 	status = att_check_reqs(channel, ATT_OP_READ_BLOB_REQ, a->read_reqs);
 
 	if (status == 0x00 && a->read_cb)
-		status = a->read_cb(a, a->cb_user_data);
+		status = a->read_cb(a, a->cb_user_data, channel->device);
 
 	if (status)
 		return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle, status,
@@ -833,7 +839,8 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 							value, vlen, NULL);
 
 		if (a->write_cb) {
-			status = a->write_cb(a, a->cb_user_data);
+			status = a->write_cb(a, a->cb_user_data,
+					     channel->device);
 			if (status)
 				return enc_error_resp(ATT_OP_WRITE_REQ, handle,
 							status, pdu, len);
@@ -1063,6 +1070,8 @@ guint attrib_channel_attach(GAttrib *attrib)
 	channel->cleanup_id = g_io_add_watch(io, G_IO_HUP, channel_watch_cb,
 								channel);
 
+	channel->device = btd_device_ref(device);
+
 	server->clients = g_slist_append(server->clients, channel);
 
 	return channel->id;
diff --git a/time/server.c b/time/server.c
index 42b12e2..4a2e168 100644
--- a/time/server.c
+++ b/time/server.c
@@ -78,7 +78,8 @@ static int encode_current_time(uint8_t value[10])
 	return 0;
 }
 
-static uint8_t current_time_read(struct attribute *a, gpointer user_data)
+static uint8_t current_time_read(struct attribute *a, gpointer user_data,
+				 struct btd_device *device)
 {
 	uint8_t value[10];
 
@@ -91,7 +92,8 @@ static uint8_t current_time_read(struct attribute *a, gpointer user_data)
 	return 0;
 }
 
-static uint8_t local_time_info_read(struct attribute *a, gpointer user_data)
+static uint8_t local_time_info_read(struct attribute *a, gpointer user_data,
+				    struct btd_device *device)
 {
 	uint8_t value[2];
 
-- 
1.7.5.4


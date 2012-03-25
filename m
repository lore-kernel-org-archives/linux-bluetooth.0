Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH v5 1/6] att: add remote btd_device to ATT read/write callbacks
Date: Sun, 25 Mar 2012 23:38:14 +0200
Message-Id: <1332711499-5928-2-git-send-email-arik@wizery.com>
In-Reply-To: <1332711499-5928-1-git-send-email-arik@wizery.com>
References: <1332711499-5928-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows us to identify the remote device that made the ATT
read/write.
---
 attrib/att-bluez.h     |   44 ++++++++++++++++++++++++++++++++++++++++++++
 attrib/att.h           |   20 --------------------
 attrib/gatt-service.c  |    1 +
 plugins/gatt-example.c |    4 +++-
 proximity/reporter.c   |    1 +
 src/attrib-server.c    |   20 +++++++++++++++-----
 time/server.c          |    7 +++++--
 7 files changed, 69 insertions(+), 28 deletions(-)
 create mode 100644 attrib/att-bluez.h

diff --git a/attrib/att-bluez.h b/attrib/att-bluez.h
new file mode 100644
index 0000000..d2b8e27
--- /dev/null
+++ b/attrib/att-bluez.h
@@ -0,0 +1,44 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012 Texas Instruments Corporation
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+/* Requirements for read/write operations */
+enum {
+	ATT_NONE,		/* No restrictions */
+	ATT_AUTHENTICATION,	/* Authentication required */
+	ATT_AUTHORIZATION,	/* Authorization required */
+	ATT_NOT_PERMITTED,	/* Operation not permitted */
+};
+
+struct attribute {
+	uint16_t handle;
+	bt_uuid_t uuid;
+	int read_reqs;
+	int write_reqs;
+	uint8_t (*read_cb)(struct attribute *a,  struct btd_device *device,
+			   gpointer user_data);
+	uint8_t (*write_cb)(struct attribute *a, struct btd_device *device,
+			    gpointer user_data);
+	gpointer cb_user_data;
+	int len;
+	uint8_t *data;
+};
+
diff --git a/attrib/att.h b/attrib/att.h
index dc266f1..cf996d8 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -117,26 +117,6 @@
 #define ATT_CID					4
 #define ATT_PSM					31
 
-/* Requirements for read/write operations */
-enum {
-	ATT_NONE,		/* No restrictions */
-	ATT_AUTHENTICATION,	/* Authentication required */
-	ATT_AUTHORIZATION,	/* Authorization required */
-	ATT_NOT_PERMITTED,	/* Operation not permitted */
-};
-
-struct attribute {
-	uint16_t handle;
-	bt_uuid_t uuid;
-	int read_reqs;
-	int write_reqs;
-	uint8_t (*read_cb)(struct attribute *a, gpointer user_data);
-	uint8_t (*write_cb)(struct attribute *a, gpointer user_data);
-	gpointer cb_user_data;
-	int len;
-	uint8_t *data;
-};
-
 struct att_data_list {
 	uint16_t num;
 	uint16_t len;
diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 4592a90..4d128a9 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -32,6 +32,7 @@
 #include <adapter.h>
 
 #include "att.h"
+#include "att-bluez.h"
 #include "gattrib.h"
 #include "attrib-server.h"
 #include "gatt-service.h"
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index f026761..5c3d902 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -37,6 +37,7 @@
 #include "gattrib.h"
 #include "gatt-service.h"
 #include "att.h"
+#include "att-bluez.h"
 #include "attrib-server.h"
 
 /* FIXME: Not defined by SIG? UUID128? */
@@ -92,7 +93,8 @@ static gint adapter_cmp(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
-static uint8_t battery_state_read(struct attribute *a, gpointer user_data)
+static uint8_t battery_state_read(struct attribute *a,
+				  struct btd_device *device, gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
 	uint8_t value;
diff --git a/proximity/reporter.c b/proximity/reporter.c
index 9777574..05207e3 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -34,6 +34,7 @@
 
 #include "hcid.h"
 #include "att.h"
+#include "att-bluez.h"
 #include "gattrib.h"
 #include "attrib-server.h"
 #include "reporter.h"
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5775861..eed2c28 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -47,6 +47,7 @@
 #include "device.h"
 #include "manager.h"
 #include "att.h"
+#include "att-bluez.h"
 #include "gattrib.h"
 #include "storage.h"
 
@@ -76,6 +77,7 @@ struct gatt_channel {
 	gboolean encrypted;
 	struct gatt_server *server;
 	guint cleanup_id;
+	struct btd_device *device;
 };
 
 struct group_elem {
@@ -112,6 +114,9 @@ static void channel_free(struct gatt_channel *channel)
 	if (channel->cleanup_id)
 		g_source_remove(channel->cleanup_id);
 
+	if (channel->device)
+		btd_device_unref(channel->device);
+
 	g_attrib_unref(channel->attrib);
 	g_free(channel);
 }
@@ -452,7 +457,8 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 								a->read_reqs);
 
 		if (status == 0x00 && a->read_cb)
-			status = a->read_cb(a, a->cb_user_data);
+			status = a->read_cb(a, channel->device,
+					    a->cb_user_data);
 
 		if (status) {
 			g_slist_free_full(groups, g_free);
@@ -541,7 +547,8 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 								a->read_reqs);
 
 		if (status == 0x00 && a->read_cb)
-			status = a->read_cb(a, a->cb_user_data);
+			status = a->read_cb(a, channel->device,
+					    a->cb_user_data);
 
 		if (status) {
 			g_slist_free(types);
@@ -753,7 +760,7 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 	status = att_check_reqs(channel, ATT_OP_READ_REQ, a->read_reqs);
 
 	if (status == 0x00 && a->read_cb)
-		status = a->read_cb(a, a->cb_user_data);
+		status = a->read_cb(a, channel->device, a->cb_user_data);
 
 	if (status)
 		return enc_error_resp(ATT_OP_READ_REQ, handle, status, pdu,
@@ -796,7 +803,7 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 	status = att_check_reqs(channel, ATT_OP_READ_BLOB_REQ, a->read_reqs);
 
 	if (status == 0x00 && a->read_cb)
-		status = a->read_cb(a, a->cb_user_data);
+		status = a->read_cb(a, channel->device, a->cb_user_data);
 
 	if (status)
 		return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle, status,
@@ -833,7 +840,8 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 							value, vlen, NULL);
 
 		if (a->write_cb) {
-			status = a->write_cb(a, a->cb_user_data);
+			status = a->write_cb(a, channel->device,
+					     a->cb_user_data);
 			if (status)
 				return enc_error_resp(ATT_OP_WRITE_REQ, handle,
 							status, pdu, len);
@@ -1067,6 +1075,8 @@ guint attrib_channel_attach(GAttrib *attrib)
 	channel->cleanup_id = g_io_add_watch(io, G_IO_HUP, channel_watch_cb,
 								channel);
 
+	channel->device = btd_device_ref(device);
+
 	server->clients = g_slist_append(server->clients, channel);
 
 	return channel->id;
diff --git a/time/server.c b/time/server.c
index 42b12e2..0de8764 100644
--- a/time/server.c
+++ b/time/server.c
@@ -33,6 +33,7 @@
 #include <adapter.h>
 
 #include "att.h"
+#include "att-bluez.h"
 #include "gattrib.h"
 #include "attrib-server.h"
 #include "gatt-service.h"
@@ -78,7 +79,8 @@ static int encode_current_time(uint8_t value[10])
 	return 0;
 }
 
-static uint8_t current_time_read(struct attribute *a, gpointer user_data)
+static uint8_t current_time_read(struct attribute *a,
+				 struct btd_device *device, gpointer user_data)
 {
 	uint8_t value[10];
 
@@ -91,7 +93,8 @@ static uint8_t current_time_read(struct attribute *a, gpointer user_data)
 	return 0;
 }
 
-static uint8_t local_time_info_read(struct attribute *a, gpointer user_data)
+static uint8_t local_time_info_read(struct attribute *a,
+				struct btd_device *device, gpointer user_data)
 {
 	uint8_t value[2];
 
-- 
1.7.5.4


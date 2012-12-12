Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 14/14] input: Use new storage architecture
Date: Wed, 12 Dec 2012 16:48:03 +0100
Message-Id: <1355327283-1558-14-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When an input device is probed, it tries to retrieve its SDP record
from "input" file in storage directory.
If this fails, during bonding phase, records is vailable from device
object.

During connection, retrieve SDP record from "input" file.
---
 profiles/input/device.c  |   17 ++++++++---
 profiles/input/manager.c |   75 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 2d8077a..5eba0be 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -316,7 +316,8 @@ static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 static int hidp_add_connection(struct input_device *idev)
 {
 	struct hidp_connadd_req *req;
-	uint8_t dst_type;
+	char *filename, *data;
+	GKeyFile *key_file = NULL;
 	sdp_record_t *rec;
 	char src_addr[18], dst_addr[18];
 	GError *gerr = NULL;
@@ -331,15 +332,23 @@ static int hidp_add_connection(struct input_device *idev)
 	ba2str(&idev->src, src_addr);
 	ba2str(&idev->dst, dst_addr);
 
-	dst_type = device_get_addr_type(idev->device);
+	filename = device_get_storage_path(idev->device, "input");
 
-	rec = fetch_record(src_addr, dst_addr, dst_type, idev->handle);
-	if (!rec) {
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	data = g_key_file_get_string(key_file, "SDP", "Record", NULL);
+	g_key_file_free(key_file);
+	g_free(filename);
+
+	if (!data) {
 		error("Rejected connection from unknown device %s", dst_addr);
 		err = -EPERM;
 		goto cleanup;
 	}
 
+	rec = record_from_string(data);
+	g_free(data);
+
 	extract_hid_record(rec, req);
 	sdp_record_free(rec);
 
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 622e24b..db42c34 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -27,6 +27,8 @@
 
 #include <errno.h>
 #include <stdbool.h>
+#include <stdlib.h>
+#include <fcntl.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
@@ -42,6 +44,7 @@
 #include "device.h"
 #include "server.h"
 #include "manager.h"
+#include "storage.h"
 
 static int idle_timeout = 0;
 
@@ -54,19 +57,83 @@ static void input_remove(struct btd_device *device, const char *uuid)
 	input_device_unregister(path, uuid);
 }
 
+static void store_hid_record(char *filename, const sdp_record_t *rec)
+{
+	sdp_buf_t buf;
+	int size, i;
+	char *str, *data;
+	GKeyFile *key_file = NULL;
+	gsize length = 0;
+
+	if (sdp_gen_record_pdu(rec, &buf) < 0)
+		return;
+
+	size = buf.data_size;
+	str = g_malloc0(size*2+1);
+
+	for (i = 0; i < size; i++)
+		sprintf(str + (i * 2), "%02X", buf.data[i]);
+
+	free(buf.data);
+
+	key_file = g_key_file_new();
+	g_key_file_set_string(key_file, "SDP", "Record", str);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	if (length > 0) {
+		create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+		g_file_set_contents(filename, data, length, NULL);
+	}
+
+	g_free(data);
+	g_free(str);
+
+	g_key_file_free(key_file);
+}
+
 static int hid_device_probe(struct btd_profile *p, struct btd_device *device,
 								GSList *uuids)
 {
 	const gchar *path = device_get_path(device);
 	const sdp_record_t *rec = btd_device_get_record(device, uuids->data);
+	sdp_record_t *stored_rec;
+	char *filename, *data;
+	GKeyFile *key_file = NULL;
+	int err;
 
 	DBG("path %s", path);
 
-	if (!rec)
-		return -1;
+	filename = device_get_storage_path(device, "input");
+
+	if (rec) {
+		store_hid_record(filename, rec);
+
+		err = input_device_register(device, path, HID_UUID, rec,
+						idle_timeout * 60);
+		goto end;
+	}
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	data = g_key_file_get_string(key_file, "SDP", "Record", NULL);
+	g_key_file_free(key_file);
+
+	if (!data) {
+		err = -1;
+		goto end;
+	}
+
+	stored_rec = record_from_string(data);
+	g_free(data);
+
+	err = input_device_register(device, path, HID_UUID, stored_rec,
+						idle_timeout * 60);
+	sdp_record_free(stored_rec);
+
+end:
+	g_free(filename);
 
-	return input_device_register(device, path, HID_UUID, rec,
-							idle_timeout * 60);
+	return err;
 }
 
 static void hid_device_remove(struct btd_profile *p, struct btd_device *device)
-- 
1.7.9.5


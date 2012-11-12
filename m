Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] device: Defer write to storage
Date: Mon, 12 Nov 2012 16:43:44 +0100
Message-Id: <1352735024-2733-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Defere write to storage using g_idle_add() to avoid multiple
open/write/close operations when device properties are changed
in sequence.
---
 src/device.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 9749bfd..354371b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -196,6 +196,7 @@ struct btd_device {
 
 	GIOChannel      *att_io;
 	guint		cleanup_id;
+	guint		store_id;
 };
 
 static uint16_t uuid_list[] = {
@@ -205,8 +206,9 @@ static uint16_t uuid_list[] = {
 	0
 };
 
-static void store_device_info(struct btd_device *device)
+static gboolean store_device_info_cb(gpointer user_data)
 {
+	struct btd_device *device = user_data;
 	GKeyFile *key_file;
 	char filename[PATH_MAX + 1];
 	char adapter_addr[18];
@@ -214,8 +216,7 @@ static void store_device_info(struct btd_device *device)
 	char *str;
 	gsize length = 0;
 
-	if (device->temporary)
-		return;
+	device->store_id = 0;
 
 	key_file = g_key_file_new();
 
@@ -233,6 +234,16 @@ static void store_device_info(struct btd_device *device)
 	g_free(str);
 
 	g_key_file_free(key_file);
+
+	return FALSE;
+}
+
+static void store_device_info(struct btd_device *device)
+{
+	if (device->temporary || device->store_id)
+		return;
+
+	device->store_id = g_idle_add(store_device_info_cb, device);
 }
 
 static void browse_request_free(struct browse_req *req)
@@ -1839,6 +1850,13 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	if (device->connected)
 		do_disconnect(device);
 
+	if (device->store_id) {
+		if (!remove_stored)
+			store_device_info_cb(device);
+
+		g_source_remove(device->store_id);
+	}
+
 	if (remove_stored)
 		device_remove_stored(device);
 
-- 
1.7.9.5


Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 6/7] device: Add common ATT connection cleanup function
Date: Thu,  9 Feb 2012 12:56:08 -0300
Message-Id: <1328802969-20244-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |   81 +++++++++++++++++++++------------------------------------
 1 files changed, 30 insertions(+), 51 deletions(-)

diff --git a/src/device.c b/src/device.c
index f588e3c..558c4c0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -198,6 +198,30 @@ static void browse_request_free(struct browse_req *req)
 	g_free(req);
 }
 
+static void att_cleanup(struct btd_device *device)
+{
+	if (device->attachid) {
+		attrib_channel_detach(device->attrib, device->attachid);
+		device->attachid = 0;
+	}
+
+	if (device->cleanup_id) {
+		g_source_remove(device->cleanup_id);
+		device->cleanup_id = 0;
+	}
+
+	if (device->att_io) {
+		g_io_channel_shutdown(device->att_io, FALSE, NULL);
+		g_io_channel_unref(device->att_io);
+		device->att_io = NULL;
+	}
+
+	if (device->attrib) {
+		g_attrib_unref(device->attrib);
+		device->attrib = NULL;
+	}
+}
+
 static void browse_request_cancel(struct browse_req *req)
 {
 	struct btd_device *device = req->device;
@@ -211,16 +235,7 @@ static void browse_request_cancel(struct browse_req *req)
 
 	bt_cancel_discovery(&src, &device->bdaddr);
 
-	if (device->cleanup_id) {
-		g_source_remove(device->cleanup_id);
-		device->cleanup_id = 0;
-	}
-
-	if (device->att_io) {
-		g_io_channel_shutdown(device->att_io, FALSE, NULL);
-		g_io_channel_unref(device->att_io);
-		device->att_io = NULL;
-	}
+	att_cleanup(device);
 
 	device->browse = NULL;
 	browse_request_free(req);
@@ -245,10 +260,7 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
 
-	if (device->cleanup_id)
-		g_source_remove(device->cleanup_id);
-
-	g_attrib_unref(device->attrib);
+	att_cleanup(device);
 
 	if (device->tmp_records)
 		sdp_list_free(device->tmp_records,
@@ -263,11 +275,6 @@ static void device_free(gpointer user_data)
 	if (device->auto_id)
 		g_source_remove(device->auto_id);
 
-	if (device->att_io) {
-		g_io_channel_shutdown(device->att_io, FALSE, NULL);
-		g_io_channel_unref(device->att_io);
-	}
-
 	DBG("%p", device);
 
 	g_free(device->authr);
@@ -1776,12 +1783,7 @@ static gboolean attrib_disconnected_cb(GIOChannel *io, GIOCondition cond,
 						att_connect_dispatched);
 
 done:
-	attrib_channel_detach(device->attrib, device->attachid);
-	device->attachid = 0;
-	g_attrib_unref(device->attrib);
-	device->attrib = NULL;
-
-	device->cleanup_id = 0;
+	att_cleanup(device);
 
 	return FALSE;
 }
@@ -1809,14 +1811,8 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	device_register_services(req->conn, device, g_slist_copy(services), -1);
 	device_probe_drivers(device, uuids);
 
-	if (device->attios == NULL && device->attios_offline == NULL) {
-		attrib_channel_detach(device->attrib, device->attachid);
-		g_source_remove(device->cleanup_id);
-		device->cleanup_id = 0;
-		device->attachid = 0;
-		g_attrib_unref(device->attrib);
-		device->attrib = NULL;
-	}
+	if (device->attios == NULL && device->attios_offline == NULL)
+		att_cleanup(device);
 
 	g_slist_free(uuids);
 
@@ -2975,24 +2971,7 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 	if (device->attios != NULL || device->attios_offline != NULL)
 		return TRUE;
 
-	if (device->attachid > 0) {
-		attrib_channel_detach(device->attrib, device->attachid);
-		device->attachid = 0;
-	}
-
-	g_source_remove(device->cleanup_id);
-	device->cleanup_id = 0;
-
-	if (device->attrib) {
-		g_attrib_unref(device->attrib);
-		device->attrib = NULL;
-	}
-
-	if (device->att_io) {
-		g_io_channel_shutdown(device->att_io, FALSE, NULL);
-		g_io_channel_unref(device->att_io);
-		device->att_io = NULL;
-	}
+	att_cleanup(device);
 
 	return TRUE;
 }
-- 
1.7.8.4


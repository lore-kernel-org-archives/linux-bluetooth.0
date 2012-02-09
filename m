Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 5/7] device: Remove GAttrib disconnect callback
Date: Thu,  9 Feb 2012 12:56:07 -0300
Message-Id: <1328802969-20244-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces the usage of GAttrib disconnection callback by
GIOChannel watch to track ATT channel disconnection. Connection
management is being centralized in device to allow multi-profile
implementations.
---
 src/device.c |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index 288d327..f588e3c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -168,6 +168,7 @@ struct btd_device {
 	gint		ref;
 
 	GIOChannel      *att_io;
+	guint		cleanup_id;
 };
 
 static uint16_t uuid_list[] = {
@@ -210,7 +211,12 @@ static void browse_request_cancel(struct browse_req *req)
 
 	bt_cancel_discovery(&src, &device->bdaddr);
 
-	if (device->att_io != NULL) {
+	if (device->cleanup_id) {
+		g_source_remove(device->cleanup_id);
+		device->cleanup_id = 0;
+	}
+
+	if (device->att_io) {
 		g_io_channel_shutdown(device->att_io, FALSE, NULL);
 		g_io_channel_unref(device->att_io);
 		device->att_io = NULL;
@@ -239,6 +245,9 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
 
+	if (device->cleanup_id)
+		g_source_remove(device->cleanup_id);
+
 	g_attrib_unref(device->attrib);
 
 	if (device->tmp_records)
@@ -1742,17 +1751,16 @@ static void att_connect_dispatched(gpointer user_data)
 
 static gboolean att_connect(gpointer user_data);
 
-static void attrib_disconnected(gpointer user_data)
+static gboolean attrib_disconnected_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
 {
 	struct btd_device *device = user_data;
-	GIOChannel *io;
 	int sock, err = 0;
 	socklen_t len;
 
 	if (device->browse)
 		goto done;
 
-	io = g_attrib_get_channel(device->attrib);
 	sock = g_io_channel_unix_get_fd(io);
 	len = sizeof(err);
 	getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len);
@@ -1772,6 +1780,10 @@ done:
 	device->attachid = 0;
 	g_attrib_unref(device->attrib);
 	device->attrib = NULL;
+
+	device->cleanup_id = 0;
+
+	return FALSE;
 }
 
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
@@ -1799,6 +1811,8 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 
 	if (device->attios == NULL && device->attios_offline == NULL) {
 		attrib_channel_detach(device->attrib, device->attachid);
+		g_source_remove(device->cleanup_id);
+		device->cleanup_id = 0;
 		device->attachid = 0;
 		g_attrib_unref(device->attrib);
 		device->attrib = NULL;
@@ -1840,8 +1854,8 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		error("Attribute server attach failure!");
 
 	device->attrib = attrib;
-	g_attrib_set_disconnect_function(device->attrib,
-					attrib_disconnected, device);
+	device->cleanup_id = g_io_add_watch(io, G_IO_HUP,
+					attrib_disconnected_cb, device);
 
 	if (attcb->success)
 		attcb->success(user_data);
@@ -2966,6 +2980,9 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 		device->attachid = 0;
 	}
 
+	g_source_remove(device->cleanup_id);
+	device->cleanup_id = 0;
+
 	if (device->attrib) {
 		g_attrib_unref(device->attrib);
 		device->attrib = NULL;
-- 
1.7.8.4


Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 10/12] Manage GAttrib refs based on registered callbacks
Date: Wed, 20 Jul 2011 17:24:47 -0300
Message-Id: <1311193487-19648-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <CAKT1EBf9xw_mjYB=-TmAS08A1ww7UuJ8Hq6GXn04jQGi9Nrr=w@mail.gmail.com>
References: <CAKT1EBf9xw_mjYB=-TmAS08A1ww7UuJ8Hq6GXn04jQGi9Nrr=w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Connection should not be dropped if there is at least one ATT connection
callback registered. After discovering primary services over the LE link,
GAttrib ref needs to be held to allow notifying an active connection
while registering connection callbacks(inside plugins probing).
---
 src/device.c |   40 ++++++++++++++++++++++++++++------------
 1 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/src/device.c b/src/device.c
index d624b46..002e424 100644
--- a/src/device.c
+++ b/src/device.c
@@ -96,6 +96,7 @@ struct browse_req {
 	DBusConnection *conn;
 	DBusMessage *msg;
 	GIOChannel *io;
+	GAttrib *attrib;
 	struct btd_device *device;
 	GSList *match_uuids;
 	GSList *profiles_added;
@@ -163,6 +164,8 @@ static void browse_request_free(struct browse_req *req, gboolean shutdown)
 {
 	if (req->listener_id)
 		g_dbus_remove_watch(req->conn, req->listener_id);
+	if (req->attrib)
+		g_attrib_unref(req->attrib);
 	if (req->io) {
 		if (shutdown)
 			g_io_channel_shutdown(req->io, FALSE, NULL);
@@ -1642,9 +1645,21 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 		uuids = g_slist_append(uuids, prim->uuid);
 	}
 
+	/*
+	 * Profiles may register attio callbacks in the probing callback.
+	 * GAttrib reference can be released if the registered callbacks
+	 * list is emtpy.
+	 */
+	device->attrib = g_attrib_ref(req->attrib);
+
 	device_register_services(req->conn, device, g_slist_copy(services), -1);
 	device_probe_drivers(device, uuids);
 
+	if (device->attios == NULL) {
+		g_attrib_unref(device->attrib);
+		device->attrib = NULL;
+	}
+
 	g_slist_free(uuids);
 
 	create_device_reply(device, req);
@@ -1683,16 +1698,16 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		device->attioid = 0;
 	}
 
-	device->attrib = g_attrib_new(io);
-	g_attrib_set_destroy_function(device->attrib, attrib_destroyed, device);
-
-	if (req)
-		gatt_discover_primary(device->attrib, NULL, primary_cb, req);
-	else if (device->attios)
+	if (req) {
+		req->attrib = g_attrib_new(io);
+		gatt_discover_primary(req->attrib, NULL, primary_cb, req);
+	} else if (device->attios) {
+		device->attrib = g_attrib_new(io);
+		g_attrib_set_destroy_function(device->attrib, attrib_destroyed,
+								device);
 		g_slist_foreach(device->attios, attio_connected,
 							device->attrib);
-
-	g_io_channel_unref(io);
+	}
 }
 
 static gboolean att_auto_connect(gpointer user_data)
@@ -1733,6 +1748,8 @@ static gboolean att_auto_connect(gpointer user_data)
 		return TRUE;
 	}
 
+	g_io_channel_unref(io);
+
 	return TRUE;
 }
 
@@ -2566,18 +2583,17 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 	attio->dcfunc = dcfunc;
 	attio->user_data = user_data;
 
-	device->attios = g_slist_append(device->attios, attio);
-
 	if (device->attrib && cfunc)
 		cfunc(device->attrib, user_data);
-
-	if (device->attioid == 0 && device->attrib == NULL) {
+	else if (device->attioid == 0) {
 		att_auto_connect(device);
 		device->attioid = g_timeout_add_seconds(AUTOCONNECT_INTERVAL,
 							att_auto_connect,
 							device);
 	}
 
+	device->attios = g_slist_append(device->attios, attio);
+
 	return attio->id;
 }
 
-- 
1.7.6


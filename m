Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] device: Move GAttrib reference to device
Date: Wed,  8 Feb 2012 17:35:48 -0300
Message-Id: <1328733349-29731-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1328733349-29731-1-git-send-email-andre.guedes@openbossa.org>
References: <1328733349-29731-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Save GAttrib reference directly in struct btd_device instead of
the temporary browse_req. GAttrib instance scope should not be
restricted to primary service browsing context only, it needs to
be shared to upper layers.
---
 src/device.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/src/device.c b/src/device.c
index 5bc2d3b..a85dd57 100644
--- a/src/device.c
+++ b/src/device.c
@@ -177,8 +177,6 @@ static void browse_request_free(struct browse_req *req)
 {
 	if (req->listener_id)
 		g_dbus_remove_watch(req->conn, req->listener_id);
-	if (req->attrib)
-		g_attrib_unref(req->attrib);
 	if (req->msg)
 		dbus_message_unref(req->msg);
 	if (req->conn)
@@ -1789,13 +1787,6 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 		uuids = g_slist_append(uuids, prim->uuid);
 	}
 
-	/*
-	 * Profiles may register attio callbacks in the probing callback.
-	 * GAttrib reference can be released if the registered callbacks
-	 * list is emtpy.
-	 */
-	device->attrib = g_attrib_ref(req->attrib);
-
 	device_register_services(req->conn, device, g_slist_copy(services), -1);
 	device_probe_drivers(device, uuids);
 
@@ -1903,7 +1894,6 @@ static void browse_primary_connect_cb(GIOChannel *io, GError *gerr,
 {
 	struct btd_device *device = user_data;
 	struct browse_req *req = device->browse;
-	GAttrib *attrib;
 
 	g_io_channel_unref(device->att_io);
 	device->att_io = NULL;
@@ -1922,13 +1912,12 @@ static void browse_primary_connect_cb(GIOChannel *io, GError *gerr,
 		return;
 	}
 
-	attrib = g_attrib_new(io);
-	device->attachid = attrib_channel_attach(attrib, TRUE);
+	device->attrib = g_attrib_new(io);
+	device->attachid = attrib_channel_attach(device->attrib, TRUE);
 	if (device->attachid == 0)
 		error("Attribute server attach failure!");
 
-	req->attrib = attrib;
-	gatt_discover_primary(req->attrib, NULL, primary_cb, req);
+	gatt_discover_primary(device->attrib, NULL, primary_cb, req);
 }
 
 int device_browse_primary(struct btd_device *device, DBusConnection *conn,
-- 
1.7.9


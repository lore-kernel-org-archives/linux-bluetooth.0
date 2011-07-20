Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 11/12] Postpone calling connected callback
Date: Wed, 20 Jul 2011 17:25:03 -0300
Message-Id: <1311193503-19684-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309987456-10219-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1309987456-10219-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the ATT callbacks registration function, the connection callback should
not be called in the same main loop iteraction to avoid accessing not
initialized data in the profiles during probing.
---
 src/device.c |   54 +++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/src/device.c b/src/device.c
index 002e424..1287f52 100644
--- a/src/device.c
+++ b/src/device.c
@@ -136,6 +136,7 @@ struct btd_device {
 	GSList		*disconnects;		/* disconnects message */
 	GAttrib		*attrib;
 	GSList		*attios;
+	GSList		*attios_offline;
 	guint		attioid;
 
 	gboolean	connected;
@@ -219,6 +220,7 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->uuids, g_free);
 	g_slist_free_full(device->primaries, g_free);
 	g_slist_free_full(device->attios, g_free);
+	g_slist_free_full(device->attios_offline, g_free);
 
 	g_attrib_unref(device->attrib);
 
@@ -1612,14 +1614,14 @@ static void attrib_destroyed(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
-	device->attrib = NULL;
-
 	g_slist_foreach(device->attios, attio_disconnected, NULL);
 
-	if (device->attioid == 0 && device->attios != NULL)
+	if ((device->attios || device->attios_offline) && device->attioid == 0)
 		device->attioid = g_timeout_add_seconds(AUTOCONNECT_INTERVAL,
 							att_auto_connect,
 							device);
+
+	device->attrib = NULL;
 }
 
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
@@ -1655,7 +1657,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	device_register_services(req->conn, device, g_slist_copy(services), -1);
 	device_probe_drivers(device, uuids);
 
-	if (device->attios == NULL) {
+	if (device->attios == NULL && device->attios_offline == NULL) {
 		g_attrib_unref(device->attrib);
 		device->attrib = NULL;
 	}
@@ -2567,6 +2569,20 @@ void device_set_class(struct btd_device *device, uint32_t value)
 				DBUS_TYPE_UINT32, &value);
 }
 
+static gboolean notify_attios(gpointer user_data)
+{
+	struct btd_device *device = user_data;
+
+	if (device->attrib == NULL)
+		return FALSE;
+
+	g_slist_foreach(device->attios_offline, attio_connected, device->attrib);
+	device->attios = g_slist_concat(device->attios, device->attios_offline);
+	device->attios_offline = NULL;
+
+	return FALSE;
+}
+
 guint btd_device_add_attio_callback(struct btd_device *device,
 						attio_connect_cb cfunc,
 						attio_disconnect_cb dcfunc,
@@ -2583,17 +2599,18 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 	attio->dcfunc = dcfunc;
 	attio->user_data = user_data;
 
-	if (device->attrib && cfunc)
-		cfunc(device->attrib, user_data);
-	else if (device->attioid == 0) {
+	if (device->attrib && cfunc) {
+		device->attios_offline = g_slist_append(device->attios_offline,
+									attio);
+		g_idle_add(notify_attios, device);
+	} else if (device->attioid == 0) {
 		att_auto_connect(device);
 		device->attioid = g_timeout_add_seconds(AUTOCONNECT_INTERVAL,
 							att_auto_connect,
 							device);
+		device->attios = g_slist_append(device->attios, attio);
 	}
 
-	device->attios = g_slist_append(device->attios, attio);
-
 	return attio->id;
 }
 
@@ -2612,16 +2629,23 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 
 	l = g_slist_find_custom(device->attios, GUINT_TO_POINTER(id),
 								attio_id_cmp);
-	if (!l)
-		return FALSE;
-
-	attio = l->data;
+	if (l) {
+		attio = l->data;
+		device->attios = g_slist_remove(device->attios, attio);
+	} else {
+		l = g_slist_find_custom(device->attios_offline,
+					GUINT_TO_POINTER(id), attio_id_cmp);
+		if (!l)
+			return FALSE;
 
-	device->attios = g_slist_remove(device->attios, attio);
+		attio = l->data;
+		device->attios_offline = g_slist_remove(device->attios_offline,
+									attio);
+	}
 
 	g_free(attio);
 
-	if (device->attios != NULL)
+	if (device->attios != NULL || device->attios_offline != NULL)
 		return TRUE;
 
 	if (device->attioid) {
-- 
1.7.6


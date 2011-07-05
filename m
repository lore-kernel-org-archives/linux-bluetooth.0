Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 11/12] Postpone calling connected callback
Date: Tue,  5 Jul 2011 10:56:07 -0300
Message-Id: <1309874168-32716-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the ATT callbacks registration function, the connection callback should
not be called in the same main loop iteraction to avoid accessing not
initialized data in the profiles during probing.
---
 src/device.c |   67 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/src/device.c b/src/device.c
index fa0efc0..52462be 100644
--- a/src/device.c
+++ b/src/device.c
@@ -134,7 +134,8 @@ struct btd_device {
 	struct authentication_req *authr;	/* authentication request */
 	GSList		*disconnects;		/* disconnects message */
 	GAttrib		*attrib;
-	GSList		*attios;
+	GSList		*attios_head;
+	GSList		*attios_tail;
 	guint		attioid;
 
 	gboolean	connected;
@@ -214,7 +215,8 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->services, g_free);
 	g_slist_free_full(device->uuids, g_free);
 	g_slist_free_full(device->primaries, g_free);
-	g_slist_free_full(device->attios, g_free);
+	g_slist_free_full(device->attios_head, g_free);
+	g_slist_free_full(device->attios_tail, g_free);
 
 	g_attrib_unref(device->attrib);
 
@@ -1617,14 +1619,15 @@ static void attrib_destroyed(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
-	device->attrib = NULL;
-
-	g_slist_foreach(device->attios, attio_disconnected, NULL);
+	g_slist_foreach(device->attios_head, attio_disconnected, NULL);
 
-	if (device->attioid == 0 && device->attios != NULL)
+	if ((device->attios_head || device->attios_tail) &&
+						device->attioid == 0)
 		device->attioid = g_timeout_add_seconds(AUTOCONNECT_INTERVAL,
 							att_auto_connect,
 							device);
+
+	device->attrib = NULL;
 }
 
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
@@ -1698,8 +1701,8 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	if (req)
 		gatt_discover_primary(device->attrib, NULL, primary_cb, req);
-	else if (device->attios)
-		g_slist_foreach(device->attios, attio_connected,
+	else if (device->attios_head)
+		g_slist_foreach(device->attios_head, attio_connected,
 							device->attrib);
 }
 
@@ -2553,6 +2556,21 @@ void device_set_class(struct btd_device *device, uint32_t value)
 				DBUS_TYPE_UINT32, &value);
 }
 
+static gboolean notify_attios(gpointer user_data)
+{
+	struct btd_device *device = user_data;
+
+	if (device->attrib == NULL)
+		return FALSE;
+
+	g_slist_foreach(device->attios_tail, attio_connected, device->attrib);
+	device->attios_head = g_slist_concat(device->attios_head,
+							device->attios_tail);
+	device->attios_tail = NULL;
+
+	return FALSE;
+}
+
 guint btd_device_add_attio_callback(struct btd_device *device,
 						attio_connect_cb cfunc,
 						attio_disconnect_cb dcfunc,
@@ -2571,20 +2589,22 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 
 	if (device->attrib) {
 		/* First element */
-		if (device->attios == NULL)
+		if (device->attios_head == NULL && device->attios_tail == NULL)
 			device->attrib = g_attrib_ref(device->attrib);
 
-		if (cfunc)
-			cfunc(device->attrib, user_data);
+		device->attios_tail = g_slist_append(device->attios_tail,
+									attio);
+		g_idle_add(notify_attios, device);
+
 	} else if (device->attioid == 0) {
 		att_auto_connect(device);
 		device->attioid = g_timeout_add_seconds(AUTOCONNECT_INTERVAL,
 							att_auto_connect,
 							device);
+		device->attios_head = g_slist_append(device->attios_head,
+									attio);
 	}
 
-	device->attios = g_slist_append(device->attios, attio);
-
 	return attio->id;
 }
 
@@ -2601,18 +2621,25 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 	struct attio_data *attio;
 	GSList *l;
 
-	l = g_slist_find_custom(device->attios, GUINT_TO_POINTER(id),
+	l = g_slist_find_custom(device->attios_head, GUINT_TO_POINTER(id),
 								attio_id_cmp);
-	if (!l)
-		return FALSE;
-
-	attio = l->data;
+	if (l) {
+		attio = l->data;
+		device->attios_head = g_slist_remove(device->attios_head,
+									attio);
+	} else {
+		l = g_slist_find_custom(device->attios_tail,
+					GUINT_TO_POINTER(id), attio_id_cmp);
+		if (!l)
+			return FALSE;
 
-	device->attios = g_slist_remove(device->attios, attio);
+		attio = l->data;
+		device->attios_tail = g_slist_remove(device->attios_tail, attio);
+	}
 
 	g_free(attio);
 
-	if (device->attios != NULL)
+	if (device->attios_head != NULL || device->attios_tail != NULL)
 		return TRUE;
 
 	if (device->attioid) {
-- 
1.7.6


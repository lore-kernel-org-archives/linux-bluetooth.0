Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 1/4] Add property changed callback
Date: Wed, 28 Mar 2012 16:46:26 +0200
Message-Id: <1332945989-375-2-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1332945989-375-1-git-send-email-chen.ganir@ti.com>
References: <1332945989-375-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add property changed callback mechanism for internal use between
different bluez modules. This mechanism will allow any module
holding a btd_device pointer, to register for proerty changed
events, similar to the D-BUS PropertyChanged signal.
---
 src/device.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h |    5 +++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index eab7e4c..45ce62e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -125,6 +125,11 @@ struct att_callbacks {
 	gpointer user_data;
 };
 
+struct prop_changed_cb {
+	guint id;
+	dev_property_changed_cb cb;
+};
+
 struct btd_device {
 	bdaddr_t	bdaddr;
 	addr_type_t	type;
@@ -169,6 +174,8 @@ struct btd_device {
 
 	GIOChannel      *att_io;
 	guint		cleanup_id;
+
+	GSList		*cb_list;
 };
 
 static uint16_t uuid_list[] = {
@@ -259,6 +266,7 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->primaries, g_free);
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
+	g_slist_free_full(device->cb_list,g_free);
 
 	att_cleanup(device);
 
@@ -2992,3 +3000,41 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 
 	return TRUE;
 }
+
+static int prop_changed_cb_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct prop_changed_cb *cb = a;
+	guint id = GPOINTER_TO_UINT(b);
+
+	return cb->id - id;
+}
+
+guint btd_device_add_prop_changed_cb(struct btd_device *device, dev_property_changed_cb cbfunc)
+{
+	struct prop_changed_cb *cb;
+	static guint cb_id = 0;
+
+	DBG("%p registered device propery changed callback", device);
+
+	cb = g_new0(struct prop_changed_cb, 1);
+	cb->id = ++cb_id;
+	cb->cb = cbfunc;
+
+	device->cb_list = g_slist_append(device->cb_list, cb);
+
+	return cb->id;
+}
+
+void btd_device_remove_prop_changed_cb(struct btd_device *device, guint id)
+{
+	struct prop_changed_cb *cb;
+	GSList *l;
+
+	l = g_slist_find_custom(device->cb_list, GUINT_TO_POINTER(id),
+					prop_changed_cb_cmp);
+	if (l) {
+		cb = l->data;
+		device->cb_list = g_slist_remove(device->cb_list, cb);
+		g_free(cb);
+	}
+}
diff --git a/src/device.h b/src/device.h
index 7cb9bb2..ba9ed32 100644
--- a/src/device.h
+++ b/src/device.h
@@ -26,6 +26,8 @@
 
 struct btd_device;
 
+typedef void (*dev_property_changed_cb)(uint16_t property, uint8_t *value, uint16_t len);
+
 typedef enum {
 	AUTH_TYPE_PINCODE,
 	AUTH_TYPE_PASSKEY,
@@ -120,3 +122,6 @@ int device_block(DBusConnection *conn, struct btd_device *device,
 						gboolean update_only);
 int device_unblock(DBusConnection *conn, struct btd_device *device,
 					gboolean silent, gboolean update_only);
+guint btd_device_add_prop_changed_cb(struct btd_device *device,
+					dev_property_changed_cb cb);
+void btd_device_remove_prop_changed_cb(struct btd_device *device, guint id);
-- 
1.7.4.1


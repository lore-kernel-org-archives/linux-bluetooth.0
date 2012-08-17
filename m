Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 06/10] gatt: Emit PropertyChanged for Appearance
Date: Fri, 17 Aug 2012 11:43:27 -0300
Message-Id: <1345214611-9071-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345214611-9071-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
 <1345214611-9071-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Emit PropertyChanged changed signal in the Device hierarchy when the
Appearance characteristic value is read from the remote GAP service.
---
 profiles/gatt/gas.c |    3 +++
 src/device.c        |    8 ++++++++
 src/device.h        |    1 +
 3 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 76db130..54f5842 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -67,6 +67,7 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
+	struct gas *gas = user_data;
 	struct att_data_list *list =  NULL;
 	uint16_t app;
 	uint8_t *atval;
@@ -91,6 +92,8 @@ static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	DBG("GAP Appearance: 0x%04x", app);
 
+	device_set_appearance(gas->device, app);
+
 done:
 	att_data_list_free(list);
 }
diff --git a/src/device.c b/src/device.c
index 00ab760..f612bb0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3012,6 +3012,14 @@ int device_get_appearance(struct btd_device *device, uint16_t *value)
 	return 0;
 }
 
+void device_set_appearance(struct btd_device *device, uint16_t value)
+{
+	DBusConnection *conn = get_dbus_connection();
+
+	emit_property_changed(conn, device->path, DEVICE_INTERFACE,
+				"Appearance", DBUS_TYPE_UINT16, &value);
+}
+
 static gboolean notify_attios(gpointer user_data)
 {
 	struct btd_device *device = user_data;
diff --git a/src/device.h b/src/device.h
index eb4b41e..85d265a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -104,6 +104,7 @@ guint device_add_disconnect_watch(struct btd_device *device,
 void device_remove_disconnect_watch(struct btd_device *device, guint id);
 void device_set_class(struct btd_device *device, uint32_t value);
 int device_get_appearance(struct btd_device *device, uint16_t *value);
+void device_set_appearance(struct btd_device *device, uint16_t value);
 
 #define BTD_UUIDS(args...) ((const char *[]) { args, NULL } )
 
-- 
1.7.8.6


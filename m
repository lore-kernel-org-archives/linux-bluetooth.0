Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 4/4] Call registered callbacks
Date: Wed, 28 Mar 2012 16:46:29 +0200
Message-Id: <1332945989-375-5-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1332945989-375-1-git-send-email-chen.ganir@ti.com>
References: <1332945989-375-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

On Property Changed, call the registered callbacks, with the event
data payload.
---
 src/device.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 130 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index dbabd87..4e7685e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -128,6 +128,13 @@ struct att_callbacks {
 struct prop_changed_cb {
 	guint id;
 	dev_property_changed_cb cb;
+	struct btd_device *device;
+};
+
+struct prop_changed_cb_data {
+	uint16_t property;
+	uint16_t len;
+	void *data;
 };
 
 struct btd_device {
@@ -205,6 +212,13 @@ const char *property_name[] = { "Address",
 								"Adapter",
 								"LegacyPairing"};
 
+static void property_changed_update_cb(struct prop_changed_cb *cb,
+						struct prop_changed_cb_data *data)
+{
+	if (cb->cb != NULL)
+		(cb->cb)(data->property, data->data, data->len,cb->device);
+}
+
 static void notify_property_changed(struct btd_device *device,
 					DBusConnection *conn,
 					const char *path,
@@ -213,12 +227,56 @@ static void notify_property_changed(struct btd_device *device,
 {
 	const char *interface = DEVICE_INTERFACE;
 	const char *name = "";
+	struct prop_changed_cb_data *cb_data = NULL;
 
 	if (property > 0 && property <= DEVICE_PROPERTY_CHANGED_LEGACYPAIRING)
 		name = property_name[property-1];
 	else
 		name = "UNKNOWN";
 
+	cb_data = g_new0(struct prop_changed_cb_data, 1);
+
+	if (cb_data != NULL) {
+		cb_data->property = property;
+
+		switch (property) {
+		case DEVICE_PROPERTY_CHANGED_CONNECTED:
+		{
+			struct property_changed_connected *p = g_new0(struct property_changed_connected,1);
+			p->connected = *(gboolean*)value;
+			cb_data->data = p;
+			cb_data->len = sizeof(struct property_changed_connected);
+			break;
+		}
+		case DEVICE_PROPERTY_CHANGED_ADDRESS:
+		case DEVICE_PROPERTY_CHANGED_NAME:
+		case DEVICE_PROPERTY_CHANGED_VENDOR:
+		case DEVICE_PROPERTY_CHANGED_PRODUCT:
+		case DEVICE_PROPERTY_CHANGED_VERSION:
+		case DEVICE_PROPERTY_CHANGED_ICON:
+		case DEVICE_PROPERTY_CHANGED_CLASS:
+		case DEVICE_PROPERTY_CHANGED_UUIDS:
+		case DEVICE_PROPERTY_CHANGED_SERVICES:
+		case DEVICE_PROPERTY_CHANGED_PAIRED:
+		case DEVICE_PROPERTY_CHANGED_TRUSTED:
+		case DEVICE_PROPERTY_CHANGED_BLOCKED:
+		case DEVICE_PROPERTY_CHANGED_ALIAS:
+		case DEVICE_PROPERTY_CHANGED_NODES:
+		case DEVICE_PROPERTY_CHANGED_ADAPTER:
+		case DEVICE_PROPERTY_CHANGED_LEGACYPAIRING:
+		default:
+			break;
+		}
+
+		if (cb_data != NULL && cb_data->len > 0 && cb_data->data != NULL) {
+			g_slist_foreach(device->cb_list, (GFunc) property_changed_update_cb, cb_data);
+		}
+
+		g_free(cb_data->data);
+		g_free(cb_data);
+	}
+
+
 	if (num == 0)
 		emit_property_changed(conn, path,
 					interface, name,
@@ -3067,6 +3125,7 @@ guint btd_device_add_prop_changed_cb(struct btd_device *device, dev_property_cha
 	cb = g_new0(struct prop_changed_cb, 1);
 	cb->id = ++cb_id;
 	cb->cb = cbfunc;
+	cb->device = device;
 
 	device->cb_list = g_slist_append(device->cb_list, cb);
 
diff --git a/src/device.h b/src/device.h
index ce0a83a..3c54255 100644
--- a/src/device.h
+++ b/src/device.h
@@ -26,25 +26,95 @@
 
 struct btd_device;
 
-typedef void (*dev_property_changed_cb)(uint16_t property, uint8_t *value, uint16_t len);
+typedef void (*dev_property_changed_cb)(uint16_t property, uint8_t *value, uint16_t len,struct btd_device *device);
 
 #define DEVICE_PROPERTY_CHANGED_ADDRESS			0x01
+struct property_changed_address {
+	char *address;
+};
+
 #define DEVICE_PROPERTY_CHANGED_NAME			0x02
+struct property_changed_name {
+	char *name;
+};
+
 #define DEVICE_PROPERTY_CHANGED_VENDOR			0x03
+struct propery_changed_vendor {
+	uint16_t vendor;
+};
+
 #define DEVICE_PROPERTY_CHANGED_PRODUCT			0x04
+struct propery_changed_product {
+	uint16_t product;
+};
+
 #define DEVICE_PROPERTY_CHANGED_VERSION			0x05
+struct propery_changed_version {
+	uint16_t version;
+};
+
 #define DEVICE_PROPERTY_CHANGED_ICON			0x06
+struct property_changed_icon {
+	char *icon;
+};
+
 #define DEVICE_PROPERTY_CHANGED_CLASS			0x07
+struct propery_changed_class {
+	uint32_t class;
+};
+
 #define DEVICE_PROPERTY_CHANGED_UUIDS			0x08
+struct propery_changed_uuid {
+	uint16_t count;
+	char *uuid[];
+};
+
 #define DEVICE_PROPERTY_CHANGED_SERVICES		0x09
+struct propery_changed_services {
+	uint16_t count;
+	char *services[];
+};
+
 #define DEVICE_PROPERTY_CHANGED_PAIRED			0x0A
+struct propery_changed_paired {
+	gboolean paired;
+};
+
 #define DEVICE_PROPERTY_CHANGED_CONNECTED       0x0B
+struct property_changed_connected {
+	gboolean connected;
+};
+
 #define DEVICE_PROPERTY_CHANGED_TRUSTED			0x0C
+struct propery_changed_trusted {
+	gboolean trusted;
+};
+
 #define DEVICE_PROPERTY_CHANGED_BLOCKED			0x0D
+struct propery_changed_blocked {
+	gboolean blocked;
+};
+
 #define DEVICE_PROPERTY_CHANGED_ALIAS			0x0E
+struct property_changed_alias {
+	char *alias;
+};
+
 #define DEVICE_PROPERTY_CHANGED_NODES			0x0F
+struct propery_changed_nodes {
+	uint16_t count;
+	char *nodes[];
+};
+
 #define DEVICE_PROPERTY_CHANGED_ADAPTER			0x10
+struct propery_changed_adapter {
+	char adapter;
+};
+
 #define DEVICE_PROPERTY_CHANGED_LEGACYPAIRING	0x11
+struct propery_changed_legacy_pairing {
+	gboolean legacy_pairing;
+};
 
 typedef enum {
 	AUTH_TYPE_PINCODE,
-- 
1.7.4.1


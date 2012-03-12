Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 3/3] DeviceInfo: Read PNP ID
Date: Mon, 12 Mar 2012 16:54:28 +0200
Message-Id: <1331564068-2658-4-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1331564068-2658-1-git-send-email-chen.ganir@ti.com>
References: <1331564068-2658-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Read the PNP ID characteristic of the DeviceInfo Service, and
store it inside the btd_device, for use by other profiles.
---
 deviceinfo/deviceinfo.c |   38 ++++++++++++++++++++++++++++++++++++++
 src/device.c            |   23 +++++++++++++++++++++++
 src/device.h            |    3 +++
 3 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
index ab2e468..59e41b1 100644
--- a/deviceinfo/deviceinfo.c
+++ b/deviceinfo/deviceinfo.c
@@ -90,6 +90,42 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct characteristic *ch = user_data;
+	uint8_t value[ATT_MAX_MTU];
+	int vlen;
+
+	if (status != 0) {
+		DBG("value read failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_read_resp(pdu, len, value, &vlen)) {
+		DBG("Protocol error\n");
+		return;
+	}
+
+	if (vlen < 7) {
+		DBG("Invalid deviceinfo received");
+		return;
+	}
+
+	device_set_deviceinfo_pnpid(ch->d->dev,value[0],att_get_u16(&value[1]), att_get_u16(&value[3]),
+				att_get_u16(&value[5]));
+}
+
+static void process_deviceinfo_char(struct characteristic *ch)
+{
+	if (g_strcmp0(ch->attr.uuid, PNPID_UUID) == 0) {
+		gatt_read_char(ch->d->attrib, ch->attr.value_handle, 0,
+							read_pnpid_cb, ch);
+		return;
+	}
+}
+
 static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
@@ -116,6 +152,8 @@ static void configure_deviceinfo_cb(GSList *characteristics, guint8 status,
 
 		d->chars = g_slist_append(d->chars, ch);
 
+		process_deviceinfo_char(ch);
+
 		start = c->value_handle + 1;
 
 		if (l->next != NULL) {
diff --git a/src/device.c b/src/device.c
index dfc8e59..0e8a04d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -125,6 +125,17 @@ struct att_callbacks {
 	gpointer user_data;
 };
 
+#define DEVICEINFO_PNPID	0x01
+
+struct btd_deviceinfo_data{
+	uint8_t		vendor_id_src;
+	uint16_t	vendor_id;
+	uint16_t	product_id;
+	uint16_t	product_ver;
+	uint16_t    deviceinfo_mask;
+
+};
+
 struct btd_device {
 	bdaddr_t	bdaddr;
 	addr_type_t	type;
@@ -169,6 +180,8 @@ struct btd_device {
 
 	GIOChannel      *att_io;
 	guint		cleanup_id;
+
+	struct btd_deviceinfo_data deviceinfo;
 };
 
 static uint16_t uuid_list[] = {
@@ -2995,3 +3008,13 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 
 	return TRUE;
 }
+
+void device_set_deviceinfo_pnpid(struct btd_device *device, uint8_t vendor_id_src,
+					uint16_t vendor_id, uint16_t product_id, uint16_t product_ver)
+{
+	device->deviceinfo.vendor_id_src = vendor_id_src;
+	device->deviceinfo.vendor_id = vendor_id;
+	device->deviceinfo.product_id = product_id;
+	device->deviceinfo.product_ver = product_ver;
+	device->deviceinfo.deviceinfo_mask |= DEVICEINFO_PNPID;
+}
diff --git a/src/device.h b/src/device.h
index 7cb9bb2..0c7f619 100644
--- a/src/device.h
+++ b/src/device.h
@@ -120,3 +120,6 @@ int device_block(DBusConnection *conn, struct btd_device *device,
 						gboolean update_only);
 int device_unblock(DBusConnection *conn, struct btd_device *device,
 					gboolean silent, gboolean update_only);
+
+void device_set_deviceinfo_pnpid(struct btd_device *device, uint8_t vendor_id_src,
+					uint16_t vendor_id, uint16_t product_id, uint16_t product_ver);
-- 
1.7.4.1


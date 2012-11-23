Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 2/3] device: Add a way to be notified that PNP information is present
Date: Fri, 23 Nov 2012 17:30:31 -0300
Message-Id: <1353702632-7960-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1353702632-7960-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1353702632-7960-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will be used inside the HoG profile to only create the uhid device
after the PNP information is present, for the HID subsystem may use the
vendor and product ids to load the correct module.

btd_device_register_pnpid_notifier() will return 'false' when the
information is already present.
---
 src/device.c | 41 +++++++++++++++++++++++++++++++++++++++++
 src/device.h |  5 +++++
 2 files changed, 46 insertions(+)

diff --git a/src/device.c b/src/device.c
index a196af4..ec890fa 100644
--- a/src/device.c
+++ b/src/device.c
@@ -132,6 +132,11 @@ struct attio_data {
 	gpointer user_data;
 };
 
+struct pnpid_notifier {
+	pnpid_ready_func func;
+	void *user_data;
+};
+
 typedef void (*attio_error_cb) (const GError *gerr, gpointer user_data);
 typedef void (*attio_success_cb) (gpointer user_data);
 
@@ -195,6 +200,8 @@ struct btd_device {
 	GIOChannel	*att_io;
 	guint		cleanup_id;
 	guint		store_id;
+
+	GSList		*pnpid_notifiers;
 };
 
 static uint16_t uuid_list[] = {
@@ -347,6 +354,7 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->primaries, g_free);
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
+	g_slist_free_full(device->pnpid_notifiers, g_free);
 
 	attio_cleanup(device);
 
@@ -4105,10 +4113,43 @@ void btd_device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 			uint16_t vendor_id, uint16_t product_id,
 			uint16_t product_ver)
 {
+	GSList *l;
+
 	device_set_vendor(device, vendor_id);
 	device_set_vendor_src(device, vendor_id_src);
 	device_set_product(device, product_id);
 	device_set_version(device, product_ver);
 
 	store_device_info(device);
+
+	for (l = device->pnpid_notifiers; l; l = l->next) {
+		struct pnpid_notifier *notifier = l->data;
+
+		notifier->func(notifier->user_data);
+		g_free(notifier);
+	}
+
+	g_slist_free_full(device->pnpid_notifiers, g_free);
+	device->pnpid_notifiers = NULL;
+}
+
+bool btd_device_register_pnpid_notifier(struct btd_device *device,
+				pnpid_ready_func notify, void *user_data)
+{
+	struct pnpid_notifier *notifier;
+
+	if (btd_device_get_vendor(device) ||
+			btd_device_get_vendor_src(device) ||
+			btd_device_get_product(device) ||
+			btd_device_get_version(device))
+		return false;
+
+	notifier = g_new0(struct pnpid_notifier, 1);
+
+	notifier->func = notify;
+	notifier->user_data = user_data;
+
+	device->pnpid_notifiers = g_slist_append(device->pnpid_notifiers,
+								notifier);
+	return true;
 }
diff --git a/src/device.h b/src/device.h
index 703dfcf..914ee38 100644
--- a/src/device.h
+++ b/src/device.h
@@ -119,4 +119,9 @@ int device_unblock(struct btd_device *device, gboolean silent,
 void btd_device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 			uint16_t vendor_id, uint16_t product_id,
 			uint16_t product_ver);
+
+typedef void (*pnpid_ready_func) (void *user_data);
+
+bool btd_device_register_pnpid_notifier(struct btd_device *device,
+		pnpid_ready_func notify, void *user_data);
 GIOChannel *device_att_connect(gpointer user_data);
-- 
1.8.0


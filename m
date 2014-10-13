Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] core: Add subscription API for Manufacturer Specific Data
Date: Mon, 13 Oct 2014 11:43:43 +0000
Message-Id: <1413200623-31278-4-git-send-email-fons@spotify.com>
In-Reply-To: <1413200623-31278-1-git-send-email-fons@spotify.com>
References: <1413200623-31278-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows plugins to be notified whenever an adapter receives
Manufacturer Specific Data in the advertising reports from a device.

This can happen when new device is discovered or when we autoconnect
to it.
---
 src/adapter.c | 36 ++++++++++++++++++++++++++++++++++++
 src/adapter.h | 10 ++++++++++
 2 files changed, 46 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 92ee1a0..d04ea83 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -206,6 +206,7 @@ struct btd_adapter {
 	gboolean initialized;
 
 	GSList *pin_callbacks;
+	GSList *msd_callbacks;
 
 	GSList *drivers;
 	GSList *profiles;
@@ -4549,6 +4550,9 @@ static void adapter_remove(struct btd_adapter *adapter)
 
 	g_slist_free(adapter->pin_callbacks);
 	adapter->pin_callbacks = NULL;
+
+	g_slist_free(adapter->msd_callbacks);
+	adapter->msd_callbacks = NULL;
 }
 
 const char *adapter_get_path(struct btd_adapter *adapter)
@@ -4647,6 +4651,20 @@ static void confirm_name(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 						confirm_name_timeout, adapter);
 }
 
+void adapter_msd_notify(struct btd_adapter *adapter, struct btd_device *dev,
+						const struct eir_msd *msd)
+{
+	GSList *l, *next;
+
+	for (l = adapter->msd_callbacks; l != NULL; l = next) {
+		btd_msd_cb_t cb = l->data;
+
+		next = g_slist_next(l);
+
+		cb(adapter, dev, msd->company, msd->data, msd->data_len);
+	}
+}
+
 static void update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
@@ -4738,6 +4756,9 @@ static void update_found_devices(struct btd_adapter *adapter,
 
 	device_add_eir_uuids(dev, eir_data.services);
 
+	if (eir_data.msd)
+		adapter_msd_notify(adapter, dev, eir_data.msd);
+
 	eir_data_free(&eir_data);
 
 	/*
@@ -5173,6 +5194,18 @@ void btd_adapter_unregister_pin_cb(struct btd_adapter *adapter,
 	adapter->pin_callbacks = g_slist_remove(adapter->pin_callbacks, cb);
 }
 
+void btd_adapter_unregister_msd_cb(struct btd_adapter *adapter,
+							btd_msd_cb_t cb)
+{
+	adapter->msd_callbacks = g_slist_remove(adapter->msd_callbacks, cb);
+}
+
+void btd_adapter_register_msd_cb(struct btd_adapter *adapter,
+							btd_msd_cb_t cb)
+{
+	adapter->msd_callbacks = g_slist_prepend(adapter->msd_callbacks, cb);
+}
+
 int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
 							gboolean enable)
 {
@@ -6663,6 +6696,9 @@ static void connected_callback(uint16_t index, uint16_t length,
 		btd_device_device_set_name(device, eir_data.name);
 	}
 
+	if (eir_data.msd)
+		adapter_msd_notify(adapter, device, eir_data.msd);
+
 	eir_data_free(&eir_data);
 }
 
diff --git a/src/adapter.h b/src/adapter.h
index 6801fee..8f4098a 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -138,6 +138,16 @@ struct btd_adapter_pin_cb_iter *btd_adapter_pin_cb_iter_new(
 void btd_adapter_pin_cb_iter_free(struct btd_adapter_pin_cb_iter *iter);
 bool btd_adapter_pin_cb_iter_end(struct btd_adapter_pin_cb_iter *iter);
 
+typedef void (*btd_msd_cb_t) (struct btd_adapter *adapter,
+							struct btd_device *dev,
+							uint16_t company,
+							const uint8_t *data,
+							uint8_t data_len);
+void btd_adapter_register_msd_cb(struct btd_adapter *adapter,
+							btd_msd_cb_t cb);
+void btd_adapter_unregister_msd_cb(struct btd_adapter *adapter,
+							btd_msd_cb_t cb);
+
 /* If TRUE, enables fast connectabe, i.e. reduces page scan interval and changes
  * type. If FALSE, disables fast connectable, i.e. sets page scan interval and
  * type to default values. Valid for both connectable and discoverable modes. */
-- 
1.9.1


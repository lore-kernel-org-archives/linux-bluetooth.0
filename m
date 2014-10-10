Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] core: Add subscription API for Manufacturer Specific Data
Date: Fri, 10 Oct 2014 15:23:46 +0000
Message-Id: <1412954626-30226-3-git-send-email-fons@spotify.com>
In-Reply-To: <1412954626-30226-1-git-send-email-fons@spotify.com>
References: <1412954626-30226-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows plugins to be notified whenever an adapter receives
Manufacturer Specific Data inside from a device.

This can happen when new device is discovered or when we autoconnect
to it.
---
 plugins/neard.c |  1 -
 src/adapter.c   | 38 +++++++++++++++++++++++++++++++++++++-
 src/adapter.h   | 10 ++++++++++
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 137d601..a975417 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -38,7 +38,6 @@
 #include "src/dbus-common.h"
 #include "src/adapter.h"
 #include "src/device.h"
-#include "src/eir.h"
 #include "src/agent.h"
 #include "src/hcid.h"
 
diff --git a/src/adapter.c b/src/adapter.c
index 92ee1a0..8302cb4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -68,7 +68,6 @@
 #include "attrib/att.h"
 #include "attrib/gatt.h"
 #include "attrib-server.h"
-#include "eir.h"
 
 #define ADAPTER_INTERFACE	"org.bluez.Adapter1"
 
@@ -206,6 +205,7 @@ struct btd_adapter {
 	gboolean initialized;
 
 	GSList *pin_callbacks;
+	GSList *msd_callbacks;
 
 	GSList *drivers;
 	GSList *profiles;
@@ -4549,6 +4549,10 @@ static void adapter_remove(struct btd_adapter *adapter)
 
 	g_slist_free(adapter->pin_callbacks);
 	adapter->pin_callbacks = NULL;
+
+	g_slist_free(adapter->msd_callbacks);
+	adapter->msd_callbacks = NULL;
+
 }
 
 const char *adapter_get_path(struct btd_adapter *adapter)
@@ -4647,6 +4651,20 @@ static void confirm_name(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 						confirm_name_timeout, adapter);
 }
 
+void adapter_msd_notify(struct btd_adapter *adapter, struct btd_device *dev,
+				const struct eir_msd *msd)
+{
+	GSList *l, *next;
+
+	for (l = adapter->msd_callbacks; l != NULL; l = next) {
+		btd_msd_cb_t cb = l->data;
+
+		next = g_slist_next(l);
+
+		cb(adapter, dev, msd);
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
index 6801fee..e72af89 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -30,6 +30,8 @@
 #include <glib.h>
 #include <stdbool.h>
 
+#include "eir.h"
+
 #define MAX_NAME_LENGTH		248
 
 /* Invalid SSP passkey value used to indicate negative replies */
@@ -138,6 +140,14 @@ struct btd_adapter_pin_cb_iter *btd_adapter_pin_cb_iter_new(
 void btd_adapter_pin_cb_iter_free(struct btd_adapter_pin_cb_iter *iter);
 bool btd_adapter_pin_cb_iter_end(struct btd_adapter_pin_cb_iter *iter);
 
+typedef void (*btd_msd_cb_t) (struct btd_adapter *adapter,
+				struct btd_device *dev,
+				const struct eir_msd *msd);
+void btd_adapter_register_msd_cb(struct btd_adapter *adapter,
+					btd_msd_cb_t cb);
+void btd_adapter_unregister_msd_cb(struct btd_adapter *adapter,
+						btd_msd_cb_t cb);
+
 /* If TRUE, enables fast connectabe, i.e. reduces page scan interval and changes
  * type. If FALSE, disables fast connectable, i.e. sets page scan interval and
  * type to default values. Valid for both connectable and discoverable modes. */
-- 
1.9.1


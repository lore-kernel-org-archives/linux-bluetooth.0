Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 4/5] android/bluetooth: Add support for caching remote device info
Date: Tue, 14 Jan 2014 12:11:44 +0100
Message-Id: <1389697905-18532-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1389697905-18532-1-git-send-email-szymon.janc@tieto.com>
References: <1389697905-18532-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Cache is limited to DEVICES_CACHE_MAX. Devices are sorted with
timestamp so if cache is full olderst device is removed.
---
 android/bluetooth.c | 69 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 8c91d87..df442a3 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -70,6 +70,8 @@
 /* Default discoverable timeout 120sec as in Android */
 #define DEFAULT_DISCOVERABLE_TIMEOUT 120
 
+#define DEVICES_CACHE_MAX 100
+
 #define BASELEN_PROP_CHANGED (sizeof(struct hal_ev_adapter_props_changed) \
 					+ (sizeof(struct hal_property)))
 
@@ -261,6 +263,27 @@ static void store_device_info(struct device *dev)
 	g_strfreev(uuids);
 }
 
+static void remove_device_info(struct device *dev)
+{
+	GKeyFile *key_file;
+	gsize length = 0;
+	char addr[18];
+	char *str;
+
+	ba2str(&dev->bdaddr, addr);
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL);
+
+	g_key_file_remove_group(key_file, addr, NULL);
+
+	str = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(DEVICES_FILE, str, length, NULL);
+	g_free(str);
+
+	g_key_file_free(key_file);
+}
+
 static int device_match(gconstpointer a, gconstpointer b)
 {
 	const struct device *dev = a;
@@ -284,6 +307,34 @@ static struct device *find_device(const bdaddr_t *bdaddr)
 	return NULL;
 }
 
+static void free_device(struct device *dev)
+{
+	g_free(dev->name);
+	g_free(dev->friendly_name);
+	g_slist_free_full(dev->uuids, g_free);
+	g_free(dev);
+}
+
+static void cache_device(struct device *new_dev)
+{
+	struct device *dev;
+	GSList *l;
+
+	if (g_slist_length(devices) < DEVICES_CACHE_MAX)
+		goto done;
+
+	l = g_slist_last(devices);
+	dev = l->data;
+
+	devices = g_slist_remove(bonded_devices, dev);
+	remove_device_info(dev);
+	free_device(dev);
+
+done:
+	devices = g_slist_prepend(devices, new_dev);
+	store_device_info(new_dev);
+}
+
 static struct device *create_device(const bdaddr_t *bdaddr, uint8_t type)
 {
 	struct device *dev;
@@ -302,19 +353,10 @@ static struct device *create_device(const bdaddr_t *bdaddr, uint8_t type)
 	/* use address for name, will be change if one is present
 	 * eg. in EIR or set by set_property. */
 	dev->name = g_strdup(addr);
-	devices = g_slist_prepend(devices, dev);
 
 	return dev;
 }
 
-static void free_device(struct device *dev)
-{
-	g_free(dev->name);
-	g_free(dev->friendly_name);
-	g_slist_free_full(dev->uuids, g_free);
-	g_free(dev);
-}
-
 static struct device *get_device(const bdaddr_t *bdaddr, uint8_t type)
 {
 	struct device *dev;
@@ -586,7 +628,8 @@ static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
 	case HAL_BOND_STATE_NONE:
 		if (dev->bond_state == HAL_BOND_STATE_BONDED) {
 			bonded_devices = g_slist_remove(bonded_devices, dev);
-			devices = g_slist_prepend(devices, dev);
+			remove_stored_link_key(&dev->bdaddr);
+			cache_device(dev);
 		}
 		break;
 	case HAL_BOND_STATE_BONDED:
@@ -600,8 +643,6 @@ static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
 
 	dev->bond_state = state;
 
-	store_device_info(dev);
-
 	send_bond_state_change(&dev->bdaddr, status, state);
 }
 
@@ -1107,6 +1148,8 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		(*num_prop)++;
 	}
 
+	cache_device(dev);
+
 	ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, opcode, size, buf);
 
 	if (confirm) {
@@ -2463,8 +2506,6 @@ static void unpair_device_complete(uint8_t status, uint16_t length,
 	if (status != MGMT_STATUS_SUCCESS)
 		return;
 
-	remove_stored_link_key(&rp->addr.bdaddr);
-
 	set_device_bond_state(&rp->addr.bdaddr, HAL_STATUS_SUCCESS,
 							HAL_BOND_STATE_NONE);
 }
-- 
1.8.3.2


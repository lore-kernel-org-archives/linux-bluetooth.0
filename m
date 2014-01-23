Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 3/5] android/bluetooth: Add support for caching remote device info
Date: Thu, 23 Jan 2014 23:18:08 +0100
Message-Id: <1390515490-29538-4-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1390515490-29538-1-git-send-email-szymon.janc@gmail.com>
References: <1390515490-29538-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

Cache is limited to DEVICES_CACHE_MAX. Devices are sorted with
timestamp so if cache is full olderst device is removed.
---
 android/bluetooth.c | 115 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 82 insertions(+), 33 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index f5ac0e4..cf2dc83 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -56,6 +56,7 @@
 
 #define SETTINGS_FILE ANDROID_STORAGEDIR"/settings"
 #define DEVICES_FILE ANDROID_STORAGEDIR"/devices"
+#define CACHE_FILE ANDROID_STORAGEDIR"/cache"
 
 #define DEVICE_ID_SOURCE	0x0002	/* USB */
 #define DEVICE_ID_VENDOR	0x1d6b	/* Linux Foundation */
@@ -70,6 +71,8 @@
 /* Default discoverable timeout 120sec as in Android */
 #define DEFAULT_DISCOVERABLE_TIMEOUT 120
 
+#define DEVICES_CACHE_MAX 300
+
 #define BASELEN_PROP_CHANGED (sizeof(struct hal_ev_adapter_props_changed) \
 					+ (sizeof(struct hal_property)))
 
@@ -199,7 +202,7 @@ static void load_adapter_config(void)
 	g_key_file_free(key_file);
 }
 
-static void store_device_info(struct device *dev)
+static void store_device_info(struct device *dev, const char *path)
 {
 	GKeyFile *key_file;
 	char addr[18];
@@ -207,22 +210,10 @@ static void store_device_info(struct device *dev)
 	char **uuids = NULL;
 	char *str;
 
-	/* We only store bonded devices and need to modify the storage
-	 * if the state is either NONE or BONDED.
-	 */
-	if (dev->bond_state != HAL_BOND_STATE_BONDED &&
-					dev->bond_state != HAL_BOND_STATE_NONE)
-		return;
-
 	ba2str(&dev->bdaddr, addr);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL);
-
-	if (dev->bond_state == HAL_BOND_STATE_NONE) {
-		g_key_file_remove_group(key_file, addr, NULL);
-		goto done;
-	}
+	g_key_file_load_from_file(key_file, path, 0, NULL);
 
 	g_key_file_set_integer(key_file, addr, "Type", dev->bdaddr_type);
 
@@ -264,15 +255,35 @@ static void store_device_info(struct device *dev)
 		g_key_file_remove_key(key_file, addr, "Services", NULL);
 	}
 
-done:
 	str = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(DEVICES_FILE, str, length, NULL);
+	g_file_set_contents(path, str, length, NULL);
 	g_free(str);
 
 	g_key_file_free(key_file);
 	g_strfreev(uuids);
 }
 
+static void remove_device_info(struct device *dev, const char *path)
+{
+	GKeyFile *key_file;
+	gsize length = 0;
+	char addr[18];
+	char *str;
+
+	ba2str(&dev->bdaddr, addr);
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, path, 0, NULL);
+
+	g_key_file_remove_group(key_file, addr, NULL);
+
+	str = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(path, str, length, NULL);
+	g_free(str);
+
+	g_key_file_free(key_file);
+}
+
 static int device_match(gconstpointer a, gconstpointer b)
 {
 	const struct device *dev = a;
@@ -296,6 +307,41 @@ static struct device *find_device(const bdaddr_t *bdaddr)
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
+	l = g_slist_find(devices, new_dev);
+	if (l) {
+		devices = g_slist_remove(devices, new_dev);
+		goto cache;
+	}
+
+	if (g_slist_length(devices) < DEVICES_CACHE_MAX)
+		goto cache;
+
+	l = g_slist_last(devices);
+	dev = l->data;
+
+	devices = g_slist_remove(devices, dev);
+	remove_device_info(dev, CACHE_FILE);
+	free_device(dev);
+
+cache:
+	devices = g_slist_prepend(devices, new_dev);
+	new_dev->timestamp = time(NULL);
+	store_device_info(new_dev, CACHE_FILE);
+}
+
 static struct device *create_device(const bdaddr_t *bdaddr, uint8_t type)
 {
 	struct device *dev;
@@ -314,19 +360,10 @@ static struct device *create_device(const bdaddr_t *bdaddr, uint8_t type)
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
@@ -335,7 +372,11 @@ static struct device *get_device(const bdaddr_t *bdaddr, uint8_t type)
 	if (dev)
 		return dev;
 
-	return create_device(bdaddr, type);
+	dev = create_device(bdaddr, type);
+
+	cache_device(dev);
+
+	return dev;
 }
 
 static  void send_adapter_property(uint8_t type, uint16_t len, const void *val)
@@ -571,12 +612,15 @@ static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
 	case HAL_BOND_STATE_NONE:
 		if (dev->bond_state == HAL_BOND_STATE_BONDED) {
 			bonded_devices = g_slist_remove(bonded_devices, dev);
-			devices = g_slist_prepend(devices, dev);
+			remove_device_info(dev, DEVICES_FILE);
+			cache_device(dev);
 		}
 		break;
 	case HAL_BOND_STATE_BONDED:
 		devices = g_slist_remove(devices, dev);
 		bonded_devices = g_slist_prepend(bonded_devices, dev);
+		remove_device_info(dev, CACHE_FILE);
+		store_device_info(dev, DEVICES_FILE);
 		break;
 	case HAL_BOND_STATE_BONDING:
 	default:
@@ -585,8 +629,6 @@ static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
 
 	dev->bond_state = state;
 
-	store_device_info(dev);
-
 	send_bond_state_change(&dev->bdaddr, status, state);
 }
 
@@ -627,7 +669,10 @@ static void set_device_uuids(struct device *dev, GSList *uuids)
 	g_slist_free_full(dev->uuids, g_free);
 	dev->uuids = uuids;
 
-	store_device_info(dev);
+	if (dev->bond_state == HAL_BOND_STATE_BONDED)
+		store_device_info(dev, DEVICES_FILE);
+	else
+		store_device_info(dev, CACHE_FILE);
 
 	send_device_uuids_notif(dev);
 }
@@ -1058,8 +1103,6 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 
 		ev->status = HAL_STATUS_SUCCESS;
 		bdaddr2android(bdaddr, ev->bdaddr);
-
-		dev->timestamp = time(NULL);
 	}
 
 	if (eir.class) {
@@ -1087,6 +1130,9 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		(*num_prop)++;
 	}
 
+	if (dev->bond_state != HAL_BOND_STATE_BONDED)
+		cache_device(dev);
+
 	if (*num_prop)
 		ipc_send_notif(HAL_SERVICE_ID_BLUETOOTH, opcode, size, buf);
 
@@ -2860,7 +2906,10 @@ static uint8_t set_device_friendly_name(struct device *dev, const uint8_t *val,
 	g_free(dev->friendly_name);
 	dev->friendly_name = g_strndup((const char *) val, len);
 
-	store_device_info(dev);
+	if (dev->bond_state == HAL_BOND_STATE_BONDED)
+		store_device_info(dev, DEVICES_FILE);
+	else
+		store_device_info(dev, CACHE_FILE);
 
 	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_FRIENDLY_NAME,
 				strlen(dev->friendly_name), dev->friendly_name);
-- 
1.8.5.3


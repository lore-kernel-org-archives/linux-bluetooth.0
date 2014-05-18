Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] android/bluetooth: Track device last connected bearer
Date: Sun, 18 May 2014 13:53:56 +0200
Message-Id: <1400414040-30913-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400414040-30913-1-git-send-email-szymon.janc@tieto.com>
References: <1400414040-30913-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to correctly choose address type when pairing dual mode
devices.
---
 android/bluetooth.c | 75 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 13 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 1e760d4..bf562bc 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -104,7 +104,8 @@ struct device {
 	uint32_t class;
 	int32_t rssi;
 
-	uint32_t timestamp;
+	time_t bredr_seen;
+	time_t le_seen;
 
 	GSList *uuids;
 
@@ -263,7 +264,12 @@ static void store_device_info(struct device *dev, const char *path)
 	else
 		g_key_file_remove_key(key_file, addr, "Class", NULL);
 
-	g_key_file_set_integer(key_file, addr, "Timestamp", dev->timestamp);
+	if (dev->bredr_seen > dev->le_seen)
+		g_key_file_set_integer(key_file, addr, "Timestamp",
+							dev->bredr_seen);
+	else
+		g_key_file_set_integer(key_file, addr, "Timestamp",
+								dev->le_seen);
 
 	if (dev->uuids) {
 		GSList *l;
@@ -374,7 +380,6 @@ static void cache_device(struct device *new_dev)
 
 cache:
 	cached_devices = g_slist_prepend(cached_devices, new_dev);
-	new_dev->timestamp = time(NULL);
 	store_device_info(new_dev, CACHE_FILE);
 }
 
@@ -392,13 +397,14 @@ static struct device *create_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type)
 
 	if (bdaddr_type == BDADDR_BREDR) {
 		dev->bredr = true;
+		dev->bredr_seen = time(NULL);
 	} else {
 		dev->le = true;
 		dev->bdaddr_type = bdaddr_type;
+		dev->le_seen = time(NULL);
 	}
 
 	dev->bond_state = HAL_BOND_STATE_NONE;
-	dev->timestamp = time(NULL);
 
 	/*
 	 * Use address for name, will be change if one is present
@@ -1400,6 +1406,11 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 
 	dev = get_device(bdaddr, bdaddr_type);
 
+	if (bdaddr_type == BDADDR_BREDR)
+		dev->bredr_seen = time(NULL);
+	else
+		dev->le_seen = time(NULL);
+
 	/*
 	 * Device found event needs to be send also for known device if this is
 	 * new discovery session. Otherwise framework will ignore it.
@@ -2178,8 +2189,13 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 
 	dev->class = g_key_file_get_integer(key_file, peer, "Class", NULL);
 
-	dev->timestamp = g_key_file_get_integer(key_file, peer, "Timestamp",
-									NULL);
+	if (dev->bredr)
+		dev->bredr_seen = g_key_file_get_integer(key_file, peer,
+								"Timestamp",
+								NULL);
+	else
+		dev->le_seen = g_key_file_get_integer(key_file, peer,
+							"Timestamp", NULL);
 
 	uuids = g_key_file_get_string_list(key_file, peer, "Services", NULL,
 									NULL);
@@ -2279,12 +2295,27 @@ failed:
 	return info;
 }
 
+static time_t device_timestamp(const struct device *dev)
+{
+	if (dev->bredr && dev->le) {
+		if (dev->le_seen > dev->bredr_seen)
+			return dev->le_seen;
+
+		return dev->bredr_seen;
+	}
+
+	if (dev->bredr)
+		return dev->bredr_seen;
+
+	return dev->le_seen;
+}
+
 static int device_timestamp_cmp(gconstpointer  a, gconstpointer  b)
 {
 	const struct device *deva = a;
 	const struct device *devb = b;
 
-	return deva->timestamp < devb->timestamp;
+	return device_timestamp(deva) < device_timestamp(devb);
 }
 
 static void load_devices_cache(void)
@@ -3155,6 +3186,18 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 							HAL_BOND_STATE_NONE);
 }
 
+static uint8_t select_device_bearer(struct device *dev)
+{
+	if (dev->bredr && dev->le) {
+		if (dev->le_seen > dev->bredr_seen)
+			return dev->bdaddr_type;
+
+		return BDADDR_BREDR;
+	}
+
+	return dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
+}
+
 static void handle_create_bond_cmd(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_create_bond *cmd = buf;
@@ -3173,7 +3216,7 @@ static void handle_create_bond_cmd(const void *buf, uint16_t len)
 		goto fail;
 	}
 
-	cp.addr.type = dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
+	cp.addr.type = select_device_bearer(dev);
 
 	if (mgmt_send(mgmt_if, MGMT_OP_PAIR_DEVICE, adapter.index, sizeof(cp),
 				&cp, pair_device_complete, NULL, NULL) == 0) {
@@ -3205,8 +3248,7 @@ static void handle_cancel_bond_cmd(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cp.type = dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
-
+	cp.type = select_device_bearer(dev);
 
 	if (mgmt_reply(mgmt_if, MGMT_OP_CANCEL_PAIR_DEVICE,
 					adapter.index, sizeof(cp), &cp,
@@ -3256,7 +3298,7 @@ static void handle_remove_bond_cmd(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cp.addr.type = dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
+	cp.addr.type = select_device_bearer(dev);
 
 	if (mgmt_send(mgmt_if, MGMT_OP_UNPAIR_DEVICE, adapter.index,
 				sizeof(cp), &cp, unpair_device_complete,
@@ -3494,8 +3536,12 @@ static uint8_t get_device_version_info(struct device *dev)
 
 static uint8_t get_device_timestamp(struct device *dev)
 {
+	uint32_t timestamp;
+
+	timestamp = device_timestamp(dev);
+
 	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_TIMESTAMP,
-				sizeof(dev->timestamp), &dev->timestamp);
+						sizeof(timestamp), &timestamp);
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -3506,6 +3552,7 @@ static void get_remote_device_props(struct device *dev)
 	struct hal_ev_remote_device_props *ev = (void *) buf;
 	uint128_t uuids[g_slist_length(dev->uuids)];
 	uint8_t android_type;
+	uint32_t timestamp;
 	int size, i;
 	GSList *l;
 
@@ -3550,8 +3597,10 @@ static void get_remote_device_props(struct device *dev)
 									uuids);
 	ev->num_props++;
 
+	timestamp = get_device_timestamp(dev);
+
 	size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_TIMESTAMP,
-				sizeof(dev->timestamp), &dev->timestamp);
+						sizeof(timestamp), &timestamp);
 	ev->num_props++;
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
-- 
1.9.0


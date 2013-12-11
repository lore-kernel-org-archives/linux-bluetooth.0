Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 8/9] android/bluetooth: Add support for remote device type property
Date: Wed, 11 Dec 2013 11:31:26 +0100
Message-Id: <1386757887-29018-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
References: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes daemon store remote device address type to be able to handle
remote device type property.
---
 android/bluetooth.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index ffe1120..b139ff7 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -93,6 +93,7 @@ static struct {
 
 struct device {
 	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
 	int bond_state;
 	char *name;
 	char *friendly_name;
@@ -135,7 +136,7 @@ static struct device *find_device(const bdaddr_t *bdaddr)
 	return NULL;
 }
 
-static struct device *create_device(const bdaddr_t *bdaddr)
+static struct device *create_device(const bdaddr_t *bdaddr, uint8_t type)
 {
 	struct device *dev;
 	char addr[18];
@@ -146,6 +147,7 @@ static struct device *create_device(const bdaddr_t *bdaddr)
 	dev = g_new0(struct device, 1);
 
 	bacpy(&dev->bdaddr, bdaddr);
+	dev->bdaddr_type = type;
 	dev->bond_state = HAL_BOND_STATE_NONE;
 
 	/* use address for name, will be change if one is present
@@ -163,7 +165,7 @@ static void free_device(struct device *dev)
 	g_free(dev);
 }
 
-static struct device *get_device(const bdaddr_t *bdaddr)
+static struct device *get_device(const bdaddr_t *bdaddr, uint8_t type)
 {
 	struct device *dev;
 
@@ -171,7 +173,7 @@ static struct device *get_device(const bdaddr_t *bdaddr)
 	if (dev)
 		return dev;
 
-	return create_device(bdaddr);
+	return create_device(bdaddr, type);
 }
 
 static  void send_adapter_property(uint8_t type, uint16_t len, const void *val)
@@ -369,7 +371,9 @@ static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
 
 	struct device *dev;
 
-	dev = get_device(addr);
+	dev = find_device(addr);
+	if (!dev)
+		return;
 
 	if (dev->bond_state != state) {
 		dev->bond_state = state;
@@ -606,7 +610,7 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 
 	ba2str(&ev->addr.bdaddr, dst);
 
-	dev = get_device(&ev->addr.bdaddr);
+	dev = get_device(&ev->addr.bdaddr, BDADDR_BREDR);
 
 	/* Workaround for Android Bluetooth.apk issue: send remote
 	 * device property */
@@ -769,6 +773,14 @@ static int fill_hal_prop(void *buf, uint8_t type, uint16_t len,
 	return sizeof(*prop) + len;
 }
 
+static uint8_t bdaddr_type2android(uint8_t type)
+{
+	if (type == BDADDR_BREDR)
+		return HAL_TYPE_BREDR;
+
+	return HAL_TYPE_LE;
+}
+
 static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, bool confirm,
 					const uint8_t *data, uint8_t data_len)
@@ -789,8 +801,9 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 	if (!dev) {
 		struct hal_ev_device_found *ev = (void *) buf;
 		bdaddr_t android_bdaddr;
+		uint8_t android_type;
 
-		dev = create_device(bdaddr);
+		dev = create_device(bdaddr, bdaddr_type);
 
 		size += sizeof(*ev);
 
@@ -802,6 +815,11 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_ADDR,
 				sizeof(android_bdaddr), &android_bdaddr);
 		(*num_prop)++;
+
+		android_type = bdaddr_type2android(dev->bdaddr_type);
+		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_TYPE,
+					sizeof(android_type), &android_type);
+		(*num_prop)++;
 	} else {
 		struct hal_ev_remote_device_props *ev = (void *) buf;
 
@@ -2280,11 +2298,12 @@ static uint8_t get_device_class(struct device *dev)
 
 static uint8_t get_device_type(struct device *dev)
 {
-	DBG("Not implemented");
+	uint8_t type = bdaddr_type2android(dev->bdaddr_type);
 
-	/* TODO */
+	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_TYPE,
+							sizeof(type), &type);
 
-	return HAL_STATUS_FAILED;
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t get_device_service_rec(struct device *dev)
-- 
1.8.3.2


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 5/5] android/bluetooth: Fix handling of BREDR, LE and dual mode devices
Date: Sun, 23 Mar 2014 22:40:54 +0100
Message-Id: <1395610854-30579-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1395610854-30579-1-git-send-email-szymon.janc@tieto.com>
References: <1395610854-30579-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This includes fix for storage format so that dual mode devices are
handled correctly. Unfortunatelly this change is not backward
compatible so wiping out /data/misc/bluetooth/ is recommended.

Also correct device type is passed to bonding commands. For create_bond
we fallback to BDEDR if device is not known. This can happen eg. with
OOB. For cancel_bond and remove_bond we require device to be known.
For dual mode device currently only BREDR type is used.

Storage change details:
Instead of storing bdaddr type of device as "Type", now two variables
are used. Boolean "BREDR" if device supports BREDR. Address type is
stored in "AddressType" only if device supports LE and is either
LE random or LE public type.
---
 android/bluetooth.c | 126 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 104 insertions(+), 22 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 5db5515..73e7ac2 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -93,6 +93,9 @@ struct device {
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
 
+	bool le;
+	bool bredr;
+
 	int bond_state;
 
 	char *name;
@@ -240,7 +243,11 @@ static void store_device_info(struct device *dev, const char *path)
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, path, 0, NULL);
 
-	g_key_file_set_integer(key_file, addr, "Type", dev->bdaddr_type);
+	g_key_file_set_boolean(key_file, addr, "BREDR", dev->bredr);
+
+	if (dev->le)
+		g_key_file_set_integer(key_file, addr, "AddressType",
+							dev->bdaddr_type);
 
 	g_key_file_set_string(key_file, addr, "Name", dev->name);
 
@@ -370,7 +377,7 @@ cache:
 	store_device_info(new_dev, CACHE_FILE);
 }
 
-static struct device *create_device(const bdaddr_t *bdaddr, uint8_t type)
+static struct device *create_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type)
 {
 	struct device *dev;
 	char addr[18];
@@ -381,7 +388,14 @@ static struct device *create_device(const bdaddr_t *bdaddr, uint8_t type)
 	dev = g_new0(struct device, 1);
 
 	bacpy(&dev->bdaddr, bdaddr);
-	dev->bdaddr_type = type;
+
+	if (bdaddr_type == BDADDR_BREDR) {
+		dev->bredr = true;
+	} else {
+		dev->le = true;
+		dev->bdaddr_type = bdaddr_type;
+	}
+
 	dev->bond_state = HAL_BOND_STATE_NONE;
 	dev->timestamp = time(NULL);
 
@@ -1151,12 +1165,15 @@ static int fill_hal_prop(void *buf, uint8_t type, uint16_t len,
 	return sizeof(*prop) + len;
 }
 
-static uint8_t bdaddr_type2android(uint8_t type)
+static uint8_t get_device_android_type(struct device *dev)
 {
-	if (type == BDADDR_BREDR)
-		return HAL_TYPE_BREDR;
+	if (dev->bredr && dev->le)
+		return HAL_TYPE_DUAL;
 
-	return HAL_TYPE_LE;
+	if (dev->le)
+		return HAL_TYPE_LE;
+
+	return HAL_TYPE_BREDR;
 }
 
 static bool rssi_above_threshold(int old, int new)
@@ -1187,7 +1204,7 @@ static void update_new_device(struct device *dev, int8_t rssi,
 						&android_bdaddr);
 	ev->num_props++;
 
-	android_type = bdaddr_type2android(dev->bdaddr_type);
+	android_type = get_device_android_type(dev);
 	size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_TYPE,
 				sizeof(android_type), &android_type);
 	ev->num_props++;
@@ -1219,10 +1236,11 @@ static void update_new_device(struct device *dev, int8_t rssi,
 }
 
 static void update_device(struct device *dev, int8_t rssi,
-						const struct eir_data *eir)
+				const struct eir_data *eir, uint8_t bdaddr_type)
 {
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_remote_device_props *ev = (void *) buf;
+	uint8_t android_type;
 	int size;
 
 	memset(buf, 0, sizeof(buf));
@@ -1232,6 +1250,27 @@ static void update_device(struct device *dev, int8_t rssi,
 	ev->status = HAL_STATUS_SUCCESS;
 	bdaddr2android(&dev->bdaddr, ev->bdaddr);
 
+	if (dev->bdaddr_type != bdaddr_type) {
+		bool type_changed = false;
+
+		dev->bdaddr_type = bdaddr_type;
+		if (bdaddr_type == BDADDR_BREDR) {
+			type_changed = !dev->bredr;
+			dev->bredr = true;
+		} else {
+			type_changed = !dev->le;
+			dev->le = true;
+		}
+
+		if (type_changed) {
+			android_type = get_device_android_type(dev);
+			size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_TYPE,
+							sizeof(android_type),
+							&android_type);
+			ev->num_props++;
+		}
+	}
+
 	if (eir->class && dev->class != eir->class) {
 		dev->class = eir->class;
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_CLASS,
@@ -1299,7 +1338,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 
 		update_new_device(dev, rssi, &eir);
 	} else {
-		update_device(dev, rssi, &eir);
+		update_device(dev, rssi, &eir, bdaddr_type);
 	}
 
 	eir_data_free(&eir);
@@ -2001,11 +2040,16 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 
 	DBG("%s", peer);
 
-	type = g_key_file_get_integer(key_file, peer, "Type", NULL);
+	/* BREDR if not present */
+	type = g_key_file_get_integer(key_file, peer, "AddressType", NULL);
 
 	str2ba(peer, &bdaddr);
 	dev = create_device(&bdaddr, type);
 
+	if (type != BDADDR_BREDR)
+		dev->bredr = g_key_file_get_boolean(key_file, peer, "BREDR",
+									NULL);
+
 	str = g_key_file_get_string(key_file, peer, "LinkKey", NULL);
 	if (str) {
 		g_free(str);
@@ -2901,13 +2945,27 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 static void handle_create_bond_cmd(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_create_bond *cmd = buf;
+	struct device *dev;
 	uint8_t status;
 	struct mgmt_cp_pair_device cp;
 
 	cp.io_cap = DEFAULT_IO_CAPABILITY;
-	cp.addr.type = BDADDR_BREDR;
 	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
 
+	dev = find_device(&cp.addr.bdaddr);
+
+	if (dev) {
+		if (dev->bond_state != HAL_BOND_STATE_NONE) {
+			status = HAL_STATUS_FAILED;
+			goto fail;
+		}
+
+		cp.addr.type = dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
+	} else {
+		/* Fallback to BREDR if device is unknown eg. OOB */
+		cp.addr.type = BDADDR_BREDR;
+	}
+
 	if (mgmt_send(mgmt_if, MGMT_OP_PAIR_DEVICE, adapter.index, sizeof(cp),
 				&cp, pair_device_complete, NULL, NULL) == 0) {
 		status = HAL_STATUS_FAILED;
@@ -2928,17 +2986,30 @@ static void handle_cancel_bond_cmd(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_cancel_bond *cmd = buf;
 	struct mgmt_addr_info cp;
+	struct device *dev;
 	uint8_t status;
 
-	cp.type = BDADDR_BREDR;
 	android2bdaddr(cmd->bdaddr, &cp.bdaddr);
 
-	if (mgmt_reply(mgmt_if, MGMT_OP_CANCEL_PAIR_DEVICE, adapter.index,
-					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
-		status = HAL_STATUS_SUCCESS;
-	else
+	dev = find_device(&cp.bdaddr);
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	cp.type = dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
+
+
+	if (mgmt_reply(mgmt_if, MGMT_OP_CANCEL_PAIR_DEVICE,
+					adapter.index, sizeof(cp), &cp,
+					NULL, NULL, NULL) == 0) {
 		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	status = HAL_STATUS_SUCCESS;
 
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CANCEL_BOND,
 									status);
 }
@@ -2961,19 +3032,30 @@ static void handle_remove_bond_cmd(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_remove_bond *cmd = buf;
 	struct mgmt_cp_unpair_device cp;
+	struct device *dev;
 	uint8_t status;
 
 	cp.disconnect = 1;
-	cp.addr.type = BDADDR_BREDR;
 	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
 
+	dev = find_device(&cp.addr.bdaddr);
+	if (!dev) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	cp.addr.type = dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
+
 	if (mgmt_send(mgmt_if, MGMT_OP_UNPAIR_DEVICE, adapter.index,
 				sizeof(cp), &cp, unpair_device_complete,
-				NULL, NULL) > 0)
-		status = HAL_STATUS_SUCCESS;
-	else
+				NULL, NULL) ==  0) {
 		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_REMOVE_BOND,
 									status);
 }
@@ -3150,7 +3232,7 @@ static uint8_t get_device_class(struct device *dev)
 
 static uint8_t get_device_type(struct device *dev)
 {
-	uint8_t type = bdaddr_type2android(dev->bdaddr_type);
+	uint8_t type = get_device_android_type(dev);
 
 	send_device_property(&dev->bdaddr, HAL_PROP_DEVICE_TYPE,
 							sizeof(type), &type);
-- 
1.8.5.3


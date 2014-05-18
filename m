Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] android/bluetooth: Fix pairing of dual mode devices
Date: Sun, 18 May 2014 13:53:57 +0200
Message-Id: <1400414040-30913-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400414040-30913-1-git-send-email-szymon.janc@tieto.com>
References: <1400414040-30913-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is possible that dual mode device is paired both for LE and BR/EDR
link. This patch add tracking of this.

Due to HAL API contraints second pairing will result in following bond
state changed events:
bonded -> bonding (success) -> bonded (success/failed)
---
 android/bluetooth.c | 172 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 124 insertions(+), 48 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index bf562bc..6743b81 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -96,7 +96,10 @@ struct device {
 	bool le;
 	bool bredr;
 
-	int bond_state;
+	bool pairing;
+
+	bool bredr_paired;
+	bool le_paired;
 
 	char *name;
 	char *friendly_name;
@@ -404,8 +407,6 @@ static struct device *create_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type)
 		dev->le_seen = time(NULL);
 	}
 
-	dev->bond_state = HAL_BOND_STATE_NONE;
-
 	/*
 	 * Use address for name, will be change if one is present
 	 * eg. in EIR or set by set_property.
@@ -648,34 +649,93 @@ static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 				HAL_EV_BOND_STATE_CHANGED, sizeof(ev), &ev);
 }
 
-static void set_device_bond_state(struct device *dev, uint8_t status,
-								int state)
+static void update_bredr_state(struct device *dev, bool pairing, bool paired)
 {
-	if (dev->bond_state == state)
+	if (pairing == dev->pairing && paired == dev->bredr_paired)
 		return;
 
-	switch (state) {
-	case HAL_BOND_STATE_NONE:
-		if (dev->bond_state == HAL_BOND_STATE_BONDED) {
-			bonded_devices = g_slist_remove(bonded_devices, dev);
-			remove_device_info(dev, DEVICES_FILE);
-			cache_device(dev);
-		}
-		break;
-	case HAL_BOND_STATE_BONDED:
+	/* avoid unpairing device on incoming pairing request */
+	if (pairing && dev->bredr_paired)
+		goto done;
+
+	/* avoid unpairing device if pairing failed */
+	if (!pairing && !paired && dev->pairing && dev->bredr_paired)
+		goto done;
+
+	if (paired && !dev->le_paired) {
 		cached_devices = g_slist_remove(cached_devices, dev);
 		bonded_devices = g_slist_prepend(bonded_devices, dev);
 		remove_device_info(dev, CACHE_FILE);
 		store_device_info(dev, DEVICES_FILE);
-		break;
-	case HAL_BOND_STATE_BONDING:
-	default:
-		break;
+	} else if (!paired && !dev->le_paired) {
+		bonded_devices = g_slist_remove(bonded_devices, dev);
+		remove_device_info(dev, DEVICES_FILE);
+		cache_device(dev);
+	}
+
+	dev->bredr_paired = paired;
+
+done:
+	dev->pairing = pairing;
+}
+
+static void update_le_state(struct device *dev, bool pairing, bool paired)
+{
+	if (pairing == dev->pairing && paired == dev->le_paired)
+		return;
+
+	/* avoid unpairing device on incoming pairing request */
+	if (pairing && dev->le_paired)
+		goto done;
+
+	/* avoid unpairing device if pairing failed */
+	if (!pairing && !paired && dev->pairing && dev->le_paired)
+		goto done;
+
+	if (paired && !dev->bredr_paired) {
+		cached_devices = g_slist_remove(cached_devices, dev);
+		bonded_devices = g_slist_prepend(bonded_devices, dev);
+		remove_device_info(dev, CACHE_FILE);
+		store_device_info(dev, DEVICES_FILE);
+	} else if (!paired && !dev->bredr_paired) {
+		bonded_devices = g_slist_remove(bonded_devices, dev);
+		remove_device_info(dev, DEVICES_FILE);
+		cache_device(dev);
 	}
 
-	dev->bond_state = state;
+	dev->le_paired = paired;
+
+done:
+	dev->pairing = pairing;
+}
+
+static uint8_t device_bond_state(struct device *dev)
+{
+	if (dev->pairing)
+		return HAL_BOND_STATE_BONDING;
+
+	if (dev->bredr_paired || dev->le_paired)
+		return HAL_BOND_STATE_BONDED;
+
+	return HAL_BOND_STATE_NONE;
+}
+
+static void update_device_state(struct device *dev, uint8_t addr_type,
+				uint8_t status, bool pairing, bool paired)
+{
+	uint8_t old_bond, new_bond;
+
+	old_bond = device_bond_state(dev);
+
+	if (addr_type == BDADDR_BREDR)
+		update_bredr_state(dev, pairing, paired);
+	else
+		update_le_state(dev, pairing, paired);
 
-	send_bond_state_change(&dev->bdaddr, status, state);
+	new_bond = device_bond_state(dev);
+
+	if (old_bond != new_bond)
+		send_bond_state_change(&dev->bdaddr, status, new_bond);
 }
 
 static  void send_device_property(const bdaddr_t *bdaddr, uint8_t type,
@@ -715,7 +775,7 @@ static void set_device_uuids(struct device *dev, GSList *uuids)
 	g_slist_free_full(dev->uuids, g_free);
 	dev->uuids = uuids;
 
-	if (dev->bond_state == HAL_BOND_STATE_BONDED)
+	if (dev->le_paired || dev->bredr_paired)
 		store_device_info(dev, DEVICES_FILE);
 	else
 		store_device_info(dev, CACHE_FILE);
@@ -882,7 +942,8 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 	if (!dev)
 		return;
 
-	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDED);
+	update_device_state(dev, ev->key.addr.type, HAL_STATUS_SUCCESS, false,
+									true);
 
 	if (ev->store_hint) {
 		const struct mgmt_link_key_info *key = &ev->key;
@@ -925,7 +986,8 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	 */
 	get_device_name(dev);
 
-	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDING);
+	update_device_state(dev, ev->addr.type, HAL_STATUS_SUCCESS, true,
+									false);
 
 	DBG("%s type %u secure %u", dst, ev->addr.type, ev->secure);
 
@@ -973,7 +1035,8 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 	if (!dev)
 		return;
 
-	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDING);
+	update_device_state(dev, ev->addr.type, HAL_STATUS_SUCCESS, true,
+									false);
 
 	if (ev->confirm_hint)
 		send_ssp_request(dev, HAL_SSP_VARIANT_CONSENT, 0);
@@ -1000,7 +1063,8 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 	if (!dev)
 		return;
 
-	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDING);
+	update_device_state(dev, ev->addr.type, HAL_STATUS_SUCCESS, true,
+									false);
 
 	send_ssp_request(dev, HAL_SSP_VARIANT_ENTRY, 0);
 }
@@ -1029,7 +1093,8 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 	if (!dev)
 		return;
 
-	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDING);
+	update_device_state(dev, ev->addr.type, HAL_STATUS_SUCCESS, true,
+									false);
 
 	send_ssp_request(dev, HAL_SSP_VARIANT_NOTIF, ev->passkey);
 }
@@ -1383,7 +1448,7 @@ static bool is_new_device(const struct device *dev, unsigned int flags)
 	if (dev->found)
 		return false;
 
-	if (dev->bond_state == HAL_BOND_STATE_BONDED)
+	if (dev->bredr_paired || dev->le_paired)
 		return false;
 
 	if (dev->bdaddr_type != BDADDR_BREDR &&
@@ -1432,7 +1497,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 								discoverable);
 	}
 
-	if (dev->bond_state != HAL_BOND_STATE_BONDED)
+	if (!dev->bredr_paired && !dev->le_paired)
 		cache_device(dev);
 
 	if (confirm) {
@@ -1583,11 +1648,11 @@ static void mgmt_connect_failed_event(uint16_t index, uint16_t length,
 	 * bonding, if so update bond state
 	 */
 
-	if (dev->bond_state != HAL_BOND_STATE_BONDING)
+	if (!dev->pairing)
 		return;
 
-	set_device_bond_state(dev, status_mgmt2hal(ev->status),
-							HAL_BOND_STATE_NONE);
+	update_device_state(dev, ev->addr.type, status_mgmt2hal(ev->status),
+								false, false);
 }
 
 static void mgmt_auth_failed_event(uint16_t index, uint16_t length,
@@ -1607,11 +1672,11 @@ static void mgmt_auth_failed_event(uint16_t index, uint16_t length,
 	if (!dev)
 		return;
 
-	if (dev->bond_state != HAL_BOND_STATE_BONDING)
+	if (!dev->pairing)
 		return;
 
-	set_device_bond_state(dev, status_mgmt2hal(ev->status),
-							HAL_BOND_STATE_NONE);
+	update_device_state(dev, ev->addr.type, status_mgmt2hal(ev->status),
+								false, false);
 }
 
 static void mgmt_device_unpaired_event(uint16_t index, uint16_t length,
@@ -1633,7 +1698,8 @@ static void mgmt_device_unpaired_event(uint16_t index, uint16_t length,
 	if (!dev)
 		return;
 
-	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_NONE);
+	update_device_state(dev, ev->addr.type, HAL_STATUS_SUCCESS, false,
+									false);
 }
 
 static void store_ltk(const bdaddr_t *dst, uint8_t bdaddr_type, bool master,
@@ -1703,7 +1769,8 @@ static void new_long_term_key_event(uint16_t index, uint16_t length,
 	if (!dev)
 		return;
 
-	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDED);
+	update_device_state(dev, ev->key.addr.type, HAL_STATUS_SUCCESS, false,
+									true);
 
 	if (ev->store_hint) {
 		const struct mgmt_ltk_info *key = &ev->key;
@@ -2160,19 +2227,19 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 	str = g_key_file_get_string(key_file, peer, "LinkKey", NULL);
 	if (str) {
 		g_free(str);
-		dev->bond_state = HAL_BOND_STATE_BONDED;
+		dev->bredr_paired = true;
 	}
 
 	str = g_key_file_get_string(key_file, peer, "LongTermKey", NULL);
 	if (str) {
 		g_free(str);
-		dev->bond_state = HAL_BOND_STATE_BONDED;
+		dev->le_paired = true;
 	}
 
 	str = g_key_file_get_string(key_file, peer, "SlaveLongTermKey", NULL);
 	if (str) {
 		g_free(str);
-		dev->bond_state = HAL_BOND_STATE_BONDED;
+		dev->le_paired = true;
 	}
 
 	str = g_key_file_get_string(key_file, peer, "Name", NULL);
@@ -3182,8 +3249,8 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 	if (!dev)
 		return;
 
-	set_device_bond_state(dev, status_mgmt2hal(status),
-							HAL_BOND_STATE_NONE);
+	update_device_state(dev, rp->addr.type, status_mgmt2hal(status), false,
+									false);
 }
 
 static uint8_t select_device_bearer(struct device *dev)
@@ -3198,6 +3265,14 @@ static uint8_t select_device_bearer(struct device *dev)
 	return dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
 }
 
+static bool device_is_paired(struct device *dev, uint8_t addr_type)
+{
+	if (addr_type == BDADDR_BREDR)
+		return dev->bredr_paired;
+
+	return dev->le_paired;
+}
+
 static void handle_create_bond_cmd(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_create_bond *cmd = buf;
@@ -3211,13 +3286,13 @@ static void handle_create_bond_cmd(const void *buf, uint16_t len)
 	/* type is used only as fallback when device is not in cache */
 	dev = get_device(&cp.addr.bdaddr, BDADDR_BREDR);
 
-	if (dev->bond_state != HAL_BOND_STATE_NONE) {
+	cp.addr.type = select_device_bearer(dev);
+
+	if (device_is_paired(dev, cp.addr.type)) {
 		status = HAL_STATUS_FAILED;
 		goto fail;
 	}
 
-	cp.addr.type = select_device_bearer(dev);
-
 	if (mgmt_send(mgmt_if, MGMT_OP_PAIR_DEVICE, adapter.index, sizeof(cp),
 				&cp, pair_device_complete, NULL, NULL) == 0) {
 		status = HAL_STATUS_FAILED;
@@ -3226,7 +3301,7 @@ static void handle_create_bond_cmd(const void *buf, uint16_t len)
 
 	status = HAL_STATUS_SUCCESS;
 
-	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDING);
+	update_device_state(dev, cp.addr.type, HAL_STATUS_SUCCESS, true, false);
 
 fail:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CREATE_BOND,
@@ -3279,7 +3354,8 @@ static void unpair_device_complete(uint8_t status, uint16_t length,
 	if (!dev)
 		return;
 
-	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_NONE);
+	update_device_state(dev, rp->addr.type, HAL_STATUS_SUCCESS, false,
+									false);
 }
 
 static void handle_remove_bond_cmd(const void *buf, uint16_t len)
@@ -3765,7 +3841,7 @@ static uint8_t set_device_friendly_name(struct device *dev, const uint8_t *val,
 	g_free(dev->friendly_name);
 	dev->friendly_name = g_strndup((const char *) val, len);
 
-	if (dev->bond_state == HAL_BOND_STATE_BONDED)
+	if (dev->bredr_paired || dev->le_paired)
 		store_device_info(dev, DEVICES_FILE);
 	else
 		store_device_info(dev, CACHE_FILE);
-- 
1.9.0


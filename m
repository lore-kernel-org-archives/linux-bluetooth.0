Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] android/bluetooth: Track if paired device is bonded
Date: Sun, 18 May 2014 13:53:59 +0200
Message-Id: <1400414040-30913-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400414040-30913-1-git-send-email-szymon.janc@tieto.com>
References: <1400414040-30913-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a preparation for correctly handling no bond pairing.

Currently paired but not bonded devices are left on list of bonded
devices in Framework until BT is restarted on device. This is due to
Android Framework is not allowing stack to unpair device by its own
(setting bond state bonded->no_bond is ignored).
---
 android/bluetooth.c | 55 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 29c4ab6..5163291 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -99,7 +99,9 @@ struct device {
 	bool pairing;
 
 	bool bredr_paired;
+	bool bredr_bonded;
 	bool le_paired;
+	bool le_bonded;
 
 	char *name;
 	char *friendly_name;
@@ -649,9 +651,11 @@ static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 				HAL_EV_BOND_STATE_CHANGED, sizeof(ev), &ev);
 }
 
-static void update_bredr_state(struct device *dev, bool pairing, bool paired)
+static void update_bredr_state(struct device *dev, bool pairing, bool paired,
+								bool bonded)
 {
-	if (pairing == dev->pairing && paired == dev->bredr_paired)
+	if (pairing == dev->pairing && paired == dev->bredr_paired &&
+						bonded == dev->bredr_bonded)
 		return;
 
 	/* avoid unpairing device on incoming pairing request */
@@ -674,14 +678,17 @@ static void update_bredr_state(struct device *dev, bool pairing, bool paired)
 	}
 
 	dev->bredr_paired = paired;
+	dev->bredr_bonded = bonded;
 
 done:
 	dev->pairing = pairing;
 }
 
-static void update_le_state(struct device *dev, bool pairing, bool paired)
+static void update_le_state(struct device *dev, bool pairing, bool paired,
+								bool bonded)
 {
-	if (pairing == dev->pairing && paired == dev->le_paired)
+	if (pairing == dev->pairing && paired == dev->le_paired &&
+						bonded == dev->le_bonded)
 		return;
 
 	/* avoid unpairing device on incoming pairing request */
@@ -704,6 +711,7 @@ static void update_le_state(struct device *dev, bool pairing, bool paired)
 	}
 
 	dev->le_paired = paired;
+	dev->le_bonded = bonded;
 
 done:
 	dev->pairing = pairing;
@@ -714,6 +722,10 @@ static uint8_t device_bond_state(struct device *dev)
 	if (dev->pairing)
 		return HAL_BOND_STATE_BONDING;
 
+	/*
+	 * We are checking for paired here instead of bonded as HAL API is
+	 * using BOND state also if there was no bonding pairing.
+	 */
 	if (dev->bredr_paired || dev->le_paired)
 		return HAL_BOND_STATE_BONDED;
 
@@ -721,16 +733,17 @@ static uint8_t device_bond_state(struct device *dev)
 }
 
 static void update_device_state(struct device *dev, uint8_t addr_type,
-				uint8_t status, bool pairing, bool paired)
+				uint8_t status, bool pairing, bool paired,
+				bool bonded)
 {
 	uint8_t old_bond, new_bond;
 
 	old_bond = device_bond_state(dev);
 
 	if (addr_type == BDADDR_BREDR)
-		update_bredr_state(dev, pairing, paired);
+		update_bredr_state(dev, pairing, paired, bonded);
 	else
-		update_le_state(dev, pairing, paired);
+		update_le_state(dev, pairing, paired, bonded);
 
 	new_bond = device_bond_state(dev);
 
@@ -943,7 +956,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 		return;
 
 	update_device_state(dev, ev->key.addr.type, HAL_STATUS_SUCCESS, false,
-									true);
+							true, !!ev->store_hint);
 
 	if (ev->store_hint) {
 		const struct mgmt_link_key_info *key = &ev->key;
@@ -987,7 +1000,7 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	get_device_name(dev);
 
 	update_device_state(dev, ev->addr.type, HAL_STATUS_SUCCESS, true,
-									false);
+								false, false);
 
 	DBG("%s type %u secure %u", dst, ev->addr.type, ev->secure);
 
@@ -1036,7 +1049,7 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 		return;
 
 	update_device_state(dev, ev->addr.type, HAL_STATUS_SUCCESS, true,
-									false);
+								false, false);
 
 	if (ev->confirm_hint)
 		send_ssp_request(dev, HAL_SSP_VARIANT_CONSENT, 0);
@@ -1064,7 +1077,7 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 		return;
 
 	update_device_state(dev, ev->addr.type, HAL_STATUS_SUCCESS, true,
-									false);
+								false, false);
 
 	send_ssp_request(dev, HAL_SSP_VARIANT_ENTRY, 0);
 }
@@ -1094,7 +1107,7 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 		return;
 
 	update_device_state(dev, ev->addr.type, HAL_STATUS_SUCCESS, true,
-									false);
+								false, false);
 
 	send_ssp_request(dev, HAL_SSP_VARIANT_NOTIF, ev->passkey);
 }
@@ -1652,7 +1665,7 @@ static void mgmt_connect_failed_event(uint16_t index, uint16_t length,
 		return;
 
 	update_device_state(dev, ev->addr.type, status_mgmt2hal(ev->status),
-								false, false);
+							false, false, false);
 }
 
 static void mgmt_auth_failed_event(uint16_t index, uint16_t length,
@@ -1676,7 +1689,7 @@ static void mgmt_auth_failed_event(uint16_t index, uint16_t length,
 		return;
 
 	update_device_state(dev, ev->addr.type, status_mgmt2hal(ev->status),
-								false, false);
+							false, false, false);
 }
 
 static void mgmt_device_unpaired_event(uint16_t index, uint16_t length,
@@ -1699,7 +1712,7 @@ static void mgmt_device_unpaired_event(uint16_t index, uint16_t length,
 		return;
 
 	update_device_state(dev, ev->addr.type, HAL_STATUS_SUCCESS, false,
-									false);
+								false, false);
 }
 
 static void store_ltk(const bdaddr_t *dst, uint8_t bdaddr_type, bool master,
@@ -1770,7 +1783,7 @@ static void new_long_term_key_event(uint16_t index, uint16_t length,
 		return;
 
 	update_device_state(dev, ev->key.addr.type, HAL_STATUS_SUCCESS, false,
-									true);
+							true, !!ev->store_hint);
 
 	if (ev->store_hint) {
 		const struct mgmt_ltk_info *key = &ev->key;
@@ -2228,18 +2241,21 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 	if (str) {
 		g_free(str);
 		dev->bredr_paired = true;
+		dev->bredr_bonded = true;
 	}
 
 	str = g_key_file_get_string(key_file, peer, "LongTermKey", NULL);
 	if (str) {
 		g_free(str);
 		dev->le_paired = true;
+		dev->le_bonded = true;
 	}
 
 	str = g_key_file_get_string(key_file, peer, "SlaveLongTermKey", NULL);
 	if (str) {
 		g_free(str);
 		dev->le_paired = true;
+		dev->le_bonded = true;
 	}
 
 	str = g_key_file_get_string(key_file, peer, "Name", NULL);
@@ -3250,7 +3266,7 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 		return;
 
 	update_device_state(dev, rp->addr.type, status_mgmt2hal(status), false,
-									false);
+								false, false);
 }
 
 static uint8_t select_device_bearer(struct device *dev)
@@ -3301,7 +3317,8 @@ static void handle_create_bond_cmd(const void *buf, uint16_t len)
 
 	status = HAL_STATUS_SUCCESS;
 
-	update_device_state(dev, cp.addr.type, HAL_STATUS_SUCCESS, true, false);
+	update_device_state(dev, cp.addr.type, HAL_STATUS_SUCCESS, true, false,
+									false);
 
 fail:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CREATE_BOND,
@@ -3355,7 +3372,7 @@ static void unpair_device_complete(uint8_t status, uint16_t length,
 		return;
 
 	update_device_state(dev, rp->addr.type, HAL_STATUS_SUCCESS, false,
-									false);
+								false, false);
 }
 
 static void handle_remove_bond_cmd(const void *buf, uint16_t len)
-- 
1.9.0


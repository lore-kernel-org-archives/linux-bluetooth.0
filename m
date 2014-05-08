Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android/bluetooth: Pass device to set_device_bond_state
Date: Thu,  8 May 2014 15:26:01 +0200
Message-Id: <1399555563-21054-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is in preparation for always having device object present when
handling events.
---
 android/bluetooth.c | 104 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 68 insertions(+), 36 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 2bc79e2..4eb5e2f 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -643,15 +643,9 @@ static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 				HAL_EV_BOND_STATE_CHANGED, sizeof(ev), &ev);
 }
 
-static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
+static void set_device_bond_state(struct device *dev, uint8_t status,
 								int state)
 {
-	struct device *dev;
-
-	dev = find_device(addr);
-	if (!dev)
-		return;
-
 	if (dev->bond_state == state)
 		return;
 
@@ -860,6 +854,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 {
 	const struct mgmt_ev_new_link_key *ev = param;
 	const struct mgmt_addr_info *addr = &ev->key.addr;
+	struct device *dev;
 	char dst[18];
 
 	if (length < sizeof(*ev)) {
@@ -878,8 +873,11 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	set_device_bond_state(&addr->bdaddr, HAL_STATUS_SUCCESS,
-							HAL_BOND_STATE_BONDED);
+	dev = find_device(&ev->key.addr.bdaddr);
+	if (!dev)
+		return;
+
+	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDED);
 
 	if (ev->store_hint) {
 		const struct mgmt_link_key_info *key = &ev->key;
@@ -922,8 +920,7 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	 */
 	get_device_name(dev);
 
-	set_device_bond_state(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
-						HAL_BOND_STATE_BONDING);
+	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDING);
 
 	DBG("%s type %u secure %u", dst, ev->addr.type, ev->secure);
 
@@ -959,6 +956,7 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_ev_user_confirm_request *ev = param;
+	struct device *dev;
 	char dst[18];
 
 	if (length < sizeof(*ev)) {
@@ -969,8 +967,11 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, dst);
 	DBG("%s confirm_hint %u", dst, ev->confirm_hint);
 
-	set_device_bond_state(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
-						HAL_BOND_STATE_BONDING);
+	dev = find_device(&ev->addr.bdaddr);
+	if (!dev)
+		return;
+
+	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDING);
 
 	if (ev->confirm_hint)
 		send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_CONSENT, 0);
@@ -983,6 +984,7 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_ev_user_passkey_request *ev = param;
+	struct device *dev;
 	char dst[18];
 
 	if (length < sizeof(*ev)) {
@@ -993,8 +995,11 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, dst);
 	DBG("%s", dst);
 
-	set_device_bond_state(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
-						HAL_BOND_STATE_BONDING);
+	dev = find_device(&ev->addr.bdaddr);
+	if (!dev)
+		return;
+
+	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDING);
 
 	send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_ENTRY, 0);
 }
@@ -1004,6 +1009,7 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 							void *user_data)
 {
 	const struct mgmt_ev_passkey_notify *ev = param;
+	struct device *dev;
 	char dst[18];
 
 	if (length < sizeof(*ev)) {
@@ -1018,8 +1024,11 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 	if (ev->entered)
 		return;
 
-	set_device_bond_state(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
-						HAL_BOND_STATE_BONDING);
+	dev = find_device(&ev->addr.bdaddr);
+	if (!dev)
+		return;
+
+	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDING);
 
 	send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_NOTIF, ev->passkey);
 }
@@ -1551,6 +1560,8 @@ static void mgmt_connect_failed_event(uint16_t index, uint16_t length,
 	DBG("");
 
 	dev = find_device(&ev->addr.bdaddr);
+	if (!dev)
+		return;
 
 	/*
 	 * In case security mode 3 pairing we will get connect failed event
@@ -1558,10 +1569,11 @@ static void mgmt_connect_failed_event(uint16_t index, uint16_t length,
 	 * bonding, if so update bond state
 	 */
 
-	if (dev && dev->bond_state == HAL_BOND_STATE_BONDING)
-		set_device_bond_state(&ev->addr.bdaddr,
-						status_mgmt2hal(ev->status),
-						HAL_BOND_STATE_NONE);
+	if (dev->bond_state != HAL_BOND_STATE_BONDING)
+		return;
+
+	set_device_bond_state(dev, status_mgmt2hal(ev->status),
+							HAL_BOND_STATE_NONE);
 }
 
 static void mgmt_auth_failed_event(uint16_t index, uint16_t length,
@@ -1578,17 +1590,21 @@ static void mgmt_auth_failed_event(uint16_t index, uint16_t length,
 	DBG("");
 
 	dev = find_device(&ev->addr.bdaddr);
+	if (!dev)
+		return;
+
+	if (dev->bond_state != HAL_BOND_STATE_BONDING)
+		return;
 
-	if (dev && dev->bond_state == HAL_BOND_STATE_BONDING)
-		set_device_bond_state(&ev->addr.bdaddr,
-						status_mgmt2hal(ev->status),
-						HAL_BOND_STATE_NONE);
+	set_device_bond_state(dev, status_mgmt2hal(ev->status),
+							HAL_BOND_STATE_NONE);
 }
 
 static void mgmt_device_unpaired_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_ev_device_unpaired *ev = param;
+	struct device *dev;
 
 	if (length < sizeof(*ev)) {
 		error("Too small device unpaired event (%u bytes)", length);
@@ -1599,8 +1615,11 @@ static void mgmt_device_unpaired_event(uint16_t index, uint16_t length,
 
 	/* TODO should device be disconnected ? */
 
-	set_device_bond_state(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
-							HAL_BOND_STATE_NONE);
+	dev = find_device(&ev->addr.bdaddr);
+	if (!dev)
+		return;
+
+	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_NONE);
 }
 
 static void store_ltk(const bdaddr_t *dst, uint8_t bdaddr_type, bool master,
@@ -1653,7 +1672,7 @@ static void new_long_term_key_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_ev_new_long_term_key *ev = param;
-	const struct mgmt_addr_info *addr = &ev->key.addr;
+	struct device *dev;
 	char dst[18];
 
 	if (length < sizeof(*ev)) {
@@ -1661,13 +1680,16 @@ static void new_long_term_key_event(uint16_t index, uint16_t length,
 		return;
 	}
 
-	ba2str(&addr->bdaddr, dst);
+	ba2str(&ev->key.addr.bdaddr, dst);
 
 	DBG("new LTK for %s type %u enc_size %u store_hint %u",
 			dst, ev->key.type, ev->key.enc_size, ev->store_hint);
 
-	set_device_bond_state(&addr->bdaddr, HAL_STATUS_SUCCESS,
-							HAL_BOND_STATE_BONDED);
+	dev = find_device(&ev->key.addr.bdaddr);
+	if (!dev)
+		return;
+
+	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDED);
 
 	if (ev->store_hint) {
 		const struct mgmt_ltk_info *key = &ev->key;
@@ -3110,6 +3132,7 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_rp_pair_device *rp = param;
+	struct device *dev;
 
 	DBG("status %u", status);
 
@@ -3120,7 +3143,11 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 	if (status == MGMT_STATUS_SUCCESS)
 		return;
 
-	set_device_bond_state(&rp->addr.bdaddr, status_mgmt2hal(status),
+	dev = find_device(&rp->addr.bdaddr);
+	if (!dev)
+		return;
+
+	set_device_bond_state(dev, status_mgmt2hal(status),
 							HAL_BOND_STATE_NONE);
 }
 
@@ -3156,8 +3183,9 @@ static void handle_create_bond_cmd(const void *buf, uint16_t len)
 
 	status = HAL_STATUS_SUCCESS;
 
-	set_device_bond_state(&cp.addr.bdaddr, HAL_STATUS_SUCCESS,
-						HAL_BOND_STATE_BONDING);
+	if (dev)
+		set_device_bond_state(dev, HAL_STATUS_SUCCESS,
+							HAL_BOND_STATE_BONDING);
 
 fail:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CREATE_BOND,
@@ -3200,14 +3228,18 @@ static void unpair_device_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_rp_unpair_device *rp = param;
+	struct device *dev;
 
 	DBG("status %u", status);
 
 	if (status != MGMT_STATUS_SUCCESS && status != MGMT_STATUS_NOT_PAIRED)
 		return;
 
-	set_device_bond_state(&rp->addr.bdaddr, HAL_STATUS_SUCCESS,
-							HAL_BOND_STATE_NONE);
+	dev = find_device(&rp->addr.bdaddr);
+	if (!dev)
+		return;
+
+	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_NONE);
 }
 
 static void handle_remove_bond_cmd(const void *buf, uint16_t len)
-- 
1.9.1


Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 1/4] android: Update bond state on incoming bonding
Date: Fri, 15 Nov 2013 19:03:58 +0100
Message-ID: <1384538641-1873-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1384538641-1873-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1384538641-1873-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before sending any ssp request or pin code request up to HAL library we
need to send bond state change with bonding state. Otherwise incoming
bonding is not correctly handled by Bluetooth.apk.
In this patch also device list has been added in order to e.g track
bonding state.

Note: For incoming paring (security mode 3) there is a  need to send
HAL_EVE_REMOTE_DEVICE_PROPS before HAL_EV_PIN_REQUEST.
It is because Android will crash due to bug in pinRequestCallback
function in java. Android checks if device is already in HashMap and if
not then creates  device, but forget to use that one, but instead do
operations on NULL. By sending HAL_BOND_STATE_BONDING event it works
better but we have race issue. It is because new device is added to
HashMap not in callback context but later after BONDING msg will be
received  by BondStateMachine. If it happens before pin_request_cb hits
java then we are fine, otherwise not. So for that reason we send
HAL_EV_REMOTE_DEVICE_PROPS so in the java handler class new device will
be added to HashMap in the  callback context.

In ssp case we don't have this problem as we send device found once acl
is created.
---
 android/bluetooth.c | 97 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 14 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index b7c05e7..8f9712f 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -62,6 +62,8 @@ static uint16_t option_index = MGMT_INDEX_NONE;
 
 static int notification_sk = -1;
 
+#define BASELEN_REMOTE_DEV_PROP (sizeof(struct hal_ev_remote_device_props) \
+					+ sizeof(struct hal_property))
 /* This list contains addresses which are asked for records */
 static GSList *browse_reqs;
 
@@ -91,6 +93,11 @@ static struct {
 	.uuids = NULL,
 };
 
+struct device {
+	bdaddr_t bdaddr;
+	int bond_state;
+};
+
 struct browse_req {
 	bdaddr_t bdaddr;
 	GSList *uuids;
@@ -106,6 +113,7 @@ static const uint16_t uuid_list[] = {
 };
 
 static GSList *found_devices = NULL;
+static GSList *devices = NULL;
 
 static void adapter_name_changed(const uint8_t *name)
 {
@@ -301,6 +309,14 @@ static void store_link_key(const bdaddr_t *dst, const uint8_t *key,
 
 }
 
+static int bdaddr_cmp(gconstpointer a, gconstpointer b)
+{
+	const bdaddr_t *bda = a;
+	const bdaddr_t *bdb = b;
+
+	return bacmp(bdb, bda);
+}
+
 static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 								uint8_t state)
 {
@@ -314,6 +330,29 @@ static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 			HAL_EV_BOND_STATE_CHANGED, sizeof(ev), &ev, -1);
 }
 
+static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
+								int state) {
+
+	struct device *dev = NULL;
+	GSList *l;
+
+	l = g_slist_find_custom(devices, addr, bdaddr_cmp);
+	if (l)
+		dev = l->data;
+
+	if (!dev) {
+		dev = g_new0(struct device, 1);
+		bacpy(&dev->bdaddr, addr);
+		dev->bond_state = HAL_BOND_STATE_NONE;
+		devices = g_slist_prepend(devices, dev);
+	}
+
+	if (dev->bond_state != state) {
+		dev->bond_state = state;
+		send_bond_state_change(&dev->bdaddr, status, state);
+	}
+}
+
 static void browse_req_free(struct browse_req *req)
 {
 	g_slist_free_full(req->uuids, g_free);
@@ -497,12 +536,32 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 								key->pin_len);
 	}
 
-	send_bond_state_change(&addr->bdaddr, HAL_STATUS_SUCCESS,
+	set_device_bond_state(&addr->bdaddr, HAL_STATUS_SUCCESS,
 							HAL_BOND_STATE_BONDED);
 
 	browse_remote_sdp(&addr->bdaddr);
 }
 
+static void send_remote_device_name_prop(const bdaddr_t *bdaddr,
+							const char *name)
+{
+	struct hal_ev_remote_device_props *ev;
+	uint8_t buf[BASELEN_REMOTE_DEV_PROP + strlen(name)];
+
+	ev = (void *) buf;
+	memset(buf, 0, sizeof(buf));
+
+	ev->status = HAL_STATUS_SUCCESS;
+	bdaddr2android(bdaddr, ev->bdaddr);
+	ev->num_props = 1;
+	ev->props[0].type = HAL_PROP_DEVICE_NAME;
+	ev->props[0].len = strlen(name);
+	memcpy(&ev->props[0].val, name, strlen(name));
+
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_REMOTE_DEVICE_PROPS, sizeof(buf), ev, -1);
+}
+
 static void pin_code_request_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -517,6 +576,13 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 
 	ba2str(&ev->addr.bdaddr, dst);
 
+	/* Workaround for Android Bluetooth.apk issue: send remote
+	 * device property. Lets use address as a name for now */
+	send_remote_device_name_prop(&ev->addr.bdaddr, dst);
+
+	set_device_bond_state(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_BOND_STATE_BONDING);
+
 	DBG("%s type %u secure %u", dst, ev->addr.type, ev->secure);
 
 	/* TODO name and CoD of remote devices should probably be cached */
@@ -556,6 +622,9 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, dst);
 	DBG("%s confirm_hint %u", dst, ev->confirm_hint);
 
+	set_device_bond_state(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_BOND_STATE_BONDING);
+
 	if (ev->confirm_hint)
 		send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_CONSENT, 0);
 	else
@@ -577,6 +646,9 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, dst);
 	DBG("%s", dst);
 
+	set_device_bond_state(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_BOND_STATE_BONDING);
+
 	send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_ENTRY, 0);
 }
 
@@ -595,8 +667,13 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 	DBG("%s entered %u", dst, ev->entered);
 
 	/* HAL seems to not support entered characters */
-	if (!ev->entered)
-		send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_NOTIF,
+	if (ev->entered)
+		return;
+
+	set_device_bond_state(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_BOND_STATE_BONDING);
+
+	send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_NOTIF,
 								ev->passkey);
 }
 
@@ -647,14 +724,6 @@ static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type)
 		error("Failed to send confirm name request");
 }
 
-static int bdaddr_cmp(gconstpointer a, gconstpointer b)
-{
-	const bdaddr_t *bda = a;
-	const bdaddr_t *bdb = b;
-
-	return bacmp(bdb, bda);
-}
-
 static int fill_device_props(struct hal_property *prop, bdaddr_t *addr,
 					uint32_t cod, int8_t rssi, char *name)
 {
@@ -1840,7 +1909,7 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 	if (status == MGMT_STATUS_SUCCESS)
 		return;
 
-	send_bond_state_change(&rp->addr.bdaddr, status_mgmt2hal(status),
+	set_device_bond_state(&rp->addr.bdaddr, status_mgmt2hal(status),
 							HAL_BOND_STATE_NONE);
 }
 
@@ -1857,7 +1926,7 @@ static bool create_bond(void *buf, uint16_t len)
 				&cp, pair_device_complete, NULL, NULL) == 0)
 		return false;
 
-	send_bond_state_change(&cp.addr.bdaddr, HAL_STATUS_SUCCESS,
+	set_device_bond_state(&cp.addr.bdaddr, HAL_STATUS_SUCCESS,
 						HAL_BOND_STATE_BONDING);
 
 	return true;
@@ -1885,7 +1954,7 @@ static void unpair_device_complete(uint8_t status, uint16_t length,
 	if (status != MGMT_STATUS_SUCCESS)
 		return;
 
-	send_bond_state_change(&rp->addr.bdaddr, HAL_STATUS_SUCCESS,
+	set_device_bond_state(&rp->addr.bdaddr, HAL_STATUS_SUCCESS,
 							HAL_BOND_STATE_NONE);
 }
 
-- 
1.8.4


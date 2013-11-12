Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/3] android: Update bond state on incoming bonding
Date: Tue, 12 Nov 2013 13:51:38 +0100
Message-ID: <1384260700-16621-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1384260700-16621-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1384260700-16621-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before sending any ssp request or pin code request up to HAL library we
need to send bond state change with bonding state. Otherwise incoming
bonding is impossible.
Add bonding tracking to adapter.
---
 android/adapter.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 65b3170..f92301e 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -74,6 +74,8 @@ struct bt_adapter {
 
 	bool discovering;
 	uint32_t discoverable_timeout;
+
+	bool bonding;
 };
 
 struct browse_req {
@@ -486,6 +488,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 	send_bond_state_change(&addr->bdaddr, HAL_STATUS_SUCCESS,
 							HAL_BOND_STATE_BONDED);
 
+	adapter->bonding = false;
 	browse_remote_sdp(&addr->bdaddr);
 }
 
@@ -501,6 +504,13 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
+	if (!adapter->bonding) {
+		adapter->bonding = true;
+		/* Update bonding state */
+		send_bond_state_change(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_BOND_STATE_BONDING);
+	}
+
 	ba2str(&ev->addr.bdaddr, dst);
 
 	DBG("%s type %u secure %u", dst, ev->addr.type, ev->secure);
@@ -542,6 +552,13 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, dst);
 	DBG("%s confirm_hint %u", dst, ev->confirm_hint);
 
+	if (!adapter->bonding) {
+		adapter->bonding = true;
+		/* Update bonding state */
+		send_bond_state_change(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_BOND_STATE_BONDING);
+	}
+
 	if (ev->confirm_hint)
 		send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_CONSENT, 0);
 	else
@@ -563,6 +580,13 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, dst);
 	DBG("%s", dst);
 
+	if (!adapter->bonding) {
+		adapter->bonding = true;
+		/* Update bonding state */
+		send_bond_state_change(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_BOND_STATE_BONDING);
+	}
+
 	send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_ENTRY, 0);
 }
 
@@ -581,9 +605,17 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 	DBG("%s entered %u", dst, ev->entered);
 
 	/* HAL seems to not support entered characters */
-	if (!ev->entered)
-		send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_NOTIF,
-								ev->passkey);
+	if (ev->entered)
+		return;
+
+	if (!adapter->bonding) {
+		adapter->bonding=true;
+		/* Update bonding state */
+		send_bond_state_change(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_BOND_STATE_BONDING);
+	}
+
+	send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_NOTIF, ev->passkey);
 }
 
 static void mgmt_discovering_event(uint16_t index, uint16_t length,
@@ -1166,6 +1198,7 @@ void bt_adapter_init(uint16_t index, struct mgmt *mgmt, bt_adapter_ready cb)
 	adapter->ready = cb;
 	/* TODO: Read it from some storage */
 	adapter->discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT;
+	adapter->bonding = false;
 
 	if (mgmt_send(mgmt, MGMT_OP_READ_INFO, index, 0, NULL,
 					read_info_complete, NULL, NULL) > 0)
@@ -1486,6 +1519,7 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 	if (status == MGMT_STATUS_SUCCESS)
 		return;
 
+	adapter->bonding = false;
 	send_bond_state_change(&rp->addr.bdaddr, status_mgmt2hal(status),
 							HAL_BOND_STATE_NONE);
 }
@@ -1504,6 +1538,7 @@ static bool create_bond(void *buf, uint16_t len)
 				NULL) == 0)
 		return false;
 
+	adapter->bonding = true;
 	send_bond_state_change(&cp.addr.bdaddr, HAL_STATUS_SUCCESS,
 						HAL_BOND_STATE_BONDING);
 
@@ -1514,13 +1549,18 @@ static bool cancel_bond(void *buf, uint16_t len)
 {
 	struct hal_cmd_cancel_bond *cmd = buf;
 	struct mgmt_addr_info cp;
+	bool result;
 
 	cp.type = BDADDR_BREDR;
 	android2bdaddr(cmd->bdaddr, &cp.bdaddr);
 
-	return mgmt_reply(adapter->mgmt, MGMT_OP_CANCEL_PAIR_DEVICE,
+	result = mgmt_reply(adapter->mgmt, MGMT_OP_CANCEL_PAIR_DEVICE,
 				adapter->index, sizeof(cp), &cp, NULL, NULL,
 				NULL) > 0;
+	if (result)
+		adapter->bonding = false;
+
+	return result;
 }
 
 static void unpair_device_complete(uint8_t status, uint16_t length,
@@ -1737,7 +1777,7 @@ void bt_adapter_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 
 		break;
 	case HAL_OP_CREATE_BOND:
-		if (!create_bond(buf, len))
+		if (adapter->bonding || !create_bond(buf, len))
 			goto error;
 
 		break;
-- 
1.8.4


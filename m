Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/3] android: Update bond state on incoming bonding
Date: Fri, 8 Nov 2013 16:48:29 +0100
Message-ID: <1383925711-26374-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1383925711-26374-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1383925711-26374-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before sending any ssp request or pin code request up to HAL library we
need to send bond state change with bonding state. Otherwise incoming
bonding is impossible.
---
 android/adapter.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 65b3170..d63352e 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -501,6 +501,10 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
+	/* Update bonding state */
+	send_bond_state_change(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_BOND_STATE_BONDING);
+
 	ba2str(&ev->addr.bdaddr, dst);
 
 	DBG("%s type %u secure %u", dst, ev->addr.type, ev->secure);
@@ -542,6 +546,10 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, dst);
 	DBG("%s confirm_hint %u", dst, ev->confirm_hint);
 
+	/* Update bonding state */
+	send_bond_state_change(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_BOND_STATE_BONDING);
+
 	if (ev->confirm_hint)
 		send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_CONSENT, 0);
 	else
@@ -563,6 +571,10 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 	ba2str(&ev->addr.bdaddr, dst);
 	DBG("%s", dst);
 
+	/* Update bonding state */
+	send_bond_state_change(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_BOND_STATE_BONDING);
+
 	send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_ENTRY, 0);
 }
 
@@ -581,9 +593,14 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 	DBG("%s entered %u", dst, ev->entered);
 
 	/* HAL seems to not support entered characters */
-	if (!ev->entered)
+	if (!ev->entered) {
+		/* Update bonding state */
+		send_bond_state_change(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_BOND_STATE_BONDING);
+
 		send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_NOTIF,
 								ev->passkey);
+	}
 }
 
 static void mgmt_discovering_event(uint16_t index, uint16_t length,
@@ -827,8 +844,6 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 
 	/* TODO: Update device */
 
-	/* TODO: Check Set bonding state */
-
 	hal_ev.status = HAL_STATUS_SUCCESS;
 	hal_ev.state = HAL_ACL_STATE_CONNECTED;
 	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
-- 
1.8.4


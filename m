Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] android/bluetooth: Pass device to send_ssp_request
Date: Thu,  8 May 2014 15:26:02 +0200
Message-Id: <1399555563-21054-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1399555563-21054-1-git-send-email-szymon.janc@tieto.com>
References: <1399555563-21054-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to fill event with all required data.
---
 android/bluetooth.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 4eb5e2f..85db038 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -933,18 +933,15 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 						sizeof(hal_ev), &hal_ev);
 }
 
-static void send_ssp_request(const bdaddr_t *addr, uint8_t variant,
+static void send_ssp_request(struct device *dev, uint8_t variant,
 							uint32_t passkey)
 {
 	struct hal_ev_ssp_request ev;
 
-	/*
-	 * It is ok to have empty name and CoD of remote devices here since
-	 * those information has been already provided on device_connected event
-	 * or during device scaning. Android will use that instead.
-	 */
-	memset(&ev, 0, sizeof(ev));
-	bdaddr2android(addr, ev.bdaddr);
+	bdaddr2android(&dev->bdaddr, ev.bdaddr);
+	memcpy(ev.name, dev->name, strlen(dev->name));
+	ev.class_of_dev = dev->class;
+
 	ev.pairing_variant = variant;
 	ev.passkey = passkey;
 
@@ -974,10 +971,9 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDING);
 
 	if (ev->confirm_hint)
-		send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_CONSENT, 0);
+		send_ssp_request(dev, HAL_SSP_VARIANT_CONSENT, 0);
 	else
-		send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_CONFIRM,
-								ev->value);
+		send_ssp_request(dev, HAL_SSP_VARIANT_CONFIRM, ev->value);
 }
 
 static void user_passkey_request_callback(uint16_t index, uint16_t length,
@@ -1001,7 +997,7 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 
 	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDING);
 
-	send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_ENTRY, 0);
+	send_ssp_request(dev, HAL_SSP_VARIANT_ENTRY, 0);
 }
 
 static void user_passkey_notify_callback(uint16_t index, uint16_t length,
@@ -1030,7 +1026,7 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 
 	set_device_bond_state(dev, HAL_STATUS_SUCCESS, HAL_BOND_STATE_BONDING);
 
-	send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_NOTIF, ev->passkey);
+	send_ssp_request(dev, HAL_SSP_VARIANT_NOTIF, ev->passkey);
 }
 
 static void clear_device_found(gpointer data, gpointer user_data)
-- 
1.9.1


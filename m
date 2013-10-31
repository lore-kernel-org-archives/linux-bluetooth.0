Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/14] android: Add initial support for sending SSP request event
Date: Thu, 31 Oct 2013 02:55:50 +0000
Message-Id: <1383188154-22905-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only consent and confirm variants are supported in this patch.
---
 android/adapter.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 0c5ae8b..b99c860 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -276,6 +276,42 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 						sizeof(hal_ev), &hal_ev, -1);
 }
 
+static void send_ssp_request(const bdaddr_t *addr, uint8_t variant,
+							uint32_t passkey)
+{
+	struct hal_ev_ssp_request ev;
+
+	/* TODO name and CoD of remote devices should probably be cached */
+	memset(&ev, 0, sizeof(ev));
+	bdaddr2android(addr, ev.bdaddr);
+	ev.pairing_variant = variant;
+	ev.passkey = passkey;
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_SSP_REQUEST,
+						sizeof(ev), &ev, -1);
+}
+
+static void user_confirm_request_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_user_confirm_request *ev = param;
+	char dst[18];
+
+	if (length < sizeof(*ev)) {
+		error("Too small user confirm request event");
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, dst);
+	DBG("%s confirm_hint %u", dst, ev->confirm_hint);
+
+	if (ev->confirm_hint)
+		send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_CONSENT, 0);
+	else
+		send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_CONFIRM,
+								ev->value);
+}
+
 static void register_mgmt_handlers(void)
 {
 	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->index,
@@ -294,6 +330,10 @@ static void register_mgmt_handlers(void)
 
 	mgmt_register(adapter->mgmt, MGMT_EV_PIN_CODE_REQUEST, adapter->index,
 					pin_code_request_callback, NULL, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_USER_CONFIRM_REQUEST,
+				adapter->index, user_confirm_request_callback,
+				NULL, NULL);
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
-- 
1.8.4.rc3


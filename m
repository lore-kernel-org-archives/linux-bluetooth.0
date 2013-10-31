Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 12/14] android: Add support for notify variant in SSP request event
Date: Thu, 31 Oct 2013 02:55:52 +0000
Message-Id: <1383188154-22905-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 1be0fb3..00766eb 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -329,6 +329,26 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 	send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_ENTRY, 0);
 }
 
+static void user_passkey_notify_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_passkey_notify *ev = param;
+	char dst[18];
+
+	if (length < sizeof(*ev)) {
+		error("Too small passkey notify event");
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, dst);
+	DBG("%s entered %u", dst, ev->entered);
+
+	/* HAL seems to not support entered characters */
+	if (!ev->entered)
+		send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_NOTIF,
+								ev->passkey);
+}
+
 static void register_mgmt_handlers(void)
 {
 	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->index,
@@ -355,6 +375,10 @@ static void register_mgmt_handlers(void)
 	mgmt_register(adapter->mgmt, MGMT_EV_USER_PASSKEY_REQUEST,
 				adapter->index, user_passkey_request_callback,
 				NULL, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_PASSKEY_NOTIFY, adapter->index,
+				user_passkey_notify_callback, NULL, NULL);
+
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
-- 
1.8.4.rc3


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/14] android: Add support for sending pin code request
Date: Thu, 31 Oct 2013 02:55:49 +0000
Message-Id: <1383188154-22905-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 0a91149..0c5ae8b 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -252,6 +252,30 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 							HAL_BOND_STATE_BONDED);
 }
 
+static void pin_code_request_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_pin_code_request *ev = param;
+	struct hal_ev_pin_request hal_ev;
+	char dst[18];
+
+	if (length < sizeof(*ev)) {
+		error("Too small PIN code request event");
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, dst);
+
+	DBG("%s type %u secure %u", dst, ev->addr.type, ev->secure);
+
+	/* TODO name and CoD of remote devices should probably be cached */
+	memset(&hal_ev, 0, sizeof(hal_ev));
+	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_PIN_REQUEST,
+						sizeof(hal_ev), &hal_ev, -1);
+}
+
 static void register_mgmt_handlers(void)
 {
 	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->index,
@@ -267,6 +291,9 @@ static void register_mgmt_handlers(void)
 
 	mgmt_register(adapter->mgmt, MGMT_EV_NEW_LINK_KEY, adapter->index,
 					new_link_key_callback, NULL, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_PIN_CODE_REQUEST, adapter->index,
+					pin_code_request_callback, NULL, NULL);
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
-- 
1.8.4.rc3


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/6] android: Send notification on adapter power state change
Date: Wed, 23 Oct 2013 15:46:24 +0200
Message-ID: <1382535986-30684-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382535986-30684-1-git-send-email-szymon.janc@tieto.com>
References: <1382535986-30684-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index f9843d1..7a219df 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -74,6 +74,20 @@ static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
 	/* TODO Update services if needed */
 }
 
+static void settings_changed_powered(struct bt_adapter *adapter)
+{
+	struct hal_msg_ev_bt_adapter_state_changed ev;
+
+	ev.state = (adapter->current_settings & MGMT_SETTING_POWERED) ?
+			HAL_BT_ADAPTER_STATE_ON : HAL_BT_ADAPTER_STATE_OFF;
+
+	DBG("%u", ev.state);
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+					HAL_MSG_EV_BT_ADAPTER_STATE_CHANGED,
+					sizeof(ev), &ev, -1);
+}
+
 static void settings_changed_connectable(struct bt_adapter *adapter)
 {
 	/* TODO */
@@ -94,16 +108,8 @@ static void settings_changed(struct bt_adapter *adapter, uint32_t settings)
 
 	DBG("0x%08x", changed_mask);
 
-	if (changed_mask & MGMT_SETTING_POWERED) {
-		info("Powered");
-
-		/*
-		if (adapter->current_settings & MGMT_SETTING_POWERED)
-			start_adapter()
-		else
-			stop_adapter()
-		*/
-	}
+	if (changed_mask & MGMT_SETTING_POWERED)
+		settings_changed_powered(adapter);
 
 	if (changed_mask & MGMT_SETTING_CONNECTABLE) {
 		DBG("Connectable");
-- 
1.8.4


Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 7/8] android/daemon: Add handler for device disconnected
Date: Fri,  1 Nov 2013 15:41:44 +0200
Message-Id: <1383313305-9442-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383313305-9442-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383313305-9442-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Send event to callback thread which shall call acl state change callback.
---
 android/adapter.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 299a025..1109443 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -651,6 +651,25 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
 }
 
+static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_device_disconnected *ev = param;
+	struct hal_ev_acl_state_changed hal_ev;
+
+	if (length < sizeof(*ev)) {
+		error("Too short device disconnected event (%u bytes)", length);
+		return;
+	}
+
+	hal_ev.status = HAL_STATUS_SUCCESS;
+	hal_ev.state = HAL_ACL_STATE_DISCONNECTED;
+	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
+}
+
 static void mgmt_connect_failed_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -710,6 +729,10 @@ static void register_mgmt_handlers(void)
 	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_CONNECTED, adapter->index,
 				mgmt_device_connected_event, NULL, NULL);
 
+	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_DISCONNECTED,
+				adapter->index, mgmt_device_disconnected_event,
+				NULL, NULL);
+
 	mgmt_register(adapter->mgmt, MGMT_EV_CONNECT_FAILED, adapter->index,
 				mgmt_connect_failed_event, NULL, NULL);
 
-- 
1.7.10.4


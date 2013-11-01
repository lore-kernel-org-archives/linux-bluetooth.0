Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 6/6] android/daemon: Add handler for device disconnected
Date: Fri,  1 Nov 2013 13:30:18 +0200
Message-Id: <1383305418-13619-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383305418-13619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383305418-13619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Send event to callback thread which shall call acl state change callback.
---
 android/adapter.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index bc4492b..39389ee 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -643,6 +643,29 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
 }
 
+static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_device_disconnected *ev = param;
+	struct hal_ev_acl_state_changed hal_ev;
+
+	if (length < sizeof(*ev)) {
+		error("Too short %s (%u bytes)", __func__, length);
+		return;
+	}
+
+	/* TODO: Update device */
+
+	/* TODO: Check Set bonding state */
+
+	hal_ev.status = HAL_STATUS_SUCCESS;
+	hal_ev.state = HAL_ACL_STATE_DISCONNECTED;
+	bdaddr2android(&ev->addr.bdaddr, &hal_ev.bdaddr);
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
+}
+
 static void mgmt_connect_failed_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -696,6 +719,10 @@ static void register_mgmt_handlers(void)
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


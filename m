Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 3/8] android/daemon: Implement mgmt device connected event
Date: Fri,  1 Nov 2013 15:41:40 +0200
Message-Id: <1383313305-9442-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383313305-9442-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383313305-9442-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Send HAL_EV_ACL_STATE_CHANGED event to HAL through IPC.
---
 android/adapter.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 5ce0797..5a5fa2e 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -628,6 +628,29 @@ static void mgmt_device_found_event(uint16_t index, uint16_t length,
 						confirm_name, eir, eir_len);
 }
 
+static void mgmt_device_connected_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_device_connected *ev = param;
+	struct hal_ev_acl_state_changed hal_ev;
+
+	if (length < sizeof(*ev)) {
+		error("Too short device connected event (%u bytes)", length);
+		return;
+	}
+
+	/* TODO: Update device */
+
+	/* TODO: Check Set bonding state */
+
+	hal_ev.status = HAL_STATUS_SUCCESS;
+	hal_ev.state = HAL_ACL_STATE_CONNECTED;
+	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
+}
+
 static void register_mgmt_handlers(void)
 {
 	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->index,
@@ -665,6 +688,9 @@ static void register_mgmt_handlers(void)
 	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_FOUND,
 					adapter->index, mgmt_device_found_event,
 					NULL, NULL);
+
+	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_CONNECTED, adapter->index,
+				mgmt_device_connected_event, NULL, NULL);
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
-- 
1.7.10.4


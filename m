Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 8/8] android/daemon: Refactor sending acl state
Date: Fri,  1 Nov 2013 15:41:45 +0200
Message-Id: <1383313305-9442-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383313305-9442-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383313305-9442-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Sending ACL state change might be refactored.
---
 android/adapter.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 1109443..d5b32c3 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -628,11 +628,24 @@ static void mgmt_device_found_event(uint16_t index, uint16_t length,
 						confirm_name, eir, eir_len);
 }
 
+static void send_acl_state_change(const bdaddr_t *addr, uint8_t status,
+								uint8_t state)
+{
+	struct hal_ev_acl_state_changed hal_ev;
+
+	hal_ev.status = status;
+	hal_ev.state = state;
+	bdaddr2android(addr, hal_ev.bdaddr);
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
+
+}
+
 static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_ev_device_connected *ev = param;
-	struct hal_ev_acl_state_changed hal_ev;
 
 	if (length < sizeof(*ev)) {
 		error("Too short device connected event (%u bytes)", length);
@@ -643,31 +656,22 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 
 	/* TODO: Check Set bonding state */
 
-	hal_ev.status = HAL_STATUS_SUCCESS;
-	hal_ev.state = HAL_ACL_STATE_CONNECTED;
-	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
-
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
+	send_acl_state_change(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_ACL_STATE_CONNECTED);
 }
 
 static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_ev_device_disconnected *ev = param;
-	struct hal_ev_acl_state_changed hal_ev;
 
 	if (length < sizeof(*ev)) {
 		error("Too short device disconnected event (%u bytes)", length);
 		return;
 	}
 
-	hal_ev.status = HAL_STATUS_SUCCESS;
-	hal_ev.state = HAL_ACL_STATE_DISCONNECTED;
-	bdaddr2android(&ev->addr.bdaddr, hal_ev.bdaddr);
-
-	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
+	send_acl_state_change(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
+						HAL_ACL_STATE_DISCONNECTED);
 }
 
 static void mgmt_connect_failed_event(uint16_t index, uint16_t length,
-- 
1.7.10.4


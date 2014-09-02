Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 4/5] android/bluetooth: Fix bond state for non-bonded devices
Date: Tue,  2 Sep 2014 15:55:02 +0200
Message-Id: <1409666103-14663-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409666103-14663-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409666103-14663-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When device is paired but no-bonded, Android GUI keep incorrect bonds
state after ACL disconnect. This patch fixes that

This patch also moved device_is_paired() up in the file
---
 android/bluetooth.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 390a3a2..147d9f8 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2035,6 +2035,19 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev);
 }
 
+static bool device_is_paired(struct device *dev, uint8_t addr_type)
+{
+	if (addr_type == BDADDR_BREDR)
+		return dev->bredr_paired;
+
+	return dev->le_paired;
+}
+
+static bool device_is_bonded(struct device *dev)
+{
+	return dev->bredr_bonded || dev->le_bonded;
+}
+
 static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
 							const void *param,
 							void *user_data)
@@ -2042,6 +2055,7 @@ static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
 	const struct mgmt_ev_device_disconnected *ev = param;
 	struct hal_ev_acl_state_changed hal_ev;
 	struct device *dev;
+	uint8_t type = ev->addr.type;
 
 	if (length < sizeof(*ev)) {
 		error("Too short device disconnected event (%u bytes)", length);
@@ -2058,6 +2072,11 @@ static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev);
+
+	if (device_is_paired(dev, type) && !device_is_bonded(dev))
+		update_device_state(dev, type, HAL_STATUS_SUCCESS, false,
+								false, false);
+
 }
 
 static uint8_t status_mgmt2hal(uint8_t mgmt)
@@ -4283,14 +4302,6 @@ uint8_t bt_device_last_seen_bearer(const bdaddr_t *bdaddr)
 	return select_device_bearer(dev);
 }
 
-static bool device_is_paired(struct device *dev, uint8_t addr_type)
-{
-	if (addr_type == BDADDR_BREDR)
-		return dev->bredr_paired;
-
-	return dev->le_paired;
-}
-
 static void handle_create_bond_cmd(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_create_bond *cmd = buf;
-- 
1.8.4


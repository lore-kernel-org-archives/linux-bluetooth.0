Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2] adapter: Fix not clearing connectable setting on power off
Date: Mon, 19 Feb 2018 13:43:35 +0100
Message-Id: <20180219124335.16528-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When kernel control of connectable is used daemon doesn't enable
connectable setting unless discoverable. Both settings are permanent
over power toggle unless discoverable timeout was set. In that case
discoverable flag is cleared by kernel on power off. This leads to
connectable flag being left enabled when toggling power on discoverable
adapter with timeout set.

This has some implications on system behaviour:
 - accepting connection from unknown devices
 - not being able to advertise as broadcaster

Since kernel doens't know the reason for enabling connectable flag (and
thus if disable if on power off) this needs to be handled in bluetoothd.
---
 src/adapter.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index fcb102411..fc4913e71 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2694,6 +2694,30 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
 	new_settings_callback(adapter->dev_id, length, param, adapter);
 }
 
+static void clear_discoverable(struct btd_adapter *adapter)
+{
+	if (!kernel_conn_control)
+		return;
+
+	if (!(adapter->current_settings & MGMT_SETTING_DISCOVERABLE))
+		return;
+
+	/* If no timeout is set do nothing as both connectable and discoverable
+	 * flags are persistent on power toggle.
+	 */
+	if (!adapter->discoverable_timeout)
+		return;
+
+	/* If timeout was set kernel clears discoverable on its own when
+	 * powering off controller. This would leave connectable flag set
+	 * after power on.
+	 *
+	 * With kernel control clearing connectable clear also discoverable
+	 * flag so we need to clear connectable.
+	 */
+	set_mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x00);
+}
+
 static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 						DBusMessageIter *value,
 						GDBusPendingPropertySet id)
@@ -2724,6 +2748,10 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 		opcode = MGMT_OP_SET_POWERED;
 		param = &mode;
 		len = sizeof(mode);
+
+		if (!mode)
+			clear_discoverable(adapter);
+
 		break;
 	case MGMT_SETTING_DISCOVERABLE:
 		if (kernel_conn_control) {
@@ -8756,6 +8784,7 @@ void adapter_shutdown(void)
 		if (!(adapter->current_settings & MGMT_SETTING_POWERED))
 			continue;
 
+		clear_discoverable(adapter);
 		set_mode(adapter, MGMT_OP_SET_POWERED, 0x00);
 
 		adapter_remaining++;
-- 
2.14.3


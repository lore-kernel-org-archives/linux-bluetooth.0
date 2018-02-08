Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] adapter: Fix not clearing connectable setting on power off
Date: Thu,  8 Feb 2018 16:46:38 +0100
Message-Id: <20180208154638.15196-1-szymon.janc@codecoup.pl>
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
 - not being advertise as broadcaster

Since kernel doens't know the reason for enabling connectable flag (and
thus if disable if on power off) this needs to be handled in bluetoothd.
---
 src/adapter.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 93e36d00d..cba2aa3b5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2693,6 +2693,22 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
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
+	/* if timeout was set kernel clears discoverable on its own */
+	if (!adapter->discoverable_timeout)
+		return;
+
+	/* with kernel control clearing connectable clear also discoverable */
+	set_mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x00);
+}
+
 static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 						DBusMessageIter *value,
 						GDBusPendingPropertySet id)
@@ -2723,6 +2739,10 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
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
@@ -8744,6 +8764,7 @@ void adapter_shutdown(void)
 		if (!(adapter->current_settings & MGMT_SETTING_POWERED))
 			continue;
 
+		clear_discoverable(adapter);
 		set_mode(adapter, MGMT_OP_SET_POWERED, 0x00);
 
 		adapter_remaining++;
-- 
2.14.3


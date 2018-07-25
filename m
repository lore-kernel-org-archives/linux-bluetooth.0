Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] adapter: Check pending when setting DiscoverableTimeout
Date: Wed, 25 Jul 2018 13:20:35 +0300
Message-Id: <20180725102035.19439-4-luiz.dentz@gmail.com>
In-Reply-To: <20180725102035.19439-1-luiz.dentz@gmail.com>
References: <20180725102035.19439-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes DiscoverableTimeout check if discoverable is already pending
and don't attempt to set it once again which may cause discoverable to
be re-enabled when in fact the application just want to set the timeout
alone.
---
 src/adapter.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 20c20f9e9..f92c897c7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2901,6 +2901,7 @@ static void property_set_discoverable_timeout(
 				GDBusPendingPropertySet id, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
+	bool enabled;
 	dbus_uint32_t value;
 
 	dbus_message_iter_get_basic(iter, &value);
@@ -2914,8 +2915,19 @@ static void property_set_discoverable_timeout(
 	g_dbus_emit_property_changed(dbus_conn, adapter->path,
 				ADAPTER_INTERFACE, "DiscoverableTimeout");
 
+	if (adapter->pending_settings & MGMT_SETTING_DISCOVERABLE) {
+		if (adapter->current_settings & MGMT_SETTING_DISCOVERABLE)
+			enabled = false;
+		else
+			enabled = true;
+	} else {
+		if (adapter->current_settings & MGMT_SETTING_DISCOVERABLE)
+			enabled = true;
+		else
+			enabled = false;
+	}
 
-	if (adapter->current_settings & MGMT_SETTING_DISCOVERABLE)
+	if (enabled)
 		set_discoverable(adapter, 0x01, adapter->discoverable_timeout);
 }
 
-- 
2.17.1


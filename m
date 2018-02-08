Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] adapter: Remove spurious propery change signal
Date: Thu,  8 Feb 2018 17:03:06 +0100
Message-Id: <20180208160306.15837-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no "Connectable" property on Adapter1 interface.
---
 src/adapter.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 50cf46b11..93e36d00d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -535,10 +535,6 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 			trigger_passive_scanning(adapter);
 	}
 
-	if (changed_mask & MGMT_SETTING_CONNECTABLE)
-		g_dbus_emit_property_changed(dbus_conn, adapter->path,
-					ADAPTER_INTERFACE, "Connectable");
-
 	if (changed_mask & MGMT_SETTING_DISCOVERABLE) {
 		g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Discoverable");
-- 
2.14.3


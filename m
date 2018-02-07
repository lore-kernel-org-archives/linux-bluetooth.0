Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2] advertising: Configure discoverable flag based on adapter settings
Date: Wed,  7 Feb 2018 11:02:24 +0100
Message-Id: <20180207100224.7523-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Until now advertising as peripheral was always setting General Discoverable
flag set. With this patch this is set based on adapter discoverable setting.
---
 src/adapter.c     |  9 +++++++++
 src/adapter.h     |  1 +
 src/advertising.c | 14 ++++++++++++--
 src/advertising.h |  1 +
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 50cf46b11..5070c0f09 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -543,6 +543,7 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 		g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Discoverable");
 		store_adapter_info(adapter);
+		btd_adv_manager_refresh(adapter->adv_manager);
 	}
 
 	if (changed_mask & MGMT_SETTING_BONDABLE) {
@@ -4108,6 +4109,14 @@ bool btd_adapter_get_connectable(struct btd_adapter *adapter)
 	return false;
 }
 
+bool btd_adapter_get_discoverable(struct btd_adapter *adapter)
+{
+	if (adapter->current_settings & MGMT_SETTING_DISCOVERABLE)
+		return true;
+
+	return false;
+}
+
 struct btd_gatt_database *btd_adapter_get_database(struct btd_adapter *adapter)
 {
 	if (!adapter)
diff --git a/src/adapter.h b/src/adapter.h
index a85327cd1..e619a5be9 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -74,6 +74,7 @@ void adapter_foreach(adapter_cb func, gpointer user_data);
 bool btd_adapter_get_pairable(struct btd_adapter *adapter);
 bool btd_adapter_get_powered(struct btd_adapter *adapter);
 bool btd_adapter_get_connectable(struct btd_adapter *adapter);
+bool btd_adapter_get_discoverable(struct btd_adapter *adapter);
 
 struct btd_gatt_database *btd_adapter_get_database(struct btd_adapter *adapter);
 
diff --git a/src/advertising.c b/src/advertising.c
index 94a8c4050..0af9f02d6 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -622,8 +622,12 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func)
 
 	DBG("Refreshing advertisement: %s", client->path);
 
-	if (client->type == AD_TYPE_PERIPHERAL)
-		flags = MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV;
+	if (client->type == AD_TYPE_PERIPHERAL) {
+		flags = MGMT_ADV_FLAG_CONNECTABLE;
+
+		if (btd_adapter_get_discoverable(client->manager->adapter))
+			flags |= MGMT_ADV_FLAG_DISCOV;
+	}
 
 	flags |= client->flags;
 
@@ -1104,3 +1108,9 @@ void btd_adv_manager_destroy(struct btd_adv_manager *manager)
 
 	manager_destroy(manager);
 }
+
+void btd_adv_manager_refresh(struct btd_adv_manager *manager)
+{
+	queue_foreach(manager->clients, (queue_foreach_func_t)refresh_adv,
+									NULL);
+}
diff --git a/src/advertising.h b/src/advertising.h
index b783cf075..d98c4b864 100644
--- a/src/advertising.h
+++ b/src/advertising.h
@@ -22,3 +22,4 @@ struct btd_adv_manager;
 
 struct btd_adv_manager *btd_adv_manager_new(struct btd_adapter *adapter);
 void btd_adv_manager_destroy(struct btd_adv_manager *manager);
+void btd_adv_manager_refresh(struct btd_adv_manager *manager);
-- 
2.14.3


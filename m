Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] advertising: Fix creating another mgmt instance
Date: Wed, 28 Feb 2018 14:18:24 +0200
Message-Id: <20180228121824.17256-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

adapter already instanciate a instance of mgmt so just reuse that
instead of creating a new one.
---
 src/adapter.c     |  2 +-
 src/advertising.c | 15 ++++++++-------
 src/advertising.h |  3 ++-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0fc9f840e..9f084da5e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7973,7 +7973,7 @@ static int adapter_register(struct btd_adapter *adapter)
 		return -EINVAL;
 	}
 
-	adapter->adv_manager = btd_adv_manager_new(adapter);
+	adapter->adv_manager = btd_adv_manager_new(adapter, adapter->mgmt);
 
 	db = btd_gatt_database_get_db(adapter->database);
 	adapter->db_id = gatt_db_register(db, services_modified,
diff --git a/src/advertising.c b/src/advertising.c
index 38d2a2d1f..5c9ae6236 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -17,8 +17,6 @@
  *
  */
 
-#include "advertising.h"
-
 #include <stdint.h>
 #include <stdbool.h>
 #include <errno.h>
@@ -39,6 +37,7 @@
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
+#include "advertising.h"
 
 #define LE_ADVERTISING_MGR_IFACE "org.bluez.LEAdvertisingManager1"
 #define LE_ADVERTISEMENT_IFACE "org.bluez.LEAdvertisement1"
@@ -1046,14 +1045,15 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 		remove_advertising(manager, 0);
 }
 
-static struct btd_adv_manager *manager_create(struct btd_adapter *adapter)
+static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
+						struct mgmt *mgmt)
 {
 	struct btd_adv_manager *manager;
 
 	manager = new0(struct btd_adv_manager, 1);
 	manager->adapter = adapter;
 
-	manager->mgmt = mgmt_new_default();
+	manager->mgmt = mgmt_ref(mgmt);
 
 	if (!manager->mgmt) {
 		error("Failed to access management interface");
@@ -1087,14 +1087,15 @@ fail:
 	return NULL;
 }
 
-struct btd_adv_manager *btd_adv_manager_new(struct btd_adapter *adapter)
+struct btd_adv_manager *btd_adv_manager_new(struct btd_adapter *adapter,
+							struct mgmt *mgmt)
 {
 	struct btd_adv_manager *manager;
 
-	if (!adapter)
+	if (!adapter || !mgmt)
 		return NULL;
 
-	manager = manager_create(adapter);
+	manager = manager_create(adapter, mgmt);
 	if (!manager)
 		return NULL;
 
diff --git a/src/advertising.h b/src/advertising.h
index d98c4b864..50d86674b 100644
--- a/src/advertising.h
+++ b/src/advertising.h
@@ -20,6 +20,7 @@
 struct btd_adapter;
 struct btd_adv_manager;
 
-struct btd_adv_manager *btd_adv_manager_new(struct btd_adapter *adapter);
+struct btd_adv_manager *btd_adv_manager_new(struct btd_adapter *adapter,
+							struct mgmt *mgmt);
 void btd_adv_manager_destroy(struct btd_adv_manager *manager);
 void btd_adv_manager_refresh(struct btd_adv_manager *manager);
-- 
2.14.3


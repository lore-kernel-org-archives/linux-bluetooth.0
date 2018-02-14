Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] adapter: Fix initializing GATT server for BR/EDR only controllers
Date: Wed, 14 Feb 2018 15:58:15 +0200
Message-Id: <20180214135815.18250-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Controller that do not support LE bearer shall not use GATT server for
anything.
---
v2: Add check for main_opts.mode and remove change to main.conf

 src/adapter.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index bd5c1e150..fcb102411 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7745,6 +7745,13 @@ static int adapter_register(struct btd_adapter *adapter)
 		agent_unref(agent);
 	}
 
+	/* Don't start GATT database and advertising managers on
+	 * non-LE controllers.
+	 */
+	if (!(adapter->supported_settings & MGMT_SETTING_LE) ||
+					main_opts.mode == BT_MODE_BREDR)
+		goto load;
+
 	adapter->database = btd_gatt_database_new(adapter);
 	if (!adapter->database) {
 		btd_error(adapter->dev_id,
@@ -7753,18 +7760,14 @@ static int adapter_register(struct btd_adapter *adapter)
 		return -EINVAL;
 	}
 
-	/* Don't start advertising managers on non-LE controllers. */
-	if (adapter->supported_settings & MGMT_SETTING_LE)
-		adapter->adv_manager = btd_adv_manager_new(adapter);
-	else
-		btd_info(adapter->dev_id,
-			"LEAdvertisingManager skipped, LE unavailable");
+	adapter->adv_manager = btd_adv_manager_new(adapter);
 
 	db = btd_gatt_database_get_db(adapter->database);
 	adapter->db_id = gatt_db_register(db, services_modified,
 							services_modified,
 							adapter, NULL);
 
+load:
 	load_config(adapter);
 	fix_storage(adapter);
 	load_drivers(adapter);
-- 
2.14.3


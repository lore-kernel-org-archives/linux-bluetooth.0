Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] adapter: Fix initializing GATT server for BR/EDR only controllers
Date: Wed, 14 Feb 2018 13:41:33 +0200
Message-Id: <20180214114133.5349-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Controller that do not support LE bearer shall not use GATT server for
anything.
---
 src/adapter.c | 14 ++++++++------
 src/main.conf |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index bd5c1e150..8b785dcfd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7745,6 +7745,12 @@ static int adapter_register(struct btd_adapter *adapter)
 		agent_unref(agent);
 	}
 
+	/* Don't start GATT database and advertising managers on
+	 * non-LE controllers.
+	 */
+	if (!(adapter->supported_settings & MGMT_SETTING_LE))
+		goto load;
+
 	adapter->database = btd_gatt_database_new(adapter);
 	if (!adapter->database) {
 		btd_error(adapter->dev_id,
@@ -7753,18 +7759,14 @@ static int adapter_register(struct btd_adapter *adapter)
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
diff --git a/src/main.conf b/src/main.conf
index 21986b386..b3f8bb274 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -42,7 +42,7 @@
 # Restricts all controllers to the specified transport. Default value
 # is "dual", i.e. both BR/EDR and LE enabled (when supported by the HW).
 # Possible values: "dual", "bredr", "le"
-#ControllerMode = dual
+ControllerMode = bredr
 
 # Enables Multi Profile Specification support. This allows to specify if
 # system supports only Multiple Profiles Single Device (MPSD) configuration
-- 
2.14.3


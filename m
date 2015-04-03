Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v10 12/12] core: Only start Advertising Manager when experimental
Date: Fri,  3 Apr 2015 15:02:12 -0700
Message-Id: <1428098532-5257-13-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1428098532-5257-1-git-send-email-jamuraa@chromium.org>
References: <1428098532-5257-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check the experimental flag, there is no value in starting the
Advertising Manager when there is no method for advertising.

This also makes startup quieter when experimental is not set.
---
 src/adapter.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ccc67fc..7ffd302 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7334,16 +7334,14 @@ static int adapter_register(struct btd_adapter *adapter)
 		return -EINVAL;
 	}
 
-	/* Don't start advertising managers on non-LE controllers. */
-	if (adapter->supported_settings & MGMT_SETTING_LE) {
-		adapter->adv_manager = btd_advertising_manager_new(adapter);
-
-		/* LEAdvertisingManager1 is experimental so optional */
-		if (!adapter->adv_manager)
-			error("Failed to register LEAdvertisingManager1 "
-						"interface for adapter");
-	} else {
-		info("Not starting LEAdvertisingManager, LE not supported");
+	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
+		/* Don't start advertising managers on non-LE controllers. */
+		if (adapter->supported_settings & MGMT_SETTING_LE) {
+			adapter->adv_manager =
+					btd_advertising_manager_new(adapter);
+		} else {
+			info("LEAdvertisingManager skipped, LE unavailable");
+		}
 	}
 
 	db = btd_gatt_database_get_db(adapter->database);
-- 
2.2.0.rc0.207.ga3a616c


Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ] core/advertising: Don't expose with no kernel support
Date: Wed, 29 Apr 2015 15:49:56 -0700
Message-Id: <1430347796-9771-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently we expose LEAdvertisingManager1 even if there isn't kernel
support for the MGMT command which implements the feature.  This changes
it to be registered after we confirm with MGMT that both Add Advertising
is available and that a non-zero number of advertisements can be added.
---
 src/advertising.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index cd78584..0eb489a 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -730,6 +730,16 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 
 	manager->max_adv_len = feat->max_adv_data_len;
 	manager->max_ads = feat->max_instances;
+
+	if (manager->max_ads == 0)
+		return;
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					adapter_get_path(manager->adapter),
+					LE_ADVERTISING_MGR_IFACE,
+					methods, NULL, NULL, manager,
+					advertising_manager_destroy))
+		error("Failed to register " LE_ADVERTISING_MGR_IFACE);
 }
 
 static struct btd_advertising *
@@ -761,16 +771,6 @@ advertising_manager_create(struct btd_adapter *adapter)
 		return NULL;
 	}
 
-	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-						adapter_get_path(adapter),
-						LE_ADVERTISING_MGR_IFACE,
-						methods, NULL, NULL, manager,
-						advertising_manager_destroy)) {
-		error("Failed to register " LE_ADVERTISING_MGR_IFACE);
-		free(manager);
-		return NULL;
-	}
-
 	manager->ads = queue_new();
 
 	manager->next_instance_id = 1;
-- 
2.2.0.rc0.207.ga3a616c


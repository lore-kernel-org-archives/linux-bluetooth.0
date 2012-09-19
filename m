Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/2] proximity: Split profile driver into Monitor and Reporter
Date: Wed, 19 Sep 2012 16:27:18 +0200
Message-ID: <1348064839-5602-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Proximity Monitor interface is registered for each GATT device since profile
driver matches by GATT_UUID which is intended only for Reporter role.

This patches splits Proximity profile driver into two separate drivers for
Monitor and Reporter role to register interfaces properly.
---
 profiles/proximity/manager.c  | 29 +++++++++++++++++++++--------
 profiles/proximity/reporter.c |  2 +-
 profiles/proximity/reporter.h |  2 +-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index 39c2bfe..df87cb0 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -61,8 +61,6 @@ static int attio_device_probe(struct btd_device *device, GSList *uuids)
 	struct gatt_primary *linkloss, *txpower, *immediate;
 	GSList *l, *primaries;
 
-	reporter_device_probe(device);
-
 	primaries = btd_device_get_primaries(device);
 
 	l = g_slist_find_custom(primaries, IMMEDIATE_ALERT_UUID,
@@ -81,15 +79,21 @@ static int attio_device_probe(struct btd_device *device, GSList *uuids)
 static void attio_device_remove(struct btd_device *device)
 {
 	monitor_unregister(device);
-	reporter_device_remove(device);
 }
 
-static struct btd_profile pxp_profile = {
-	.name		= "Proximity GATT Driver",
-	.remote_uuids	= BTD_UUIDS(GATT_UUID, IMMEDIATE_ALERT_UUID,
+static struct btd_profile pxp_monitor_profile = {
+	.name		= "Proximity Monitor GATT Driver",
+	.remote_uuids	= BTD_UUIDS(IMMEDIATE_ALERT_UUID,
 						LINK_LOSS_UUID, TX_POWER_UUID),
 	.device_probe	= attio_device_probe,
 	.device_remove	= attio_device_remove,
+};
+
+static struct btd_profile pxp_reporter_profile = {
+	.name		= "Proximity Reporter GATT Driver",
+	.remote_uuids	= BTD_UUIDS(GATT_UUID),
+	.device_probe	= reporter_device_probe,
+	.device_remove	= reporter_device_remove,
 
 	.adapter_probe	= reporter_adapter_probe,
 	.adapter_remove	= reporter_adapter_remove,
@@ -121,10 +125,19 @@ int proximity_manager_init(GKeyFile *config)
 {
 	load_config_file(config);
 
-	return btd_profile_register(&pxp_profile);
+	if (btd_profile_register(&pxp_monitor_profile) < 0)
+		return -1;
+
+	if (btd_profile_register(&pxp_reporter_profile) < 0) {
+		btd_profile_unregister(&pxp_monitor_profile);
+		return -1;
+	}
+
+	return 0;
 }
 
 void proximity_manager_exit(void)
 {
-	btd_profile_unregister(&pxp_profile);
+	btd_profile_unregister(&pxp_monitor_profile);
+	btd_profile_unregister(&pxp_reporter_profile);
 }
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 3843018..ae6af09 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -222,7 +222,7 @@ static void register_reporter_device(struct btd_device *device,
 	radapter->devices = g_slist_prepend(radapter->devices, device);
 }
 
-int reporter_device_probe(struct btd_device *device)
+int reporter_device_probe(struct btd_device *device, GSList *uuids)
 {
 	struct reporter_adapter *radapter;
 	struct btd_adapter *adapter = device_get_adapter(device);
diff --git a/profiles/proximity/reporter.h b/profiles/proximity/reporter.h
index d038c0e..9b4b3a5 100644
--- a/profiles/proximity/reporter.h
+++ b/profiles/proximity/reporter.h
@@ -37,7 +37,7 @@ enum {
 };
 
 void reporter_device_remove(struct btd_device *device);
-int reporter_device_probe(struct btd_device *device);
+int reporter_device_probe(struct btd_device *device, GSList *uuids);
 
 int reporter_adapter_probe(struct btd_adapter *adapter);
 void reporter_adapter_remove(struct btd_adapter *adapter);
-- 
1.7.11.3


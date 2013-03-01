Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 4/7] proximity: Split monitor into three btd_profile
Date: Fri,  1 Mar 2013 14:59:10 +0100
Message-Id: <1362146353-23799-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1362146353-23799-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1362146353-23799-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Split into three btd_profile such that each of them handles one single
UUID.
---
 profiles/proximity/manager.c | 104 +++++++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 28 deletions(-)

diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index 3182596..7579be5 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -48,42 +48,79 @@ static struct enabled enabled  = {
 	.findme = TRUE,
 };
 
-static int monitor_device_probe(struct btd_profile *p,
+static int monitor_linkloss_probe(struct btd_profile *p,
 				struct btd_device *device, GSList *uuids)
 {
-	struct gatt_primary *linkloss, *txpower, *immediate;
-	int err = 0;
+	struct gatt_primary *linkloss;
 
-	immediate = btd_device_get_primary(device, IMMEDIATE_ALERT_UUID);
-	txpower = btd_device_get_primary(device, TX_POWER_UUID);
 	linkloss = btd_device_get_primary(device, LINK_LOSS_UUID);
+	if (linkloss == NULL)
+		return -1;
+
+	return monitor_register_linkloss(device, &enabled, linkloss);
+}
+
+static int monitor_immediate_probe(struct btd_profile *p,
+				struct btd_device *device, GSList *uuids)
+{
+	struct gatt_primary *immediate;
+
+	immediate = btd_device_get_primary(device, IMMEDIATE_ALERT_UUID);
+	if (immediate == NULL)
+		return -1;
 
-	if (linkloss)
-		err = monitor_register_linkloss(device, &enabled, linkloss);
+	return monitor_register_immediate(device, &enabled, immediate);
+}
 
-	if (err >= 0 && immediate)
-		err = monitor_register_immediate(device, &enabled, immediate);
+static int monitor_txpower_probe(struct btd_profile *p,
+				struct btd_device *device, GSList *uuids)
+{
+	struct gatt_primary *txpower;
 
-	if (err >= 0 && txpower)
-		err = monitor_register_txpower(device, &enabled, txpower);
+	txpower = btd_device_get_primary(device, TX_POWER_UUID);
+	if (txpower == NULL)
+		return -1;
 
-	return err;
+	return monitor_register_txpower(device, &enabled, txpower);
 }
 
-static void monitor_device_remove(struct btd_profile *p,
+static void monitor_linkloss_remove(struct btd_profile *p,
 						struct btd_device *device)
 {
-	monitor_unregister_txpower(device);
-	monitor_unregister_immediate(device);
 	monitor_unregister_linkloss(device);
 }
 
-static struct btd_profile pxp_monitor_profile = {
-	.name		= "Proximity Monitor GATT Driver",
-	.remote_uuids	= BTD_UUIDS(IMMEDIATE_ALERT_UUID,
-						LINK_LOSS_UUID, TX_POWER_UUID),
-	.device_probe	= monitor_device_probe,
-	.device_remove	= monitor_device_remove,
+static void monitor_immediate_remove(struct btd_profile *p,
+						struct btd_device *device)
+{
+	monitor_unregister_immediate(device);
+}
+
+static void monitor_txpower_remove(struct btd_profile *p,
+						struct btd_device *device)
+{
+	monitor_unregister_txpower(device);
+}
+
+static struct btd_profile pxp_monitor_linkloss_profile = {
+	.name		= "proximity-linkloss",
+	.remote_uuids	= BTD_UUIDS(LINK_LOSS_UUID),
+	.device_probe	= monitor_linkloss_probe,
+	.device_remove	= monitor_linkloss_remove,
+};
+
+static struct btd_profile pxp_monitor_immediate_profile = {
+	.name		= "proximity-immediate",
+	.remote_uuids	= BTD_UUIDS(IMMEDIATE_ALERT_UUID),
+	.device_probe	= monitor_immediate_probe,
+	.device_remove	= monitor_immediate_remove,
+};
+
+static struct btd_profile pxp_monitor_txpower_profile = {
+	.name		= "proximity-txpower",
+	.remote_uuids	= BTD_UUIDS(TX_POWER_UUID),
+	.device_probe	= monitor_txpower_probe,
+	.device_remove	= monitor_txpower_remove,
 };
 
 static struct btd_profile pxp_reporter_profile = {
@@ -122,19 +159,30 @@ int proximity_manager_init(GKeyFile *config)
 {
 	load_config_file(config);
 
-	if (btd_profile_register(&pxp_monitor_profile) < 0)
-		return -1;
+	if (btd_profile_register(&pxp_monitor_linkloss_profile) < 0)
+		goto fail;
 
-	if (btd_profile_register(&pxp_reporter_profile) < 0) {
-		btd_profile_unregister(&pxp_monitor_profile);
-		return -1;
-	}
+	if (btd_profile_register(&pxp_monitor_immediate_profile) < 0)
+		goto fail;
+
+	if (btd_profile_register(&pxp_monitor_txpower_profile) < 0)
+		goto fail;
+
+	if (btd_profile_register(&pxp_reporter_profile) < 0)
+		goto fail;
 
 	return 0;
+
+fail:
+	proximity_manager_exit();
+
+	return -1;
 }
 
 void proximity_manager_exit(void)
 {
-	btd_profile_unregister(&pxp_monitor_profile);
 	btd_profile_unregister(&pxp_reporter_profile);
+	btd_profile_unregister(&pxp_monitor_txpower_profile);
+	btd_profile_unregister(&pxp_monitor_immediate_profile);
+	btd_profile_unregister(&pxp_monitor_linkloss_profile);
 }
-- 
1.8.1


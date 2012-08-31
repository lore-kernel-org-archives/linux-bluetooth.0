Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 4/7] proximity: Move reporter device driver registration to manager
Date: Fri, 31 Aug 2012 14:48:30 +0200
Message-ID: <1346417314-25109-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Device driver for reporter is registered each time new adapter is probed
so in case multiple adapters are used it will be registered multiple
times for no reason.

This patch moves reporter device driver registration to manager so it
is registered only once, when plugin is loaded.
---
 profiles/proximity/manager.c  | 21 +++++++++++++++++++--
 profiles/proximity/reporter.c | 16 ++--------------
 profiles/proximity/reporter.h |  3 +++
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/profiles/proximity/manager.c b/profiles/proximity/manager.c
index 97e9795..4998a9e 100644
--- a/profiles/proximity/manager.c
+++ b/profiles/proximity/manager.c
@@ -85,6 +85,15 @@ static struct btd_device_driver monitor_driver = {
 	.remove = attio_device_remove,
 };
 
+
+/* device driver for tracking remote GATT client devices */
+static struct btd_device_driver reporter_device_driver = {
+	.name = "Proximity GATT Reporter Device Tracker Driver",
+	.uuids = BTD_UUIDS(GATT_UUID),
+	.probe = reporter_device_probe,
+	.remove = reporter_device_remove,
+};
+
 static struct btd_adapter_driver reporter_server_driver = {
 	.name = "Proximity GATT Reporter Driver",
 	.probe = reporter_adapter_probe,
@@ -123,13 +132,20 @@ int proximity_manager_init(GKeyFile *config)
 	if (ret < 0)
 		goto fail_monitor;
 
+	ret = btd_register_device_driver(&reporter_device_driver);
+	if (ret < 0)
+		goto fail_reporter_device;
+
 	ret = btd_register_adapter_driver(&reporter_server_driver);
 	if (ret < 0)
-		goto fail_reporter;
+		goto fail_reporter_server;
 
 	return 0;
 
-fail_reporter:
+fail_reporter_server:
+	btd_unregister_device_driver(&reporter_device_driver);
+
+fail_reporter_device:
 	btd_unregister_device_driver(&monitor_driver);
 
 fail_monitor:
@@ -139,5 +155,6 @@ fail_monitor:
 void proximity_manager_exit(void)
 {
 	btd_unregister_device_driver(&monitor_driver);
+	btd_unregister_device_driver(&reporter_device_driver);
 	btd_unregister_adapter_driver(&reporter_server_driver);
 }
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index ff9fd0c..c221fae 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -220,7 +220,7 @@ static void register_reporter_device(struct btd_device *device,
 	radapter->devices = g_slist_prepend(radapter->devices, device);
 }
 
-static int reporter_device_probe(struct btd_device *device, GSList *uuids)
+int reporter_device_probe(struct btd_device *device, GSList *uuids)
 {
 	struct reporter_adapter *radapter;
 	struct btd_adapter *adapter = device_get_adapter(device);
@@ -233,7 +233,7 @@ static int reporter_device_probe(struct btd_device *device, GSList *uuids)
 	return 0;
 }
 
-static void reporter_device_remove(struct btd_device *device)
+void reporter_device_remove(struct btd_device *device)
 {
 	struct reporter_adapter *radapter;
 	struct btd_adapter *adapter = device_get_adapter(device);
@@ -245,14 +245,6 @@ static void reporter_device_remove(struct btd_device *device)
 	unregister_reporter_device(device, radapter);
 }
 
-/* device driver for tracking remote GATT client devices */
-static struct btd_device_driver reporter_device_driver = {
-	.name = "Proximity GATT Reporter Device Tracker Driver",
-	.uuids = BTD_UUIDS(GATT_UUID),
-	.probe = reporter_device_probe,
-	.remove = reporter_device_remove,
-};
-
 int reporter_adapter_probe(struct btd_adapter *adapter)
 {
 	struct reporter_adapter *radapter;
@@ -269,8 +261,6 @@ int reporter_adapter_probe(struct btd_adapter *adapter)
 	register_tx_power(adapter);
 	imm_alert_register(adapter);
 
-	btd_register_device_driver(&reporter_device_driver);
-
 	reporter_adapters = g_slist_prepend(reporter_adapters, radapter);
 	DBG("Proximity Reporter for adapter %p", adapter);
 
@@ -283,8 +273,6 @@ void reporter_adapter_remove(struct btd_adapter *adapter)
 	if (!radapter)
 		return;
 
-	btd_unregister_device_driver(&reporter_device_driver);
-
 	g_slist_foreach(radapter->devices, unregister_reporter_device,
 								radapter);
 
diff --git a/profiles/proximity/reporter.h b/profiles/proximity/reporter.h
index ae5ddf6..c77c3af 100644
--- a/profiles/proximity/reporter.h
+++ b/profiles/proximity/reporter.h
@@ -36,6 +36,9 @@ enum {
 	HIGH_ALERT = 0x02,
 };
 
+int reporter_device_probe(struct btd_device *device, GSList *uuids);
+void reporter_device_remove(struct btd_device *device);
+
 int reporter_adapter_probe(struct btd_adapter *adapter);
 void reporter_adapter_remove(struct btd_adapter *adapter);
 
-- 
1.7.11.3


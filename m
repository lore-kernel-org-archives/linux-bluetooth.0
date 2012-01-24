Return-Path: <cyrus@holtmann.org>
From: Vishal Agarwal <vishal.agarwal@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <naresh.gupta@stericsson.com>,
	Vishal Agarwal <vishal.agarwal@stericsson.com>
Subject: [PATCH BlueZ v3 2/2] Add-support-for-proximity-UUIDs-in-adapter
Date: Tue, 24 Jan 2012 09:20:00 +0530
Message-ID: <1327377000-17048-3-git-send-email-vishal.agarwal@stericsson.com>
In-Reply-To: <1327377000-17048-1-git-send-email-vishal.agarwal@stericsson.com>
References: <1327377000-17048-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the Proximity services UUIDs to adapter during
initialization and removes during deinitialization.

---
 lib/sdp.h           |    3 +++
 proximity/manager.c |   23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/lib/sdp.h b/lib/sdp.h
index 5f7d271..6586c89 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -147,6 +147,9 @@ extern "C" {
 #define HDP_SINK_SVCLASS_ID		0x1402
 #define APPLE_AGENT_SVCLASS_ID		0x2112
 #define GENERIC_ATTRIB_SVCLASS_ID	0x1801
+#define IMMEDIATE_ALERT_SVCLASS_ID	0x1802
+#define LINK_LOSS_SVCLASS_ID		0x1803
+#define TX_POWER_SVCLASS_ID		0x1804
 
 /*
  * Standard profile descriptor identifiers; note these
diff --git a/proximity/manager.c b/proximity/manager.c
index a767554..0dc678c 100644
--- a/proximity/manager.c
+++ b/proximity/manager.c
@@ -83,6 +83,21 @@ static void attio_device_remove(struct btd_device *device)
 	monitor_unregister(connection, device);
 }
 
+static int proximity_adapter_probe(struct btd_adapter *adapter)
+{
+	adapter_add_primary_uuid(adapter, LINK_LOSS_SVCLASS_ID);
+	adapter_add_primary_uuid(adapter, IMMEDIATE_ALERT_SVCLASS_ID);
+	adapter_add_primary_uuid(adapter, TX_POWER_SVCLASS_ID);
+	return 0;
+}
+
+static void proximity_adapter_remove(struct btd_adapter *adapter)
+{
+	adapter_remove_primary_uuid(adapter, LINK_LOSS_SVCLASS_ID);
+	adapter_remove_primary_uuid(adapter, IMMEDIATE_ALERT_SVCLASS_ID);
+	adapter_remove_primary_uuid(adapter, TX_POWER_SVCLASS_ID);
+}
+
 static struct btd_device_driver monitor_driver = {
 	.name = "Proximity GATT Driver",
 	.uuids = BTD_UUIDS(IMMEDIATE_ALERT_UUID, LINK_LOSS_UUID, TX_POWER_UUID),
@@ -90,6 +105,12 @@ static struct btd_device_driver monitor_driver = {
 	.remove = attio_device_remove,
 };
 
+static struct btd_adapter_driver proximity_adapter = {
+	.name = "Proximity",
+	.probe = proximity_adapter_probe,
+	.remove = proximity_adapter_remove,
+};
+
 static void load_config_file(GKeyFile *config)
 {
 	char **list;
@@ -118,6 +139,7 @@ int proximity_manager_init(DBusConnection *conn, GKeyFile *config)
 
 	load_config_file(config);
 
+	btd_register_adapter_driver(&proximity_adapter);
 	/* TODO: Register Proximity Monitor/Reporter drivers */
 	ret = btd_register_device_driver(&monitor_driver);
 	if (ret < 0)
@@ -132,5 +154,6 @@ void proximity_manager_exit(void)
 {
 	reporter_exit();
 	btd_unregister_device_driver(&monitor_driver);
+	btd_unregister_adapter_driver(&proximity_adapter);
 	dbus_connection_unref(connection);
 }
-- 
1.7.0.4


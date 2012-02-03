Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <claudio.takahasi@openbossa.org>, <anderson.lizardo@openbossa.org>,
	Arik Nemtsov <arik@wizery.com>
Subject: [PATCH v3] proximity: make reporter work per-adapter
Date: Fri,  3 Feb 2012 23:34:04 +0200
Message-Id: <1328304844-21149-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Register an adapter driver for reporter and add the adapter argument in
appropriate places.
---
v2->3: rebased, removed signed-off-by

 proximity/manager.c  |   28 +++++++++++++++++++-----
 proximity/reporter.c |   57 +++++++++++++++++++------------------------------
 proximity/reporter.h |    4 +-
 3 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/proximity/manager.c b/proximity/manager.c
index a767554..336d8f7 100644
--- a/proximity/manager.c
+++ b/proximity/manager.c
@@ -84,12 +84,18 @@ static void attio_device_remove(struct btd_device *device)
 }
 
 static struct btd_device_driver monitor_driver = {
-	.name = "Proximity GATT Driver",
+	.name = "Proximity GATT Monitor Driver",
 	.uuids = BTD_UUIDS(IMMEDIATE_ALERT_UUID, LINK_LOSS_UUID, TX_POWER_UUID),
 	.probe = attio_device_probe,
 	.remove = attio_device_remove,
 };
 
+static struct btd_adapter_driver reporter_server_driver = {
+	.name = "Proximity GATT Reporter Driver",
+	.probe = reporter_init,
+	.remove = reporter_exit,
+};
+
 static void load_config_file(GKeyFile *config)
 {
 	char **list;
@@ -118,19 +124,29 @@ int proximity_manager_init(DBusConnection *conn, GKeyFile *config)
 
 	load_config_file(config);
 
-	/* TODO: Register Proximity Monitor/Reporter drivers */
+	connection = dbus_connection_ref(conn);
+
 	ret = btd_register_device_driver(&monitor_driver);
 	if (ret < 0)
-		return ret;
+		goto fail_monitor;
 
-	connection = dbus_connection_ref(conn);
+	ret = btd_register_adapter_driver(&reporter_server_driver);
+	if (ret < 0)
+		goto fail_reporter;
+
+	return 0;
 
-	return reporter_init();
+fail_reporter:
+	btd_unregister_device_driver(&monitor_driver);
+
+fail_monitor:
+	dbus_connection_unref(connection);
+	return ret;
 }
 
 void proximity_manager_exit(void)
 {
-	reporter_exit();
 	btd_unregister_device_driver(&monitor_driver);
+	btd_unregister_adapter_driver(&reporter_server_driver);
 	dbus_connection_unref(connection);
 }
diff --git a/proximity/reporter.c b/proximity/reporter.c
index b29c75b..737faf9 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -52,7 +52,7 @@ enum {
 
 static uint16_t tx_power_handle;
 
-static void register_link_loss(void)
+static void register_link_loss(struct btd_adapter *adapter)
 {
 	uint16_t start_handle, h;
 	const int svc_size = 3;
@@ -60,8 +60,7 @@ static void register_link_loss(void)
 	bt_uuid_t uuid;
 
 	bt_uuid16_create(&uuid, LINK_LOSS_SVC_UUID);
-	/* FIXME: Provide the adapter in next function */
-	start_handle = attrib_db_find_avail(NULL, &uuid, svc_size);
+	start_handle = attrib_db_find_avail(adapter, &uuid, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -74,27 +73,24 @@ static void register_link_loss(void)
 	/* Primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(LINK_LOSS_SVC_UUID, &atval[0]);
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Alert level characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_WRITE;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(ALERT_LEVEL_CHR_UUID, &atval[3]);
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Alert level value */
 	bt_uuid16_create(&uuid, ALERT_LEVEL_CHR_UUID);
 	att_put_u8(NO_ALERT, &atval[0]);
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NONE, atval, 1);
+	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NONE, atval, 1);
 
 	g_assert(h - start_handle == svc_size);
 }
 
-static void register_tx_power(void)
+static void register_tx_power(struct btd_adapter *adapter)
 {
 	uint16_t start_handle, h;
 	const int svc_size = 4;
@@ -102,8 +98,7 @@ static void register_tx_power(void)
 	bt_uuid_t uuid;
 
 	bt_uuid16_create(&uuid, TX_POWER_SVC_UUID);
-	/* FIXME: Provide the adapter in next function */
-	start_handle = attrib_db_find_avail(NULL, &uuid, svc_size);
+	start_handle = attrib_db_find_avail(adapter, &uuid, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -116,35 +111,31 @@ static void register_tx_power(void)
 	/* Primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(TX_POWER_SVC_UUID, &atval[0]);
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Power level characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_NOTIFY;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(POWER_LEVEL_CHR_UUID, &atval[3]);
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Power level value */
 	bt_uuid16_create(&uuid, POWER_LEVEL_CHR_UUID);
 	att_put_u8(0x00, &atval[0]);
 	tx_power_handle = h;
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
+	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
 
 	/* Client characteristic configuration */
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 	atval[0] = 0x00;
 	atval[1] = 0x00;
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NONE, atval, 2);
+	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NONE, atval, 2);
 
 	g_assert(h - start_handle == svc_size);
 }
 
-static void register_immediate_alert(void)
+static void register_immediate_alert(struct btd_adapter *adapter)
 {
 	uint16_t start_handle, h;
 	const int svc_size = 3;
@@ -152,8 +143,7 @@ static void register_immediate_alert(void)
 	bt_uuid_t uuid;
 
 	bt_uuid16_create(&uuid, IMMEDIATE_ALERT_SVC_UUID);
-	/* FIXME: Provide the adapter in next function */
-	start_handle = attrib_db_find_avail(NULL, &uuid, svc_size);
+	start_handle = attrib_db_find_avail(adapter, &uuid, svc_size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
 		return;
@@ -166,42 +156,39 @@ static void register_immediate_alert(void)
 	/* Primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(IMMEDIATE_ALERT_SVC_UUID, &atval[0]);
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* Alert level characteristic */
 	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_WRITE_WITHOUT_RESP;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(ALERT_LEVEL_CHR_UUID, &atval[3]);
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* Alert level value */
 	bt_uuid16_create(&uuid, ALERT_LEVEL_CHR_UUID);
 	att_put_u8(NO_ALERT, &atval[0]);
-	/* FIXME: Provide the adapter in next function */
-	attrib_db_add(NULL, h++, &uuid, ATT_NONE, ATT_NONE, atval, 1);
+	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NONE, atval, 1);
 
 	g_assert(h - start_handle == svc_size);
 }
 
-int reporter_init(void)
+int reporter_init(struct btd_adapter *adapter)
 {
 	if (!main_opts.attrib_server) {
 		DBG("Attribute server is disabled");
 		return -1;
 	}
 
-	DBG("Proximity Reporter");
+	DBG("Proximity Reporter for adapter %p", adapter);
 
-	register_link_loss();
-	register_tx_power();
-	register_immediate_alert();
+	register_link_loss(adapter);
+	register_tx_power(adapter);
+	register_immediate_alert(adapter);
 
 	return 0;
 }
 
-void reporter_exit(void)
+void reporter_exit(struct btd_adapter *adapter)
 {
 }
diff --git a/proximity/reporter.h b/proximity/reporter.h
index ea6b83d..2b18446 100644
--- a/proximity/reporter.h
+++ b/proximity/reporter.h
@@ -22,5 +22,5 @@
  *
  */
 
-int reporter_init(void);
-void reporter_exit(void);
+int reporter_init(struct btd_adapter *adapter);
+void reporter_exit(struct btd_adapter *adapter);
-- 
1.7.5.4


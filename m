Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v4 2/3] GATT: Rename AttributeServer switch
Date: Mon, 19 Mar 2012 16:57:52 +0200
Message-Id: <1332169073-15885-3-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1332169073-15885-1-git-send-email-chen.ganir@ti.com>
References: <1332169073-15885-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Rename the AttributeServer main.conf option to EnableGatt and
change its purpose to enable/disable all GATT related activity.
---
 alert/main.c           |    4 ++--
 plugins/gatt-example.c |    4 ++--
 proximity/reporter.c   |    2 +-
 src/adapter.c          |    8 ++++----
 src/hcid.h             |    2 +-
 src/main.c             |    4 ++--
 time/main.c            |    4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/alert/main.c b/alert/main.c
index 25100e9..6e2e058 100644
--- a/alert/main.c
+++ b/alert/main.c
@@ -36,7 +36,7 @@
 
 static int alert_init(void)
 {
-	if (!main_opts.attrib_server) {
+	if (!main_opts.gatt_enabled) {
 		DBG("Attribute server is disabled");
 		return -1;
 	}
@@ -46,7 +46,7 @@ static int alert_init(void)
 
 static void alert_exit(void)
 {
-	if (!main_opts.attrib_server)
+	if (!main_opts.gatt_enabled)
 		return;
 
 	alert_server_exit();
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index f026761..165d218 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -560,7 +560,7 @@ static struct btd_adapter_driver gatt_example_adapter_driver = {
 
 static int gatt_example_init(void)
 {
-	if (!main_opts.attrib_server) {
+	if (!main_opts.gatt_enabled) {
 		DBG("Attribute server is disabled");
 		return -ENOTSUP;
 	}
@@ -570,7 +570,7 @@ static int gatt_example_init(void)
 
 static void gatt_example_exit(void)
 {
-	if (!main_opts.attrib_server)
+	if (!main_opts.gatt_enabled)
 		return;
 
 	btd_unregister_adapter_driver(&gatt_example_adapter_driver);
diff --git a/proximity/reporter.c b/proximity/reporter.c
index 9777574..d4a4c96 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -172,7 +172,7 @@ static void register_immediate_alert(struct btd_adapter *adapter)
 
 int reporter_init(struct btd_adapter *adapter)
 {
-	if (!main_opts.attrib_server) {
+	if (!main_opts.gatt_enabled) {
 		DBG("Attribute server is disabled");
 		return -1;
 	}
diff --git a/src/adapter.c b/src/adapter.c
index acb845e..13f3683 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -698,7 +698,7 @@ void btd_adapter_class_changed(struct btd_adapter *adapter, uint32_t new_class)
 
 	adapter->dev_class = new_class;
 
-	if (main_opts.attrib_server) {
+	if (main_opts.gatt_enabled) {
 		/* Removes service class */
 		class[1] = class[1] & 0x1f;
 		attrib_gap_set(adapter, GATT_CHARAC_APPEARANCE, class, 2);
@@ -722,7 +722,7 @@ void adapter_name_changed(struct btd_adapter *adapter, const char *name)
 					ADAPTER_INTERFACE, "Name",
 					DBUS_TYPE_STRING, &name);
 
-	if (main_opts.attrib_server)
+	if (main_opts.gatt_enabled)
 		attrib_gap_set(adapter, GATT_CHARAC_DEVICE_NAME,
 				(const uint8_t *) name, strlen(name));
 }
@@ -2407,7 +2407,7 @@ gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
 
 	sdp_init_services_list(&adapter->bdaddr);
 
-	if (main_opts.attrib_server)
+	if (main_opts.gatt_enabled)
 		btd_adapter_gatt_server_start(adapter);
 
 	load_drivers(adapter);
@@ -2469,7 +2469,7 @@ void adapter_remove(struct btd_adapter *adapter)
 	g_slist_free(adapter->devices);
 
 	unload_drivers(adapter);
-	if (main_opts.attrib_server)
+	if (main_opts.gatt_enabled)
 		btd_adapter_gatt_server_stop(adapter);
 
 	g_slist_free(adapter->pin_callbacks);
diff --git a/src/hcid.h b/src/hcid.h
index 1987b7d..16a8ded 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -38,7 +38,7 @@ struct main_opts {
 	gboolean	reverse_sdp;
 	gboolean	name_resolv;
 	gboolean	debug_keys;
-	gboolean	attrib_server;
+	gboolean	gatt_enabled;
 
 	uint8_t		mode;
 	uint8_t		discov_interval;
diff --git a/src/main.c b/src/main.c
index 74ec3fa..a3e8c84 100644
--- a/src/main.c
+++ b/src/main.c
@@ -223,11 +223,11 @@ static void parse_config(GKeyFile *config)
 		main_opts.debug_keys = boolean;
 
 	boolean = g_key_file_get_boolean(config, "General",
-						"AttributeServer", &err);
+						"EnableGatt", &err);
 	if (err)
 		g_clear_error(&err);
 	else
-		main_opts.attrib_server = boolean;
+		main_opts.gatt_enabled = boolean;
 
 	main_opts.link_mode = HCI_LM_ACCEPT;
 
diff --git a/time/main.c b/time/main.c
index a4de0fe..cbcdb0d 100644
--- a/time/main.c
+++ b/time/main.c
@@ -36,7 +36,7 @@
 
 static int time_init(void)
 {
-	if (!main_opts.attrib_server) {
+	if (!main_opts.gatt_enabled) {
 		DBG("Attribute server is disabled");
 		return -1;
 	}
@@ -46,7 +46,7 @@ static int time_init(void)
 
 static void time_exit(void)
 {
-	if (!main_opts.attrib_server)
+	if (!main_opts.gatt_enabled)
 		return;
 
 	time_server_exit();
-- 
1.7.4.1


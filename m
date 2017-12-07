Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] shared/shell: Don't remove command from arguments
Date: Thu,  7 Dec 2017 10:21:47 -0200
Message-Id: <20171207122152.29743-2-luiz.dentz@gmail.com>
In-Reply-To: <20171207122152.29743-1-luiz.dentz@gmail.com>
References: <20171207122152.29743-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Maintain the original argc and argv so the callback has a chance to
parse the command if it has to.
---
 client/advertising.c |  14 +++----
 client/gatt.c        |  12 +++---
 client/main.c        | 112 +++++++++++++++++++++++++--------------------------
 src/shared/shell.c   |  18 ++++-----
 4 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 8f0360177..f0fd3599e 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -440,10 +440,10 @@ void ad_advertise_uuids(DBusConnection *conn, int argc, char *argv[])
 	ad.uuids = NULL;
 	ad.uuids_len = 0;
 
-	if (!argc || !strlen(argv[0]))
+	if (argc < 2 || !strlen(argv[1]))
 		return;
 
-	ad.uuids = g_strdupv(argv);
+	ad.uuids = g_strdupv(&argv[1]);
 	if (!ad.uuids) {
 		bt_shell_printf("Failed to parse input\n");
 		return;
@@ -467,10 +467,10 @@ void ad_advertise_service(DBusConnection *conn, int argc, char *argv[])
 
 	ad_clear_service();
 
-	if (!argc)
+	if (argc < 2)
 		return;
 
-	ad.service.uuid = g_strdup(argv[0]);
+	ad.service.uuid = g_strdup(argv[1]);
 	data = &ad.service.data;
 
 	for (i = 1; i < (unsigned int) argc; i++) {
@@ -511,10 +511,10 @@ void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
 
 	ad_clear_manufacturer();
 
-	if (argc == 0)
+	if (argc < 2)
 		return;
 
-	val = strtol(argv[0], &endptr, 0);
+	val = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || val > UINT16_MAX) {
 		bt_shell_printf("Invalid manufacture id\n");
 		return;
@@ -523,7 +523,7 @@ void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
 	ad.manufacturer.id = val;
 	data = &ad.manufacturer.data;
 
-	for (i = 1; i < (unsigned int) argc; i++) {
+	for (i = 2; i < (unsigned int) argc; i++) {
 		if (i >= G_N_ELEMENTS(data->data)) {
 			bt_shell_printf("Too much data\n");
 			ad_clear_manufacturer();
diff --git a/client/gatt.c b/client/gatt.c
index 4335d5295..059cae8f0 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1209,7 +1209,7 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 
 	service = g_new0(struct service, 1);
 	service->conn = conn;
-	service->uuid = g_strdup(argv[0]);
+	service->uuid = g_strdup(argv[1]);
 	service->path = g_strdup_printf("%s/service%p", APP_PATH, service);
 	service->primary = primary;
 
@@ -1254,7 +1254,7 @@ void gatt_unregister_service(DBusConnection *conn, GDBusProxy *proxy,
 {
 	struct service *service;
 
-	service = service_find(argv[0]);
+	service = service_find(argv[1]);
 	if (!service) {
 		bt_shell_printf("Failed to unregister service object\n");
 		return;
@@ -1708,7 +1708,7 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 
 	chrc = g_new0(struct chrc, 1);
 	chrc->service = service;
-	chrc->uuid = g_strdup(argv[0]);
+	chrc->uuid = g_strdup(argv[1]);
 	chrc->path = g_strdup_printf("%s/chrc%p", service->path, chrc);
 	chrc->flags = g_strsplit(argv[1], ",", -1);
 
@@ -1757,7 +1757,7 @@ void gatt_unregister_chrc(DBusConnection *conn, GDBusProxy *proxy,
 {
 	struct chrc *chrc;
 
-	chrc = chrc_find(argv[0]);
+	chrc = chrc_find(argv[1]);
 	if (!chrc) {
 		bt_shell_printf("Failed to unregister characteristic object\n");
 		return;
@@ -1900,7 +1900,7 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
 
 	desc = g_new0(struct desc, 1);
 	desc->chrc = g_list_last(service->chrcs)->data;
-	desc->uuid = g_strdup(argv[0]);
+	desc->uuid = g_strdup(argv[1]);
 	desc->path = g_strdup_printf("%s/desc%p", desc->chrc->path, desc);
 	desc->flags = g_strsplit(argv[1], ",", -1);
 
@@ -1954,7 +1954,7 @@ void gatt_unregister_desc(DBusConnection *conn, GDBusProxy *proxy,
 {
 	struct desc *desc;
 
-	desc = desc_find(argv[0]);
+	desc = desc_find(argv[1]);
 	if (!desc) {
 		bt_shell_printf("Failed to unregister descriptor object\n");
 		return;
diff --git a/client/main.c b/client/main.c
index 98123d53a..3534bd329 100644
--- a/client/main.c
+++ b/client/main.c
@@ -804,27 +804,27 @@ static gboolean parse_argument(int argc, char *argv[], const char **arg_table,
 {
 	const char **opt;
 
-	if (!strcmp(argv[0], "on") || !strcmp(argv[0], "yes")) {
+	if (!strcmp(argv[1], "on") || !strcmp(argv[1], "yes")) {
 		*value = TRUE;
 		if (option)
 			*option = "";
 		return TRUE;
 	}
 
-	if (!strcmp(argv[0], "off") || !strcmp(argv[0], "no")) {
+	if (!strcmp(argv[1], "off") || !strcmp(argv[1], "no")) {
 		*value = FALSE;
 		return TRUE;
 	}
 
 	for (opt = arg_table; opt && *opt; opt++) {
-		if (strcmp(argv[0], *opt) == 0) {
+		if (strcmp(argv[1], *opt) == 0) {
 			*value = TRUE;
 			*option = *opt;
 			return TRUE;
 		}
 	}
 
-	bt_shell_printf("Invalid argument %s\n", argv[0]);
+	bt_shell_printf("Invalid argument %s\n", argv[1]);
 	return FALSE;
 }
 
@@ -845,16 +845,16 @@ static void cmd_show(int argc, char *argv[])
 	DBusMessageIter iter;
 	const char *address;
 
-	if (!argc || !strlen(argv[0])) {
+	if (argc < 2 || !strlen(argv[1])) {
 		if (check_default_ctrl() == FALSE)
 			return;
 
 		proxy = default_ctrl->proxy;
 	} else {
-		adapter = find_ctrl_by_address(ctrl_list, argv[0]);
+		adapter = find_ctrl_by_address(ctrl_list, argv[1]);
 		if (!adapter) {
 			bt_shell_printf("Controller %s not available\n",
-								argv[0]);
+								argv[1]);
 			return;
 		}
 		proxy = adapter->proxy;
@@ -881,9 +881,9 @@ static void cmd_select(int argc, char *argv[])
 {
 	struct adapter *adapter;
 
-	adapter = find_ctrl_by_address(ctrl_list, argv[0]);
+	adapter = find_ctrl_by_address(ctrl_list, argv[1]);
 	if (!adapter) {
-		bt_shell_printf("Controller %s not available\n", argv[0]);
+		bt_shell_printf("Controller %s not available\n", argv[1]);
 		return;
 	}
 
@@ -949,7 +949,7 @@ static void cmd_system_alias(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return;
 
-	name = g_strdup(argv[0]);
+	name = g_strdup(argv[1]);
 
 	if (g_dbus_proxy_set_property_basic(default_ctrl->proxy, "Alias",
 					DBUS_TYPE_STRING, &name,
@@ -1297,10 +1297,10 @@ static void cmd_set_scan_filter_uuids(int argc, char *argv[])
 	filtered_scan_uuids = NULL;
 	filtered_scan_uuids_len = 0;
 
-	if (!argc || !strlen(argv[0]))
+	if (argc < 2 || !strlen(argv[1]))
 		goto commit;
 
-	filtered_scan_uuids = g_strdupv(argv);
+	filtered_scan_uuids = g_strdupv(&argv[1]);
 	if (!filtered_scan_uuids) {
 		bt_shell_printf("Failed to parse input\n");
 		return;
@@ -1316,10 +1316,10 @@ static void cmd_set_scan_filter_rssi(int argc, char *argv[])
 {
 	filtered_scan_pathloss = DISTANCE_VAL_INVALID;
 
-	if (!argc || !strlen(argv[0]))
+	if (argc < 2 || !strlen(argv[1]))
 		filtered_scan_rssi = DISTANCE_VAL_INVALID;
 	else
-		filtered_scan_rssi = atoi(argv[0]);
+		filtered_scan_rssi = atoi(argv[1]);
 
 	cmd_set_scan_filter_commit();
 }
@@ -1328,10 +1328,10 @@ static void cmd_set_scan_filter_pathloss(int argc, char *argv[])
 {
 	filtered_scan_rssi = DISTANCE_VAL_INVALID;
 
-	if (!argc || !strlen(argv[0]))
+	if (argc < 2 || !strlen(argv[1]))
 		filtered_scan_pathloss = DISTANCE_VAL_INVALID;
 	else
-		filtered_scan_pathloss = atoi(argv[0]);
+		filtered_scan_pathloss = atoi(argv[1]);
 
 	cmd_set_scan_filter_commit();
 }
@@ -1340,24 +1340,24 @@ static void cmd_set_scan_filter_transport(int argc, char *argv[])
 {
 	g_free(filtered_scan_transport);
 
-	if (!argc || !strlen(argv[0]))
+	if (argc < 2 || !strlen(argv[1]))
 		filtered_scan_transport = NULL;
 	else
-		filtered_scan_transport = g_strdup(argv[0]);
+		filtered_scan_transport = g_strdup(argv[1]);
 
 	cmd_set_scan_filter_commit();
 }
 
 static void cmd_set_scan_filter_duplicate_data(int argc, char *argv[])
 {
-	if (!argc || !strlen(argv[0]))
+	if (argc < 2 || !strlen(argv[1]))
 		filtered_scan_duplicate_data = false;
-	else if (!strcmp(argv[0], "on"))
+	else if (!strcmp(argv[1], "on"))
 		filtered_scan_duplicate_data = true;
-	else if (!strcmp(argv[0], "off"))
+	else if (!strcmp(argv[1], "off"))
 		filtered_scan_duplicate_data = false;
 	else {
-		bt_shell_printf("Invalid option: %s\n", argv[0]);
+		bt_shell_printf("Invalid option: %s\n", argv[1]);
 		return;
 	}
 
@@ -1402,7 +1402,7 @@ static struct GDBusProxy *find_device(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	if (!argc || !strlen(argv[0])) {
+	if (argc < 2 || !strlen(argv[1])) {
 		if (default_dev)
 			return default_dev;
 		bt_shell_printf("Missing device address argument\n");
@@ -1412,9 +1412,9 @@ static struct GDBusProxy *find_device(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return NULL;
 
-	proxy = find_proxy_by_address(default_ctrl->devices, argv[0]);
+	proxy = find_proxy_by_address(default_ctrl->devices, argv[1]);
 	if (!proxy) {
-		bt_shell_printf("Device %s not available\n", argv[0]);
+		bt_shell_printf("Device %s not available\n", argv[1]);
 		return NULL;
 	}
 
@@ -1484,7 +1484,7 @@ static void cmd_pair(int argc, char *argv[])
 		return;
 	}
 
-	bt_shell_printf("Attempting to pair with %s\n", argv[0]);
+	bt_shell_printf("Attempting to pair with %s\n", argv[1]);
 }
 
 static void cmd_trust(int argc, char *argv[])
@@ -1499,7 +1499,7 @@ static void cmd_trust(int argc, char *argv[])
 
 	trusted = TRUE;
 
-	str = g_strdup_printf("%s trust", argv[0]);
+	str = g_strdup_printf("%s trust", argv[1]);
 
 	if (g_dbus_proxy_set_property_basic(proxy, "Trusted",
 					DBUS_TYPE_BOOLEAN, &trusted,
@@ -1521,7 +1521,7 @@ static void cmd_untrust(int argc, char *argv[])
 
 	trusted = FALSE;
 
-	str = g_strdup_printf("%s untrust", argv[0]);
+	str = g_strdup_printf("%s untrust", argv[1]);
 
 	if (g_dbus_proxy_set_property_basic(proxy, "Trusted",
 					DBUS_TYPE_BOOLEAN, &trusted,
@@ -1543,7 +1543,7 @@ static void cmd_block(int argc, char *argv[])
 
 	blocked = TRUE;
 
-	str = g_strdup_printf("%s block", argv[0]);
+	str = g_strdup_printf("%s block", argv[1]);
 
 	if (g_dbus_proxy_set_property_basic(proxy, "Blocked",
 					DBUS_TYPE_BOOLEAN, &blocked,
@@ -1565,7 +1565,7 @@ static void cmd_unblock(int argc, char *argv[])
 
 	blocked = FALSE;
 
-	str = g_strdup_printf("%s unblock", argv[0]);
+	str = g_strdup_printf("%s unblock", argv[1]);
 
 	if (g_dbus_proxy_set_property_basic(proxy, "Blocked",
 					DBUS_TYPE_BOOLEAN, &blocked,
@@ -1622,7 +1622,7 @@ static void cmd_remove(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return;
 
-	if (strcmp(argv[0], "*") == 0) {
+	if (strcmp(argv[1], "*") == 0) {
 		GList *list;
 
 		for (list = default_ctrl->devices; list;
@@ -1634,9 +1634,9 @@ static void cmd_remove(int argc, char *argv[])
 		return;
 	}
 
-	proxy = find_proxy_by_address(default_ctrl->devices, argv[0]);
+	proxy = find_proxy_by_address(default_ctrl->devices, argv[1]);
 	if (!proxy) {
-		bt_shell_printf("Device %s not available\n", argv[0]);
+		bt_shell_printf("Device %s not available\n", argv[1]);
 		return;
 	}
 
@@ -1668,9 +1668,9 @@ static void cmd_connect(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return;
 
-	proxy = find_proxy_by_address(default_ctrl->devices, argv[0]);
+	proxy = find_proxy_by_address(default_ctrl->devices, argv[1]);
 	if (!proxy) {
-		bt_shell_printf("Device %s not available\n", argv[0]);
+		bt_shell_printf("Device %s not available\n", argv[1]);
 		return;
 	}
 
@@ -1680,7 +1680,7 @@ static void cmd_connect(int argc, char *argv[])
 		return;
 	}
 
-	bt_shell_printf("Attempting to connect to %s\n", argv[0]);
+	bt_shell_printf("Attempting to connect to %s\n", argv[1]);
 }
 
 static void disconn_reply(DBusMessage *message, void *user_data)
@@ -1718,7 +1718,7 @@ static void cmd_disconn(int argc, char *argv[])
 		return;
 	}
 
-	if (!argc || strlen(argv[0]) == 0) {
+	if (argc < 2 || strlen(argv[1]) == 0) {
 		DBusMessageIter iter;
 		const char *addr;
 
@@ -1727,7 +1727,7 @@ static void cmd_disconn(int argc, char *argv[])
 
 		bt_shell_printf("Attempting to disconnect from %s\n", addr);
 	} else
-		bt_shell_printf("Attempting to disconnect from %s\n", argv[0]);
+		bt_shell_printf("Attempting to disconnect from %s\n", argv[1]);
 }
 
 static void cmd_list_attributes(int argc, char *argv[])
@@ -1750,7 +1750,7 @@ static void cmd_set_alias(int argc, char *argv[])
 		return;
 	}
 
-	name = g_strdup(argv[0]);
+	name = g_strdup(argv[1]);
 
 	if (g_dbus_proxy_set_property_basic(default_dev, "Alias",
 					DBUS_TYPE_STRING, &name,
@@ -1769,7 +1769,7 @@ static void cmd_select_attribute(int argc, char *argv[])
 		return;
 	}
 
-	proxy = gatt_select_attribute(default_attr, argv[0]);
+	proxy = gatt_select_attribute(default_attr, argv[1]);
 	if (proxy)
 		set_default_attribute(proxy);
 }
@@ -1778,16 +1778,16 @@ static struct GDBusProxy *find_attribute(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	if (!argc || !strlen(argv[0])) {
+	if (argc < 2 || !strlen(argv[1])) {
 		if (default_attr)
 			return default_attr;
 		bt_shell_printf("Missing attribute argument\n");
 		return NULL;
 	}
 
-	proxy = gatt_select_attribute(default_attr, argv[0]);
+	proxy = gatt_select_attribute(default_attr, argv[1]);
 	if (!proxy) {
-		bt_shell_printf("Attribute %s not available\n", argv[0]);
+		bt_shell_printf("Attribute %s not available\n", argv[1]);
 		return NULL;
 	}
 
@@ -1856,7 +1856,7 @@ static void cmd_write(int argc, char *argv[])
 		return;
 	}
 
-	gatt_write_attribute(default_attr, argv[0]);
+	gatt_write_attribute(default_attr, argv[1]);
 }
 
 static void cmd_acquire_write(int argc, char *argv[])
@@ -1866,7 +1866,7 @@ static void cmd_acquire_write(int argc, char *argv[])
 		return;
 	}
 
-	gatt_acquire_write(default_attr, argv[0]);
+	gatt_acquire_write(default_attr, argv[1]);
 }
 
 static void cmd_release_write(int argc, char *argv[])
@@ -1876,7 +1876,7 @@ static void cmd_release_write(int argc, char *argv[])
 		return;
 	}
 
-	gatt_release_write(default_attr, argv[0]);
+	gatt_release_write(default_attr, argv[1]);
 }
 
 static void cmd_acquire_notify(int argc, char *argv[])
@@ -1886,7 +1886,7 @@ static void cmd_acquire_notify(int argc, char *argv[])
 		return;
 	}
 
-	gatt_acquire_notify(default_attr, argv[0]);
+	gatt_acquire_notify(default_attr, argv[1]);
 }
 
 static void cmd_release_notify(int argc, char *argv[])
@@ -1896,7 +1896,7 @@ static void cmd_release_notify(int argc, char *argv[])
 		return;
 	}
 
-	gatt_release_notify(default_attr, argv[0]);
+	gatt_release_notify(default_attr, argv[1]);
 }
 
 static void cmd_notify(int argc, char *argv[])
@@ -2135,17 +2135,17 @@ static void cmd_set_advertise_tx_power(int argc, char *argv[])
 
 static void cmd_set_advertise_name(int argc, char *argv[])
 {
-	if (strcmp(argv[0], "on") == 0 || strcmp(argv[0], "yes") == 0) {
+	if (strcmp(argv[1], "on") == 0 || strcmp(argv[1], "yes") == 0) {
 		ad_advertise_name(dbus_conn, true);
 		return;
 	}
 
-	if (strcmp(argv[0], "off") == 0 || strcmp(argv[0], "no") == 0) {
+	if (strcmp(argv[1], "off") == 0 || strcmp(argv[1], "no") == 0) {
 		ad_advertise_name(dbus_conn, false);
 		return;
 	}
 
-	ad_advertise_local_name(dbus_conn, argv[0]);
+	ad_advertise_local_name(dbus_conn, argv[1]);
 }
 
 static void cmd_set_advertise_appearance(int argc, char *argv[])
@@ -2153,17 +2153,17 @@ static void cmd_set_advertise_appearance(int argc, char *argv[])
 	long int value;
 	char *endptr = NULL;
 
-	if (strcmp(argv[0], "on") == 0 || strcmp(argv[0], "yes") == 0) {
+	if (strcmp(argv[1], "on") == 0 || strcmp(argv[1], "yes") == 0) {
 		ad_advertise_appearance(dbus_conn, true);
 		return;
 	}
 
-	if (strcmp(argv[0], "off") == 0 || strcmp(argv[0], "no") == 0) {
+	if (strcmp(argv[1], "off") == 0 || strcmp(argv[1], "no") == 0) {
 		ad_advertise_appearance(dbus_conn, false);
 		return;
 	}
 
-	value = strtol(argv[0], &endptr, 0);
+	value = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
 		bt_shell_printf("Invalid argument\n");
 		return;
@@ -2177,7 +2177,7 @@ static void cmd_set_advertise_duration(int argc, char *argv[])
 	long int value;
 	char *endptr = NULL;
 
-	value = strtol(argv[0], &endptr, 0);
+	value = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
 		bt_shell_printf("Invalid argument\n");
 		return;
@@ -2191,7 +2191,7 @@ static void cmd_set_advertise_timeout(int argc, char *argv[])
 	long int value;
 	char *endptr = NULL;
 
-	value = strtol(argv[0], &endptr, 0);
+	value = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
 		bt_shell_printf("Invalid argument\n");
 		return;
diff --git a/src/shared/shell.c b/src/shared/shell.c
index d262f534b..7e639ccc3 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -129,14 +129,14 @@ static void cmd_menu(int argc, char *argv[])
 {
 	const struct bt_shell_menu *menu;
 
-	if (!argc || !strlen(argv[0])) {
+	if (argc < 2 || !strlen(argv[1])) {
 		bt_shell_printf("Missing name argument\n");
 		return;
 	}
 
-	menu = find_menu(argv[0]);
+	menu = find_menu(argv[1]);
 	if (!menu) {
-		bt_shell_printf("Unable find menu with name: %s\n", argv[0]);
+		bt_shell_printf("Unable find menu with name: %s\n", argv[1]);
 		return;
 	}
 
@@ -239,7 +239,7 @@ static int cmd_exec(const struct bt_shell_menu_entry *entry,
 	int flags = WRDE_NOCMD;
 
 	if (!entry->arg || entry->arg[0] == '\0') {
-		if (argc) {
+		if (argc > 1) {
 			print_text(COLOR_HIGHLIGHT, "Too many arguments");
 			return -EINVAL;
 		}
@@ -263,9 +263,9 @@ static int cmd_exec(const struct bt_shell_menu_entry *entry,
 	}
 
 	/* Check if there are enough arguments */
-	if ((unsigned) argc < w.we_wordc && !w.we_offs) {
+	if ((unsigned) argc - 1 < w.we_wordc && !w.we_offs) {
 		print_text(COLOR_HIGHLIGHT, "Missing %s argument",
-						w.we_wordv[argc]);
+						w.we_wordv[argc - 1]);
 		goto fail;
 	}
 
@@ -280,9 +280,9 @@ optional:
 	}
 
 	/* Check if there are too many arguments */
-	if ((unsigned) argc > w.we_wordc && !w.we_offs) {
+	if ((unsigned) argc - 1 > w.we_wordc && !w.we_offs) {
 		print_text(COLOR_HIGHLIGHT, "Too many arguments: %d > %zu",
-					argc, w.we_wordc);
+					argc - 1, w.we_wordc);
 		goto fail;
 	}
 
@@ -314,7 +314,7 @@ static int menu_exec(const struct bt_shell_menu_entry *entry,
 		if (data.menu == data.main && !strcmp(entry->cmd, "back"))
 			continue;
 
-		return cmd_exec(entry, --argc, ++argv);
+		return cmd_exec(entry, argc, argv);
 	}
 
 	return -ENOENT;
-- 
2.13.6


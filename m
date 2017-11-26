Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] client: Remove argument checks
Date: Sun, 26 Nov 2017 22:21:24 +0200
Message-Id: <20171126202126.27783-2-luiz.dentz@gmail.com>
In-Reply-To: <20171126202126.27783-1-luiz.dentz@gmail.com>
References: <20171126202126.27783-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is now done automatically by bt_shell with the use of the
arguments entered in the command table.
---
 client/main.c | 93 -----------------------------------------------------------
 1 file changed, 93 deletions(-)

diff --git a/client/main.c b/client/main.c
index a510851e3..38028c6c0 100644
--- a/client/main.c
+++ b/client/main.c
@@ -804,14 +804,6 @@ static gboolean parse_argument(int argc, char *argv[], const char **arg_table,
 {
 	const char **opt;
 
-	if (!argc || !strlen(argv[0])) {
-		if (msg)
-			bt_shell_printf("Missing on/off/%s argument\n", msg);
-		else
-			bt_shell_printf("Missing on/off argument\n");
-		return FALSE;
-	}
-
 	if (!strcmp(argv[0], "on") || !strcmp(argv[0], "yes")) {
 		*value = TRUE;
 		if (option)
@@ -889,11 +881,6 @@ static void cmd_select(int argc, char *argv[])
 {
 	struct adapter *adapter;
 
-	if (!argc || !strlen(argv[0])) {
-		bt_shell_printf("Missing controller address argument\n");
-		return;
-	}
-
 	adapter = find_ctrl_by_address(ctrl_list, argv[0]);
 	if (!adapter) {
 		bt_shell_printf("Controller %s not available\n", argv[0]);
@@ -959,11 +946,6 @@ static void cmd_system_alias(int argc, char *argv[])
 {
 	char *name;
 
-	if (!argc || !strlen(argv[0])) {
-		bt_shell_printf("Missing name argument\n");
-		return;
-	}
-
 	if (check_default_ctrl() == FALSE)
 		return;
 
@@ -1637,11 +1619,6 @@ static void cmd_remove(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	if (!argc || !strlen(argv[0])) {
-		bt_shell_printf("Missing device address argument\n");
-		return;
-	}
-
 	if (check_default_ctrl() == FALSE)
 		return;
 
@@ -1688,11 +1665,6 @@ static void cmd_connect(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	if (!argc || !strlen(argv[0])) {
-		bt_shell_printf("Missing device address argument\n");
-		return;
-	}
-
 	if (check_default_ctrl() == FALSE)
 		return;
 
@@ -1773,11 +1745,6 @@ static void cmd_set_alias(int argc, char *argv[])
 {
 	char *name;
 
-	if (!argc || !strlen(argv[0])) {
-		bt_shell_printf("Missing name argument\n");
-		return;
-	}
-
 	if (!default_dev) {
 		bt_shell_printf("No device connected\n");
 		return;
@@ -1797,11 +1764,6 @@ static void cmd_select_attribute(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	if (!argc || !strlen(argv[0])) {
-		bt_shell_printf("Missing attribute argument\n");
-		return;
-	}
-
 	if (!default_dev) {
 		bt_shell_printf("No device connected\n");
 		return;
@@ -1889,11 +1851,6 @@ static void cmd_read(int argc, char *argv[])
 
 static void cmd_write(int argc, char *argv[])
 {
-	if (!argc || !strlen(argv[0])) {
-		bt_shell_printf("Missing data argument\n");
-		return;
-	}
-
 	if (!default_attr) {
 		bt_shell_printf("No attribute selected\n");
 		return;
@@ -1978,11 +1935,6 @@ static void cmd_register_service(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return;
 
-	if (!argc) {
-		bt_shell_printf("Missing argument\n");
-		return;
-	}
-
 	gatt_register_service(dbus_conn, default_ctrl->proxy, argc, argv);
 }
 
@@ -1991,11 +1943,6 @@ static void cmd_unregister_service(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return;
 
-	if (!argc) {
-		bt_shell_printf("Missing argument\n");
-		return;
-	}
-
 	gatt_unregister_service(dbus_conn, default_ctrl->proxy, argc, argv);
 }
 
@@ -2004,11 +1951,6 @@ static void cmd_register_characteristic(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return;
 
-	if (argc < 2) {
-		bt_shell_printf("Missing arguments\n");
-		return;
-	}
-
 	gatt_register_chrc(dbus_conn, default_ctrl->proxy, argc, argv);
 }
 
@@ -2017,11 +1959,6 @@ static void cmd_unregister_characteristic(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return;
 
-	if (argc < 1) {
-		bt_shell_printf("Missing arguments\n");
-		return;
-	}
-
 	gatt_unregister_chrc(dbus_conn, default_ctrl->proxy, argc, argv);
 }
 
@@ -2030,11 +1967,6 @@ static void cmd_register_descriptor(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return;
 
-	if (argc < 2) {
-		bt_shell_printf("Missing arguments\n");
-		return;
-	}
-
 	gatt_register_desc(dbus_conn, default_ctrl->proxy, argc, argv);
 }
 
@@ -2043,11 +1975,6 @@ static void cmd_unregister_descriptor(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return;
 
-	if (argc < 1) {
-		bt_shell_printf("Missing arguments\n");
-		return;
-	}
-
 	gatt_unregister_desc(dbus_conn, default_ctrl->proxy, argc, argv);
 }
 
@@ -2208,11 +2135,6 @@ static void cmd_set_advertise_tx_power(int argc, char *argv[])
 
 static void cmd_set_advertise_name(int argc, char *argv[])
 {
-	if (!argc || strlen(argv[0]) == 0) {
-		bt_shell_printf("Missing on/off argument\n");
-		return;
-	}
-
 	if (strcmp(argv[0], "on") == 0 || strcmp(argv[0], "yes") == 0) {
 		ad_advertise_name(dbus_conn, true);
 		return;
@@ -2231,11 +2153,6 @@ static void cmd_set_advertise_appearance(int argc, char *argv[])
 	long int value;
 	char *endptr = NULL;
 
-	if (!argc || strlen(argv[0]) == 0) {
-		bt_shell_printf("Missing value argument\n");
-		return;
-	}
-
 	if (strcmp(argv[0], "on") == 0 || strcmp(argv[0], "yes") == 0) {
 		ad_advertise_appearance(dbus_conn, true);
 		return;
@@ -2260,11 +2177,6 @@ static void cmd_set_advertise_duration(int argc, char *argv[])
 	long int value;
 	char *endptr = NULL;
 
-	if (!argc || strlen(argv[0]) == 0) {
-		bt_shell_printf("Missing value argument\n");
-		return;
-	}
-
 	value = strtol(argv[0], &endptr, 0);
 	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
 		bt_shell_printf("Invalid argument\n");
@@ -2279,11 +2191,6 @@ static void cmd_set_advertise_timeout(int argc, char *argv[])
 	long int value;
 	char *endptr = NULL;
 
-	if (!argc || strlen(argv[0]) == 0) {
-		bt_shell_printf("Missing value argument\n");
-		return;
-	}
-
 	value = strtol(argv[0], &endptr, 0);
 	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
 		bt_shell_printf("Invalid argument\n");
-- 
2.13.6


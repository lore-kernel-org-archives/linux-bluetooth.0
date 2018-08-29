Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v4] tools/meshctl: Fix default directory for JSON files
Date: Tue, 28 Aug 2018 22:12:51 -0700
Message-Id: <20180829051251.13549-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes the name of default directory that contains sample JSON files.
README file is updated to describe the default location.
---
 tools/mesh/README | 19 +++++++++++++++-
 tools/meshctl.c   | 56 +++++++++++++++++++++++++++++------------------
 2 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/tools/mesh/README b/tools/mesh/README
index ea561efc8..44d633313 100644
--- a/tools/mesh/README
+++ b/tools/mesh/README
@@ -1,5 +1,5 @@
 MeshCtl - BlueZ GATT based Bluetooth Mesh Provisioner
-******************************************
+*****************************************************
 
 Copyright (C) 2017  Intel Corporation. All rights reserved.
 
@@ -16,6 +16,23 @@ Configuration and options
 
 		Build meshctl and other Bluetooth Mesh based tools and utils
 
+Example configuration files
+===========================
+
+The MeshCtl tool requires two input configuration files in JSON format:
+	- local_node.json
+		Local mesh node configuration
+	- prov_db.json
+		Provisoner's database for all the configured nodes in the mesh
+
+The default directory for MeshCtl configuration files is
+/home/<username>/.config/meshctl
+
+To use .json configuration files either copy them to the default directory
+or, to specify a custom storage directory, run meshctl tool as:
+
+	meshctl -c <config_dir_name>
+
 Information
 ===========
 
diff --git a/tools/meshctl.c b/tools/meshctl.c
index 3e1484f61..89960ac2b 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -72,6 +72,8 @@
 #define MESH_PROXY_DATA_IN_UUID_STR	"00002add-0000-1000-8000-00805f9b34fb"
 #define MESH_PROXY_DATA_OUT_UUID_STR	"00002ade-0000-1000-8000-00805f9b34fb"
 
+#define MESHCTL_DIR	".config/meshctl"
+
 static DBusConnection *dbus_conn;
 
 struct adapter {
@@ -1873,7 +1875,7 @@ static const struct bt_shell_menu main_menu = {
 	{ } },
 };
 
-static const char *mesh_config_dir;
+static const char *config_dir;
 
 static const struct option options[] = {
 	{ "config",	required_argument, 0, 'c' },
@@ -1881,7 +1883,7 @@ static const struct option options[] = {
 };
 
 static const char **optargs[] = {
-	&mesh_config_dir
+	&config_dir
 };
 
 static const char *help[] = {
@@ -1907,38 +1909,48 @@ int main(int argc, char *argv[])
 	int status;
 	int len;
 	int extra;
+	char *mesh_dir = NULL;
 
 	bt_shell_init(argc, argv, &opt);
 	bt_shell_set_menu(&main_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
 
-	if (!mesh_config_dir) {
-		bt_shell_printf("Local config directory not provided.\n");
-		mesh_config_dir = "";
+	if (!config_dir) {
+		char *home = getenv("XDG_CONFIG_HOME");
+
+		if (!home)
+			home = getenv("HOME");
+
+		if (!home) {
+			g_printerr("Configuration not found\n");
+			goto fail;
+		}
+
+		mesh_dir = g_strdup_printf("%s/%s", home, MESHCTL_DIR);
 	} else {
-		bt_shell_printf("Reading prov_db.json and local_node.json from"
-				" %s\n", mesh_config_dir);
+		mesh_dir = g_strdup_printf("%s", config_dir);
 	}
 
-	len = strlen(mesh_config_dir);
-	if (len && mesh_config_dir[len - 1] != '/') {
+	printf("Reading prov_db.json and local_node.json from %s directory\n",
+								mesh_dir);
+
+	len = strlen(mesh_dir);
+
+	if (len && mesh_dir[len - 1] != '/')
 		extra = 1;
-		bt_shell_printf("mesh_config_dir[%d] %s\n", len,
-						&mesh_config_dir[len - 1]);
-	} else {
+	else
 		extra = 0;
-	}
+
 	mesh_local_config_filename = g_malloc(len + strlen("local_node.json")
 									+ 2);
 	if (!mesh_local_config_filename)
 		goto fail;
 
 	mesh_prov_db_filename = g_malloc(len + strlen("prov_db.json") + 2);
-	if (!mesh_prov_db_filename) {
+	if (!mesh_prov_db_filename)
 		goto fail;
-	}
 
-	sprintf(mesh_local_config_filename, "%s", mesh_config_dir);
+	sprintf(mesh_local_config_filename, "%s", mesh_dir);
 
 	if (extra)
 		sprintf(mesh_local_config_filename + len , "%c", '/');
@@ -1946,7 +1958,6 @@ int main(int argc, char *argv[])
 	sprintf(mesh_local_config_filename + len + extra, "%s",
 							"local_node.json");
 	len = len + extra + strlen("local_node.json");
-	sprintf(mesh_local_config_filename + len, "%c", '\0');
 
 	if (!prov_db_read_local_node(mesh_local_config_filename, true)) {
 		g_printerr("Failed to parse local node configuration file %s\n",
@@ -1954,14 +1965,15 @@ int main(int argc, char *argv[])
 		goto fail;
 	}
 
-	sprintf(mesh_prov_db_filename, "%s", mesh_config_dir);
-	len = strlen(mesh_config_dir);
+	sprintf(mesh_prov_db_filename, "%s", mesh_dir);
+	len = strlen(mesh_dir);
+
+	g_free(mesh_dir);
+
 	if (extra)
 		sprintf(mesh_prov_db_filename + len , "%c", '/');
 
 	sprintf(mesh_prov_db_filename + len + extra, "%s", "prov_db.json");
-	sprintf(mesh_prov_db_filename + len + extra + strlen("prov_db.json"),
-								"%c", '\0');
 
 	if (!prov_db_read(mesh_prov_db_filename)) {
 		g_printerr("Failed to parse provisioning database file %s\n",
@@ -2006,5 +2018,7 @@ int main(int argc, char *argv[])
 
 fail:
 	bt_shell_cleanup();
+	g_free(mesh_dir);
+
 	return EXIT_FAILURE;
 }
-- 
2.17.1

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh/meshctl: Exit cleanly if start up fails
Date: Fri, 23 Mar 2018 19:33:36 -0700
Message-Id: <20180324023336.13879-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When failing to start meshctl due to invalid input configuration,
release bt_shell resources prior to exit.
---
 mesh/main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index d991c9f8c..d0f71c2d9 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -1930,11 +1930,11 @@ int main(int argc, char *argv[])
 	mesh_local_config_filename = g_malloc(len + strlen("local_node.json")
 									+ 2);
 	if (!mesh_local_config_filename)
-		exit(1);
+		goto fail;
 
 	mesh_prov_db_filename = g_malloc(len + strlen("prov_db.json") + 2);
 	if (!mesh_prov_db_filename) {
-		exit(1);
+		goto fail;
 	}
 
 	sprintf(mesh_local_config_filename, "%s", mesh_config_dir);
@@ -1950,7 +1950,7 @@ int main(int argc, char *argv[])
 	if (!prov_db_read_local_node(mesh_local_config_filename, true)) {
 		g_printerr("Failed to parse local node configuration file %s\n",
 			mesh_local_config_filename);
-		exit(1);
+		goto fail;
 	}
 
 	sprintf(mesh_prov_db_filename, "%s", mesh_config_dir);
@@ -1965,7 +1965,7 @@ int main(int argc, char *argv[])
 	if (!prov_db_read(mesh_prov_db_filename)) {
 		g_printerr("Failed to parse provisioning database file %s\n",
 			mesh_prov_db_filename);
-		exit(1);
+		goto fail;
 	}
 
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
@@ -2001,5 +2001,9 @@ int main(int argc, char *argv[])
 	g_list_free(service_list);
 	g_list_free_full(ctrl_list, proxy_leak);
 
-	return 0;
+	return EXIT_SUCCESS;
+
+fail:
+	bt_shell_cleanup();
+	return EXIT_FAILURE;
 }
-- 
2.13.6


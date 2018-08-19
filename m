Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/meshctl: Fix default directory for JSON files
Date: Sun, 19 Aug 2018 14:30:26 -0700
Message-Id: <20180819213026.28429-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes the name of default directory that contains sample JSON files.
---
 tools/meshctl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/meshctl.c b/tools/meshctl.c
index 3e1484f61..a8468b716 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -1913,21 +1913,20 @@ int main(int argc, char *argv[])
 	bt_shell_set_prompt(PROMPT_OFF);
 
 	if (!mesh_config_dir) {
-		bt_shell_printf("Local config directory not provided.\n");
-		mesh_config_dir = "";
-	} else {
-		bt_shell_printf("Reading prov_db.json and local_node.json from"
-				" %s\n", mesh_config_dir);
+		printf("Local config directory not provided.\n");
+		mesh_config_dir = "mesh";
 	}
 
+	printf("Reading prov_db.json and local_node.json from"
+				" %s directory\n", mesh_config_dir);
+
 	len = strlen(mesh_config_dir);
-	if (len && mesh_config_dir[len - 1] != '/') {
+
+	if (len && mesh_config_dir[len - 1] != '/')
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
@@ -1956,6 +1955,7 @@ int main(int argc, char *argv[])
 
 	sprintf(mesh_prov_db_filename, "%s", mesh_config_dir);
 	len = strlen(mesh_config_dir);
+
 	if (extra)
 		sprintf(mesh_prov_db_filename + len , "%c", '/');
 
-- 
2.14.4

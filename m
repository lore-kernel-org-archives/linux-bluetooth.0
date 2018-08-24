Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/1] mesh: Fix location for composition and configuration files
Date: Fri, 24 Aug 2018 15:21:28 -0700
Message-Id: <20180824222128.30043-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The default location for composition data and node configuration is
set to be in STORAGEDIR/mesh. This is a temporary solution until a
permanent mesh storage directory structure is decided upon.
---
 mesh/storage.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mesh/storage.c b/mesh/storage.c
index 937f801a6..be618ed8c 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -47,8 +47,8 @@
  * TODO: figure out naming convention to store alternative nodes
  * Mesh storage dir wil be in configure.ac
  */
-#define DEVICE_COMPOSITION_FILE "../config/composition.json"
-#define NODE_CONGIGURATION_FILE "../config/configuration.json"
+#define DEVICE_COMPOSITION_FILE STORAGEDIR"/mesh/composition.json"
+#define NODE_CONFIGURATION_FILE STORAGEDIR"/mesh/configuration.json"
 
 static bool read_local_node_cb(struct mesh_db_node *db_node, void *user_data)
 {
@@ -276,7 +276,7 @@ static bool parse_config(struct mesh_net *net, const char *config_name,
 	mesh_net_cfg_file_get(net, &out);
 	if (!out)
 		mesh_net_cfg_file_set(net, !unprovisioned ?
-					config_name : NODE_CONGIGURATION_FILE);
+					config_name : NODE_CONFIGURATION_FILE);
 done:
 	close(fd);
 	if (str)
-- 
2.17.1

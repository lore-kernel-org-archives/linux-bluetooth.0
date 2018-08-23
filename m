Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
        inga.stotland@intel.com, johan.hedberg@intel.com,
        luiz.von.dentz@intel.com, Brian Gix <brian.gix@intel.com>
Subject: [PATCH 1/1] mesh: Fixed warning-to-error from GCC 8.1.1
Date: Thu, 23 Aug 2018 12:13:24 -0700
Message-Id: <20180823191324.12712-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed compiler flagged unsafe usage of strncpy
---
 mesh/storage.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mesh/storage.c b/mesh/storage.c
index 85fa81dda..1be403297 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -298,13 +298,14 @@ bool storage_parse_config(struct mesh_net *net, const char *config_name)
 	result = parse_config(net, config_name, false);
 
 	if (!result) {
-		char *bak = (char *) l_malloc(strlen(config_name) + 5);
+		size_t len = strlen(config_name) + 5;
+		char *bak = (char *) l_malloc(len);
 
 		if (!bak)
 			goto done;
 
 		/* Fall-back to Backup version */
-		strncpy(bak, config_name, strlen(config_name) + 1);
+		strncpy(bak, config_name, len);
 		bak = strncat(bak, ".bak", 5);
 
 		remove(config_name);
@@ -592,15 +593,16 @@ struct write_info {
 static void idle_save_config(void *user_data)
 {
 	struct write_info *info = user_data;
-	char *tmp = (char *) l_malloc(strlen(info->config_name) + 5);
-	char *bak = (char *) l_malloc(strlen(info->config_name) + 5);
+	size_t len = strlen(info->config_name) + 5;
+	char *tmp = (char *) l_malloc(len);
+	char *bak = (char *) l_malloc(len);
 	bool result = false;
 
 	if (!tmp || !bak)
 		goto done;
 
-	strncpy(tmp, info->config_name, strlen(info->config_name)  + 1);
-	strncpy(bak, info->config_name, strlen(info->config_name)  + 1);
+	strncpy(tmp, info->config_name, len);
+	strncpy(bak, info->config_name, len);
 	tmp = strncat(tmp, ".tmp", 5);
 	bak = strncat(bak, ".bak", 5);
 	remove(tmp);
-- 
2.17.1

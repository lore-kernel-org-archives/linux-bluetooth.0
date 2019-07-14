Return-Path: <SRS0=dLRT=VL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515D1C742A2
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 06:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5BD20820
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 06:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfGNG21 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Jul 2019 02:28:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:30362 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfGNG21 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Jul 2019 02:28:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 23:28:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,489,1557212400"; 
   d="scan'208";a="318388010"
Received: from ingas-nuc1.sea.intel.com ([10.251.146.93])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2019 23:28:24 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 09/10 v2] mesh: Create or re-use a node storage directory for keyring
Date:   Sat, 13 Jul 2019 23:28:11 -0700
Message-Id: <20190714062812.31041-10-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190714062812.31041-1-inga.stotland@intel.com>
References: <20190714062812.31041-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds APIs to set a directory for storing node's key ring info.
The directory is named MESH_STORAGE_DIR/<node uuid>. This directory
may contain additional node info plus node configuration, if node
configuration storage follows the same layout (as it does when
JSON based config file format is used).
---
 mesh/keyring.c | 36 ++++++++++++++++++------------------
 mesh/node.c    | 41 ++++++++++++++++++++++++++++++++---------
 mesh/node.h    |  4 ++--
 3 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index 4c6d2986d..3ea83194c 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -43,7 +43,7 @@ const char *net_key_dir = "/net_keys";
 bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
 						struct keyring_net_key *key)
 {
-	char *node_path;
+	const char *node_path;
 	char key_file[PATH_MAX];
 	bool result = false;
 	int fd;
@@ -51,7 +51,7 @@ bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
 	if (!node || !key)
 		return false;
 
-	node_path = node_path_get(node);
+	node_path = node_get_storage_dir(node);
 
 	if (strlen(node_path) + strlen(net_key_dir) + 1 + 3 >= PATH_MAX)
 		return false;
@@ -76,7 +76,7 @@ bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
 bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
 				uint16_t net_idx, struct keyring_app_key *key)
 {
-	char *node_path;
+	const char *node_path;
 	char key_file[PATH_MAX];
 	bool result = false;
 	int fd;
@@ -84,7 +84,7 @@ bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
 	if (!node || !key)
 		return false;
 
-	node_path = node_path_get(node);
+	node_path = node_get_storage_dir(node);
 
 	if (strlen(node_path) + strlen(app_key_dir) + 1 + 3 >= PATH_MAX)
 		return false;
@@ -123,7 +123,7 @@ bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
 bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 					uint8_t count, uint8_t dev_key[16])
 {
-	char *node_path;
+	const char *node_path;
 	char key_file[PATH_MAX];
 	bool result = true;
 	int fd, i;
@@ -131,7 +131,7 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	if (!node)
 		return false;
 
-	node_path = node_path_get(node);
+	node_path = node_get_storage_dir(node);
 
 	if (strlen(node_path) + strlen(dev_key_dir) + 1 + 4 >= PATH_MAX)
 		return false;
@@ -161,7 +161,7 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 bool keyring_get_net_key(struct mesh_node *node, uint16_t net_idx,
 						struct keyring_net_key *key)
 {
-	char *node_path;
+	const char *node_path;
 	char key_file[PATH_MAX];
 	bool result = false;
 	int fd;
@@ -169,7 +169,7 @@ bool keyring_get_net_key(struct mesh_node *node, uint16_t net_idx,
 	if (!node || !key)
 		return false;
 
-	node_path = node_path_get(node);
+	node_path = node_get_storage_dir(node);
 	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, net_key_dir,
 								net_idx);
 
@@ -187,7 +187,7 @@ bool keyring_get_net_key(struct mesh_node *node, uint16_t net_idx,
 bool keyring_get_app_key(struct mesh_node *node, uint16_t app_idx,
 						struct keyring_app_key *key)
 {
-	char *node_path;
+	const char *node_path;
 	char key_file[PATH_MAX];
 	bool result = false;
 	int fd;
@@ -195,7 +195,7 @@ bool keyring_get_app_key(struct mesh_node *node, uint16_t app_idx,
 	if (!node || !key)
 		return false;
 
-	node_path = node_path_get(node);
+	node_path = node_get_storage_dir(node);
 	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, app_key_dir,
 								app_idx);
 
@@ -213,7 +213,7 @@ bool keyring_get_app_key(struct mesh_node *node, uint16_t app_idx,
 bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 							uint8_t dev_key[16])
 {
-	char *node_path;
+	const char *node_path;
 	char key_file[PATH_MAX];
 	bool result = false;
 	int fd;
@@ -221,7 +221,7 @@ bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	if (!node)
 		return false;
 
-	node_path = node_path_get(node);
+	node_path = node_get_storage_dir(node);
 	snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path, dev_key_dir,
 								unicast);
 
@@ -238,13 +238,13 @@ bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 
 bool keyring_del_net_key(struct mesh_node *node, uint16_t net_idx)
 {
-	char *node_path;
+	const char *node_path;
 	char key_file[PATH_MAX];
 
 	if (!node)
 		return false;
 
-	node_path = node_path_get(node);
+	node_path = node_get_storage_dir(node);
 	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, net_key_dir,
 								net_idx);
 	l_debug("RM Net Key %s", key_file);
@@ -258,13 +258,13 @@ bool keyring_del_net_key(struct mesh_node *node, uint16_t net_idx)
 
 bool keyring_del_app_key(struct mesh_node *node, uint16_t app_idx)
 {
-	char *node_path;
+	const char *node_path;
 	char key_file[PATH_MAX];
 
 	if (!node)
 		return false;
 
-	node_path = node_path_get(node);
+	node_path = node_get_storage_dir(node);
 	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, app_key_dir,
 								app_idx);
 	l_debug("RM App Key %s", key_file);
@@ -276,14 +276,14 @@ bool keyring_del_app_key(struct mesh_node *node, uint16_t app_idx)
 bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 								uint8_t count)
 {
-	char *node_path;
+	const char *node_path;
 	char key_file[PATH_MAX];
 	int i;
 
 	if (!node)
 		return false;
 
-	node_path = node_path_get(node);
+	node_path = node_get_storage_dir(node);
 	for (i = 0; i < count; i++) {
 		snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
 						dev_key_dir, unicast + i);
diff --git a/mesh/node.c b/mesh/node.c
index decd3d6fc..0f4569e36 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -22,6 +22,8 @@
 #endif
 
 #define _GNU_SOURCE
+#include <dirent.h>
+#include <stdio.h>
 
 #include <sys/time.h>
 
@@ -81,7 +83,7 @@ struct mesh_node {
 	char *owner;
 	char *path;
 	struct mesh_config *cfg;
-	char *node_path;
+	char *storage_dir;
 	uint32_t disc_watch;
 	time_t upd_sec;
 	uint32_t seq_number;
@@ -267,6 +269,7 @@ static void free_node_resources(void *data)
 
 	mesh_net_free(node->net);
 	l_free(node->comp);
+	l_free(node->storage_dir);
 	l_free(node);
 }
 
@@ -1511,6 +1514,29 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 	return true;
 }
 
+static bool init_storage_dir(struct mesh_node *node)
+{
+	char uuid[33];
+	char dir_name[PATH_MAX];
+
+	if (node->storage_dir)
+		return true;
+
+	if (!hex2str(node->uuid, 16, uuid, sizeof(uuid)))
+		return false;
+
+	snprintf(dir_name, PATH_MAX, "%s/%s", mesh_get_storage_dir(), uuid);
+
+	if (strlen(dir_name) >= PATH_MAX)
+		return false;
+
+	create_dir(dir_name);
+
+	node->storage_dir = l_strdup(dir_name);
+
+	return true;
+}
+
 static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 {
 	struct l_dbus_message_iter objects, interfaces;
@@ -1663,6 +1689,9 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 						net_key.old_key))
 			goto fail;
 
+		/* Initialize directory for storing keyring info */
+		init_storage_dir(node);
+
 		if (!keyring_put_remote_dev_key(node, DEFAULT_NEW_UNICAST,
 							num_ele, dev_key))
 			goto fail;
@@ -2063,15 +2092,9 @@ struct mesh_config *node_config_get(struct mesh_node *node)
 	return node->cfg;
 }
 
-void node_path_set(struct mesh_node *node, char *path)
-{
-	l_free(node->node_path);
-	node->node_path = l_strdup(path);
-}
-
-char *node_path_get(struct mesh_node *node)
+const char *node_get_storage_dir(struct mesh_node *node)
 {
-	return node->node_path;
+	return node->storage_dir;
 }
 
 struct mesh_net *node_get_net(struct mesh_node *node)
diff --git a/mesh/node.h b/mesh/node.h
index 17c89da26..baa0eb315 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -98,6 +98,6 @@ uint16_t node_id_get(struct mesh_node *node);
 bool node_dbus_init(struct l_dbus *bus);
 void node_cleanup_all(void);
 struct mesh_config *node_config_get(struct mesh_node *node);
-void node_path_set(struct mesh_node *node, char *path);
-char *node_path_get(struct mesh_node *node);
+const char *node_get_storage_dir(struct mesh_node *node);
+bool node_init_storage_dir(struct mesh_node *node);
 bool node_load_from_storage(const char *storage_dir);
-- 
2.21.0


Return-Path: <SRS0=obUF=UX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613B7C43613
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jun 2019 17:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F70220645
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jun 2019 17:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfFXRlp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:41:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:27641 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbfFXRlp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jun 2019 13:41:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 10:41:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,412,1557212400"; 
   d="scan'208";a="166394614"
Received: from ingas-nuc1.sea.intel.com ([10.254.44.156])
  by orsmga006.jf.intel.com with ESMTP; 24 Jun 2019 10:41:44 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/1] mesh: Modify check of the node directory name upon removal
Date:   Mon, 24 Jun 2019 10:41:42 -0700
Message-Id: <20190624174142.15920-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes check for "mesh" as the parent directory name and, instead,
verifies that the node configuration directory name is the hexadecimal
string representating the node's UUID.
---
 mesh/storage.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/mesh/storage.c b/mesh/storage.c
index 1a9945aa8..54c985559 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -53,20 +53,6 @@ static const char *bak_ext = ".bak";
 static const char *tmp_ext = ".tmp";
 static const char *storage_dir;
 
-/* This is a thread-safe always malloced version of dirname which will work
- * regardless of which underlying dirname() implementation is used.
- */
-static char *alloc_dirname(const char *path)
-{
-	char *tmp = l_strdup(path);
-	char *dir;
-
-	dir = dirname(tmp);
-	strncpy(tmp, dir, strlen(path) + 1);
-
-	return tmp;
-}
-
 static bool read_node_cb(struct mesh_db_node *db_node, void *user_data)
 {
 	struct mesh_node *node = user_data;
@@ -486,20 +472,20 @@ void storage_save_config(struct mesh_node *node, bool no_wait,
 		l_idle_oneshot(idle_save_config, info, NULL);
 }
 
-static int create_dir(const char *dirname)
+static int create_dir(const char *dir_name)
 {
 	struct stat st;
 	char dir[PATH_MAX + 1], *prev, *next;
 	int err;
 
-	err = stat(dirname, &st);
+	err = stat(dir_name, &st);
 	if (!err && S_ISREG(st.st_mode))
 		return 0;
 
 	memset(dir, 0, PATH_MAX + 1);
 	strcat(dir, "/");
 
-	prev = strchr(dirname, '/');
+	prev = strchr(dir_name, '/');
 
 	while (prev) {
 		next = strchr(prev + 1, '/');
@@ -517,7 +503,7 @@ static int create_dir(const char *dirname)
 		prev = next;
 	}
 
-	mkdir(dirname, 0755);
+	mkdir(dir_name, 0755);
 
 	return 0;
 }
@@ -640,7 +626,8 @@ static int del_fobject(const char *fpath, const struct stat *sb, int typeflag,
 /* Permanently remove node configuration */
 void storage_remove_node_config(struct mesh_node *node)
 {
-	char *node_path, *mesh_path, *mesh_name;
+	char *node_path, *node_name;
+	char uuid[33];
 	struct json_object *jnode;
 
 	if (!node)
@@ -656,13 +643,13 @@ void storage_remove_node_config(struct mesh_node *node)
 	l_debug("Delete node config %s", node_path);
 
 	/* Make sure path name of node follows expected guidelines */
-	mesh_path = alloc_dirname(node_path);
-	mesh_name = basename(mesh_path);
-	if (strcmp(mesh_name, "mesh"))
-		goto done;
+	if (!hex2str(node_uuid_get(node), 16, uuid, sizeof(uuid)))
+		return;
 
-	nftw(node_path, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
+	node_name = basename(node_path);
 
-done:
-	l_free(mesh_path);
+	if (strcmp(node_name, uuid))
+		return;
+
+	nftw(node_path, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
 }
-- 
2.21.0


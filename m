Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C32FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 17:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbiFNRNz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiFNRNy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 13:13:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1D51FA79
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655226833; x=1686762833;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5mMsQrPr+sQP3R2iBlzsvxR1A+6STqAHDTUQIgeRwAI=;
  b=kAQc13pyTPbm5NcIbSF0nEqH1FoQx8SiKPOfjFKZfQtO5jFxHJdW6Xan
   kmMqcZv26s5L4bg067ZgIBqhGl9VVlfEsnhY0J6OgDOa2FkpNI/mZf1q7
   kDDuhfQcVAMoGAiWCUXM31xQNT5oq51YZdXIIue1pbnwhAGudKa73ejpT
   0uDCrgJzMfGXUu0v+9Cxqkx/ZReXx+dxBUK6cmOD49J+9TOPcVlHSN3OM
   zK+b5YYSVUH5b9vQkQ7qum8OnuesP1cGe4Ej64Ew95ZUti9ee/vgFXW/1
   nza36OfuBmJTUC2CawTkEA99XG+4KAymp2y2HAA1eJeL/7xP5jnnpPTBm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="259137453"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="259137453"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 10:13:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="570095481"
Received: from kjirish-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.156.199])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 10:13:52 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com,
        tedd.an@intel.com
Subject: [PATCH BlueZ] mesh: Fix keyring snprintf usage range checking
Date:   Tue, 14 Jun 2022 10:13:38 -0700
Message-Id: <20220614171338.177983-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

snprintf performs it's own range checking and returns a negative value
if string construction fails. Not checking the return value throws a
warning at compile time on GCC 12 and later. This patch removes
redundent range chacking and checks all snprintf return values.
---
 mesh/keyring.c | 68 +++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index 6d539e74e..995a4b88f 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -39,26 +39,24 @@ static int open_key_file(struct mesh_node *node, const char *key_dir,
 {
 	const char *node_path;
 	char fname[PATH_MAX];
-	int len;
+	int ret;
 
 	if (!node)
 		return -1;
 
 	node_path = node_get_storage_dir(node);
 
-	if (strlen(node_path) + strlen(key_dir) + 1 + 3 >= PATH_MAX)
-		return -1;
-
 	if (flags & O_CREAT) {
-		len = snprintf(fname, PATH_MAX, "%s%s", node_path, key_dir);
-		if (len >= PATH_MAX)
+		ret = snprintf(fname, PATH_MAX, "%s%s", node_path, key_dir);
+		if (ret < 0)
 			return -1;
+
 		if (mkdir(fname, 0755) != 0 && errno != EEXIST)
 			l_error("Failed to create dir(%d): %s", errno, fname);
 	}
 
-	len = snprintf(fname, PATH_MAX, "%s%s/%3.3x", node_path, key_dir, idx);
-	if (len >= PATH_MAX)
+	ret = snprintf(fname, PATH_MAX, "%s%s/%3.3x", node_path, key_dir, idx);
+	if (ret < 0)
 		return -1;
 
 	if (flags & O_CREAT)
@@ -157,7 +155,7 @@ bool keyring_finalize_app_keys(struct mesh_node *node, uint16_t net_idx)
 	const char *node_path;
 	char key_dir[PATH_MAX];
 	DIR *dir;
-	int dir_fd;
+	int ret, dir_fd;
 	struct dirent *entry;
 
 	if (!node)
@@ -165,10 +163,10 @@ bool keyring_finalize_app_keys(struct mesh_node *node, uint16_t net_idx)
 
 	node_path = node_get_storage_dir(node);
 
-	if (strlen(node_path) + strlen(app_key_dir) + 1 >= PATH_MAX)
+	ret = snprintf(key_dir, PATH_MAX, "%s%s", node_path, app_key_dir);
+	if (ret < 0)
 		return false;
 
-	snprintf(key_dir, PATH_MAX, "%s%s", node_path, app_key_dir);
 	dir = opendir(key_dir);
 	if (!dir) {
 		if (errno == ENOENT)
@@ -197,7 +195,7 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	const char *node_path;
 	char key_file[PATH_MAX];
 	bool result = true;
-	int fd, i;
+	int ret, fd, i;
 
 	if (!IS_UNICAST_RANGE(unicast, count))
 		return false;
@@ -207,17 +205,19 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 
 	node_path = node_get_storage_dir(node);
 
-	if (strlen(node_path) + strlen(dev_key_dir) + 1 + 4 >= PATH_MAX)
+	ret = snprintf(key_file, PATH_MAX, "%s%s", node_path, dev_key_dir);
+	if (ret < 0)
 		return false;
 
-	snprintf(key_file, PATH_MAX, "%s%s", node_path, dev_key_dir);
-
 	if (mkdir(key_file, 0755) != 0 && errno != EEXIST)
 		l_error("Failed to create dir(%d): %s", errno, key_file);
 
 	for (i = 0; i < count; i++) {
-		snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
+		ret = snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
 						dev_key_dir, unicast + i);
+		if (ret < 0)
+			return false;
+
 		l_debug("Put Dev Key %s", key_file);
 
 		fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC, 0600);
@@ -272,7 +272,7 @@ bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	const char *node_path;
 	char key_file[PATH_MAX];
 	bool result = false;
-	int fd;
+	int ret, fd;
 
 	if (!IS_UNICAST(unicast))
 		return false;
@@ -282,8 +282,11 @@ bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 
 	node_path = node_get_storage_dir(node);
 
-	snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path, dev_key_dir,
+	ret = snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path, dev_key_dir,
 								unicast);
+	if (ret < 0)
+		return false;
+
 	fd = open(key_file, O_RDONLY);
 	if (fd >= 0) {
 		if (read(fd, dev_key, 16) == 16)
@@ -299,13 +302,17 @@ bool keyring_del_net_key(struct mesh_node *node, uint16_t net_idx)
 {
 	const char *node_path;
 	char key_file[PATH_MAX];
+	int ret;
 
 	if (!node)
 		return false;
 
 	node_path = node_get_storage_dir(node);
-	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, net_key_dir,
+	ret = snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, net_key_dir,
 								net_idx);
+	if (ret < 0)
+		return false;
+
 	l_debug("RM Net Key %s", key_file);
 	remove(key_file);
 
@@ -319,13 +326,17 @@ bool keyring_del_app_key(struct mesh_node *node, uint16_t app_idx)
 {
 	const char *node_path;
 	char key_file[PATH_MAX];
+	int ret;
 
 	if (!node)
 		return false;
 
 	node_path = node_get_storage_dir(node);
-	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, app_key_dir,
+	ret = snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, app_key_dir,
 								app_idx);
+	if (ret < 0)
+		return false;
+
 	l_debug("RM App Key %s", key_file);
 	remove(key_file);
 
@@ -337,7 +348,7 @@ bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 {
 	const char *node_path;
 	char key_file[PATH_MAX];
-	int i;
+	int ret, i;
 
 	if (!IS_UNICAST_RANGE(unicast, count))
 		return false;
@@ -348,8 +359,11 @@ bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	node_path = node_get_storage_dir(node);
 
 	for (i = 0; i < count; i++) {
-		snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
+		ret = snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
 						dev_key_dir, unicast + i);
+		if (ret < 0)
+			return false;
+
 		l_debug("RM Dev Key %s", key_file);
 		remove(key_file);
 	}
@@ -361,18 +375,16 @@ static DIR *open_key_dir(const char *node_path, const char *key_dir_name)
 {
 	char dir_path[PATH_MAX];
 	DIR *key_dir;
+	int ret;
 
-	if (strlen(node_path) + strlen(key_dir_name) + 1 >= PATH_MAX)
+	ret = snprintf(dir_path, PATH_MAX, "%s%s", node_path, key_dir_name);
+	if (ret < 0)
 		return NULL;
 
-	snprintf(dir_path, PATH_MAX, "%s%s", node_path, key_dir_name);
-
 	key_dir = opendir(dir_path);
-	if (!key_dir) {
+	if (!key_dir)
 		l_error("Failed to open keyring storage directory: %s",
 								dir_path);
-		return NULL;
-	}
 
 	return key_dir;
 }
-- 
2.35.3


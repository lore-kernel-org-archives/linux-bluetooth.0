Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FADC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 20:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7132364EAD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 20:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhBPUx4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Feb 2021 15:53:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:12098 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhBPUxz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Feb 2021 15:53:55 -0500
IronPort-SDR: 999ndaiFwLeeFRVtLbcF8FyRGySfFmRaYs/m5xtHi5wbJK0bfGyFQw/NVVWR3EJ42wB5TfB6Vu
 pgeNL5g+Yhqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="162148744"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="162148744"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 12:53:12 -0800
IronPort-SDR: v1Pa+qnI22V4KoMr/ifr7PpN8cmV0x2tUwqly/xwAZMzNN5bsor+TzAh+gD0iISRaSXE9x8kaZ
 KBE7z12H27qA==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="364231465"
Received: from tldewalt-mobl1.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.254.177.48])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 12:53:11 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Combine common functions for NetKeys and AppKeys
Date:   Tue, 16 Feb 2021 12:52:56 -0800
Message-Id: <20210216205256.15300-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

No change in functioanality, code tightening.
---
 mesh/keyring.c | 120 +++++++++++++++++++++----------------------------
 1 file changed, 50 insertions(+), 70 deletions(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index 0b74ee914..025703574 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -33,31 +33,45 @@ const char *dev_key_dir = "/dev_keys";
 const char *app_key_dir = "/app_keys";
 const char *net_key_dir = "/net_keys";
 
-bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
-						struct keyring_net_key *key)
+static int open_key_file(struct mesh_node *node, const char *key_dir,
+					uint16_t idx, bool is_wrt, int flags)
 {
 	const char *node_path;
-	char key_file[PATH_MAX];
-	bool result = false;
-	int fd;
+	char fname[PATH_MAX];
 
-	if (!node || !key)
-		return false;
+	if (!node)
+		return -1;
 
 	node_path = node_get_storage_dir(node);
 
-	if (strlen(node_path) + strlen(net_key_dir) + 1 + 3 >= PATH_MAX)
-		return false;
+	if (strlen(node_path) + strlen(key_dir) + 1 + 3 >= PATH_MAX)
+		return -1;
 
-	snprintf(key_file, PATH_MAX, "%s%s", node_path, net_key_dir);
+	if (is_wrt) {
+		snprintf(fname, PATH_MAX, "%s%s", node_path, key_dir);
+		mkdir(fname, 0755);
+	}
 
-	mkdir(key_file, 0755);
+	snprintf(fname, PATH_MAX, "%s%s/%3.3x", node_path, key_dir, idx);
 
-	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, net_key_dir,
-								net_idx);
-	l_debug("Put Net Key %s", key_file);
+	if (is_wrt)
+		return open(fname, flags, S_IRUSR | S_IWUSR);
+	else
+		return open(fname, flags);
+}
+
+bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
+						struct keyring_net_key *key)
+{
+	bool result = false;
+	int fd;
+
+	if (!key)
+		return false;
+
+	fd = open_key_file(node, net_key_dir, net_idx, true,
+					O_WRONLY | O_CREAT | O_TRUNC);
 
-	fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
 	if (fd < 0)
 		return false;
 
@@ -72,28 +86,14 @@ bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
 bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
 				uint16_t net_idx, struct keyring_app_key *key)
 {
-	const char *node_path;
-	char key_file[PATH_MAX];
 	bool result = false;
 	int fd;
 
-	if (!node || !key)
+	if (!key)
 		return false;
 
-	node_path = node_get_storage_dir(node);
-
-	if (strlen(node_path) + strlen(app_key_dir) + 1 + 3 >= PATH_MAX)
-		return false;
+	fd = open_key_file(node, app_key_dir, app_idx, false, O_RDWR);
 
-	snprintf(key_file, PATH_MAX, "%s%s", node_path, app_key_dir);
-
-	mkdir(key_file, 0755);
-
-	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, app_key_dir,
-								app_idx);
-	l_debug("Put App Key %s", key_file);
-
-	fd = open(key_file, O_RDWR);
 	if (fd >= 0) {
 		struct keyring_app_key old_key;
 
@@ -105,12 +105,12 @@ bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
 		}
 
 		lseek(fd, 0, SEEK_SET);
-	} else {
-		fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC,
-							S_IRUSR | S_IWUSR);
-		if (fd < 0)
-			return false;
-	}
+	} else
+		fd = open_key_file(node, app_key_dir, app_idx, true,
+						O_WRONLY | O_CREAT | O_TRUNC);
+
+	if (fd < 0)
+		return false;
 
 	if (write(fd, key, sizeof(*key)) == sizeof(*key))
 		result = true;
@@ -212,8 +212,7 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 						dev_key_dir, unicast + i);
 		l_debug("Put Dev Key %s", key_file);
 
-		fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC,
-							S_IRUSR | S_IWUSR);
+		fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC, 0600);
 		if (fd >= 0) {
 			if (write(fd, dev_key, 16) != 16)
 				result = false;
@@ -226,24 +225,19 @@ bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
 	return result;
 }
 
-bool keyring_get_net_key(struct mesh_node *node, uint16_t net_idx,
-						struct keyring_net_key *key)
+static bool get_key(struct mesh_node *node, const char *key_dir,
+					uint16_t key_idx, void *key, ssize_t sz)
 {
-	const char *node_path;
-	char key_file[PATH_MAX];
 	bool result = false;
 	int fd;
 
-	if (!node || !key)
+	if (!key)
 		return false;
 
-	node_path = node_get_storage_dir(node);
-	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, net_key_dir,
-								net_idx);
+	fd = open_key_file(node, key_dir, key_idx, false, O_RDONLY);
 
-	fd = open(key_file, O_RDONLY);
 	if (fd >= 0) {
-		if (read(fd, key, sizeof(*key)) == sizeof(*key))
+		if (read(fd, key, sz) == sz)
 			result = true;
 
 		close(fd);
@@ -252,30 +246,16 @@ bool keyring_get_net_key(struct mesh_node *node, uint16_t net_idx,
 	return result;
 }
 
+bool keyring_get_net_key(struct mesh_node *node, uint16_t net_idx,
+						struct keyring_net_key *key)
+{
+	return get_key(node, net_key_dir, net_idx, key, sizeof(*key));
+}
+
 bool keyring_get_app_key(struct mesh_node *node, uint16_t app_idx,
 						struct keyring_app_key *key)
 {
-	const char *node_path;
-	char key_file[PATH_MAX];
-	bool result = false;
-	int fd;
-
-	if (!node || !key)
-		return false;
-
-	node_path = node_get_storage_dir(node);
-	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, app_key_dir,
-								app_idx);
-
-	fd = open(key_file, O_RDONLY);
-	if (fd >= 0) {
-		if (read(fd, key, sizeof(*key)) == sizeof(*key))
-			result = true;
-
-		close(fd);
-	}
-
-	return result;
+	return get_key(node, app_key_dir, app_idx, key, sizeof(*key));
 }
 
 bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
-- 
2.26.2


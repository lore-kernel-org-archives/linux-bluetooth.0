Return-Path: <SRS0=kXS7=33=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1845C2D0B1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 06:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B904C21741
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 06:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgBGGjs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:39:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:53801 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgBGGjr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Feb 2020 01:39:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 22:39:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,412,1574150400"; 
   d="scan'208";a="264888587"
Received: from ingas-nuc1.sea.intel.com ([10.254.98.3])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2020 22:39:46 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix keyring app keys directory iteration
Date:   Thu,  6 Feb 2020 22:39:45 -0800
Message-Id: <20200207063945.21943-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes how app key files are accessed when finalizing
Key Refresh procedure. Instead of using open(entry->d_name, ...)
to get file descriptor, use openat(dir_fd, entry->d_name, ...)
since entry->d_name contains a relative app key filename, not an
absolute path.
---
 mesh/keyring.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index 41cb2e980..29c5f1e8e 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -123,12 +123,12 @@ bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
 	return result;
 }
 
-static void finalize(const char *fpath, uint16_t net_idx)
+static void finalize(int dir_fd, const char *fname, uint16_t net_idx)
 {
 	struct keyring_app_key key;
 	int fd;
 
-	fd = open(fpath, O_RDWR);
+	fd = openat(dir_fd, fname, O_RDWR);
 
 	if (fd < 0)
 		return;
@@ -137,7 +137,7 @@ static void finalize(const char *fpath, uint16_t net_idx)
 						key.net_idx != net_idx)
 		goto done;
 
-	l_debug("Finalize %s", fpath);
+	l_debug("Finalize %s", fname);
 	memcpy(key.old_key, key.new_key, 16);
 	lseek(fd, 0, SEEK_SET);
 
@@ -153,6 +153,7 @@ bool keyring_finalize_app_keys(struct mesh_node *node, uint16_t net_idx)
 	const char *node_path;
 	char key_dir[PATH_MAX];
 	DIR *dir;
+	int dir_fd;
 	struct dirent *entry;
 
 	if (!node)
@@ -170,10 +171,12 @@ bool keyring_finalize_app_keys(struct mesh_node *node, uint16_t net_idx)
 		return false;
 	}
 
+	dir_fd = dirfd(dir);
+
 	while ((entry = readdir(dir)) != NULL) {
 		/* AppKeys are stored in regular files */
 		if (entry->d_type == DT_REG)
-			finalize(entry->d_name, net_idx);
+			finalize(dir_fd, entry->d_name, net_idx);
 	}
 
 	closedir(dir);
-- 
2.21.1


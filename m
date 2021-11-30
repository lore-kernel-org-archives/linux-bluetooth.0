Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD98C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Nov 2021 23:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhK3XRk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Nov 2021 18:17:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:4001 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231514AbhK3XRj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Nov 2021 18:17:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="223565979"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="223565979"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 15:14:19 -0800
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="609312241"
Received: from timothyo-mobl1.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.60.104])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 15:14:18 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Don't log error for false positive mkdir failure
Date:   Tue, 30 Nov 2021 15:14:12 -0800
Message-Id: <20211130231412.97437-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When invoking mkdir() for mesh configuration storage, do not
report an error if a target directory already exists.
---
 mesh/keyring.c | 2 +-
 mesh/rpl.c     | 4 ++--
 mesh/util.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index 51621777d..b44091154 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -50,7 +50,7 @@ static int open_key_file(struct mesh_node *node, const char *key_dir,
 
 	if (flags & O_CREAT) {
 		snprintf(fname, PATH_MAX, "%s%s", node_path, key_dir);
-		if (mkdir(fname, 0755) != 0)
+		if (mkdir(fname, 0755) != 0 && errno != EEXIST)
 			l_error("Failed to create dir(%d): %s", errno, fname);
 	}
 
diff --git a/mesh/rpl.c b/mesh/rpl.c
index 9a99afe7b..6bb3532b2 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -255,7 +255,7 @@ void rpl_update(struct mesh_node *node, uint32_t cur)
 
 	/* Make sure path exists */
 	snprintf(path, PATH_MAX, "%s%s", node_path, rpl_dir);
-	if (mkdir(path, 0755) != 0)
+	if (mkdir(path, 0755) != 0 && errno != EEXIST)
 		l_error("Failed to create dir(%d): %s", errno, path);
 
 	dir = opendir(path);
@@ -293,7 +293,7 @@ bool rpl_init(const char *node_path)
 		return false;
 
 	snprintf(path, PATH_MAX, "%s%s", node_path, rpl_dir);
-	if (mkdir(path, 0755) != 0)
+	if (mkdir(path, 0755) != 0 && errno != EEXIST)
 		l_error("Failed to create dir(%d): %s", errno, path);
 	return true;
 }
diff --git a/mesh/util.c b/mesh/util.c
index d505e7a0c..82b57f642 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -118,13 +118,13 @@ int create_dir(const char *dir_name)
 		}
 
 		strncat(dir, prev + 1, next - prev);
-		if (mkdir(dir, 0755) != 0)
+		if (mkdir(dir, 0755) != 0 && errno != EEXIST)
 			l_error("Failed to create dir(%d): %s", errno, dir);
 
 		prev = next;
 	}
 
-	if (mkdir(dir_name, 0755) != 0)
+	if (mkdir(dir_name, 0755) != 0 && errno != EEXIST)
 		l_error("Failed to create dir(%d): %s", errno, dir_name);
 
 	return 0;
-- 
2.31.1


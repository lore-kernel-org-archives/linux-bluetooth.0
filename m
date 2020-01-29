Return-Path: <SRS0=JIrD=3S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B880C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 02:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F12207FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 02:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgA2CdJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 21:33:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:53194 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgA2CdJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 21:33:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 18:33:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,376,1574150400"; 
   d="scan'208";a="427831882"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.255.84.27])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jan 2020 18:33:08 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        rafal.gajda@silvair.com
Subject: [PATCH BlueZ v4 1/5] mesh: Relocate tree deletion to util.c/h
Date:   Tue, 28 Jan 2020 18:32:54 -0800
Message-Id: <20200129023258.10004-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200129023258.10004-1-brian.gix@intel.com>
References: <20200129023258.10004-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh-config-json.c | 20 +-------------------
 mesh/util.c             | 25 +++++++++++++++++++++++++
 mesh/util.h             |  1 +
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 5855149e3..ad2d4d0f8 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -2253,24 +2253,6 @@ bool mesh_config_load_nodes(const char *cfgdir_name, mesh_config_node_func_t cb,
 	return true;
 }
 
-static int del_fobject(const char *fpath, const struct stat *sb, int typeflag,
-						struct FTW *ftwbuf)
-{
-	switch (typeflag) {
-	case FTW_DP:
-		rmdir(fpath);
-		l_debug("RMDIR %s", fpath);
-		break;
-
-	case FTW_SL:
-	default:
-		remove(fpath);
-		l_debug("RM %s", fpath);
-		break;
-	}
-	return 0;
-}
-
 void mesh_config_destroy(struct mesh_config *cfg)
 {
 	char *node_dir, *node_name;
@@ -2291,7 +2273,7 @@ void mesh_config_destroy(struct mesh_config *cfg)
 	if (strcmp(node_name, uuid))
 		return;
 
-	nftw(node_dir, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
+	del_path(node_dir);
 
 	/* Release node config object */
 	mesh_config_release(cfg);
diff --git a/mesh/util.c b/mesh/util.c
index 986ba4b28..43340f159 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -24,6 +24,7 @@
 #define _GNU_SOURCE
 #include <dirent.h>
 #include <ftw.h>
+#include <unistd.h>
 #include <stdio.h>
 #include <limits.h>
 #include <time.h>
@@ -129,3 +130,27 @@ int create_dir(const char *dir_name)
 
 	return 0;
 }
+
+static int del_fobject(const char *fpath, const struct stat *sb, int typeflag,
+						struct FTW *ftwbuf)
+{
+	switch (typeflag) {
+	case FTW_DP:
+		rmdir(fpath);
+		l_debug("RMDIR %s", fpath);
+		break;
+
+	case FTW_SL:
+	default:
+		remove(fpath);
+		l_debug("RM %s", fpath);
+		break;
+	}
+	return 0;
+}
+
+
+void del_path(const char *path)
+{
+	nftw(path, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
+}
diff --git a/mesh/util.h b/mesh/util.h
index d1e83b573..092d33041 100644
--- a/mesh/util.h
+++ b/mesh/util.h
@@ -23,3 +23,4 @@ bool str2hex(const char *str, uint16_t in_len, uint8_t *out,
 size_t hex2str(uint8_t *in, size_t in_len, char *out, size_t out_len);
 void print_packet(const char *label, const void *data, uint16_t size);
 int create_dir(const char *dir_name);
+void del_path(const char *path);
-- 
2.21.1


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA711C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8613C610A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbhIWD2o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:16373 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239045AbhIWD2l (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555895"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555895"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072328"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:51 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 02/20] tools/mesh-cfgclient: Add timestamp to config database
Date:   Wed, 22 Sep 2021 20:25:45 -0700
Message-Id: <20210923032603.50536-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds timestamp property to the configuration database.
The UTC timestamp format: YYYY-MM-DDThh:mm:ssZ
---
 tools/mesh/mesh-db.c | 56 +++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 50fbc18cb..d42587da8 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -3,7 +3,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2019  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2019-2020  Intel Corporation. All rights reserved.
  *
  *
  */
@@ -20,10 +20,9 @@
 #include <libgen.h>
 #include <stdio.h>
 #include <string.h>
+#include <time.h>
 #include <unistd.h>
 
-#include <sys/time.h>
-
 #include <ell/ell.h>
 #include <json-c/json.h>
 
@@ -42,13 +41,39 @@ struct mesh_db {
 	json_object *jcfg;
 	char *cfg_fname;
 	uint8_t token[8];
-	struct timeval write_time;
 };
 
 static struct mesh_db *cfg;
 static const char *bak_ext = ".bak";
 static const char *tmp_ext = ".tmp";
 
+static bool add_string(json_object *jobj, const char *desc, const char *str)
+{
+	json_object *jstring = json_object_new_string(str);
+
+	if (!jstring)
+		return false;
+
+	json_object_object_add(jobj, desc, jstring);
+	return true;
+}
+
+static bool set_timestamp(json_object *jobj)
+{
+	time_t time_raw;
+	struct tm *tp;
+	char buf[80];
+
+	time(&time_raw);
+	tp = gmtime(&time_raw);
+
+	strftime(buf, 80, "%FT%TZ", tp);
+
+	json_object_object_del(jobj, "timestamp");
+
+	return add_string(jobj, "timestamp", buf);
+}
+
 static bool save_config_file(const char *fname)
 {
 	FILE *outfile;
@@ -61,6 +86,8 @@ static bool save_config_file(const char *fname)
 		return false;
 	}
 
+	set_timestamp(cfg->jcfg);
+
 	str = json_object_to_json_string_ext(cfg->jcfg,
 						JSON_C_TO_STRING_PRETTY);
 
@@ -97,8 +124,6 @@ static bool save_config(void)
 	l_free(fname_tmp);
 	l_free(fname_bak);
 
-	gettimeofday(&cfg->write_time, NULL);
-
 	return result;
 }
 
@@ -289,17 +314,6 @@ static bool add_u8_16(json_object *jobj, const char *desc,
 	return true;
 }
 
-static bool add_string(json_object *jobj, const char *desc, const char *str)
-{
-	json_object *jstring = json_object_new_string(str);
-
-	if (!jstring)
-		return false;
-
-	json_object_object_add(jobj, desc, jstring);
-	return true;
-}
-
 static bool get_token(json_object *jobj, uint8_t token[8])
 {
 	json_object *jval;
@@ -726,6 +740,9 @@ bool mesh_db_net_key_add(uint16_t net_idx)
 	if (!write_int(jkey, "phase", KEY_REFRESH_PHASE_NONE))
 		goto fail;
 
+	if (!set_timestamp(jkey))
+		goto fail;
+
 	json_object_array_add(jarray, jkey);
 
 	return save_config();
@@ -960,10 +977,7 @@ bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 
 	json_object_array_add(jnodes, jnode);
 
-	if (!save_config())
-		goto fail;
-
-	return true;
+	return save_config();
 
 fail:
 	json_object_put(jnode);
-- 
2.31.1


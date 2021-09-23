Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE492C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF18361130
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbhIWD2q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:16381 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239050AbhIWD2o (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555903"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555903"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:54 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072347"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:54 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 06/20] tools/mesh-cfgclient: Overwrite config values when adding new ones
Date:   Wed, 22 Sep 2021 20:25:49 -0700
Message-Id: <20210923032603.50536-7-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This changes common utilities used in mesh-db.c to replace old values
by default whenever a new value is written.
---
 tools/mesh/mesh-db.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index bf9344931..f0e0aeb71 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -54,6 +54,9 @@ static bool add_string(json_object *jobj, const char *desc, const char *str)
 	if (!jstring)
 		return false;
 
+	/* Overwrite old value if present */
+	json_object_object_del(jobj, desc);
+
 	json_object_object_add(jobj, desc, jstring);
 	return true;
 }
@@ -69,8 +72,6 @@ static bool set_timestamp(json_object *jobj)
 
 	strftime(buf, 80, "%FT%TZ", tp);
 
-	json_object_object_del(jobj, "timestamp");
-
 	return add_string(jobj, "timestamp", buf);
 }
 
@@ -190,12 +191,13 @@ static bool write_int(json_object *jobj, const char *keyword, int val)
 {
 	json_object *jval;
 
-	json_object_object_del(jobj, keyword);
-
 	jval = json_object_new_int(val);
 	if (!jval)
 		return false;
 
+	/* Overwrite old value if present */
+	json_object_object_del(jobj, keyword);
+
 	json_object_object_add(jobj, keyword, jval);
 	return true;
 }
@@ -222,12 +224,13 @@ static bool write_bool(json_object *jobj, const char *keyword, bool val)
 {
 	json_object *jval;
 
-	json_object_object_del(jobj, keyword);
-
 	jval = json_object_new_boolean(val);
 	if (!jval)
 		return false;
 
+	/* Overwrite old value if present */
+	json_object_object_del(jobj, keyword);
+
 	json_object_object_add(jobj, keyword, jval);
 	return true;
 }
@@ -262,6 +265,9 @@ static bool write_uint16_hex(json_object *jobj, const char *desc,
 	if (!jstring)
 		return false;
 
+	/* Overwrite old value if present */
+	json_object_object_del(jobj, desc);
+
 	json_object_object_add(jobj, desc, jstring);
 	return true;
 }
@@ -327,6 +333,9 @@ static bool add_u8_8(json_object *jobj, const char *desc,
 	if (!jstring)
 		return false;
 
+	/* Overwrite old value if present */
+	json_object_object_del(jobj, desc);
+
 	json_object_object_add(jobj, desc, jstring);
 	return true;
 }
@@ -342,6 +351,9 @@ static bool add_u8_16(json_object *jobj, const char *desc,
 	if (!jstring)
 		return false;
 
+	/* Overwrite old value if present */
+	json_object_object_del(jobj, desc);
+
 	json_object_object_add(jobj, desc, jstring);
 	return true;
 }
-- 
2.31.1


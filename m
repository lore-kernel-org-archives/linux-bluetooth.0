Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BB8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3FD610A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbhIWD2n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:16373 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239042AbhIWD2l (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555898"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555898"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072335"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:52 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 03/20] tools/mesh-cfgclient: Update stored NetKey and AppKey
Date:   Wed, 22 Sep 2021 20:25:46 -0700
Message-Id: <20210923032603.50536-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

NetKeys:
- Record additional properties: "name", "minSecurity", "timestamp"

AppKeys:
- Record additional property: "name"
---
 tools/mesh/mesh-db.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index d42587da8..5b3c4b2f7 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -517,6 +517,7 @@ static void load_remotes(json_object *jcfg)
 static bool add_app_key(json_object *jobj, uint16_t net_idx, uint16_t app_idx)
 {
 	json_object *jkey, *jarray;
+	char buf[12];
 
 	json_object_object_get_ex(jobj, "appKeys", &jarray);
 	if (!jarray || json_object_get_type(jarray) != json_type_array)
@@ -524,6 +525,11 @@ static bool add_app_key(json_object *jobj, uint16_t net_idx, uint16_t app_idx)
 
 	jkey = json_object_new_object();
 
+	snprintf(buf, 12, "AppKey %4.4x", app_idx);
+
+	if (!add_string(jkey, "name", buf))
+		goto fail;
+
 	if (!write_int(jkey, "boundNetKey", (int)net_idx))
 		goto fail;
 
@@ -721,6 +727,7 @@ static bool load_keys(json_object *jobj)
 bool mesh_db_net_key_add(uint16_t net_idx)
 {
 	json_object *jkey, *jarray;
+	char buf[12];
 
 	if (!cfg || !cfg->jcfg)
 		return false;
@@ -734,12 +741,20 @@ bool mesh_db_net_key_add(uint16_t net_idx)
 
 	jkey = json_object_new_object();
 
+	snprintf(buf, 12, "Subnet %4.4x", net_idx);
+
+	if (!add_string(jkey, "name", buf))
+		goto fail;
+
 	if (!write_int(jkey, "index", net_idx))
 		goto fail;
 
 	if (!write_int(jkey, "phase", KEY_REFRESH_PHASE_NONE))
 		goto fail;
 
+	if (!add_string(jkey, "minSecurity", "secure"))
+		goto fail;
+
 	if (!set_timestamp(jkey))
 		goto fail;
 
-- 
2.31.1


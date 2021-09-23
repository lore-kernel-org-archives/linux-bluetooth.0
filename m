Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD676C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9415A60F48
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbhIWD27 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:16373 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239072AbhIWD2q (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555935"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555935"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:27:03 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072410"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:27:03 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 19/20] tools/mesh-cfgclient: Excluded addresses property
Date:   Wed, 22 Sep 2021 20:26:02 -0700
Message-Id: <20210923032603.50536-20-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The correct name for a property that contains a list of addresses
not allowed in circulation is "networkExclusions"
The "excluded" property in "nodes" array entry is used to indicated that
this node has been removed from a mesh network and it's address should not
be re-used.
---
 tools/mesh/mesh-db.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index b45212fc9..262a274c7 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -1724,7 +1724,7 @@ bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 	if (!add_string(jnode, "security", "secure"))
 		goto fail;
 
-	if (!write_bool(jnode, "blacklisted", false))
+	if (!write_bool(jnode, "excluded", false))
 		goto fail;
 
 	if (!write_bool(jnode, "configComplete", false))
@@ -2165,7 +2165,7 @@ static bool load_rejected_addresses(json_object *jobj)
 	json_object *jarray;
 	int i, cnt;
 
-	json_object_object_get_ex(jobj, "blacklistedAddresses", &jarray);
+	json_object_object_get_ex(jobj, "networkExclusions", &jarray);
 	if (!jarray || json_object_get_type(jarray) != json_type_array)
 		return true;
 
@@ -2212,11 +2212,10 @@ bool mesh_db_add_rejected_addr(uint16_t unicast, uint32_t iv_index)
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	json_object_object_get_ex(cfg->jcfg, "blacklistedAddresses", &jarray);
+	json_object_object_get_ex(cfg->jcfg, "networkExclusions", &jarray);
 	if (!jarray) {
 		jarray = json_object_new_array();
-		json_object_object_add(cfg->jcfg, "blacklistedAddresses",
-									jarray);
+		json_object_object_add(cfg->jcfg, "networkExclusions", jarray);
 	}
 
 	idx = get_rejected_by_iv_index(jarray, iv_index);
@@ -2261,7 +2260,7 @@ bool mesh_db_clear_rejected(uint32_t iv_index)
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	json_object_object_get_ex(cfg->jcfg, "blacklistedAddresses", &jarray);
+	json_object_object_get_ex(cfg->jcfg, "networkExclusions", &jarray);
 	if (!jarray || json_object_get_type(jarray) != json_type_array)
 		return false;
 
@@ -2338,7 +2337,7 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 	if (!jarray)
 		goto fail;
 
-	json_object_object_add(jcfg, "blacklistedAddresses", jarray);
+	json_object_object_add(jcfg, "networkExclusions", jarray);
 
 	write_int(jcfg, "ivIndex", 0);
 
-- 
2.31.1


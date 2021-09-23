Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29670C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B4760F48
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbhIWD2z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:16377 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239065AbhIWD2p (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555933"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555933"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:27:03 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072407"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:27:02 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 18/20] tools/mesh-cfgclient: Store UUIDs in standard format
Date:   Wed, 22 Sep 2021 20:26:01 -0700
Message-Id: <20210923032603.50536-19-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use standard xxxx-xx-xx-xx-xxxxxxxx format for string
representation of mesh and node UUIDs in stored configuration.
---
 tools/mesh/mesh-db.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 0dc811801..b45212fc9 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -293,10 +293,11 @@ static bool write_uint32_hex(json_object *jobj, const char *desc, uint32_t val)
 static json_object *get_node_by_uuid(json_object *jcfg, uint8_t uuid[16])
 {
 	json_object *jarray = NULL;
-	char buf[33];
+	char buf[37];
 	int i, sz;
 
-	hex2str(uuid, 16, buf, sizeof(buf));
+	if (!l_uuid_to_string(uuid, buf, sizeof(buf)))
+		return NULL;
 
 	json_object_object_get_ex(jcfg, "nodes", &jarray);
 	if (!jarray || json_object_get_type(jarray) != json_type_array)
@@ -313,7 +314,7 @@ static json_object *get_node_by_uuid(json_object *jcfg, uint8_t uuid[16])
 			return NULL;
 
 		str = json_object_get_string(jval);
-		if (strlen(str) != 32)
+		if (strlen(str) != 36)
 			continue;
 
 		if (!strcmp(buf, str))
@@ -506,10 +507,11 @@ static void load_remotes(json_object *jcfg)
 			continue;
 
 		str = json_object_get_string(jval);
-		if (strlen(str) != 32)
+		if (strlen(str) != 36)
 			continue;
 
-		str2hex(str, 32, uuid, 16);
+		if (!l_uuid_from_string(str, uuid))
+			continue;
 
 		if (!json_object_object_get_ex(jnode, "unicastAddress", &jval))
 			continue;
@@ -1698,6 +1700,7 @@ bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 {
 	json_object *jnode;
 	json_object *jelements, *jnodes, *jnetkeys, *jappkeys;
+	char buf[37];
 
 	if (!cfg || !cfg->jcfg)
 		return false;
@@ -1712,9 +1715,11 @@ bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 	if (!jnode)
 		return false;
 
-	if (!add_u8_16(jnode, "UUID", uuid))
+	if (!l_uuid_to_string(uuid, buf, sizeof(buf)))
 		goto fail;
 
+	if (!add_string(jnode, "UUID", buf))
+		goto fail;
 
 	if (!add_string(jnode, "security", "secure"))
 		goto fail;
@@ -2065,6 +2070,7 @@ bool mesh_db_add_provisioner(const char *name, uint8_t uuid[16],
 					uint16_t group_low, uint16_t group_high)
 {
 	json_object *jprovs, *jprov, *jscenes;
+	char buf[37];
 
 	if (!cfg || !cfg->jcfg)
 		return false;
@@ -2080,7 +2086,10 @@ bool mesh_db_add_provisioner(const char *name, uint8_t uuid[16],
 	if (!add_string(jprov, "provisionerName", name))
 		goto fail;
 
-	if (!add_u8_16(jprov, "UUID", uuid))
+	if (!l_uuid_to_string(uuid, buf, sizeof(buf)))
+		goto fail;
+
+	if (!add_string(jprov, "UUID", buf))
 		goto fail;
 
 	if (!add_range(jprov, "allocatedUnicastRange", unicast_low,
@@ -2270,6 +2279,7 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 {
 	json_object *jcfg, *jarray;
 	uint8_t uuid[16];
+	char buf[37];
 
 	if (cfg)
 		return false;
@@ -2291,7 +2301,10 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 
 	l_uuid_v4(uuid);
 
-	if (!add_u8_16(jcfg, "meshUUID", uuid))
+	if (!l_uuid_to_string(uuid, buf, sizeof(buf)))
+		goto fail;
+
+	if (!add_string(jcfg, "meshUUID", buf))
 		goto fail;
 
 	if (mesh_name && !add_string(jcfg, "meshName", mesh_name))
-- 
2.31.1


Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3291C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 00:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FA320737
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 00:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390331AbgDCAyj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:54:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:21186 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390138AbgDCAyi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Apr 2020 20:54:38 -0400
IronPort-SDR: zR7mZUbWU/YcBJHyNPAC5dR0/1Y4jVvu8DswsbeLSkELy+2aoDfc+dOjsJ+AByVZ/w17vrBrEU
 Q2Yy533sRtbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 17:54:38 -0700
IronPort-SDR: sd9uwoh1enRIF4ZmcG8MsDYwXClG7RUds9PzDWeVi2oRFslGtYUZFqbyflJOn3OK3L1RW5623I
 zJRNDC6ZzM9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,337,1580803200"; 
   d="scan'208";a="449843073"
Received: from ingas-nuc1.sea.intel.com ([10.255.231.70])
  by fmsmga005.fm.intel.com with ESMTP; 02 Apr 2020 17:54:37 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2] tools/mescfg-client: Use local routines for config write
Date:   Thu,  2 Apr 2020 17:54:35 -0700
Message-Id: <20200403005436.15034-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes dependencies on internal structures of
mesh/mesh-config-json.c.
---
 Makefile.tools       |  1 -
 tools/mesh/mesh-db.c | 63 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index f43764adc..9b9236609 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -336,7 +336,6 @@ tools_mesh_cfgclient_SOURCES = tools/mesh-cfgclient.c \
 				tools/mesh/agent.h tools/mesh/agent.c \
 				tools/mesh/mesh-db.h tools/mesh/mesh-db.c \
 				mesh/util.h mesh/util.c \
-				mesh/mesh-config.h mesh/mesh-config-json.c \
 				mesh/crypto.h mesh/crypto.c
 
 tools_mesh_cfgclient_LDADD = lib/libbluetooth-internal.la src/libshared-ell.la \
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 05e96e554..21bccf653 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -50,12 +50,44 @@ struct mesh_db {
 	json_object *jcfg;
 	char *cfg_fname;
 	uint8_t token[8];
-	uint8_t pad[12];
 	struct timeval write_time;
 };
 
 struct mesh_db *cfg;
 
+static bool save_config(void)
+{
+	FILE *outfile;
+	const char *str;
+	bool result = false;
+
+	outfile = fopen(cfg->cfg_fname, "w");
+	if (!outfile) {
+		l_error("Failed to save configuration to %s", cfg->cfg_fname);
+		return false;
+	}
+
+	str = json_object_to_json_string_ext(cfg->jcfg,
+						JSON_C_TO_STRING_PRETTY);
+
+	if (fwrite(str, sizeof(char), strlen(str), outfile) < strlen(str))
+		l_warn("Incomplete write of mesh configuration");
+	else
+		result = true;
+
+	fclose(outfile);
+
+	return result;
+}
+
+static void release_config(void)
+{
+	l_free(cfg->cfg_fname);
+	json_object_put(cfg->jcfg);
+	l_free(cfg);
+	cfg = NULL;
+}
+
 static json_object *get_node_by_unicast(uint16_t unicast)
 {
 	json_object *jarray;
@@ -430,7 +462,7 @@ static bool add_node_key(json_object *jobj, const char *desc, uint16_t idx)
 	json_object_object_add(jkey, "index", jval);
 	json_object_array_add(jarray, jkey);
 
-	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+	return save_config();
 }
 
 bool mesh_db_node_net_key_add(uint16_t unicast, uint16_t idx)
@@ -461,7 +493,7 @@ bool mesh_db_node_ttl_set(uint16_t unicast, uint8_t ttl)
 	if (!write_int(jnode, "defaultTTL", ttl))
 		return false;
 
-	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+	return save_config();
 }
 
 static void jarray_key_del(json_object *jarray, int16_t idx)
@@ -500,7 +532,7 @@ static bool delete_key(json_object *jobj, const char *desc, uint16_t idx)
 
 	jarray_key_del(jarray, idx);
 
-	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+	return save_config();
 }
 
 bool mesh_db_node_net_key_del(uint16_t unicast, uint16_t net_idx)
@@ -645,7 +677,7 @@ bool mesh_db_net_key_add(uint16_t net_idx)
 
 	json_object_array_add(jarray, jkey);
 
-	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+	return save_config();
 
 fail:
 	json_object_put(jkey);
@@ -681,7 +713,7 @@ bool mesh_db_net_key_phase_set(uint16_t net_idx, uint8_t phase)
 
 	json_object_object_add(jkey, "phase", jval);
 
-	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+	return save_config();
 }
 
 bool mesh_db_app_key_add(uint16_t net_idx, uint16_t app_idx)
@@ -692,7 +724,7 @@ bool mesh_db_app_key_add(uint16_t net_idx, uint16_t app_idx)
 	if (!add_app_key(cfg->jcfg, net_idx, app_idx))
 		return false;
 
-	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+	return save_config();
 }
 
 bool mesh_db_app_key_del(uint16_t app_idx)
@@ -735,7 +767,7 @@ bool mesh_db_add_group(struct mesh_group *grp)
 
 	json_object_array_add(jgroups, jgroup);
 
-	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+	return save_config();
 
 fail:
 	json_object_put(jgroup);
@@ -873,7 +905,7 @@ bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 
 	json_object_array_add(jnodes, jnode);
 
-	if (!mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL))
+	if (!save_config())
 		goto fail;
 
 	return true;
@@ -919,7 +951,7 @@ bool mesh_db_del_node(uint16_t unicast)
 
 	json_object_array_del_idx(jarray, i, 1);
 
-	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+	return save_config();
 }
 
 bool mesh_db_get_token(uint8_t token[8])
@@ -966,7 +998,7 @@ bool mesh_db_set_addr_range(uint16_t low, uint16_t high)
 	if (!write_uint16_hex(cfg->jcfg, "high", high))
 		return false;
 
-	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+	return save_config();
 }
 
 bool mesh_db_create(const char *fname, const uint8_t token[8],
@@ -1019,14 +1051,13 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 
 	json_object_object_add(jcfg, "appKeys", jarray);
 
-	if (!mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL))
+	if (!save_config())
 		goto fail;
 
 	return true;
 
 fail:
-	mesh_config_release((struct mesh_config *)cfg);
-	cfg = NULL;
+	release_config();
 
 	return false;
 }
@@ -1085,7 +1116,7 @@ bool mesh_db_load(const char *fname)
 
 	return true;
 fail:
-	mesh_config_release((struct mesh_config *)cfg);
-	cfg = NULL;
+	release_config();
+
 	return false;
 }
-- 
2.21.1


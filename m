Return-Path: <SRS0=Rej4=6X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E9CC54E4A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 00:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED94217BA
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 00:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgEIAA3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 May 2020 20:00:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:65494 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbgEIAA2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 May 2020 20:00:28 -0400
IronPort-SDR: +gqOE3ba+hkID4hGVhVuue38zW3VCNU+uX4Ve5V8N1s7+lT0NSJJa/t9XPPU8BnovbrNU5CpZs
 tIBz77P1Q6iA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 17:00:27 -0700
IronPort-SDR: 18J4PDrRCI27uTUOSbexTEd1OC6lDhgcZb1Wp4Xf0WP+0udlc1ADaV76jcLAobn5CJxHJvKM2I
 ykpcDPXut0eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,369,1583222400"; 
   d="scan'208";a="408275101"
Received: from ingas-nuc1.sea.intel.com ([10.254.110.242])
  by orsmga004.jf.intel.com with ESMTP; 08 May 2020 17:00:27 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/4] mesh: Allow updating CID, PID, VID & CRPL on node attach
Date:   Fri,  8 May 2020 17:00:23 -0700
Message-Id: <20200509000024.5704-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200509000024.5704-1-inga.stotland@intel.com>
References: <20200509000024.5704-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This allows to update settings of the following composition fields
when an existing node (application) attaches to the daemon:
Company ID (CID), Product ID (PID), Versioin ID (VID),
CRPL (replay protection depth)
---
 mesh/mesh-config-json.c | 32 ++++++++++++++++++++++++++++++++
 mesh/mesh-config.h      |  4 ++++
 mesh/node.c             | 17 +++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index ce7058b5a..9ac3979f8 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -2057,6 +2057,38 @@ bool mesh_config_write_ttl(struct mesh_config *cfg, uint8_t ttl)
 	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
+bool mesh_config_update_company_id(struct mesh_config *cfg, uint16_t cid)
+{
+	if (!cfg || !write_uint16_hex(cfg->jnode, "cid", cid))
+		return false;
+
+	return save_config(cfg->jnode, cfg->node_dir_path);
+}
+
+bool mesh_config_update_product_id(struct mesh_config *cfg, uint16_t pid)
+{
+	if (!cfg || !write_uint16_hex(cfg->jnode, "pid", pid))
+		return false;
+
+	return save_config(cfg->jnode, cfg->node_dir_path);
+}
+
+bool mesh_config_update_version_id(struct mesh_config *cfg, uint16_t vid)
+{
+	if (!cfg || !write_uint16_hex(cfg->jnode, "vid", vid))
+		return false;
+
+	return save_config(cfg->jnode, cfg->node_dir_path);
+}
+
+bool mesh_config_update_crpl(struct mesh_config *cfg, uint16_t crpl)
+{
+	if (!cfg || !write_uint16_hex(cfg->jnode, "crpl", crpl))
+		return false;
+
+	return save_config(cfg->jnode, cfg->node_dir_path);
+}
+
 static bool load_node(const char *fname, const uint8_t uuid[16],
 				mesh_config_node_func_t cb, void *user_data)
 {
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index a5b12bbad..25002f5a7 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -172,3 +172,7 @@ bool mesh_config_net_key_set_phase(struct mesh_config *cfg, uint16_t idx,
 bool mesh_config_write_address(struct mesh_config *cfg, uint16_t address);
 bool mesh_config_write_iv_index(struct mesh_config *cfg, uint32_t idx,
 								bool update);
+bool mesh_config_update_company_id(struct mesh_config *cfg, uint16_t cid);
+bool mesh_config_update_product_id(struct mesh_config *cfg, uint16_t pid);
+bool mesh_config_update_version_id(struct mesh_config *cfg, uint16_t vid);
+bool mesh_config_update_crpl(struct mesh_config *cfg, uint16_t crpl);
diff --git a/mesh/node.c b/mesh/node.c
index e3f9e52e3..a96c0cae1 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1374,6 +1374,21 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 	return true;
 }
 
+static void update_composition(struct mesh_node *node, struct mesh_node *attach)
+{
+	if (node->comp.cid != attach->comp.cid)
+		mesh_config_update_company_id(node->cfg, attach->comp.cid);
+
+	if (node->comp.pid != attach->comp.pid)
+		mesh_config_update_product_id(node->cfg, attach->comp.pid);
+
+	if (node->comp.vid != attach->comp.vid)
+		mesh_config_update_version_id(node->cfg, attach->comp.vid);
+
+	if (node->comp.crpl != attach->comp.crpl)
+		mesh_config_update_crpl(node->cfg, attach->comp.crpl);
+}
+
 static bool check_req_node(struct managed_obj_request *req)
 {
 	uint8_t node_comp[MAX_MSG_LEN - 2];
@@ -1444,6 +1459,8 @@ static bool attach_req_node(struct mesh_node *attach, struct mesh_node *node)
 	attach->owner = node->owner;
 	node->owner = NULL;
 
+	update_composition(node, attach);
+
 	node_remove(node);
 
 	return true;
-- 
2.21.3


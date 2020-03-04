Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C0BC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 07:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1CC215A4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 07:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgCDHjR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:39:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:1980 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbgCDHjR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Mar 2020 02:39:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 23:39:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; 
   d="scan'208";a="263514579"
Received: from ingas-nuc1.sea.intel.com ([10.251.135.221])
  by fmsmga004.fm.intel.com with ESMTP; 03 Mar 2020 23:39:16 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Record remote node's default TTL
Date:   Tue,  3 Mar 2020 23:39:15 -0800
Message-Id: <20200304073915.24964-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds code to save the value of a remote node's default TTL
upon receiving Config Default TTL Status message.

Also, cleanup leftover "#if 0" clause
---
 tools/mesh/cfgcli.c  |  1 +
 tools/mesh/mesh-db.c | 25 ++++++++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 0aea7e553..33e77d878 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -557,6 +557,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 			return true;
 
 		bt_shell_printf("Node %4.4x Default TTL %d\n", src, data[0]);
+		mesh_db_node_ttl_set(src, data[0]);
 
 		break;
 
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 41114f40f..4a26a667e 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -434,6 +434,24 @@ bool mesh_db_node_net_key_add(uint16_t unicast, uint16_t idx)
 	return add_node_key(jnode, "netKeys", idx);
 }
 
+bool mesh_db_node_ttl_set(uint16_t unicast, uint8_t ttl)
+{
+	json_object *jnode;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(unicast);
+	if (!jnode)
+		return false;
+
+	if (!write_int(jnode, "defaultTTL", ttl))
+		return false;
+
+	return mesh_config_save((struct mesh_config *) cfg, true,
+								NULL, NULL);
+}
+
 static void jarray_key_del(json_object *jarray, int16_t idx)
 {
 	int i, sz = json_object_array_length(jarray);
@@ -923,13 +941,6 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 		goto fail;
 
 	json_object_object_add(jcfg, "appKeys", jarray);
-#if 0
-	jarray = json_object_new_array();
-	if (!jarray)
-		goto fail;
-
-	json_object_object_add(jcfg, "groups", jarray);
-#endif
 
 	if (!mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL))
 		goto fail;
-- 
2.21.1


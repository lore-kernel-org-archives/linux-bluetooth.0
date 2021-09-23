Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954ADC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C51161131
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbhIWD2y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:16377 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239062AbhIWD2p (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555926"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555926"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072384"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:59 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 14/20] tools/mesh-cfgclient: Store remote's heartbeat sub/pub
Date:   Wed, 22 Sep 2021 20:25:57 -0700
Message-Id: <20210923032603.50536-15-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Store remote node's heartbeat publication or subscription info upon
receiving CONFIG_HEARTBEAT_PUB_STATUS or CONFIG_HEARTBEAT_SUB_STATUS
messages when the messages' status code is set to Success.
---
 tools/mesh/cfgcli.c  |  30 +++++++++---
 tools/mesh/mesh-db.c | 113 +++++++++++++++++++++++++++++++++++++++++--
 tools/mesh/mesh-db.h |   4 ++
 3 files changed, 135 insertions(+), 12 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index b5f39df18..2bf1a1503 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -400,7 +400,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 {
 	uint32_t opcode, mod_id;
 	const struct cfg_cmd *cmd;
-	uint16_t app_idx, net_idx, addr, ele_addr;
+	uint16_t app_idx, net_idx, addr, ele_addr, features;
 	struct mesh_group *grp;
 	struct model_pub pub;
 	int n;
@@ -813,13 +813,21 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		bt_shell_printf("\nNode %4.4x Heartbeat publish status %s\n",
 				src, mesh_status_str(data[0]));
 
-		bt_shell_printf("Destination\t%4.4x\n", get_le16(data + 1));
-		bt_shell_printf("Count\t\t%2.2x\n", data[3]);
-		bt_shell_printf("Period\t\t%2.2x\n", data[4]);
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		addr = get_le16(data + 1);
+		bt_shell_printf("Destination\t%4.4x\n", addr);
+		bt_shell_printf("CountLog\t\t%2.2x\n", data[3]);
+		bt_shell_printf("PeriodLog\t\t%2.2x\n", data[4]);
 		bt_shell_printf("TTL\t\t%2.2x\n", data[5]);
-		bt_shell_printf("Features\t%4.4x\n", get_le16(data + 6));
+		features = get_le16(data + 6);
+		bt_shell_printf("Features\t%4.4x\n", features);
 		net_idx = get_le16(data + 8);
 		bt_shell_printf("Net_Idx\t%u (0x%3.3x)\n", net_idx, net_idx);
+
+		saved = mesh_db_node_set_hb_pub(src, addr, net_idx, data[4],
+							data[5], features);
 		break;
 
 	/* Per Mesh Profile 4.3.2.66 */
@@ -830,12 +838,20 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		bt_shell_printf("\nNode %4.4x Heartbeat subscribe status %s\n",
 				src, mesh_status_str(data[0]));
 
-		bt_shell_printf("Source\t\t%4.4x\n", get_le16(data + 1));
-		bt_shell_printf("Destination\t%4.4x\n", get_le16(data + 3));
+		if (data[0] != MESH_STATUS_SUCCESS)
+			return true;
+
+		ele_addr = get_le16(data + 1);
+		bt_shell_printf("Source\t\t%4.4x\n", ele_addr);
+		addr = get_le16(data + 3);
+		bt_shell_printf("Destination\t%4.4x\n", addr);
 		bt_shell_printf("Period\t\t%2.2x\n", data[5]);
 		bt_shell_printf("Count\t\t%2.2x\n", data[6]);
 		bt_shell_printf("Min Hops\t%2.2x\n", data[7]);
 		bt_shell_printf("Max Hops\t%2.2x\n", data[8]);
+
+		saved = mesh_db_node_set_hb_sub(src, ele_addr, addr);
+
 		break;
 
 	/* Per Mesh Profile 4.3.2.71 */
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 3290c5b8e..42ba831d4 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -963,12 +963,24 @@ static void jarray_string_del(json_object *jarray, const char *str, size_t len)
 	}
 }
 
+static bool add_array_string(json_object *jarray, const char *str)
+{
+	json_object *jstring;
+
+	jstring = json_object_new_string(str);
+	if (!jstring)
+		return false;
+
+	json_object_array_add(jarray, jstring);
+	return true;
+}
+
 static bool update_model_string_array(uint16_t unicast, uint16_t ele_addr,
 						bool vendor, uint32_t mod_id,
 						const char *str, uint32_t len,
 						const char *keyword, bool add)
 {
-	json_object *jarray, *jmod, *jstring;
+	json_object *jarray, *jmod;
 
 	if (!cfg || !cfg->jcfg)
 		return false;
@@ -988,12 +1000,9 @@ static bool update_model_string_array(uint16_t unicast, uint16_t ele_addr,
 	if (!add)
 		return true;
 
-	jstring = json_object_new_string(str);
-	if (!jstring)
+	if (!add_array_string(jarray, str))
 		return false;
 
-	json_object_array_add(jarray, jstring);
-
 	return save_config();
 }
 
@@ -1179,6 +1188,100 @@ fail:
 	return false;
 }
 
+bool mesh_db_node_set_hb_pub(uint16_t unicast, uint16_t dst, uint16_t net_idx,
+						uint8_t period_log, uint8_t ttl,
+							uint16_t features)
+{
+	json_object *jnode, *jpub, *jarray = NULL;
+	uint32_t period;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	if (period_log > 0x12 || ttl > 0x7F)
+		return  false;
+
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
+	if (!jnode)
+		return false;
+
+	jpub = json_object_new_object();
+
+	if (!write_uint16_hex(jpub, "address", dst))
+		goto fail;
+
+	period = period_log ? 1 << (period_log - 1) : 0;
+
+	if (!write_int(jpub, "period", period))
+		goto fail;
+
+	if (!write_int(jpub, "ttl", ttl))
+		goto fail;
+
+	if (!write_int(jpub, "index", net_idx))
+		goto fail;
+
+	jarray = json_object_new_array();
+
+	if (features & FEATURE_PROXY)
+		if (!add_array_string(jarray, "proxy"))
+			goto fail;
+
+	if (features & FEATURE_RELAY)
+		if (!add_array_string(jarray, "relay"))
+			goto fail;
+
+	if (features & FEATURE_FRIEND)
+		if (!add_array_string(jarray, "friend"))
+			goto fail;
+
+	if (features & FEATURE_LPN)
+		if (!add_array_string(jarray, "lowPower"))
+			goto fail;
+
+	json_object_object_add(jpub, "features", jarray);
+	json_object_object_del(jnode, "heartbeatPub");
+	json_object_object_add(jnode, "heartbeatPub", jpub);
+
+	return save_config();
+
+fail:
+	if (jarray)
+		json_object_put(jarray);
+
+	json_object_put(jpub);
+	return false;
+}
+
+bool mesh_db_node_set_hb_sub(uint16_t unicast, uint16_t src, uint16_t dst)
+{
+	json_object *jnode, *jsub;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
+	if (!jnode)
+		return false;
+
+	jsub = json_object_new_object();
+
+	if (!write_uint16_hex(jsub, "source", src))
+		goto fail;
+
+	if (!write_uint16_hex(jsub, "destination", dst))
+		goto fail;
+
+	json_object_object_del(jnode, "heartbeatSub");
+	json_object_object_add(jnode, "heartbeatSub", jsub);
+
+	return save_config();
+
+fail:
+	json_object_put(jsub);
+	return false;
+}
+
 static void jarray_key_del(json_object *jarray, int16_t idx)
 {
 	int i, sz = json_object_array_length(jarray);
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index b3b0bce79..16c46c046 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -74,6 +74,10 @@ bool mesh_db_node_model_del_sub_all(uint16_t unicast, uint16_t ele, bool vendor,
 bool mesh_db_node_model_set_pub(uint16_t unicast, uint16_t ele_addr,
 					bool vendor, uint32_t mod_id,
 					struct model_pub *pub, bool virt);
+bool mesh_db_node_set_hb_pub(uint16_t unicast, uint16_t dst, uint16_t net_idx,
+						uint8_t period_log, uint8_t ttl,
+							uint16_t features);
+bool mesh_db_node_set_hb_sub(uint16_t unicast, uint16_t src, uint16_t dst);
 struct l_queue *mesh_db_load_groups(void);
 bool mesh_db_add_group(struct mesh_group *grp);
 bool mesh_db_add_rejected_addr(uint16_t unicast, uint32_t iv_index);
-- 
2.31.1


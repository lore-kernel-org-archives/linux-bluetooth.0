Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84945C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B260610A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbhIWD2x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:16381 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239061AbhIWD2p (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555924"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555924"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072380"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:59 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 13/20] tools/mesh-cfgclient: Save remote node feature setting
Date:   Wed, 22 Sep 2021 20:25:56 -0700
Message-Id: <20210923032603.50536-14-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Save the information for remote node's relay, friend, proxy and
secure network beacon settings.
---
 tools/mesh/cfgcli.c  |  14 +++-
 tools/mesh/mesh-db.c | 160 +++++++++++++++++++++++++++++++++++--------
 tools/mesh/mesh-db.h |   5 ++
 3 files changed, 151 insertions(+), 28 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index b30edca19..b5f39df18 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -594,6 +594,8 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		bt_shell_printf("Node %4.4x: Config Beacon Status 0x%02x\n",
 				src, data[0]);
+
+		saved = mesh_db_node_set_beacon(src, data[0] != 0);
 		break;
 
 	case OP_CONFIG_RELAY_STATUS:
@@ -602,6 +604,10 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		bt_shell_printf("Node %4.4x: Relay 0x%02x, cnt %d, steps %d\n",
 				src, data[0], data[1] & 0x7, data[1] >> 3);
+
+		saved = mesh_db_node_set_relay(src, data[0], data[1] & 7,
+						((data[1] >> 3) + 1) * 10);
+
 		break;
 
 	case OP_CONFIG_PROXY_STATUS:
@@ -610,6 +616,8 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		bt_shell_printf("Node %4.4x Proxy state 0x%02x\n",
 				src, data[0]);
+
+		saved = mesh_db_node_set_proxy(src, data[0]);
 		break;
 
 	case OP_CONFIG_DEFAULT_TTL_STATUS:
@@ -618,7 +626,6 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		bt_shell_printf("Node %4.4x Default TTL %d\n", src, data[0]);
 		saved = mesh_db_node_set_ttl(src, data[0]);
-
 		break;
 
 	case OP_CONFIG_MODEL_PUB_STATUS:
@@ -838,6 +845,9 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		bt_shell_printf("Node %4.4x: Net transmit cnt %d, steps %d\n",
 				src, data[0] & 7, data[0] >> 3);
+
+		saved = mesh_db_node_set_net_transmit(src, data[0] & 7,
+						((data[0] >> 3) + 1) * 10);
 		break;
 
 	/* Per Mesh Profile 4.3.2.54 */
@@ -855,6 +865,8 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		bt_shell_printf("Node %4.4x Friend state 0x%02x\n",
 				src, data[0]);
+
+		saved = mesh_db_node_set_friend(src, data[0]);
 		break;
 	}
 
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 46efb81ea..3290c5b8e 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -137,12 +137,12 @@ static void release_config(void)
 	cfg = NULL;
 }
 
-static json_object *get_node_by_unicast(uint16_t unicast)
+static json_object *get_node_by_unicast(json_object *jcfg, uint16_t unicast)
 {
 	json_object *jarray;
 	int i, sz;
 
-	if (!json_object_object_get_ex(cfg->jcfg, "nodes", &jarray))
+	if (!json_object_object_get_ex(jcfg, "nodes", &jarray))
 		return NULL;
 
 	if (!jarray || json_object_get_type(jarray) != json_type_array)
@@ -655,7 +655,7 @@ bool mesh_db_node_set_ttl(uint16_t unicast, uint8_t ttl)
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	jnode = get_node_by_unicast(unicast);
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
 	if (!jnode)
 		return false;
 
@@ -665,12 +665,135 @@ bool mesh_db_node_set_ttl(uint16_t unicast, uint8_t ttl)
 	return save_config();
 }
 
+static bool add_transmit_info(json_object *jobj, int cnt, int interval,
+							const char *desc)
+{
+	json_object *jtxmt;
+
+	json_object_object_del(jobj, desc);
+	jtxmt = json_object_new_object();
+
+	if (!write_int(jtxmt, "count", cnt))
+		goto fail;
+
+	if (!write_int(jtxmt, "interval", interval))
+		goto fail;
+
+	json_object_object_add(jobj, desc, jtxmt);
+	return true;
+
+fail:
+	json_object_put(jtxmt);
+	return false;
+}
+
+bool mesh_db_node_set_net_transmit(uint16_t unicast, uint8_t cnt,
+							uint16_t interval)
+{
+	json_object *jnode;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
+	if (!jnode)
+		return false;
+
+	if (!add_transmit_info(jnode, cnt, interval, "networkTransmit"))
+		return false;
+
+	return save_config();
+}
+
+static bool set_feature(json_object *jnode, const char *desc, uint8_t feature)
+{
+	json_object *jobj;
+
+	if (feature > MESH_MODE_UNSUPPORTED)
+		return false;
+
+	jobj = json_object_object_get(jnode, "features");
+	if (!jobj) {
+		jobj = json_object_new_object();
+		json_object_object_add(jnode, "features", jobj);
+	}
+
+	if (!write_int(jobj, desc, feature))
+		return false;
+
+	return save_config();
+}
+
+bool mesh_db_node_set_relay(uint16_t unicast, uint8_t relay, uint8_t cnt,
+							uint16_t interval)
+{
+	json_object *jnode;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
+	if (!jnode)
+		return false;
+
+	if (relay < MESH_MODE_UNSUPPORTED &&
+		!add_transmit_info(jnode, cnt, interval, "relayRetransmit"))
+		return false;
+
+	return set_feature(jnode, "relay", relay);
+}
+
+bool mesh_db_node_set_proxy(uint16_t unicast, uint8_t proxy)
+{
+	json_object *jnode;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
+	if (!jnode)
+		return false;
+
+	return set_feature(jnode, "proxy", proxy);
+}
+
+bool mesh_db_node_set_friend(uint16_t unicast, uint8_t friend)
+{
+	json_object *jnode;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
+	if (!jnode)
+		return false;
+
+	return set_feature(jnode, "friend", friend);
+}
+
+bool mesh_db_node_set_beacon(uint16_t unicast, bool enabled)
+{
+	json_object *jnode;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
+	if (!jnode)
+		return false;
+
+	if (!write_bool(jnode, "secureNetworkBeacon", enabled))
+		return false;
+
+	return save_config();
+}
+
 static json_object *get_element(uint16_t unicast, uint16_t ele_addr)
 {
 	json_object *jnode, *jarray;
 	int i, ele_cnt;
 
-	jnode = get_node_by_unicast(unicast);
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
 	if (!jnode)
 		return false;
 
@@ -993,23 +1116,6 @@ bool mesh_db_node_model_overwrt_sub_virt(uint16_t unicast, uint16_t ele,
 	return sub_overwrite(unicast, ele, vendor, mod_id, buf);
 }
 
-static bool add_transmit_info(json_object *jobj, int cnt, int interval,
-							const char *desc)
-{
-	json_object *jtxmt;
-
-	jtxmt = json_object_new_object();
-
-	if (!write_int(jtxmt, "count", cnt))
-		return false;
-
-	if (!write_int(jtxmt, "interval", interval))
-		return false;
-
-	json_object_object_add(jobj, desc, jtxmt);
-	return true;
-}
-
 bool mesh_db_node_model_set_pub(uint16_t unicast, uint16_t ele_addr,
 					bool vendor, uint32_t mod_id,
 					struct model_pub *pub, bool virt)
@@ -1113,7 +1219,7 @@ bool mesh_db_node_add_net_key(uint16_t unicast, uint16_t idx)
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	jnode = get_node_by_unicast(unicast);
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
 	if (!jnode)
 		return false;
 
@@ -1127,7 +1233,7 @@ bool mesh_db_node_del_net_key(uint16_t unicast, uint16_t net_idx)
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	jnode = get_node_by_unicast(unicast);
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
 	if (!jnode)
 		return false;
 
@@ -1143,7 +1249,7 @@ static bool key_update(uint16_t unicast, int16_t idx, bool updated,
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	jnode = get_node_by_unicast(unicast);
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
 	if (!jnode)
 		return false;
 
@@ -1180,7 +1286,7 @@ bool mesh_db_node_add_app_key(uint16_t unicast, uint16_t idx)
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	jnode = get_node_by_unicast(unicast);
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
 	if (!jnode)
 		return false;
 
@@ -1194,7 +1300,7 @@ bool mesh_db_node_del_app_key(uint16_t unicast, uint16_t idx)
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	jnode = get_node_by_unicast(unicast);
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
 	if (!jnode)
 		return false;
 
@@ -1635,7 +1741,7 @@ bool mesh_db_node_set_composition(uint16_t unicast, uint8_t *data, uint16_t len)
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	jnode = get_node_by_unicast(unicast);
+	jnode = get_node_by_unicast(cfg->jcfg, unicast);
 	if (!jnode)
 		return false;
 
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index 147fbf98c..b3b0bce79 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -37,6 +37,11 @@ bool mesh_db_add_provisioner(const char *name, uint8_t uuid[16],
 				uint16_t group_low, uint16_t group_high);
 bool mesh_db_node_set_net_transmit(uint16_t unicast, uint8_t cnt,
 							uint16_t interval);
+bool mesh_db_node_set_relay(uint16_t unicast, uint8_t relay, uint8_t cnt,
+							uint16_t interval);
+bool mesh_db_node_set_proxy(uint16_t unicast, uint8_t proxy);
+bool mesh_db_node_set_friend(uint16_t unicast, uint8_t friend);
+bool mesh_db_node_set_beacon(uint16_t unicast, bool enabled);
 bool mesh_db_node_add_net_key(uint16_t unicast, uint16_t idx);
 bool mesh_db_node_del_net_key(uint16_t unicast, uint16_t idx);
 bool mesh_db_node_update_net_key(uint16_t unicast, uint16_t idx, bool updated);
-- 
2.31.1


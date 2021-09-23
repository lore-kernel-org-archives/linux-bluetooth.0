Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCE1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D1961038
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbhIWD2v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:16381 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239046AbhIWD2o (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555922"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555922"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072376"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:58 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 12/20] tools/mesh-cfgclient: Rename mesh-db APIs for consistency
Date:   Wed, 22 Sep 2021 20:25:55 -0700
Message-Id: <20210923032603.50536-13-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/mesh-cfgclient.c | 12 ++++++------
 tools/mesh/cfgcli.c    |  2 +-
 tools/mesh/keys.c      |  4 ++--
 tools/mesh/mesh-db.c   | 24 ++++++++++++------------
 tools/mesh/mesh-db.h   | 26 +++++++++++++-------------
 tools/mesh/remote.c    | 16 ++++++++--------
 6 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 62dcecb2f..beeb115dc 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -1041,15 +1041,15 @@ static void mgr_key_reply(struct l_dbus_proxy *proxy,
 
 	if (!strcmp("CreateSubnet", method)) {
 		keys_add_net_key(idx);
-		mesh_db_net_key_add(idx);
+		mesh_db_add_net_key(idx);
 	} else if (!strcmp("DeleteSubnet", method)) {
 		keys_del_net_key(idx);
-		mesh_db_net_key_del(idx);
+		mesh_db_del_net_key(idx);
 	} else if (!strcmp("UpdateSubnet", method)) {
 		keys_set_net_key_phase(idx, KEY_REFRESH_PHASE_ONE, true);
 	} else if (!strcmp("DeleteAppKey", method)) {
 		keys_del_app_key(idx);
-		mesh_db_app_key_del(idx);
+		mesh_db_del_app_key(idx);
 	}
 }
 
@@ -1133,13 +1133,13 @@ static void add_key_reply(struct l_dbus_proxy *proxy,
 
 	if (!strcmp(method, "ImportSubnet")) {
 		keys_add_net_key(net_idx);
-		mesh_db_net_key_add(net_idx);
+		mesh_db_add_net_key(net_idx);
 		return;
 	}
 
 	app_idx = (uint16_t) req->arg2;
 	keys_add_app_key(net_idx, app_idx);
-	mesh_db_app_key_add(net_idx, app_idx);
+	mesh_db_add_app_key(net_idx, app_idx);
 }
 
 static void import_appkey_setup(struct l_dbus_message *msg, void *user_data)
@@ -1824,7 +1824,7 @@ static struct l_dbus_message *join_complete(struct l_dbus *dbus,
 	}
 
 	keys_add_net_key(PRIMARY_NET_IDX);
-	mesh_db_net_key_add(PRIMARY_NET_IDX);
+	mesh_db_add_net_key(PRIMARY_NET_IDX);
 
 	remote_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
 	mesh_db_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 9399228c8..b30edca19 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -617,7 +617,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 			return true;
 
 		bt_shell_printf("Node %4.4x Default TTL %d\n", src, data[0]);
-		saved = mesh_db_node_ttl_set(src, data[0]);
+		saved = mesh_db_node_set_ttl(src, data[0]);
 
 		break;
 
diff --git a/tools/mesh/keys.c b/tools/mesh/keys.c
index c08348bff..134c1a10e 100644
--- a/tools/mesh/keys.c
+++ b/tools/mesh/keys.c
@@ -54,7 +54,7 @@ static void delete_bound_appkey(void *a)
 {
 	uint32_t idx = L_PTR_TO_UINT(a);
 
-	mesh_db_app_key_del(idx);
+	mesh_db_del_app_key(idx);
 }
 
 void keys_add_net_key(uint16_t net_idx)
@@ -102,7 +102,7 @@ void keys_set_net_key_phase(uint16_t net_idx, uint8_t phase, bool save)
 
 	key->phase = phase;
 
-	if (save && !mesh_db_net_key_phase_set(net_idx, phase))
+	if (save && !mesh_db_set_net_key_phase(net_idx, phase))
 		bt_shell_printf("Failed to save updated KR phase\n");
 }
 
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index f63edd5ae..46efb81ea 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -648,7 +648,7 @@ fail:
 	return false;
 }
 
-bool mesh_db_node_ttl_set(uint16_t unicast, uint8_t ttl)
+bool mesh_db_node_set_ttl(uint16_t unicast, uint8_t ttl)
 {
 	json_object *jnode;
 
@@ -1106,7 +1106,7 @@ static bool delete_key(json_object *jobj, const char *desc, uint16_t idx)
 	return save_config();
 }
 
-bool mesh_db_node_net_key_add(uint16_t unicast, uint16_t idx)
+bool mesh_db_node_add_net_key(uint16_t unicast, uint16_t idx)
 {
 	json_object *jnode;
 
@@ -1120,7 +1120,7 @@ bool mesh_db_node_net_key_add(uint16_t unicast, uint16_t idx)
 	return add_node_key(jnode, "netKeys", idx);
 }
 
-bool mesh_db_node_net_key_del(uint16_t unicast, uint16_t net_idx)
+bool mesh_db_node_del_net_key(uint16_t unicast, uint16_t net_idx)
 {
 	json_object *jnode;
 
@@ -1168,12 +1168,12 @@ static bool key_update(uint16_t unicast, int16_t idx, bool updated,
 	return false;
 }
 
-bool mesh_db_node_net_key_update(uint16_t unicast, uint16_t idx, bool updated)
+bool mesh_db_node_update_net_key(uint16_t unicast, uint16_t idx, bool updated)
 {
 	return key_update(unicast, idx, updated, "netKeys");
 }
 
-bool mesh_db_node_app_key_add(uint16_t unicast, uint16_t idx)
+bool mesh_db_node_add_app_key(uint16_t unicast, uint16_t idx)
 {
 	json_object *jnode;
 
@@ -1187,7 +1187,7 @@ bool mesh_db_node_app_key_add(uint16_t unicast, uint16_t idx)
 	return add_node_key(jnode, "appKeys", idx);
 }
 
-bool mesh_db_node_app_key_del(uint16_t unicast, uint16_t idx)
+bool mesh_db_node_del_app_key(uint16_t unicast, uint16_t idx)
 {
 	json_object *jnode;
 
@@ -1201,7 +1201,7 @@ bool mesh_db_node_app_key_del(uint16_t unicast, uint16_t idx)
 	return delete_key(jnode, "appKeys", idx);
 }
 
-bool mesh_db_node_app_key_update(uint16_t unicast, uint16_t idx, bool updated)
+bool mesh_db_node_update_app_key(uint16_t unicast, uint16_t idx, bool updated)
 {
 	return key_update(unicast, idx, updated, "appKeys");
 }
@@ -1260,7 +1260,7 @@ static bool load_keys(json_object *jobj)
 	return true;
 }
 
-bool mesh_db_net_key_add(uint16_t net_idx)
+bool mesh_db_add_net_key(uint16_t net_idx)
 {
 	json_object *jkey, *jarray;
 	char buf[12];
@@ -1303,7 +1303,7 @@ fail:
 	return false;
 }
 
-bool mesh_db_net_key_del(uint16_t net_idx)
+bool mesh_db_del_net_key(uint16_t net_idx)
 {
 	if (!cfg || !cfg->jcfg)
 		return false;
@@ -1311,7 +1311,7 @@ bool mesh_db_net_key_del(uint16_t net_idx)
 	return delete_key(cfg->jcfg, "netKeys", net_idx);
 }
 
-bool mesh_db_net_key_phase_set(uint16_t net_idx, uint8_t phase)
+bool mesh_db_set_net_key_phase(uint16_t net_idx, uint8_t phase)
 {
 	json_object *jval, *jarray, *jkey;
 
@@ -1335,7 +1335,7 @@ bool mesh_db_net_key_phase_set(uint16_t net_idx, uint8_t phase)
 	return save_config();
 }
 
-bool mesh_db_app_key_add(uint16_t net_idx, uint16_t app_idx)
+bool mesh_db_add_app_key(uint16_t net_idx, uint16_t app_idx)
 {
 	if (!cfg || !cfg->jcfg)
 		return false;
@@ -1346,7 +1346,7 @@ bool mesh_db_app_key_add(uint16_t net_idx, uint16_t app_idx)
 	return save_config();
 }
 
-bool mesh_db_app_key_del(uint16_t app_idx)
+bool mesh_db_del_app_key(uint16_t app_idx)
 {
 	if (!cfg || !cfg->jcfg)
 		return false;
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index 885dabe90..147fbf98c 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -20,13 +20,13 @@ bool mesh_db_load(const char *fname);
 bool mesh_db_get_token(uint8_t token[8]);
 bool mesh_db_set_iv_index(uint32_t ivi);
 uint32_t mesh_db_get_iv_index(void);
-bool mesh_db_net_key_add(uint16_t idx);
-bool mesh_db_net_key_del(uint16_t idx);
-bool mesh_db_net_key_phase_set(uint16_t net_idx, uint8_t phase);
-bool mesh_db_app_key_add(uint16_t net_idx, uint16_t app_idx);
-bool mesh_db_app_key_del(uint16_t app_idx);
-bool mesh_db_get_addr_range(uint16_t *low, uint16_t *high);
 
+bool mesh_db_add_net_key(uint16_t idx);
+bool mesh_db_del_net_key(uint16_t idx);
+bool mesh_db_set_net_key_phase(uint16_t net_idx, uint8_t phase);
+bool mesh_db_add_app_key(uint16_t net_idx, uint16_t app_idx);
+bool mesh_db_del_app_key(uint16_t app_idx);
+bool mesh_db_get_addr_range(uint16_t *low, uint16_t *high);
 bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 							uint16_t net_idx);
 bool mesh_db_del_node(uint16_t unicast);
@@ -37,13 +37,13 @@ bool mesh_db_add_provisioner(const char *name, uint8_t uuid[16],
 				uint16_t group_low, uint16_t group_high);
 bool mesh_db_node_set_net_transmit(uint16_t unicast, uint8_t cnt,
 							uint16_t interval);
-bool mesh_db_node_net_key_add(uint16_t unicast, uint16_t idx);
-bool mesh_db_node_net_key_del(uint16_t unicast, uint16_t idx);
-bool mesh_db_node_net_key_update(uint16_t unicast, uint16_t idx, bool updated);
-bool mesh_db_node_app_key_add(uint16_t unicast, uint16_t idx);
-bool mesh_db_node_app_key_del(uint16_t unicast, uint16_t idx);
-bool mesh_db_node_app_key_update(uint16_t unicast, uint16_t idx, bool updated);
-bool mesh_db_node_ttl_set(uint16_t unicast, uint8_t ttl);
+bool mesh_db_node_add_net_key(uint16_t unicast, uint16_t idx);
+bool mesh_db_node_del_net_key(uint16_t unicast, uint16_t idx);
+bool mesh_db_node_update_net_key(uint16_t unicast, uint16_t idx, bool updated);
+bool mesh_db_node_add_app_key(uint16_t unicast, uint16_t idx);
+bool mesh_db_node_del_app_key(uint16_t unicast, uint16_t idx);
+bool mesh_db_node_update_app_key(uint16_t unicast, uint16_t idx, bool updated);
+bool mesh_db_node_set_ttl(uint16_t unicast, uint8_t ttl);
 bool mesh_db_node_write_mode(uint16_t unicast, const char *keyword, int value);
 bool mesh_db_node_model_bind(uint16_t unicast, uint16_t ele_addr, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index dd294fe4d..054da5300 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -233,7 +233,7 @@ bool remote_add_net_key(uint16_t addr, uint16_t net_idx, bool save)
 	l_queue_push_tail(rmt->net_keys, key);
 
 	if (save)
-		return mesh_db_node_net_key_add(addr, net_idx);
+		return mesh_db_node_add_net_key(addr, net_idx);
 	else
 		return true;
 }
@@ -252,14 +252,14 @@ bool remote_del_net_key(uint16_t addr, uint16_t net_idx)
 	if (!key)
 		return false;
 
-	mesh_db_node_net_key_del(addr, net_idx);
+	mesh_db_node_del_net_key(addr, net_idx);
 
 	l_free(key);
 	key = l_queue_remove_if(rmt->app_keys, match_bound_key,
 						L_UINT_TO_PTR(net_idx));
 
 	while (key) {
-		mesh_db_node_app_key_del(rmt->unicast, key->idx);
+		mesh_db_node_del_app_key(rmt->unicast, key->idx);
 		l_free(key);
 
 		key = l_queue_remove_if(rmt->app_keys, match_bound_key,
@@ -284,7 +284,7 @@ bool remote_update_net_key(uint16_t addr, uint16_t net_idx, bool update,
 	key->updated = update;
 
 	if (save)
-		return mesh_db_node_net_key_update(addr, net_idx, update);
+		return mesh_db_node_update_net_key(addr, net_idx, update);
 	else
 		return true;
 }
@@ -310,7 +310,7 @@ bool remote_add_app_key(uint16_t addr, uint16_t app_idx, bool save)
 	l_queue_push_tail(rmt->app_keys, key);
 
 	if (save)
-		return mesh_db_node_app_key_add(addr, app_idx);
+		return mesh_db_node_add_app_key(addr, app_idx);
 	else
 		return true;
 }
@@ -328,7 +328,7 @@ bool remote_del_app_key(uint16_t addr, uint16_t app_idx)
 						L_UINT_TO_PTR(app_idx));
 	l_free(key);
 
-	return mesh_db_node_app_key_del(addr, app_idx);
+	return mesh_db_node_del_app_key(addr, app_idx);
 }
 
 bool remote_update_app_key(uint16_t addr, uint16_t app_idx, bool update,
@@ -346,7 +346,7 @@ bool remote_update_app_key(uint16_t addr, uint16_t app_idx, bool update,
 	key->updated = update;
 
 	if (save)
-		return mesh_db_node_app_key_update(addr, app_idx, update);
+		return mesh_db_node_update_app_key(addr, app_idx, update);
 	else
 		return true;
 }
@@ -375,7 +375,7 @@ bool remote_finish_key_refresh(uint16_t addr, uint16_t net_idx)
 
 		key->updated = false;
 
-		res &= mesh_db_node_app_key_update(addr, key->idx, false);
+		res &= mesh_db_node_update_app_key(addr, key->idx, false);
 	}
 
 	return res;
-- 
2.31.1


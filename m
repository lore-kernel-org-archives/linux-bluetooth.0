Return-Path: <SRS0=Tmyd=5O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6C7C2D0EB
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Mar 2020 20:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC8B2074A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Mar 2020 20:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgC2U4S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:56:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:20803 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgC2U4S (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Mar 2020 16:56:18 -0400
IronPort-SDR: iwqgAhfL0E4A4pVInbZUtBr8ZJZxi0hJRy//Iq3/DAYvhIwCK78KT0VgeO9OFBJM9jN+yDeQdY
 MElYZL/ol8fA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 13:56:16 -0700
IronPort-SDR: IP614L/0zDUrxy03oEf14y2K6FCdq2sQ4WF8hGCx1XATfs8wUmMNFiVhAM7w55QZR+XWUqcftm
 TelJsyI6siuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,321,1580803200"; 
   d="scan'208";a="294412308"
Received: from ingas-nuc1.sea.intel.com ([10.252.139.119])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2020 13:56:16 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2] tools/mesh-cfgclient: Save subnet key refresh phase
Date:   Sun, 29 Mar 2020 13:56:14 -0700
Message-Id: <20200329205615.22090-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This records Key Refresh phase of a subnet either as a consequence
of successful execution of subnet-update or subnet-set-phase commands.
---
 tools/mesh-cfgclient.c | 16 ++++++++++-
 tools/mesh/keys.c      | 24 ++++++++++++++--
 tools/mesh/keys.h      |  1 +
 tools/mesh/mesh-db.c   | 64 +++++++++++++++++++++++++++++++++---------
 tools/mesh/mesh-db.h   |  1 +
 5 files changed, 90 insertions(+), 16 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index d1c673182..a1dbf3fa7 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -950,14 +950,25 @@ fail:
 static void subnet_set_phase_reply(struct l_dbus_proxy *proxy,
 				struct l_dbus_message *msg, void *user_data)
 {
+	struct generic_request *req = user_data;
+	uint16_t net_idx;
+	uint8_t phase;
+
 	if (l_dbus_message_is_error(msg)) {
 		const char *name;
 
 		l_dbus_message_get_error(msg, &name, NULL);
 		l_error("Failed to set subnet phase: %s", name);
+		return;
 	}
 
-	/* TODO: Set key phase in configuration */
+	net_idx = (uint16_t) req->arg1;
+	phase = (uint8_t) req->arg2;
+
+	if (phase == KEY_REFRESH_PHASE_THREE)
+		phase = KEY_REFRESH_PHASE_NONE;
+
+	keys_set_net_key_phase(net_idx, phase);
 }
 
 static void subnet_set_phase_setup(struct l_dbus_message *msg, void *user_data)
@@ -1016,6 +1027,7 @@ static void mgr_key_reply(struct l_dbus_proxy *proxy,
 
 		l_dbus_message_get_error(msg, &name, NULL);
 		l_error("Method %s returned error: %s", method, name);
+		bt_shell_printf("Method %s returned error: %s\n", method, name);
 		return;
 	}
 
@@ -1025,6 +1037,8 @@ static void mgr_key_reply(struct l_dbus_proxy *proxy,
 	} else if (!strcmp("DeleteSubnet", method)) {
 		keys_del_net_key(idx);
 		mesh_db_net_key_del(idx);
+	} else if (!strcmp("UpdateSubnet", method)) {
+		keys_set_net_key_phase(idx, KEY_REFRESH_PHASE_ONE);
 	} else if (!strcmp("DeleteAppKey", method)) {
 		keys_del_app_key(idx);
 		mesh_db_app_key_del(idx);
diff --git a/tools/mesh/keys.c b/tools/mesh/keys.c
index 77b32da63..e7b065beb 100644
--- a/tools/mesh/keys.c
+++ b/tools/mesh/keys.c
@@ -31,8 +31,9 @@
 #include "tools/mesh/keys.h"
 
 struct net_key {
-	uint16_t idx;
 	struct l_queue *app_keys;
+	uint16_t idx;
+	uint8_t phase;
 };
 
 static struct l_queue *net_keys;
@@ -78,6 +79,7 @@ void keys_add_net_key(uint16_t net_idx)
 
 	key = l_new(struct net_key, 1);
 	key->idx = net_idx;
+	key->phase = KEY_REFRESH_PHASE_NONE;
 
 	l_queue_push_tail(net_keys, key);
 }
@@ -97,6 +99,23 @@ void keys_del_net_key(uint16_t idx)
 	l_free(key);
 }
 
+void keys_set_net_key_phase(uint16_t net_idx, uint8_t phase)
+{
+	struct net_key *key;
+
+	if (!net_keys)
+		return;
+
+	key = l_queue_find(net_keys, net_idx_match, L_UINT_TO_PTR(net_idx));
+	if (!key)
+		return;
+
+	key->phase = phase;
+
+	if (!mesh_db_net_key_phase_set(net_idx, phase))
+		bt_shell_printf("Failed to save updated KR phase\n");
+}
+
 void keys_add_app_key(uint16_t net_idx, uint16_t app_idx)
 {
 	struct net_key *key;
@@ -166,7 +185,8 @@ static void print_netkey(void *net_key, void *user_data)
 {
 	struct net_key *key = net_key;
 
-	bt_shell_printf(COLOR_YELLOW "NetKey: 0x%3.3x\n" COLOR_OFF, key->idx);
+	bt_shell_printf(COLOR_YELLOW "NetKey: 0x%3.3x, phase: %u\n" COLOR_OFF,
+							key->idx, key->phase);
 
 	if (!key->app_keys || l_queue_isempty(key->app_keys))
 		return;
diff --git a/tools/mesh/keys.h b/tools/mesh/keys.h
index 71c3bb390..e05e57997 100644
--- a/tools/mesh/keys.h
+++ b/tools/mesh/keys.h
@@ -20,6 +20,7 @@
 
 void keys_add_net_key(uint16_t net_idx);
 void keys_del_net_key(uint16_t net_idx);
+void keys_set_net_key_phase(uint16_t net_idx, uint8_t phase);
 void keys_add_app_key(uint16_t net_idx, uint16_t app_idx);
 void keys_del_app_key(uint16_t app_idx);
 uint16_t keys_get_bound_key(uint16_t app_idx);
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index e938ee733..05e96e554 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -114,6 +114,20 @@ static json_object *get_key_object(json_object *jarray, uint16_t idx)
 	return NULL;
 }
 
+static bool get_int(json_object *jobj, const char *keyword, int *value)
+{
+	json_object *jvalue;
+
+	if (!json_object_object_get_ex(jobj, keyword, &jvalue))
+		return false;
+
+	*value = json_object_get_int(jvalue);
+	if (errno == EINVAL)
+		return false;
+
+	return true;
+}
+
 static bool write_int(json_object *jobj, const char *keyword, int val)
 {
 	json_object *jval;
@@ -416,8 +430,7 @@ static bool add_node_key(json_object *jobj, const char *desc, uint16_t idx)
 	json_object_object_add(jkey, "index", jval);
 	json_object_array_add(jarray, jkey);
 
-	return mesh_config_save((struct mesh_config *) cfg, true,
-								NULL, NULL);
+	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
 }
 
 bool mesh_db_node_net_key_add(uint16_t unicast, uint16_t idx)
@@ -448,8 +461,7 @@ bool mesh_db_node_ttl_set(uint16_t unicast, uint8_t ttl)
 	if (!write_int(jnode, "defaultTTL", ttl))
 		return false;
 
-	return mesh_config_save((struct mesh_config *) cfg, true,
-								NULL, NULL);
+	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
 }
 
 static void jarray_key_del(json_object *jarray, int16_t idx)
@@ -488,8 +500,7 @@ static bool delete_key(json_object *jobj, const char *desc, uint16_t idx)
 
 	jarray_key_del(jarray, idx);
 
-	return mesh_config_save((struct mesh_config *) cfg, true,
-								NULL, NULL);
+	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
 }
 
 bool mesh_db_node_net_key_del(uint16_t unicast, uint16_t net_idx)
@@ -550,6 +561,7 @@ static bool load_keys(json_object *jobj)
 
 	for (i = 0; i < key_cnt; ++i) {
 		const char *str;
+		int phase;
 
 		jentry = json_object_array_get_idx(jarray, i);
 
@@ -562,6 +574,11 @@ static bool load_keys(json_object *jobj)
 			return false;
 
 		keys_add_net_key(net_idx);
+
+		if (!get_int(jentry, "phase", &phase))
+			return false;
+
+		keys_set_net_key_phase(net_idx, (uint8_t) phase);
 	}
 
 	json_object_object_get_ex(jobj, "appKeys", &jarray);
@@ -623,15 +640,13 @@ bool mesh_db_net_key_add(uint16_t net_idx)
 
 	json_object_object_add(jkey, "index", jval);
 
-	jval = json_object_new_int(KEY_REFRESH_PHASE_NONE);
-	if (!jval)
+	if (!write_int(jkey, "phase", KEY_REFRESH_PHASE_NONE))
 		goto fail;
 
-	json_object_object_add(jkey, "phase", jval);
 	json_object_array_add(jarray, jkey);
 
-	return mesh_config_save((struct mesh_config *) cfg, true,
-								NULL, NULL);
+	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+
 fail:
 	json_object_put(jkey);
 	return false;
@@ -645,6 +660,30 @@ bool mesh_db_net_key_del(uint16_t net_idx)
 	return delete_key(cfg->jcfg, "netKeys", net_idx);
 }
 
+bool mesh_db_net_key_phase_set(uint16_t net_idx, uint8_t phase)
+{
+	json_object *jval, *jarray, *jkey;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	json_object_object_get_ex(cfg->jcfg, "netKeys", &jarray);
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	jkey = get_key_object(jarray, net_idx);
+	if (!jkey)
+		return false;
+
+	jval = json_object_new_int(phase);
+	if (!jval)
+		return false;
+
+	json_object_object_add(jkey, "phase", jval);
+
+	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+}
+
 bool mesh_db_app_key_add(uint16_t net_idx, uint16_t app_idx)
 {
 	if (!cfg || !cfg->jcfg)
@@ -653,8 +692,7 @@ bool mesh_db_app_key_add(uint16_t net_idx, uint16_t app_idx)
 	if (!add_app_key(cfg->jcfg, net_idx, app_idx))
 		return false;
 
-	return mesh_config_save((struct mesh_config *) cfg, true,
-								NULL, NULL);
+	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
 }
 
 bool mesh_db_app_key_del(uint16_t app_idx)
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index 80dc4ed53..1f9e4e3d3 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -29,6 +29,7 @@ bool mesh_db_get_token(uint8_t token[8]);
 
 bool mesh_db_net_key_add(uint16_t idx);
 bool mesh_db_net_key_del(uint16_t idx);
+bool mesh_db_net_key_phase_set(uint16_t net_idx, uint8_t phase);
 bool mesh_db_app_key_add(uint16_t net_idx, uint16_t app_idx);
 bool mesh_db_app_key_del(uint16_t app_idx);
 bool mesh_db_set_addr_range(uint16_t low, uint16_t high);
-- 
2.21.1


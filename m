Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823A5C004D4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 23:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjASX6d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjASX63 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Jan 2023 18:58:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEBFA1005
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d8so4032475pjc.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZywWneBzfnS1YhNnPrphi7pBqCuQFz4CPvLAU9MWVM=;
        b=jFzYhUWk9X6MsXmnT+3dgTeO0eyjvoVbMgA+Ia/iL676frpSyo4LDSuuvsC5qVvxIz
         MrJEoQQbpW3v9tK0Q8FARrRIp0RLAeIi6K8Zui1aRBlNAFlOfPl4k4ztJ3HTnVD4pFC9
         JAiHLNd4/ubLzVPcC8fo8moD3V5BRd/hYUfS2ezw7mulzBTb+1DpBIbZN83K2cVVfAOe
         qDw8Ra488eiDe0CeDBKc2RweyVvlrrVXoS/v75A3/6qRoJbR2t4VXBfqOkXQzD9CD4d4
         wBpDAxYV8vmLkZMf832OlSc2y6U0Gweys+pkZW0pf6uGGugR2nSJy266ADghOWdQE7ze
         7v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZywWneBzfnS1YhNnPrphi7pBqCuQFz4CPvLAU9MWVM=;
        b=R2ku859zaTORZYXn9z907a5WXGJu8ti+pp2Ov3mhFXjhMsecBeHAWVxY+EJq8K9YKB
         PqG3mbNtilcY5t9Zbv7iarsMV7f045qIBPnRVhGi3LFLz1mWwrH9yNa9x2epZUKGEwvc
         RpKY/3ifHvLTdUtz6LCeT6s5Bk3JlPP1npTU1wb3P5adEWaDMjHhmz+5XC5wor0xXuuu
         GutuO/S62HlZveH9a73XLPogfWJ9HC4pqAxfJN7loc15K95k3LSdX80Yp/dFTffe/mCP
         gZZPsQmTW0CPnol/asfQIMNrFKzQfjFEqUPQUxjkGjRdbUkHTwTQQ0Cdp5W56PLxvELQ
         78vA==
X-Gm-Message-State: AFqh2kopQcu0RXS4EdG7wFoYowM/TffVLZRzQPpXkp+OXUwWKlgAJGnt
        wv4WOeF6ZeNleOdrfjSI/QA1WwQYP2fdKg==
X-Google-Smtp-Source: AMrXdXvEh9i3/zc+MRzr9c5X7JDoTdwPlbiAbbe+wUvstV1wYEASon8Flb3/X/bjXx64/VcuGLgAVg==
X-Received: by 2002:a17:902:e194:b0:18f:98bb:c08e with SMTP id y20-20020a170902e19400b0018f98bbc08emr11656708pla.36.1674172693448;
        Thu, 19 Jan 2023 15:58:13 -0800 (PST)
Received: from fedora.. (97-113-173-242.tukw.qwest.net. [97.113.173.242])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b0019460c34839sm14826373plc.185.2023.01.19.15.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:13 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 10/12] mesh: Plumb in Mesh Private Beacon model
Date:   Thu, 19 Jan 2023 15:57:53 -0800
Message-Id: <20230119235755.46002-11-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235755.46002-1-brian.gix@gmail.com>
References: <20230119235755.46002-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

This allows nodes with this nodes Device Key to make changes to the
behavior of this node's Mesh Private Beaconing.
---
 mesh/net-keys.c       |  5 ++++
 mesh/net-keys.h       |  1 +
 mesh/node.c           | 67 +++++++++++++++++++++++++++++++++++++++----
 mesh/node.h           |  2 ++
 mesh/prvbeac-server.c | 11 +++++--
 5 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 429ca1f46..c7becb422 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -123,6 +123,7 @@ uint32_t net_key_add(const uint8_t flooding[16])
 	key = l_new(struct net_key, 1);
 	memcpy(key->flooding, flooding, 16);
 	key->ref_cnt++;
+	key->mpb_refresh = NET_MPB_REFRESH_DEFAULT;
 	result = mesh_crypto_k2(flooding, p, sizeof(p), &key->nid, key->enc_key,
 								key->prv_key);
 	if (!result)
@@ -664,6 +665,10 @@ bool net_key_beacon_refresh(uint32_t id, uint32_t ivi, bool kr, bool ivu,
 
 	l_debug("Set Beacon: IVI: %8.8x, IVU: %d, KR: %d", ivi, ivu, kr);
 
+	key->ivi = ivi;
+	key->ivu = ivu;
+	key->kr = kr;
+
 	/* Propagate changes to all local nodes */
 	net_local_beacon(id, ivi, ivu, kr);
 
diff --git a/mesh/net-keys.h b/mesh/net-keys.h
index a3909448c..e73812481 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -12,6 +12,7 @@
 #define BEACON_TYPE_MPB		0x02
 #define KEY_REFRESH		0x01
 #define IV_INDEX_UPDATE		0x02
+#define NET_MPB_REFRESH_DEFAULT	60
 
 void net_key_cleanup(void);
 bool net_key_confirm(uint32_t id, const uint8_t flooding[16]);
diff --git a/mesh/node.c b/mesh/node.c
index a2a330518..ed3212685 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -32,6 +32,7 @@
 #include "mesh/model.h"
 #include "mesh/cfgmod.h"
 #include "mesh/remprv.h"
+#include "mesh/prv-beacon.h"
 #include "mesh/util.h"
 #include "mesh/error.h"
 #include "mesh/dbus.h"
@@ -100,6 +101,8 @@ struct mesh_node {
 	uint8_t proxy;
 	uint8_t friend;
 	uint8_t beacon;
+	uint8_t mpb;
+	uint8_t mpb_period;
 };
 
 struct node_import {
@@ -206,6 +209,8 @@ static void set_defaults(struct mesh_node *node)
 {
 	node->lpn = MESH_MODE_UNSUPPORTED;
 	node->proxy = MESH_MODE_UNSUPPORTED;
+	node->mpb = MESH_MODE_DISABLED;
+	node->mpb_period = NET_MPB_REFRESH_DEFAULT;
 	node->friend = (mesh_friendship_supported()) ? MESH_MODE_DISABLED :
 							MESH_MODE_UNSUPPORTED;
 	node->beacon = (mesh_beacon_enabled()) ? MESH_MODE_ENABLED :
@@ -403,7 +408,7 @@ static bool init_storage_dir(struct mesh_node *node)
 	return rpl_init(node->storage_dir);
 }
 
-static void update_net_settings(struct mesh_node *node)
+static void init_net_settings(struct mesh_node *node)
 {
 	struct mesh_net *net = node->net;
 
@@ -415,6 +420,8 @@ static void update_net_settings(struct mesh_node *node)
 					node->relay.cnt, node->relay.interval);
 
 	mesh_net_set_snb_mode(net, node->beacon == MESH_MODE_ENABLED);
+	mesh_net_set_mpb_mode(net, node->mpb == MESH_MODE_ENABLED,
+							node->mpb_period, true);
 }
 
 static bool init_from_storage(struct mesh_config_node *db_node,
@@ -442,6 +449,8 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 	node->relay.cnt = db_node->modes.relay.cnt;
 	node->relay.interval = db_node->modes.relay.interval;
 	node->beacon = db_node->modes.beacon;
+	node->mpb = db_node->modes.mpb;
+	node->mpb_period = db_node->modes.mpb_period;
 
 	l_debug("relay %2.2x, proxy %2.2x, lpn %2.2x, friend %2.2x",
 			node->relay.mode, node->proxy, node->lpn, node->friend);
@@ -495,7 +504,7 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 	mesh_net_set_seq_num(node->net, node->seq_number);
 	mesh_net_set_default_ttl(node->net, node->ttl);
 
-	update_net_settings(node);
+	init_net_settings(node);
 
 	/* Initialize configuration server model */
 	cfgmod_server_init(node, PRIMARY_ELE_IDX);
@@ -504,6 +513,9 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 	remote_prov_server_init(node, PRIMARY_ELE_IDX);
 	remote_prov_client_init(node, PRIMARY_ELE_IDX);
 
+	/* Initialize Private Beacon server model */
+	prv_beacon_server_init(node, PRIMARY_ELE_IDX);
+
 	node->cfg = cfg;
 
 	return true;
@@ -839,6 +851,36 @@ uint8_t node_beacon_mode_get(struct mesh_node *node)
 	return node->beacon;
 }
 
+bool node_mpb_mode_set(struct mesh_node *node, bool enable, uint8_t period)
+{
+	bool res;
+	uint8_t beacon;
+
+	if (!node)
+		return false;
+
+	beacon = enable ? MESH_MODE_ENABLED : MESH_MODE_DISABLED;
+	res = mesh_config_write_mpb(node->cfg, beacon, period);
+
+	if (res) {
+		node->mpb = beacon;
+		node->mpb_period = period;
+		mesh_net_set_mpb_mode(node->net, enable, period, false);
+	}
+
+	return res;
+}
+
+uint8_t node_mpb_mode_get(struct mesh_node *node, uint8_t *period)
+{
+	if (!node)
+		return MESH_MODE_DISABLED;
+
+	*period = node->mpb_period;
+
+	return node->mpb;
+}
+
 bool node_friend_mode_set(struct mesh_node *node, bool enable)
 {
 	bool res;
@@ -951,6 +993,8 @@ static void convert_node_to_storage(struct mesh_node *node,
 	db_node->modes.relay.cnt = node->relay.cnt;
 	db_node->modes.relay.interval = node->relay.interval;
 	db_node->modes.beacon = node->beacon;
+	db_node->modes.mpb = node->mpb;
+	db_node->modes.mpb_period = node->mpb_period;
 
 	db_node->ttl = node->ttl;
 	db_node->seq_number = node->seq_number;
@@ -1173,9 +1217,16 @@ static bool get_sig_models_from_properties(struct mesh_node *node,
 	while (l_dbus_message_iter_next_entry(&mods, &m_id, &var)) {
 		uint32_t id = SET_ID(SIG_VENDOR, m_id);
 
-		/* Allow Config Server Model only on the primary element */
-		if (ele->idx != PRIMARY_ELE_IDX && id == CONFIG_SRV_MODEL)
-			return false;
+		/*
+		 * Allow Config Server & Private Beacon Models only on
+		 * the primary element
+		 */
+		if (ele->idx != PRIMARY_ELE_IDX) {
+			if (id == CONFIG_SRV_MODEL)
+				return false;
+			if (id == PRV_BEACON_SRV_MODEL)
+				return false;
+		}
 
 		if (!mesh_model_add(node, ele->models, id, &var))
 			return false;
@@ -1278,6 +1329,7 @@ static bool get_element_properties(struct mesh_node *node, const char *path,
 	 */
 	if (ele->idx == PRIMARY_ELE_IDX) {
 		mesh_model_add(node, ele->models, CONFIG_SRV_MODEL, NULL);
+		mesh_model_add(node, ele->models, PRV_BEACON_SRV_MODEL, NULL);
 		mesh_model_add(node, ele->models, REM_PROV_SRV_MODEL, NULL);
 		if (node->provisioner)
 			mesh_model_add(node, ele->models, REM_PROV_CLI_MODEL,
@@ -1397,13 +1449,16 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 
 	l_queue_foreach(node->pages, save_pages, node);
 
-	update_net_settings(node);
+	init_net_settings(node);
 
 	/* Initialize internal server models */
 	cfgmod_server_init(node, PRIMARY_ELE_IDX);
 	remote_prov_server_init(node, PRIMARY_ELE_IDX);
 	remote_prov_client_init(node, PRIMARY_ELE_IDX);
 
+	/* Initialize Private Beacon server model */
+	prv_beacon_server_init(node, PRIMARY_ELE_IDX);
+
 	node->busy = true;
 
 	return true;
diff --git a/mesh/node.h b/mesh/node.h
index a98945223..4f31c5056 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -63,6 +63,8 @@ uint8_t node_relay_mode_get(struct mesh_node *node, uint8_t *cnt,
 bool node_proxy_mode_set(struct mesh_node *node, bool enable);
 uint8_t node_proxy_mode_get(struct mesh_node *node);
 bool node_beacon_mode_set(struct mesh_node *node, bool enable);
+bool node_mpb_mode_set(struct mesh_node *node, bool enable, uint8_t period);
+uint8_t node_mpb_mode_get(struct mesh_node *node, uint8_t *period);
 uint8_t node_beacon_mode_get(struct mesh_node *node);
 bool node_friend_mode_set(struct mesh_node *node, bool enable);
 uint8_t node_friend_mode_get(struct mesh_node *node);
diff --git a/mesh/prvbeac-server.c b/mesh/prvbeac-server.c
index 4d33f2823..d4475fb09 100644
--- a/mesh/prvbeac-server.c
+++ b/mesh/prvbeac-server.c
@@ -43,7 +43,7 @@ static bool prvbec_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 	uint32_t opcode;
 	uint8_t msg[5];
 	uint16_t n;
-	uint8_t period = 0;
+	uint8_t period;
 
 	if (app_idx != APP_IDX_DEV_LOCAL)
 		return false;
@@ -65,18 +65,23 @@ static bool prvbec_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 
 	case OP_PRIVATE_BEACON_SET:
 		if (size == 1)
-			period = 0xff;
+			node_mpb_mode_get(node, &period);
 		else if (size == 2)
 			period = pkt[1];
 		else
 			return true;
 
+		if (pkt[0] > 1)
+			return true;
+
+		node_mpb_mode_set(node, !!pkt[0], period);
+
 		/* Fall Through */
 
 	case OP_PRIVATE_BEACON_GET:
 		n = mesh_model_opcode_set(OP_PRIVATE_BEACON_STATUS, msg);
 
-		msg[n++] = NOT_SUPPORTED;
+		msg[n++] = node_mpb_mode_get(node, &period);
 		msg[n++] = period;
 
 		l_debug("Get/Set Private Beacon (%d)", msg[n-2]);
-- 
2.39.0


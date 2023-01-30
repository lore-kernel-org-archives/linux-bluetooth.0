Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05962C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 23:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjA3Xwc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjA3Xw2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 18:52:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8641C2F7AE
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:25 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cl23-20020a17090af69700b0022c745bfdc3so6150551pjb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHc1WD7oRJPg7EeaWXDZ/l7T1fOswZZvE3tAmq4YIi8=;
        b=nmCYBGlz4vVjg+AVmi4Ozcmva9inkl6ymH5i09sX2mWBlMSk0M+osZc6L6tgYPyYGX
         olwLFe2T/GZt3C//aPnoAPBqNm1uIy//SctNXgI5FuKkW2ii/bCTc7Itfpp8rZ80s2Qn
         GnaXQnBuZes2EJLNAh+gv0eB26PtfX0kGT7t3tAtNlaDHrrVr/pwBW34si1M5JSdhVZc
         1zw9NHe4P0BIs1C4ArSP5bBHYY2Dmldt0MSdvJQ/MH0NjfkTVce1s8N8gRlBznCX3/t8
         qaSLtxJ7JGEQbszO57le7v5zwz2Lh1cb5LevuDyHqTmILW7IvSIozxCVkjl8cpuTfRo8
         pIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHc1WD7oRJPg7EeaWXDZ/l7T1fOswZZvE3tAmq4YIi8=;
        b=qc7jrGr+Ntumx+Bmklbcy681HJzyTA9ECP90692dUwmsgQKfOiSGFc6456YLY1hPvO
         +20q3n7aY9JU+Y+VarXfVi7hJTvDEDtcQDkxBGM7wtTJdTjCbM0ZF1mCpdgZUkqthNFq
         7c38ImD9gF5DGikO6w0Z3f8TdOwc7KBhN5QYoyPGT/SS6zxeD9uMESbaosM4x8JkD2Zf
         nHG9GUo3TLSIpsoPnr4BopQoNL8+Fj3DXQCLEmMWVXQNxK5yhLyo15MCbbxATUwvubWZ
         OVuNQ8Fk4kt1goo3k5xBnk/oKa+svsl9GC1tub/sNcZyNZ4wqLXcmplzxCVt15XOT3do
         8R5g==
X-Gm-Message-State: AO0yUKWsNYNLwJ5Jg+i+vQEKDuPzhtI9++Rik4MqgtkOd++fUd35OF38
        FzvGkTlM0kKe1FibRDYClopQZL9JT0WWvQ==
X-Google-Smtp-Source: AK7set+yzKXD+aIWdinl79zomfjSK26xaEqqHskur2BccAnsyxWawgQHtG1vwG1IJX/owAJwfNpk/g==
X-Received: by 2002:a05:6a20:8427:b0:bb:c422:809f with SMTP id c39-20020a056a20842700b000bbc422809fmr32921158pzd.4.1675122744989;
        Mon, 30 Jan 2023 15:52:24 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm2663948pgd.76.2023.01.30.15.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:52:24 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v5 09/14] mesh: Add internal Mesh Private Beacon model
Date:   Mon, 30 Jan 2023 15:52:05 -0800
Message-Id: <20230130235210.94385-10-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130235210.94385-1-brian.gix@gmail.com>
References: <20230130235210.94385-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

Adds recgnition that the Mesh Private Beacon model is internal
and foundational, without bindings.
---
 mesh/model.c          | 10 ++++++-
 mesh/net-keys.c       |  5 ++++
 mesh/net-keys.h       |  1 +
 mesh/node.c           | 67 +++++++++++++++++++++++++++++++++++++++----
 mesh/node.h           |  2 ++
 mesh/prvbeac-server.c | 11 +++++--
 6 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index e2babea10..4ccafa17e 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -26,6 +26,7 @@
 #include "mesh/cfgmod.h"
 #include "mesh/prov.h"
 #include "mesh/remprv.h"
+#include "mesh/prv-beacon.h"
 #include "mesh/error.h"
 #include "mesh/dbus.h"
 #include "mesh/util.h"
@@ -81,6 +82,9 @@ static bool is_internal(uint32_t id)
 	if (id == REM_PROV_SRV_MODEL || id == REM_PROV_CLI_MODEL)
 		return true;
 
+	if (id == PRV_BEACON_SRV_MODEL || id == PRV_BEACON_CLI_MODEL)
+		return true;
+
 	return false;
 }
 
@@ -647,6 +651,9 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (id == CONFIG_SRV_MODEL || id == CONFIG_CLI_MODEL)
 		return MESH_STATUS_INVALID_MODEL;
 
+	if (id == PRV_BEACON_SRV_MODEL || id == PRV_BEACON_CLI_MODEL)
+		return MESH_STATUS_INVALID_MODEL;
+
 	if (!appkey_have_key(node_get_net(node), app_idx))
 		return MESH_STATUS_INVALID_APPKEY;
 
@@ -1655,7 +1662,8 @@ static struct mesh_model *model_setup(struct mesh_net *net, uint8_t ele_idx,
 						SET_ID(SIG_VENDOR, db_mod->id));
 
 	/* Implicitly bind config server model to device key */
-	if (db_mod->id == CONFIG_SRV_MODEL) {
+	if (db_mod->id == CONFIG_SRV_MODEL ||
+					db_mod->id == PRV_BEACON_SRV_MODEL) {
 
 		if (ele_idx != PRIMARY_ELE_IDX) {
 			l_free(mod);
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 0ba051d79..57a9df04a 100644
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
index e712778f8..dd0e4cbf4 100644
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
 		/* fall through */
 
 	case OP_PRIVATE_BEACON_GET:
 		n = mesh_model_opcode_set(OP_PRIVATE_BEACON_STATUS, msg);
 
-		msg[n++] = NOT_SUPPORTED;
+		msg[n++] = node_mpb_mode_get(node, &period);
 		msg[n++] = period;
 
 		l_debug("Get/Set Private Beacon (%d)", msg[n-2]);
-- 
2.39.1


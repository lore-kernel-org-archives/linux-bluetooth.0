Return-Path: <SRS0=3vvc=RY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA98C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 21:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFBE218FC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 21:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfCUVAd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:00:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:17780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727520AbfCUVA0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Mar 2019 17:00:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 13:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="153951507"
Received: from bgix-dell-lap.sea.intel.com ([10.255.84.223])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2019 13:55:26 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Store node state variables prior to response
Date:   Thu, 21 Mar 2019 13:55:18 -0700
Message-Id: <20190321205518.7881-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190321205518.7881-1-brian.gix@intel.com>
References: <20190321205518.7881-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remotely set node state variables need to be saved to the file system
or other NVM prior to returning success status.
---
 mesh/node.c    |  4 +--
 mesh/storage.c | 99 ++++++++++++++++++++++++++++++++++++++++++++--------------
 mesh/storage.h |  9 +++---
 3 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 761a67af4..af8eb6bb8 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -497,7 +497,7 @@ bool node_default_ttl_set(struct mesh_node *node, uint8_t ttl)
 	if (!node)
 		return false;
 
-	res = storage_set_ttl(node->jconfig, ttl);
+	res = storage_set_ttl(node, ttl);
 
 	if (res) {
 		node->ttl = ttl;
@@ -621,7 +621,7 @@ bool node_relay_mode_set(struct mesh_node *node, bool enable, uint8_t cnt,
 	if (!node || node->relay.mode == MESH_MODE_UNSUPPORTED)
 		return false;
 
-	res = storage_set_relay(node->jconfig, enable, cnt, interval);
+	res = storage_set_relay(node, enable, cnt, interval);
 
 	if (res) {
 		node->relay.mode = enable ? MESH_MODE_ENABLED :
diff --git a/mesh/storage.c b/mesh/storage.c
index e84c2c933..f04e3ec89 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -224,27 +224,51 @@ done:
 	return result;
 }
 
-bool storage_set_ttl(json_object *jnode, uint8_t ttl)
+bool storage_set_ttl(struct mesh_node *node, uint8_t ttl)
 {
-	return mesh_db_write_int(jnode, "defaultTTL", ttl);
+	json_object *jnode = node_jconfig_get(node);
+
+	if (!mesh_db_write_int(jnode, "defaultTTL", ttl))
+		return false;
+
+	storage_save_config(node, true, NULL, NULL);
+	return true;
 }
 
-bool storage_set_relay(json_object *jnode, bool enable,
+bool storage_set_relay(struct mesh_node *node, bool enable,
 				uint8_t count, uint8_t interval)
 {
-	return mesh_db_write_relay_mode(jnode, enable, count, interval);
+	json_object *jnode = node_jconfig_get(node);
+
+	if (!mesh_db_write_relay_mode(jnode, enable, count, interval))
+		return false;
+
+	storage_save_config(node, true, NULL, NULL);
+	return true;
 }
 
-bool storage_set_transmit_params(json_object *jnode, uint8_t count,
+bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
 							uint8_t interval)
 {
-	return mesh_db_write_net_transmit(jnode, count, interval);
+	json_object *jnode = node_jconfig_get(node);
+
+	if (!mesh_db_write_net_transmit(jnode, count, interval))
+		return false;
+
+	storage_save_config(node, true, NULL, NULL);
+	return true;
 }
 
-bool storage_set_mode(json_object *jnode, uint8_t mode,
+bool storage_set_mode(struct mesh_node *node, uint8_t mode,
 						const char *mode_name)
 {
-	return mesh_db_write_mode(jnode, mode_name, mode);
+	json_object *jnode = node_jconfig_get(node);
+
+	if (!mesh_db_write_mode(jnode, mode_name, mode))
+		return false;
+
+	storage_save_config(node, true, NULL, NULL);
+	return true;
 }
 
 bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
@@ -252,7 +276,7 @@ bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 {
 	json_object *jnode;
 	int ele_idx;
-	bool is_vendor = (mod_id > 0xffff);
+	bool stored, is_vendor = (mod_id > 0xffff);
 
 	ele_idx = node_get_element_idx(node, addr);
 	if (ele_idx < 0)
@@ -261,11 +285,16 @@ bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 	jnode = node_jconfig_get(node);
 
 	if (unbind)
-		return mesh_db_model_binding_del(jnode, ele_idx, is_vendor,
+		stored = mesh_db_model_binding_del(jnode, ele_idx, is_vendor,
 							mod_id, app_idx);
 	else
-		return mesh_db_model_binding_add(jnode, ele_idx, is_vendor,
+		stored = mesh_db_model_binding_add(jnode, ele_idx, is_vendor,
 							mod_id, app_idx);
+
+	if (stored)
+		storage_save_config(node, true, NULL, NULL);
+
+	return stored;
 }
 
 bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
@@ -273,15 +302,21 @@ bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 {
 	json_object *jnode;
 	struct mesh_node *node = mesh_net_node_get(net);
+	bool stored;
 
 	jnode = node_jconfig_get(node);
 	if (!jnode)
 		return false;
 
 	if (update)
-		return mesh_db_app_key_update(jnode, app_idx, key);
+		stored = mesh_db_app_key_update(jnode, app_idx, key);
+	else
+		stored = mesh_db_app_key_add(jnode, net_idx, app_idx, key);
+
+	if (stored)
+		storage_save_config(node, true, NULL, NULL);
 
-	return mesh_db_app_key_add(jnode, net_idx, app_idx, key);
+	return stored;
 }
 
 bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
@@ -294,8 +329,11 @@ bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
 	if (!jnode)
 		return false;
 
-	return mesh_db_app_key_del(jnode, net_idx, app_idx);
+	if (!mesh_db_app_key_del(jnode, net_idx, app_idx))
+		return false;
 
+	storage_save_config(node, true, NULL, NULL);
+	return true;
 }
 
 bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
@@ -303,11 +341,17 @@ bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 {
 	struct mesh_node *node = mesh_net_node_get(net);
 	json_object *jnode = node_jconfig_get(node);
+	bool stored;
 
 	if (!update)
-		return mesh_db_net_key_add(jnode, net_idx, key);
+		stored = mesh_db_net_key_add(jnode, net_idx, key);
 	else
-		return mesh_db_net_key_update(jnode, net_idx, key);
+		stored = mesh_db_net_key_update(jnode, net_idx, key);
+
+	if (stored)
+		storage_save_config(node, true, NULL, NULL);
+
+	return stored;
 }
 
 bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx)
@@ -315,7 +359,11 @@ bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx)
 	struct mesh_node *node = mesh_net_node_get(net);
 	json_object *jnode = node_jconfig_get(node);
 
-	return mesh_db_net_key_del(jnode, net_idx);
+	if (!mesh_db_net_key_del(jnode, net_idx))
+		return false;
+
+	storage_save_config(node, true, NULL, NULL);
+	return true;
 }
 
 bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
@@ -324,7 +372,11 @@ bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
 	struct mesh_node *node = mesh_net_node_get(net);
 	json_object *jnode = node_jconfig_get(node);
 
-	return mesh_db_write_iv_index(jnode, iv_index, update);
+	if (!mesh_db_write_iv_index(jnode, iv_index, update))
+		return false;
+
+	storage_save_config(node, true, NULL, NULL);
+	return true;
 }
 
 bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
@@ -333,21 +385,22 @@ bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
 	struct mesh_node *node = mesh_net_node_get(net);
 	json_object *jnode = node_jconfig_get(node);
 
-	return mesh_db_net_key_set_phase(jnode, net_idx, phase);
+	if (!mesh_db_net_key_set_phase(jnode, net_idx, phase))
+		return false;
+
+	storage_save_config(node, true, NULL, NULL);
+	return true;
 }
 
 bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
 	json_object *jnode = node_jconfig_get(node);
-	bool result;
 
-	result = mesh_db_write_int(jnode, "sequenceNumber", seq);
-	if (!result)
+	if (!mesh_db_write_int(jnode, "sequenceNumber", seq))
 		return false;
 
 	storage_save_config(node, false, NULL, NULL);
-
 	return true;
 }
 
diff --git a/mesh/storage.h b/mesh/storage.h
index 8b14c8e8e..d71d11b8e 100644
--- a/mesh/storage.h
+++ b/mesh/storage.h
@@ -28,12 +28,13 @@ void storage_save_config(struct mesh_node *node, bool no_wait,
 bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t app_idx, bool unbind);
 
-bool storage_set_ttl(json_object *jnode, uint8_t ttl);
-bool storage_set_relay(json_object *jnode, bool enable, uint8_t count,
+bool storage_set_ttl(struct mesh_node *node, uint8_t ttl);
+bool storage_set_relay(struct mesh_node *node, bool enable, uint8_t count,
 							uint8_t interval);
-bool storage_set_transmit_params(json_object *jnode, uint8_t count,
+bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
 							uint8_t interval);
-bool storage_set_mode(json_object *jnode, uint8_t mode, const char *mode_name);
+bool storage_set_mode(struct mesh_node *node, uint8_t mode,
+						const char *mode_name);
 bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 					const uint8_t key[16], bool update);
 bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx);
-- 
2.14.5


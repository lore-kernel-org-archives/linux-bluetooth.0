Return-Path: <SRS0=iTYz=VN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901D0C76195
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 22:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD0E21743
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 22:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbfGPW4v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:56:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:2095 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731273AbfGPW4u (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jul 2019 18:56:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 15:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,271,1559545200"; 
   d="scan'208";a="170073269"
Received: from bgix-dell-lap.sea.intel.com ([10.251.137.82])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2019 15:56:49 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ 1/3] mesh: Add bound Net Index lookup for App Keys
Date:   Tue, 16 Jul 2019 15:56:42 -0700
Message-Id: <20190716225644.11449-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190716225644.11449-1-brian.gix@intel.com>
References: <20190716225644.11449-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch also normalizes the naming convention in favor of key_aid
when referring to the calculated AID of the used Access Layer key.
---
 mesh/appkey.c | 59 ++++++++++++++++++++++++++++++++++++++---------------------
 mesh/appkey.h |  1 +
 2 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index 412a2c48c..bdc6ac29e 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -39,9 +39,9 @@ struct mesh_app_key {
 	uint16_t net_idx;
 	uint16_t app_idx;
 	uint8_t key[16];
-	uint8_t key_id;
+	uint8_t key_aid;
 	uint8_t new_key[16];
-	uint8_t new_key_id;
+	uint8_t new_key_aid;
 };
 
 struct mesh_msg {
@@ -62,7 +62,7 @@ struct mod_decrypt {
 	uint16_t idx;
 	uint16_t size;
 	uint16_t virt_size;
-	uint8_t key_id;
+	uint8_t key_aid;
 	bool szmict;
 	bool decrypted;
 };
@@ -108,16 +108,16 @@ static void packet_decrypt(void *a, void *b)
 	if (dec->decrypted)
 		return;
 
-	if (key->key_id != dec->key_id &&
-			key->new_key_id != dec->key_id)
+	if (key->key_aid != dec->key_aid &&
+			key->new_key_aid != dec->key_aid)
 		return;
 
 	dec->key = key;
 
-	if (key->key_id == dec->key_id) {
+	if (key->key_aid == dec->key_aid) {
 		dec->decrypted = mesh_crypto_payload_decrypt(dec->virt,
 				dec->virt_size, dec->data, dec->size,
-				dec->szmict, dec->src, dec->dst, dec->key_id,
+				dec->szmict, dec->src, dec->dst, dec->key_aid,
 				dec->seq, dec->iv_idx, dec->out, key->key);
 		if (dec->decrypted)
 			print_packet("Used App Key", dec->key->key, 16);
@@ -125,10 +125,10 @@ static void packet_decrypt(void *a, void *b)
 			print_packet("Failed with App Key", dec->key->key, 16);
 	}
 
-	if (!dec->decrypted && key->new_key_id == dec->key_id) {
+	if (!dec->decrypted && key->new_key_aid == dec->key_aid) {
 		dec->decrypted = mesh_crypto_payload_decrypt(dec->virt,
 				dec->virt_size, dec->data, dec->size,
-				dec->szmict, dec->src, dec->dst, dec->key_id,
+				dec->szmict, dec->src, dec->dst, dec->key_aid,
 				dec->seq, dec->iv_idx, dec->out, key->new_key);
 		if (dec->decrypted)
 			print_packet("Used App Key", dec->key->new_key, 16);
@@ -144,7 +144,7 @@ static void packet_decrypt(void *a, void *b)
 int appkey_packet_decrypt(struct mesh_net *net, bool szmict, uint32_t seq,
 				uint32_t iv_index, uint16_t src,
 				uint16_t dst, uint8_t *virt, uint16_t virt_size,
-				uint8_t key_id, const uint8_t *data,
+				uint8_t key_aid, const uint8_t *data,
 				uint16_t data_size, uint8_t *out)
 {
 	struct l_queue *app_keys;
@@ -156,7 +156,7 @@ int appkey_packet_decrypt(struct mesh_net *net, bool szmict, uint32_t seq,
 		.data = data,
 		.out = out,
 		.size = data_size,
-		.key_id = key_id,
+		.key_aid = key_aid,
 		.iv_idx = iv_index,
 		.virt = virt,
 		.virt_size = virt_size,
@@ -244,7 +244,7 @@ static struct mesh_app_key *app_key_new(void)
 {
 	struct mesh_app_key *key = l_new(struct mesh_app_key, 1);
 
-	key->new_key_id = 0xFF;
+	key->new_key_aid = 0xFF;
 	key->replay_cache = l_queue_new();
 	return key;
 }
@@ -252,16 +252,16 @@ static struct mesh_app_key *app_key_new(void)
 static bool set_key(struct mesh_app_key *key, uint16_t app_idx,
 			const uint8_t *key_value, bool is_new)
 {
-	uint8_t key_id;
+	uint8_t key_aid;
 
-	if (!mesh_crypto_k4(key_value, &key_id))
+	if (!mesh_crypto_k4(key_value, &key_aid))
 		return false;
 
-	key_id = KEY_ID_AKF | (key_id << KEY_AID_SHIFT);
+	key_aid = KEY_ID_AKF | (key_aid << KEY_AID_SHIFT);
 	if (!is_new)
-		key->key_id = key_id;
+		key->key_aid = key_aid;
 	else
-		key->new_key_id = key_id;
+		key->new_key_aid = key_aid;
 
 	memcpy(is_new ? key->new_key : key->key, key_value, 16);
 
@@ -314,7 +314,7 @@ bool appkey_key_init(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 }
 
 const uint8_t *appkey_get_key(struct mesh_net *net, uint16_t app_idx,
-							uint8_t *key_id)
+							uint8_t *key_aid)
 {
 	struct mesh_app_key *app_key;
 	uint8_t phase;
@@ -334,14 +334,14 @@ const uint8_t *appkey_get_key(struct mesh_net *net, uint16_t app_idx,
 		return NULL;
 
 	if (phase != KEY_REFRESH_PHASE_TWO) {
-		*key_id = app_key->key_id;
+		*key_aid = app_key->key_aid;
 		return app_key->key;
 	}
 
-	if (app_key->new_key_id == NET_NID_INVALID)
+	if (app_key->new_key_aid == NET_NID_INVALID)
 		return NULL;
 
-	*key_id = app_key->new_key_id;
+	*key_aid = app_key->new_key_aid;
 	return app_key->new_key;
 }
 
@@ -362,6 +362,23 @@ bool appkey_have_key(struct mesh_net *net, uint16_t app_idx)
 		return true;
 }
 
+uint16_t appkey_net_idx(struct mesh_net *net, uint16_t app_idx)
+{
+	struct mesh_app_key *key;
+	struct l_queue *app_keys;
+
+	app_keys = mesh_net_get_app_keys(net);
+	if (!app_keys)
+		return NET_IDX_INVALID;
+
+	key = l_queue_find(app_keys, match_key_index, L_UINT_TO_PTR(app_idx));
+
+	if (!key)
+		return NET_IDX_INVALID;
+	else
+		return key->net_idx;
+}
+
 int appkey_key_update(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 							const uint8_t *new_key)
 {
diff --git a/mesh/appkey.h b/mesh/appkey.h
index 1c22e801c..4c135580a 100644
--- a/mesh/appkey.h
+++ b/mesh/appkey.h
@@ -34,6 +34,7 @@ bool appkey_msg_in_replay_cache(struct mesh_net *net, uint16_t idx,
 const uint8_t *appkey_get_key(struct mesh_net *net, uint16_t app_idx,
 							uint8_t *key_id);
 bool appkey_have_key(struct mesh_net *net, uint16_t app_idx);
+uint16_t appkey_net_idx(struct mesh_net *net, uint16_t app_idx);
 int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 							const uint8_t *new_key);
 int appkey_key_update(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
-- 
2.14.5


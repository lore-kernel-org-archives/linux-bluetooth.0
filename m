Return-Path: <SRS0=I3Ez=RL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977BAC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 22:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7151B206DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 22:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCHW63 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:58:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:23716 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfCHW62 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Mar 2019 17:58:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 14:58:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="120994307"
Received: from ingas-nuc1.sea.intel.com ([10.251.144.43])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2019 14:58:27 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/3] mesh: Store model publication settings in config file
Date:   Fri,  8 Mar 2019 14:58:20 -0800
Message-Id: <20190308225820.20561-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190308225820.20561-1-inga.stotland@intel.com>
References: <20190308225820.20561-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds functionality to enable storing model publication
parameters in node configuration file.

Also, fix calculations of model publication period.
---
 mesh/cfgmod-server.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 mesh/mesh-db.c       |  2 +-
 mesh/mesh-db.h       |  2 +-
 mesh/model.c         | 18 +++++++++---------
 4 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index df2614529..737aee376 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -125,6 +125,9 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 	uint8_t retransmit;
 	int status;
 	bool cred_flag, b_virt = false;
+	bool vendor = false;
+	struct mesh_model_pub *pub;
+	uint8_t ele_idx;
 
 	switch (size) {
 	default:
@@ -146,6 +149,7 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 		retransmit = pkt[8];
 		mod_id = l_get_le16(pkt + 9) << 16;
 		mod_id |= l_get_le16(pkt + 11);
+		vendor = true;
 		break;
 
 	case 25:
@@ -166,6 +170,7 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 		retransmit = pkt[22];
 		mod_id = l_get_le16(pkt + 23) << 16;
 		mod_id |= l_get_le16(pkt + 25);
+		vendor = true;
 		break;
 	}
 	ele_addr = l_get_le16(pkt);
@@ -193,9 +198,46 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 	l_debug("pub_set: status %d, ea %4.4x, ota: %4.4x, mod: %x, idx: %3.3x",
 					status, ele_addr, ota, mod_id, idx);
 
-	if (IS_UNASSIGNED(ota) && !b_virt)
+	if (IS_UNASSIGNED(ota) && !b_virt) {
 		ttl = period = idx = 0;
 
+		/* Remove model publication from config file */
+		if (status == MESH_STATUS_SUCCESS)
+			mesh_db_model_pub_del(node_jconfig_get(node), ele_addr,
+					vendor ? mod_id : mod_id & 0x0000ffff,
+					vendor);
+		goto done;
+	}
+
+	if (status != MESH_STATUS_SUCCESS)
+		goto done;
+
+	ele_idx = node_get_element_idx(node, ele_addr);
+	pub = mesh_model_pub_get(node, ele_idx, mod_id, &status);
+
+	if (pub) {
+		struct mesh_db_pub db_pub = {
+			.virt = b_virt,
+			.addr = ota,
+			.idx = idx,
+			.ttl = ttl,
+			.credential = pub->credential,
+			.period = period,
+			.count = pub->retransmit >> 5,
+			.interval = ((0x1f & pub->retransmit) + 1) * 50
+		};
+
+		if (b_virt)
+			memcpy(db_pub.virt_addr, pub_addr, 16);
+
+		/* Save model publication to config file */
+		if (!mesh_db_model_pub_add(node_jconfig_get(node), ele_addr,
+					vendor ? mod_id : mod_id & 0x0000ffff,
+					vendor, &db_pub))
+			status = MESH_STATUS_STORAGE_FAIL;
+	}
+
+done:
 	if (!unreliable)
 		send_pub_status(node, src, dst, status, ele_addr, ota,
 				mod_id, idx, cred_flag, ttl, period,
diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 01859f524..757cfd4c2 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -820,7 +820,7 @@ static struct mesh_db_pub *parse_model_publication(json_object *jpub)
 
 	if (!get_int(jpub, "period", &value))
 		goto fail;
-	pub->period = (uint8_t) value;
+	pub->period = value;
 
 	if (!get_int(jpub, "credentials", &value))
 		goto fail;
diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h
index 5dec6cb9f..b9af1203b 100644
--- a/mesh/mesh-db.h
+++ b/mesh/mesh-db.h
@@ -27,11 +27,11 @@ struct mesh_db_sub {
 
 struct mesh_db_pub {
 	bool virt;
+	uint32_t period;
 	uint16_t addr;
 	uint16_t idx;
 	uint8_t ttl;
 	uint8_t credential;
-	uint8_t period;
 	uint8_t count;
 	uint8_t interval;
 	uint8_t virt_addr[16];
diff --git a/mesh/model.c b/mesh/model.c
index dc525f72f..80c30edba 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -178,13 +178,13 @@ static struct mesh_model *find_model(struct mesh_node *node, uint16_t addr,
 	return get_model(node, (uint8_t) ele_idx, mod_id, fail);
 }
 
-static uint32_t convert_pub_period_to_ms(uint8_t pub_period)
+static uint32_t pub_period_to_ms(uint8_t pub_period)
 {
 	int n;
 
-	n = (pub_period & 0x3f);
+	n = pub_period >> 2;
 
-	switch (pub_period >> 6) {
+	switch (pub_period & 0x3) {
 	default:
 		return n * 100;
 	case 2:
@@ -488,8 +488,10 @@ static void remove_pub(struct mesh_node *node, struct mesh_model *mod)
 	l_free(mod->pub);
 	mod->pub = NULL;
 
-	/* TODO: remove from storage */
-
+	/*
+	 * TODO: Instead of reporting  period of 0, report publication
+	 * address as unassigned
+	 */
 	if (!mod->cbs)
 		/* External models */
 		config_update_model_pub_period(node, mod->ele_idx, mod->id, 0);
@@ -1017,8 +1019,6 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (result != MESH_STATUS_SUCCESS)
 		return result;
 
-	/* TODO: save to storage */
-
 	/*
 	 * If the publication address is set to unassigned address value,
 	 * remove publication
@@ -1034,7 +1034,7 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 
 	/* External model */
 	config_update_model_pub_period(node, ele_idx, id,
-					convert_pub_period_to_ms(period));
+						pub_period_to_ms(period));
 
 	return MESH_STATUS_SUCCESS;
 }
@@ -1601,7 +1601,7 @@ void model_build_config(void *model, void *msg_builder)
 
 	/* Model periodic publication interval, if present */
 	if (mod->pub) {
-		uint32_t period = convert_pub_period_to_ms(mod->pub->period);
+		uint32_t period = pub_period_to_ms(mod->pub->period);
 		dbus_append_dict_entry_basic(builder, "PublicationPeriod", "u",
 								&period);
 	}
-- 
2.17.2


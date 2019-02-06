Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2FAC169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 07:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027EF218A1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 07:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfBFHjL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:39:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:11568 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfBFHjL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 02:39:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 23:39:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="115615995"
Received: from naram-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.228.86])
  by orsmga008.jf.intel.com with ESMTP; 05 Feb 2019 23:39:10 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 4/5] mesh: Save key refresh phase state to node config file
Date:   Tue,  5 Feb 2019 23:39:08 -0800
Message-Id: <20190206073908.29138-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds implementation for saving the key refresh phase to
a node configuration file in JSON format. When the key refresh
procedure is finished, the old network keys are remove from the
configuration file.
---
 mesh/mesh-db.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/mesh-db.h |  2 +-
 mesh/net.c     |  4 ++++
 mesh/storage.c |  9 ++++++++
 mesh/storage.h |  2 ++
 5 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 5c0b72551..b9bbef912 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -1491,3 +1491,59 @@ bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node) {
 
 	return true;
 }
+
+static void finish_key_refresh(json_object *jobj, uint16_t net_idx)
+{
+	json_object *jarray;
+	int i, len;
+
+	/* Clean up all the bound appkeys */
+	json_object_object_get_ex(jobj, "appKeys", &jarray);
+	if (!jarray)
+		return;
+
+	len = json_object_array_length(jarray);
+
+	for (i = 0; i < len; ++i) {
+		json_object *jentry;
+		uint16_t idx;
+
+		jentry = json_object_array_get_idx(jarray, i);
+
+		if (!get_key_index(jentry, "boundNetKey", &idx))
+			continue;
+
+		if (idx != net_idx)
+			continue;
+
+		json_object_object_del(jentry, "oldKey");
+
+		if (!get_key_index(jentry, "index", &idx))
+			continue;
+	}
+
+}
+
+bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase)
+{
+	json_object *jarray, *jentry = NULL;
+
+	json_object_object_get_ex(jobj, "netKeys", &jarray);
+
+	if (jarray)
+		jentry = get_key_object(jarray, idx);
+
+	if (!jentry)
+		return false;
+
+	json_object_object_del(jentry, "keyRefresh");
+	json_object_object_add(jentry, "keyRefresh",
+					json_object_new_int(phase));
+
+	if (phase == KEY_REFRESH_PHASE_NONE) {
+		json_object_object_del(jentry, "oldKey");
+		finish_key_refresh(jobj, idx);
+	}
+
+	return true;
+}
diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h
index 40e60f72d..db7ea6045 100644
--- a/mesh/mesh-db.h
+++ b/mesh/mesh-db.h
@@ -135,7 +135,7 @@ bool mesh_db_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx);
 bool mesh_db_net_key_add(json_object *jobj, uint16_t net_idx,
 					const uint8_t key[16], int phase);
 bool mesh_db_net_key_del(json_object *jobj, uint16_t net_idx);
-bool mesh_db_write_kr_phase(json_object *jobj, uint16_t net_idx, int phase);
+bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase);
 bool mesh_db_write_address(json_object *jobj, uint16_t address);
 bool mesh_db_write_iv_index(json_object *jobj, uint32_t idx, bool update);
 void mesh_db_remove_property(json_object *jobj, const char *desc);
diff --git a/mesh/net.c b/mesh/net.c
index 21f78163a..b85a95cad 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2656,6 +2656,8 @@ static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	else
 		l_queue_foreach(net->friends, frnd_kr_phase2, net);
 
+	storage_set_key_refresh_phase(net, idx, KEY_REFRESH_PHASE_TWO);
+
 	return MESH_STATUS_SUCCESS;
 }
 
@@ -2689,6 +2691,8 @@ static int key_refresh_finish(struct mesh_net *net, uint16_t idx)
 	else
 		l_queue_foreach(net->friends, frnd_kr_phase3, net);
 
+	storage_set_key_refresh_phase(net, idx, KEY_REFRESH_PHASE_NONE);
+
 	return MESH_STATUS_SUCCESS;
 }
 
diff --git a/mesh/storage.c b/mesh/storage.c
index 84f7c6161..e1d86960a 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -321,6 +321,15 @@ bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
 	return mesh_db_write_iv_index(jnode, iv_index, update);
 }
 
+bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
+								uint8_t phase)
+{
+	struct mesh_node *node = mesh_net_node_get(net);
+	json_object *jnode = node_jconfig_get(node);
+
+	return mesh_db_net_key_set_phase(jnode, net_idx, phase);
+}
+
 bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
diff --git a/mesh/storage.h b/mesh/storage.h
index 91299f0a8..7dad2762e 100644
--- a/mesh/storage.h
+++ b/mesh/storage.h
@@ -47,3 +47,5 @@ bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
 								bool update);
 bool storage_set_device_key(struct mesh_node *node, uint8_t dev_key[16]);
 bool storage_set_unicast(struct mesh_node *node, uint16_t unicast);
+bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
+								uint8_t phase);
-- 
2.17.2


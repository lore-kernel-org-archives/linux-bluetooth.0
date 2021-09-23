Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1630C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888E1610A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbhIWD2l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:16373 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239035AbhIWD2k (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555893"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555893"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:50 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072324"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:50 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 01/20] tools/mesh-cfgclient: Save provisioner info
Date:   Wed, 22 Sep 2021 20:25:44 -0700
Message-Id: <20210923032603.50536-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds "provisioners" property to the config database.
The property includes the provisioner's name, UUID of the provisioner
device (corresponds to the local node), allocated unicast, group and
scene ranges.
The current implementation limitations:
- only one provisioner in the mesh network is supported,
- the unicast range is assumed to be contiguous,
- the group range is assumed to be contiguous,
- no support for scenes (empty array).
---
 tools/mesh-cfgclient.c |   5 +-
 tools/mesh/mesh-db.c   | 110 ++++++++++++++++++++++++++++++++++++-----
 tools/mesh/mesh-db.h   |   1 -
 3 files changed, 103 insertions(+), 13 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 70553c95c..62dcecb2f 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -1823,13 +1823,16 @@ static struct l_dbus_message *join_complete(struct l_dbus *dbus,
 		return l_dbus_message_new_error(message, dbus_err_fail, NULL);
 	}
 
-	mesh_db_set_addr_range(low_addr, high_addr);
 	keys_add_net_key(PRIMARY_NET_IDX);
 	mesh_db_net_key_add(PRIMARY_NET_IDX);
 
 	remote_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
 	mesh_db_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
 
+	mesh_db_add_provisioner("BlueZ mesh-cfgclient", app.uuid,
+					low_addr, high_addr,
+					GROUP_ADDRESS_LOW, GROUP_ADDRESS_HIGH);
+
 	l_idle_oneshot(attach_node, NULL, NULL);
 
 	return l_dbus_message_new_method_return(message);
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 034d7be2b..50fbc18cb 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -245,7 +245,7 @@ static json_object *get_node_by_uuid(json_object *jcfg, uint8_t uuid[16])
 		const char *str;
 
 		jentry = json_object_array_get_idx(jarray, i);
-		if (!json_object_object_get_ex(jentry, "uuid", &jval))
+		if (!json_object_object_get_ex(jentry, "UUID", &jval))
 			return NULL;
 
 		str = json_object_get_string(jval);
@@ -429,7 +429,7 @@ static void load_remotes(json_object *jcfg)
 		if (!jnode)
 			continue;
 
-		if (!json_object_object_get_ex(jnode, "uuid", &jval))
+		if (!json_object_object_get_ex(jnode, "UUID", &jval))
 			continue;
 
 		str = json_object_get_string(jval);
@@ -931,7 +931,7 @@ bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 	if (!jnode)
 		return false;
 
-	if (!add_u8_16(jnode, "uuid", uuid))
+	if (!add_u8_16(jnode, "UUID", uuid))
 		goto fail;
 
 	jelements = init_elements(num_els);
@@ -1188,14 +1188,32 @@ bool mesh_db_get_token(uint8_t token[8])
 
 bool mesh_db_get_addr_range(uint16_t *low, uint16_t *high)
 {
-	json_object *jlow, *jhigh;
+	json_object *jprov, *jarray, *jobj, *jlow, *jhigh;
 	const char *str;
 
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	if (!json_object_object_get_ex(cfg->jcfg, "low", &jlow) ||
-			!json_object_object_get_ex(cfg->jcfg, "high", &jhigh))
+	jarray = json_object_object_get(cfg->jcfg, "provisioniers");
+
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	/* Assumption: only one provisioner in the system */
+	jprov = json_object_array_get_idx(jarray, 0);
+	if (!jprov)
+		return false;
+
+	if (!json_object_object_get_ex(jprov, "allocatedUnicastRange", &jarray))
+		return false;
+
+	/* Assumption: only one contiguous range is specified */
+	jobj = json_object_array_get_idx(jarray, 0);
+	if (!jobj)
+		return false;
+
+	if (!json_object_object_get_ex(jobj, "lowAddress", &jlow) ||
+			!json_object_object_get_ex(jobj, "highAddress", &jhigh))
 		return false;
 
 	str = json_object_get_string(jlow);
@@ -1209,18 +1227,82 @@ bool mesh_db_get_addr_range(uint16_t *low, uint16_t *high)
 	return true;
 }
 
-bool mesh_db_set_addr_range(uint16_t low, uint16_t high)
+/*
+ * This is a simplistic implementation onf allocated range, where
+ * the range is one contiguous chunk of the address space.
+ */
+static bool add_range(json_object *jobj, const char *keyword, uint16_t low,
+								uint16_t high)
 {
+	json_object *jarray, *jrange;
+
+	jrange = json_object_new_object();
+
+	if (!write_uint16_hex(jrange, "lowAddress", low))
+		goto fail;
+
+	if (!write_uint16_hex(jrange, "highAddress", high))
+		goto fail;
+
+	jarray = json_object_new_array();
+	if (!jarray)
+		goto fail;
+
+	json_object_array_add(jarray, jrange);
+	json_object_object_add(jobj, keyword, jarray);
+
+	return true;
+
+fail:
+	json_object_put(jrange);
+
+	return false;
+}
+
+bool mesh_db_add_provisioner(const char *name, uint8_t uuid[16],
+				uint16_t unicast_low, uint16_t unicast_high,
+					uint16_t group_low, uint16_t group_high)
+{
+	json_object *jprovs, *jprov, *jscenes;
+
 	if (!cfg || !cfg->jcfg)
 		return false;
 
-	if (!write_uint16_hex(cfg->jcfg, "low", low))
+	if (!json_object_object_get_ex(cfg->jcfg, "provisioners", &jprovs))
 		return false;
 
-	if (!write_uint16_hex(cfg->jcfg, "high", high))
+	if (!jprovs || json_object_get_type(jprovs) != json_type_array)
 		return false;
 
+	jprov = json_object_new_object();
+
+	if (!add_string(jprov, "provisionerName", name))
+		goto fail;
+
+	if (!add_u8_16(jprov, "UUID", uuid))
+		goto fail;
+
+	if (!add_range(jprov, "allocatedUnicastRange", unicast_low,
+								unicast_high))
+		goto fail;
+
+	if (!add_range(jprov, "allocatedGroupRange", group_low, group_high))
+		goto fail;
+
+	/* Scenes are not supported. Just add an empty array */
+	jscenes = json_object_new_array();
+	if (!jscenes)
+		goto fail;
+
+	json_object_object_add(jprov, "allocatedSceneRange", jscenes);
+
+	json_object_array_add(jprovs, jprov);
+
 	return save_config();
+
+fail:
+	json_object_put(jprov);
+	return false;
 }
 
 uint32_t mesh_db_get_iv_index(void)
@@ -1408,10 +1490,10 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 
 	l_uuid_v4(uuid);
 
-	if (!add_u8_16(jcfg, "uuid", uuid))
+	if (!add_u8_16(jcfg, "meshUUID", uuid))
 		goto fail;
 
-	if (mesh_name && !add_string(jcfg, "name", mesh_name))
+	if (mesh_name && !add_string(jcfg, "meshName", mesh_name))
 		goto fail;
 
 	jarray = json_object_new_array();
@@ -1420,6 +1502,12 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 
 	json_object_object_add(jcfg, "nodes", jarray);
 
+	jarray = json_object_new_array();
+	if (!jarray)
+		goto fail;
+
+	json_object_object_add(jcfg, "provisioners", jarray);
+
 	jarray = json_object_new_array();
 	if (!jarray)
 		goto fail;
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index 22518c618..efd579553 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -24,7 +24,6 @@ bool mesh_db_net_key_del(uint16_t idx);
 bool mesh_db_net_key_phase_set(uint16_t net_idx, uint8_t phase);
 bool mesh_db_app_key_add(uint16_t net_idx, uint16_t app_idx);
 bool mesh_db_app_key_del(uint16_t app_idx);
-bool mesh_db_set_addr_range(uint16_t low, uint16_t high);
 bool mesh_db_get_addr_range(uint16_t *low, uint16_t *high);
 
 bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
-- 
2.31.1


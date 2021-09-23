Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF06EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D90610A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbhIWD2w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:16377 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239057AbhIWD2o (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555919"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555919"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:57 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072365"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:57 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 10/20] tools/mesh-cfgclient: Store remote's model publication info
Date:   Wed, 22 Sep 2021 20:25:53 -0700
Message-Id: <20210923032603.50536-11-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update remote node's model publication after a successful completion
of "pub-set" or "pub-get" commands.
---
 tools/mesh/cfgcli.c  | 42 +++++++++++++++++------
 tools/mesh/mesh-db.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 tools/mesh/mesh-db.h |  4 +++
 tools/mesh/model.h   | 13 ++++---
 4 files changed, 124 insertions(+), 16 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 19a42947e..2766d47ca 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -334,7 +334,7 @@ static void print_pub(uint16_t ele_addr, uint32_t mod_id,
 						struct model_pub *pub)
 {
 	bt_shell_printf("\tElement: %4.4x\n", ele_addr);
-	bt_shell_printf("\tPub Addr: %4.4x\n", pub->u.addr16);
+	bt_shell_printf("\tPub Addr: %4.4x\n", pub->u.addr);
 
 	if (mod_id < VENDOR_ID_MASK)
 		bt_shell_printf("\tModel: %8.8x\n", mod_id);
@@ -634,31 +634,51 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		mod_id = print_mod_id(data + 10, len == 14, "");
 
-		pub.u.addr16 = get_le16(data + 3);
+		pub.u.addr = get_le16(data + 3);
+
 		pub.app_idx = get_le16(data + 5);
+		pub.cred = ((pub.app_idx & 0x1000) != 0);
+		pub.app_idx &= 0x3ff;
+
 		pub.ttl = data[7];
-		pub.period = data[8];
-		n = (data[8] & 0x3f);
+		pub.prd_steps = (data[8] & 0x3f);
 
 		print_pub(ele_addr, mod_id, &pub);
 
 		switch (data[8] >> 6) {
 		case 0:
-			bt_shell_printf("Period\t\t%d ms\n", n * 100);
+			pub.prd_res = 100;
 			break;
 		case 2:
-			n *= 10;
-			/* fall through */
+			pub.prd_res = 10;
+			break;
 		case 1:
-			bt_shell_printf("Period\t\t%d sec\n", n);
+			pub.prd_res = 10000;
 			break;
 		case 3:
-			bt_shell_printf("Period\t\t%d min\n", n * 10);
+			pub.prd_res = 600000;
 			break;
 		}
 
-		bt_shell_printf("Rexmit count\t%d\n", data[9] & 0x7);
-		bt_shell_printf("Rexmit steps\t%d\n", data[9] >> 3);
+		bt_shell_printf("Period\t\t%d ms\n", pub.period);
+
+		pub.rtx_cnt = data[9] & 0x7;
+		pub.rtx_interval = ((data[9] >> 3) + 1) * 50;
+		bt_shell_printf("Rexmit count\t%d\n", pub.rtx_cnt);
+		bt_shell_printf("Rexmit steps\t%d\n", pub.rtx_interval);
+
+		if (IS_VIRTUAL(pub.u.addr)) {
+			grp = l_queue_find(groups, match_group_addr,
+						L_UINT_TO_PTR(pub.u.addr));
+			if (!grp)
+				return true;
+
+			memcpy(pub.u.label, grp->label, sizeof(pub.u.label));
+
+		}
+
+		mesh_db_node_model_set_pub(src, ele_addr, len == 14, mod_id,
+						&pub, IS_VIRTUAL(pub.u.addr));
 
 		break;
 
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 8445d33f4..f63edd5ae 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -32,6 +32,7 @@
 #include "tools/mesh/keys.h"
 #include "tools/mesh/remote.h"
 #include "tools/mesh/cfgcli.h"
+#include "tools/mesh/model.h"
 #include "tools/mesh/mesh-db.h"
 
 #define KEY_IDX_INVALID NET_IDX_INVALID
@@ -992,6 +993,86 @@ bool mesh_db_node_model_overwrt_sub_virt(uint16_t unicast, uint16_t ele,
 	return sub_overwrite(unicast, ele, vendor, mod_id, buf);
 }
 
+static bool add_transmit_info(json_object *jobj, int cnt, int interval,
+							const char *desc)
+{
+	json_object *jtxmt;
+
+	jtxmt = json_object_new_object();
+
+	if (!write_int(jtxmt, "count", cnt))
+		return false;
+
+	if (!write_int(jtxmt, "interval", interval))
+		return false;
+
+	json_object_object_add(jobj, desc, jtxmt);
+	return true;
+}
+
+bool mesh_db_node_model_set_pub(uint16_t unicast, uint16_t ele_addr,
+					bool vendor, uint32_t mod_id,
+					struct model_pub *pub, bool virt)
+{
+	json_object *jmod, *jpub, *jobj = NULL;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jmod = get_model(unicast, ele_addr, mod_id, vendor);
+	if (!jmod)
+		return false;
+
+	jpub = json_object_new_object();
+
+	if (!virt && !write_uint16_hex(jpub, "address", pub->u.addr))
+		goto fail;
+
+	if (virt) {
+		char buf[33];
+
+		hex2str(pub->u.label, 16, buf, sizeof(buf));
+
+		if (!add_string(jpub, "address", buf))
+			goto fail;
+	}
+
+	if (!write_int(jpub, "index", pub->app_idx))
+		goto fail;
+
+	if (!write_int(jpub, "ttl", pub->ttl))
+		goto fail;
+
+	if (!write_int(jpub, "credentials", pub->cred ? 1 : 0))
+		goto fail;
+
+	if (!add_transmit_info(jpub, pub->rtx_cnt, pub->rtx_interval,
+							"retransmit"))
+		goto fail;
+
+	jobj = json_object_new_object();
+
+	if (!write_int(jobj, "numberOfSteps", pub->prd_steps))
+		goto fail;
+
+	if (!write_int(jobj, "resolution", pub->prd_res))
+		goto fail;
+
+	json_object_object_add(jpub, "period", jobj);
+
+	json_object_object_del(jmod, "publish");
+	json_object_object_add(jmod, "publish", jpub);
+
+	return save_config();
+
+fail:
+	if (jobj)
+		json_object_put(jobj);
+
+	json_object_put(jpub);
+	return false;
+}
+
 static void jarray_key_del(json_object *jarray, int16_t idx)
 {
 	int i, sz = json_object_array_length(jarray);
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index 384376cbd..885dabe90 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -11,6 +11,7 @@
 #include "mesh/mesh-config.h"
 
 struct mesh_group;
+struct model_pub;
 
 bool mesh_db_create(const char *fname, const uint8_t token[8],
 							const char *name);
@@ -65,6 +66,9 @@ bool mesh_db_node_model_overwrt_sub_virt(uint16_t unicast, uint16_t ele,
 								uint8_t *label);
 bool mesh_db_node_model_del_sub_all(uint16_t unicast, uint16_t ele, bool vendor,
 							uint32_t mod_id);
+bool mesh_db_node_model_set_pub(uint16_t unicast, uint16_t ele_addr,
+					bool vendor, uint32_t mod_id,
+					struct model_pub *pub, bool virt);
 struct l_queue *mesh_db_load_groups(void);
 bool mesh_db_add_group(struct mesh_group *grp);
 bool mesh_db_add_rejected_addr(uint16_t unicast, uint32_t iv_index);
diff --git a/tools/mesh/model.h b/tools/mesh/model.h
index 7359ea7df..5e20719b2 100644
--- a/tools/mesh/model.h
+++ b/tools/mesh/model.h
@@ -25,14 +25,17 @@ typedef int (*model_bind_func_t)(uint16_t app_idx, int action);
 
 struct model_pub {
 	uint16_t app_idx;
+	uint16_t period;
 	union {
-		uint16_t addr16;
-		uint8_t va_128[16];
+		uint16_t addr;
+		uint8_t label[16];
 	} u;
+	bool cred;
+	uint32_t prd_res;
+	uint16_t rtx_interval;
+	uint8_t prd_steps;
+	uint8_t rtx_cnt;
 	uint8_t ttl;
-	uint8_t credential;
-	uint8_t period;
-	uint8_t retransmit;
 };
 
 typedef int (*model_pub_func_t)(struct model_pub *pub);
-- 
2.31.1


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD91C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D1D61130
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbhIWD2t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:16381 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239048AbhIWD2o (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555916"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555916"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072360"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:56 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 09/20] tools/mesh-cfgclient: Disallow model commands w/o composition
Date:   Wed, 22 Sep 2021 20:25:52 -0700
Message-Id: <20210923032603.50536-10-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If remote node's composition hasn't been acquired, disallow commands
that change model state (that is, bindings, subscriptions, publications).
Prompt to run "get-composition" command first.
---
 tools/mesh/cfgcli.c  | 26 ++++++++++++++++++++++++++
 tools/mesh/mesh-db.c | 10 ++++++++--
 tools/mesh/remote.c  | 23 +++++++++++++++++++++++
 tools/mesh/remote.h  |  2 ++
 4 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 71bf2e706..19a42947e 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -434,6 +434,9 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		if (!mesh_db_node_set_composition(src, data, len))
 			bt_shell_printf("Failed to save node composition!\n");
+		else
+			remote_set_composition(src, true);
+
 		break;
 
 	case OP_APPKEY_STATUS:
@@ -1233,6 +1236,12 @@ static void cmd_bind(uint32_t opcode, int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	if (!remote_has_composition(target)) {
+		bt_shell_printf("Node composition is unknown\n");
+		bt_shell_printf("Call \"get-composition\" first\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
 	n = mesh_opcode_set(opcode, msg);
 
 	put_le16(parms[0], msg + n);
@@ -1429,6 +1438,12 @@ static void cmd_pub_set(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	if (!remote_has_composition(target)) {
+		bt_shell_printf("Node composition is unknown\n");
+		bt_shell_printf("Call \"get-composition\" first\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
 	pub_addr = parms[1];
 
 	grp = l_queue_find(groups, match_group_addr, L_UINT_TO_PTR(pub_addr));
@@ -1523,6 +1538,12 @@ static void subscription_cmd(int argc, char *argv[], uint32_t opcode)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	if (!remote_has_composition(target)) {
+		bt_shell_printf("Node composition is unknown\n");
+		bt_shell_printf("Call \"get-composition\" first\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
 	sub_addr = parms[1];
 
 	grp = l_queue_find(groups, match_group_addr, L_UINT_TO_PTR(sub_addr));
@@ -1722,6 +1743,11 @@ static void cmd_hb_sub_set(int argc, char *argv[])
 	uint8_t msg[32];
 	uint32_t parm_cnt;
 
+	if (IS_UNASSIGNED(target)) {
+		bt_shell_printf("Destination not set\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
 	n = mesh_opcode_set(OP_CONFIG_HEARTBEAT_SUB_SET, msg);
 
 	parm_cnt = read_input_parameters(argc, argv);
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 1b03e2d90..8445d33f4 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -574,11 +574,17 @@ static void load_remotes(json_object *jcfg)
 			remote_update_app_key(unicast, key_idx, updated, false);
 		}
 
-		load_composition(jnode, unicast);
+		if (!load_composition(jnode, unicast))
+			continue;
 
-		node_count++;
+		/* If "crpl" is present, composition's is available */
+		jval = NULL;
+		if (json_object_object_get_ex(jnode, "crpl", &jval) && jval)
+			remote_set_composition(unicast, true);
 
 		/* TODO: Add the rest of the configuration */
+
+		node_count++;
 	}
 
 	if (node_count != sz)
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index 5f598cb8b..2f8493f8a 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -35,6 +35,7 @@ struct remote_node {
 	struct l_queue *net_keys;
 	struct l_queue *app_keys;
 	struct l_queue **els;
+	bool comp;
 	uint8_t uuid[16];
 	uint8_t num_ele;
 };
@@ -192,6 +193,28 @@ bool remote_set_model(uint16_t unicast, uint8_t ele_idx, uint32_t mod_id,
 	return true;
 }
 
+void remote_set_composition(uint16_t addr, bool comp)
+{
+	struct remote_node *rmt;
+
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
+	if (!rmt)
+		return;
+
+	rmt->comp = comp;
+}
+
+bool remote_has_composition(uint16_t addr)
+{
+	struct remote_node *rmt;
+
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
+	if (!rmt)
+		return false;
+
+	return rmt->comp;
+}
+
 bool remote_add_net_key(uint16_t addr, uint16_t net_idx, bool save)
 {
 	struct remote_node *rmt;
diff --git a/tools/mesh/remote.h b/tools/mesh/remote.h
index 74747689a..2fb0d83ce 100644
--- a/tools/mesh/remote.h
+++ b/tools/mesh/remote.h
@@ -25,6 +25,8 @@ bool remote_del_app_key(uint16_t addr, uint16_t app_idx);
 bool remote_update_app_key(uint16_t addr, uint16_t app_idx, bool update,
 								bool save);
 void remote_finish_key_refresh(uint16_t addr, uint16_t net_idx);
+void remote_set_composition(uint16_t addr, bool comp);
+bool remote_has_composition(uint16_t addr);
 uint16_t remote_get_subnet_idx(uint16_t addr);
 void remote_print_node(uint16_t addr);
 void remote_print_all(void);
-- 
2.31.1


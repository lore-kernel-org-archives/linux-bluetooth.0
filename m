Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E219C3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 20:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1157F21556
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 20:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCBUkc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:40:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:54730 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgCBUkc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 15:40:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 12:40:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,508,1574150400"; 
   d="scan'208";a="351630459"
Received: from ingas-nuc1.sea.intel.com ([10.255.230.43])
  by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2020 12:40:31 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Add address checks for pub/sub commands
Date:   Mon,  2 Mar 2020 12:40:29 -0800
Message-Id: <20200302204030.9150-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This addrs verification of subscriptpion address value entered on
the command line: unassigned address, unicast address, and
all-nodes address are not allowed. Publication address check verifies
that the entered value falls into mesh address space.

Also, change the type of parameter count in comaand processing routines
from int to uint32_t to match the retrun type of the parameter parsing
routine.
---
 tools/mesh/cfgcli.c | 47 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 5c990d2e8..0aea7e553 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -802,7 +802,7 @@ static struct mesh_group *add_group(uint16_t addr)
 {
 	struct mesh_group *grp;
 
-	if (!IS_GROUP(addr))
+	if (!IS_GROUP(addr) || addr >= FIXED_GROUP_LOW)
 		return NULL;
 
 	grp = l_queue_find(groups, match_group_addr, L_UINT_TO_PTR(addr));
@@ -1064,7 +1064,7 @@ static void cmd_bind(uint32_t opcode, int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
-	int parm_cnt;
+	uint32_t parm_cnt;
 
 	parm_cnt = read_input_parameters(argc, argv);
 	if (parm_cnt != 3 && parm_cnt != 4) {
@@ -1101,7 +1101,7 @@ static void cmd_beacon_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[2 + 1];
-	int parm_cnt;
+	uint32_t parm_cnt;
 
 	n = mesh_opcode_set(OP_CONFIG_BEACON_SET, msg);
 
@@ -1128,7 +1128,7 @@ static void cmd_ident_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[2 + 3 + 4];
-	int parm_cnt;
+	uint32_t parm_cnt;
 
 	n = mesh_opcode_set(OP_NODE_IDENTITY_SET, msg);
 
@@ -1152,7 +1152,7 @@ static void cmd_ident_get(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[2 + 2 + 4];
-	int parm_cnt;
+	uint32_t parm_cnt;
 
 	n = mesh_opcode_set(OP_NODE_IDENTITY_GET, msg);
 
@@ -1175,7 +1175,7 @@ static void cmd_proxy_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[2 + 1];
-	int parm_cnt;
+	uint32_t parm_cnt;
 
 	n = mesh_opcode_set(OP_CONFIG_PROXY_SET, msg);
 
@@ -1202,7 +1202,7 @@ static void cmd_relay_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[2 + 2 + 4];
-	int parm_cnt;
+	uint32_t parm_cnt;
 
 	n = mesh_opcode_set(OP_CONFIG_RELAY_SET, msg);
 
@@ -1230,7 +1230,7 @@ static void cmd_ttl_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
-	int parm_cnt;
+	uint32_t parm_cnt;
 
 	parm_cnt = read_input_parameters(argc, argv);
 	if (!parm_cnt || parms[0] > TTL_MASK) {
@@ -1251,7 +1251,7 @@ static void cmd_pub_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[48];
-	int parm_cnt;
+	uint32_t parm_cnt;
 	struct mesh_group *grp;
 	uint32_t opcode;
 	uint16_t pub_addr;
@@ -1263,6 +1263,11 @@ static void cmd_pub_set(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	if (parms[1] > ALL_NODES_ADDRESS) {
+		bt_shell_printf("Bad publication address %x\n", parms[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
 	pub_addr = parms[1];
 
 	grp = l_queue_find(groups, match_group_addr, L_UINT_TO_PTR(pub_addr));
@@ -1314,7 +1319,7 @@ static void cmd_pub_get(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
-	int parm_cnt;
+	uint32_t parm_cnt;
 
 	n = mesh_opcode_set(OP_CONFIG_MODEL_PUB_GET, msg);
 
@@ -1341,7 +1346,7 @@ static void subscription_cmd(int argc, char *argv[], uint32_t opcode)
 {
 	uint16_t n;
 	uint8_t msg[32];
-	int parm_cnt;
+	uint32_t parm_cnt;
 	struct mesh_group *grp;
 	uint16_t sub_addr;
 
@@ -1351,6 +1356,12 @@ static void subscription_cmd(int argc, char *argv[], uint32_t opcode)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	if ((!IS_GROUP(parms[1]) || IS_ALL_NODES(parms[1])) &&
+							!IS_VIRTUAL(parms[1])) {
+		bt_shell_printf("Bad subscription address %x\n", parms[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
 	sub_addr = parms[1];
 
 	grp = l_queue_find(groups, match_group_addr, L_UINT_TO_PTR(sub_addr));
@@ -1416,7 +1427,7 @@ static void cmd_sub_del_all(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
-	int parm_cnt;
+	uint32_t parm_cnt;
 
 	n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_DELETE_ALL, msg);
 
@@ -1443,7 +1454,7 @@ static void cmd_sub_get(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
-	int parm_cnt;
+	uint32_t parm_cnt;
 	bool vendor;
 	uint32_t opcode;
 
@@ -1474,7 +1485,7 @@ static void cmd_mod_appidx_get(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
-	int parm_cnt;
+	uint32_t parm_cnt;
 	bool vendor;
 	uint32_t opcode;
 
@@ -1504,7 +1515,7 @@ static void cmd_hb_pub_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
-	int parm_cnt;
+	uint32_t parm_cnt;
 
 	n = mesh_opcode_set(OP_CONFIG_HEARTBEAT_PUB_SET, msg);
 
@@ -1549,7 +1560,7 @@ static void cmd_hb_sub_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[32];
-	int parm_cnt;
+	uint32_t parm_cnt;
 
 	n = mesh_opcode_set(OP_CONFIG_HEARTBEAT_SUB_SET, msg);
 
@@ -1597,7 +1608,7 @@ static void cmd_network_transmit_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[2 + 1];
-	int parm_cnt;
+	uint32_t parm_cnt;
 
 	n = mesh_opcode_set(OP_CONFIG_NETWORK_TRANSMIT_SET, msg);
 
@@ -1619,7 +1630,7 @@ static void cmd_friend_set(int argc, char *argv[])
 {
 	uint16_t n;
 	uint8_t msg[2 + 1];
-	int parm_cnt;
+	uint32_t parm_cnt;
 
 	n = mesh_opcode_set(OP_CONFIG_FRIEND_SET, msg);
 
-- 
2.21.1


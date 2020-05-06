Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1026C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 06:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B4E2073A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 06:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgEFGR7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 02:17:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:27971 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgEFGR6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 02:17:58 -0400
IronPort-SDR: poTHzZY08UIqrkcB/M/PsWtkNvDzUpv2jSLTar/hMit20sUE1tv+qQeOEzmYGPq74d43nMnRgn
 dVMCR3pheAeg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 23:17:58 -0700
IronPort-SDR: PqV61fV4hxOSibG4fgIeSsD1MCK8W4/iO9z4Z+ggKNRsNs0SL6XD/ETzwupBQduYHh9gQFMRF1
 6qn4nP7RXdgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,358,1583222400"; 
   d="scan'208";a="251111788"
Received: from ingas-nuc1.sea.intel.com ([10.254.75.233])
  by fmsmga008.fm.intel.com with ESMTP; 05 May 2020 23:17:57 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Fix model app list parsing
Date:   Tue,  5 May 2020 23:17:56 -0700
Message-Id: <20200506061756.3449-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes parsing of Model AppKey List & Vendor Model Appkey List
messages: taking into account the packt that AppKey indices are parked
two in three octets.

Also, when printing key indices, print in both decimal and hexadecimal
formats.
---
 tools/mesh-cfgclient.c |  6 ++--
 tools/mesh/cfgcli.c    | 74 +++++++++++++++++++++++++-----------------
 tools/mesh/keys.c      |  6 ++--
 tools/mesh/remote.c    |  6 ++--
 4 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 6db65cd49..bd8fa98d3 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -338,12 +338,14 @@ static bool send_key(void *user_data, uint16_t dst, uint16_t key_idx,
 	}
 
 	if (!is_appkey && !keys_subnet_exists(key_idx)) {
-		bt_shell_printf("Local NetKey %u not found\n", key_idx);
+		bt_shell_printf("Local NetKey %u (%3.3x) not found\n",
+							key_idx, key_idx);
 		return false;
 	}
 
 	if (is_appkey && (keys_get_bound_key(key_idx) == NET_IDX_INVALID)) {
-		bt_shell_printf("Local AppKey %u not found\n", key_idx);
+		bt_shell_printf("Local AppKey %u (%3.3x) not found\n",
+							key_idx, key_idx);
 		return false;
 	}
 
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index d9f1c9b72..2cb28abb8 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -351,7 +351,8 @@ static void print_pub(uint16_t ele_addr, uint32_t mod_id,
 		bt_shell_printf("\tModel: %4.4x\n",
 				(uint16_t) (mod_id & 0xffff));
 
-	bt_shell_printf("\tApp Key Idx: %4.4x\n", pub->app_idx);
+	bt_shell_printf("\tApp Key Idx: %u (0x%3.3x)\n", pub->app_idx,
+								pub->app_idx);
 	bt_shell_printf("\tTTL: %2.2x\n", pub->ttl);
 }
 
@@ -374,6 +375,27 @@ static void print_sub_list(uint16_t addr, bool is_vendor, uint8_t *data,
 		bt_shell_printf("\t\t%4.4x\n ", get_le16(data + i));
 }
 
+static void print_appkey_list(uint16_t len, uint8_t *data)
+{
+	uint16_t app_idx;
+
+	bt_shell_printf("AppKeys:\n");
+
+	while (len >= 3) {
+		app_idx = l_get_le16(data) & 0xfff;
+		bt_shell_printf("\t%u (0x%3.3x)\n", app_idx, app_idx);
+		app_idx = l_get_le16(data + 1) >> 4;
+		bt_shell_printf("\t%u (0x%3.3x)\n", app_idx, app_idx);
+		data += 3;
+		len -= 3;
+	}
+
+	if (len == 2) {
+		app_idx = l_get_le16(data) & 0xfff;
+		bt_shell_printf("\t %u (0x%3.3x)\n", app_idx, app_idx);
+	}
+}
+
 static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 							uint16_t len)
 {
@@ -384,7 +406,6 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 	uint32_t mod_id;
 	struct model_pub pub;
 	int n;
-	uint16_t i;
 	struct pending_req *req;
 
 	if (mesh_opcode_get(data, len, &opcode, &n)) {
@@ -424,8 +445,8 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		net_idx = get_le16(data + 1) & 0xfff;
 		app_idx = get_le16(data + 2) >> 4;
 
-		bt_shell_printf("NetKey\t%3.3x\n", net_idx);
-		bt_shell_printf("AppKey\t%3.3x\n", app_idx);
+		bt_shell_printf("NetKey\t%u (0x%3.3x)\n", net_idx, net_idx);
+		bt_shell_printf("AppKey\t%u (0x%3.3x)\n", app_idx, app_idx);
 
 		if (data[0] != MESH_STATUS_SUCCESS)
 			break;
@@ -455,18 +476,8 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		if (data[0] != MESH_STATUS_SUCCESS)
 			break;
 
-		bt_shell_printf("AppKeys:\n");
 		data += 3;
-
-		while (len >= 3) {
-			bt_shell_printf("\t%3.3x\n", l_get_le16(data) & 0xfff);
-			bt_shell_printf("\t%3.3x\n", l_get_le16(data + 1) >> 4);
-			len -= 3;
-			data += 3;
-		}
-
-		if (len == 2)
-			bt_shell_printf("\t%3.3x\n", l_get_le16(data));
+		print_appkey_list(len, data);
 
 		break;
 
@@ -478,7 +489,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 						mesh_status_str(data[0]));
 		net_idx = get_le16(data + 1) & 0xfff;
 
-		bt_shell_printf("\tNetKey %3.3x\n", net_idx);
+		bt_shell_printf("\tNetKey %u (0x%3.3x)\n", net_idx, net_idx);
 
 		if (data[0] != MESH_STATUS_SUCCESS)
 			break;
@@ -504,15 +515,17 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		while (len >= 3) {
 			net_idx = l_get_le16(data) & 0xfff;
-			bt_shell_printf("\t%3.3x\n", net_idx);
+			bt_shell_printf("\t%u (0x%3.3x)\n", net_idx, net_idx);
 			net_idx = l_get_le16(data + 1) >> 4;
-			bt_shell_printf("\t%3.3x\n", net_idx);
+			bt_shell_printf("\t%u (0x%3.3x)\n", net_idx, net_idx);
 			data += 3;
 			len -= 3;
 		}
 
-		if (len == 2)
-			bt_shell_printf("\t%3.3x\n", l_get_le16(data) & 0xfff);
+		if (len == 2) {
+			net_idx = l_get_le16(data) & 0xfff;
+			bt_shell_printf("\t %u (0x%3.3x)\n", net_idx, net_idx);
+		}
 
 		break;
 
@@ -524,7 +537,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 						mesh_status_str(data[0]));
 		net_idx = get_le16(data + 1) & 0xfff;
 
-		bt_shell_printf("\tNetKey %3.3x\n", net_idx);
+		bt_shell_printf("\tNetKey %u (0x%3.3x)\n", net_idx, net_idx);
 		bt_shell_printf("\tKR Phase %2.2x\n", data[3]);
 		break;
 
@@ -541,7 +554,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		print_mod_id(data + 5, len == 9, "");
 
-		bt_shell_printf("AppIdx\t\t%3.3x\n ", app_idx);
+		bt_shell_printf("AppIdx\t\t%u (0x%3.3x)\n ", app_idx, app_idx);
 
 		break;
 
@@ -673,9 +686,9 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		bt_shell_printf("Element Addr\t%4.4x\n", get_le16(data + 1));
 		bt_shell_printf("Model ID\t%4.4x\n", get_le16(data + 3));
 
-		for (i = 5; i < len; i += 2)
-			bt_shell_printf("Model AppIdx\t%4.4x\n",
-							get_le16(data + i));
+		data += 5;
+		print_appkey_list(len, data);
+
 		break;
 
 	case OP_VEND_MODEL_APP_LIST:
@@ -691,9 +704,9 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		bt_shell_printf("Element Addr\t%4.4x\n", get_le16(data + 1));
 		print_mod_id(data + 3, true, "");
 
-		for (i = 7; i < len; i += 2)
-			bt_shell_printf("Model AppIdx\t%4.4x\n",
-							get_le16(data + i));
+		data += 7;
+		print_appkey_list(len, data);
+
 		break;
 
 	/* Per Mesh Profile 4.3.2.63 */
@@ -709,7 +722,8 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		bt_shell_printf("Period\t\t%2.2x\n", data[4]);
 		bt_shell_printf("TTL\t\t%2.2x\n", data[5]);
 		bt_shell_printf("Features\t%4.4x\n", get_le16(data + 6));
-		bt_shell_printf("Net_Idx\t%4.4x\n", get_le16(data + 8));
+		net_idx = get_le16(data + 8);
+		bt_shell_printf("Net_Idx\t%u (0x%3.3x)\n", net_idx, net_idx);
 		break;
 
 	/* Per Mesh Profile 4.3.2.66 */
@@ -733,7 +747,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		if (len != 1)
 			return true;
 
-		bt_shell_printf("Node %4.4x: Network transmit cnt %d, steps %d\n",
+		bt_shell_printf("Node %4.4x: Net transmit cnt %d, steps %d\n",
 				src, data[0] & 7, data[0] >> 3);
 		break;
 
diff --git a/tools/mesh/keys.c b/tools/mesh/keys.c
index b7d36599a..958df1d15 100644
--- a/tools/mesh/keys.c
+++ b/tools/mesh/keys.c
@@ -193,15 +193,15 @@ static void print_appkey(void *app_key, void *user_data)
 {
 	uint16_t app_idx = L_PTR_TO_UINT(app_key);
 
-	bt_shell_printf("0x%3.3x, ", app_idx);
+	bt_shell_printf("%u (0x%3.3x), ", app_idx, app_idx);
 }
 
 static void print_netkey(void *net_key, void *user_data)
 {
 	struct net_key *key = net_key;
 
-	bt_shell_printf(COLOR_YELLOW "NetKey: 0x%3.3x, phase: %u\n" COLOR_OFF,
-							key->idx, key->phase);
+	bt_shell_printf(COLOR_YELLOW "NetKey: %u (0x%3.3x), phase: %u\n"
+				COLOR_OFF, key->idx, key->idx, key->phase);
 
 	if (!key->app_keys || l_queue_isempty(key->app_keys))
 		return;
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index b9bc6b5c0..24bc59129 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -217,11 +217,11 @@ uint16_t remote_get_subnet_idx(uint16_t addr)
 	return (uint16_t) net_idx;
 }
 
-static void print_key(void *net_key, void *user_data)
+static void print_key(void *key, void *user_data)
 {
-	uint16_t net_idx = L_PTR_TO_UINT(net_key);
+	uint16_t idx = L_PTR_TO_UINT(key);
 
-	bt_shell_printf("%3.3x, ", net_idx);
+	bt_shell_printf("%u (0x%3.3x), ", idx, idx);
 }
 
 static void print_node(void *rmt, void *user_data)
-- 
2.21.1


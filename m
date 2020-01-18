Return-Path: <SRS0=z6V2=3H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6075C32771
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 04:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9812F2467C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 04:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgAREWh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 23:22:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:11361 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgAREWg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 23:22:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 20:22:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="220926447"
Received: from ingas-nuc1.sea.intel.com ([10.251.138.89])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2020 20:22:35 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/4] tools/mesh: Add length checks for rxed messages
Date:   Fri, 17 Jan 2020 20:22:31 -0800
Message-Id: <20200118042233.15338-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200118042233.15338-1-inga.stotland@intel.com>
References: <20200118042233.15338-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds missing validation of received responses.
If the length of a received message does not pass the
validation, it's not processed.
---
 tools/mesh/cfgcli.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 23fca4df6..934205f0b 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -73,9 +73,9 @@ static uint32_t parms[8];
 static struct cfg_cmd cmds[] = {
 	{ OP_APPKEY_ADD, OP_APPKEY_STATUS, "AppKeyAdd" },
 	{ OP_APPKEY_DELETE, OP_APPKEY_STATUS, "AppKeyDelete" },
-	{ OP_APPKEY_GET, OP_APPKEY_LIST, "AppKeyGet"},
-	{ OP_APPKEY_LIST, NO_RESPONSE, "AppKeyList"},
-	{ OP_APPKEY_STATUS, NO_RESPONSE, "AppKeyStatus"},
+	{ OP_APPKEY_GET, OP_APPKEY_LIST, "AppKeyGet" },
+	{ OP_APPKEY_LIST, NO_RESPONSE, "AppKeyList" },
+	{ OP_APPKEY_STATUS, NO_RESPONSE, "AppKeyStatus" },
 	{ OP_APPKEY_UPDATE, OP_APPKEY_STATUS, "AppKeyUpdate" },
 	{ OP_DEV_COMP_GET, OP_DEV_COMP_STATUS, "DeviceCompositionGet" },
 	{ OP_DEV_COMP_STATUS, NO_RESPONSE, "DeviceCompositionStatus" },
@@ -356,7 +356,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 	} else
 		return false;
 
-	bt_shell_printf("Received %s\n", opcode_str(opcode));
+	bt_shell_printf("Received %s (len %u)\n", opcode_str(opcode), len);
 
 	req = get_req_by_rsp(src, (opcode & ~OP_UNRELIABLE));
 	if (req) {
@@ -581,12 +581,12 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 	/* Per Mesh Profile 4.3.2.19 */
 	case OP_CONFIG_MODEL_SUB_STATUS:
+		if (len != 7 && len != 9)
+			return true;
+
 		bt_shell_printf("\nNode %4.4x Subscription status %s\n",
 				src, mesh_status_str(data[0]));
 
-		if (data[0] != MESH_STATUS_SUCCESS)
-			return true;
-
 		ele_addr = get_le16(data + 1);
 		addr = get_le16(data + 3);
 		bt_shell_printf("Element Addr\t%4.4x\n", ele_addr);
@@ -599,13 +599,12 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 	/* Per Mesh Profile 4.3.2.27 */
 	case OP_CONFIG_MODEL_SUB_LIST:
+		if (len < 5)
+			return true;
 
 		bt_shell_printf("\nNode %4.4x Subscription List status %s\n",
 				src, mesh_status_str(data[0]));
 
-		if (data[0] != MESH_STATUS_SUCCESS)
-			return true;
-
 		bt_shell_printf("Element Addr\t%4.4x\n", get_le16(data + 1));
 		bt_shell_printf("Model ID\t%4.4x\n", get_le16(data + 3));
 
@@ -616,12 +615,12 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 	/* Per Mesh Profile 4.3.2.50 */
 	case OP_MODEL_APP_LIST:
+		if (len < 5)
+			return true;
+
 		bt_shell_printf("\nNode %4.4x Model AppIdx status %s\n",
 						src, mesh_status_str(data[0]));
 
-		if (data[0] != MESH_STATUS_SUCCESS)
-			return true;
-
 		bt_shell_printf("Element Addr\t%4.4x\n", get_le16(data + 1));
 		bt_shell_printf("Model ID\t%4.4x\n", get_le16(data + 3));
 
@@ -632,12 +631,12 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 	/* Per Mesh Profile 4.3.2.63 */
 	case OP_CONFIG_HEARTBEAT_PUB_STATUS:
+		if (len != 10)
+			return true;
+
 		bt_shell_printf("\nNode %4.4x Heartbeat publish status %s\n",
 				src, mesh_status_str(data[0]));
 
-		if (data[0] != MESH_STATUS_SUCCESS)
-			return true;
-
 		bt_shell_printf("Destination\t%4.4x\n", get_le16(data + 1));
 		bt_shell_printf("Count\t\t%2.2x\n", data[3]);
 		bt_shell_printf("Period\t\t%2.2x\n", data[4]);
@@ -648,12 +647,12 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 	/* Per Mesh Profile 4.3.2.66 */
 	case OP_CONFIG_HEARTBEAT_SUB_STATUS:
+		if (len != 9)
+			return true;
+
 		bt_shell_printf("\nNode %4.4x Heartbeat subscribe status %s\n",
 				src, mesh_status_str(data[0]));
 
-		if (data[0] != MESH_STATUS_SUCCESS)
-			return true;
-
 		bt_shell_printf("Source\t\t%4.4x\n", get_le16(data + 1));
 		bt_shell_printf("Destination\t%4.4x\n", get_le16(data + 3));
 		bt_shell_printf("Period\t\t%2.2x\n", data[5]);
@@ -673,6 +672,9 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 	/* Per Mesh Profile 4.3.2.54 */
 	case OP_NODE_RESET_STATUS:
+		if (len != 1)
+			return true;
+
 		bt_shell_printf("Node %4.4x reset status %s\n",
 				src, mesh_status_str(data[0]));
 
-- 
2.21.1


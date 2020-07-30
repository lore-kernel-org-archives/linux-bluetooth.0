Return-Path: <SRS0=EfKn=BJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0A5C433E8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 20:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D173D2084D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 20:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgG3UjC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:39:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:35035 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbgG3Ui7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 16:38:59 -0400
IronPort-SDR: bO+4G1v8i4R/80DOHZIM8VbG9/XYhm6Dsr0jiNd1Kd8Y4Bj96RwTySYRKFBfhf7EmnnlCEYLce
 89VIHi3mdo5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="169803101"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="169803101"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 13:38:59 -0700
IronPort-SDR: Li0M3bedzVlOsS++Bx9i7971V5Fj6MBFtvjbazXpll/r74nER87VIxMwH9n8pQlMv06jxMjngo
 YtfS7c4iyeMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="330864968"
Received: from wlloyd-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.79.39])
  by orsmga007.jf.intel.com with ESMTP; 30 Jul 2020 13:38:59 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 05/10] mesh: Clean up handling of config net and app key messages
Date:   Thu, 30 Jul 2020 13:38:46 -0700
Message-Id: <20200730203851.32043-6-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730203851.32043-1-inga.stotland@intel.com>
References: <20200730203851.32043-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This modification allows using a single point for sending out
the composed status messages by the Config Server.
---
 mesh/cfgmod-server.c | 147 ++++++++++++++++++++++---------------------
 1 file changed, 75 insertions(+), 72 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 871ecf878..67e320eda 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -541,6 +541,73 @@ static void node_reset(void *user_data)
 	node_remove(node);
 }
 
+static uint16_t cfg_appkey_msg(struct mesh_node *node, const uint8_t *pkt,
+								int opcode)
+{
+	uint16_t n_idx, a_idx, n;
+	struct mesh_net *net = node_get_net(node);
+
+	n_idx = l_get_le16(pkt) & 0xfff;
+	a_idx = l_get_le16(pkt + 1) >> 4;
+
+	n = mesh_model_opcode_set(OP_APPKEY_STATUS, msg);
+
+	if (opcode == OP_APPKEY_ADD)
+		msg[n] = appkey_key_add(net, n_idx, a_idx, pkt + 3);
+	else if (opcode == OP_APPKEY_UPDATE)
+		msg[n] = appkey_key_update(net, n_idx, a_idx, pkt + 3);
+	else
+		msg[n] = appkey_key_delete(net, n_idx, a_idx);
+
+	l_debug("AppKey Command %s: Net_Idx %3.3x, App_Idx %3.3x",
+			(msg[n] == MESH_STATUS_SUCCESS) ? "success" : "fail",
+								n_idx, a_idx);
+
+	memcpy(msg + n + 1, &pkt[0], 3);
+
+	return n + 4;
+}
+
+static uint16_t cfg_netkey_msg(struct mesh_node *node, const uint8_t *pkt,
+								int opcode)
+{
+	uint16_t n_idx, n;
+	struct mesh_net *net = node_get_net(node);
+
+	n_idx = l_get_le16(pkt);
+	n = mesh_model_opcode_set(OP_NETKEY_STATUS, msg);
+
+	if (opcode == OP_NETKEY_ADD)
+		msg[n] = mesh_net_add_key(net, n_idx, pkt + 2);
+	else if (opcode == OP_NETKEY_UPDATE)
+		msg[n] = mesh_net_update_key(net, n_idx, pkt + 2);
+	else
+		msg[n] = mesh_net_del_key(net, n_idx);
+
+	l_debug("NetKey Command %s: Net_Idx %3.3x",
+			(msg[n] == MESH_STATUS_SUCCESS) ? "success" : "fail",
+									n_idx);
+
+	memcpy(msg + n + 1, &pkt[0], 2);
+
+	return n + 3;
+}
+
+static uint16_t cfg_get_appkeys_msg(struct mesh_node *node, const uint8_t *pkt)
+{
+	uint16_t n_idx, sz, n;
+
+	n_idx = l_get_le16(pkt);
+
+	n = mesh_model_opcode_set(OP_APPKEY_LIST, msg);
+	l_put_le16(n_idx, msg + n + 1);
+
+	msg[n] = appkey_list(node_get_net(node), n_idx, msg + n + 3,
+						MAX_MSG_LEN - (n + 3), &sz);
+
+	return n + 3 + sz;
+}
+
 static uint16_t get_composition(struct mesh_node *node, uint8_t page,
 								uint8_t *buf)
 {
@@ -579,7 +646,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 	uint32_t opcode, tmp32;
 	int b_res = MESH_STATUS_SUCCESS;
 	struct mesh_net_heartbeat *hb;
-	uint16_t n_idx, a_idx;
+	uint16_t n_idx;
 	uint8_t state, status;
 	uint8_t phase;
 	bool virt = false;
@@ -850,60 +917,19 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		if (size != 19)
 			return true;
 
-		n_idx = l_get_le16(pkt) & 0xfff;
-		a_idx = l_get_le16(pkt + 1) >> 4;
-
-		if (opcode == OP_APPKEY_ADD)
-			b_res = appkey_key_add(net, n_idx, a_idx, pkt + 3);
-		else
-			b_res = appkey_key_update(net, n_idx, a_idx,
-								pkt + 3);
-
-		l_debug("Add/Update AppKey %s: Net_Idx %3.3x, App_Idx %3.3x",
-			(b_res == MESH_STATUS_SUCCESS) ? "success" : "fail",
-							n_idx, a_idx);
-
-
-		n = mesh_model_opcode_set(OP_APPKEY_STATUS, msg);
-
-		msg[n++] = b_res;
-		msg[n++] = pkt[0];
-		msg[n++] = pkt[1];
-		msg[n++] = pkt[2];
-		break;
-
+		/* Fall Through */
 	case OP_APPKEY_DELETE:
-		if (size != 3)
+		if (opcode == OP_APPKEY_DELETE && size != 3)
 			return true;
 
-		n_idx = l_get_le16(pkt) & 0xfff;
-		a_idx = l_get_le16(pkt + 1) >> 4;
-		b_res = appkey_key_delete(net, n_idx, a_idx);
-		l_debug("Delete AppKey %s Net_Idx %3.3x to App_Idx %3.3x",
-			(b_res == MESH_STATUS_SUCCESS) ? "success" : "fail",
-							n_idx, a_idx);
-
-		n = mesh_model_opcode_set(OP_APPKEY_STATUS, msg);
-		msg[n++] = b_res;
-		msg[n++] = pkt[0];
-		msg[n++] = pkt[1];
-		msg[n++] = pkt[2];
+		n = cfg_appkey_msg(node, pkt, opcode);
 		break;
 
 	case OP_APPKEY_GET:
 		if (size != 2)
 			return true;
 
-		n_idx = l_get_le16(pkt);
-
-		n = mesh_model_opcode_set(OP_APPKEY_LIST, msg);
-
-		status = appkey_list(net, n_idx, msg + n + 3,
-						MAX_MSG_LEN - n - 3, &size);
-
-		msg[n] = status;
-		l_put_le16(n_idx, msg + n + 1);
-		n += (size + 3);
+		n = cfg_get_appkeys_msg(node, pkt);
 		break;
 
 	case OP_NETKEY_ADD:
@@ -911,35 +937,12 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		if (size != 18)
 			return true;
 
-		n_idx = l_get_le16(pkt);
-
-		if (opcode == OP_NETKEY_ADD)
-			b_res = mesh_net_add_key(net, n_idx, pkt + 2);
-		else
-			b_res = mesh_net_update_key(net, n_idx, pkt + 2);
-
-		l_debug("NetKey Add/Update %s",
-			(b_res == MESH_STATUS_SUCCESS) ? "success" : "fail");
-
-		n = mesh_model_opcode_set(OP_NETKEY_STATUS, msg);
-		msg[n++] = b_res;
-		l_put_le16(l_get_le16(pkt), msg + n);
-		n += 2;
-		break;
-
+		/* Fall Through */
 	case OP_NETKEY_DELETE:
-		if (size != 2)
+		if (opcode == OP_NETKEY_DELETE && size != 2)
 			return true;
 
-		b_res = mesh_net_del_key(net, l_get_le16(pkt));
-
-		l_debug("NetKey delete %s",
-			(b_res == MESH_STATUS_SUCCESS) ? "success" : "fail");
-
-		n = mesh_model_opcode_set(OP_NETKEY_STATUS, msg);
-		msg[n++] = b_res;
-		l_put_le16(l_get_le16(pkt), msg + n);
-		n += 2;
+		n = cfg_netkey_msg(node, pkt, opcode);
 		break;
 
 	case OP_NETKEY_GET:
-- 
2.26.2


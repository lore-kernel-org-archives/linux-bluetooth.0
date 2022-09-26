Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB59CC07E9D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 14:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiIZOlY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiIZOk5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 10:40:57 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C05783239
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 06:01:48 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ocnk3-000470-72
        for linux-bluetooth@vger.kernel.org; Mon, 26 Sep 2022 15:01:47 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 28QD1bCY1107873;
        Mon, 26 Sep 2022 15:01:45 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 4/4] mesh: Clear HB sub status field if disabled
Date:   Mon, 26 Sep 2022 15:01:10 +0200
Message-Id: <20220926130110.2146-5-isak.westin@loytec.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220926130110.2146-1-isak.westin@loytec.com>
References: <20220926130110.2146-1-isak.westin@loytec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 212.17.98.152
X-SA-Exim-Mail-From: isak.westin@loytec.com
X-SA-Exim-Scanned: No (on voyager.loytec.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When replying to a HB subscription get message, and the current state of
source or destination fields is zero (which means that HB subscription
is disabled), all fields in the status reply should be zero.
---
 mesh/cfgmod-server.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 55a2d896b..7044b670d 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -470,7 +470,7 @@ static uint8_t uint32_to_log(uint32_t value)
 	return ret;
 }
 
-static uint16_t hb_subscription_get(struct mesh_node *node, int status)
+static uint16_t hb_subscription_status(struct mesh_node *node, int status)
 {
 	struct mesh_net *net = node_get_net(node);
 	struct mesh_net_heartbeat_sub *sub = mesh_net_get_heartbeat_sub(net);
@@ -502,6 +502,28 @@ static uint16_t hb_subscription_get(struct mesh_node *node, int status)
 	return n;
 }
 
+static uint16_t hb_subscription_get(struct mesh_node *node, int status)
+{
+	struct mesh_net *net = node_get_net(node);
+	struct mesh_net_heartbeat_sub *sub = mesh_net_get_heartbeat_sub(net);
+
+	/*
+	 * MshPRFv1.0.1 section 4.4.1.2.16, Heartbeat Subscription state:
+	 * If this is a GET request and the source or destination is unassigned,
+	 * all fields shall be set to zero in the status reply.
+	 */
+	if (IS_UNASSIGNED(sub->src) || IS_UNASSIGNED(sub->dst)) {
+		uint16_t n;
+
+		n = mesh_model_opcode_set(OP_CONFIG_HEARTBEAT_SUB_STATUS, msg);
+		memset(msg + n, 0, 9);
+		n += 9;
+		return n;
+	}
+
+	return hb_subscription_status(node, status);
+}
+
 static uint16_t hb_subscription_set(struct mesh_node *node, const uint8_t *pkt)
 {
 	uint16_t src, dst;
@@ -525,7 +547,7 @@ static uint16_t hb_subscription_set(struct mesh_node *node, const uint8_t *pkt)
 
 	status = mesh_net_set_heartbeat_sub(net, src, dst, period_log);
 
-	return hb_subscription_get(node, status);
+	return hb_subscription_status(node, status);
 }
 
 static uint16_t hb_publication_get(struct mesh_node *node, int status)
-- 
2.20.1






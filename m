Return-Path: <SRS0=BuFd=5C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB9AC5ACD6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 22:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6410A20738
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 22:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgCQWPt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:15:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:25747 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgCQWPs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Mar 2020 18:15:48 -0400
IronPort-SDR: jZeE3IXnPh5H58S6TBF6C41o2A7RrFza7UbGWckF2aqxnmhtQJPAXI3eW54h2ulzN5PpCi7lvP
 b2+RcSIdYI6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 15:15:48 -0700
IronPort-SDR: hPbHt4VgGXzOdKvfrh83K07cizsltCF09tc+ul0j09btMr4zRlcqRGRv8KfzisPwoXWkm8yWqV
 Z6LIm3jzrM6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="417711494"
Received: from ingas-nuc1.sea.intel.com ([10.255.228.139])
  by orsmga005.jf.intel.com with ESMTP; 17 Mar 2020 15:15:48 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 2/2] mesh: Fix processing of Config Node Reset message
Date:   Tue, 17 Mar 2020 15:15:46 -0700
Message-Id: <20200317221546.22440-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317221546.22440-1-inga.stotland@intel.com>
References: <20200317221546.22440-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a condition when a node continues processing messages
after it has been reset by a remote configuration client.
Upon receiving Config Node Reset message, node removal happens after
a grace interval to allow sending of Config Node Reset Status reply.
---
 mesh/cfgmod-server.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index a1f682765..8db2ef43c 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -695,12 +695,11 @@ static int hb_subscription_set(struct mesh_net *net, uint16_t src,
 	return MESH_STATUS_SUCCESS;
 }
 
-static void node_reset(struct l_timeout *timeout, void *user_data)
+static void node_reset(void *user_data)
 {
 	struct mesh_node *node = user_data;
 
 	l_debug("Node Reset");
-	l_timeout_remove(timeout);
 	node_remove(node);
 }
 
@@ -1223,20 +1222,17 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 
 	case OP_NODE_RESET:
 		n = mesh_model_opcode_set(OP_NODE_RESET_STATUS, msg);
-		/*
-		 * Delay node removal to give it a chance to send back the
-		 * status
-		 */
-		l_timeout_create(1, node_reset, node, NULL);
+
+		/* Delay node removal to give it a chance to send the status */
+		l_idle_oneshot(node_reset, node, NULL);
 		break;
 	}
 
-	if (n) {
-		/* print_packet("App Tx", long_msg ? long_msg : msg, n); */
+	if (n)
 		mesh_model_send(node, dst, src,
 				APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
 				long_msg ? long_msg : msg, n);
-	}
+
 	l_free(long_msg);
 
 	return true;
-- 
2.21.1


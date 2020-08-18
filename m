Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D7CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE0720738
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHRWWM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:22:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:11540 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgHRWWK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 18:22:10 -0400
IronPort-SDR: 1MvmYClBNo3BUix5PZO0yBa8VRgvbNKJO9qLrrMVRtoAbc13WjNCMLW5Ho4prmiESQzJ+TA8Q3
 Z55nvmUPMDDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="152634881"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="152634881"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 15:22:09 -0700
IronPort-SDR: Jdcjc6bvwcySXLaDcnnQPXaLA53jNVFaXNsf95PByCDEI0SNE9AEV8/ysrfUl97LdQ2tCH9G3U
 a2zIal+yhD+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="336764503"
Received: from ypeng18-mobl.ger.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.255.230.245])
  by orsmga007.jf.intel.com with ESMTP; 18 Aug 2020 15:22:09 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2] mesh: Always set net modes based on node feature settings
Date:   Tue, 18 Aug 2020 15:22:07 -0700
Message-Id: <20200818222208.50938-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The network settings such as relay, beacon, proxy and friend are
always set based on local node feature settings. This change makes
the net modes intialization unconditional, to include the "No Support"
setting on node level which should result in the disabled mode in net.c
---
 mesh/node.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 1eeffeb8b..ebc111a62 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -399,24 +399,16 @@ static bool init_storage_dir(struct mesh_node *node)
 
 static void update_net_settings(struct mesh_node *node)
 {
-	uint8_t mode;
+	struct mesh_net *net = node->net;
 
-	mode = node->proxy;
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_proxy_mode(node->net, mode == MESH_MODE_ENABLED);
+	mesh_net_set_proxy_mode(net, node->proxy == MESH_MODE_ENABLED);
 
-	mode = node->friend;
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_friend_mode(node->net, mode == MESH_MODE_ENABLED);
+	mesh_net_set_friend_mode(net, node->friend == MESH_MODE_ENABLED);
 
-	mode = node->relay.mode;
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_relay_mode(node->net, mode == MESH_MODE_ENABLED,
+	mesh_net_set_relay_mode(net, node->relay.mode == MESH_MODE_ENABLED,
 					node->relay.cnt, node->relay.interval);
 
-	mode = node->beacon;
-	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
-		mesh_net_set_beacon_mode(node->net, mode == MESH_MODE_ENABLED);
+	mesh_net_set_beacon_mode(net, node->beacon == MESH_MODE_ENABLED);
 }
 
 static bool init_from_storage(struct mesh_config_node *db_node,
-- 
2.26.2


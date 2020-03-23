Return-Path: <SRS0=apyX=5I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC680C4332B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 21:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D8920719
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 21:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgCWVkg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:40:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:7025 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgCWVkg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Mar 2020 17:40:36 -0400
IronPort-SDR: INCV6RmU/yf+dHYGdAzuuh5kGLOp+yyi6xs5UQ6zDygvrUU8H/TH6kR+LCoyvYGDaK/+VvlI5J
 Fl4C87vZxSMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 14:40:35 -0700
IronPort-SDR: rGdcbBANf8m1w3VolZcwjzH5YvYHtY6qEG6YBdkQ1TgDsQ8JAqefzSMbQaL/7g4YaVLVN5bhVH
 /2/BLUUVajiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="325699111"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.251.242.81])
  by orsmga001.jf.intel.com with ESMTP; 23 Mar 2020 14:40:35 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ] mesh: Fix Replay Protection Cache
Date:   Mon, 23 Mar 2020 14:40:32 -0700
Message-Id: <20200323214032.23816-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There was a bug identified in the RPL storage, such that the real-time
queue was being filled by incorrect unicast addresses. (Thx ccsanden).
---
 mesh/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/net.c b/mesh/net.c
index 55b1330cc..49c4ee23a 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3857,7 +3857,7 @@ void net_msg_add_replay_cache(struct mesh_net *net, uint16_t src, uint32_t seq,
 	if (!rpe) {
 		l_debug("New Entry for %4.4x", src);
 		rpe = l_new(struct mesh_rpl, 1);
-		rpe->seq = src;
+		rpe->src = src;
 	}
 
 	rpe->seq = seq;
-- 
2.21.1


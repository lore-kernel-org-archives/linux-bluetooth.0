Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F517C433C1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 19:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3BB761A1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 19:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbhCXTeu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:34:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:24125 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237780AbhCXTeX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Mar 2021 15:34:23 -0400
IronPort-SDR: jHV+a7DiOLmWFKpqVb6wGSwv+QAZ0r/4w3dq0YzeRFIPF5oxmzsg2KVrOwqtcRtf3VNvVRbnXe
 jcuf3AfnQTAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="178328834"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="178328834"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 12:34:23 -0700
IronPort-SDR: MxV0bmS0jwpdE2dd4HER5MvfUko+mZ2HnVBuejThGVotv6Ja4Jthpx388xr2audl1SofK2i2HI
 ihNfzugTk2eg==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="391416946"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.68.134])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 12:34:23 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Fix segmented msg RX with friendship
Date:   Wed, 24 Mar 2021 12:34:12 -0700
Message-Id: <20210324193412.488233-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes an uninitialized memory issue where a message received for
a local node is silently discarded if an uninitialized boolean is
mistakenly set to TRUE, when friendships exist.
---
 mesh/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mesh/net.c b/mesh/net.c
index 6acd9bc7b..aa220f762 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1165,6 +1165,7 @@ static struct mesh_friend_msg *mesh_friend_msg_new(uint8_t seg_max)
 
 		size += (seg_max + 1) * sizeof(struct mesh_friend_seg_12);
 		frnd_msg = l_malloc(size);
+		memset(frnd_msg, 0, size);
 	} else
 		frnd_msg = l_new(struct mesh_friend_msg, 1);
 
-- 
2.25.4


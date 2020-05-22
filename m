Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A46C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 20:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF79620679
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 20:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbgEVU57 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 May 2020 16:57:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:25387 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731026AbgEVU56 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 May 2020 16:57:58 -0400
IronPort-SDR: UcW6mIf23CkYJ425yhDTgxL1yvKy9R0V/g4GZ8wQMxdVyq3BoTYsac8oPzf83JCKmpyuOjagF2
 TEzAcRVICJKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 13:57:58 -0700
IronPort-SDR: q46fR3eVkKr4A82IvG7hHkSPu2McU7r/Dxhone8C8O3F18ypViIq5zXySjsTUsBpLxQkTbEvTT
 kF20gzUHdC5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,423,1583222400"; 
   d="scan'208";a="254369943"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.68.94])
  by fmsmga007.fm.intel.com with ESMTP; 22 May 2020 13:57:58 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ 1/3] mesh: Fix using uninitialized bytes
Date:   Fri, 22 May 2020 13:57:54 -0700
Message-Id: <20200522205756.230907-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200522205756.230907-1-brian.gix@intel.com>
References: <20200522205756.230907-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixes two problems found with static analysis
---
 mesh/crypto.c | 1 +
 mesh/node.c   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 99536594b..70b96c51b 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -553,6 +553,7 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 	if (seq > SEQ_MASK)
 		return false;
 
+	packet[0] = 0;
 	l_put_be32(seq, packet + 1);
 	packet[1] = (ctl ? CTL : 0) | (ttl & TTL_MASK);
 
diff --git a/mesh/node.c b/mesh/node.c
index dd28dfd77..49ba7c885 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1596,6 +1596,8 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		/* Generate device and primary network keys */
 		l_getrandom(dev_key, sizeof(dev_key));
 		l_getrandom(net_key.old_key, sizeof(net_key.old_key));
+		memcpy(net_key.new_key, net_key.old_key,
+						sizeof(net_key.old_key));
 		net_key.net_idx = PRIMARY_NET_IDX;
 		net_key.phase = KEY_REFRESH_PHASE_NONE;
 
-- 
2.25.4


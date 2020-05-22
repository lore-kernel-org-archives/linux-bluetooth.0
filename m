Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AF7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 21:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79D9207CB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 21:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbgEVVNR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 May 2020 17:13:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:48185 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731041AbgEVVNQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 May 2020 17:13:16 -0400
IronPort-SDR: v9uLO1+6xSk0M/3AzNcPNpWhtI/QPCjjl+O6b7OdXA7SSW5v/lvarYkIHXcztRXWC4pvdQEBRR
 DEZYQIY+DFcQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 14:13:15 -0700
IronPort-SDR: R5EREKU611aelqhjOQoVvNNBUD/hIEjGCceS/9iCeqpp5/eT8KnDfhTj2JNysU3tCNy2OnY22M
 CY15SxT8QWQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,423,1583222400"; 
   d="scan'208";a="254372379"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.68.94])
  by fmsmga007.fm.intel.com with ESMTP; 22 May 2020 14:13:15 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 1/4] mesh: Fix using uninitialized bytes
Date:   Fri, 22 May 2020 14:13:06 -0700
Message-Id: <20200522211309.233824-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200522211309.233824-1-brian.gix@intel.com>
References: <20200522211309.233824-1-brian.gix@intel.com>
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


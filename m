Return-Path: <SRS0=fr0v=SR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A94C10F0E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 19:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1182070D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 19:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfDOT4i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:56:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:22506 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbfDOT4i (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Apr 2019 15:56:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 12:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="131626794"
Received: from bgix-dell-lap.sea.intel.com ([10.254.112.76])
  by orsmga007.jf.intel.com with ESMTP; 15 Apr 2019 12:56:37 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Fix decryption when on more than one Network
Date:   Mon, 15 Apr 2019 12:56:26 -0700
Message-Id: <20190415195626.16687-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Multiple networks use different IV Index's, so we should only use
decryption cache after successful decoding.
---
 mesh/net-keys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 84e3982f5..1a2b590eb 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -216,7 +216,8 @@ uint32_t net_key_decrypt(uint32_t iv_index, const uint8_t *pkt, size_t len,
 	if (iv_pkt != iv_flag)
 		iv_index--;
 
-	if (cache_len == len && memcmp(pkt, cache_pkt, len) == 0)
+	/* If we already successfully decrypted this packet, use cached data */
+	if (cache_id && cache_len == len && !memcmp(pkt, cache_pkt, len))
 		goto done;
 
 	cache_id = 0;
@@ -228,6 +229,7 @@ uint32_t net_key_decrypt(uint32_t iv_index, const uint8_t *pkt, size_t len,
 	l_queue_foreach(keys, decrypt_net_pkt, NULL);
 
 done:
+	/* IV Index must match what was used to decrypt */
 	if (cache_iv_index != iv_index)
 		return 0;
 
-- 
2.14.5


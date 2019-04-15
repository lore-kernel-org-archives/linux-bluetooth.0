Return-Path: <SRS0=fr0v=SR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EE3C10F0E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 21:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF9C20880
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 21:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfDOVQv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:16:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:37983 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfDOVQv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Apr 2019 17:16:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 14:16:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,355,1549958400"; 
   d="scan'208";a="162170446"
Received: from bgix-dell-lap.sea.intel.com ([10.254.112.76])
  by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2019 14:16:50 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2] mesh: Fix decryption when on more than one Network
Date:   Mon, 15 Apr 2019 14:16:44 -0700
Message-Id: <20190415211644.13859-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Multiple networks use different IV Index's, so we should only use
decryption cache after successful decoding.
---
 mesh/net-keys.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 84e3982f5..4f85d5e52 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -216,8 +216,14 @@ uint32_t net_key_decrypt(uint32_t iv_index, const uint8_t *pkt, size_t len,
 	if (iv_pkt != iv_flag)
 		iv_index--;
 
-	if (cache_len == len && memcmp(pkt, cache_pkt, len) == 0)
+	/* If we already successfully decrypted this packet, use cached data */
+	if (cache_id && cache_len == len && !memcmp(pkt, cache_pkt, len)) {
+		/* IV Index must match what was used to decrypt */
+		if (cache_iv_index != iv_index)
+			return 0;
+
 		goto done;
+	}
 
 	cache_id = 0;
 	memcpy(cache_pkt, pkt, len);
@@ -228,9 +234,6 @@ uint32_t net_key_decrypt(uint32_t iv_index, const uint8_t *pkt, size_t len,
 	l_queue_foreach(keys, decrypt_net_pkt, NULL);
 
 done:
-	if (cache_iv_index != iv_index)
-		return 0;
-
 	if (cache_id) {
 		*plain = cache_plain;
 		*plain_len = cache_plainlen;
-- 
2.14.5


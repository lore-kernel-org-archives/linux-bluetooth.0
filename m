Return-Path: <SRS0=kOdZ=XX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B244AC4360C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Sep 2019 14:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EEA20866
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Sep 2019 14:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mnmoran.org header.i=@mnmoran.org header.b="wVIKsLtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfI1OPU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Sep 2019 10:15:20 -0400
Received: from hoster906.com ([192.252.156.27]:42500 "EHLO hoster906.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfI1OPT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Sep 2019 10:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=mnmoran.org; h=from:to
        :cc:subject:date:message-id:in-reply-to:references; s=dkim; bh=P
        FKk8Slfqqq6U2fFl6bBw1p1uhXc4VoV4AqjnCh7iJk=; b=wVIKsLtddPLh0hcqq
        TB+KnOtxuCvenjjXPFfFMC3SRsf9yel4cZVy4T3FlooiBPEk/wQcUjxHjoSSQVZx
        zu+2xSiK2PCxf2d8/+ncIW3+p3kD1+oCofY3D+dMb46Aph9pFQXIQdLjeddlqwl4
        nKacOaQJZwjQTSPwkp3vrIdOYs=
Received: (qmail 32463 invoked by uid 503); 28 Sep 2019 14:15:18 -0000
Received: from unknown (HELO lespaul.Home) (mike@mnmoran.org@50.96.104.71)
  by hoster906.com with ESMTPA; 28 Sep 2019 14:15:18 -0000
From:   "Michael N. Moran" <mike@mnmoran.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Michael N. Moran" <mike@mnmoran.org>
Subject: [PATCH BlueZ] The meshctl sock_write() max_len variable is declared as a uint8_t, which causes the calculation of the GATT MTU to be truncated when the MTU (write_mtu) is greater than 259. This error causes incorrect segmentation.
Date:   Sat, 28 Sep 2019 10:14:03 -0400
Message-Id: <1569680043-2874-2-git-send-email-mike@mnmoran.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569680043-2874-1-git-send-email-mike@mnmoran.org>
References: <1569680043-2874-1-git-send-email-mike@mnmoran.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "Michael N. Moran" <mike@mnmoran.org>

---
 tools/mesh/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mesh/gatt.c b/tools/mesh/gatt.c
index 0a942d4..c9e789c 100644
--- a/tools/mesh/gatt.c
+++ b/tools/mesh/gatt.c
@@ -189,7 +189,7 @@ static bool sock_write(struct io *io, void *user_data)
 	struct write_data *data = user_data;
 	struct iovec iov[2];
 	uint8_t sar;
-	uint8_t max_len;
+	uint16_t max_len;
 
 	if (data == NULL)
 		return true;
-- 
1.8.3.1


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60984C32771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 14:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiIZOla (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiIZOlC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 10:41:02 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C298F3135
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 06:01:44 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ocnjy-00046k-Kp
        for linux-bluetooth@vger.kernel.org; Mon, 26 Sep 2022 15:01:42 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 28QD1bCV1107873;
        Mon, 26 Sep 2022 15:01:40 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 1/4] mesh: Correct u32 to u8 log transformation
Date:   Mon, 26 Sep 2022 15:01:07 +0200
Message-Id: <20220926130110.2146-2-isak.westin@loytec.com>
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

Fixed the log transformation to correctly follow the value mapping
defined in the mesh profile (section 4.1.2).
---
 mesh/cfgmod-server.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 9bc2f1c97..33796d05a 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -455,14 +455,14 @@ done:
 static uint8_t uint32_to_log(uint32_t value)
 {
 	uint32_t val = 1;
-	uint8_t ret = 1;
+	uint8_t ret = 0;
 
 	if (!value)
 		return 0;
 	else if (value > 0x10000)
 		return 0xff;
 
-	while (val < value) {
+	while (val <= value) {
 		val <<= 1;
 		ret++;
 	}
@@ -495,7 +495,7 @@ static uint16_t hb_subscription_get(struct mesh_node *node, int status)
 	l_put_le16(sub->dst, msg + n);
 	n += 2;
 	msg[n++] = uint32_to_log(time_now.tv_sec);
-	msg[n++] = uint32_to_log(sub->count);
+	msg[n++] = sub->count != 0xffff ? uint32_to_log(sub->count) : 0xff;
 	msg[n++] = sub->count ? sub->min_hops : 0;
 	msg[n++] = sub->max_hops;
 
@@ -538,7 +538,7 @@ static uint16_t hb_publication_get(struct mesh_node *node, int status)
 	msg[n++] = status;
 	l_put_le16(pub->dst, msg + n);
 	n += 2;
-	msg[n++] = uint32_to_log(pub->count);
+	msg[n++] = pub->count != 0xffff ? uint32_to_log(pub->count) : 0xff;
 	msg[n++] = uint32_to_log(pub->period);
 	msg[n++] = pub->ttl;
 	l_put_le16(pub->features, msg + n);
-- 
2.20.1






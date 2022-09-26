Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE39BC32771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 14:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiIZOlX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbiIZOk5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 10:40:57 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95011F390E
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 06:01:47 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ocnk1-00046w-LX
        for linux-bluetooth@vger.kernel.org; Mon, 26 Sep 2022 15:01:45 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 28QD1bCX1107873;
        Mon, 26 Sep 2022 15:01:43 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 3/4] mesh: Correct HB sub state updates
Date:   Mon, 26 Sep 2022 15:01:09 +0200
Message-Id: <20220926130110.2146-4-isak.westin@loytec.com>
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

If heartbeat subscription is disabled, all fields should be set to zero
but collected data should be preserved. If HB subscription is enabled,
the collected data should be reset (which includes Min Hops = 0x7f).
HB subscription is disabled by setting any of the following fields to
zero: Source, destination or period log.
HB subscription is enabled by setting all the same fields to valid values.
---
 mesh/cfgmod-server.c |  2 +-
 mesh/net.c           | 20 ++++----------------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 9c5edf551..55a2d896b 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -496,7 +496,7 @@ static uint16_t hb_subscription_get(struct mesh_node *node, int status)
 	n += 2;
 	msg[n++] = uint32_to_log(time_now.tv_sec);
 	msg[n++] = sub->count != 0xffff ? uint32_to_log(sub->count) : 0xff;
-	msg[n++] = sub->count ? sub->min_hops : 0;
+	msg[n++] = sub->min_hops;
 	msg[n++] = sub->max_hops;
 
 	return n;
diff --git a/mesh/net.c b/mesh/net.c
index 699469284..7fec98531 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3608,24 +3608,14 @@ int mesh_net_set_heartbeat_sub(struct mesh_net *net, uint16_t src, uint16_t dst,
 		return MESH_STATUS_UNSPECIFIED_ERROR;
 
 	/* Check if the subscription should be disabled */
-	if (IS_UNASSIGNED(src) || IS_UNASSIGNED(dst)) {
+	if (IS_UNASSIGNED(src) || IS_UNASSIGNED(dst) || !period_log) {
 		if (IS_GROUP(sub->dst))
 			mesh_net_dst_unreg(net, sub->dst);
 
+		/* Preserve collected data, but disable */
 		sub->enabled = false;
 		sub->dst = UNASSIGNED_ADDRESS;
 		sub->src = UNASSIGNED_ADDRESS;
-		sub->count = 0;
-		sub->period = 0;
-		sub->min_hops = 0;
-		sub->max_hops = 0;
-
-	} else if (!period_log && src == sub->src && dst == sub->dst) {
-		if (IS_GROUP(sub->dst))
-			mesh_net_dst_unreg(net, sub->dst);
-
-		/* Preserve collected data, but disable */
-		sub->enabled = false;
 		sub->period = 0;
 
 	} else {
@@ -3637,12 +3627,12 @@ int mesh_net_set_heartbeat_sub(struct mesh_net *net, uint16_t src, uint16_t dst,
 				mesh_net_dst_reg(net, dst);
 		}
 
-		sub->enabled = !!period_log;
+		sub->enabled = true;
 		sub->src = src;
 		sub->dst = dst;
 		sub->count = 0;
 		sub->period = log_to_uint32(period_log);
-		sub->min_hops = 0x00;
+		sub->min_hops = 0x7f;
 		sub->max_hops = 0x00;
 		gettimeofday(&time_now, NULL);
 		sub->start = time_now.tv_sec;
@@ -3656,8 +3646,6 @@ int mesh_net_set_heartbeat_sub(struct mesh_net *net, uint16_t src, uint16_t dst,
 		return MESH_STATUS_SUCCESS;
 	}
 
-	sub->min_hops = 0xff;
-
 	if (!sub->timer)
 		sub->timer = l_timeout_create(sub->period, hb_sub_timeout_func,
 								net, NULL);
-- 
2.20.1






Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D680C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 11:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiI2LEP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 07:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiI2LEM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 07:04:12 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6AD12BDA8
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 04:04:11 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1odrKs-0007Jf-8W
        for linux-bluetooth@vger.kernel.org; Thu, 29 Sep 2022 13:04:10 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 28TB45CH3109252;
        Thu, 29 Sep 2022 13:04:08 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 3/4] mesh: Allow Key refresh to skip Phase 2
Date:   Thu, 29 Sep 2022 13:03:43 +0200
Message-Id: <20220929110344.26130-4-isak.westin@loytec.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220929110344.26130-1-isak.westin@loytec.com>
References: <20220929110344.26130-1-isak.westin@loytec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 212.17.98.152
X-SA-Exim-Mail-From: isak.westin@loytec.com
X-SA-Exim-Scanned: No (on voyager.loytec.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If we are in Key Refresh Phase 1, and receive a Secure Network beacon
using the new NetKey and with KR flag set to 0, Phase 2 should be
skipped. See MshPRFv1.0.1 section 3.10.4.1.
---
 mesh/net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index c225fdb9a..379a6e250 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2613,7 +2613,8 @@ static bool update_kr_state(struct mesh_subnet *subnet, bool kr, uint32_t id)
 {
 	/* Figure out the key refresh phase */
 	if (kr) {
-		if (id == subnet->net_key_upd) {
+		if (subnet->kr_phase == KEY_REFRESH_PHASE_ONE &&
+						id == subnet->net_key_upd) {
 			l_debug("Beacon based KR phase 2 change");
 			return (key_refresh_phase_two(subnet->net, subnet->idx)
 							== MESH_STATUS_SUCCESS);
@@ -2754,7 +2755,7 @@ static void process_beacon(void *net_ptr, void *user_data)
 							ivu != net->iv_update)
 		updated |= update_iv_ivu_state(net, ivi, ivu);
 
-	if (kr != local_kr)
+	if (kr != local_kr || beacon_data->net_key_id != subnet->net_key_cur)
 		updated |= update_kr_state(subnet, kr, beacon_data->net_key_id);
 
 	if (updated)
-- 
2.20.1






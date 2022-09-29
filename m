Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CF7C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 11:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiI2LEQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 07:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbiI2LEM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 07:04:12 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DF012BD8F
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 04:04:10 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1odrKr-0007Jb-E8
        for linux-bluetooth@vger.kernel.org; Thu, 29 Sep 2022 13:04:09 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 28TB45CG3109252;
        Thu, 29 Sep 2022 13:04:07 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 2/4] mesh: Ignore SNB with invalid IV Index values
Date:   Thu, 29 Sep 2022 13:03:42 +0200
Message-Id: <20220929110344.26130-3-isak.westin@loytec.com>
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

If we are in IV update in progress state, and receive a Secure Network
beacon with an IV index equal to last known IV index + 1, and IV update
flag set to 1, it should be ignored. See MshPRFv1.0.1 section 3.10.5.
---
 mesh/net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mesh/net.c b/mesh/net.c
index dc3d1fd80..c225fdb9a 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2671,6 +2671,10 @@ static bool update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 		if (iv_index == net->iv_index)
 			return false;
 
+		/* Ignore beacon with invalid IV index value */
+		if (net->iv_update && iv_index == net->iv_index + 1)
+			return false;
+
 		if (!net->iv_update) {
 			l_debug("iv_upd_state = IV_UPD_UPDATING");
 			net->iv_upd_state = IV_UPD_UPDATING;
-- 
2.20.1






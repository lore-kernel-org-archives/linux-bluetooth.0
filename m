Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CB4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 11:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiI2LES (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 07:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiI2LEP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 07:04:15 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F2C1EC58
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 04:04:13 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1odrKu-0007Jp-9Q
        for linux-bluetooth@vger.kernel.org; Thu, 29 Sep 2022 13:04:12 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 28TB45CI3109252;
        Thu, 29 Sep 2022 13:04:10 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 4/4] mesh: Allow Key Refresh Phase 0 to 3 transition
Date:   Thu, 29 Sep 2022 13:03:44 +0200
Message-Id: <20220929110344.26130-5-isak.westin@loytec.com>
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

Transition to Phase 3 from Phase 0 does not cause any state change, but
is a valid transition. See MshPRFv1.0.1 section 4.2.14.
---
 mesh/cfgmod-server.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 7044b670d..be90ef8c5 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -436,6 +436,10 @@ static uint16_t cfg_key_refresh_phase(struct mesh_node *node,
 				return 0;
 		}
 
+		if (pkt[2] == KEY_REFRESH_TRANS_THREE &&
+						phase == KEY_REFRESH_PHASE_NONE)
+			goto done;
+
 		status = mesh_net_key_refresh_phase_set(net, idx, pkt[2]);
 		l_debug("Set KR Phase: net=%3.3x transition=%d", idx, pkt[2]);
 
-- 
2.20.1






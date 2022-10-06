Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D23C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 15:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJFPAK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiJFO77 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 10:59:59 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74BC1EADC
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 07:59:54 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ogSLo-0006rb-0t
        for linux-bluetooth@vger.kernel.org; Thu, 06 Oct 2022 16:59:52 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 296ExnRD4163430;
        Thu, 6 Oct 2022 16:59:49 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 1/6] mesh: Update Key Refresh flag after provision
Date:   Thu,  6 Oct 2022 16:59:22 +0200
Message-Id: <20221006145927.32731-2-isak.westin@loytec.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221006145927.32731-1-isak.westin@loytec.com>
References: <20221006145927.32731-1-isak.westin@loytec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 212.17.98.152
X-SA-Exim-Mail-From: isak.westin@loytec.com
X-SA-Exim-Scanned: No (on voyager.loytec.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Key Refresh flag in the Secure Network beacon is now correctly
updated based on provisioning data after being successfully provisioned.
---
 mesh/node.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index e81aa82fe..cf4ed140e 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1270,8 +1270,8 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 							MESH_STATUS_SUCCESS)
 			return false;
 
-		if (!mesh_config_net_key_set_phase(node->cfg, net_key_idx,
-							KEY_REFRESH_PHASE_TWO))
+		if (mesh_net_key_refresh_phase_set(node->net, net_key_idx,
+				KEY_REFRESH_PHASE_TWO) != MESH_STATUS_SUCCESS)
 			return false;
 	}
 
-- 
2.20.1






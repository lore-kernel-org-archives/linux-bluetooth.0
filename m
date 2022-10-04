Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C6AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 08:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiJDIZ4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 04:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJDIZy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 04:25:54 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3E622511
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 01:25:54 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ofdFQ-0002H1-NT
        for linux-bluetooth@vger.kernel.org; Tue, 04 Oct 2022 10:25:52 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 2948PkTc2433476;
        Tue, 4 Oct 2022 10:25:50 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 3/4] mesh: Queue a friend update on IV Update change
Date:   Tue,  4 Oct 2022 10:25:29 +0200
Message-Id: <20221004082530.25719-4-isak.westin@loytec.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221004082530.25719-1-isak.westin@loytec.com>
References: <20221004082530.25719-1-isak.westin@loytec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 212.17.98.152
X-SA-Exim-Mail-From: isak.westin@loytec.com
X-SA-Exim-Scanned: No (on voyager.loytec.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A friend update should be queued when we receive a Secure Network beacon
that changes the IV Update state.
---
 mesh/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mesh/net.c b/mesh/net.c
index a8a527c2f..577121f30 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2703,6 +2703,7 @@ static bool update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 
 	net->iv_index = iv_index;
 	net->iv_update = ivu;
+	queue_friend_update(net);
 	return true;
 }
 
-- 
2.20.1






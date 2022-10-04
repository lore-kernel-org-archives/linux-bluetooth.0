Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C63C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 08:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJDIZz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 04:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJDIZx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 04:25:53 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE22C2252E
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 01:25:52 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ofdFP-0002Gr-1r
        for linux-bluetooth@vger.kernel.org; Tue, 04 Oct 2022 10:25:51 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 2948PkTa2433476;
        Tue, 4 Oct 2022 10:25:49 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 1/4] mesh: Correct size of friend cache
Date:   Tue,  4 Oct 2022 10:25:27 +0200
Message-Id: <20221004082530.25719-2-isak.westin@loytec.com>
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

The cache size communicated to the Low Power node should be the same as
the cache size actually used.
---
 mesh/friend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/friend.c b/mesh/friend.c
index 6c63032ac..5b73da689 100644
--- a/mesh/friend.c
+++ b/mesh/friend.c
@@ -25,7 +25,7 @@
 
 #define MAX_FRND_GROUPS		20
 #define FRND_RELAY_WINDOW	250		/* 250 ms */
-#define FRND_CACHE_SIZE		16
+#define FRND_CACHE_SIZE		FRND_CACHE_MAX
 #define FRND_SUB_LIST_SIZE	8
 
 #define RESPONSE_DELAY		(100 - 12)	/*  100  ms - 12ms hw delay */
-- 
2.20.1






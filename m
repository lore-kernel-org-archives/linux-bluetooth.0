Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8A5C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 12:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiF2MrR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiF2MrQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 08:47:16 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B3736179
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 05:47:14 -0700 (PDT)
X-QQ-mid: bizesmtp89t1656506823tf6s4aje
Received: from localhost.localdomain ( [61.183.83.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 29 Jun 2022 20:46:57 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00A0000000
X-QQ-FEAT: j3hIXqmsyHZU6Mf95Mj3H0CRpUTcU+1oTH+pgTqdx3hwnV6EnmmvlNYq5RZ7l
        C6yz/nxdfxEd5BWsHEDh1d2wilKhPN4zqzBx9gmEmvXrzRoQdmYAk1eOFjNIhyxavoAFw/d
        JR9dtCaXhWaGUn6BWYpwqZgk14QC/0I6T8vmud3N5YSn5r51KVmLpro29vD84J45P9/2rhk
        1OAlcBVjwM5N7EpN9ae/5X9mb2ZwwzJy97OJ8ubFGI7ht+pPpu/9qEnsKjhV6/MFd5Aci+0
        lKBs/StPocpQPVlldX7TWWsjOZilyiBEztZl4++GUaI4qc1lqNMdrVyA0Q1prMPPhOSw==
X-QQ-GoodBg: 2
From:   lishengyu <lishengyu@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     lishengyu <lishengyu@uniontech.com>
Subject: [PATCH BlueZ] avdtp: fix possible minor problems
Date:   Wed, 29 Jun 2022 20:46:56 +0800
Message-Id: <20220629124656.10174-1-lishengyu@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It should always be considered that if send_request fails, sep
should be removed from the list and the requested memory freed;
---
 profiles/audio/avdtp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 0d2213ea2..10ef380d4 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2765,8 +2765,11 @@ static gboolean avdtp_discover_resp(struct avdtp *session,
 
 		ret = send_request(session, TRUE, NULL, getcap_cmd,
 							&req, sizeof(req));
-		if (ret < 0)
+		if (ret < 0) {
+			session->seps = g_slist_remove(session->seps, sep);
+			g_free(sep);
 			break;
+		}
 		getcap_pending = TRUE;
 	}
 
-- 
2.20.1




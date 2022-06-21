Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4E1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 04:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbiFUEbv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 00:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiFUEbt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 00:31:49 -0400
X-Greylist: delayed 9211 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Jun 2022 21:31:48 PDT
Received: from smtpbgjp3.qq.com. (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50226B7FD
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jun 2022 21:31:48 -0700 (PDT)
X-QQ-mid: bizesmtp75t1655785902tfvg4y03
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 12:31:42 +0800 (CST)
X-QQ-SSF: 01400000000000D0G000000A0000000
X-QQ-FEAT: xoS364mEyr2n0PaWh1CKP6IurI0fr8dGujIheX7snLbSk9VKXkZQ0SnS9qZIy
        EcVlo9hN6FonT5IkQ8HQ1UGpCion17MFWT0jfOgwDUDHV9AzG5By/4B8mgSFzxcKC/AzZu8
        hhFC3K1Ksj4gmEbMLwAEUehW4Iqvt1W2CxRh1VIPt0rm4/h2QRG61MLq8LmOvllOyUnp4gX
        WHvLBVzPlP/5HVe8FKGP1R5rExWIIlz6gLTZDovfgwTuny6C5jJLKxqWxmnKIIL/pBMWOrU
        XNNdc9NAJpXf3l9SArQHnizcNEeNq7KP+cHBLY+HQoXYlD+qzX8u43ukLvDBERBnfBc/USM
        JHUEeYbwqUrqp/bPcw11zmHeGYcjA==
X-QQ-GoodBg: 1
From:   Chengyi Zhao <zhaochengyi@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Chengyi <zhaochengyi@uniontech.com>
Subject: [PATCH BlueZ 1/1] avdtp: Free discover when send_request returns error
Date:   Tue, 21 Jun 2022 12:31:33 +0800
Message-Id: <20220621043133.7720-2-zhaochengyi@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220621043133.7720-1-zhaochengyi@uniontech.com>
References: <20220621043133.7720-1-zhaochengyi@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chengyi <zhaochengyi@uniontech.com>

When send_request returns an error, session->discover should
be released here, so that the next time the program enters
avdtp_discover, the -EBUSY error will not be returned.
---
 profiles/audio/avdtp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index bc7afad81..0d2213ea2 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3429,6 +3429,9 @@ int avdtp_discover(struct avdtp *session, avdtp_discover_cb_t cb,
 	if (err == 0) {
 		session->discover->cb = cb;
 		session->discover->user_data = user_data;
+	} else if (session->discover) {
+		g_free(session->discover);
+		session->discover = NULL;
 	}
 
 	return err;
-- 
2.20.1




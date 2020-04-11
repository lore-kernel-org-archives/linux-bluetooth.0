Return-Path: <SRS0=Wpeu=53=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D232AC2BB86
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Apr 2020 23:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28F020936
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Apr 2020 23:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648705;
	bh=dYxTGFLO18XEoHMGcD97ucFQmH0G9hApwYyAukMl4HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ekGrnZ5/GglJvnm/uDmjYCq0A7MAIbKRmitAUrwrgoK5Ncilq1sSWN3/n8qpTkCvP
	 wuc8sksyLDmnmnP3qEnakyFz+idGacf6fMb2kYAKQR7Z2SOjcou7ri4i36G5MlE9nI
	 oIRPzpO8OEGHvTdAm1VX5HB6JGZBAYO2j4a8X9aA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgDKXFs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgDKXFs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Apr 2020 19:05:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA6F6215A4;
        Sat, 11 Apr 2020 23:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646348;
        bh=dYxTGFLO18XEoHMGcD97ucFQmH0G9hApwYyAukMl4HE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8X1ZrRIvT1vHL4B8GEM4qpLjtJ6w4V8wtQ4zRENaFXxwjRsPlGq1PHYzR6FO9jax
         TKizTUAtjkfJVVED9aVstkP6XJTRe9Vw8l7UqEyzUxzMeV+rCrq9gvYkHeNvCD0B7l
         belEGjj8S/0YgIVcCHdzgHkVNP+mr710YntQGYu4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>,
        syzbot+4496e82090657320efc6@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 096/149] Bluetooth: RFCOMM: fix ODEBUG bug in rfcomm_dev_ioctl
Date:   Sat, 11 Apr 2020 19:02:53 -0400
Message-Id: <20200411230347.22371-96-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

[ Upstream commit 71811cac8532b2387b3414f7cd8fe9e497482864 ]

Needn't call 'rfcomm_dlc_put' here, because 'rfcomm_dlc_exists' didn't
increase dlc->refcnt.

Reported-by: syzbot+4496e82090657320efc6@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Suggested-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/rfcomm/tty.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 0c7d31c6c18cc..a58584949a955 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -413,10 +413,8 @@ static int __rfcomm_create_dev(struct sock *sk, void __user *arg)
 		dlc = rfcomm_dlc_exists(&req.src, &req.dst, req.channel);
 		if (IS_ERR(dlc))
 			return PTR_ERR(dlc);
-		else if (dlc) {
-			rfcomm_dlc_put(dlc);
+		if (dlc)
 			return -EBUSY;
-		}
 		dlc = rfcomm_dlc_alloc(GFP_KERNEL);
 		if (!dlc)
 			return -ENOMEM;
-- 
2.20.1


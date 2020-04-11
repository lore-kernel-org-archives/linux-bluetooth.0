Return-Path: <SRS0=Wpeu=53=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA98C2BBFD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Apr 2020 23:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A18C206E9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Apr 2020 23:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586647165;
	bh=9jgHXDBXge+Uelg55uiGNqGFcvm6tM5OrdSs/Qi7XPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HUfuajw0eNTFcdC3NVj13PgNF4eEZi1uQF6WNcfB8XQgKBkGUtZM9IQj650AS1E69
	 W7YTHATUMvFZEAXL6ikQd/zux+QqX/+UJ/H3noum6bX+Ys3mKttaKprPFxtrt+Aihi
	 urEtQpZCwIPc0nSk36LYU44acMMikNCaW4yRupAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgDKXN5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbgDKXN4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Apr 2020 19:13:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FDD021744;
        Sat, 11 Apr 2020 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646837;
        bh=9jgHXDBXge+Uelg55uiGNqGFcvm6tM5OrdSs/Qi7XPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRGNfe1vUBL1lpjdSNbxIhmD2i7z5MWhye0MtGfczFPZ1snM2pc8FZgCCCfHWtUoA
         n4RpuJD86AB5akjL9QqZlr0SY6OxK8y46T6vbpbX8x+jkQ6fu3SKkrPCL2nx6coSS3
         Dy+FRzapme1PK2JJyifRLw6DWab3JtkF648ylezI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>,
        syzbot+4496e82090657320efc6@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 25/37] Bluetooth: RFCOMM: fix ODEBUG bug in rfcomm_dev_ioctl
Date:   Sat, 11 Apr 2020 19:13:14 -0400
Message-Id: <20200411231327.26550-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411231327.26550-1-sashal@kernel.org>
References: <20200411231327.26550-1-sashal@kernel.org>
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
index 5f3074cb6b4db..b6f26ec9e90cd 100644
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


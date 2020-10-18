Return-Path: <SRS0=T6Hm=DZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D516C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Oct 2020 19:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8CD206B6
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Oct 2020 19:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603050141;
	bh=zx84Ap/ZbXLfmgQQFnACS6AemwwsovoRyJHPi1w2D2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HVJH4zF9nCAzHF5gPtC06wpyeDpO/M3AH5p+g2PyGbCbmNQatR0h5SaoE3A03mgSf
	 S8e6tBSO8Zvg1egwfAFKUobdnSsKGFD9u8HGOmMhugo29zzKGNuZjQZWGTwxoQ4eOC
	 IKcCgeSorZkfJs8jJ7HTY0vyVpBHmf4ld6IT8GNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgJRTX6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730537AbgJRTX5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Oct 2020 15:23:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BCEE222EC;
        Sun, 18 Oct 2020 19:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603049037;
        bh=zx84Ap/ZbXLfmgQQFnACS6AemwwsovoRyJHPi1w2D2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lw3CjM1QP0S+/PTXgzrd0ISFvZ+AIcm2wVdT8WiGQbkz7LQH0iaQkXnYfmnH2Olto
         9QhU3Ngm/Zujy3INDvioHr9HiYjiQ9s2XZv8jvLwmTErOwaPoJurt6C8FJ7DUHBWG/
         4JvzTH0gImyniBALc4vAnb534dk7Z78K30IeNZfM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 68/80] Bluetooth: btusb: Fix memleak in btusb_mtk_submit_wmt_recv_urb
Date:   Sun, 18 Oct 2020 15:22:19 -0400
Message-Id: <20201018192231.4054535-68-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192231.4054535-1-sashal@kernel.org>
References: <20201018192231.4054535-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit d33fe77bdf75806d785dabf90d21d962122e5296 ]

When kmalloc() on buf fails, urb should be freed just like
when kmalloc() on dr fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f3f0529564da0..b326eeddaadf0 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2664,6 +2664,7 @@ static int btusb_mtk_submit_wmt_recv_urb(struct hci_dev *hdev)
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf) {
 		kfree(dr);
+		usb_free_urb(urb);
 		return -ENOMEM;
 	}
 
-- 
2.25.1


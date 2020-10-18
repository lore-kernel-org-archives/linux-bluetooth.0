Return-Path: <SRS0=T6Hm=DZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF95CC43457
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Oct 2020 19:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD1722268
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Oct 2020 19:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603050945;
	bh=DdVhnljRUtl+cIhvvuIZwihVhPauS9K7dhmPnfcjnRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JJTxCACHx3hYemJtqexRfVXeKgWmJc8kOp22woyD8Np92Eur+sJVDq/WCvnNl7AMN
	 6acbBbXX5ePrEsm/2cH2pTW7s3D2lDOFa4/A8oT2A2NycUJrk1bMFgkAqm4MEaUZir
	 OiYAm7mghXQa2GctbGznLAfcaTeONN0NocgPXuL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbgJRTze (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbgJRTT5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Oct 2020 15:19:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADC3A22363;
        Sun, 18 Oct 2020 19:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603048797;
        bh=DdVhnljRUtl+cIhvvuIZwihVhPauS9K7dhmPnfcjnRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJOsGVq25jRowDeKnejl4yJxhf2XLGIP72xiQmp4uMYUIFn2avmypss/RyFSp/4Xo
         wVvo0ZYgYywYILruJLaUCVgbYmxZtbNVf5wP8i+075oP6Mt/V6MCQcGNFp33EUEEIw
         WvS7u2JKANyl1d/hZ9iW9sR8UJXL6MuBwdFh+7JE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 091/111] Bluetooth: btusb: Fix memleak in btusb_mtk_submit_wmt_recv_urb
Date:   Sun, 18 Oct 2020 15:17:47 -0400
Message-Id: <20201018191807.4052726-91-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018191807.4052726-1-sashal@kernel.org>
References: <20201018191807.4052726-1-sashal@kernel.org>
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
index 8d2608ddfd087..f88968bcdd6a8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2896,6 +2896,7 @@ static int btusb_mtk_submit_wmt_recv_urb(struct hci_dev *hdev)
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf) {
 		kfree(dr);
+		usb_free_urb(urb);
 		return -ENOMEM;
 	}
 
-- 
2.25.1


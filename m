Return-Path: <SRS0=5gFq=DX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918F0C43467
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 13:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C0720874
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 13:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5961oYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407213AbgJPNQB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407176AbgJPNQA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Oct 2020 09:16:00 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90033C061755;
        Fri, 16 Oct 2020 06:16:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so1252036pll.11;
        Fri, 16 Oct 2020 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywZMHMoa9Z2/Mz63aoLeLWbP5S3RUkcpUs/A8T6Yyeg=;
        b=D5961oYoWjrbxsHHTMOeZKBQ/TRF4he+KTOpPZPu0q9sMdCFZxI2NJkuWh8DjpTdbK
         Nb5w+7ClTeSeXk/73DZv3Ng3yS/dPJntdavYpMrP62XQwzAJ/WvlX3XPyEh4iQC9M4am
         HQYBvBfJdwdGYHfnKJC+NGj3FTpdC+uZeSFePGF/Wl6IWdZEJb96qzzH1Qtwg+DHQJvF
         TwjoIySOE2x9Oz2SP9vf2lY8iBBGmGzkfyv+wQoKccbgN43y38sFaZc57A7hWtvqoe3D
         Lfjjml5Pr8c3prYFdzy8gGZAxg1b5pQI1P1L3eCV+MGlQQ5YvmRlY1bGRrGAqgwcQFoc
         B7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywZMHMoa9Z2/Mz63aoLeLWbP5S3RUkcpUs/A8T6Yyeg=;
        b=G0+GT8vS2Z7ZWmrIsk1ZbKckM9DkKQ5d9BQ3voQ9grNYa+Vz4BHIVuwrMAQ79MIaRv
         2TiONfu9AC/qHkyDE8AQwWFcqhCwyvASGW7mI4lH20/BSJ2V1jitirHHW2iHtVQ2JfRA
         h422goSMp3xva2B3HDB4KC1Rr5ubk04oa8HlRGmgVXf1HVnh/WzMY909Usbv7DsaxIul
         nM6x1Rartg3kMCGvh7Co7iVhNvKDIrA+L5dVnETfjl76Q+AyVagfNEVKztMKY6YCqAFX
         u2Xuqy2EFD77boUKoA4M0R3v2W3hwnngLoyuS2IOJHCYusft7+6qyuerMgPlL9Rl/FX/
         0F9g==
X-Gm-Message-State: AOAM533hkplphf1BqfBBbpYfjFGVRYmpBgnChzPlTqrQrjSQqGEV1hV9
        o7l8pDtZFM/pfC22Brs3W7E=
X-Google-Smtp-Source: ABdhPJzZiFySSHjmf9JkgTm5CVtdFe+1MqqCGZN0AwBdYN0l1fJfu9gdvZmcESsUknwi1zG7/fqlYA==
X-Received: by 2002:a17:902:c254:b029:d4:c2d4:15f with SMTP id 20-20020a170902c254b02900d4c2d4015fmr4055633plg.18.1602854159966;
        Fri, 16 Oct 2020 06:15:59 -0700 (PDT)
Received: from localhost.localdomain ([49.207.207.75])
        by smtp.gmail.com with ESMTPSA id q8sm2988144pfl.100.2020.10.16.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 06:15:59 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
Subject: [PATCH v5] bluetooth: hci_h5: fix memory leak in h5_close
Date:   Fri, 16 Oct 2020 18:44:47 +0530
Message-Id: <20201016131447.32107-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When h5_close() is called, h5 is directly freed when !hu->serdev.
However, h5->rx_skb is not freed, which causes a memory leak.

Freeing h5->rx_skb and setting it to NULL, fixes this memory leak.

Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
Changes in v5:
	* Set h5->rx_skb = NULL unconditionally - to improve code
	  readability
	* Update commit message accordingly

Changes in v4:
	* Free h5->rx_skb even when hu->serdev
	(Suggested by Hans de Goede <hdegoede@redhat.com>)
	* If hu->serdev, then assign h5->rx_skb = NULL

Changes in v3:
	* Free h5->rx_skb when !hu->serdev, and fix the memory leak
	* Do not incorrectly and unnecessarily call serdev_device_close()

Changes in v2:
	* Fixed the Fixes tag


 drivers/bluetooth/hci_h5.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index e41854e0d79a..0ef253136b06 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -245,6 +245,9 @@ static int h5_close(struct hci_uart *hu)
 	skb_queue_purge(&h5->rel);
 	skb_queue_purge(&h5->unrel);
 
+	kfree_skb(h5->rx_skb);
+	h5->rx_skb = NULL;
+
 	if (h5->vnd && h5->vnd->close)
 		h5->vnd->close(h5);
 
-- 
2.25.1


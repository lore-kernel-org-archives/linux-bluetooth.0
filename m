Return-Path: <SRS0=nDLV=Y7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE463C5DF61
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 09:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7489B214D8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 09:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tFeI+bI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfKGJqP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:46:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35691 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGJqO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Nov 2019 04:46:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id p2so2260886wro.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Nov 2019 01:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EYdHQ/UO27K++cZW9zQuGji5xNvlsvTd2fpe7ujHCIY=;
        b=tFeI+bI82f7A9CpRrm9gCaaLcV7L2rzG0cOBj47LsplQyzscDWZ3uSLmVVhWH5Ll/l
         RJcMzMHrmLR+NhhG5jy+j6QjSH5iqcUjFJr+m34ITo3AtN4W/0mMXab9iywV2TSwnVJm
         4fi8CMpuw3leDD1mdEP8zY6PvqvgXP9UAYbQ1VKb+5KwJtbHQe+ShVBdOHZtjg2EU984
         YoTOK6R2M/Jfjqzg1PULRDczEaDkzOe/PyLGA3BXMTShRJybE++WeCLiXu0jHXYyfiF9
         Dnt9h7jgQzXBV6HK1JsB6bcryzs8ANOWZJCdw73JfF2yrIR5ulTaBfuWTTq1MidZQcjR
         RQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EYdHQ/UO27K++cZW9zQuGji5xNvlsvTd2fpe7ujHCIY=;
        b=ZMDjhuISZO8VdTzq9lTz919608hUVwMP90kyRrypJRJeju5mNvMaZ8KjygX8Nac8RI
         /LkfmT8Nidxf0YgLbUfi4QNypK8nfOs7wUfBKfJa7JfxpzsU1KIuGfSLjer/xMvmS/2C
         521ZqH7bjCGadBG3xRUSR3TxeqTg20I1gmTPpJrbGeX1IvRxDznF1YxR3kAOhDNaEDiC
         Xep35aNucKg37ffk/Lh+p8TCZJLfcFVfIaY001cJPMKwLo3t0iFInwPywte5Zp/G/5DD
         ckRJLJfHb7AkbTMNF+9Q6OUXqsvo1wzS3V64Ja19NCBKu4LMjMh8vPPc4WOnQi3N8eP/
         9PTg==
X-Gm-Message-State: APjAAAXSnTiG4a5L5Byh53u6D3srQnW37hguxZbSkchLQ1Dtw1vAZ93C
        Xelrg6UDfxmnXi9UZoxTlhCnaQ==
X-Google-Smtp-Source: APXvYqx6uFZ7ophY/dHYBLgpfGDu/hW16RYAXW1k4gUoFsC70OQxNUBqA9m6WSaXBdxp1jtieD8bSg==
X-Received: by 2002:a5d:4808:: with SMTP id l8mr1912912wrq.118.1573119972703;
        Thu, 07 Nov 2019 01:46:12 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id j14sm1917896wrj.35.2019.11.07.01.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 01:46:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] bluetooth: btmtksdio: add MODULE_DEVICE_TABLE()
Date:   Thu,  7 Nov 2019 10:46:10 +0100
Message-Id: <20191107094610.22132-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This adds the missing MODULE_DEVICE_TABLE() for SDIO IDs. While certain
platforms using this driver indeed have HW issues causing problems if
the module is loaded too early - this should be handled from user-space
by blacklisting it or delaying the loading.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/bluetooth/btmtksdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 813338288453..519788c442ca 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -57,6 +57,7 @@ static const struct sdio_device_id btmtksdio_table[] = {
 	 .driver_data = (kernel_ulong_t)&mt7668_data },
 	{ }	/* Terminating entry */
 };
+MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 
 #define MTK_REG_CHLPCR		0x4	/* W1S */
 #define C_INT_EN_SET		BIT(0)
-- 
2.23.0


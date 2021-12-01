Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96730C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 20:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352820AbhLAUT0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 15:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352763AbhLAURe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 15:17:34 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC648C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 12:14:03 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id v15so50599537ljc.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 12:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cm/LOgLyBHKAfjqechOv4aUVLu/lBrZhgrgfeAG5yYo=;
        b=fwEyewYur5etSp2FpL23q166Zxo/52wGLeItiLpnYKKIEI858vqpTANucPYAH3vXMn
         F2EJNFiqfRkM/cBZpB73BNMWsNecOfeKKv6xpobMrWm03XeDZ/drZzf2cxE/xzXNT2v3
         2xjvFop0AVhHAF8nkpPjaB1M/HeMkVxdkzQguOtyqaTl0VL4AkDfyH5U/UMOINph9A2a
         +Z04PdnBMK2KObVwXh2lH0bgw8ttHbddrFTRhroCovx5ZaPuEdNnnLetAm0zjuJlRhUC
         EPh1PjcCJw1NBjU8coV44cNv39c/YMeYTihhuUDhfwGuF+Tsghs4DIltrdiuiuZOBZzd
         MzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cm/LOgLyBHKAfjqechOv4aUVLu/lBrZhgrgfeAG5yYo=;
        b=mKIRlKul0FfqEToC4ZXS1yEWB4mwCZ0qUMAZ1MI7SrtdF3zmAD+9ag8vL7KvcGCDWY
         CyEYuoKtaUjd2KfYoRGdl1UFjlYbpu4P+Uv4BVLsLy6xVQPVVnH9Enhj9clKyt0tRF55
         KGHozfL5AB7kBKwqdAWNLFU2wBe7aCrteAY/S+q+g2uZ1laGFDtofR2uAdSkwLCkdsMr
         9KKlwRhl/Oj3I9sjBzvlod3R/ENC4GJ5DkCxhiUoh0pmUdUe0yHL5Mwl5llmYw8Ng+GR
         yBChslxQmRcKsXNEybSoYzMgbXPegfP4KHLmRyhchInAR0MpGzQM4y3upauTtQXgYzdE
         Onfw==
X-Gm-Message-State: AOAM533hXw5CylTbFc4CxmWbV/x3osd+4vUuVWduqM6KHNIuTAqsOGhY
        ujGL72c5rYXzpdVE7BO0yqFQ
X-Google-Smtp-Source: ABdhPJwh7kUWJI3j+dt7aVBYHbMLal6jtWKJqNYOZ4M5lBHwJFT3jmirtgmKTGx4fzYCylglSD3stA==
X-Received: by 2002:a2e:3e17:: with SMTP id l23mr7025336lja.380.1638389642146;
        Wed, 01 Dec 2021 12:14:02 -0800 (PST)
Received: from localhost.localdomain (public-gprs378549.centertel.pl. [37.47.109.246])
        by smtp.gmail.com with ESMTPSA id i3sm86821lfu.156.2021.12.01.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:14:01 -0800 (PST)
From:   Lukasz Bartosik <lb@semihalf.com>
X-Google-Original-From: Lukasz Bartosik <lukasz.bartosik@semihalf.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: [PATCH v2] Bluetooth: btmtksdio: enable msft opcode
Date:   Wed,  1 Dec 2021 21:13:51 +0100
Message-Id: <20211201201351.2552-1-lukasz.bartosik@semihalf.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Łukasz Bartosik <lb@semihalf.com>

Enable msft opcode for mt7921 chip.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 drivers/bluetooth/btmtksdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 9bf5e70f47ad..6a7ba67a2dd1 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -787,6 +787,8 @@ static int mt79xx_setup(struct hci_dev *hdev, const char *fwname)
 		return err;
 	}
 
+	hci_set_msft_opcode(hdev, 0xFD30);
+
 	return err;
 }
 
-- 
2.34.0.rc2.393.gf8c9666880-goog


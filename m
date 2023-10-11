Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D040ACDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 21:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjJKVQm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbjJKVQl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 17:16:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ECBA9
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 14:16:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d918aef0d0dso363473276.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 14:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697058998; x=1697663798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AkMbkjU0vEq64RoxC9mx2kutRLIWzBPilt+kMErOBXk=;
        b=viwZ6khh+pCy12HXp+3i4C2faf8ibwIfdTcWmQp9SYSsN1/Og84W5amWj/g/L+6Xxp
         Jhz/bvk+NqhIHvb13OiY+MCvx/yLnAUdvWVe1oKQQdnPITCmJcCGrnQuQNOcXkxTJd0x
         mpOg2HZjEuz9xUsh/PwD1IIKzEm54xgZDzXfa4uEuUzmTNLf8e7ApnEA72oJVJVieU63
         GHdyFgPk+J87teZ4yIBUQjNdkXVsFMwbb+tMgBbWWg7aWTEcveut7KLxqnb8sdA84OgL
         +Mvz7rOnFau1cjNwdeW8VEioeObD0cwri3E/vs1c8Q6ICaM/uvoz9JuJs6JMzXD3xPHY
         O7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697058998; x=1697663798;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkMbkjU0vEq64RoxC9mx2kutRLIWzBPilt+kMErOBXk=;
        b=s3nddhwdsQvhL56ARUL4K7WegGlKWbX/EeAldhKl4Q1o85SaxNIiuhFCE3jgHMqLmm
         /B8cfQgEWAtsgmkrL6Y/lAk+arJOzHlFagfwzjragKYf7Oi9AIOuQaKxoLBJ5a9Z3zxr
         W2e2W1sj05n04WUawBBvXcrOpWybEsOgOV9dZASefLM2jJ2w6qBrGnMLneyg52Xg119M
         eHx2OS7yrdgfGtU6v8ZwcC3EpJV1EnLCghO3DY4lKsrL1o5LQsahdxZzP2/kKXivul1m
         wz9oymC8RDG2nRIe5nJXX12GuHnh7ge9kmn0CVvs8VIEg9LU7fo/ziXyercZo09T2pOm
         vioA==
X-Gm-Message-State: AOJu0Yw8r5Ke0jIiv0ZbCC+nWgWnpZEr+quWNIl23EADW16MKW7xGmRj
        vy9VhgL86m1yexjOzuLrPClhrensqIk64g7Nlu1Tggjw2BJ/lzQhs2X+pkIX+UqjnhNLcnmCJk1
        c20UxmK+c0OqqB7m1t1hqw+9CZLcSg64iQZ2n9fJ5at1ng1Kxa+eIjC0lHv0G14IFRB95jwKHYa
        9W
X-Google-Smtp-Source: AGHT+IGAzhuTPA8xuaGd0/MIYrNSNCXikipR4gkbaclFwt1ULUI/01TDo30ZPmFJEvB4ZjHJwjhJuCAIPgXw
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:38e4])
 (user=jiangzp job=sendgmr) by 2002:a25:828c:0:b0:d9a:bc5a:737c with SMTP id
 r12-20020a25828c000000b00d9abc5a737cmr10169ybk.4.1697058998406; Wed, 11 Oct
 2023 14:16:38 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:16:31 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231011141631.kernel.v1.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc@changeid>
Subject: [kernel PATCH v1] btmtksdio: enable bluetooth wakeup in system suspend
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The BTMTKSDIO_BT_WAKE_ENABLED flag is set for bluetooth interrupt
during system suspend and increases wakeup count for bluetooth event.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Add BTMTKSDIO_BT_WAKE_ENABLED flag
- Call pm_wakeup_event in btmtksdio_interrupt

 drivers/bluetooth/btmtksdio.c | 36 +++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index f9a3444753c2..ddc04ce5c6d4 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -118,6 +118,7 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 #define BTMTKSDIO_FUNC_ENABLED		3
 #define BTMTKSDIO_PATCH_ENABLED		4
 #define BTMTKSDIO_HW_RESET_ACTIVE	5
+#define BTMTKSDIO_BT_WAKE_ENABLED	6
 
 struct mtkbtsdio_hdr {
 	__le16	len;
@@ -620,6 +621,12 @@ static void btmtksdio_interrupt(struct sdio_func *func)
 {
 	struct btmtksdio_dev *bdev = sdio_get_drvdata(func);
 
+	if (test_bit(BTMTKSDIO_BT_WAKE_ENABLED, &bdev->tx_state)) {
+		if (bdev->hdev->suspended)
+			pm_wakeup_event(bdev->dev, 0);
+		clear_bit(BTMTKSDIO_BT_WAKE_ENABLED, &bdev->tx_state);
+	}
+
 	/* Disable interrupt */
 	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, 0);
 
@@ -1454,6 +1461,23 @@ static int btmtksdio_runtime_suspend(struct device *dev)
 	return err;
 }
 
+static int btmtksdio_system_suspend(struct device *dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(dev);
+	struct btmtksdio_dev *bdev;
+
+	bdev = sdio_get_drvdata(func);
+	if (!bdev)
+		return 0;
+
+	if (!test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
+		return 0;
+
+	set_bit(BTMTKSDIO_BT_WAKE_ENABLED, &bdev->tx_state);
+
+	return btmtksdio_runtime_suspend(dev);
+}
+
 static int btmtksdio_runtime_resume(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
@@ -1474,8 +1498,16 @@ static int btmtksdio_runtime_resume(struct device *dev)
 	return err;
 }
 
-static UNIVERSAL_DEV_PM_OPS(btmtksdio_pm_ops, btmtksdio_runtime_suspend,
-			    btmtksdio_runtime_resume, NULL);
+static int btmtksdio_system_resume(struct device *dev)
+{
+	return btmtksdio_runtime_resume(dev);
+}
+
+const struct dev_pm_ops __maybe_unused btmtksdio_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(btmtksdio_system_suspend, btmtksdio_system_resume)
+	SET_RUNTIME_PM_OPS(btmtksdio_runtime_suspend, btmtksdio_runtime_resume, NULL)
+};
+
 #define BTMTKSDIO_PM_OPS (&btmtksdio_pm_ops)
 #else	/* CONFIG_PM */
 #define BTMTKSDIO_PM_OPS NULL
-- 
2.42.0.609.gbb76f46606-goog


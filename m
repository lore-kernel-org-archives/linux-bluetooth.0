Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C556ECDB483
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 22:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjJKWjm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjJKWjl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 18:39:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231F4B8
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 15:39:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a21c283542so5379147b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697063974; x=1697668774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=szUp3IgWTq4iCJ08BNtxTyUlyqhJt469/BAgPtCRvbI=;
        b=tz2kkrAMJrWEcNdZJ8UJ4VR8v1bAT+PuzGh51gdgEYJKxFWXDTRhR5YL5PgqBJI8Xx
         pikvCJi+MnNO8Kv/E9CW/ko0N12lSXlee5TBj0T2zm9YaxRZclr3605VlLCMx79tvORQ
         nhOU1+YHHtru4WNSSjtrBpCsjsp0KxALEF5HQOdft3id4aLi3zAJXdckiZDojV2AAVNT
         Vur9VoG4MxJnto30HAXMIAt5eVnGd38u2GELO4ShC7a8b3Ldu3C+CmJ0fQywA01fwaOk
         qhASTx+poasdLMNw2Q5Dcm29LUvQaJbC4/qlIp3THFxg+SyIIb8g+Syn/4Du6uMpDHyJ
         LDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697063974; x=1697668774;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szUp3IgWTq4iCJ08BNtxTyUlyqhJt469/BAgPtCRvbI=;
        b=uyWoQwYWIFNckB4rFIwjMWpLoadkfkgv+QwRbbDOzJW501IZsco91u+lxryBbhGCSQ
         hHFMUpDctECIMDRe3jdKFkipcqSTolbAtwCqMPw2PhAZ+7XjFmGMhiZOaHydgYYu8KG5
         yn0DzfMUXu3DoCkZdn26BNE37eftiiI9unyrzspa3I/S01ZvpDBi9ajtx2qdJvmIpC+e
         JdB9d5K5OPl19+qCS1ZnQY1m3++6viXlMtfMFkM8HxBl7ogAtoexdBw1GOq0RvcOPu6Z
         YXxBN0HvMt5H+MAH2h/n3TqmknZjZt2E53p/MeYPqohOi0TZw9aAW5pNhTMoqfnPBArM
         4kcQ==
X-Gm-Message-State: AOJu0YzLDyUEYON9SlA1hrWZ5Ms470sCY/W8FbIqWMRPW6gfPuMXog+E
        9SinXtxy4bx96itWLvGO18yPOtM9f1h5Gnn8JzqCMYn0XsHC0omHvbiJXeW7VHksPuNNP/xTWyU
        qC3T3xYqVMl550Pr37P0EQUfEXQSKspnvQLITfgk6peBEs5FJDCcb3dQ9CQP5oY/sb/oPKOtsZF
        NB
X-Google-Smtp-Source: AGHT+IHm0+BwtpxvlDs0EJwWZDp2C+XyFuA9xw6fgoMpcHbgvM2/ri5l0LiHHVPLimN54DRYZEolelves5tp
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:38e4])
 (user=jiangzp job=sendgmr) by 2002:a81:aa4d:0:b0:59f:3cde:b33a with SMTP id
 z13-20020a81aa4d000000b0059f3cdeb33amr416465ywk.6.1697063974245; Wed, 11 Oct
 2023 15:39:34 -0700 (PDT)
Date:   Wed, 11 Oct 2023 15:39:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231011153928.kernel.v2.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc@changeid>
Subject: [kernel PATCH v2] Bluetooth: btmtksdio: enable bluetooth wakeup in
 system suspend
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

Changes in v2:
- Add Bluetooth prefix to patch subject
- Fix warnings regarding using plain integer as NULL
- Add static to btmtksdio_pm_ops

Changes in v1:
- Add BTMTKSDIO_BT_WAKE_ENABLED flag
- Call pm_wakeup_event in btmtksdio_interrupt

 drivers/bluetooth/btmtksdio.c | 44 ++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index f9a3444753c2..404105e69c67 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -118,6 +118,7 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 #define BTMTKSDIO_FUNC_ENABLED		3
 #define BTMTKSDIO_PATCH_ENABLED		4
 #define BTMTKSDIO_HW_RESET_ACTIVE	5
+#define BTMTKSDIO_BT_WAKE_ENABLED	6
 
 struct mtkbtsdio_hdr {
 	__le16	len;
@@ -554,7 +555,7 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	sdio_claim_host(bdev->func);
 
 	/* Disable interrupt */
-	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, 0);
+	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
 
 	txrx_timeout = jiffies + 5 * HZ;
 
@@ -576,7 +577,7 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 		if ((int_status & FW_MAILBOX_INT) &&
 		    bdev->data->chipid == 0x7921) {
 			sdio_writel(bdev->func, PH2DSM0R_DRIVER_OWN,
-				    MTK_REG_PH2DSM0R, 0);
+				    MTK_REG_PH2DSM0R, NULL);
 		}
 
 		if (int_status & FW_OWN_BACK_INT)
@@ -608,7 +609,7 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	} while (int_status || time_is_before_jiffies(txrx_timeout));
 
 	/* Enable interrupt */
-	sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, 0);
+	sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, NULL);
 
 	sdio_release_host(bdev->func);
 
@@ -620,8 +621,14 @@ static void btmtksdio_interrupt(struct sdio_func *func)
 {
 	struct btmtksdio_dev *bdev = sdio_get_drvdata(func);
 
+	if (test_bit(BTMTKSDIO_BT_WAKE_ENABLED, &bdev->tx_state)) {
+		if (bdev->hdev->suspended)
+			pm_wakeup_event(bdev->dev, 0);
+		clear_bit(BTMTKSDIO_BT_WAKE_ENABLED, &bdev->tx_state);
+	}
+
 	/* Disable interrupt */
-	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, 0);
+	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
 
 	schedule_work(&bdev->txrx_work);
 }
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
+static const struct dev_pm_ops __maybe_unused btmtksdio_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(btmtksdio_system_suspend, btmtksdio_system_resume)
+	SET_RUNTIME_PM_OPS(btmtksdio_runtime_suspend, btmtksdio_runtime_resume, NULL)
+};
+
 #define BTMTKSDIO_PM_OPS (&btmtksdio_pm_ops)
 #else	/* CONFIG_PM */
 #define BTMTKSDIO_PM_OPS NULL
-- 
2.42.0.609.gbb76f46606-goog


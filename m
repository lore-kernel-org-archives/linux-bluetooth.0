Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D43CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Oct 2023 19:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjJMTrQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Oct 2023 15:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJMTrP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Oct 2023 15:47:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69ACAD
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Oct 2023 12:47:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a824ef7a83so12765467b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Oct 2023 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697226433; x=1697831233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mHGY1rNgdssEAkSd/6ZBfSHP677hALKRsWOmZt1w4io=;
        b=DRS6nwCp6/z+zyQRKVbqZu8SC+ou3EPlvENHy6mmxjBNOfI2NnOuJ4HZdVR0y5i0L6
         HQylAqIDPtuE9NR+6Qdv41LTgFGKrczARY38jriQxyELAEVm4QxYQRPVipO/ypx3rr+c
         fk0c7vKRZKaiU1JW0nwAajr6bfGExqL+1uOYTChkdxeCmznqzj2mdBq7K1QCrnJybdCP
         HF8IsDUdE95kYB68H9Vl73WNrEOJ5A5BuhySej9q8YxrDEEdAxe/6VAiT+hBWND48S2H
         lrGglvz+Tr8ik9AbFJ6ryiNHlGQUoCzZeBYO5uc9yqwWs82UlJK2Z37XiWYXSI/euimQ
         OaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697226433; x=1697831233;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHGY1rNgdssEAkSd/6ZBfSHP677hALKRsWOmZt1w4io=;
        b=FfjRFsYO2BxBnEZGrPTt1u/30N5jEnVH7CPntQayatQgziwOLXfkvniTpBfXzSvUXg
         rJ6g1ezHzMD+SY9xJZ3WwBex5zT0Mn5tZQ7cu2Z6ObsFJPr+VXJy0rTCiiRAoaaZpXV3
         ffxm1ALibgsotC/ZZD53vof/DcK9h5BChDjxHYGjPjrqxnRQFzM91FbYV3bnAoGJzNTV
         6cn2kFR0AC9QCLXY4AatSxBHCOf7QcciiK/dbA+47bQadFptOLs+b0EZltJkGbKGHoyv
         cDIngpgLRTTt2NiXW/K3FCSY5Wc3IjJb3AIZu2ZkQgcL9HJN/guRjWnHEXOpl7qUDshr
         sZ3Q==
X-Gm-Message-State: AOJu0Yx3IX3Oy42avctRC2zOmSW0LkvJYFRy9c03DcwYrZ2bxrvJJYZg
        sk7+Rr+Bj5JS/M825oBbl8rXMpY3gp2MBrJZIPIIzUR2RydoNrXKZ8MUJ621HMoSnRHbwDekPz3
        CBplK3C/EeEL3V08fXS9iVbO754PyKHkZQmidPFLsaqg1XqiiWR82YYTHkLBvVyoKzhfsYrL5Ox
        hq
X-Google-Smtp-Source: AGHT+IHpmQg2Q8i1hn/xSsGU1Xlpm5F24a4h6RyCnX+WmtsHD+RkrppicP7DiSaF/ezg06qukkb3PlzMghkW
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:38e4])
 (user=jiangzp job=sendgmr) by 2002:a81:a84a:0:b0:59b:e97e:f7df with SMTP id
 f71-20020a81a84a000000b0059be97ef7dfmr537451ywh.2.1697226432947; Fri, 13 Oct
 2023 12:47:12 -0700 (PDT)
Date:   Fri, 13 Oct 2023 12:47:07 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231013124707.kernel.v3.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc@changeid>
Subject: [kernel PATCH v3] Bluetooth: btmtksdio: enable bluetooth wakeup in
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

Changes in v3:
- Replace deprecated macro.

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
index f9a3444753c2..ff4868c83cd8 100644
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
+static const struct dev_pm_ops btmtksdio_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(btmtksdio_system_suspend, btmtksdio_system_resume)
+	RUNTIME_PM_OPS(btmtksdio_runtime_suspend, btmtksdio_runtime_resume, NULL)
+};
+
 #define BTMTKSDIO_PM_OPS (&btmtksdio_pm_ops)
 #else	/* CONFIG_PM */
 #define BTMTKSDIO_PM_OPS NULL
-- 
2.42.0.655.g421f12c284-goog


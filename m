Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4BDC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 01:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC61206FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 01:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="byQoXdL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgFKByN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgFKByH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 21:54:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AF9C08C5C6
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 18:54:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so1704178pjd.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 18:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1X3ZX/iOwR/Uqfzsx2X/9AVb+bv3TKUHZzyCIU6EnHM=;
        b=byQoXdL9yUHiIdagQ/QkxkdVIIOdOM55WxCDdNr3/Xu+1inMXbhoEVAhu38ZZyoYSt
         mrhebQIUmr+EWcM577PZstHgA0MKAo9Yho38axOk/AAPQbtzUYm6PUCvsSqinCrEQUgx
         LEdJwoj1zqLe6bjhKXQ9Q8BCIGOutpDUq7apU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1X3ZX/iOwR/Uqfzsx2X/9AVb+bv3TKUHZzyCIU6EnHM=;
        b=aPCElUmpS8AhwyP+A/oQot702J5XgdH17CG3bvUWwhwsyz8jI95tamp+gPeuUjzc6b
         am8+5VVC6LJiBCPnuSgHVXfy4YVZJ1OzxX+SQ6Eu5mjaF+cxE+cD+bZR4bHhY/+w4RQC
         Bxh7fs52Y0ALp0J+0d4hdvqbTaXUnr+NjSCpg47OKLToyUpoXAtKKXLWdn3BZUWjsY/Y
         SmdzFMJlwaUk2ZLJU8M1QkbXiuKy2qtIfkN36bOsOvRiYOCJFTJMad367YxpMKeC9+gu
         XH5tnFIIDBE2bCUbTI2jM0kq8GY0Jfc5PXWFO4JxVRwnADMIFeZXyAwUtTmYnO/ti0Xx
         uFOA==
X-Gm-Message-State: AOAM532UayTuBnzVEZk/4boKkvi4twf9DdUQsvGFkjZdO/6PVqCOgije
        FSeAJyEgVaoQTtqgpW8GQyufqg==
X-Google-Smtp-Source: ABdhPJxww6szgbZ7bos55brDGgfFhu9RmKbp4hX7/6AFdIVAZUjqS8/AG1a9V5KiAsusG3waIK1W3A==
X-Received: by 2002:a17:90a:f3d6:: with SMTP id ha22mr5625289pjb.193.1591840446227;
        Wed, 10 Jun 2020 18:54:06 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id b191sm998661pga.13.2020.06.10.18.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 18:54:05 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtman.org, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        mka@chromium.org, dianders@chromium.org, linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: btmrvl_sdio: Refactor irq wakeup
Date:   Wed, 10 Jun 2020 18:53:55 -0700
Message-Id: <20200610185214.3.If7946e7127c13a422d8c41d10dc8e6fe71396c8c@changeid>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200611015355.186666-1-abhishekpandit@chromium.org>
References: <20200611015355.186666-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use device_init_wakeup to allow the Bluetooth dev to wake the system
from suspend. Currently, the device can wake the system but no
power/wakeup entry is created in sysfs to allow userspace to disable
wakeup.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/bluetooth/btmrvl_sdio.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 4c7978cb1786fc..cfb9f9db44a0d9 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -111,6 +111,9 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 					"Failed to request irq_bt %d (%d)\n",
 					cfg->irq_bt, ret);
 			}
+
+			/* Configure wakeup (enabled by default) */
+			device_init_wakeup(dev, true);
 			disable_irq(cfg->irq_bt);
 		}
 	}
@@ -1654,6 +1657,7 @@ static void btmrvl_sdio_remove(struct sdio_func *func)
 							MODULE_SHUTDOWN_REQ);
 				btmrvl_sdio_disable_host_int(card);
 			}
+
 			BT_DBG("unregister dev");
 			card->priv->surprise_removed = true;
 			btmrvl_sdio_unregister_dev(card);
@@ -1690,7 +1694,8 @@ static int btmrvl_sdio_suspend(struct device *dev)
 	}
 
 	/* Enable platform specific wakeup interrupt */
-	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0) {
+	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0 &&
+	    device_may_wakeup(dev)) {
 		card->plt_wake_cfg->wake_by_bt = false;
 		enable_irq(card->plt_wake_cfg->irq_bt);
 		enable_irq_wake(card->plt_wake_cfg->irq_bt);
@@ -1707,7 +1712,8 @@ static int btmrvl_sdio_suspend(struct device *dev)
 			BT_ERR("HS not activated, suspend failed!");
 			/* Disable platform specific wakeup interrupt */
 			if (card->plt_wake_cfg &&
-			    card->plt_wake_cfg->irq_bt >= 0) {
+			    card->plt_wake_cfg->irq_bt >= 0 &&
+			    device_may_wakeup(dev)) {
 				disable_irq_wake(card->plt_wake_cfg->irq_bt);
 				disable_irq(card->plt_wake_cfg->irq_bt);
 			}
@@ -1767,7 +1773,8 @@ static int btmrvl_sdio_resume(struct device *dev)
 	hci_resume_dev(hcidev);
 
 	/* Disable platform specific wakeup interrupt */
-	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0) {
+	if (card->plt_wake_cfg && card->plt_wake_cfg->irq_bt >= 0 &&
+	    device_may_wakeup(dev)) {
 		disable_irq_wake(card->plt_wake_cfg->irq_bt);
 		disable_irq(card->plt_wake_cfg->irq_bt);
 		if (card->plt_wake_cfg->wake_by_bt)
-- 
2.27.0.278.ge193c7cf3a9-goog


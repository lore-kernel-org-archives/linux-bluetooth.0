Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB524C07E9A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 07:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86CC9613B2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 07:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbhGNHQs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 03:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbhGNHQs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 03:16:48 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674AFC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 00:13:57 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id a6-20020a63e4060000b02902272a0052cdso865944pgi.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 00:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4VkQ1Iiul9IdyOdh2D5ZbpYEPyiXApvR1eCAJNvVrsM=;
        b=dxNkLIPensbh7CpTTLhNxTKlMxa+tVRgW2IpfGuC2M0ke9N83F29aMXYvdgT++ZeKf
         lPupsD+yhcXH83PTMl4NaZTdABK6AVCx2vXKVL0+2ZgfKsHQZiwYXLwx7Oik0k6QEj8T
         QV8hDr8qAXLW0XQRgBl2/G606qPuLXe8B6cjBtpo1DzEu2RmMxFgJ3UsvMwTFd7gutlv
         0lalDf1wwfId21Pqcka2HuExBj6t0RpqFNRSLn9cVikoPQrhdID8PPPXgFKpggfGwOK4
         TQ4xQ1Zzdu4jpj4SfHkybrYW51juhWWRtgm4R7k5dW1zghvnKg0GDMrbN3D8EWMsWgsr
         6jJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4VkQ1Iiul9IdyOdh2D5ZbpYEPyiXApvR1eCAJNvVrsM=;
        b=lVfn44uc+2C/QL4fQSvjGTM6W0fESCJAOaAkuqB25mYUAewT1adsPBIXlaw26lU8hX
         z7lRu1gQeyMwkEaJcGkiveVhv6nbZ3mrkqt99jMlVlSmdZ03HNiPFa+Ewbrxwr1ytDYQ
         7dfkgAlgJtNsYV9v5bU3ZhUD/GTktGwkbJMdoet/ov3sbdj2kDCk8ZQNRbjLCon1Zuq/
         HY3BtwopoZreu9wsWg1e1uL9Ph6w3xw5/mvvOsCdzJ61LJ6Ev0+Q2cXxyqCZrQ/McGJ2
         yCXSFzkrdff5EXhBtW1YVPqg+mDnoRHqnJi9QrHXUDa0h7VKUyPtRRdhEW52pk/LKCFR
         oH5w==
X-Gm-Message-State: AOAM532ciwJxk2M8oLPp7GrgRl73pfjNBHlOGIlmX+pqOoVP/k1spu3u
        M6Npfr6MymuyQs7MNV2e3tssRfXXcln58IoOhS7HRsLR/Fs3CbGNij1bJfbMclD1vi+zpT4JpEY
        im4jIV8r42lA4N+c4G2xLjw4AsPfI5Jlihwv2l8mVSjWnXuT4oa2GVeJCpsMwX6pW6iGu9rHyib
        Tu
X-Google-Smtp-Source: ABdhPJx4joST/q+l0Tth0jRspoxkgMhbzuHImZ6dAlxfN1Ug6/UIMqXCbd5quC1pkIjexHXeIAe2JqP0C20E
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:ecf5:ef03:eb15:e989])
 (user=apusaka job=sendgmr) by 2002:a17:90a:a393:: with SMTP id
 x19mr289600pjp.1.1626246836513; Wed, 14 Jul 2021 00:13:56 -0700 (PDT)
Date:   Wed, 14 Jul 2021 15:13:40 +0800
In-Reply-To: <20210714151332.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Message-Id: <20210714151332.3.I4b323d2adf1dca62777c41de344a7d2f79b7f908@changeid>
Mime-Version: 1.0
References: <20210714151332.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 3/3] Bluetooth: hci_h5: Add runtime suspend
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This patch allows the controller to suspend after a short period of
inactivity.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Hilda Wu <hildawu@realtek.com>

---

 drivers/bluetooth/hci_h5.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 67fcf192d5c5..41039cadd6f8 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
+#include <linux/pm_runtime.h>
 #include <linux/of_device.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
@@ -21,6 +22,8 @@
 #include "btrtl.h"
 #include "hci_uart.h"
 
+#define SUSPEND_TIMEOUT_MS	6000
+
 #define HCI_3WIRE_ACK_PKT	0
 #define HCI_3WIRE_LINK_PKT	15
 
@@ -584,6 +587,10 @@ static int h5_recv(struct hci_uart *hu, const void *data, int count)
 		count -= processed;
 	}
 
+	pm_runtime_get(&hu->serdev->dev);
+	pm_runtime_mark_last_busy(&hu->serdev->dev);
+	pm_runtime_put_autosuspend(&hu->serdev->dev);
+
 	return 0;
 }
 
@@ -620,6 +627,10 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		break;
 	}
 
+	pm_runtime_get_sync(&hu->serdev->dev);
+	pm_runtime_mark_last_busy(&hu->serdev->dev);
+	pm_runtime_put_autosuspend(&hu->serdev->dev);
+
 	return 0;
 }
 
@@ -954,6 +965,12 @@ static void h5_btrtl_open(struct h5 *h5)
 	serdev_device_set_parity(h5->hu->serdev, SERDEV_PARITY_EVEN);
 	serdev_device_set_baudrate(h5->hu->serdev, 115200);
 
+	pm_runtime_set_active(&h5->hu->serdev->dev);
+	pm_runtime_use_autosuspend(&h5->hu->serdev->dev);
+	pm_runtime_set_autosuspend_delay(&h5->hu->serdev->dev,
+					 SUSPEND_TIMEOUT_MS);
+	pm_runtime_enable(&h5->hu->serdev->dev);
+
 	/* The controller needs up to 500ms to wakeup */
 	gpiod_set_value_cansleep(h5->enable_gpio, 1);
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
@@ -962,6 +979,8 @@ static void h5_btrtl_open(struct h5 *h5)
 
 static void h5_btrtl_close(struct h5 *h5)
 {
+	pm_runtime_disable(&h5->hu->serdev->dev);
+
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
 	gpiod_set_value_cansleep(h5->enable_gpio, 0);
 }
@@ -1069,6 +1088,7 @@ MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
 
 static const struct dev_pm_ops h5_serdev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
+	SET_RUNTIME_PM_OPS(h5_serdev_suspend, h5_serdev_resume, NULL)
 };
 
 static const struct of_device_id rtl_bluetooth_of_match[] = {
-- 
2.32.0.93.g670b81a890-goog


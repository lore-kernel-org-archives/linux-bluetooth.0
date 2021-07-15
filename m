Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A22C07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 14:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1564E613D1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 14:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbhGOOzK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Jul 2021 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbhGOOzK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Jul 2021 10:55:10 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47246C06175F
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jul 2021 07:52:17 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id v16-20020a05622a0150b029025a2609eb04so4263711qtw.17
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jul 2021 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QKhwAp39hW3ocoCF4aqrDutBWf5OOZ3fiizl2xE7StM=;
        b=ou1UBuj08Z5EqeU3Hlm6zqcnhXaOCJzYPApeTlA42TdireB/FK0ykv2krZXzFyhn7+
         Rlh0rYNwzc+wlvdrFjtnDK7Gg1Uu0oIuxVaieECO4drELEvfB2+miH7/Bn+rJ+7TCqep
         RZuEMAsk+kN6Rd8za0fnyLe6IdVz594NrZJ8ZXtbQ/UF8wKct3aG/vv7jpntnQtjsSwq
         /jqH6pj1un97POXkh80co5DfUN/mNYg/UNV8KkrVMzS7KtN5+ruLVBX8b3VzMfUg07qk
         xADhBnLoK2liqXIIorDHve19cY+nxrtOAvulmA3scOdwVFKaJ1AErpVZGAyXT8s9ADgC
         T/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QKhwAp39hW3ocoCF4aqrDutBWf5OOZ3fiizl2xE7StM=;
        b=X9h4LoRo9AnMkK7eZ1HU74BM/gBJBlcWoDWlzh1qtuvt0wFdSPIzOuiztvSBA9CESx
         hEwj+9+hZ0jYmfu04cHvvDEkvRPEDi+UvUti1nSPfK7V4tOHwekwqwSOJiqz0w3FFt8R
         ko69DhCT0xxlCDt9hfxr6orqInz4qQT9tkLsGMvCDlh5NSzx9xQGYQXiP4P5pnH4eHys
         ncvfXrYugOd0WjrdkZwWWI7KsrHxOgOdMcV3TtFhzBqK5sXOCpiw+rguoaZ0qZPluece
         S37tQ7qXBFHANJiMXStKsSJZcMCUU1w5wpUBpnuqGeb1ncNbepioRTFLJ7Tp3HOvncOv
         K51w==
X-Gm-Message-State: AOAM531/tTKLaJ2yupS+g7+1ptNEole0cSHNYfNdUu3eVwxux1yK/xYD
        AY3z4HYFFPldqnkz4OAVzGGMSloujNqFT5Gt/8GjswwRpyg0tWy8a5uoZA0I3sEflYUMT1CY2qm
        jA5nyByhjf9pvsqWuGjsY1Ci9+FaZeqDfuc4wE6kxB1vdQMdLUwWG7dneKEyjjl4ZpQ4DE26soo
        uO
X-Google-Smtp-Source: ABdhPJxWOh0bGdoMKCzBaF7LVBpQ3LHdUwc4SOxL2qxRSI/KBLA/4pzMiqNeAqQi79/DaNr08KibnOHM9TiH
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:d9e1:875d:57dd:2e32])
 (user=apusaka job=sendgmr) by 2002:a05:6214:4e2:: with SMTP id
 cl2mr4671805qvb.55.1626360735981; Thu, 15 Jul 2021 07:52:15 -0700 (PDT)
Date:   Thu, 15 Jul 2021 22:52:00 +0800
In-Reply-To: <20210715225146.v2.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Message-Id: <20210715225146.v2.3.I4b323d2adf1dca62777c41de344a7d2f79b7f908@changeid>
Mime-Version: 1.0
References: <20210715225146.v2.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 3/3] Bluetooth: hci_h5: Add runtime suspend
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

(no changes since v1)

 drivers/bluetooth/hci_h5.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index cbc63b057f33..f95ec9991180 100644
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
 
@@ -951,6 +962,12 @@ static void h5_btrtl_open(struct h5 *h5)
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
@@ -959,6 +976,8 @@ static void h5_btrtl_open(struct h5 *h5)
 
 static void h5_btrtl_close(struct h5 *h5)
 {
+	pm_runtime_disable(&h5->hu->serdev->dev);
+
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
 	gpiod_set_value_cansleep(h5->enable_gpio, 0);
 }
@@ -1066,6 +1085,7 @@ MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
 
 static const struct dev_pm_ops h5_serdev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
+	SET_RUNTIME_PM_OPS(h5_serdev_suspend, h5_serdev_resume, NULL)
 };
 
 static const struct of_device_id rtl_bluetooth_of_match[] = {
-- 
2.32.0.93.g670b81a890-goog


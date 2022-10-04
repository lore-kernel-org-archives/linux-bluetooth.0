Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3045C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 08:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJDIdN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 04:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJDIdK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 04:33:10 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC212B18A
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 01:33:09 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p12-20020a170902e74c00b00177f3be2825so9936306plf.17
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Oct 2022 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=mUw8UBadLiHi3J/pZlzSALpv6ewLMu8s9SQXK+Sa/QU=;
        b=OJ4t71dNLGl8TZgKvNooAVw9sze/VDQ4M+L7N7BHrpAPRsP49A2qBRtDwMPvWi89Tk
         ecoaPtFqBthqfpCLK/lKDYlLt44b8CYPJfzG6bmr4E0rJo0CO11LMbMMwJ2xcO+Nwsiy
         ML1ujtbNpcd95wfeKxckFUEC26cq1njyR8KpnhlMF7YskZTfsRo4FBdpCcli7Pi2Qk/m
         DW40OkFmkUF6HCVvRzSpNLuid3FJkbX8ZBGjELhGCQ5LZdDx/j3R+yuhTXKYZMuqFhQS
         D2pBtOPJXhzzwclGy2l94YumVWaaVcOVdyzHnhUU/SAnFCxQlKIh9VOxD/dPk6Z6EGkh
         sRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=mUw8UBadLiHi3J/pZlzSALpv6ewLMu8s9SQXK+Sa/QU=;
        b=dY3qLZwUTYBqJRXr1sshJtGk4dEdNMkvO3zVW1ejA05q2C0G6oBfN6BV2D4VIWryF0
         boo5l3kPnLY4kYULyB+ijcx6+wigCk5HaVJZ9f/5ZHsVzl4/XMYwa1G2S8Taa5+a19eu
         xqUm67K5WDHzC9IRajfDIBalcSUHrN32qaz4o/Qp5j7DZFGOKlOF+igIrEawQjURfRKu
         LzaT2bK3HmbIDbPLGVnoDnVRNWRU0I/+pqfxbQQn8esZ0AR8NftFcPYc7ViMVTrn9lSN
         mI+q4dZJO2Lqhc+hmOrjqASiEuKwcK7L7qnekewGvz2H6Xbm8U2bs0FhhqdN9CD3Nw8C
         AbNA==
X-Gm-Message-State: ACrzQf0BQWW0+zyjYfjXu1ezxa8H4sH4EAHb5tsUOmrf4eiKoUOwT5/R
        omilPrCB1oeAigvb/SFvaBULlGvV60hRzU7iaagTtiCZ7AhEWH9O6yn5kpBUL4X/JE4qC9ynIfy
        UCs1NVA5+aLSP9R2sDpfK1PjlNtOM67+sEuun6IRvYx3fEieUChtLE/eYMcTyL2LzjWgVFiz8s5
        in
X-Google-Smtp-Source: AMsMyM5huMghpuYio6zUoq3FwJTD9YdendfJWEgnilY/ykjUO/lpy44+gwvOp/rReo1Nje2YYzM8Deru1MIr
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:e06f:8778:ebde:592c])
 (user=apusaka job=sendgmr) by 2002:a63:1348:0:b0:440:5c6e:aedf with SMTP id
 8-20020a631348000000b004405c6eaedfmr20589308pgt.613.1664872389114; Tue, 04
 Oct 2022 01:33:09 -0700 (PDT)
Date:   Tue,  4 Oct 2022 16:32:34 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221004163224.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
Subject: [PATCH] Bluetooth: btusb: Introduce generic USB reset
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@google.com>,
        Ying Hsu <yinghsu@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

On cmd_timeout and there is no reset_gpio, reset the USB port as a
last resort.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
Reviewed-by: Ying Hsu <yinghsu@chromium.org>

---

 drivers/bluetooth/btusb.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 271963805a38..11040124ef79 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -696,6 +696,19 @@ struct btusb_data {
 	unsigned cmd_timeout_cnt;
 };
 
+static void generic_usb_reset(struct hci_dev *hdev, struct btusb_data *data)
+{
+	int err;
+
+	bt_dev_err(hdev, "Resetting usb device.");
+	/* This is not an unbalanced PM reference since the device will reset */
+	err = usb_autopm_get_interface(data->intf);
+	if (!err)
+		usb_queue_reset_device(data->intf);
+	else
+		bt_dev_err(hdev, "Failed usb_autopm_get_interface: %d", err);
+}
+
 static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -705,7 +718,7 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 		return;
 
 	if (!reset_gpio) {
-		bt_dev_err(hdev, "No way to reset. Ignoring and continuing");
+		generic_usb_reset(hdev, data);
 		return;
 	}
 
@@ -736,7 +749,7 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
 		return;
 
 	if (!reset_gpio) {
-		bt_dev_err(hdev, "No gpio to reset Realtek device, ignoring");
+		generic_usb_reset(hdev, data);
 		return;
 	}
 
@@ -761,7 +774,6 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct gpio_desc *reset_gpio = data->reset_gpio;
-	int err;
 
 	if (++data->cmd_timeout_cnt < 5)
 		return;
@@ -787,13 +799,7 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
 		return;
 	}
 
-	bt_dev_err(hdev, "Multiple cmd timeouts seen. Resetting usb device.");
-	/* This is not an unbalanced PM reference since the device will reset */
-	err = usb_autopm_get_interface(data->intf);
-	if (!err)
-		usb_queue_reset_device(data->intf);
-	else
-		bt_dev_err(hdev, "Failed usb_autopm_get_interface with %d", err);
+	generic_usb_reset(hdev, data);
 }
 
 static inline void btusb_free_frags(struct btusb_data *data)
-- 
2.38.0.rc1.362.ged0d419d3c-goog


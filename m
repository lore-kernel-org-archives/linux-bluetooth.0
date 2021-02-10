Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD5CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 19:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA6464E74
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 19:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhBJTTO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 14:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbhBJTSz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 14:18:55 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B45C06178A
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 11:18:15 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q72so1678121pjq.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 11:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=32LcXk/7PCDCZLUi1o4F0t61bLIAE9lCwzQ2hzrHujM=;
        b=BJtCNc8OphniqSfMrzJif9Op9NOXdLexGGZNECzvqLXXvoiO2AkV+D/yVLw0jUbSN+
         NLEgI46M5L9EuUEDlDg0F4MTswM1B5ouw1raw/+Kyg1LGMqcU+wvXKWGD0+uVuEtH0MK
         USsTRHUl90ZGxzQo7GSZVP76brnQ9ggmU84ZPWmlMAaPdo3/4blw8HMkFIgSxaWqdzfO
         HCcPjl4BFI33mKa1dsDiStCNV/kJ2/Yw/I21QwUC9MeGdA8XJygrwBdkMLdI1ZcRN+Dq
         tEVZtFF//bvEUAjD+w2OiNK2SZo1rx3qPEAhfgPTuOH+nwd9Rg1TJdcDFISwvdRzEbhp
         4iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32LcXk/7PCDCZLUi1o4F0t61bLIAE9lCwzQ2hzrHujM=;
        b=jGfTmMyUh1OZYNeVZTKyV7rA+6UsnnNC7CQLn62BKabX7j85r9A4taV5i/IssmtOpK
         mod4c0Jkxb/J10iBDBp53hODFRqXmItnEWSagL8S2fYqf6HoX+5iLElAATbrIXgkGvV6
         82oNc0XUatzmjk+tcvpnDG/O4yfmLJzqdeSPHl+3r28GjsVa2Ocrw3qZIzvbA22f751u
         UaZG88yXXKvdRdrnaZssmcO8qh7MLALa7HWNMS+RPpbTIR5PdOJrgbwHurh85yOzq539
         Fgqcwa8BZoXrYt8158Q58twCiS2g0HskI8tb5rAPBpf/pBOuYwpwcXCf1kMgD35OfcaE
         1iOw==
X-Gm-Message-State: AOAM530HwLoeHc42zArLOT8OwxhrrnVbaOd/r1bSkWUXMji+wEREpFJ+
        x0zrWueSyATxCshfOIlYpBDWMUGMqu2Hyg==
X-Google-Smtp-Source: ABdhPJy3OLw1nNc54X713DI7oldpg7dj619Hwi59KL/UVrnTtptYNFXmlSVPnvjK9dpdYYToZZnjcQ==
X-Received: by 2002:a17:90a:ce89:: with SMTP id g9mr423480pju.42.1612984694487;
        Wed, 10 Feb 2021 11:18:14 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 125sm2988822pfu.7.2021.02.10.11.18.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:18:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 5/6] Bluetooth: btusb: Consolidate code for waiting firmware download
Date:   Wed, 10 Feb 2021 11:18:08 -0800
Message-Id: <20210210191809.2181630-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210210191809.2181630-1-luiz.dentz@gmail.com>
References: <20210210191809.2181630-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves duplicated code for waiting firmware download to complete to
a function that can then be reused.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 108 +++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 60 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index df0b1f8c7ed7..c4d30525dafe 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2524,6 +2524,44 @@ static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv
 		 suffix);
 }
 
+static int btusb_download_wait(struct hci_dev *hdev, ktime_t calltime, int msec)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	ktime_t delta, rettime;
+	unsigned long long duration;
+	int err;
+
+	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+
+	bt_dev_info(hdev, "Waiting for firmware download to complete");
+
+	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(msec));
+	if (err == -EINTR) {
+		bt_dev_err(hdev, "Firmware loading interrupted");
+		return err;
+	}
+
+	if (err) {
+		bt_dev_err(hdev, "Firmware loading timeout");
+		return -ETIMEDOUT;
+	}
+
+	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
+		bt_dev_err(hdev, "Firmware loading failed");
+		return -ENOEXEC;
+	}
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+
+	bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
+
+	return 0;
+}
+
 static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 						struct intel_version_tlv *ver,
 						u32 *boot_param)
@@ -2532,6 +2570,7 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	char fwname[64];
 	int err;
 	struct btusb_data *data = hci_get_drvdata(hdev);
+	ktime_t calltime;
 
 	if (!ver || !boot_param)
 		return -EINVAL;
@@ -2578,6 +2617,8 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 		goto done;
 	}
 
+	calltime = ktime_get();
+
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
@@ -2598,9 +2639,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 		btintel_reset_to_bootloader(hdev);
 		goto done;
 	}
-	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-
-	bt_dev_info(hdev, "Waiting for firmware download to complete");
 
 	/* Before switching the device into operational mode and with that
 	 * booting the loaded firmware, wait for the bootloader notification
@@ -2613,26 +2651,9 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	 * and thus just timeout if that happens and fail the setup
 	 * of this device.
 	 */
-	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
-				  TASK_INTERRUPTIBLE,
-				  msecs_to_jiffies(5000));
-	if (err == -EINTR) {
-		bt_dev_err(hdev, "Firmware loading interrupted");
-		goto done;
-	}
-
-	if (err) {
-		bt_dev_err(hdev, "Firmware loading timeout");
-		err = -ETIMEDOUT;
+	err = btusb_download_wait(hdev, calltime, 5000);
+	if (err == -ETIMEDOUT)
 		btintel_reset_to_bootloader(hdev);
-		goto done;
-	}
-
-	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
-		bt_dev_err(hdev, "Firmware loading failed");
-		err = -ENOEXEC;
-		goto done;
-	}
 
 done:
 	release_firmware(fw);
@@ -2648,6 +2669,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	char fwname[64];
 	int err;
 	struct btusb_data *data = hci_get_drvdata(hdev);
+	ktime_t calltime;
 
 	if (!ver || !params)
 		return -EINVAL;
@@ -2747,6 +2769,8 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 		goto done;
 	}
 
+	calltime = ktime_get();
+
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
@@ -2765,9 +2789,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 		btintel_reset_to_bootloader(hdev);
 		goto done;
 	}
-	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-
-	bt_dev_info(hdev, "Waiting for firmware download to complete");
 
 	/* Before switching the device into operational mode and with that
 	 * booting the loaded firmware, wait for the bootloader notification
@@ -2780,26 +2801,9 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	 * and thus just timeout if that happens and fail the setup
 	 * of this device.
 	 */
-	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
-				  TASK_INTERRUPTIBLE,
-				  msecs_to_jiffies(5000));
-	if (err == -EINTR) {
-		bt_dev_err(hdev, "Firmware loading interrupted");
-		goto done;
-	}
-
-	if (err) {
-		bt_dev_err(hdev, "Firmware loading timeout");
-		err = -ETIMEDOUT;
+	err = btusb_download_wait(hdev, calltime, 5000);
+	if (err == -ETIMEDOUT)
 		btintel_reset_to_bootloader(hdev);
-		goto done;
-	}
-
-	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
-		bt_dev_err(hdev, "Firmware loading failed");
-		err = -ENOEXEC;
-		goto done;
-	}
 
 done:
 	release_firmware(fw);
@@ -2826,8 +2830,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 */
 	boot_param = 0x00000000;
 
-	calltime = ktime_get();
-
 	/* Read the Intel version information to determine if the device
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
@@ -2851,12 +2853,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	if (ver.fw_variant == 0x23)
 		goto finish;
 
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
-
-	bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
-
 	calltime = ktime_get();
 
 	set_bit(BTUSB_BOOTING, &data->flags);
@@ -2974,8 +2970,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	 */
 	boot_param = 0x00000000;
 
-	calltime = ktime_get();
-
 	/* Read the Intel version information to determine if the device
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
@@ -2999,12 +2993,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	if (version.img_type == 0x03)
 		goto finish;
 
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
-
-	bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
-
 	calltime = ktime_get();
 
 	set_bit(BTUSB_BOOTING, &data->flags);
-- 
2.26.2


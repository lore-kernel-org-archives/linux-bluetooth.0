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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ACDC433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 00:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504C464E66
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 00:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhBJASs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 19:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhBIXey (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 18:34:54 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B207C06178C
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Feb 2021 15:34:09 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id e7so15111pge.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Feb 2021 15:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O9iKgPn4LCWBYgOKdHMjLPOYN57TDAbQkLbQ2xPL650=;
        b=KBfHBPK+3x3BfSb0MxBennVtGXbImKMtGrCl0gmuyPkBgONnhUz/lgIwzDDQUSYErl
         FBlNha4bK+qppr3tfKHvnIneO2JrUnyNm/+Wx4ltB0ft6SGHKqoQCZu6hOnVltDgDaLQ
         NO00MeLcOt8UuBVGo/yUrFky3OavU0hNa0bWHyddHgOXntFDb4Tx8Y6OJFJmggEmZsfG
         g5psyMiA2Ozrcj3SMZfHeonL40RRtcmmlRa7jliYh8ipDiONIs2TADWj7AOaH+trpYCB
         gE31oR4ODZTD3M+VaZZ9leghwgGzP5F2L/vg0k6udexSSn7T2YzJLAhMYl+A2yKD8lk0
         UzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9iKgPn4LCWBYgOKdHMjLPOYN57TDAbQkLbQ2xPL650=;
        b=Lm3v+ymeb40VJ9sTRPHpodLLfdhPDINIdLUJCc39ODJNSg1ejuhCHG//t/3/3BAOMv
         CIrZPFH5XrifpbPxK0+FP1PCorexDb3rNv7oAHEUv0QG0tGLajG5yZ3n97IpkvZDEgXx
         BZyCJFYnyouL98QsSPktPETllIT89/9vKC+4FVI2wZ4YuFTF0j+K0mQTa0FPDQk0Y99Q
         IX6NKKvUYCCo1Up1MFQ6WMwzCMeZbX9Gs2QEVO/yd79e15U3aNrCF28J4c47JO43z+9V
         q/6qF2uP2mbNG3g8VpRBRi/cZUnVhTBbh0iSQdua0yRWa7Y0bNY3xZ+vugfCgTpKTn0g
         sVAg==
X-Gm-Message-State: AOAM532j5LCu3h2fxz8btS24jZo6kzijnjz74xavq5SjXHfcKoD3dFZZ
        DcyWdU21zlmpnaKDrg9c06O6oAZu2VLniw==
X-Google-Smtp-Source: ABdhPJw6aipzoAOyG+XaqtM9sWSRpVL2SuaANdJGzlCBJz1Ejt93nGRYEo/gjPNUnBYxDT358rWnZQ==
X-Received: by 2002:a65:648c:: with SMTP id e12mr333515pgv.123.1612913648625;
        Tue, 09 Feb 2021 15:34:08 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s18sm141943pjr.14.2021.02.09.15.34.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 15:34:08 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/6] Bluetooth: btusb: Consolidate code for waiting firmware download
Date:   Tue,  9 Feb 2021 15:34:03 -0800
Message-Id: <20210209233404.2121960-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209233404.2121960-1-luiz.dentz@gmail.com>
References: <20210209233404.2121960-1-luiz.dentz@gmail.com>
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
index c1f8d61ced65..0462961f4690 100644
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
@@ -2597,9 +2638,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 		btintel_reset_to_bootloader(hdev);
 		goto done;
 	}
-	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-
-	bt_dev_info(hdev, "Waiting for firmware download to complete");
 
 	/* Before switching the device into operational mode and with that
 	 * booting the loaded firmware, wait for the bootloader notification
@@ -2612,26 +2650,9 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
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
@@ -2647,6 +2668,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	char fwname[64];
 	int err;
 	struct btusb_data *data = hci_get_drvdata(hdev);
+	ktime_t calltime;
 
 	if (!ver || !params)
 		return -EINVAL;
@@ -2746,6 +2768,8 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 		goto done;
 	}
 
+	calltime = ktime_get();
+
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
@@ -2763,9 +2787,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 		btintel_reset_to_bootloader(hdev);
 		goto done;
 	}
-	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-
-	bt_dev_info(hdev, "Waiting for firmware download to complete");
 
 	/* Before switching the device into operational mode and with that
 	 * booting the loaded firmware, wait for the bootloader notification
@@ -2778,26 +2799,9 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
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
@@ -2824,8 +2828,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 */
 	boot_param = 0x00000000;
 
-	calltime = ktime_get();
-
 	/* Read the Intel version information to determine if the device
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
@@ -2849,12 +2851,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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
@@ -2972,8 +2968,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	 */
 	boot_param = 0x00000000;
 
-	calltime = ktime_get();
-
 	/* Read the Intel version information to determine if the device
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
@@ -2997,12 +2991,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
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


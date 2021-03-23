Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C58C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2535619C8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhCWS7S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbhCWS7K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 14:59:10 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B45C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id u19so12677529pgh.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ufsDvRHRPhFwKqbIwatE4/dZRCGgv5SmrtuZPyIPUwM=;
        b=QPDX+0basiVdWz4/a86Fm9HVZJXV2mUjC+46X1uC3BQsG0bBvu9B5n5UgAOcHHleb3
         iQfVk/4vbdEXv9Q3PsQUAn2Dzm6G4ze2RTD5Jy2eCu2TU85uKe1UBrdh8M2MJnf8G0Pj
         HayiBrXesIrbjrZ7XEPPJPFNCaW6JrutwaSHfPYs7ErSCpI+URcjZwiThYQ+qguGlTdv
         JRgNlXIvZ5iF88rVaXe5ERNln8bJe0su/w8YfBbfwQOm05X7M8AOpTq8JZalVIaBWCBY
         rZkJsb7nkWV8DhSnLyUNHTaDh52HjU+zDPfUjZD+Li7ervuakJfCtZy6/tINynWR0sh8
         A6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufsDvRHRPhFwKqbIwatE4/dZRCGgv5SmrtuZPyIPUwM=;
        b=n05TtwzY5X2qFbHlQ6dXxB6UCqiGvuMU289iJVfG2ooVqK+XxI4kBfxpRNCrychO3C
         +MhkixYkgx040cebX9Z2ERvD05SP1XfCJ4vJ8Fndc4nhDqC7l5O1IifYK2PyeAk/SoLk
         p86i4JHb2hZ0pZ1gELLvxhV9CfWvxlG47/Bw57nkN5O9ViYjn4Kze/1G+ehfOR7tcnN9
         1N32AxmWNfoagE/lu0o26lvDouAMmqxRYKclUv9NvqoqUGI+HPtsFW/BmV/WlC3Y4ZAQ
         vyqg0hAXRaSTy/XDQeDaSRH88hp3YiHHST0C5qJUQ4bk4VByJo7o+859t0617FsG9ENF
         8NQw==
X-Gm-Message-State: AOAM533BW4PQvKqaNu7kcf1JdnpVogA5/gE2k/MIsqmz6ZeII399goE5
        ZL77jFonsAbG5Mwy+dcqF/pbUy5z9DGxFg==
X-Google-Smtp-Source: ABdhPJwsrnkzlSKa5meMbTYtS0T/ZgOH+tyHFymFY4wipfghJAATv2O4Eqc2O0T3MO2ZrFu+izxXzg==
X-Received: by 2002:a17:902:ce8d:b029:e4:bc38:c4 with SMTP id f13-20020a170902ce8db02900e4bc3800c4mr7254761plg.48.1616525949379;
        Tue, 23 Mar 2021 11:59:09 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b10sm16132325pgm.76.2021.03.23.11.59.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 11:59:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 5/9] Bluetooth: btusb: Consolidate code for waiting firmware download
Date:   Tue, 23 Mar 2021 11:59:00 -0700
Message-Id: <20210323185904.3372987-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323185904.3372987-1-luiz.dentz@gmail.com>
References: <20210323185904.3372987-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves duplicated code for waiting firmware download completion to
a function that can be reused.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 108 +++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 60 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2d3498b74296..dcdc434cf794 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2447,6 +2447,44 @@ static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv
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
@@ -2455,6 +2493,7 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	char fwname[64];
 	int err;
 	struct btusb_data *data = hci_get_drvdata(hdev);
+	ktime_t calltime;
 
 	if (!ver || !boot_param)
 		return -EINVAL;
@@ -2502,6 +2541,8 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 		goto done;
 	}
 
+	calltime = ktime_get();
+
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
@@ -2522,9 +2563,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 		btintel_reset_to_bootloader(hdev);
 		goto done;
 	}
-	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-
-	bt_dev_info(hdev, "Waiting for firmware download to complete");
 
 	/* Before switching the device into operational mode and with that
 	 * booting the loaded firmware, wait for the bootloader notification
@@ -2537,26 +2575,9 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
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
@@ -2572,6 +2593,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	char fwname[64];
 	int err;
 	struct btusb_data *data = hci_get_drvdata(hdev);
+	ktime_t calltime;
 
 	if (!ver || !params)
 		return -EINVAL;
@@ -2676,6 +2698,8 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 		goto done;
 	}
 
+	calltime = ktime_get();
+
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
@@ -2694,9 +2718,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 		btintel_reset_to_bootloader(hdev);
 		goto done;
 	}
-	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-
-	bt_dev_info(hdev, "Waiting for firmware download to complete");
 
 	/* Before switching the device into operational mode and with that
 	 * booting the loaded firmware, wait for the bootloader notification
@@ -2709,26 +2730,9 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
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
@@ -2755,8 +2759,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 */
 	boot_param = 0x00000000;
 
-	calltime = ktime_get();
-
 	/* Read the Intel version information to determine if the device
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
@@ -2780,12 +2782,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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
@@ -2903,8 +2899,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	 */
 	boot_param = 0x00000000;
 
-	calltime = ktime_get();
-
 	/* Read the Intel version information to determine if the device
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
@@ -2928,12 +2922,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
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
2.30.2


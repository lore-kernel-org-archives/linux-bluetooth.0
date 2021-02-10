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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C880C433E9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 23:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25D064E25
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 23:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhBJXqo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhBJXqm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 18:46:42 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12771C06178B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 15:45:55 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k22so2143792pll.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 15:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VmNbal+6pTvzxSQV2RErY1Ip55BmzrxOqTRVYU1f9rw=;
        b=ag8wiDJLFnGqaIxehQ8w43y4mVOxRkhofALfl1Ju20iwQqqXiWWRoOE6aHXBW3ZsSb
         DaSjAsfBxOYvONWRKQ/FrS96lxFPC1B8gAst8oh+jFtxff75orKYRui47+LFBNUDWX1+
         T6xqm8+9K/Fv5CUIjDjNuqLdk1DwbiyiGKx+6ccmGkxn77iWxPhEl/iin8NsvXrqllAo
         TupJgEQs139Z8QxbjMwHTkmDkDAR2ZXetJXMygHG4C+e61Z9IJoTEZH6oFBzQ8Ab3rZ1
         WwFy5PHvyMRmmPccDPzhXQ4wIYEqQvHVIg3QJyRdb1W4jS+BGQHR99nPaluQn7Kv7Dk2
         XWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VmNbal+6pTvzxSQV2RErY1Ip55BmzrxOqTRVYU1f9rw=;
        b=Z4rvV5Nxaq7n8UmgoIes7m+ALCYtvTh659SU4AkO/W9Ty+HBYf3aElrJ1dAPRnrzyS
         +L1Nr8/gjETVe0CiblfLdkXkzoBCjIDDvhbVQqvatMnhl2qXbVcw6qUN3QUOEekYRcEz
         TPR3zE7gcrWD69OgL5BsKfh5ViT5D68dxyibR9ENMu3nscrrVXavVjYRxJr8cByS/uXv
         5A2jL2tyqg7lqw8j2J+Rz/K36VrPSXRR+wklmnfMoY2hdAkbFcwX4Jo5rPEEN1KpLdrl
         I2rtea4LhqP8qupk0cFsu9ZBQuczDONzPt4nl1nqIXwhw6gDho3n7xe/NoICER7AqldQ
         F0SQ==
X-Gm-Message-State: AOAM532LnJCbLSaP4gWrmn7OAgnlPc5RoGl9/JOgJF8Q4C3GIs6+9iJX
        0DDeYcPBErMTa1bbcCImopEmslksKH9IuQ==
X-Google-Smtp-Source: ABdhPJyG0xc7tmc1FvJSvvB11CACU6NJQo5TYauFt8YkTUcUEwev8QI6cLq+SF493P8weqzP3xMcNQ==
X-Received: by 2002:a17:90a:701:: with SMTP id l1mr1307139pjl.154.1613000754091;
        Wed, 10 Feb 2021 15:45:54 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w124sm3377569pfw.176.2021.02.10.15.45.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:45:53 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 5/6] Bluetooth: btusb: Consolidate code for waiting firmware download
Date:   Wed, 10 Feb 2021 15:45:48 -0800
Message-Id: <20210210234549.2293917-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210210234549.2293917-1-luiz.dentz@gmail.com>
References: <20210210234549.2293917-1-luiz.dentz@gmail.com>
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
index 1f2b74eaaccf..8d343bf33438 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2514,6 +2514,44 @@ static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv
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
@@ -2522,6 +2560,7 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	char fwname[64];
 	int err;
 	struct btusb_data *data = hci_get_drvdata(hdev);
+	ktime_t calltime;
 
 	if (!ver || !boot_param)
 		return -EINVAL;
@@ -2568,6 +2607,8 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 		goto done;
 	}
 
+	calltime = ktime_get();
+
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
@@ -2588,9 +2629,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 		btintel_reset_to_bootloader(hdev);
 		goto done;
 	}
-	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-
-	bt_dev_info(hdev, "Waiting for firmware download to complete");
 
 	/* Before switching the device into operational mode and with that
 	 * booting the loaded firmware, wait for the bootloader notification
@@ -2603,26 +2641,9 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
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
@@ -2638,6 +2659,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	char fwname[64];
 	int err;
 	struct btusb_data *data = hci_get_drvdata(hdev);
+	ktime_t calltime;
 
 	if (!ver || !params)
 		return -EINVAL;
@@ -2741,6 +2763,8 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 		goto done;
 	}
 
+	calltime = ktime_get();
+
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
@@ -2759,9 +2783,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 		btintel_reset_to_bootloader(hdev);
 		goto done;
 	}
-	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-
-	bt_dev_info(hdev, "Waiting for firmware download to complete");
 
 	/* Before switching the device into operational mode and with that
 	 * booting the loaded firmware, wait for the bootloader notification
@@ -2774,26 +2795,9 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
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
@@ -2820,8 +2824,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 */
 	boot_param = 0x00000000;
 
-	calltime = ktime_get();
-
 	/* Read the Intel version information to determine if the device
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
@@ -2845,12 +2847,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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
@@ -2967,8 +2963,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	 */
 	boot_param = 0x00000000;
 
-	calltime = ktime_get();
-
 	/* Read the Intel version information to determine if the device
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
@@ -2992,12 +2986,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
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


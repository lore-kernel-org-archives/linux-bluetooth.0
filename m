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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B601C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE06619C9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhCWS7S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhCWS7L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 14:59:11 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3AFC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y5so15284495pfn.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jyJY6fTBeeDElTRy5LQwXAFLN7zjYr+7ncEfoPRBoc0=;
        b=pIC6zFzlMpxF1XkYKF9aAtRTAbI84m9uxIac+/j1qxuGWhQ3m6UQ0wE1mGEkVyotSM
         ohxJLk7krHoABnAKK63czKPZjnIVlQB4AuRqTOviaZOs4lm28nhRRgMbKPWZ7rxEv4Kt
         XJv5Pk9xwKhJB0RtmcsNf1DbEkcs2U6IW2HhZYxFppQF1Y0TkrKJJ+v4R/lm5bbf3ICW
         jFInNuGJkDzbXbLxcBAHim+EOMJbq7c6Jz6T9/Wv0IkztfboGKh7UUHmG/+bsAa1L83A
         /Wlgr+eJZbYM9ioCE6Bdc+oQa2vJD/RrCTCJDCCcws7dBGMIA5xkYZEB7VJZsEmX+ykD
         eY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jyJY6fTBeeDElTRy5LQwXAFLN7zjYr+7ncEfoPRBoc0=;
        b=nWt3+vNmzPtAJZ3KjHrXPwYU7G3vNnaaA6ZRcmWgteDHdlhKkj7YKtZMGcb3vEWBl7
         Iv7yrx0ugpJw6SFrXoYGnWXnmmJReed/c4EtFMqCmlOjHeCuNY1QCg7lQfSkFeRPkE6P
         zneEdBWen0Cu+8SYiL/cmscZsHynqYeuUdMS8UHe29py8H+TpBLlT6au5Ejb4i4iX5iG
         biRZzhTWXt8h5jB3ROHOold6NruYhwHBCpUOQ20wqW5ftVIk9959QjGDW8G60+hjzgdF
         d9sDJ2McNI45VQqrrd/rnP4MznngHEcxjlaCnZFUjo/XPJNWYTzy573z/P+m1xPgqdlz
         TpJA==
X-Gm-Message-State: AOAM532e+fE7DcpDn5NSMPP5zkqfq5LOaR9D4MY8RChmnCOP5I+nAaPj
        kUF458q6v8F4eoRKDqo6HJck5rz6bot8sQ==
X-Google-Smtp-Source: ABdhPJzXt+wCmwKL3OejGeWbm6kXCWFQJdlx0bwiI8OEU8SlcQ9cxJ66OPYAdVOpQ3j3EAbovjlojw==
X-Received: by 2002:a63:520e:: with SMTP id g14mr5139920pgb.350.1616525950390;
        Tue, 23 Mar 2021 11:59:10 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b10sm16132325pgm.76.2021.03.23.11.59.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 11:59:09 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 6/9] Bluetooth: btusb: Consolidate code for waiting firmware to boot
Date:   Tue, 23 Mar 2021 11:59:01 -0700
Message-Id: <20210323185904.3372987-6-luiz.dentz@gmail.com>
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
 drivers/bluetooth/btusb.c | 148 +++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 82 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dcdc434cf794..eb250f533265 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2739,6 +2739,68 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	return err;
 }
 
+static int btusb_boot_wait(struct hci_dev *hdev, ktime_t calltime, int msec)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	ktime_t delta, rettime;
+	unsigned long long duration;
+	int err;
+
+	bt_dev_info(hdev, "Waiting for device to boot");
+
+	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(msec));
+	if (err == -EINTR) {
+		bt_dev_err(hdev, "Device boot interrupted");
+		return -EINTR;
+	}
+
+	if (err) {
+		bt_dev_err(hdev, "Device boot timeout");
+		return -ETIMEDOUT;
+	}
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+
+	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
+
+	return 0;
+}
+
+static int btusb_intel_boot(struct hci_dev *hdev, u32 boot_addr)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	ktime_t calltime;
+	int err;
+
+	calltime = ktime_get();
+
+	set_bit(BTUSB_BOOTING, &data->flags);
+
+	err = btintel_send_intel_reset(hdev, boot_addr);
+	if (err) {
+		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
+		btintel_reset_to_bootloader(hdev);
+		return err;
+	}
+
+	/* The bootloader will not indicate when the device is ready. This
+	 * is done by the operational firmware sending bootup notification.
+	 *
+	 * Booting into operational firmware should not take longer than
+	 * 1 second. However if that happens, then just fail the setup
+	 * since something went wrong.
+	 */
+	err = btusb_boot_wait(hdev, calltime, 1000);
+	if (err == -ETIMEDOUT)
+		btintel_reset_to_bootloader(hdev);
+
+	return err;
+}
+
 static int btusb_setup_intel_new(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2746,8 +2808,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	struct intel_boot_params params;
 	u32 boot_param;
 	char ddcname[64];
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
 	int err;
 	struct intel_debug_features features;
 
@@ -2782,46 +2842,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	if (ver.fw_variant == 0x23)
 		goto finish;
 
-	calltime = ktime_get();
-
-	set_bit(BTUSB_BOOTING, &data->flags);
-
-	err = btintel_send_intel_reset(hdev, boot_param);
-	if (err) {
-		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
-		btintel_reset_to_bootloader(hdev);
+	err = btusb_intel_boot(hdev, boot_param);
+	if (err)
 		return err;
-	}
-
-	/* The bootloader will not indicate when the device is ready. This
-	 * is done by the operational firmware sending bootup notification.
-	 *
-	 * Booting into operational firmware should not take longer than
-	 * 1 second. However if that happens, then just fail the setup
-	 * since something went wrong.
-	 */
-	bt_dev_info(hdev, "Waiting for device to boot");
-
-	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
-				  TASK_INTERRUPTIBLE,
-				  msecs_to_jiffies(1000));
-
-	if (err == -EINTR) {
-		bt_dev_err(hdev, "Device boot interrupted");
-		return -EINTR;
-	}
-
-	if (err) {
-		bt_dev_err(hdev, "Device boot timeout");
-		btintel_reset_to_bootloader(hdev);
-		return -ETIMEDOUT;
-	}
-
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
-
-	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
@@ -2885,8 +2908,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u32 boot_param;
 	char ddcname[64];
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
 	int err;
 	struct intel_debug_features features;
 	struct intel_version_tlv version;
@@ -2922,46 +2943,9 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	if (version.img_type == 0x03)
 		goto finish;
 
-	calltime = ktime_get();
-
-	set_bit(BTUSB_BOOTING, &data->flags);
-
-	err = btintel_send_intel_reset(hdev, boot_param);
-	if (err) {
-		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
-		btintel_reset_to_bootloader(hdev);
+	err = btusb_intel_boot(hdev, boot_param);
+	if (err)
 		return err;
-	}
-
-	/* The bootloader will not indicate when the device is ready. This
-	 * is done by the operational firmware sending bootup notification.
-	 *
-	 * Booting into operational firmware should not take longer than
-	 * 1 second. However if that happens, then just fail the setup
-	 * since something went wrong.
-	 */
-	bt_dev_info(hdev, "Waiting for device to boot");
-
-	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
-				  TASK_INTERRUPTIBLE,
-				  msecs_to_jiffies(1000));
-
-	if (err == -EINTR) {
-		bt_dev_err(hdev, "Device boot interrupted");
-		return -EINTR;
-	}
-
-	if (err) {
-		bt_dev_err(hdev, "Device boot timeout");
-		btintel_reset_to_bootloader(hdev);
-		return -ETIMEDOUT;
-	}
-
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
-
-	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
-- 
2.30.2


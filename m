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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F9DC4332B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 23:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A6264E0B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 23:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhBJXqp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhBJXqn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 18:46:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810F6C06178C
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 15:45:55 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id a24so217075plm.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 15:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dLB7vhC9uuiz026hgr1eH1jbQMXLdTjovN95ZprIn4s=;
        b=iToV773m1RBS2kQ9mC/dS+OeMaLITk6tT5qtkWchelpwgIYtfYULQ9Lxq6fR2KDOlO
         gKlVMeveCCbHy95NNLuoGxbm1+zNBjKGuXnI6NSXD+/O+Rwy79xJX2h56W0HVjehJNAt
         IokmkT9Xh09i2vrboP9wxzrCX4affOUra7O7nAXMdYq2RHxRfZA8rLry/16+o0zuuVR2
         XufN/NecttXdn59yL4ycUE/zKVEwK+klRQyzuvoIiXfj9vy7l++dUUVqkZ4CFYMB4hnU
         EtHVutfGn2kQKnoP535zENrnLH95spwWcA03lZwpy069kZaAizin0Gb7pugF96gJy8Dj
         JUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLB7vhC9uuiz026hgr1eH1jbQMXLdTjovN95ZprIn4s=;
        b=Gxdo9s15kRYBx3zQQIRZw/vhyOr/ACTmuk6ZVBZyQblWy77O0uoQ/As7jKFwRdRC8n
         zVK3IPylTIia6RLPOW2YsfEFj61+duK6LhyB4yK8dZ9sPxbglbU6j8Gcm8+dTDNq/o5q
         S1ZMGxbrS0AE6dbooNzL6Yj9n+NzNrdt8Fox/sENy2txw3Sxlxvfrxeo9ZIjvKZnSjX8
         ccgKIutaw3T/U57c58YZe+hvN6ygQyDQ+NknRZn9ZVhyC6iVeUfLfI3f7E/aXarb1pb1
         OXdinILZgSORgAtMeR7OMmA5PUt6/6W/Dz3U/mWaLGuynPh1Xl9gvzmTWXScwPi9/LXp
         NqsQ==
X-Gm-Message-State: AOAM530mom+vqM+I+pRDetNuOw/L4VYPMtqpNA7qImdWL3L1IJKZjbe5
        +4UqLk3nJpTOtRP5ZatO4JFAYO0hNspnDg==
X-Google-Smtp-Source: ABdhPJypYDNyGVVckSIo73sDaxGiSIz5aN5ntbti9oNCTmZ9kGRUgJ6KLrsS13204BOzt73DTb540Q==
X-Received: by 2002:a17:90a:470b:: with SMTP id h11mr1279040pjg.186.1613000754717;
        Wed, 10 Feb 2021 15:45:54 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w124sm3377569pfw.176.2021.02.10.15.45.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:45:54 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 6/6] Bluetooth: btusb: Consolidate code for waiting firmware to boot
Date:   Wed, 10 Feb 2021 15:45:49 -0800
Message-Id: <20210210234549.2293917-6-luiz.dentz@gmail.com>
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
 drivers/bluetooth/btusb.c | 148 +++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 82 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8d343bf33438..64c62a19df69 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2804,6 +2804,68 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
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
@@ -2811,8 +2873,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	struct intel_boot_params params;
 	u32 boot_param;
 	char ddcname[64];
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
 	int err;
 	struct intel_debug_features features;
 
@@ -2847,46 +2907,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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
 
@@ -2949,8 +2972,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u32 boot_param;
 	char ddcname[64];
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
 	int err;
 	struct intel_debug_features features;
 	struct intel_version_tlv version;
@@ -2986,46 +3007,9 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
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
2.26.2


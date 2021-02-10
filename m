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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104BBC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 19:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C3364E70
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 19:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhBJTTQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 14:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbhBJTS4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 14:18:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275BAC06178B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 11:18:16 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gx20so1732961pjb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 11:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kiETWGaUJR3IlkOPRJNEI8PKgQxhZ1U9H/eZGERLo7c=;
        b=E/mR0ztuHTcmhLj75gVkg7TZPF/S9IfawfDX+223CNt42uUsBfsprM6y1CnYEXHQVz
         4IMqrPoSxuLEl9Er0h7WzQw44H9slrgcqnXGQvPefXEu3xp8scEt6Y/d7Tburp5cLoXN
         d8cuDhGG2Xj3sl8O88eR/e5KLsw7YYeID00/AztdULnngJNXfS3jtjovdQrNG45qdIYp
         bBu8S4TenfO/5DHWE5qjHJQ365tg3W+vJXstYEZK9edLa286fJ/HHDapSmke4uFUCT9z
         K16U6uFfniqglW2BK5hqkieLLzbc3VgICK1x5x4XkZHT8QE8VQkkVz3n2r7iyIPI7G/G
         2apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiETWGaUJR3IlkOPRJNEI8PKgQxhZ1U9H/eZGERLo7c=;
        b=gKcV2s1edHeTUBipB9vtxCHxHVcixhinnGQDvpE5JTRzLSBmHLTTpFjoMZrwjf4j4c
         73rKMgrq+1xtINi8tgZ0CkrOmI+DXq7nKSpiATk7i3+8JLQynP+Qj/plOvGGB71x0Dy+
         Jmk81cK/AEKu2GstEAmhuHkcpr2WBBjckhga1baB56Ozd5ux22xy9OVDPzICUZ1A4f3O
         pc0MAJBE4mnsVmYi85mmvQ+evqLRJAw1Dnf+HnTLyduEtVxPk+GY4nYKUm1hPjVoJSVH
         X438YYw8dHWfIur2lC140XYjBZFOhsI3PlMDzb2JJKDJ6yl7u+qNoGmU9U6wnGmUAWbL
         PF9w==
X-Gm-Message-State: AOAM533mljn/1ns2VWsRjqLcc6fRE15ISbpXWuGFtbddEJg8KO0OShxZ
        P90tA1jR9nNcQcapU1mw+59be7+E/jqJCg==
X-Google-Smtp-Source: ABdhPJyBP3AJciVjX5JNBo1ZZPPwfCnp8lpvS5aA/O/hKPAH2aULTwg/11LtGw2p6encyk+9HpFQVw==
X-Received: by 2002:a17:90a:7641:: with SMTP id s1mr449560pjl.20.1612984695391;
        Wed, 10 Feb 2021 11:18:15 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 125sm2988822pfu.7.2021.02.10.11.18.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:18:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 6/6] Bluetooth: btusb: Consolidate code for waiting firmware to boot
Date:   Wed, 10 Feb 2021 11:18:09 -0800
Message-Id: <20210210191809.2181630-6-luiz.dentz@gmail.com>
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
 drivers/bluetooth/btusb.c | 148 +++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 82 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c4d30525dafe..6ab955c9b309 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2810,6 +2810,68 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
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
@@ -2817,8 +2879,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	struct intel_boot_params params;
 	u32 boot_param;
 	char ddcname[64];
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
 	int err;
 	struct intel_debug_features features;
 
@@ -2853,46 +2913,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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
 
@@ -2956,8 +2979,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u32 boot_param;
 	char ddcname[64];
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
 	int err;
 	struct intel_debug_features features;
 	struct intel_version_tlv version;
@@ -2993,46 +3014,9 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
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


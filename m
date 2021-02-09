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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1848AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 18:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D2664EC4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 18:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhBISzu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 13:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbhBIStG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 13:49:06 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FC8C061788
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Feb 2021 10:37:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id t2so2189860pjq.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Feb 2021 10:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9r39e0FawigOYrzHIRBqg19OWikqKQp5VXTUpj5s8XA=;
        b=pbpvQ4xZ3hOR9inzJvfRex3bV+iKg8aSkIkGIHkTVvxujzbVqVLwYh8JYiiFxng3kk
         K2Ugpy5TCwYwF7DIKRSZIEJ9weGoCkDPMGrDDs+F1y86CQctlvhJ9hMtOrkqxa/9pf/8
         3Wz4jX9hY9K/Hm94wEoZDPxW24aLsCOSROwKRQuXQWr2sc4ZPzvNNeptyrtpw1v4nZnb
         HeaJwZ73YDM9ZbIVZVBDeVB5oLZya8jIVuD/Hcpxl6WTIeEHDtAC8hzA0J7AMTzHK1pd
         r/QZJZL4yyyF/PSV49OZvR/oCOAjHefU40BO3zyNFpUgMa36V3vtzrYsD7F+DUPmektT
         pheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9r39e0FawigOYrzHIRBqg19OWikqKQp5VXTUpj5s8XA=;
        b=oshTfnxQj3hTyji+RT37v5Xp5seTeNZKUJnd0UlRGQuWwnX2Ou7a6a8spCwyg99Mr3
         V7h50CFTvscCvhpZ0XvGiNG3B0ndzrR8eiS1UFpxxK8l1rjVhYVwziFxVGkin9lrripE
         UY+RVyW8Vyi7CA3+k/M5PpAZzfuWAbD8hqoHtzs29RZUB7CIAav7bJj1IsUYsgDvLRDL
         iu7wtr5RS9t74DRUVb+j8lrX34z04+STDuHrlE+MVECwzYKJRoM8iK4Iz3lx7AOl/azJ
         a6CcyP0Dg6ntfF2pfQ/M8viYraA0QvZu36oghg03HyZVsMTmHhN42EpazBROx/lYKvA4
         lZtw==
X-Gm-Message-State: AOAM530PVzjsj50Xa8p/ArDkyOCE4SekmBpgijon3625IULRDQ0oos/A
        TYxTWVyAuuVpH4sS98zuTJ3pWtnM57DTJw==
X-Google-Smtp-Source: ABdhPJyYQAUUgrBdBb9eCksATsSBG8jBdFIur9pOoOY5cN6zYeOH2dWqe0HiMIDfMWScmoE3mZhzRw==
X-Received: by 2002:a17:90b:3805:: with SMTP id mq5mr5309781pjb.93.1612895868404;
        Tue, 09 Feb 2021 10:37:48 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w1sm3178760pjq.38.2021.02.09.10.37.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 10:37:48 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: btintel: Move operational checks after version check
Date:   Tue,  9 Feb 2021 10:37:45 -0800
Message-Id: <20210209183745.1855624-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209183745.1855624-1-luiz.dentz@gmail.com>
References: <20210209183745.1855624-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order to allow new firmware to be loaded it first needs to check if
the firmware version on file matches the one loaded if it doesn't then
it needs to revert to boorloader mode in order to load the new firmware.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 22 +++++++++++++++++++++
 drivers/bluetooth/btusb.c   | 38 -------------------------------------
 2 files changed, 22 insertions(+), 38 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 153989bd8d5f..ccab05f67df9 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -948,6 +948,17 @@ int btintel_download_firmware(struct hci_dev *hdev,
 		return -EALREADY;
 	}
 
+	/* The firmware variant determines if the device is in bootloader
+	 * mode or is running operational firmware. The value 0x06 identifies
+	 * the bootloader and the value 0x23 identifies the operational
+	 * firmware.
+	 *
+	 * If the firmware version has changed that means it needs to be reset
+	 * to bootloader when operational so the new firmware can be loaded.
+	 */
+	if (ver->fw_variant == 0x23)
+		return -EINVAL;
+
 	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
 	if (err)
 		return err;
@@ -974,6 +985,17 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
 		return -EALREADY;
 	}
 
+	/* The firmware variant determines if the device is in bootloader
+	 * mode or is running operational firmware. The value 0x03 identifies
+	 * the bootloader and the value 0x23 identifies the operational
+	 * firmware.
+	 *
+	 * If the firmware version has changed that means it needs to be reset
+	 * to bootloader when operational so the new firmware can be loaded.
+	 */
+	if (ver->img_type == 0x03)
+		return -EINVAL;
+
 	/* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
 	 * only RSA secure boot engine. Hence, the corresponding sfi file will
 	 * have RSA header of 644 bytes followed by Command Buffer.
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e896c6702d60..971dbad31e26 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2534,25 +2534,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 		return -EINVAL;
 	}
 
-	/* The firmware variant determines if the device is in bootloader
-	 * mode or is running operational firmware. The value 0x03 identifies
-	 * the bootloader and the value 0x23 identifies the operational
-	 * firmware.
-	 *
-	 * When the operational firmware is already present, then only
-	 * the check for valid Bluetooth device address is needed. This
-	 * determines if the device will be added as configured or
-	 * unconfigured controller.
-	 *
-	 * It is not possible to use the Secure Boot Parameters in this
-	 * case since that command is only available in bootloader mode.
-	 */
-	if (ver->img_type == 0x03) {
-		clear_bit(BTUSB_BOOTLOADER, &data->flags);
-		btintel_check_bdaddr(hdev);
-		return 0;
-	}
-
 	/* Check for supported iBT hardware variants of this firmware
 	 * loading method.
 	 *
@@ -2724,25 +2705,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 
 	btintel_version_info(hdev, ver);
 
-	/* The firmware variant determines if the device is in bootloader
-	 * mode or is running operational firmware. The value 0x06 identifies
-	 * the bootloader and the value 0x23 identifies the operational
-	 * firmware.
-	 *
-	 * When the operational firmware is already present, then only
-	 * the check for valid Bluetooth device address is needed. This
-	 * determines if the device will be added as configured or
-	 * unconfigured controller.
-	 *
-	 * It is not possible to use the Secure Boot Parameters in this
-	 * case since that command is only available in bootloader mode.
-	 */
-	if (ver->fw_variant == 0x23) {
-		clear_bit(BTUSB_BOOTLOADER, &data->flags);
-		btintel_check_bdaddr(hdev);
-		return 0;
-	}
-
 	/* If the device is not in bootloader mode, then the only possible
 	 * choice is to return an error and abort the device initialization.
 	 */
-- 
2.26.2


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484A2C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 00:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B8A64E4E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 00:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhBJATQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 19:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbhBIXe5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 18:34:57 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A5BC061788
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Feb 2021 15:34:07 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u11so155414plg.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Feb 2021 15:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GdOiIie4HAqq0oCccb0BSTkbOEFxAfkIDQa7QkSeGjY=;
        b=mEucaZNuOoNHbwNZaLzaPrH1TpBg35r878IjyR3qTupWDUv8e7nfh6Qg8PRa68oxXP
         Wj/GN5xc4dCDCumOchBQgRzzsxfdYp37QpmLZtEaNZhkJodNhpHJsHL1EZXrJuWUXaoA
         lKhmf3t7WfakeEDOCBIgFptZAB2QtGy3vajT8m1gtsz2r9oVW8EKFwUgZ15+iGDYyA7Y
         IPsqPgFXBIG1vunnBiV6FRTgJ6grz4kmJ/JSxveqrkxYpugEhR4D1cA90UaRRuw2KkJD
         72EAVx5Ng3zkyuNlfBCny/cHSbtYiK65/xoxtqynHWldlGSpvmhVE4U7u2djnDtJaYgs
         MjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GdOiIie4HAqq0oCccb0BSTkbOEFxAfkIDQa7QkSeGjY=;
        b=UaqZ3yJiz14UFse4DJxW0Td9ZbWjZKMcrHc5vxLTOm3wErAuKpxrrFX70sX2eOMnu3
         ck0CKkBkr2KDapIqnm/VNYBQXo662oIeuoAph3kao3y39uVP57UZeLRW7gWnuWMzIcUB
         VjPjbRXgQLqpBK6I+XTrBTvIhVjyRCBuR96HVgPZOR7VN3ZrGrBK98YQbjp4wlz91ysK
         iszws29i5Wepon6eHBRvFPNgbGWyAQF+3/BhA17r3C1NyqA7P0Sf43IdieUgobfEBBFe
         2svfqsWl6pVR0lYLSngvegkbSztPkm2e0waj7YUw3IUu2YpVQXl1qyntzaB5y3JJPI6V
         V+Tw==
X-Gm-Message-State: AOAM5322oPRdQXZJ+f/zN6IcYu0ociH+s35/JYgSB0B0+Lzak+U8n57R
        bzNrU+tUJ1qdHqJl8bmsqFBJ7E6mngY+Lw==
X-Google-Smtp-Source: ABdhPJyXF0kvbuXxfluSEwz3Sc1IDM9ntfTfQfJ3Lpfo6nJt2xC7D9D3NFds1jdcRpEZl9124KBccQ==
X-Received: by 2002:a17:90a:6708:: with SMTP id n8mr311688pjj.38.1612913646868;
        Tue, 09 Feb 2021 15:34:06 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s18sm141943pjr.14.2021.02.09.15.34.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 15:34:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/6] Bluetooth: btintel: Consolidate intel_version_tlv parsing
Date:   Tue,  9 Feb 2021 15:34:01 -0800
Message-Id: <20210209233404.2121960-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209233404.2121960-1-luiz.dentz@gmail.com>
References: <20210209233404.2121960-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves checks version checks of intel_version_tlv to
btintel_version_info_tlv.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 50 ++++++++++++++++++++++++++++++---
 drivers/bluetooth/btintel.h |  2 +-
 drivers/bluetooth/btusb.c   | 56 ++-----------------------------------
 3 files changed, 50 insertions(+), 58 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index ccab05f67df9..ce4b9ef2015f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -372,10 +372,53 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 }
 EXPORT_SYMBOL_GPL(btintel_read_version);
 
-void btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
+int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
 {
 	const char *variant;
 
+	/* The hardware platform number has a fixed value of 0x37 and
+	 * for now only accept this single value.
+	 */
+	if (INTEL_HW_PLATFORM(version->cnvi_bt) != 0x37) {
+		bt_dev_err(hdev, "Unsupported Intel hardware platform (0x%2x)",
+			   INTEL_HW_PLATFORM(version->cnvi_bt));
+		return -EINVAL;
+	}
+
+	/* Check for supported iBT hardware variants of this firmware
+	 * loading method.
+	 *
+	 * This check has been put in place to ensure correct forward
+	 * compatibility options when newer hardware variants come along.
+	 */
+	switch (INTEL_HW_VARIANT(version->cnvi_bt)) {
+	case 0x17:	/* TyP */
+	case 0x18:	/* Slr */
+	case 0x19:	/* Slr-F */
+		break;
+	default:
+		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
+			   INTEL_HW_VARIANT(version->cnvi_bt));
+		return -EINVAL;
+	}
+
+	/* It is required that every single firmware fragment is acknowledged
+	 * with a command complete event. If the boot parameters indicate
+	 * that this bootloader does not send them, then abort the setup.
+	 */
+	if (version->limited_cce != 0x00) {
+		bt_dev_err(hdev, "Unsupported Intel firmware loading method (0x%x)",
+			   version->limited_cce);
+		return -EINVAL;
+	}
+
+	/* Secure boot engine type should be either 1 (ECDSA) or 0 (RSA) */
+	if (version->sbe_type > 0x01) {
+		bt_dev_err(hdev, "Unsupported Intel secure boot engine type (0x%x)",
+			   version->sbe_type);
+		return -EINVAL;
+	}
+
 	switch (version->img_type) {
 	case 0x01:
 		variant = "Bootloader";
@@ -397,15 +440,14 @@ void btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *ve
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported image type(%02x)", version->img_type);
-		goto done;
+		return -EINVAL;
 	}
 
 	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", variant,
 		    2000 + (version->timestamp >> 8), version->timestamp & 0xff,
 		    version->build_type, version->build_num);
 
-done:
-	return;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 51f1f2c883b4..94a63e898826 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -149,7 +149,7 @@ int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
 void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
-void btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *version);
+int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *version);
 int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 			const void *param);
 int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 113ff780232f..895950a79400 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2542,15 +2542,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	if (!ver || !boot_param)
 		return -EINVAL;
 
-	/* The hardware platform number has a fixed value of 0x37 and
-	 * for now only accept this single value.
-	 */
-	if (INTEL_HW_PLATFORM(ver->cnvi_bt) != 0x37) {
-		bt_dev_err(hdev, "Unsupported Intel hardware platform (0x%2x)",
-			   INTEL_HW_PLATFORM(ver->cnvi_bt));
-		return -EINVAL;
-	}
-
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x03 identifies
 	 * the bootloader and the value 0x23 identifies the operational
@@ -2569,49 +2560,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 		btintel_check_bdaddr(hdev);
 	}
 
-	/* Check for supported iBT hardware variants of this firmware
-	 * loading method.
-	 *
-	 * This check has been put in place to ensure correct forward
-	 * compatibility options when newer hardware variants come along.
-	 */
-	switch (INTEL_HW_VARIANT(ver->cnvi_bt)) {
-	case 0x17:	/* TyP */
-	case 0x18:	/* Slr */
-	case 0x19:	/* Slr-F */
-		break;
-	default:
-		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
-			   INTEL_HW_VARIANT(ver->cnvi_bt));
-		return -EINVAL;
-	}
-
-	/* If the device is not in bootloader mode, then the only possible
-	 * choice is to return an error and abort the device initialization.
-	 */
-	if (ver->img_type != 0x01) {
-		bt_dev_err(hdev, "Unsupported Intel firmware variant (0x%x)",
-			   ver->img_type);
-		return -ENODEV;
-	}
-
-	/* It is required that every single firmware fragment is acknowledged
-	 * with a command complete event. If the boot parameters indicate
-	 * that this bootloader does not send them, then abort the setup.
-	 */
-	if (ver->limited_cce != 0x00) {
-		bt_dev_err(hdev, "Unsupported Intel firmware loading method (0x%x)",
-			   ver->limited_cce);
-		return -EINVAL;
-	}
-
-	/* Secure boot engine type should be either 1 (ECDSA) or 0 (RSA) */
-	if (ver->sbe_type > 0x01) {
-		bt_dev_err(hdev, "Unsupported Intel secure boot engine type (0x%x)",
-			   ver->sbe_type);
-		return -EINVAL;
-	}
-
 	/* If the OTP has no valid Bluetooth device address, then there will
 	 * also be no valid address for the operational firmware.
 	 */
@@ -3041,7 +2989,9 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 		return err;
 	}
 
-	btintel_version_info_tlv(hdev, &version);
+	err = btintel_version_info_tlv(hdev, &version);
+	if (err)
+		return err;
 
 	err = btusb_intel_download_firmware_newgen(hdev, &version, &boot_param);
 	if (err)
-- 
2.26.2


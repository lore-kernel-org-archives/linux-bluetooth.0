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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A456C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 19:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B95664E76
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 19:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhBJTTF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 14:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhBJTSx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 14:18:53 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979ABC061786
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 11:18:13 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b8so1739006plh.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 11:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U8tyEVc9YdDLk7/3YBN1/7GLG8xe/5FnTiCTfGp1948=;
        b=Lvp4pVV0Lqc2TI1zsCF7jWuCKglAG3FIwBAf7XWs8SSTnzMIroGqSWDiCWwP1VEuXy
         qV5prQATf9EU//06TQoa2gV0apyd970r8A00+leDiVLshHwxk9BsxHJFcQdIRqiZMSK5
         lQDAx/l2eZsGidCi3IrELgvx9m3jbDELrMvEPeAhBGrJ3FXfiuFWYUp6F4N+YtFeSUny
         vChDZI2HiVYenDs+wT7Sjd94bZu5O4GR8NB46QDFXYnhJff4E6d7+pY4WHMNY7HNZckQ
         wbzay1mzOpYCMNtmVctJGZbYPrAApSrp9dqXlsMLtmoPQZUrBYq/69s7U7XK52fn6+An
         pDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8tyEVc9YdDLk7/3YBN1/7GLG8xe/5FnTiCTfGp1948=;
        b=m+aWEoo4ZmR9l1chq+RTRgixdXG7da0RkDZgvVaRpOAOARUErLRGDhNS88uLhQKS2a
         Kv8Xch/dvg81D6b4Bl1KkTjBtKtgVOqD1sMpi8bgiYLv0wkBQUlC093v4G0UIfzsiFav
         GGIjXy08jK8wjIQNlKANcBNQ57pn+EL8PBjRaAbreEyZqz2Dfkx5HRZw7jyvgaF0va9o
         TgxgF0JcIwQvmJ66hubX8uu1M+rjPtynPsMJpyuNghZl32TYI6GzzuPo6a0Zvve3g0um
         tVMDpFlLVBg7cCG0w0998XHl5GoLFsrRXiMGke+8V3/qGF6wDgjjDd8GBz7Uk3wFpstD
         GiXA==
X-Gm-Message-State: AOAM531iYgYtm+saEFOoE2/VbzEQ78cSKpNp/nixVJcs9WywD1klrr4S
        QMWAsmnUtR5mrL/FiqqEFafjc07GZoD2Iw==
X-Google-Smtp-Source: ABdhPJwd/12DMzq3gPekGvERh8k+ppcStZx+5oyu4MDVHPUeZ3/8g3rMvoEbMJ7bA079ngoZEO6H0g==
X-Received: by 2002:a17:90a:7e94:: with SMTP id j20mr444971pjl.8.1612984692829;
        Wed, 10 Feb 2021 11:18:12 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 125sm2988822pfu.7.2021.02.10.11.18.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:18:12 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/6] Bluetooth: btintel: Consolidate intel_version_tlv parsing
Date:   Wed, 10 Feb 2021 11:18:06 -0800
Message-Id: <20210210191809.2181630-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210210191809.2181630-1-luiz.dentz@gmail.com>
References: <20210210191809.2181630-1-luiz.dentz@gmail.com>
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
index 6c45e86a8a72..c907a4d6b37c 100644
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
index a44f3cf25790..634406058ccf 100644
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
@@ -3043,7 +2991,9 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
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


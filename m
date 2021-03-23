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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95965C433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D20619A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhCWS7P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhCWS7H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 14:59:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C04C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so10329377pjb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=o4VR66b72NDwj9AcA+Kn10dg4DS4Df355mwoHIeLOss=;
        b=rfI78seF8S79HpN3BHKZZmyhWVANags/XVD87Hb8wQX07fTh13Ab7iBxQ5AoNLfhls
         B32NDXV51awBnyChHbvqytHn9h729uX3FCUYL+MDcUWucg3GYE1y7bb+JA+SezTb4NYl
         VtDjWKFf0IlJj7dp4/bmdHNo7vaZA2i9TRtJCFIulmY2eKsBULd0vnWik7SWES8ZkF0v
         O4g+ISoiaYPQL6k0CFlTlVH3l2pLyZa04YaSpqnr/xlG0Rvn1ma9j0MfTWgoilEaxVjR
         ajDc1IRCv8yNknPzu8MTP0a8/CvNG27p/J0RImGSk3eHaGaifiBhwpjetupc74P1INxa
         PXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o4VR66b72NDwj9AcA+Kn10dg4DS4Df355mwoHIeLOss=;
        b=oWBrAI+OUAhe07ezc1IwcUjU3VjCK18MfVf3YMXBChVZOnIDIVQFasuGUNu2YYEg5/
         3ta/kaMgcK9GosAvLFRqm15ER0lNGZ4VyipFZo+dHZ3+Idpud0b3PejWSjqo5lma/jat
         1cUrZNt7P70z9mh0hwi7WA266g/ks3LmPclLYUKLGdq0yJRui92r5Jr2xv+HRL2T3j6g
         gXHyqGhs0IX2oYldBDMRxDtUyK1NLGRD+GV4oaMdmkhFGr8koxtkLSNXpBLABHNPOLQu
         ND2nGR3hEcytWXiqZ84b9zGCUf/fbYfbXTtDOJSySK7jffB+QZtvLS5AHEG1oJnEO5V8
         NmJA==
X-Gm-Message-State: AOAM531n06w2qH2TxFQYZ7sk1rfcBHy76Or77I6hhBKfcP/Jxbr0+WH8
        Y/3//CKWmFyEhNqCNtvfd61/nzhdzJd6sA==
X-Google-Smtp-Source: ABdhPJxgMlqVObeu/hM/ROlCYPgCh+0+/DePKZXtCeN8PZbjKErX/IewbOvButcglIPyr52kZN2rkQ==
X-Received: by 2002:a17:90a:ff91:: with SMTP id hf17mr6129435pjb.34.1616525946626;
        Tue, 23 Mar 2021 11:59:06 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b10sm16132325pgm.76.2021.03.23.11.59.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 11:59:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 2/9] Bluetooth: btintel: Move operational checks after version check
Date:   Tue, 23 Mar 2021 11:58:57 -0700
Message-Id: <20210323185904.3372987-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323185904.3372987-1-luiz.dentz@gmail.com>
References: <20210323185904.3372987-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order to allow new firmware to load, it first needs to check if the
firmware version on file matches the one loaded if it doesn't, then it
needs to revert to bootloader mode in order to load the new firmware.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 22 ++++++++++++
 drivers/bluetooth/btusb.c   | 68 +++++++++++++------------------------
 2 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 3ff698a0bd25..13bc93a986c7 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -958,6 +958,17 @@ int btintel_download_firmware(struct hci_dev *hdev,
 		}
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
@@ -985,6 +996,17 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
 		return -EALREADY;
 	}
 
+	/* The firmware variant determines if the device is in bootloader
+	 * mode or is running operational firmware. The value 0x01 identifies
+	 * the bootloader and the value 0x03 identifies the operational
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
index de220ab7f231..a30f7ea9be36 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2402,11 +2402,17 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
-static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
+static int btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 					     struct intel_boot_params *params,
 					     char *fw_name, size_t len,
 					     const char *suffix)
 {
+	/* The hardware platform number has a fixed value of 0x37 and
+	 * for now only accept this single value.
+	 */
+	if (ver->hw_platform != 0x37)
+		return -EINVAL;
+
 	switch (ver->hw_variant) {
 	case 0x0b:	/* SfP */
 	case 0x0c:	/* WsP */
@@ -2426,9 +2432,10 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 			suffix);
 		break;
 	default:
-		return false;
+		return -EINVAL;
 	}
-	return true;
+
+	return 0;
 }
 
 static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv *ver_tlv,
@@ -2483,7 +2490,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	if (ver->img_type == 0x03) {
 		clear_bit(BTUSB_BOOTLOADER, &data->flags);
 		btintel_check_bdaddr(hdev);
-		return 0;
 	}
 
 	/* Check for supported iBT hardware variants of this firmware
@@ -2628,35 +2634,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	if (!ver || !params)
 		return -EINVAL;
 
-	/* The hardware platform number has a fixed value of 0x37 and
-	 * for now only accept this single value.
-	 */
-	if (ver->hw_platform != 0x37) {
-		bt_dev_err(hdev, "Unsupported Intel hardware platform (%u)",
-			   ver->hw_platform);
-		return -EINVAL;
-	}
-
-	/* Check for supported iBT hardware variants of this firmware
-	 * loading method.
-	 *
-	 * This check has been put in place to ensure correct forward
-	 * compatibility options when newer hardware variants come along.
-	 */
-	switch (ver->hw_variant) {
-	case 0x0b:	/* SfP */
-	case 0x0c:	/* WsP */
-	case 0x11:	/* JfP */
-	case 0x12:	/* ThP */
-	case 0x13:	/* HrP */
-	case 0x14:	/* CcP */
-		break;
-	default:
-		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
-			   ver->hw_variant);
-		return -EINVAL;
-	}
-
 	btintel_version_info(hdev, ver);
 
 	/* The firmware variant determines if the device is in bootloader
@@ -2675,16 +2652,18 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	if (ver->fw_variant == 0x23) {
 		clear_bit(BTUSB_BOOTLOADER, &data->flags);
 		btintel_check_bdaddr(hdev);
-		return 0;
-	}
 
-	/* If the device is not in bootloader mode, then the only possible
-	 * choice is to return an error and abort the device initialization.
-	 */
-	if (ver->fw_variant != 0x06) {
-		bt_dev_err(hdev, "Unsupported Intel firmware variant (%u)",
-			   ver->fw_variant);
-		return -ENODEV;
+		/* SfP and WsP don't seem to update the firmware version on file
+		 * so version checking is currently possible.
+		 */
+		switch (ver->hw_variant) {
+		case 0x0b:	/* SfP */
+		case 0x0c:	/* WsP */
+			return 0;
+		}
+
+		/* Proceed to download to check if the version matches */
+		goto download;
 	}
 
 	/* Read the secure boot parameters to identify the operating
@@ -2712,6 +2691,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
 	}
 
+download:
 	/* With this Intel bootloader only the hardware variant and device
 	 * revision information are used to select the right firmware for SfP
 	 * and WsP.
@@ -2735,7 +2715,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	 */
 	err = btusb_setup_intel_new_get_fw_name(ver, params, fwname,
 						sizeof(fwname), "sfi");
-	if (!err) {
+	if (err < 0) {
 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
 		return -EINVAL;
 	}
@@ -2908,7 +2888,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	err = btusb_setup_intel_new_get_fw_name(&ver, &params, ddcname,
 						sizeof(ddcname), "ddc");
 
-	if (!err) {
+	if (err < 0) {
 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
 	} else {
 		/* Once the device is running in operational mode, it needs to
-- 
2.30.2


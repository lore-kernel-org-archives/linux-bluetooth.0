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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E518FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 23:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2E864E0B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 23:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhBJXqe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbhBJXqc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 18:46:32 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E73DC061786
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 15:45:52 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n10so2334817pgl.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 15:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B1eh0ci3OYPiGnjxFe5zEwVQbktEc5t7+gWRKyDwP58=;
        b=V5GDvLu4qZIXRj1NTfmcoH1UQeGYFw8G7xgsKZJVUrtjZqnyxZIqiYiH13Zn/FcSYr
         JBzqrERdFh81EJMEnmkMIKbUqReaRgwU2WXwT7XkFOfdLSYOUCsPEo/oZYUfDmy7M/iy
         q3bnhbE9lIqU3QPBxcKo8Asy0n1IreYPnEqpATAHa2Fza/8S9kYzlpDMbxutl5DfJCFn
         c5dJ2RQ60GvJORrqvk7qP1tR9cVe2L8bYVunnn9+z9kpUvNVVBVnvZvIDcw7p8YtSRUJ
         4pfswODsIPj+HQR3oKSM/snZ7SlSoeLYGm3DoLuyM74Up++A82gReYM61vj3U7DvxpER
         bKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1eh0ci3OYPiGnjxFe5zEwVQbktEc5t7+gWRKyDwP58=;
        b=X0ugNfjEEtXVcyRVMa4LAALp1LOOa+sKf1rLIrsOjhjOJ8CZ3SIFtumsAu/9yhz/3c
         Bktehm4tI0TDk8zlmV8CJleNmM/cCfd3A6epa997bI3jasYp2aDCK1N2apdKy6TkOcmH
         OH25IuvgJ9MUMYfZFn4piw/pkDzzFVfMRb0yeYyt2oX/WrbBf9F4UVoWWMUdrrqCQJi+
         qTjXE8K7CoRJcfCmv0WIO/QD07cHzbLL6QYxqBZBQGiUUgtrGuapnHbNpccaICBqS3eP
         VRt/SCyZsLDVKQQ+pVN1alwMeT1YT1GQJaM7m13tmf4A20ORVvsOw+OsfyBehdpn6AMs
         97OQ==
X-Gm-Message-State: AOAM533XZNZ6V6MHejqLkgi55AwerApI3VfOWi09Pv/9fvxPeHIlzhbN
        RQCpyy1BfCgWV9VcWGW8ZRZcAKs4AiFr3Q==
X-Google-Smtp-Source: ABdhPJwC2oRm+0yvO0Q+QwuPD8XiQ2lk4mFYUES2xLQ6phGRZOVKSpoQTEvNNUHZlCKgUCWjyAPVtg==
X-Received: by 2002:a62:1d84:0:b029:1c0:671:2275 with SMTP id d126-20020a621d840000b02901c006712275mr5407274pfd.16.1613000751772;
        Wed, 10 Feb 2021 15:45:51 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w124sm3377569pfw.176.2021.02.10.15.45.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:45:51 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 2/6] Bluetooth: btintel: Move operational checks after version check
Date:   Wed, 10 Feb 2021 15:45:45 -0800
Message-Id: <20210210234549.2293917-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210210234549.2293917-1-luiz.dentz@gmail.com>
References: <20210210234549.2293917-1-luiz.dentz@gmail.com>
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
 drivers/bluetooth/btintel.c | 22 ++++++++++++
 drivers/bluetooth/btusb.c   | 69 +++++++++++++------------------------
 2 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 96bca89d1b99..6c45e86a8a72 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -947,6 +947,17 @@ int btintel_download_firmware(struct hci_dev *hdev,
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
index c92060e7472c..115a8ccb1468 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2469,11 +2469,17 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -2493,9 +2499,10 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
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
@@ -2550,7 +2557,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	if (ver->img_type == 0x03) {
 		clear_bit(BTUSB_BOOTLOADER, &data->flags);
 		btintel_check_bdaddr(hdev);
-		return 0;
 	}
 
 	/* Check for supported iBT hardware variants of this firmware
@@ -2694,35 +2700,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
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
@@ -2741,16 +2718,18 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
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
@@ -2778,6 +2757,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
 	}
 
+download:
 	/* With this Intel bootloader only the hardware variant and device
 	 * revision information are used to select the right firmware for SfP
 	 * and WsP.
@@ -2801,7 +2781,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	 */
 	err = btusb_setup_intel_new_get_fw_name(ver, params, fwname,
 						sizeof(fwname), "sfi");
-	if (!err) {
+	if (err < 0) {
 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
 		return -EINVAL;
 	}
@@ -2972,8 +2952,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	err = btusb_setup_intel_new_get_fw_name(&ver, &params, ddcname,
 						sizeof(ddcname), "ddc");
-
-	if (!err) {
+	if (err < 0) {
 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
 	} else {
 		/* Once the device is running in operational mode, it needs to
-- 
2.26.2


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7B8C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1076A64F23
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhCORkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhCORkH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 13:40:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC28C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:40:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so15185975pjg.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mTfGe/bRv70U2yhmAsuWuqD595RgXA33vM6u4cnpcgI=;
        b=Td0sNz1h+rkJCwVl9JlyDv5VSQEUBr2LWL6SZKqMa9BQz79LtomzqvesURFfbThAVJ
         eh0z7CW3yWo08/8026vcv6nePaH8OGmfyaSE2lpGx0SW8A8kcGhOUU1s2rPI/4UK2Fpq
         hd+79Mtm/O6Zzk/80uUIP6FqL3Yj+S6F/9uEmLfOY+aNrGy1+hhTCXaHeIi6rdxjlZkl
         FcihxyPdND4OfJnMMYjoxz8DEeqzjqd+4Wu00gTFo1YhbJiaeD9anNNvsDXCl2wYiAf8
         4ZtedLpQ4Om99L5dq06dwqeQT5x/gVMRBN0lxej/6lWd2FJ4kRX25fjZjeVJ2kUocSM8
         qUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTfGe/bRv70U2yhmAsuWuqD595RgXA33vM6u4cnpcgI=;
        b=dg5jqTi/tX+0OC/leDqBEs+dDD2o6YUGOOrRdmJGaXQanZ7eG+Vh7OQNrN0RFCRkpT
         +MfI3s706PZo4nWNkHTsvxXeido5J2R0rOhrmbwj8zcHwCbLWDRlzDx6S6puMkChYwSG
         lh4i640bY+IPZjn8bKOoDxLodlyBZwW42lYQBhpAFlpTchug3kNWusIKQJ9dAOAb4RsX
         I/WVzXanPiBsixnlGzZk4F/NILT39eJKgmJOXdjHAiZWufepGnF2r7s10chBG4G2WZ7a
         YIjlr/D4rh8ICaRxWK1jU6EvCBpwccClSXHZ//qOQP01dp3A1cms91MlbZ+N7a1IplXT
         AjfQ==
X-Gm-Message-State: AOAM532JqubZZtoW9sX/ymr19BHvpvHubhr4LsYb/Xdv/p9bLxqV5eQR
        mI0uaWTVi2R6T9oJM62r7cve66EUrSVaVg==
X-Google-Smtp-Source: ABdhPJzRO66taDIi9tceGXSIRR8+dIRgZYPXU8/J7aNGEeGtzj1vnaR7VICUuPJsucS+uph8rpL9FA==
X-Received: by 2002:a17:90a:9f43:: with SMTP id q3mr232614pjv.50.1615830007014;
        Mon, 15 Mar 2021 10:40:07 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id fa21sm246914pjb.25.2021.03.15.10.40.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:40:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v9 3/9] Bluetooth: btintel: Consolidate intel_version_tlv parsing
Date:   Mon, 15 Mar 2021 10:39:56 -0700
Message-Id: <20210315174002.1778447-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315174002.1778447-1-luiz.dentz@gmail.com>
References: <20210315174002.1778447-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves version checks of intel_version_tlv() to btintel_version_info_tlv().

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 50 ++++++++++++++++++++++++++++++---
 drivers/bluetooth/btintel.h |  2 +-
 drivers/bluetooth/btusb.c   | 56 ++-----------------------------------
 3 files changed, 50 insertions(+), 58 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 13bc93a986c7..bb2546c4374a 100644
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
index 2eaecba84bf5..2a1926552a50 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2523,15 +2523,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
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
@@ -2550,49 +2541,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
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
@@ -3030,7 +2978,9 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 		return err;
 	}
 
-	btintel_version_info_tlv(hdev, &version);
+	err = btintel_version_info_tlv(hdev, &version);
+	if (err)
+		return err;
 
 	err = btusb_intel_download_firmware_newgen(hdev, &version, &boot_param);
 	if (err)
-- 
2.30.2


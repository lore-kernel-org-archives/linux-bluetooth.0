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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114C1C433E9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 20:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E831F64EDA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 20:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhBJUUF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhBJUTf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 15:19:35 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C6C0613D6
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 12:18:55 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e7so1991900pge.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 12:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=B/POsKmKnFV5jQ0fMqMg4rKRc/b27kxxdqzC4QbvQ8g=;
        b=ArveozudV4arSDrnpS/edi8ydNI6RDi+ukRLdSA2zbtv/yjmwg1VL3z0/XRxWO8E3k
         wBW9T9eLPVrWw9aqcK00Ezx/ta5FmbbRVaLIjJWtrHz9FmFhAjl9Sy+ml1mya6NkXRW/
         v8SPNZmfOT5xp8EVhxlbUvPvsyA035wTNWephWYel8LOVlXquAKpEE+IQs0cfwm+RH3k
         W/POuUhNzTkxVK+f7uDBS9AjZ9Sz/bYfvrsGMF58FNrVRV1d4xs00AlhZmRhR72yPEBv
         yuOaRF9CaHQfsjJOXSZZvIl0NZDPzZCAlUR6P4OVvOSqA+iA6aVhCFc6bxLqTe51cLF2
         z4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/POsKmKnFV5jQ0fMqMg4rKRc/b27kxxdqzC4QbvQ8g=;
        b=h6oDcemAP2zE9viBxguWrn4SXEJuCN9CkwGZvPt+w2zM/tAJmZifDPpqWHF34a9w9u
         3CcNlQw0PWYvh+F4v/ZpOU9IcwbKzDseDjakN1Kec0Pc/UIu9p297zoO65vTqpD5ZgHA
         o6P8Qiv4/sJpr+Y/9wZiOl1SCgw/85zTXUHn7vEtNJsth6SnE73Owi/H9aDwIDeQPPK7
         yokRkveZQfGy5974EM5qEPnejRsMnGU8NQ6HIIuDFTKR37TJs9xgXzrtriyiQ3jy2NSG
         0F5k9reJOImpVUvCfXYj9TdOMaLocTb6k21iFRU76Ga26D+h687bwFvIVjUm323GM15D
         Fs2A==
X-Gm-Message-State: AOAM531jvTcvIZwkBRmpsJcSzKJ1rWwyC/Ecmww6hE8eovCE/5UucPkh
        GDJvorq88Ie2GM4eBekEwJ05c189jr5FUQ==
X-Google-Smtp-Source: ABdhPJyP9w+lqBVIPieoGjrb7C6J9DD/5p7U+GrWa8a7INh6usXyLmf/6nCS0MChyrfiARbEjQLCgg==
X-Received: by 2002:a65:4c4c:: with SMTP id l12mr4605197pgr.361.1612988335010;
        Wed, 10 Feb 2021 12:18:55 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id cu5sm3124696pjb.27.2021.02.10.12.18.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:18:54 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 3/6] Bluetooth: btintel: Consolidate intel_version_tlv parsing
Date:   Wed, 10 Feb 2021 12:18:49 -0800
Message-Id: <20210210201852.2246985-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210210201852.2246985-1-luiz.dentz@gmail.com>
References: <20210210201852.2246985-1-luiz.dentz@gmail.com>
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
index f9c1f78cd80a..169e7d0739d1 100644
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
@@ -3042,7 +2990,9 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
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


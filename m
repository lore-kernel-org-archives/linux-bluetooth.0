Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7123C433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 13:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92088208E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 13:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqO6Kn+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgINN2G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgINNZn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 09:25:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51C0C06178B
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 06:25:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so12618528pfn.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r4wEGA0i1h+TaaI8ogIOqXo9gZlNAqNjwv5dvfMH8kk=;
        b=eqO6Kn+N8c05rS9slIhX4PnaY7dkE1cO/fF7pc3OV4AZWVgs7MaiIfygP8Xl4EVCRg
         0r4YSI31FtQWM2+V3rBIdkQiqCVUQxTuNu7dbZnRP2/arUwB7px+63UxN0HG8bXRZ3Ve
         dVmdrPMke0F+V0ixrvNvEAzBNWPfSG9PDv5qn5I/LdH8CfDYrwmWGwpe5bKL5PDsyryf
         GXJDbLGlfn9YztBmOYkt8AZZLSwTEwaKqOd7fXaziqWNMxmLPdFHe+GO4fTpDinYjoTG
         h1Uc5xQtQLqjI5uThyO6CZSCR7prCDJ8lqesuOsIM6/7OmWxhJ0unm4VhGqXwgFfdSfs
         oO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r4wEGA0i1h+TaaI8ogIOqXo9gZlNAqNjwv5dvfMH8kk=;
        b=fskj/boE4R819vJ6JPK4f/1iLk+PqD5yR4oDWeQNh4izIKsaalMAa5jsHByH20kMWi
         N1KM5clCnsXoeOIqjNee9vK6np7+joQde7B6lEUgCPOLFN4LfDCymPdBvwiqTtx38rBN
         E9Zu9scC+RE7vmc5mmG52nRYiN/UxjMM0CHdYwBod2TLYIVWfcYxidsckI6GgugmP3VJ
         JCELhxG9hTAJ/vuak2r8T1JOtqUsDQPXByXmKIKY3N7kg+oCMg56AZOT9RPGq7iJkfwL
         LVaXMXFpkV0ey9IKGlatUNX5kj5Sx+EdBBz5Z7U5Ze6DEUhj5Ftg514iEt06W2kq5flT
         74vw==
X-Gm-Message-State: AOAM532jEbifldDC88hFWtkzmyeWSF91+O3YAwjYDwS38CG+UsFnV3mm
        letOIbUULL85QWQ+mi0AnzCQZvmQLEm/Hg==
X-Google-Smtp-Source: ABdhPJxlYeqiUhV9SAJ4vAVnYnMgwhLcs6M3HsG7DenGHV3z34D9IkhIKtsxfzv6U2OL0Ul4jU4B4g==
X-Received: by 2002:a62:8c86:: with SMTP id m128mr13387687pfd.111.1600089941491;
        Mon, 14 Sep 2020 06:25:41 -0700 (PDT)
Received: from localhost.localdomain ([171.61.74.206])
        by smtp.gmail.com with ESMTPSA id m20sm10776707pfa.115.2020.09.14.06.25.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2020 06:25:40 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        kiraank@gmail.com, Kiran K <kiran.k@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btintel: Functions to send firmware header / payload
Date:   Mon, 14 Sep 2020 18:55:06 +0530
Message-Id: <1600089906-9852-2-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600089906-9852-1-git-send-email-kiran.k@intel.com>
References: <1600089906-9852-1-git-send-email-kiran.k@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

New generation controllers supports ECDSA secure boot engine.
This patch adds,

1) function to send ECDSA header

2) function to download complete firmware for new generation Intel
   controllers

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btintel.c | 119 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h |  12 +++++
 2 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e99fc6e..88ce5f0 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -18,8 +18,11 @@
 
 #define VERSION "0.1"
 
-#define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
-#define RSA_HEADER_LEN	644
+#define BDADDR_INTEL		(&(bdaddr_t){{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
+#define RSA_HEADER_LEN		644
+#define CSS_HEADER_OFFSET	8
+#define ECDSA_OFFSET		644
+#define ECDSA_HEADER_LEN	320
 
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
@@ -801,6 +804,41 @@ static int btintel_sfi_rsa_header_secure_send(struct hci_dev *hdev,
 	return err;
 }
 
+static int btintel_sfi_ecdsa_header_secure_send(struct hci_dev *hdev,
+						const struct firmware *fw)
+{
+	int err;
+
+	/* Start the firmware download transaction with the Init fragment
+	 * represented by the 128 bytes of CSS header.
+	 */
+	err = btintel_secure_send(hdev, 0x00, 128, fw->data + 644);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send firmware header (%d)", err);
+		return err;
+	}
+
+	/* Send the 96 bytes of public key information from the firmware
+	 * as the PKey fragment.
+	 */
+	err = btintel_secure_send(hdev, 0x03, 96, fw->data + 644 + 128);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send firmware pkey (%d)", err);
+		return err;
+	}
+
+	/* Send the 96 bytes of signature information from the firmware
+	 * as the Sign fragment
+	 */
+	err = btintel_secure_send(hdev, 0x02, 96, fw->data + 644 + 224);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send firmware signature (%d)",
+			   err);
+		return err;
+	}
+	return 0;
+}
+
 static int btintel_download_firmware_payload(struct hci_dev *hdev,
 					     const struct firmware *fw,
 					     u32 *boot_param, size_t offset)
@@ -873,6 +911,83 @@ int btintel_download_firmware(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_download_firmware);
 
+int btintel_download_firmware_newgen(struct hci_dev *hdev,
+				     const struct firmware *fw, u32 *boot_param,
+				     u8 hw_variant, u8 sbe_type)
+{
+	int err;
+	u32 css_header_ver;
+
+	/* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
+	 * only RSA secure boot engine. Hence, the corresponding sfi file will
+	 * have RSA header of 644 bytes followed by Command Buffer.
+	 *
+	 * iBT hardware variants 0x17, 0x18 onwards support both RSA and ECDSA
+	 * secure boot engine. As a result, the corresponding sfi file will
+	 * have RSA header of 644, ECDSA header of 320 bytes followed by
+	 * Command Buffer.
+	 *
+	 * CSS Header byte positions 0x08 to 0x0B represent the CSS Header
+	 * version: RSA(0x00010000) , ECDSA (0x00020000)
+	 */
+	css_header_ver = get_unaligned_le32(fw->data + CSS_HEADER_OFFSET);
+	if (css_header_ver != 0x00010000) {
+		bt_dev_err(hdev, "Invalid CSS Header version");
+		return -EINVAL;
+	}
+
+	if (hw_variant <= 0x14) {
+		if (sbe_type != 0x00) {
+			bt_dev_err(hdev, "Invalid SBE type for hardware variant (%d)",
+				   hw_variant);
+			return -EINVAL;
+		}
+
+		err = btintel_sfi_rsa_header_secure_send(hdev, fw);
+		if (err)
+			return err;
+
+		err = btintel_download_firmware_payload(hdev, fw, boot_param, RSA_HEADER_LEN);
+		if (err)
+			return err;
+	} else if (hw_variant >= 0x17) {
+		/* Check if CSS header for ECDSA follows the RSA header */
+		if (fw->data[ECDSA_OFFSET] != 0x06)
+			return -EINVAL;
+
+		/* Check if the CSS Header version is ECDSA(0x00020000) */
+		css_header_ver = get_unaligned_le32(fw->data + ECDSA_OFFSET + CSS_HEADER_OFFSET);
+		if (css_header_ver != 0x00020000) {
+			bt_dev_err(hdev, "Invalid CSS Header version");
+			return -EINVAL;
+		}
+
+		if (sbe_type == 0x00) {
+			err = btintel_sfi_rsa_header_secure_send(hdev, fw);
+			if (err)
+				return err;
+
+			err = btintel_download_firmware_payload(hdev, fw,
+								boot_param,
+								RSA_HEADER_LEN + ECDSA_HEADER_LEN);
+			if (err)
+				return err;
+		} else if (sbe_type == 0x01) {
+			err = btintel_sfi_ecdsa_header_secure_send(hdev, fw);
+			if (err)
+				return err;
+
+			err = btintel_download_firmware_payload(hdev, fw,
+								boot_param,
+								RSA_HEADER_LEN + ECDSA_HEADER_LEN);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_download_firmware_newgen);
+
 void btintel_reset_to_bootloader(struct hci_dev *hdev)
 {
 	struct intel_reset params;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 829e1fc..09346ae 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -159,6 +159,10 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 			     struct intel_boot_params *params);
 int btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
 			      u32 *boot_param);
+int btintel_download_firmware_newgen(struct hci_dev *hdev,
+				     const struct firmware *fw,
+				     u32 *boot_param, u8 hw_variant,
+				     u8 sbe_type);
 void btintel_reset_to_bootloader(struct hci_dev *hdev);
 int btintel_read_debug_features(struct hci_dev *hdev,
 				struct intel_debug_features *features);
@@ -270,6 +274,14 @@ static inline int btintel_download_firmware(struct hci_dev *dev,
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_download_firmware_newgen(struct hci_dev *hdev,
+						   const struct firmware *fw,
+						   u32 *boot_param,
+						   u8 hw_variant, u8 sbe_type)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void btintel_reset_to_bootloader(struct hci_dev *hdev)
 {
 }
-- 
2.7.4


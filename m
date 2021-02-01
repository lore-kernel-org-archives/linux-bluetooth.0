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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37277C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Feb 2021 23:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E8664EBF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Feb 2021 23:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhBAXYq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Feb 2021 18:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhBAXYp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Feb 2021 18:24:45 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C7BC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Feb 2021 15:24:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id w18so12848534pfu.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Feb 2021 15:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4mSWtv2L9kQIcgjFEJbYk78OB5rzOA1IsuWOzjTmc0=;
        b=Nx+tC0jX7VgkTDoFbv69tYoPwPTQijAQqyvRaAwKG75OFzl+Ha7x8olZjFCzEAqlzV
         O27QGYDY8u4Dy2EXVAkUEMtbc/dCeyQPZUgOy0gSt7zfhVooJE+CXWMjDQ+TwFtZgo5Y
         jwA5jjRjXGxiAiURa2db8ZbjqzinOqwLMe3R95k4sA6DyXm9brFVyPV+QeySC0VKoKk6
         qPlM/QZOoPUxkJYuMe61mm3K4foSGJbTQ3q1I/a13+IAbaAy/EVvudIPxDl3zL3Jy42C
         46f+snut3sZ46k0hYUp2Z434vF/Kr6kes3YYmjQhv7j076Islsc3hwnWlZRQT2qFujVz
         E5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4mSWtv2L9kQIcgjFEJbYk78OB5rzOA1IsuWOzjTmc0=;
        b=Bl+98DuiYYKt7kOoTjyaoi/NHxX6/bTwdoFBF/jPYV1zngTNr379VtHjETmMaAViNL
         KTtZGZ/oGFpsb48BxbGJ2kV0ClHK/+B4AHg8+K+aFz8st2jYOuMT/QznZqkaEBfxyeON
         dl9fyLaG75PMI2V+c6Eje6mvnz80NOaG7rXgwM1onk6f13ELVCUIG853TlMEDeM84gwA
         7Wj0y4Axn4BBm0tdSIJgCTmvDiCHKLtm9pUIxAf4P1pY3PXiipHNHt+ry45zodd+sPQV
         UrzrxI5LgKHcu4Bte3jBQZaclyHBToeFfJW3H2qsjBNSOmiXwOAz0rWAVJgtKrtLp+LF
         9syw==
X-Gm-Message-State: AOAM531IjIySv8Cjk4r9UluhtF475dd+UXq0N9goAKk/1lZX6V1AWbsK
        IOIqjOmUv29SqDtpjKbiPEZRI6+yMEO/kw==
X-Google-Smtp-Source: ABdhPJyy2gjNuXdEOux4eMMtsrtbx6E1ynJxLdl7/8CvM+SWB6e/zuhtKDlBaDmashEfe1RxWbw9bg==
X-Received: by 2002:a62:1755:0:b029:1cb:4985:4cf8 with SMTP id 82-20020a6217550000b02901cb49854cf8mr12855130pfx.9.1612221843947;
        Mon, 01 Feb 2021 15:24:03 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 77sm18965956pfx.130.2021.02.01.15.24.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 15:24:03 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v2] Bluetooth: btintel: Check firmware version before download
Date:   Mon,  1 Feb 2021 15:24:02 -0800
Message-Id: <20210201232402.906223-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checking the firmware build number, week and years matches and then
skip the download process.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c   | 88 +++++++++++++++++++++++++++--------
 drivers/bluetooth/btintel.h   |  5 +-
 drivers/bluetooth/btusb.c     | 22 +++++----
 drivers/bluetooth/hci_intel.c |  2 +-
 4 files changed, 84 insertions(+), 33 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 88ce5f0ffc4b..bf7b910966c8 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -24,6 +24,14 @@
 #define ECDSA_OFFSET		644
 #define ECDSA_HEADER_LEN	320
 
+#define CMD_WRITE_BOOT_PARAMS	0xfc0e
+struct cmd_write_boot_params {
+	u32 boot_addr;
+	u8  fw_build_num;
+	u8  fw_build_ww;
+	u8  fw_build_yy;
+} _packed;
+
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -841,7 +849,7 @@ static int btintel_sfi_ecdsa_header_secure_send(struct hci_dev *hdev,
 
 static int btintel_download_firmware_payload(struct hci_dev *hdev,
 					     const struct firmware *fw,
-					     u32 *boot_param, size_t offset)
+					     size_t offset)
 {
 	int err;
 	const u8 *fw_ptr;
@@ -854,20 +862,6 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
 	while (fw_ptr - fw->data < fw->size) {
 		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
 
-		/* Each SKU has a different reset parameter to use in the
-		 * HCI_Intel_Reset command and it is embedded in the firmware
-		 * data. So, instead of using static value per SKU, check
-		 * the firmware data and save it for later use.
-		 */
-		if (le16_to_cpu(cmd->opcode) == 0xfc0e) {
-			/* The boot parameter is the first 32-bit value
-			 * and rest of 3 octets are reserved.
-			 */
-			*boot_param = get_unaligned_le32(fw_ptr + sizeof(*cmd));
-
-			bt_dev_dbg(hdev, "boot_param=0x%x", *boot_param);
-		}
-
 		frag_len += sizeof(*cmd) + cmd->plen;
 
 		/* The parameter length of the secure send command requires
@@ -896,28 +890,84 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
 	return err;
 }
 
+static bool btintel_firmware_version(struct hci_dev *hdev,
+				     u8 num, u8 ww, u8 yy,
+				     const struct firmware *fw,
+				     u32 *boot_addr)
+{
+	const u8 *fw_ptr;
+	u32 frag_len;
+
+	fw_ptr = fw->data;
+	frag_len = 0;
+
+	while (fw_ptr - fw->data < fw->size) {
+		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
+
+		/* Each SKU has a different reset parameter to use in the
+		 * HCI_Intel_Reset command and it is embedded in the firmware
+		 * data. So, instead of using static value per SKU, check
+		 * the firmware data and save it for later use.
+		 */
+		if (le16_to_cpu(cmd->opcode) == CMD_WRITE_BOOT_PARAMS) {
+			struct cmd_write_boot_params *params;
+
+			params = (void *)(fw_ptr + sizeof(*cmd));
+
+			bt_dev_dbg(hdev, "Boot Address: 0x%x\n"
+				   "Firmware Version: %u-%u.%u",
+				   le32_to_cpu(params->boot_addr),
+				   params->fw_build_num, params->fw_build_ww,
+				   params->fw_build_yy);
+
+			if (num == params->fw_build_num &&
+			    ww == params->fw_build_ww &&
+			    yy == params->fw_build_yy)
+				return true;
+			else
+				return false;
+		}
+
+		frag_len += sizeof(*cmd) + cmd->plen;
+	}
+
+	return false;
+}
+
 int btintel_download_firmware(struct hci_dev *hdev,
+			      struct intel_version *ver,
 			      const struct firmware *fw,
 			      u32 *boot_param)
 {
 	int err;
 
+	/* Skip download if firmware has the same version */
+	if (btintel_firmware_version(hdev, ver->fw_build_num, ver->fw_build_ww,
+				     ver->fw_build_yy, fw, boot_param))
+		return -EALREADY;
+
 	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
 	if (err)
 		return err;
 
-	return btintel_download_firmware_payload(hdev, fw, boot_param,
-						 RSA_HEADER_LEN);
+	return btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
 }
 EXPORT_SYMBOL_GPL(btintel_download_firmware);
 
 int btintel_download_firmware_newgen(struct hci_dev *hdev,
+				     struct intel_version_tlv *ver,
 				     const struct firmware *fw, u32 *boot_param,
 				     u8 hw_variant, u8 sbe_type)
 {
 	int err;
 	u32 css_header_ver;
 
+	/* Skip download if firmware has the same version */
+	if (btintel_firmware_version(hdev, ver->min_fw_build_nn,
+				     ver->min_fw_build_cw, ver->min_fw_build_yy,
+				     fw, boot_param))
+		return -EALREADY;
+
 	/* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
 	 * only RSA secure boot engine. Hence, the corresponding sfi file will
 	 * have RSA header of 644 bytes followed by Command Buffer.
@@ -947,7 +997,7 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
 		if (err)
 			return err;
 
-		err = btintel_download_firmware_payload(hdev, fw, boot_param, RSA_HEADER_LEN);
+		err = btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
 		if (err)
 			return err;
 	} else if (hw_variant >= 0x17) {
@@ -968,7 +1018,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
 				return err;
 
 			err = btintel_download_firmware_payload(hdev, fw,
-								boot_param,
 								RSA_HEADER_LEN + ECDSA_HEADER_LEN);
 			if (err)
 				return err;
@@ -978,7 +1027,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
 				return err;
 
 			err = btintel_download_firmware_payload(hdev, fw,
-								boot_param,
 								RSA_HEADER_LEN + ECDSA_HEADER_LEN);
 			if (err)
 				return err;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 6511b091caf5..51f1f2c883b4 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -163,9 +163,10 @@ struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
 int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param);
 int btintel_read_boot_params(struct hci_dev *hdev,
 			     struct intel_boot_params *params);
-int btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
-			      u32 *boot_param);
+int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
+			      const struct firmware *fw, u32 *boot_param);
 int btintel_download_firmware_newgen(struct hci_dev *hdev,
+				     struct intel_version_tlv *ver,
 				     const struct firmware *fw,
 				     u32 *boot_param, u8 hw_variant,
 				     u8 sbe_type);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4266c057746e..a06e86f52da3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2612,14 +2612,15 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
-	err = btintel_download_firmware_newgen(hdev, fw, boot_param,
+	err = btintel_download_firmware_newgen(hdev, ver, fw, boot_param,
 					       INTEL_HW_VARIANT(ver->cnvi_bt),
 					       ver->sbe_type);
 	if (err < 0) {
-		/* When FW download fails, send Intel Reset to retry
-		 * FW download.
-		 */
-		btintel_reset_to_bootloader(hdev);
+		if (err != -EALREADY)
+			/* When FW download fails, send Intel Reset to retry
+			 * FW download.
+			 */
+			btintel_reset_to_bootloader(hdev);
 		goto done;
 	}
 	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
@@ -2806,12 +2807,13 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
-	err = btintel_download_firmware(hdev, fw, boot_param);
+	err = btintel_download_firmware(hdev, ver, fw, boot_param);
 	if (err < 0) {
-		/* When FW download fails, send Intel Reset to retry
-		 * FW download.
-		 */
-		btintel_reset_to_bootloader(hdev);
+		if (err != -EALREADY)
+			/* When FW download fails, send Intel Reset to retry
+			 * FW download.
+			 */
+			btintel_reset_to_bootloader(hdev);
 		goto done;
 	}
 	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index b20a40fab83e..050fae33dab8 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -735,7 +735,7 @@ static int intel_setup(struct hci_uart *hu)
 	set_bit(STATE_DOWNLOADING, &intel->flags);
 
 	/* Start firmware downloading and get boot parameter */
-	err = btintel_download_firmware(hdev, fw, &boot_param);
+	err = btintel_download_firmware(hdev, &ver, fw, &boot_param);
 	if (err < 0)
 		goto done;
 
-- 
2.26.2


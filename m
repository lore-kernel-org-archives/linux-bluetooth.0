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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3841C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 17:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF6664DDF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 17:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhBJRAI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbhBJQ76 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 11:59:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28889C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 08:59:19 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gb24so1446063pjb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 08:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fe7snvMbur/GMho7ioOBNYhhcaWSxhGC2Oyoz7AsCfs=;
        b=R1hVpe2FlaT3n2GF3NrACrtpZ6DsKDJNossGUlBSn5MO2Y7UQF8wKhUKq/mx27IPT/
         EyFAmJKkZx5glBOpC1xGmTsLQvZU7SwhECB1nLwUt3ZAZr8Li2dTsUMwyqnpiysis+yC
         pt/BdpL4TEpcNTvzyOW2VQ67eKt7YlKxCBCjDy28fFD9YJ/iaZjTu9c0VspaDHE5bUrj
         OPkU3HuF2PMR4NZRFj3YSf4kp2cZn/BdZgjpH5LYdeJ9F6Rog3sVDuoTWc9WKMAusbPI
         VYGNTDyqxAVoo2aVA8SH/0zyeF6CmKStlzG0opU+GMxJbOKLHUZJsTXMEU9+dXO2wEbJ
         Y8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fe7snvMbur/GMho7ioOBNYhhcaWSxhGC2Oyoz7AsCfs=;
        b=GDvHGqKXtFyD/AG0oAYzU6EHeYcIL1qeW6lGgGylh6yU2S8hlXvES4CCh4s8qYa7rE
         ibAPPFqfldRv6dS6cIVUa8mBq4E0QfI0APahAWqBNichyDLleDa+EdysRVkRsq0IsHbW
         hURD9U0KiokOKS8TiZdtrFQ9Tc210fPXO5Z0edS6UnTIDiB2pmV/qVLNEsAMq4wAjHtI
         Ltu4FpROsvzPjSZmpzMJoW3FDbvGzlgtX9iClcRc940A2x3/w04uZ1U5EA95i6IShYBP
         Nu/XHzjknJKgZYjWq6VM0ScTbWHEhrzktSoEZlfwdOyK2RcNxP18UbXPNXJI/O62PG51
         rKkA==
X-Gm-Message-State: AOAM531YFIebshV1KB2sA8pAp1RHG9hbMEPxojGvOD30O7lw8ngZbdnK
        1blTx+2522e4buAKGirgFXo4Us4Q0IDcwA==
X-Google-Smtp-Source: ABdhPJwnofB6sPiaZNDaXEMwS4B2wgISESqWPflKCpEu9d35EoGdUisFoo1sm1XnFATG2IsbpVRBNA==
X-Received: by 2002:a17:90b:3692:: with SMTP id mj18mr3925687pjb.83.1612976358157;
        Wed, 10 Feb 2021 08:59:18 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id cu5sm2881492pjb.27.2021.02.10.08.59.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:59:17 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/6] Bluetooth: btintel: Check firmware version before download
Date:   Wed, 10 Feb 2021 08:59:11 -0800
Message-Id: <20210210165916.2148856-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks the firmware build number, week and year matches with
repective version loaded and then skip the download process.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Add patch that mover checks for operational mode after the version
checking.
v3: Fix not checking for operation mode before using btintel_read_boot_params
since some models depend on that to contruct the fw filename. Also attempt to
cleanup duplicated code.
v4: Fix forwarding -EALREADY when firmware has already been loaded.

 drivers/bluetooth/btintel.c   | 96 +++++++++++++++++++++++++++--------
 drivers/bluetooth/btintel.h   |  5 +-
 drivers/bluetooth/btusb.c     | 18 ++++++-
 drivers/bluetooth/hci_intel.c |  7 ++-
 4 files changed, 100 insertions(+), 26 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 88ce5f0ffc4b..89f85d54ca64 100644
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
+} __packed;
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
@@ -896,28 +890,92 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
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
+			bt_dev_info(hdev, "Boot Address: 0x%x",
+				   le32_to_cpu(params->boot_addr));
+
+			bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
+				   params->fw_build_num, params->fw_build_ww,
+				   params->fw_build_yy);
+
+			return (num == params->fw_build_num &&
+				ww == params->fw_build_ww &&
+				yy == params->fw_build_yy);
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
+				     ver->fw_build_yy, fw, boot_param)) {
+		bt_dev_info(hdev, "Firmware already loaded");
+		/* Return -EALREADY to indicate that the firmware has already
+		 * been loaded.
+		 */
+		return -EALREADY;
+	}
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
+				     fw, boot_param)) {
+		bt_dev_info(hdev, "Firmware already loaded");
+		/* Return -EALREADY to indicate that firmware has already been
+		 * loaded.
+		 */
+		return -EALREADY;
+	}
+
 	/* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
 	 * only RSA secure boot engine. Hence, the corresponding sfi file will
 	 * have RSA header of 644 bytes followed by Command Buffer.
@@ -947,7 +1005,7 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
 		if (err)
 			return err;
 
-		err = btintel_download_firmware_payload(hdev, fw, boot_param, RSA_HEADER_LEN);
+		err = btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
 		if (err)
 			return err;
 	} else if (hw_variant >= 0x17) {
@@ -968,7 +1026,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
 				return err;
 
 			err = btintel_download_firmware_payload(hdev, fw,
-								boot_param,
 								RSA_HEADER_LEN + ECDSA_HEADER_LEN);
 			if (err)
 				return err;
@@ -978,7 +1035,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
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
index 66ada8217797..c92060e7472c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2623,10 +2623,17 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
-	err = btintel_download_firmware_newgen(hdev, fw, boot_param,
+	err = btintel_download_firmware_newgen(hdev, ver, fw, boot_param,
 					       INTEL_HW_VARIANT(ver->cnvi_bt),
 					       ver->sbe_type);
 	if (err < 0) {
+		if (err == -EALREADY) {
+			/* Firmware has already been loaded */
+			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+			err = 0;
+			goto done;
+		}
+
 		/* When FW download fails, send Intel Reset to retry
 		 * FW download.
 		 */
@@ -2817,8 +2824,15 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
 	/* Start firmware downloading and get boot parameter */
-	err = btintel_download_firmware(hdev, fw, boot_param);
+	err = btintel_download_firmware(hdev, ver, fw, boot_param);
 	if (err < 0) {
+		if (err == -EALREADY) {
+			/* Firmware has already been loaded */
+			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+			err = 0;
+			goto done;
+		}
+
 		/* When FW download fails, send Intel Reset to retry
 		 * FW download.
 		 */
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index b20a40fab83e..7249b91d9b91 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -735,7 +735,7 @@ static int intel_setup(struct hci_uart *hu)
 	set_bit(STATE_DOWNLOADING, &intel->flags);
 
 	/* Start firmware downloading and get boot parameter */
-	err = btintel_download_firmware(hdev, fw, &boot_param);
+	err = btintel_download_firmware(hdev, &ver, fw, &boot_param);
 	if (err < 0)
 		goto done;
 
@@ -784,7 +784,10 @@ static int intel_setup(struct hci_uart *hu)
 done:
 	release_firmware(fw);
 
-	if (err < 0)
+	/* Check if there was an error and if is not -EALREADY which means the
+	 * firmware has already been loaded.
+	 */
+	if (err < 0 && err != -EALREADY)
 		return err;
 
 	/* We need to restore the default speed before Intel reset */
-- 
2.26.2


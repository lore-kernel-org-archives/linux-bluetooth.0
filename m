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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC884C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3160619B3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhCWS7Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhCWS7G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 14:59:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AB7C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so12623200pjc.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5S35RqV/iyjjUKRd30CMkCYafAi58/svbRji+isuYwo=;
        b=sCOL4KuGzF1HSTJu0Owrp26d3/wKbinPHmPUG92EdUnrdVUydcDCFbw3JhIjEZHhTT
         ZKq+Hms3em3JUoSDTkY1Fyw01ZWpCaw+eg61+G6NV87IEfYnsLtQtTiUT7KRU6TlbR+J
         e14JbbjFdLsLw1vcQhcmExBwbxwiC6ZiPWG2R8V/hBDosbKi+1EIz7tAWfFgjsCWnhuO
         bf9K9PbD3sTf5y149G1ILyBk2hxxBD/5TuUHm6SdtBshna3Da0AlY1FqCAzVSCD0MTh2
         kSnLjfTrvP+vI5iywMKhwpC3V8H9HohEnEmlbE3SyYcqBSRcgOwke+DOBv1VbZFDm+Bi
         l4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5S35RqV/iyjjUKRd30CMkCYafAi58/svbRji+isuYwo=;
        b=R8WTwQR+KXBZiUaVjPaiJKubeueuEREB9zfoAiEYpkt2HaKCWUeIDyyeItSGnRwHFr
         BN9i3OzgXJypMwgXu832C3TO07XL2eI1VcnUrt0p7Jii70tgo45kqTLoZOyCFLEqbSNh
         DMUnNVWjcJgVshz5X9FzRQ+SWt67SKhpfXemeGbCEb5lb9Mzu+O3br5IlRn6mOqTaVnD
         RaD3SqN6twa3eW4o5e7E+6EvAz4Z07lHCqPz7moxVHcJuaBpaocfYYHN3u9cwc2KL684
         yRpnknJFwTgSW44bYXPKCQwxCECKSvScBWhyB0VRaUvMtGJjzH+Idvc7vPcSOewU8cd/
         MkwQ==
X-Gm-Message-State: AOAM532u+ZinsbLX3RxpDfTvrNo7ALbixhtKhPA+78n+iygipDZUBb2z
        5dmYeJ2MGwndqM3avH0bJ8Af507wPE4VfA==
X-Google-Smtp-Source: ABdhPJzfawyJeUP1bsKjbO1OmzBL51h8jzJpNAmnn6wkFGHdgHTOGTJU31zUtlqfBlIZnRLY3sb/4w==
X-Received: by 2002:a17:90a:d341:: with SMTP id i1mr5700780pjx.74.1616525945615;
        Tue, 23 Mar 2021 11:59:05 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b10sm16132325pgm.76.2021.03.23.11.59.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 11:59:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 1/9] Bluetooth: btintel: Check firmware version before download
Date:   Tue, 23 Mar 2021 11:58:56 -0700
Message-Id: <20210323185904.3372987-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks the firmware build number, week and year against the
repective loaded version. If details are a match, skip the download
process.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Add patch that mover checks for operational mode after the version
checking.
v3: Fix not checking for operation mode before using btintel_read_boot_params
since some models depend on that to contruct the fw filename. Also attempt to
cleanup duplicated code.
v4: Fix forwarding -EALREADY when firmware has already been loaded.
v5: Fix not advancing fw_ptr.
v6: Fix btusb_setup_intel_new_get_fw_name error checking for ddc.
v7: Disable version checking for WsP/SfP.
v8: Really disables version checking for WsP/SfP.
v9: Reintroduce bootloader checks and add workaround for version checking when
operation and version cannot be read.
v10: Fix build error when BT_CONFIG_INTEL is not set.

 drivers/bluetooth/btintel.c   | 106 +++++++++++++++++++++++++++-------
 drivers/bluetooth/btintel.h   |   5 +-
 drivers/bluetooth/btusb.c     |  18 +++++-
 drivers/bluetooth/hci_intel.c |   7 ++-
 4 files changed, 109 insertions(+), 27 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index fa97324454ea..3ff698a0bd25 100644
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
@@ -854,21 +862,6 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
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
-			*boot_param = get_unaligned_le32(fw_ptr + frag_len +
-							 sizeof(*cmd));
-
-			bt_dev_dbg(hdev, "boot_param=0x%x", *boot_param);
-		}
-
 		frag_len += sizeof(*cmd) + cmd->plen;
 
 		/* The parameter length of the secure send command requires
@@ -897,28 +890,101 @@ static int btintel_download_firmware_payload(struct hci_dev *hdev,
 	return err;
 }
 
+static bool btintel_firmware_version(struct hci_dev *hdev,
+				     u8 num, u8 ww, u8 yy,
+				     const struct firmware *fw,
+				     u32 *boot_addr)
+{
+	const u8 *fw_ptr;
+
+	fw_ptr = fw->data;
+
+	while (fw_ptr - fw->data < fw->size) {
+		struct hci_command_hdr *cmd = (void *)(fw_ptr);
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
+				    le32_to_cpu(params->boot_addr));
+
+			bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
+				    params->fw_build_num, params->fw_build_ww,
+				    params->fw_build_yy);
+
+			return (num == params->fw_build_num &&
+				ww == params->fw_build_ww &&
+				yy == params->fw_build_yy);
+		}
+
+		fw_ptr += sizeof(*cmd) + cmd->plen;
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
 
+	/* SfP and WsP don't seem to update the firmware version on file
+	 * so version checking is currently not possible.
+	 */
+	switch (ver->hw_variant) {
+	case 0x0b:	/* SfP */
+	case 0x0c:	/* WsP */
+		/* Skip version checking */
+		break;
+	default:
+		/* Skip download if firmware has the same version */
+		if (btintel_firmware_version(hdev, ver->fw_build_num,
+					     ver->fw_build_ww, ver->fw_build_yy,
+					     fw, boot_param)) {
+			bt_dev_info(hdev, "Firmware already loaded");
+			/* Return -EALREADY to indicate that the firmware has
+			 * already been loaded.
+			 */
+			return -EALREADY;
+		}
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
@@ -948,7 +1014,7 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
 		if (err)
 			return err;
 
-		err = btintel_download_firmware_payload(hdev, fw, boot_param, RSA_HEADER_LEN);
+		err = btintel_download_firmware_payload(hdev, fw, RSA_HEADER_LEN);
 		if (err)
 			return err;
 	} else if (hw_variant >= 0x17) {
@@ -969,7 +1035,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
 				return err;
 
 			err = btintel_download_firmware_payload(hdev, fw,
-								boot_param,
 								RSA_HEADER_LEN + ECDSA_HEADER_LEN);
 			if (err)
 				return err;
@@ -979,7 +1044,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
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
index 0d355bb45e08..de220ab7f231 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2557,10 +2557,17 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
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
@@ -2752,8 +2759,15 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
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
2.30.2


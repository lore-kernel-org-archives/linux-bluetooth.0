Return-Path: <SRS0=CDO+=DV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F866C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 12:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEC520848
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 12:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB8qfY/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbgJNM3D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Oct 2020 08:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbgJNM3D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Oct 2020 08:29:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30E3C0613D2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 05:29:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n14so1889189pff.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F+XP8vytQQ4d23/wZSRYuvhzk147xUDt8MC3FL0S8ek=;
        b=AB8qfY/KFi8P59Nzf8WhNjAXFTPvP2fMaJj6TpR3Hsj9ZSWq1eLehosfgqqB/0Hqw9
         dBWQBYi9wgMPdSFt+ey+FaVNTevKC5zCpjho9z6mGNm6ssoY/HfOxWTOl1OJ0XjlyA14
         CyemirvScAZ8m/s2dgqqhZjZstEDxOaVjQYMnvChNaDGvpTMY7rGmqSMTQYON+2GPtAH
         30hrZ95Pb00WyjB8JWamNYW+9N4M139lwMdApulYD/TCDR3EmMNrCuUBw/pMHdRSRySr
         d2mYYY+og5iGm9Qzr7rPjA3/pjv++cEyDwEyKYxyJ842ewG5NU0SUq7G+WpErKUI9yyJ
         EE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F+XP8vytQQ4d23/wZSRYuvhzk147xUDt8MC3FL0S8ek=;
        b=T+dG3WO6Id0sCNFNWuiO3USVRKQsDHhIsJQIFizvZGN4cSKeKbXO1VarVTwLjLO8ju
         0FfGB8Hv9f4R1FEzabJbrnU1ki9xHNjzmm+roRtHyVCWNC9wiWwaK+nCY+HpG1/snvHr
         0IZlwr+m/A7xkMqwFFLGEt1HsubjL5te0SSJfGlJ0z6ybfjXIIe8jbpoHgyMrL9O79zV
         /rIoMoZVqfywLRuR2FUzwPMQ+L5SuuuvbkPYxH7DKp5peedzb23ChbhW1/gImK2zHB2E
         54UGj9Qjthj+GWvF2qvwIEoUkOHuhZkbFcu9brJzBv82AMLguoH0uyJXH7wju7B1b1dK
         grZQ==
X-Gm-Message-State: AOAM530nfsTfmqaxb15VUHV+GhZe8wH5jnl/QuCujyfv2O+J/zEGndE4
        OeBemQWyDGeJOlcqLPJ/Gy5zAiTai2jF8j8c
X-Google-Smtp-Source: ABdhPJzC6Ea0Y/P4r7ss8sT1sWVdZHxxyEYeUklfJccDzYpgRhWYT2xCfhsERSDa7N2YCykUOgp3Jw==
X-Received: by 2002:a63:c342:: with SMTP id e2mr3638654pgd.56.1602678542163;
        Wed, 14 Oct 2020 05:29:02 -0700 (PDT)
Received: from localhost.localdomain ([122.179.122.132])
        by smtp.gmail.com with ESMTPSA id r16sm2930000pjo.19.2020.10.14.05.29.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 05:29:01 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v7 3/4] Bluetooth: btusb: Helper function to download firmware to Intel adapters
Date:   Wed, 14 Oct 2020 17:58:36 +0530
Message-Id: <1602678517-9912-3-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602678517-9912-1-git-send-email-kiran.k@intel.com>
References: <1602678517-9912-1-git-send-email-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Define a helper function to download firmware for new generation Intel
controllers

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
---
 drivers/bluetooth/btusb.c | 165 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ac532dd..5d68cdb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2375,6 +2375,167 @@ static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv
 		 suffix);
 }
 
+static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
+						struct intel_version_tlv *ver,
+						u32 *boot_param)
+{
+	const struct firmware *fw;
+	char fwname[64];
+	int err;
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	if (!ver || !boot_param)
+		return -EINVAL;
+
+	/* The hardware platform number has a fixed value of 0x37 and
+	 * for now only accept this single value.
+	 */
+	if (INTEL_HW_PLATFORM(ver->cnvi_bt) != 0x37) {
+		bt_dev_err(hdev, "Unsupported Intel hardware platform (0x%2x)",
+			   INTEL_HW_PLATFORM(ver->cnvi_bt));
+		return -EINVAL;
+	}
+
+	/* The firmware variant determines if the device is in bootloader
+	 * mode or is running operational firmware. The value 0x03 identifies
+	 * the bootloader and the value 0x23 identifies the operational
+	 * firmware.
+	 *
+	 * When the operational firmware is already present, then only
+	 * the check for valid Bluetooth device address is needed. This
+	 * determines if the device will be added as configured or
+	 * unconfigured controller.
+	 *
+	 * It is not possible to use the Secure Boot Parameters in this
+	 * case since that command is only available in bootloader mode.
+	 */
+	if (ver->img_type == 0x03) {
+		clear_bit(BTUSB_BOOTLOADER, &data->flags);
+		btintel_check_bdaddr(hdev);
+		return 0;
+	}
+
+	/* Check for supported iBT hardware variants of this firmware
+	 * loading method.
+	 *
+	 * This check has been put in place to ensure correct forward
+	 * compatibility options when newer hardware variants come along.
+	 */
+	switch (INTEL_HW_VARIANT(ver->cnvi_bt)) {
+	case 0x17:	/* TyP */
+	case 0x18:	/* Slr */
+	case 0x19:	/* Slr-F */
+		break;
+	default:
+		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
+			   INTEL_HW_VARIANT(ver->cnvi_bt));
+		return -EINVAL;
+	}
+
+	/* If the device is not in bootloader mode, then the only possible
+	 * choice is to return an error and abort the device initialization.
+	 */
+	if (ver->img_type != 0x01) {
+		bt_dev_err(hdev, "Unsupported Intel firmware variant (0x%x)",
+			   ver->img_type);
+		return -ENODEV;
+	}
+
+	/* It is required that every single firmware fragment is acknowledged
+	 * with a command complete event. If the boot parameters indicate
+	 * that this bootloader does not send them, then abort the setup.
+	 */
+	if (ver->limited_cce != 0x00) {
+		bt_dev_err(hdev, "Unsupported Intel firmware loading method (0x%x)",
+			   ver->limited_cce);
+		return -EINVAL;
+	}
+
+	/* Secure boot engine type should be either 1 (ECDSA) or 0 (RSA) */
+	if (ver->sbe_type > 0x01) {
+		bt_dev_err(hdev, "Unsupported Intel secure boot engine type (0x%x)",
+			   ver->sbe_type);
+		return -EINVAL;
+	}
+
+	/* If the OTP has no valid Bluetooth device address, then there will
+	 * also be no valid address for the operational firmware.
+	 */
+	if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
+		bt_dev_info(hdev, "No device address configured");
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	}
+
+	btusb_setup_intel_newgen_get_fw_name(ver, fwname, sizeof(fwname), "sfi");
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to load Intel firmware file (%d)", err);
+		return err;
+	}
+
+	bt_dev_info(hdev, "Found device firmware: %s", fwname);
+
+	if (fw->size < 644) {
+		bt_dev_err(hdev, "Invalid size of firmware file (%zu)",
+			   fw->size);
+		err = -EBADF;
+		goto done;
+	}
+
+	set_bit(BTUSB_DOWNLOADING, &data->flags);
+
+	/* Start firmware downloading and get boot parameter */
+	err = btintel_download_firmware_newgen(hdev, fw, boot_param,
+					       INTEL_HW_VARIANT(ver->cnvi_bt),
+					       ver->sbe_type);
+	if (err < 0) {
+		/* When FW download fails, send Intel Reset to retry
+		 * FW download.
+		 */
+		btintel_reset_to_bootloader(hdev);
+		goto done;
+	}
+	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+
+	bt_dev_info(hdev, "Waiting for firmware download to complete");
+
+	/* Before switching the device into operational mode and with that
+	 * booting the loaded firmware, wait for the bootloader notification
+	 * that all fragments have been successfully received.
+	 *
+	 * When the event processing receives the notification, then the
+	 * BTUSB_DOWNLOADING flag will be cleared.
+	 *
+	 * The firmware loading should not take longer than 5 seconds
+	 * and thus just timeout if that happens and fail the setup
+	 * of this device.
+	 */
+	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(5000));
+	if (err == -EINTR) {
+		bt_dev_err(hdev, "Firmware loading interrupted");
+		goto done;
+	}
+
+	if (err) {
+		bt_dev_err(hdev, "Firmware loading timeout");
+		err = -ETIMEDOUT;
+		btintel_reset_to_bootloader(hdev);
+		goto done;
+	}
+
+	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
+		bt_dev_err(hdev, "Firmware loading failed");
+		err = -ENOEXEC;
+		goto done;
+	}
+
+done:
+	release_firmware(fw);
+	return err;
+}
+
 static int btusb_intel_download_firmware(struct hci_dev *hdev,
 					 struct intel_version *ver,
 					 struct intel_boot_params *params,
@@ -2743,7 +2904,9 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 
 	btintel_version_info_tlv(hdev, &version);
 
-	/* TODO: Plugin in code here to download firmware */
+	err = btusb_intel_download_firmware_newgen(hdev, &version, &boot_param);
+	if (err)
+		return err;
 
 	/* check if controller is already having an operational firmware */
 	if (version.img_type == 0x03)
-- 
2.7.4


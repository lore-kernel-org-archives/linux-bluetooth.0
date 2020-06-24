Return-Path: <SRS0=JtDF=AF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E56CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 18:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABE820767
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Jun 2020 18:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406139AbgFXSdh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:33:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:6951 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405581AbgFXSdh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Jun 2020 14:33:37 -0400
IronPort-SDR: mEYx0wriW+qMufwTxmcCG88Fght/H6QrVuZITzaRwGbzu0ErCC0Gesut6dbHugow2JqsS0NIvP
 qZUi2ehIpJdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="142807123"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="142807123"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 11:33:34 -0700
IronPort-SDR: gk0yVSDbxKiG4YY9ulzDheaJLJzRVxVLC1a1er1GyNTDJxoQykuhqvoVZ2w9c0opdNbO5ysK4G
 XyxWMQntQxqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="263711197"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jun 2020 11:33:33 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH 1/1] Bluetooth: btusb: Refactor of firmware download flow for Intel conrollers
Date:   Thu, 25 Jun 2020 00:04:32 +0530
Message-Id: <20200624183432.1356-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624183432.1356-1-kiran.k@intel.com>
References: <20200624183432.1356-1-kiran.k@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Address the scalability to support new generation Intel controller with
respect to readability and enhancement to new firmware download sequence

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
---
 drivers/bluetooth/btusb.c | 146 +++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 66 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e42fdd625eb0..d8c429e37d8a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -511,7 +511,6 @@ struct btusb_data {
 	unsigned cmd_timeout_cnt;
 };
 
-
 static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2262,46 +2261,25 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 	return true;
 }
 
-static int btusb_setup_intel_new(struct hci_dev *hdev)
+static int btusb_intel_download_firmware(struct hci_dev *hdev,
+					 struct intel_version *ver,
+					 struct intel_boot_params *params)
 {
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct intel_version ver;
-	struct intel_boot_params params;
-	struct intel_debug_features features;
 	const struct firmware *fw;
 	u32 boot_param;
 	char fwname[64];
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
 	int err;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 
-	BT_DBG("%s", hdev->name);
-
-	/* Set the default boot parameter to 0x0 and it is updated to
-	 * SKU specific boot parameter after reading Intel_Write_Boot_Params
-	 * command while downloading the firmware.
-	 */
-	boot_param = 0x00000000;
-
-	calltime = ktime_get();
-
-	/* Read the Intel version information to determine if the device
-	 * is in bootloader mode or if it already has operational firmware
-	 * loaded.
-	 */
-	err = btintel_read_version(hdev, &ver);
-	if (err) {
-		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
-		btintel_reset_to_bootloader(hdev);
-		return err;
-	}
+	if (!ver || !params)
+		return -EINVAL;
 
 	/* The hardware platform number has a fixed value of 0x37 and
 	 * for now only accept this single value.
 	 */
-	if (ver.hw_platform != 0x37) {
+	if (ver->hw_platform != 0x37) {
 		bt_dev_err(hdev, "Unsupported Intel hardware platform (%u)",
-			   ver.hw_platform);
+			   ver->hw_platform);
 		return -EINVAL;
 	}
 
@@ -2311,7 +2289,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * This check has been put in place to ensure correct forward
 	 * compatibility options when newer hardware variants come along.
 	 */
-	switch (ver.hw_variant) {
+	switch (ver->hw_variant) {
 	case 0x0b:	/* SfP */
 	case 0x0c:	/* WsP */
 	case 0x11:	/* JfP */
@@ -2321,11 +2299,11 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
-			   ver.hw_variant);
+			   ver->hw_variant);
 		return -EINVAL;
 	}
 
-	btintel_version_info(hdev, &ver);
+	btintel_version_info(hdev, ver);
 
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
@@ -2340,25 +2318,25 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * It is not possible to use the Secure Boot Parameters in this
 	 * case since that command is only available in bootloader mode.
 	 */
-	if (ver.fw_variant == 0x23) {
+	if (ver->fw_variant == 0x23) {
 		clear_bit(BTUSB_BOOTLOADER, &data->flags);
 		btintel_check_bdaddr(hdev);
-		goto finish;
+		return 0;
 	}
 
 	/* If the device is not in bootloader mode, then the only possible
 	 * choice is to return an error and abort the device initialization.
 	 */
-	if (ver.fw_variant != 0x06) {
+	if (ver->fw_variant != 0x06) {
 		bt_dev_err(hdev, "Unsupported Intel firmware variant (%u)",
-			   ver.fw_variant);
+			   ver->fw_variant);
 		return -ENODEV;
 	}
 
 	/* Read the secure boot parameters to identify the operating
 	 * details of the bootloader.
 	 */
-	err = btintel_read_boot_params(hdev, &params);
+	err = btintel_read_boot_params(hdev, params);
 	if (err)
 		return err;
 
@@ -2366,16 +2344,16 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * with a command complete event. If the boot parameters indicate
 	 * that this bootloader does not send them, then abort the setup.
 	 */
-	if (params.limited_cce != 0x00) {
+	if (params->limited_cce != 0x00) {
 		bt_dev_err(hdev, "Unsupported Intel firmware loading method (%u)",
-			   params.limited_cce);
+			   params->limited_cce);
 		return -EINVAL;
 	}
 
 	/* If the OTP has no valid Bluetooth device address, then there will
 	 * also be no valid address for the operational firmware.
 	 */
-	if (!bacmp(&params.otp_bdaddr, BDADDR_ANY)) {
+	if (!bacmp(&params->otp_bdaddr, BDADDR_ANY)) {
 		bt_dev_info(hdev, "No device address configured");
 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
 	}
@@ -2401,7 +2379,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
 	 *
 	 */
-	err = btusb_setup_intel_new_get_fw_name(&ver, &params, fwname,
+	err = btusb_setup_intel_new_get_fw_name(ver, params, fwname,
 						sizeof(fwname), "sfi");
 	if (!err) {
 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
@@ -2416,16 +2394,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	bt_dev_info(hdev, "Found device firmware: %s", fwname);
 
-	/* Save the DDC file name for later use to apply once the firmware
-	 * downloading is done.
-	 */
-	err = btusb_setup_intel_new_get_fw_name(&ver, &params, fwname,
-						sizeof(fwname), "ddc");
-	if (!err) {
-		bt_dev_err(hdev, "Unsupported Intel firmware naming");
-		return -EINVAL;
-	}
-
 	if (fw->size < 644) {
 		bt_dev_err(hdev, "Invalid size of firmware file (%zu)",
 			   fw->size);
@@ -2480,18 +2448,58 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		goto done;
 	}
 
+done:
+	release_firmware(fw);
+	return err;
+}
+
+static int btusb_setup_intel_new(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct intel_version ver;
+	struct intel_boot_params params;
+	u32 boot_param;
+	char ddcname[64];
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+	int err;
+	struct intel_debug_features features;
+
+	BT_DBG("%s", hdev->name);
+
+	/* Set the default boot parameter to 0x0 and it is updated to
+	 * SKU specific boot parameter after reading Intel_Write_Boot_Params
+	 * command while downloading the firmware.
+	 */
+	boot_param = 0x00000000;
+
+	calltime = ktime_get();
+
+	/* Read the Intel version information to determine if the device
+	 * is in bootloader mode or if it already has operational firmware
+	 * loaded.
+	 */
+	err = btintel_read_version(hdev, &ver);
+	if (err) {
+		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
+		btintel_reset_to_bootloader(hdev);
+		return err;
+	}
+
+	err = btusb_intel_download_firmware(hdev, &ver, &params);
+	if (err)
+		return err;
+
+	/* controller is already having an operational firmware */
+	if (ver.fw_variant == 0x23)
+		goto finish;
+
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
 	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
 
 	bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
 
-done:
-	release_firmware(fw);
-
-	if (err < 0)
-		return err;
-
 	calltime = ktime_get();
 
 	set_bit(BTUSB_BOOTING, &data->flags);
@@ -2535,13 +2543,20 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
-	/* Once the device is running in operational mode, it needs to apply
-	 * the device configuration (DDC) parameters.
-	 *
-	 * The device can work without DDC parameters, so even if it fails
-	 * to load the file, no need to fail the setup.
-	 */
-	btintel_load_ddc_config(hdev, fwname);
+	err = btusb_setup_intel_new_get_fw_name(&ver, &params, ddcname,
+						sizeof(ddcname), "ddc");
+
+	if (!err) {
+		bt_dev_err(hdev, "Unsupported Intel firmware naming");
+	} else {
+		/* Once the device is running in operational mode, it needs to
+		 * apply the device configuration (DDC) parameters.
+		 *
+		 * The device can work without DDC parameters, so even if it
+		 * fails to load the file, no need to fail the setup.
+		 */
+		btintel_load_ddc_config(hdev, ddcname);
+	}
 
 	/* Read the Intel supported features and if new exception formats
 	 * supported, need to load the additional DDC config to enable.
@@ -2555,7 +2570,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	err = btintel_read_version(hdev, &ver);
 	if (err)
 		return err;
-
 	btintel_version_info(hdev, &ver);
 
 finish:
-- 
2.17.1


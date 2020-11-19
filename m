Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E233CC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 11:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804C6246EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 11:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgKSLhy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 06:37:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:21909 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgKSLhx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 06:37:53 -0500
IronPort-SDR: EdKamnteHJ1Q2CvWopydFMPBkMh6wT1UjzelNoJuuRidWHrog6H33PhNPlenlR8ozqdkJZd/P2
 9kc7Cte3aJYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="167763750"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="167763750"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 03:37:53 -0800
IronPort-SDR: RBI7R+XBIxEMsMKk2CbTjvztmosUHOXJzAcv/QSbCvyYK7qgKqfG/mkRMHQA82vPaDEDx52Im6
 X6OVIQbYoO2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="325950033"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga003.jf.intel.com with ESMTP; 19 Nov 2020 03:37:50 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        sathish.narasimman@intel.com, Kiran K <kiran.k@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: [PATCH v8 2/5] Bluetooth: btusb: Add *setup* function for new generation Intel controllers
Date:   Thu, 19 Nov 2020 17:09:40 +0530
Message-Id: <20201119113943.13839-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119113943.13839-1-kiran.k@intel.com>
References: <20201119113943.13839-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Define a new  *setup* function for new generation Intel controllers

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
Changes in v8:
* fix review comments
* create a separate patch to fix issue reported for endianness

Changes in v7:
* split code in to multiple patches

Changes in v6:
* Revert to v4
* Move TyphoonPeak controller mapping to BTUSB_INTEL_NEWGEN to
  a separte patch

Changes in v5:
* Remove BTUSB_INTEL_NEWGEN and use usb vid/pid combination to
  identify controller type

Changes in v4:
* Rebase patchset
* Fix indentation issues
* make btusb_setup_intel_new_get_fw_name to return void as return value is
  not getting used

Changes in v3:
* Combine the two patches in v2 series to one to avoid compiler warnings
   reported by kernel bot (lkp)

Changed in v2:
* Fix typo in commit message
 drivers/bluetooth/btusb.c | 141 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 71f62d532481..111de9f25ef4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_WIDEBAND_SPEECH	0x400000
 #define BTUSB_VALID_LE_STATES   0x800000
 #define BTUSB_QCA_WCN6855	0x1000000
+#define BTUSB_INTEL_NEWGEN	0x2000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -2716,6 +2717,128 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	return 0;
 }
 
+static int btusb_setup_intel_newgen(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	u32 boot_param;
+	char ddcname[64];
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+	int err;
+	struct intel_debug_features features;
+	struct intel_version_tlv version;
+
+	bt_dev_dbg(hdev, "");
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
+	err = btintel_read_version_tlv(hdev, &version);
+	if (err) {
+		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
+		btintel_reset_to_bootloader(hdev);
+		return err;
+	}
+
+	btintel_version_info_tlv(hdev, &version);
+
+	/* check if controller is already having an operational firmware */
+	if (version.img_type == 0x03)
+		goto finish;
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+
+	bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
+
+	calltime = ktime_get();
+
+	set_bit(BTUSB_BOOTING, &data->flags);
+
+	err = btintel_send_intel_reset(hdev, boot_param);
+	if (err) {
+		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
+		btintel_reset_to_bootloader(hdev);
+		return err;
+	}
+
+	/* The bootloader will not indicate when the device is ready. This
+	 * is done by the operational firmware sending bootup notification.
+	 *
+	 * Booting into operational firmware should not take longer than
+	 * 1 second. However if that happens, then just fail the setup
+	 * since something went wrong.
+	 */
+	bt_dev_info(hdev, "Waiting for device to boot");
+
+	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(1000));
+
+	if (err == -EINTR) {
+		bt_dev_err(hdev, "Device boot interrupted");
+		return -EINTR;
+	}
+
+	if (err) {
+		bt_dev_err(hdev, "Device boot timeout");
+		btintel_reset_to_bootloader(hdev);
+		return -ETIMEDOUT;
+	}
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+
+	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
+
+	clear_bit(BTUSB_BOOTLOADER, &data->flags);
+
+	/* Once the device is running in operational mode, it needs to
+	 * apply the device configuration (DDC) parameters.
+	 *
+	 * The device can work without DDC parameters, so even if it
+	 * fails to load the file, no need to fail the setup.
+	 */
+	btintel_load_ddc_config(hdev, ddcname);
+
+	/* Read the Intel supported features and if new exception formats
+	 * supported, need to load the additional DDC config to enable.
+	 */
+	btintel_read_debug_features(hdev, &features);
+
+	/* Set DDC mask for available debug features */
+	btintel_set_debug_features(hdev, &features);
+
+	/* Read the Intel version information after loading the FW  */
+	err = btintel_read_version_tlv(hdev, &version);
+	if (err)
+		return err;
+
+	btintel_version_info_tlv(hdev, &version);
+
+finish:
+	/* Set the event mask for Intel specific vendor events. This enables
+	 * a few extra events that are useful during general operation. It
+	 * does not enable any debugging related events.
+	 *
+	 * The device will function correctly without these events enabled
+	 * and thus no need to fail the setup.
+	 */
+	btintel_set_event_mask(hdev, false);
+
+	return 0;
+}
 static int btusb_shutdown_intel(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -4101,6 +4224,24 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
 	}
 
+	if (id->driver_info & BTUSB_INTEL_NEWGEN) {
+		hdev->manufacturer = 2;
+		hdev->send = btusb_send_frame_intel;
+		hdev->setup = btusb_setup_intel_newgen;
+		hdev->shutdown = btusb_shutdown_intel_new;
+		hdev->hw_error = btintel_hw_error;
+		hdev->set_diag = btintel_set_diag;
+		hdev->set_bdaddr = btintel_set_bdaddr;
+		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+
+		data->recv_event = btusb_recv_event_intel;
+		data->recv_bulk = btusb_recv_bulk_intel;
+		set_bit(BTUSB_BOOTLOADER, &data->flags);
+	}
+
 	if (id->driver_info & BTUSB_MARVELL)
 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
 
-- 
2.17.1


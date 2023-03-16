Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD5CC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 00:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjCPAPd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 20:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjCPAPb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 20:15:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333886C184
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 17:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678925726; x=1710461726;
  h=from:to:cc:subject:date:message-id;
  bh=jIxxFUK9Tz2YrKPrfBLTQMZMKFz3y3BvNlgocKouVmA=;
  b=Ogh07k7I/rb8URBf4QdNjuODSndYEymUAo8sAZsrcFay1QX5O4mA3fZp
   b2vca1XzJckb7Hg+wCap1VqkhTynISKR27V/F2KphLh87ItJR7UqN7WbB
   t0Y11zAopmCoueXyVxRiW0klyw+ta0pF7sOLYaZxk0HZc8FYNfxHamH+D
   yA/xxAzwAsTsbgi+nXWN7W+Hw/hFPe6PbsVwcqpRM6H6sHub5u48RFP4p
   tbPu2bMWcczfIe9rJ15LfkWYsoIP5SxR9Wgetc62C0FGroLfNerGJNVb+
   02RIpbXNIp1PwarAHNYVB62YyTWz8GllHG95n27ZjEDRl5lsK3Ve0qVaN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="318245178"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="318245178"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 17:15:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="672928216"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="672928216"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2023 17:15:22 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 1/2] Bluetooth: btintel: Add support to reset bluetooth via ACPI DSM
Date:   Thu, 16 Mar 2023 05:55:58 +0530
Message-Id: <20230316002559.32562-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

New Intel platforms supports reset of Bluetooth device  via ACPI DSM
methods. The legacy reset mechanism via GPIO will be deprecated in
future. This patch checks the platform support for reset methods and if
supported uses the same instead of legacy GPIO toggling method.

ACPI firmware supports two types of reset method based on NIC card.
(Discrete or Integrated).

1. VSEC Type - Vendor Specific Extended Capability. Here  BT_EN and
   BT_IF_SELECT lines are driven by a register in PCH cluster. This
   interface is supported on discrete BT solution.

2. WDISABLE2 - In this soluton, W_DISABLE2 pin in M.2 is connected to
   physical GPIO from PCH. The DSM interface shall toggle this to recover
   from  error.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
---
changes in v2:
Fix compilation error when compiled for  ARCH=arc
Details here:
https://patchwork.kernel.org/project/bluetooth/patch/20230313151549.15791-1-kiran.k@intel.com/

 drivers/bluetooth/btintel.c | 121 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |   2 +
 drivers/bluetooth/btusb.c   |  16 +++++
 3 files changed, 139 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index af774688f1c0..c4b02ac42106 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -10,6 +10,7 @@
 #include <linux/firmware.h>
 #include <linux/regmap.h>
 #include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -43,6 +44,15 @@ struct cmd_write_boot_params {
 	u8  fw_build_yy;
 } __packed;
 
+enum {
+	DSM_SET_WDISABLE2_DELAY = 1,
+	DSM_SET_RESET_METHOD = 3,
+};
+
+static const guid_t btintel_guid_dsm =
+	GUID_INIT(0xaa10f4e0, 0x81ac, 0x4233,
+		  0xab, 0xf6, 0x3b, 0x2a, 0xc5, 0x0e, 0x28, 0xd9);
+
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -2379,6 +2389,116 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 	kfree_skb(skb);
 }
 
+static int btintel_acpi_reset_method(struct hci_dev *hdev)
+{
+	int ret = 0;
+	acpi_status status;
+	union acpi_object *p, *ref;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+
+	status = acpi_evaluate_object(ACPI_HANDLE(GET_HCIDEV_DEV(hdev)), "_PRR", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		bt_dev_err(hdev, "Failed to run _PRR method");
+		ret = -ENODEV;
+		return ret;
+	}
+	p = buffer.pointer;
+
+	if (p->package.count != 1 || p->type != ACPI_TYPE_PACKAGE) {
+		bt_dev_err(hdev, "Invalid arguments");
+		ret = -EINVAL;
+		goto exit_on_error;
+	}
+
+	ref = &p->package.elements[0];
+	if (ref->type != ACPI_TYPE_LOCAL_REFERENCE) {
+		bt_dev_err(hdev, "Invalid object type: 0x%x", ref->type);
+		ret = -EINVAL;
+		goto exit_on_error;
+	}
+
+	status = acpi_evaluate_object(ref->reference.handle, "_RST", NULL, NULL);
+	if (ACPI_FAILURE(status)) {
+		bt_dev_err(hdev, "Failed to run_RST method");
+		ret = -ENODEV;
+		goto exit_on_error;
+	}
+
+exit_on_error:
+	kfree(buffer.pointer);
+	return ret;
+}
+
+static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
+					 struct intel_version_tlv *ver_tlv)
+{
+	struct btintel_data *data = hci_get_priv(hdev);
+	acpi_handle handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
+	u8 reset_payload[4] = {0x01, 0x00, 0x01, 0x00};
+	union acpi_object *obj, argv4;
+	enum {
+		RESET_TYPE_WDISABLE2,
+		RESET_TYPE_VSEC
+	};
+
+	handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
+
+	if (!handle) {
+		bt_dev_dbg(hdev, "No support for bluetooth device in ACPI firmware");
+		return;
+	}
+
+	if (!acpi_has_method(handle, "_PRR")) {
+		bt_dev_err(hdev, "No support for _PRR ACPI method");
+		return;
+	}
+
+	switch (ver_tlv->cnvi_top & 0xfff) {
+	case 0x910: /* GalePeak2 */
+		reset_payload[2] = RESET_TYPE_VSEC;
+		break;
+	default:
+		/* WDISABLE2 is the default reset method */
+		reset_payload[2] = RESET_TYPE_WDISABLE2;
+
+		if (!acpi_check_dsm(handle, &btintel_guid_dsm, 0,
+				    BIT(DSM_SET_WDISABLE2_DELAY))) {
+			bt_dev_err(hdev, "No dsm support to set reset delay");
+			return;
+		}
+		argv4.integer.type = ACPI_TYPE_INTEGER;
+		/* delay required to toggle BT power */
+		argv4.integer.value = 160;
+		obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
+					DSM_SET_WDISABLE2_DELAY, &argv4);
+		if (!obj) {
+			bt_dev_err(hdev, "Failed to call dsm to set reset delay");
+			return;
+		}
+		ACPI_FREE(obj);
+	}
+
+	bt_dev_info(hdev, "DSM reset method type: 0x%02x", reset_payload[2]);
+
+	if (!acpi_check_dsm(handle, &btintel_guid_dsm, 0,
+			    DSM_SET_RESET_METHOD)) {
+		bt_dev_warn(hdev, "No support for dsm to set reset method");
+		return;
+	}
+	argv4.buffer.type = ACPI_TYPE_BUFFER;
+	argv4.buffer.length = sizeof(reset_payload);
+	argv4.buffer.pointer = reset_payload;
+
+	obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
+				DSM_SET_RESET_METHOD, &argv4);
+	if (!obj) {
+		bt_dev_err(hdev, "Failed to call dsm to set reset method");
+		return;
+	}
+	ACPI_FREE(obj);
+	data->acpi_reset_method = btintel_acpi_reset_method;
+}
+
 static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 					struct intel_version_tlv *ver)
 {
@@ -2691,6 +2811,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		/* Setup MSFT Extension support */
 		btintel_set_msft_opcode(hdev,
 					INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
+		btintel_set_dsm_reset_method(hdev, &ver_tlv);
 
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
 		break;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 8fdb65b66315..8e7c51a78327 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -159,12 +159,14 @@ enum {
 	INTEL_BROKEN_SHUTDOWN_LED,
 	INTEL_ROM_LEGACY,
 	INTEL_ROM_LEGACY_NO_WBS_SUPPORT,
+	INTEL_ACPI_RESET_ACTIVE,
 
 	__INTEL_NUM_FLAGS,
 };
 
 struct btintel_data {
 	DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
+	int (*acpi_reset_method)(struct hci_dev *hdev);
 };
 
 #define btintel_set_flag(hdev, nr)					\
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7382b021f3df..bfee12b6ab57 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -838,10 +838,26 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct gpio_desc *reset_gpio = data->reset_gpio;
+	struct btintel_data *intel_data = hci_get_priv(hdev);
 
 	if (++data->cmd_timeout_cnt < 5)
 		return;
 
+	if (intel_data->acpi_reset_method) {
+		if (test_and_set_bit(INTEL_ACPI_RESET_ACTIVE, intel_data->flags)) {
+			bt_dev_err(hdev, "acpi: last reset failed ? Not resetting again");
+			return;
+		}
+
+		bt_dev_err(hdev, "Initiating acpi reset method");
+		/* If ACPI reset method fails, lets try with legacy GPIO
+		 * toggling
+		 */
+		if (!intel_data->acpi_reset_method(hdev)) {
+			return;
+		}
+	}
+
 	if (!reset_gpio) {
 		btusb_reset(hdev);
 		return;
-- 
2.17.1


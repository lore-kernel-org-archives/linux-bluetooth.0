Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12816C05027
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Feb 2023 06:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBFGmE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 01:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBFGly (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 01:41:54 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22805196A1
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Feb 2023 22:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675665698; x=1707201698;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cujdBNUGQ6ImTKY9UJD6akfvyPws2GScSnzvnXh8iaY=;
  b=ixgORyZW7ypSXCP7iZ78yGbMAwLUM0QWqnZAAB1YS79WUjmFfW9nzbpt
   51lA9UXPYXsVDyblmbkqo/13t/+tTfQyKSEyi41hwrFSo5V8u6e3xHOWH
   V3J/m5vPXNW90rDuBXvfA4Ar4zxlvwPoaH/O9+Xz/V3RGdIiZKRHy/zFr
   2DMrp1i/pS+nbgJKxpWbbv98Rk1BfoRAHVHSfcHulJi81Rgo+4+LynsX6
   E/GGzf1hQ9slJ0+OwXpzdqVC0fXz6Ru6Vfc1uXk3AwjlhsYx/fpAPiawY
   4xdtx6+al15lhm93ykBik/TsuqDGr+dsSyxCAVFKmcY3bLLPGvfCm9IT4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="330433730"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="330433730"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 22:41:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="696769645"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="696769645"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga008.jf.intel.com with ESMTP; 05 Feb 2023 22:41:34 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, lokendra.singh@intel.com,
        chethan.tumkur.narayan@intel.com, seema.sreemantha@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v3] Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)
Date:   Mon,  6 Feb 2023 12:21:44 +0530
Message-Id: <20230206065144.28322-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Seema Sreemantha <seema.sreemantha@intel.com>

Antenna gain is defined as the antenna’s ability to
increase the Tx power in a given direction. Intel
is certifying its products with fixed reference
antenna peak gain values (3/5dBi). The feature takes
into account the actual antenna gain, and increases
output power values, which results in a performance
improvement.

After firmware download is completed, driver reads from
ACPI table and configures PPAG as required. ACPI table
entry for PPAG is defined as below.

Name (PPAG, Package (0x02)
{
    0x00000001,
    Package (0x02)
    {
        0x00000012, /* Bluetooth Domain */
        0x00000001  /* 1 - Enable PPAG, 0 - Disable PPAG */
    }
})

btmon log:
< HCI Command: Intel Configure Per Platform Antenna Gain (0x3f|0x0219) plen 12
        Mcc: 0x00000000
        Selector: Enable
        Delta: 0x00000000
> HCI Event: Command Complete (0x0e) plen 4
      Intel Configure Per Platform Antenna Gain (0x3f|0x0219) ncmd 1
        Status: Success (0x00)

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Seema Sreemantha <seema.sreemantha@intel.com>
---
changes in v2:
Fix review comments

changes in v3:
Fix compilation issue.

 drivers/bluetooth/btintel.c | 116 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  13 ++++
 2 files changed, 129 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d4e2cb9a4eb4..bede8b005594 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/regmap.h>
+#include <linux/acpi.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -24,6 +25,9 @@
 #define ECDSA_OFFSET		644
 #define ECDSA_HEADER_LEN	320
 
+#define BTINTEL_PPAG_NAME   "PPAG"
+#define BTINTEL_PPAG_PREFIX "\\_SB_.PCI0.XHCI.RHUB"
+
 #define CMD_WRITE_BOOT_PARAMS	0xfc0e
 struct cmd_write_boot_params {
 	__le32 boot_addr;
@@ -1278,6 +1282,63 @@ static int btintel_read_debug_features(struct hci_dev *hdev,
 	return 0;
 }
 
+static acpi_status btintel_ppag_callback(acpi_handle handle, u32 lvl, void *data,
+					 void **ret)
+{
+	acpi_status status;
+	size_t len;
+	struct btintel_ppag *ppag = data;
+	union acpi_object *p, *elements;
+	struct acpi_buffer string = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct hci_dev *hdev = ppag->hdev;
+
+	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
+	if (ACPI_FAILURE(status)) {
+		bt_dev_warn(hdev, "ACPI Failure: %s", acpi_format_exception(status));
+		return status;
+	}
+
+	if (strncmp(BTINTEL_PPAG_PREFIX, string.pointer,
+		    strlen(BTINTEL_PPAG_PREFIX))) {
+		kfree(string.pointer);
+		return AE_OK;
+	}
+
+	len = strlen(string.pointer);
+	if (strncmp((char *)string.pointer + len - 4, BTINTEL_PPAG_NAME, 4)) {
+		kfree(string.pointer);
+		return AE_OK;
+	}
+	kfree(string.pointer);
+
+	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		bt_dev_warn(hdev, "ACPI Failure: %s", acpi_format_exception(status));
+		return status;
+	}
+
+	p = buffer.pointer;
+	ppag = (struct btintel_ppag *)data;
+
+	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 2) {
+		kfree(buffer.pointer);
+		bt_dev_warn(hdev, "Invalid object type: %d or package count: %d",
+			    p->type, p->package.count);
+		return AE_ERROR;
+	}
+
+	elements = p->package.elements;
+
+	/* PPAG table is located at element[1] */
+	p = &elements[1];
+
+	ppag->domain = (u32)p->package.elements[0].integer.value;
+	ppag->mode = (u32)p->package.elements[1].integer.value;
+	kfree(buffer.pointer);
+	return AE_CTRL_TERMINATE;
+}
+
 static int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features)
 {
@@ -2251,6 +2312,58 @@ static int btintel_configure_offload(struct hci_dev *hdev)
 	return err;
 }
 
+static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver)
+{
+	acpi_status status;
+	struct btintel_ppag ppag;
+	struct sk_buff *skb;
+	struct btintel_loc_aware_reg ppag_cmd;
+
+    /* PPAG is not supported if CRF is HrP2, Jfp2, JfP1 */
+	switch (ver->cnvr_top & 0xFFF) {
+	case 0x504:     /* Hrp2 */
+	case 0x202:     /* Jfp2 */
+	case 0x201:     /* Jfp1 */
+		return;
+	}
+
+	memset(&ppag, 0, sizeof(ppag));
+
+	ppag.hdev = hdev;
+	status = acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX, NULL,
+				     btintel_ppag_callback, &ppag, NULL);
+
+	if (ACPI_FAILURE(status)) {
+		/* Do not log warning message if ACPI entry is not found */
+		if (status == AE_NOT_FOUND)
+			return;
+		bt_dev_warn(hdev, "PPAG: ACPI Failure: %s", acpi_format_exception(status));
+		return;
+	}
+
+	if (ppag.domain != 0x12) {
+		bt_dev_warn(hdev, "PPAG-BT Domain disabled");
+		return;
+	}
+
+	/* PPAG mode, BIT0 = 0 Disabled, BIT0 = 1 Enabled */
+	if (!(ppag.mode & BIT(0))) {
+		bt_dev_dbg(hdev, "PPAG disabled");
+		return;
+	}
+
+	ppag_cmd.mcc = cpu_to_le32(0);
+	ppag_cmd.sel = cpu_to_le32(0); /* 0 - Enable , 1 - Disable, 2 - Testing mode */
+	ppag_cmd.delta = cpu_to_le32(0);
+	skb = __hci_cmd_sync(hdev, 0xfe19, sizeof(ppag_cmd), &ppag_cmd, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_warn(hdev, "Failed to send PPAG Enable (%ld)", PTR_ERR(skb));
+		return;
+	}
+	kfree_skb(skb);
+}
+
 static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 					struct intel_version_tlv *ver)
 {
@@ -2297,6 +2410,9 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 
 	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
 
+	/* Set PPAG feature */
+	btintel_set_ppag(hdev, ver);
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &new_ver);
 	if (err)
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index e0060e58573c..8e7da877efae 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -137,6 +137,19 @@ struct intel_offload_use_cases {
 	__u8	preset[8];
 } __packed;
 
+/* structure to store the PPAG data read from ACPI table */
+struct btintel_ppag {
+	u32	domain;
+	u32     mode;
+	struct hci_dev *hdev;
+};
+
+struct btintel_loc_aware_reg {
+	__le32 mcc;
+	__le32 sel;
+	__le32 delta;
+} __packed;
+
 #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
 #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
 #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
-- 
2.17.1


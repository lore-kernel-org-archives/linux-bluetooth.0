Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96795C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Apr 2022 08:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiDHIDG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Apr 2022 04:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiDHICC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Apr 2022 04:02:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6888B16CE6F
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Apr 2022 00:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649404792; x=1680940792;
  h=from:to:cc:subject:date:message-id;
  bh=prFR6QKqzoTUeToSJ0zfKCjbqoAIx1tdFx3ZtyBTJcM=;
  b=lABcI8POPQQGAcqMf6N97gn93nv2G+23G3YQML6aQTqv4culJ2n+3nOG
   tzlPJTFE4QgQLj0D5sHYeh3Q8Smekf8jQdhw7Zvk3/2y1TrtcYQXg8mc6
   ktplxqQyUi2QOMVG8ulkk5NAVsT9fTloKzTpHAn/9zkJglgo/QatmFJxa
   xQwS7K/lAp0PON8+ViZud2EaZahDH9TanZQlQzRt36TV9nE/+gVExNn4o
   hjHpl4YUJGMJ/lqPGiPUHlT1tDBY8Npwf4dAq24H1iKayXt4m9qsHDNKc
   iN0ksaqgxXop+nHNm8Qh34N5P9J8NmfNUxk57O4n5MLHNmLbpLpkihI7d
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260374146"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="260374146"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 00:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="621552343"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2022 00:59:40 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>,
        Seema S <seema.sreemantha@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Add support to configure TX power
Date:   Fri,  8 Apr 2022 13:36:33 +0530
Message-Id: <20220408080633.20463-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BRDS - Bluetooth Regulatory Domain Specific absorption rate
-----------------------------------------------------------

Bluetooth has regulatory limitations which prohibit or allow usage
of certain bands or channels as well as limiting Tx power. The Tx power
values can be configured in ACPI table. This patch reads ACPI entry of
Bluetooth SAR and configures the controller accordingly.

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Seema S <seema.sreemantha@intel.com>
---
 drivers/bluetooth/btintel.c | 229 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  18 +++
 2 files changed, 247 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 818681c89db8..d3dc703eba78 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/regmap.h>
+#include <linux/acpi.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -32,6 +33,9 @@ struct cmd_write_boot_params {
 	u8  fw_build_yy;
 } __packed;
 
+#define BTINTEL_SAR_NAME	"BRDS"
+#define BTINTEL_SAR_PREFIX	"\\_SB_.PC00.XHCI.RHUB"
+
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -2250,6 +2254,228 @@ static int btintel_configure_offload(struct hci_dev *hdev)
 	return err;
 }
 
+static acpi_status btintel_sar_callback(acpi_handle handle, u32 lvl, void *data,
+					void **ret)
+{
+	acpi_status status;
+	int len;
+	struct btintel_sar *sar;
+	union acpi_object *p, *elements;
+	struct acpi_buffer string = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+
+	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
+	if (ACPI_FAILURE(status)) {
+		BT_DBG("ACPI Failure: %s", acpi_format_exception(status));
+		return status;
+	}
+
+	if (strncmp(BTINTEL_SAR_PREFIX, string.pointer,
+		    strlen(BTINTEL_SAR_PREFIX))) {
+		kfree(string.pointer);
+		return AE_OK;
+	}
+
+	len = strlen(string.pointer);
+	if (strncmp((char *)string.pointer + len - 4, BTINTEL_SAR_NAME, 4)) {
+		kfree(string.pointer);
+		return AE_OK;
+	}
+	kfree(string.pointer);
+
+	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		BT_DBG("ACPI Failure: %s", acpi_format_exception(status));
+		return status;
+	}
+
+	p = buffer.pointer;
+	sar = data;
+
+	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 2) {
+		kfree(buffer.pointer);
+		BT_DBG("Invalid object type or package count");
+		return AE_ERROR;
+	}
+
+	elements = p->package.elements;
+
+	/* SAR table is located at element[1] */
+	p = &elements[1];
+
+	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 8) {
+		kfree(buffer.pointer);
+		return AE_ERROR;
+	}
+
+	sar->domain = (u8)p->package.elements[0].integer.value;
+	sar->type = (u8)p->package.elements[1].integer.value;
+	sar->br = (u32)p->package.elements[2].integer.value;
+	sar->edr2 = (u32)p->package.elements[3].integer.value;
+	sar->edr3 = (u32)p->package.elements[4].integer.value;
+	sar->le = (u32)p->package.elements[5].integer.value;
+	sar->le_2mhz = (u32)p->package.elements[6].integer.value;
+	sar->le_lr  = (u32)p->package.elements[7].integer.value;
+	kfree(buffer.pointer);
+	return AE_CTRL_TERMINATE;
+}
+
+static void btintel_send_sar_ddc(struct hci_dev *hdev, void *data, u8 len)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, 0xfc8b, len, data, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_warn(hdev, "Failed to send Intel Write SAR DDC (%ld)", PTR_ERR(skb));
+		return;
+	}
+	kfree_skb(skb);
+}
+
+static int btintel_set_legacy_sar(struct hci_dev *hdev, struct btintel_sar *sar)
+{
+	struct btintel_cp_ddc_write	*cmd;
+	u8	buffer[64];
+
+	if (!sar)
+		return -EINVAL;
+
+	cmd = (void *)buffer;
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x0131);
+	cmd->data[0] = sar->br >> 3;
+	btintel_send_sar_ddc(hdev, cmd, 4);
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x0132);
+	cmd->data[0] = sar->br >> 3;
+	btintel_send_sar_ddc(hdev, cmd, 4);
+
+	cmd->len = 5;
+	cmd->id = cpu_to_le16(0x0137);
+	cmd->data[0] = sar->br >> 3;
+	cmd->data[1] = sar->edr2 >> 3;
+	cmd->data[2] = sar->edr3 >> 3;
+	btintel_send_sar_ddc(hdev, cmd, 6);
+
+	cmd->len = 5;
+	cmd->id = cpu_to_le16(0x0138);
+	cmd->data[0] = sar->br >> 3;
+	cmd->data[1] = sar->edr2 >> 3;
+	cmd->data[2] = sar->edr3 >> 3;
+	btintel_send_sar_ddc(hdev, cmd, 6);
+
+	cmd->len = 5;
+	cmd->id = cpu_to_le16(0x013b);
+	cmd->data[0] = sar->br >> 3;
+	cmd->data[1] = sar->edr2 >> 3;
+	cmd->data[2] = sar->edr3 >> 3;
+	btintel_send_sar_ddc(hdev, cmd, 6);
+
+	cmd->len = 5;
+	cmd->id = cpu_to_le16(0x013c);
+	cmd->data[0] = sar->br >> 3;
+	cmd->data[1] = sar->edr2 >> 3;
+	cmd->data[2] = sar->edr3 >> 3;
+	btintel_send_sar_ddc(hdev, cmd, 6);
+
+	return 0;
+}
+
+static int btintel_set_mutual_sar(struct hci_dev *hdev, struct btintel_sar *sar)
+{
+	u8 buffer[64];
+	struct btintel_cp_ddc_write *cmd;
+	u8 enable[1] = {1};
+	struct sk_buff *skb;
+
+	if (!sar)
+		return -EINVAL;
+
+	cmd = (void *)buffer;
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x019e);
+	if (!(sar->le_2mhz & BIT(7)))
+		cmd->data[0] = 0x01;
+	else
+		cmd->data[0] = 0x00;
+	btintel_send_sar_ddc(hdev, cmd, 4);
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x019f);
+	cmd->data[0] = sar->le_lr;
+	btintel_send_sar_ddc(hdev, cmd, 4);
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x01a0);
+	cmd->data[0] = sar->br;
+	btintel_send_sar_ddc(hdev, cmd, 4);
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x01a1);
+	cmd->data[0] = sar->edr2;
+	btintel_send_sar_ddc(hdev, cmd, 4);
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x01a2);
+	cmd->data[0] = sar->edr3;
+	btintel_send_sar_ddc(hdev, cmd, 4);
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x01a3);
+	cmd->data[0] = sar->le;
+	btintel_send_sar_ddc(hdev, cmd, 4);
+
+	skb = __hci_cmd_sync(hdev, 0xfe25, 1, enable, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_warn(hdev, "Failed to send Intel SAR Enable (%ld)", PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int btintel_set_specific_absorption_rate(struct hci_dev *hdev,
+						struct intel_version_tlv *ver)
+{
+	acpi_status status;
+	struct btintel_sar sar;
+
+	switch (ver->cnvr_top & 0xfff) {
+	case 0x810: /* MsP */
+		break;
+	default:
+		return 0;
+	}
+
+	memset(&sar, 0, sizeof(sar));
+
+	status = acpi_walk_namespace(ACPI_TYPE_METHOD, ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX, NULL,
+				     btintel_sar_callback, &sar, NULL);
+
+	if (ACPI_FAILURE(status))
+		return -1;
+
+	if (sar.domain != 0x12)
+		return -1;
+
+	/* No need to configure controller if Bluetooth SAR is disabled in BIOS
+	 */
+	if (!sar.type)
+		return 0;
+
+	if (sar.type == 1) {
+		bt_dev_info(hdev, "Applying both legacy and mutual Bluetooth SAR");
+		btintel_set_legacy_sar(hdev, &sar);
+		btintel_set_mutual_sar(hdev, &sar);
+	}
+	return 0;
+}
+
 static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 					struct intel_version_tlv *ver)
 {
@@ -2294,6 +2520,9 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	/* Read supported use cases and set callbacks to fetch datapath id */
 	btintel_configure_offload(hdev);
 
+	/* Set Specific Absorption Rate */
+	btintel_set_specific_absorption_rate(hdev, ver);
+
 	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
 
 	/* Read the Intel version information after loading the FW  */
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index e0060e58573c..7aa58fb7b02a 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -137,6 +137,24 @@ struct intel_offload_use_cases {
 	__u8	preset[8];
 } __packed;
 
+/* structure to store the data read from ACPI table */
+struct btintel_sar {
+	u8	domain;
+	u8	type;
+	u32	br;
+	u32	edr2;
+	u32	edr3;
+	u32	le;
+	u32	le_2mhz;
+	u32	le_lr;
+};
+
+struct btintel_cp_ddc_write {
+	u8	len;
+	__le16	id;
+	u8	data[0];
+} __packed;
+
 #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
 #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
 #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
-- 
2.17.1


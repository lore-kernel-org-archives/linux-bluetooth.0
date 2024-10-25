Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF922B668
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858653; cv=none; b=KZaCnnyJLKYYrynA85e+Kq7kvwGFc3x2XVXluT1x18SCxno3Ud/0cRVQXz0K8iPal7QLNYDO7VqN45jSukRboXOkve8A0krAVeFMXXpu51TjEt97Z84OZGxOf9viMHNpzig1uIUwF6Cdp5prIZmmoweNiiPce1aNTEBsQQ/Ufc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858653; c=relaxed/simple;
	bh=ed+AmCZlbHVQvLbgD9Zf+jsQc7spWw8eTYK6RUMI9h4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tStW/CIWbBYyPIkjeU2OhU5Ur0qF5I5sEWeWs+mFQ3yp1qFZI9pjsNhXyE5WiOFG1uWOSwQTpEuMzLTYWaeZGAMxVdEfURazXJ2erTeqyJYDowuNLrHxH9pttukeGohgIOTNdOrFEhRAaMD43gWU4QfhqVY5QpNUdr7QrT2nRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLm3bp1L; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLm3bp1L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729858650; x=1761394650;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ed+AmCZlbHVQvLbgD9Zf+jsQc7spWw8eTYK6RUMI9h4=;
  b=RLm3bp1LfdmRXUD1lWe/F7kuvpkoKlAtiXN2bvhbs5VZGAIVqvX5Iaz8
   q8wshydGwR1SF3f+nIQDNs6ogr0/uru/bVlvD3FZfRaMMozur9k6kTTgW
   RyBTncrwHoEqcl00ku0L13kv4itNzpcmaj+iRr1j2Ll71aHzT8mRO88Rr
   dRdp+ugryMxa9r9FG+sQCbH+VK5ESKRRpSqAwuDDUlMUdEp6vO/IaNGMD
   MQDSqmPsVc6hT57i2PT4jNCEKfXRrDZdbhhgvhHUCZMUlfO33cKq095SV
   A8yeqmijMmb/LXYR387NOyTb18QkGhd+BeINE+le+W+HmyFhsI0vJL3cD
   A==;
X-CSE-ConnectionGUID: CLLutyriSr+3SL090TF0nA==
X-CSE-MsgGUID: Qm/w8INRRECdnWk5IvvttA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46990053"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46990053"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 05:17:30 -0700
X-CSE-ConnectionGUID: MbrhRzOtR1qHL0GS7bKRQA==
X-CSE-MsgGUID: FuXrVuI+TMOKUpWLvO2NXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="84859289"
Received: from bswm3002.iind.intel.com ([10.66.185.33])
  by fmviesa003.fm.intel.com with ESMTP; 25 Oct 2024 05:17:27 -0700
From: Vijay Satija <vijay.satija@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	kiran.k@intel.com,
	Vijay Satija <vijay.satija@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Add support to configure TX power
Date: Fri, 25 Oct 2024 17:47:16 +0530
Message-Id: <20241025121716.1913833-1-vijay.satija@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bluetooth has regulatory limitations which prohibit or allow usage
of certain bands or channels or limiting Tx power. The Tx power
values can be configured in ACPI table. This patch reads from ACPI entry
and configures the TX power to be used accordingly.

Signed-off-by: Vijay Satija <vijay.satija@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 313 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  35 ++++
 2 files changed, 348 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d496cf2c3411..aa4ebe230cc5 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -29,6 +29,11 @@
 
 #define BTINTEL_EFI_DSBR	L"UefiCnvCommonDSBR"
 
+#define BTINTEL_BT_DOMAIN		0x12
+#define BTINTEL_SAR_LEGACY		0
+#define BTINTEL_SAR_INC_PWR		1
+#define BTINTEL_SAR_INC_PWR_SUPPORTED	0
+
 enum {
 	DSM_SET_WDISABLE2_DELAY = 1,
 	DSM_SET_RESET_METHOD = 3,
@@ -2799,6 +2804,311 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static acpi_status btintel_evaluate_acpi_method(struct hci_dev *hdev,
+						acpi_string method,
+						union acpi_object **ptr,
+						u8 pkg_size)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *p;
+	acpi_status status;
+	acpi_handle handle;
+
+	handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
+	if (!handle) {
+		bt_dev_dbg(hdev, "ACPI-BT: No ACPI support for Bluetooth device");
+		return AE_NOT_EXIST;
+	}
+
+	status = acpi_evaluate_object(handle, method, NULL, &buffer);
+
+	if (ACPI_FAILURE(status)) {
+		bt_dev_dbg(hdev, "ACPI-BT: ACPI Failure: %s method: %s",
+			   acpi_format_exception(status), method);
+		return status;
+	}
+
+	p = buffer.pointer;
+
+	if (p->type != ACPI_TYPE_PACKAGE || p->package.count < pkg_size) {
+		bt_dev_warn(hdev, "ACPI-BT: Invalid object type: %d or package count: %d",
+			    p->type, p->package.count);
+		kfree(buffer.pointer);
+		return AE_ERROR;
+	}
+
+	*ptr = buffer.pointer;
+	return 0;
+}
+
+static union acpi_object *btintel_acpi_get_bt_pkg(union acpi_object *buffer)
+{
+	union acpi_object *domain, *bt_pkg;
+	int i;
+
+	for (i = 1; i < buffer->package.count; i++) {
+		bt_pkg = &buffer->package.elements[i];
+		domain = &bt_pkg->package.elements[0];
+		if (domain->type == ACPI_TYPE_INTEGER &&
+		    domain->integer.value == BTINTEL_BT_DOMAIN)
+			return bt_pkg;
+	}
+	return ERR_PTR(-ENOENT);
+}
+
+static int btintel_send_sar_ddc(struct hci_dev *hdev, struct btintel_cp_ddc_write *data, u8 len)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, 0xfc8b, len, data, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_warn(hdev, "Failed to send sar ddc id:0x%4.4x (%ld)",
+			    le16_to_cpu(data->id), PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+	return 0;
+}
+
+static int btintel_set_legacy_sar(struct hci_dev *hdev,
+				  struct btintel_sar_inc_pwr *sar)
+{
+	struct btintel_cp_ddc_write *cmd;
+	u8 buffer[64];
+	int ret;
+
+	cmd = (void *)buffer;
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x0131);
+	cmd->data[0] = sar->br >> 3;
+	ret = btintel_send_sar_ddc(hdev, cmd, 4);
+	if (ret)
+		return ret;
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x0132);
+	cmd->data[0] = sar->br >> 3;
+	ret = btintel_send_sar_ddc(hdev, cmd, 4);
+	if (ret)
+		return ret;
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x0133);
+	cmd->data[0] = min3(sar->le, sar->le_lr, sar->le_2mhz) >> 3;
+	ret = btintel_send_sar_ddc(hdev, cmd, 4);
+	if (ret)
+		return ret;
+
+	cmd->len = 5;
+	cmd->id = cpu_to_le16(0x0137);
+	cmd->data[0] = sar->br >> 3;
+	cmd->data[1] = sar->edr2 >> 3;
+	cmd->data[2] = sar->edr3 >> 3;
+	ret = btintel_send_sar_ddc(hdev, cmd, 6);
+	if (ret)
+		return ret;
+
+	cmd->len = 5;
+	cmd->id = cpu_to_le16(0x0138);
+	cmd->data[0] = sar->br >> 3;
+	cmd->data[1] = sar->edr2 >> 3;
+	cmd->data[2] = sar->edr3 >> 3;
+	ret = btintel_send_sar_ddc(hdev, cmd, 6);
+	if (ret)
+		return ret;
+
+	cmd->len = 5;
+	cmd->id = cpu_to_le16(0x013b);
+	cmd->data[0] = sar->br >> 3;
+	cmd->data[1] = sar->edr2 >> 3;
+	cmd->data[2] = sar->edr3 >> 3;
+	ret = btintel_send_sar_ddc(hdev, cmd, 6);
+	if (ret)
+		return ret;
+
+	cmd->len = 5;
+	cmd->id = cpu_to_le16(0x013c);
+	cmd->data[0] = sar->br >> 3;
+	cmd->data[1] = sar->edr2 >> 3;
+	cmd->data[2] = sar->edr3 >> 3;
+	ret = btintel_send_sar_ddc(hdev, cmd, 6);
+
+	return ret;
+}
+
+static int btintel_set_mutual_sar(struct hci_dev *hdev,
+				  struct btintel_sar_inc_pwr *sar)
+{
+	struct btintel_cp_ddc_write *cmd;
+	struct sk_buff *skb;
+	u8 buffer[64];
+	bool enable;
+	int ret;
+
+	cmd = (void *)buffer;
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x019e);
+
+	if (sar->revision == BTINTEL_SAR_INC_PWR &&
+	    sar->inc_power_mode == BTINTEL_SAR_INC_PWR_SUPPORTED)
+		cmd->data[0] = 0x01;
+	else
+		cmd->data[0] = 0x00;
+
+	ret = btintel_send_sar_ddc(hdev, cmd, 4);
+	if (ret)
+		return ret;
+
+	if (sar->revision == BTINTEL_SAR_INC_PWR &&
+	    sar->inc_power_mode == BTINTEL_SAR_INC_PWR_SUPPORTED) {
+		cmd->len = 3;
+		cmd->id = cpu_to_le16(0x019f);
+		cmd->data[0] = sar->sar_2400_chain_a;
+
+		ret = btintel_send_sar_ddc(hdev, cmd, 4);
+		if (ret)
+			return ret;
+	}
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x01a0);
+	cmd->data[0] = sar->br;
+	ret = btintel_send_sar_ddc(hdev, cmd, 4);
+	if (ret)
+		return ret;
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x01a1);
+	cmd->data[0] = sar->edr2;
+	ret = btintel_send_sar_ddc(hdev, cmd, 4);
+	if (ret)
+		return ret;
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x01a2);
+	cmd->data[0] = sar->edr3;
+	ret = btintel_send_sar_ddc(hdev, cmd, 4);
+	if (ret)
+		return ret;
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x01a3);
+	cmd->data[0] = min3(sar->le, sar->le_lr, sar->le_2mhz);
+	ret = btintel_send_sar_ddc(hdev, cmd, 4);
+	if (ret)
+		return ret;
+
+	enable = true;
+	skb = __hci_cmd_sync(hdev, 0xfe25, 1, &enable, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_warn(hdev, "Failed to send Intel SAR Enable (%ld)", PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static int btintel_sar_send_to_device(struct hci_dev *hdev, struct btintel_sar_inc_pwr *sar,
+				      struct intel_version_tlv *ver)
+{
+	u16 cnvi, cnvr;
+	int ret;
+
+	cnvi = ver->cnvi_top & 0xfff;
+	cnvr = ver->cnvr_top & 0xfff;
+
+	if (cnvi < BTINTEL_CNVI_BLAZARI && cnvr < BTINTEL_CNVR_FMP2) {
+		bt_dev_info(hdev, "Applying legacy Bluetooth SAR");
+		ret = btintel_set_legacy_sar(hdev, sar);
+	} else if (cnvi == BTINTEL_CNVI_GAP || cnvr == BTINTEL_CNVR_FMP2) {
+		bt_dev_info(hdev, "Applying  Mutual Bluetooth SAR");
+		ret = btintel_set_mutual_sar(hdev, sar);
+	} else {
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static int btintel_acpi_set_sar(struct hci_dev *hdev, struct intel_version_tlv *ver)
+{
+	union acpi_object *bt_pkg, *buffer = NULL;
+	struct btintel_sar_inc_pwr sar;
+	acpi_status status;
+	u8 revision;
+	int ret;
+
+	status = btintel_evaluate_acpi_method(hdev, "BRDS", &buffer, 2);
+	if (ACPI_FAILURE(status))
+		return -ENOENT;
+
+	bt_pkg = btintel_acpi_get_bt_pkg(buffer);
+
+	if (IS_ERR(bt_pkg)) {
+		ret = PTR_ERR(bt_pkg);
+		goto error;
+	}
+
+	revision = buffer->package.elements[0].integer.value;
+
+	if (revision > BTINTEL_SAR_INC_PWR) {
+		bt_dev_dbg(hdev, "BT_SAR: revision: 0x%2.2x not supported", revision);
+		ret = -EOPNOTSUPP;
+		goto error;
+	}
+
+	if (revision == BTINTEL_SAR_LEGACY && bt_pkg->package.count != 7) {
+		sar.revision = revision;
+		sar.bt_sar_bios = (u32)bt_pkg->package.elements[1].integer.value;
+		sar.br = (u8)bt_pkg->package.elements[2].integer.value;
+		sar.edr2 = (u8)bt_pkg->package.elements[3].integer.value;
+		sar.edr3 = (u8)bt_pkg->package.elements[4].integer.value;
+		sar.le = (u8)bt_pkg->package.elements[5].integer.value;
+		sar.le_2mhz = (u8)bt_pkg->package.elements[6].integer.value;
+		sar.le_lr  = (u8)bt_pkg->package.elements[7].integer.value;
+
+	} else if (revision == BTINTEL_SAR_INC_PWR && bt_pkg->package.count != 9) {
+		sar.revision = revision;
+		sar.bt_sar_bios = (u32)bt_pkg->package.elements[1].integer.value;
+		sar.inc_power_mode = (u32)bt_pkg->package.elements[2].integer.value;
+		sar.sar_2400_chain_a = (u8)bt_pkg->package.elements[3].integer.value;
+		sar.br = (u8)bt_pkg->package.elements[4].integer.value;
+		sar.edr2 = (u8)bt_pkg->package.elements[5].integer.value;
+		sar.edr3 = (u8)bt_pkg->package.elements[6].integer.value;
+		sar.le = (u8)bt_pkg->package.elements[7].integer.value;
+		sar.le_2mhz = (u8)bt_pkg->package.elements[8].integer.value;
+		sar.le_lr  = (u8)bt_pkg->package.elements[9].integer.value;
+	} else {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	/* Apply only if it is enabled in BIOS */
+	if (sar.bt_sar_bios != 1) {
+		bt_dev_dbg(hdev, "Bluetooth SAR is not enabled");
+		ret = -EOPNOTSUPP;
+		goto error;
+	}
+
+	ret = btintel_sar_send_to_device(hdev, &sar, ver);
+error:
+	kfree(buffer);
+	return ret;
+}
+#endif /* CONFIG_ACPI */
+
+static int btintel_set_specific_absorption_rate(struct hci_dev *hdev,
+						struct intel_version_tlv *ver)
+{
+#ifdef CONFIG_ACPI
+	return btintel_acpi_set_sar(hdev, ver);
+#endif
+	return 0;
+}
+
 int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 				 struct intel_version_tlv *ver)
 {
@@ -2876,6 +3186,9 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 
 	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
 
+	/* Send sar values to controller */
+	btintel_set_specific_absorption_rate(hdev, ver);
+
 	/* Set PPAG feature */
 	btintel_set_ppag(hdev, ver);
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index fa43eb137821..0b355cb49836 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -56,7 +56,10 @@ struct intel_tlv {
 #define BTINTEL_CNVI_BLAZARIW		0x901
 #define BTINTEL_CNVI_GAP		0x910
 #define BTINTEL_CNVI_BLAZARU		0x930
+#define BTINTEL_CNVI_GAP		0x910
 
+/* CNVR */
+#define BTINTEL_CNVR_FMP2		0x910
 #define BTINTEL_IMG_BOOTLOADER		0x01	/* Bootloader image */
 #define BTINTEL_IMG_IML			0x02	/* Intermediate image */
 #define BTINTEL_IMG_OP			0x03	/* Operational image */
@@ -164,6 +167,38 @@ struct hci_ppag_enable_cmd {
 #define INTEL_TLV_DEBUG_EXCEPTION	0x02
 #define INTEL_TLV_TEST_EXCEPTION	0xDE
 
+struct btintel_cp_ddc_write {
+	u8	len;
+	__le16	id;
+	u8	data[];
+} __packed;
+
+/* Bluetooth SAR feature (BRDS), Revision 0 */
+struct btintel_sar {
+	u8	revision;
+	u32	bt_sar_bios; /* Mode of SAR control to be used, 1:enabled in bios */
+	u8	br;
+	u8	edr2;
+	u8      edr3;
+	u8      le;
+	u8      le_2mhz;
+	u8      le_lr;
+} __packed;
+
+/* Bluetooth SAR feature (BRDS), Revision 1 */
+struct btintel_sar_inc_pwr {
+	u8	revision;
+	u32	bt_sar_bios;
+	u32	inc_power_mode;  /* Increased power mode */
+	u8	sar_2400_chain_a; /* Sar power restriction LB */
+	u8	br;
+	u8	edr2;
+	u8	edr3;
+	u8	le;
+	u8	le_2mhz;
+	u8	le_lr;
+} __packed;
+
 #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
 #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
 #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
-- 
2.40.1


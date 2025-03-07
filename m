Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5209720E018
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345207; cv=none; b=D1dvmH5xAahW//Q2+tSHmht3pqMHXo7GQqxlUHu1oKU5EIA9TZOiKRSkaAHB0MLFYV6wWx+wI3PyP0J2lHuCNfzrWmmYDJFF9XtcEWvzCy9AqxtrxSA3VB0fkh51Tm0/bwZ6RHtUof1FZI6lFg+R1MnR2ry1mPL5XFKjzNav20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345207; c=relaxed/simple;
	bh=ZDlWiM66eg0Mgd6eGOYShqXGD/DdktvUxAmzaO5wkpA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jkA5wQ9fDnAwkrd+pVpb22HoU48Jxyfri639cL7mezEselLiJif7k4KVGztD+DEoqxhEs5sXFe6yFQcIYRpgvVYYCYcfx7PANCQNsgCP0EhTpHGMoVZadgGX9I76l+1fr+nibtL3TccWMylm58N73ZMoytbdLb6dgGnVnPc0nCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1qjuRto; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1qjuRto"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741345204; x=1772881204;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZDlWiM66eg0Mgd6eGOYShqXGD/DdktvUxAmzaO5wkpA=;
  b=g1qjuRtozWL1vKqLuUwajwBEwYtyrDoCFbcprt4EXyfX0pr2WaXfVOMU
   eVFcbLn9RPCwvLqjl79t2rB6cDH60dQrEkjX10t87gXeCxfk2goo+MOY3
   AePbf4ZliyQ3vLPzZZa29c6yxWXrtsXiKCtpZWxWnWSnOzDvlrbUwbaEx
   D7cyovj2bAaUArCp3duE588yth+CaxJ5xhTiDw13noJ+X2i1zGxHXTKjR
   rFQxcSAJ9Fy1UxQNiUGinPQoHHUTDHAdWOlpeZ54uw58PrG5wD2Ore8rE
   h6vGarm7kcVb3CKRzJtUaNtXlFaq6KXWTzGvlMBp2aW7HXAsmX5ZdcU48
   w==;
X-CSE-ConnectionGUID: I11rL9M1TZOG/pt3qwlwbA==
X-CSE-MsgGUID: jLh7TGKLQx698NhGv+0GxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53778729"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53778729"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 03:00:02 -0800
X-CSE-ConnectionGUID: rAivNA3nQbiD9wtOs5BvgQ==
X-CSE-MsgGUID: Z6krkszvStC1G02uakHlaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150239154"
Received: from bswm3002.iind.intel.com ([10.66.185.33])
  by fmviesa001.fm.intel.com with ESMTP; 07 Mar 2025 02:59:59 -0800
From: Vijay Satija <vijay.satija@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Vijay Satija <vijay.satija@intel.com>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Add support to configure TX power
Date: Fri,  7 Mar 2025 16:30:11 +0530
Message-Id: <20250307110011.1960049-1-vijay.satija@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BRDS - Bluetooth Regulatory Domain Specific absorption rate

Bluetooth has regulatory limitations which prohibit or allow usage of certain
bands or channels as well as limiting Tx power. The Tx power values can be
configured in ACPI table. This patch reads from ACPI entry configures the
controller accordingly.

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Vijay Satija <vijay.satija@intel.com>
---
v1-->V2:
- Define function for redundant code
- Address minor review comments
- Remove unused structure

 drivers/bluetooth/btintel.c | 333 ++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  23 +++
 2 files changed, 356 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index ec5e2c7a56ae..48e2f400957b 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -35,6 +35,11 @@ enum {
 	DSM_SET_RESET_METHOD = 3,
 };
 
+#define BTINTEL_BT_DOMAIN		0x12
+#define BTINTEL_SAR_LEGACY		0
+#define BTINTEL_SAR_INC_PWR		1
+#define BTINTEL_SAR_INC_PWR_SUPPORTED	0
+
 #define CMD_WRITE_BOOT_PARAMS	0xfc0e
 struct cmd_write_boot_params {
 	__le32 boot_addr;
@@ -2806,6 +2811,331 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
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
+static int btintel_send_edr(struct hci_dev *hdev, struct btintel_cp_ddc_write *cmd,
+			    int id, struct btintel_sar_inc_pwr *sar)
+{
+	cmd->len = 5;
+	cmd->id = cpu_to_le16(id);
+	cmd->data[0] = sar->br >> 3;
+	cmd->data[1] = sar->edr2 >> 3;
+	cmd->data[2] = sar->edr3 >> 3;
+	return btintel_send_sar_ddc(hdev, cmd, 6);
+}
+
+static int btintel_send_le(struct hci_dev *hdev, struct btintel_cp_ddc_write *cmd,
+			   int id, struct btintel_sar_inc_pwr *sar)
+{
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(id);
+	cmd->data[0] = min3(sar->le, sar->le_lr, sar->le_2mhz) >> 3;
+	return btintel_send_sar_ddc(hdev, cmd, 4);
+}
+
+static int btintel_send_br(struct hci_dev *hdev, struct btintel_cp_ddc_write *cmd,
+			   int id, struct btintel_sar_inc_pwr *sar)
+{
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(id);
+	cmd->data[0] = sar->br >> 3;
+	return btintel_send_sar_ddc(hdev, cmd, 4);
+}
+
+static int btintel_send_br_mutual(struct hci_dev *hdev, struct btintel_cp_ddc_write *cmd,
+				  int id, struct btintel_sar_inc_pwr *sar)
+{
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(id);
+	cmd->data[0] = sar->br;
+	return btintel_send_sar_ddc(hdev, cmd, 4);
+}
+
+static int btintel_send_edr2(struct hci_dev *hdev, struct btintel_cp_ddc_write *cmd,
+			     int id, struct btintel_sar_inc_pwr *sar)
+{
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(id);
+	cmd->data[0] = sar->edr2;
+	return btintel_send_sar_ddc(hdev, cmd, 4);
+}
+
+static int btintel_send_edr3(struct hci_dev *hdev, struct btintel_cp_ddc_write *cmd,
+			     int id, struct btintel_sar_inc_pwr *sar)
+{
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(id);
+	cmd->data[0] = sar->edr3;
+	return btintel_send_sar_ddc(hdev, cmd, 4);
+}
+
+static int btintel_set_legacy_sar(struct hci_dev *hdev, struct btintel_sar_inc_pwr *sar)
+{
+	struct btintel_cp_ddc_write *cmd;
+	u8 buffer[64];
+	int ret;
+
+	cmd = (void *)buffer;
+	ret = btintel_send_br(hdev, cmd, 0x0131, sar);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_br(hdev, cmd, 0x0132, sar);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_le(hdev, cmd, 0x0133, sar);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_edr(hdev, cmd, 0x0137, sar);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_edr(hdev, cmd, 0x0138, sar);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_edr(hdev, cmd, 0x013b, sar);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_edr(hdev, cmd, 0x013c, sar);
+
+	return ret;
+}
+
+static int btintel_set_mutual_sar(struct hci_dev *hdev, struct btintel_sar_inc_pwr *sar)
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
+	ret = btintel_send_br_mutual(hdev, cmd, 0x01a0, sar);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_edr2(hdev, cmd, 0x01a1, sar);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_edr3(hdev, cmd, 0x01a2, sar);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_le(hdev, cmd, 0x01a3, sar);
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
+		bt_dev_info(hdev, "Applying mutual Bluetooth SAR");
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
+	if (!bt_pkg->package.count) {
+		ret = -EINVAL;
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
+	memset(&sar, 0, sizeof(sar));
+
+	if (revision == BTINTEL_SAR_LEGACY && bt_pkg->package.count == 8) {
+		sar.revision = revision;
+		sar.bt_sar_bios = bt_pkg->package.elements[1].integer.value;
+		sar.br = bt_pkg->package.elements[2].integer.value;
+		sar.edr2 = bt_pkg->package.elements[3].integer.value;
+		sar.edr3 = bt_pkg->package.elements[4].integer.value;
+		sar.le = bt_pkg->package.elements[5].integer.value;
+		sar.le_2mhz = bt_pkg->package.elements[6].integer.value;
+		sar.le_lr  = bt_pkg->package.elements[7].integer.value;
+
+	} else if (revision == BTINTEL_SAR_INC_PWR && bt_pkg->package.count == 10) {
+		sar.revision = revision;
+		sar.bt_sar_bios = bt_pkg->package.elements[1].integer.value;
+		sar.inc_power_mode = bt_pkg->package.elements[2].integer.value;
+		sar.sar_2400_chain_a = bt_pkg->package.elements[3].integer.value;
+		sar.br = bt_pkg->package.elements[4].integer.value;
+		sar.edr2 = bt_pkg->package.elements[5].integer.value;
+		sar.edr3 = bt_pkg->package.elements[6].integer.value;
+		sar.le = bt_pkg->package.elements[7].integer.value;
+		sar.le_2mhz = bt_pkg->package.elements[8].integer.value;
+		sar.le_lr  = bt_pkg->package.elements[9].integer.value;
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
@@ -2883,6 +3213,9 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 
 	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
 
+	/* Send sar values to controller */
+	btintel_set_specific_absorption_rate(hdev, ver);
+
 	/* Set PPAG feature */
 	btintel_set_ppag(hdev, ver);
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 19530ea14905..b2b5be28e803 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -58,6 +58,9 @@ struct intel_tlv {
 #define BTINTEL_CNVI_BLAZARU		0x930
  #define BTINTEL_CNVI_SCP		0xA00
 
+/* CNVR */
+#define BTINTEL_CNVR_FMP2		0x910
+
 #define BTINTEL_IMG_BOOTLOADER		0x01	/* Bootloader image */
 #define BTINTEL_IMG_IML			0x02	/* Intermediate image */
 #define BTINTEL_IMG_OP			0x03	/* Operational image */
@@ -165,6 +168,26 @@ struct hci_ppag_enable_cmd {
 #define INTEL_TLV_DEBUG_EXCEPTION	0x02
 #define INTEL_TLV_TEST_EXCEPTION	0xDE
 
+struct btintel_cp_ddc_write {
+	u8	len;
+	__le16	id;
+	u8	data[];
+} __packed;
+
+/* Bluetooth SAR feature (BRDS), Revision 1 */
+struct btintel_sar_inc_pwr {
+	u8	revision;
+	u32	bt_sar_bios; /* Mode of SAR control to be used, 1:enabled in bios */
+	u32	inc_power_mode;  /* Increased power mode */
+	u8	sar_2400_chain_a; /* Sar power restriction LB */
+	u8	br;
+	u8	edr2;
+	u8	edr3;
+	u8	le;
+	u8	le_2mhz;
+	u8	le_lr;
+};
+
 #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
 #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
 #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
-- 
2.34.1


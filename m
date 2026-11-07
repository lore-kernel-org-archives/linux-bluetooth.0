Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794042440;
	b=Ay0cNAHXX2Z1XhVSnREr92HA9pgF5y3zNkN/YEu6RdoTMyBlzoLxsRIBTlOIiVkJbL3l
	 UZ7YF8leUxr2V9GVDHE03LX49gdd9F5fU0atM9GaZgBdqEfxSz54T5DXLNo0o5G2fiVky
	 8LgM+HNKRVdbM83GW9HXKsaMafnI7fdv4XPV0gTrbzD40gZniyY6zEVMOU9hjuOt9QhW5
	 0ACjw9MmyH4hEUpy0dSteRXjkHlkbxHEvKcOzaAtIo2db9uh45L9pZFCmu7uu+zRNscLg
	 EP6vm3le82xBy1cKnscdbnKbBRLWUS6qVvx5lH5ulbnn8TAQUqCvcKp3qSonecmmLTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794042440;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=r1kMfPA3U/NhUsXi0AFuL5M1xBf5iT+m70jqW2Pk3Pw=;
	b=NuzpYwYo7nykqwyI3eqTHGoYuTroe2fUtWn9O/pzVf5gZRAzRrI1XNxG3Qt5twD3N/cF
	 8pmaCOgVGfVy4pWlASbZMh3nq9/o5K6gBQYMLf8BwGaNsWQ82W3Nv2ynp94HVPD9OQ60K
	 7YPIsUr7C6Ulzi3fFjFIt7HxNfKB00/uX2Niu+BdcRybIb3izgZu4kZdsTOW6tu4sixzS
	 pEDGLUV3tC9ACQ40ZbjNWhZjZz7EgVJFUaOwYk8GTP7GluIezlFbhWXw3IqYzw980MUVT
	 ihQnxUhjilVYUs+GiezWn3X/AUOXvl/9a0yRK9EVWzhHwMphc27o3PUwgc78glGgd3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BGrVs8bz;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F42E606A326
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 09:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F42E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BGrVs8bz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794042439; x=1825578439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3kQs3377YaGSIr/5FAJ4/ZYKh3Mcjzvh2IF77sHos3U=;
  b=BGrVs8bzC31PB3BNlbzXRTnMCqcz0gnFGZcXQp8NnZ8k/gHuN5ImY5Pm
   Ex3HE5iCH8j9xlZBYcuRp68sbUU77uFSnaxJ7/Sjvn91FO4uKBiPXMgB1
   plyDOAh5WQ0b630Ef1JX8674dGhWb5sAfm0wJ3cMwyUvjN1xrF+onNT7+
   nNVR2T4aXCoxu1SHzNuttFWjwl2jnhjllwPwpKVIbuELF0m2Zj5nEWovZ
   OmLMqLeUOU59+epK7FIfZteYnZogNKwil5BRgzPE5GavdN8wLMVDI+g+H
   5VOq23+LYE0vg/5y040H2rOTQEUca/kXdpYRDGMKIo3zsMH5KmMvn2XFr
   A==;
X-CSE-ConnectionGUID: grF/zU1rT/C7T1JEHtGpQA==
X-CSE-MsgGUID: BCcJsDGJRaSAOZjl33s8+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2746672"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2746672"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 01:07:19 -0800
X-CSE-ConnectionGUID: GO4jWhm8TQaN4yTn887SSQ==
X-CSE-MsgGUID: U+EBNJDJRT2M04288kpVUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7325113"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2026 01:07:17 -0800
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Add UEFI standalone static SAR support
Date: Sat,  7 Nov 2026 14:28:47 +0530
Message-ID: <20261107085847.2866615-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scorpius Peak2 and later platforms, excluding BlazarI and BlazarIW,
provide standalone static SAR limits through the UefiCnvBtBSSS
variable. Applying these limits requires SAR to be enabled in
UefiCnvBtBRDS as well as in BSSS.

Read the revision 2 UEFI BRDS and BSSS variables using their shared
layout. Program the BRDS 2.4 GHz limits, then enable standalone SAR
and write the BSSS per-chain sub-band limits. Send SAR initialization
complete after the DDC writes.

Reuse the existing SAR DDC helpers and configure UEFI SAR before
running the existing ACPI BRDS path. Keep the ACPI platform and
revision checks unchanged, independently of the UEFI result.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 drivers/bluetooth/btintel.c | 151 ++++++++++++++++++++++++++++++++----
 1 file changed, 134 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a0aa110f4cdd..fe0b6b379245 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -29,6 +29,21 @@
 #define ECDSA_HEADER_LEN	320
 
 #define BTINTEL_EFI_DSBR	L"UefiCnvCommonDSBR"
+#define BTINTEL_EFI_BRDS	L"UefiCnvBtBRDS"
+#define BTINTEL_EFI_BSSS	L"UefiCnvBtBSSS"
+
+static efi_guid_t btintel_efi_sar_guid =
+	EFI_GUID(0x42780dd5, 0x9a7d, 0x404c,
+		 0x80, 0xe4, 0x7f, 0x70, 0x94, 0x36, 0x03, 0x94);
+
+/* BRDS and BSSS revision 2 use the same 19-byte UEFI layout. */
+struct btintel_uefi_sar {
+	u8 revision;
+	__le32 mode;
+	__le32 inc_power_mode;
+	u8 chain_a[5];
+	u8 chain_b[5];
+} __packed;
 
 enum {
 	DSM_SET_WDISABLE2_DELAY = 1,
@@ -3093,6 +3108,8 @@ static union acpi_object *btintel_acpi_get_bt_pkg(union acpi_object *buffer)
 	return ERR_PTR(-ENOENT);
 }
 
+#endif /* CONFIG_ACPI */
+
 static int btintel_send_sar_ddc(struct hci_dev *hdev, struct btintel_cp_ddc_write *data, u8 len)
 {
 	struct sk_buff *skb;
@@ -3107,6 +3124,18 @@ static int btintel_send_sar_ddc(struct hci_dev *hdev, struct btintel_cp_ddc_writ
 	return 0;
 }
 
+static int btintel_send_sar_rev2_band(struct hci_dev *hdev,
+				      struct btintel_cp_ddc_write *cmd,
+				      u16 id, u8 chain_a, u8 chain_b)
+{
+	cmd->len = 4;
+	cmd->id = cpu_to_le16(id);
+	cmd->data[0] = chain_a;
+	cmd->data[1] = chain_b;
+	return btintel_send_sar_ddc(hdev, cmd, 5);
+}
+
+#ifdef CONFIG_ACPI
 static int btintel_send_edr(struct hci_dev *hdev, struct btintel_cp_ddc_write *cmd,
 			    int id, struct btintel_sar_inc_pwr *sar)
 {
@@ -3260,23 +3289,6 @@ static int btintel_set_mutual_sar(struct hci_dev *hdev, struct btintel_sar_inc_p
 	return 0;
 }
 
-/* btintel_send_sar_rev2_band - send DDC command for one Rev2 sub-band
- *
- * Each DDC 0x0311-0x0316 carries 2 bytes: [ChainA_value, ChainB_value].
- * cmd->len = 4  (2 id + 2 data)
- * HCI total  = 5 bytes (1 len + 4)
- */
-static int btintel_send_sar_rev2_band(struct hci_dev *hdev,
-				      struct btintel_cp_ddc_write *cmd,
-				      u16 id, u8 chain_a, u8 chain_b)
-{
-	cmd->len = 4;
-	cmd->id = cpu_to_le16(id);
-	cmd->data[0] = chain_a;
-	cmd->data[1] = chain_b;
-	return btintel_send_sar_ddc(hdev, cmd, 5);
-}
-
 static int btintel_set_sar_rev2(struct hci_dev *hdev,
 				struct btintel_sar_rev2 *sar)
 {
@@ -3544,9 +3556,114 @@ static int btintel_acpi_set_sar(struct hci_dev *hdev, struct intel_version_tlv *
 }
 #endif /* CONFIG_ACPI */
 
+static int btintel_uefi_read_sar(struct hci_dev *hdev, efi_char16_t *name,
+				 struct btintel_uefi_sar *sar)
+{
+	unsigned long size = sizeof(*sar);
+	efi_status_t status;
+
+	if (!IS_ENABLED(CONFIG_EFI) ||
+	    !efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return -EOPNOTSUPP;
+
+	status = efi.get_variable(name, &btintel_efi_sar_guid, NULL, &size, sar);
+	if (status == EFI_NOT_FOUND)
+		return -ENOENT;
+	if (status == EFI_BUFFER_TOO_SMALL)
+		return -EOPNOTSUPP;
+	if (status != EFI_SUCCESS) {
+		bt_dev_warn(hdev, "Failed to read UEFI SAR variable: 0x%lx",
+			    status);
+		return -EIO;
+	}
+
+	if (size != sizeof(*sar))
+		return -EINVAL;
+	if (sar->revision != BTINTEL_SAR_REV2)
+		return -EOPNOTSUPP;
+	if (!(le32_to_cpu(sar->mode) & BIT(0)))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int btintel_set_uefi_sar(struct hci_dev *hdev)
+{
+	/* 5G8 and 5G9 share a limit but have separate DDC identifiers. */
+	static const struct {
+		u16 id;
+		u8 band;
+	} bands[] = {
+		{ 0x0311, 0 },
+		{ 0x0312, 1 },
+		{ 0x0313, 2 },
+		{ 0x0314, 2 },
+		{ 0x0315, 3 },
+		{ 0x0316, 4 },
+	};
+	u8 buffer[sizeof(struct btintel_cp_ddc_write) + 2];
+	struct btintel_cp_ddc_write *cmd = (void *)buffer;
+	struct btintel_uefi_sar sar;
+	struct sk_buff *skb;
+	u8 enable = 1;
+	int ret, i;
+
+	ret = btintel_uefi_read_sar(hdev, BTINTEL_EFI_BRDS, &sar);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_sar_rev2_band(hdev, cmd, 0x0311,
+					 sar.chain_a[0], sar.chain_b[0]);
+	if (ret)
+		return ret;
+
+	/* Standalone limits require both BRDS and BSSS to be enabled. */
+	ret = btintel_uefi_read_sar(hdev, BTINTEL_EFI_BSSS, &sar);
+	if (!ret) {
+		cmd->len = 3;
+		/* BSSS requires 0x019e = 1 regardless of UEFI inc_power_mode. */
+		cmd->id = cpu_to_le16(0x019e);
+		cmd->data[0] = enable;
+		ret = btintel_send_sar_ddc(hdev, cmd, sizeof(*cmd) + 1);
+		if (ret)
+			return ret;
+
+		/* Firmware interprets these DDC IDs as BSSS limits after enablement. */
+		for (i = 0; i < ARRAY_SIZE(bands); i++) {
+			ret = btintel_send_sar_rev2_band(hdev, cmd, bands[i].id,
+							 sar.chain_a[bands[i].band],
+							 sar.chain_b[bands[i].band]);
+			if (ret)
+				return ret;
+		}
+	} else if (ret != -ENOENT && ret != -EOPNOTSUPP) {
+		return ret;
+	}
+
+	skb = __hci_cmd_sync(hdev, 0xfe25, sizeof(enable), &enable,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+	return 0;
+}
+
 static int btintel_set_specific_absorption_rate(struct hci_dev *hdev,
 						struct intel_version_tlv *ver)
 {
+	u8 hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
+	int ret;
+
+	if (hw_variant >= BTINTEL_HWID_SCP2 &&
+	    hw_variant != BTINTEL_HWID_BZRI &&
+	    hw_variant != BTINTEL_HWID_BZRIW) {
+		ret = btintel_set_uefi_sar(hdev);
+		if (ret && ret != -ENOENT && ret != -EOPNOTSUPP)
+			bt_dev_warn(hdev, "Failed to configure UEFI SAR (%d)", ret);
+	}
+
+	/* UEFI SAR configuration does not replace ACPI BRDS handling. */
 #ifdef CONFIG_ACPI
 	return btintel_acpi_set_sar(hdev, ver);
 #endif
-- 
2.53.0


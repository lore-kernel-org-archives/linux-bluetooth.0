Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131129;
	b=1GY6F6k/BxeoMXTi66S4k+p9LwlJbCaaXRg6t+87/0f1ESBT5v57CPM6CkKTCYNtVD+J
	 yXUE0XSOEPwR4wuVyGK/pZ3U9mzNTio+TUa5JOAR109SzqiIHmdm1X1D5HV17FpbtovrF
	 auVd9JBLSjmSIZkXJbDM7rU6yfntL6DPkD4Q0FwA/4xi0P+Gv2+Iu4mGaVt/aeMfnYIse
	 9in3BS/iEjnNAtb5h/h9Va79isa9Msn+Tw05Rrkdues3oqPHc5xMdT7en6eMd0t8N3L07
	 ptwfJleJDi8Y0NTY99wQfDBcwa5qgmJBObmnS81GP7c2M+9xfuzrULYX+cjrFawi1BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131129;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KKuXhxlcM08s4/TapouDtjrmWLBYME+oNM733HInP8c=;
	b=vK5vjhJgAX0uydREedc5kP6hDPLF0VwRjWrMFpGiAMKBIFh8pL9R6vLMuM25kyQwL1lR
	 HpX5qIE3GSDfzAGf7zRujc2zkaTAFdP+XFW93/ptDPr+wU2OcPF+zlsnBxLMsaYYnOXOI
	 tdieNNyb3VyKKsKFn8z4yFvDmzrvq4cx5KLlnOiR2mTBn39WhDUtFX5LdypFDqTMcIgc/
	 uYfrx7Grru+z17+gpdEfMXIG0cL9DTf7TkNF4JsWfUflCetrg2xcWOBSqeMMMhsJJxGkU
	 XhheJMXpqESd1CsWvhz5IdxHWuo7cRgk6kY6lKUdPxkDNZGfKIxWclk0uZxxOPOQiIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=duCl6MTV;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEDA606A31C
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2026 09:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DEDA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=duCl6MTV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794131128; x=1825667128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iuiSmBuh3H94gws5+05kgPXVnIdma497cbvFn4AXB3w=;
  b=duCl6MTVvI88hf2E7e9FiztmL1dAXDE71JwmOfDwlX3SgOJ0GaIuBZo2
   GSOVZo6IatyhXnVCzLMm01K+NM0/5vWIBMVYgRGsnP1rWuCUAGIcGJuOk
   IbmffopwnXk7KcfvGQiVO+SiR6Ng/3cI5QGexxns4KFGvY8rEq7jEE/b+
   w53IPTjHfQudv2snUi/7J053CKSveBOXQ2BpmZThTfdtToLiPvkH9zVhI
   h/Yk2vY9zo/JX0hm7+9K+x9r2odzYKnX+lzEjfM/hlEG9z+q4MVFrkVka
   9VZYH0AsEiF+5q44LYEGHS8c6nHqNXT8d8CFj0GfWD+bKkp8xz3bgH8D0
   g==;
X-CSE-ConnectionGUID: 2I5jQX+ASPStDgIJ9LrmqA==
X-CSE-MsgGUID: KF8WJnFoSUm4pdaKoR7a8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2912936"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2912936"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 01:45:28 -0800
X-CSE-ConnectionGUID: kMpQkW+eRNGAHr3RVlTpbQ==
X-CSE-MsgGUID: uuY/J134S8ik34Sw+Y2ZJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7796210"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa002.fm.intel.com with ESMTP; 08 Nov 2026 01:45:26 -0800
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	aluvala.sai.teja@intel.com
Subject: [PATCH v2] Bluetooth: btintel: Add UEFI standalone static SAR support
Date: Sun,  8 Nov 2026 15:06:56 +0530
Message-ID: <20261108093656.3857961-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107085847.2866615-1-aluvala.sai.teja@intel.com>
References: <20261107085847.2866615-1-aluvala.sai.teja@intel.com>
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
Changes in v2:
Address all six findings from the netdev Sashiko cross-review:
- Attempt SAR initialization complete after any UEFI DDC attempt,
  including error paths, while preserving the original error.
- Clarify the other five findings with firmware-confirmed comments on
  BRDS/BSSS DDC semantics, initial mode independence, ACPI coexistence
  and CNVr coverage.

 drivers/bluetooth/btintel.c | 173 ++++++++++++++++++++++++++++++++----
 1 file changed, 156 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a0aa110f4cdd..3612d8da81e5 100644
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
@@ -3107,6 +3124,24 @@ static int btintel_send_sar_ddc(struct hci_dev *hdev, struct btintel_cp_ddc_writ
 	return 0;
 }
 
+/* btintel_send_sar_rev2_band - send DDC command for one Rev2 sub-band
+ *
+ * Each DDC 0x0311-0x0316 carries 2 bytes: [ChainA_value, ChainB_value].
+ * cmd->len = 4  (2 id + 2 data)
+ * HCI total  = 5 bytes (1 len + 4)
+ */
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
@@ -3260,23 +3295,6 @@ static int btintel_set_mutual_sar(struct hci_dev *hdev, struct btintel_sar_inc_p
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
@@ -3544,9 +3562,130 @@ static int btintel_acpi_set_sar(struct hci_dev *hdev, struct intel_version_tlv *
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
+	/*
+	 * UEFI BRDS uses only the 2.4 GHz limits; BSSS supplies sub-band limits.
+	 * Firmware accepts this BRDS write regardless of the existing 0x019e
+	 * value, including a value previously set by the DDC configuration.
+	 */
+	ret = btintel_send_sar_rev2_band(hdev, cmd, 0x0311,
+					 sar.chain_a[0], sar.chain_b[0]);
+	if (ret)
+		goto complete;
+
+	/* Standalone limits require both BRDS and BSSS to be enabled. */
+	ret = btintel_uefi_read_sar(hdev, BTINTEL_EFI_BSSS, &sar);
+	if (!ret) {
+		cmd->len = 3;
+		/* UEFI BSSS requires 0x019e = 1; inc_power_mode is not used here. */
+		cmd->id = cpu_to_le16(0x019e);
+		cmd->data[0] = enable;
+		ret = btintel_send_sar_ddc(hdev, cmd, sizeof(*cmd) + 1);
+		if (ret)
+			goto complete;
+
+		/* In this UEFI sequence, firmware interprets these writes as BSSS limits. */
+		for (i = 0; i < ARRAY_SIZE(bands); i++) {
+			ret = btintel_send_sar_rev2_band(hdev, cmd, bands[i].id,
+							 sar.chain_a[bands[i].band],
+							 sar.chain_b[bands[i].band]);
+			if (ret)
+				goto complete;
+		}
+	} else if (ret != -ENOENT && ret != -EOPNOTSUPP) {
+		goto complete;
+	} else {
+		ret = 0;
+	}
+
+complete:
+	skb = __hci_cmd_sync(hdev, 0xfe25, sizeof(enable), &enable,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_warn(hdev, "Failed to complete UEFI SAR setup (%ld)",
+			    PTR_ERR(skb));
+		return ret ? ret : PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+	return ret;
+}
+
 static int btintel_set_specific_absorption_rate(struct hci_dev *hdev,
 						struct intel_version_tlv *ver)
 {
+	u8 hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
+	int ret;
+
+	/* Supported SCP2+ platforms use this UEFI DDC map regardless of CNVr. */
+	if (hw_variant >= BTINTEL_HWID_SCP2 &&
+	    hw_variant != BTINTEL_HWID_BZRI &&
+	    hw_variant != BTINTEL_HWID_BZRIW) {
+		ret = btintel_set_uefi_sar(hdev);
+		if (ret && ret != -ENOENT && ret != -EOPNOTSUPP)
+			bt_dev_warn(hdev, "Failed to configure UEFI SAR (%d)", ret);
+	}
+
+	/*
+	 * Firmware preserves BSSS configuration across subsequent ACPI BRDS
+	 * programming, including writes to the shared DDC IDs and 0x019e.
+	 * Keep ACPI BRDS handling independent of the UEFI result.
+	 */
 #ifdef CONFIG_ACPI
 	return btintel_acpi_set_sar(hdev, ver);
 #endif
-- 
2.53.0


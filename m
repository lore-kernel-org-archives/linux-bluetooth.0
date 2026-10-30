Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361058;
	b=cClNZqY6sIAWYswnbn5joPFTPmTHkIaYE86XisWqY8k5PKZwl3SJVgDGktBhfW2PtSdo
	 nxc1vUp6yvcIlysPYLOZ4JAehhGnTU3PjBi2ge4OHVylLHfMVzRRhoHMMDz1PxagnMoLA
	 HuaG2+/eRyoowwHxLGOPSQp6KLzJJSUrDKTZogtXwnkLib/zlajfnZ441qsstjTN2WfwE
	 RQkY9nCQ+utJKKYePGuG9snbHx4C36+FdqIZ/smmIGog1Ii97STfsgy7G1JyHNZPqI87X
	 VuZB0Bcf+iMtq9jWh5/xGDR1mRv1fAAbTjDWZXYFeSHHZb6aPGu7Z8xkNp2B72eZCCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361058;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VZZ/cBly8VJXjVDwUSbUY7SFAEBiNMismQKz0bgFhNk=;
	b=lO7ngl0jfhT7F0Ye7hHQ2yCEo9w+D2id5lRyKt06P0KXB34OW+dK3AkTdL5xwqHMtkTm
	 lSUk3CZ1wWNZfMmcidMMrHlR1pnhoupTwa8/YHVrOb58JqbjnCZ0+F7TTe003EW66EX9u
	 JvlYEcKQG5S9dQ8MUys69ZN5gaJyD3uA6+JYaq+KZRyj112Je+T5HbJepj6+SrIXxEtUy
	 MQ9tTD6V6tlEjGDbfsC6SFqbbICk2QGC07UtfW1aGvwVKVctft56pLTH0fsMly5JUlJd3
	 X/gmpF7sdJbveclQcQSiLH0UQrLvBAplm7PXrz9HjXeOrRCOUwhKmNYtefqWFazB8dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Tph5l7Gn;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEB6606A31F
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 11:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FEB6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Tph5l7Gn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793361056; x=1824897056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4menVFgHbW85LX+iXGTblQxW587q1OmYq+twQ7yGzJI=;
  b=Tph5l7GnpOb8Hc1jTrfujCGA2VRAODG/nsexj2TSQsnwpRxJudjLQdBm
   dyKKA+uUrvz9TGEMtCw4xOR8soU0KTqmQicxYkJZ+ozrjHrdsvnw+Pxqd
   iNaWSYzyh45lbqpYw8L2lRszO3c++HUYKwHtyQwD9y29ivJkPO1mMTJCH
   sgL1jAf98NlfiYzWc3vU4ImETIWo4nFsrw4I2okTt8ZXKlCo7xw8UUhQT
   rgsd+6an80sK4/TaPwt2GGjHw+8zG4rqSM4ZRKmOwlcnmtdBS7XTWuMjw
   rWtd5E/tRApqDJT189U+z3IamTuTAlSIYVQK+v8Yjj9fLatyCtjgbZIrS
   A==;
X-CSE-ConnectionGUID: oMU5OjUUSTu5XyJ0FucyAA==
X-CSE-MsgGUID: RqUu4zW8ST27bVDXyu8CUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2124733"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2124733"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 04:50:56 -0700
X-CSE-ConnectionGUID: m/lFBr1tThCY2OIHf5vsZw==
X-CSE-MsgGUID: LxRIBU81SGujO30kfkUO0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7246451"
Received: from unknown (HELO WEBAPTLH152.iind.intel.com) ([10.66.226.239])
  by fmviesa011.fm.intel.com with ESMTP; 30 Oct 2026 04:50:54 -0700
From: Catherine L <catherine.l@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Catherine L <catherine.l@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Add UEFI BRDS and BPMO for PeP
Date: Fri, 30 Oct 2026 17:20:26 +0530
Message-ID: <20261030115033.115060-1-catherine.l@intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DCR-3475 adds per-modulation SAR offsets for PeP platforms. PeP
platforms expose BRDS and BPMO data through UEFI variables instead of
the legacy ACPI BRDS path.

Add UEFI-based SAR initialization for supported CNVi/CNVr combinations:
- SCP2, SCP2_C0, or SCP2F CNVi with PeP CNVr 0xA30
- Exclude WHP2 CNVr 0xA10, even when UEFI variables are present
- Read UefiCnvBtBRDS and write SarBrdsLimit2G4 DDC 0x0311
- Read UefiCnvBtBPMO and write BPMO DDC 0x0359, 0x035A, and 0x035B
- Preserve fixed UEFI structures, including header and mode fields
- Handle unsupported and oversized future UEFI revisions gracefully
- Send HCI_Intel_SarInitializeState_CMD (0xFE25) after SAR DDC writes

BRDS and BPMO are independent. Missing or disabled BIOS data is
non-fatal, and firmware proceeds with default SAR values. The existing
ACPI BRDS/SAR path, including mutual SAR and its 0xFE25 completion
command, remains unchanged. No ACPI BPMO path is added.

Initial UEFI validation passed 6/6 scenarios on a PEP STC card using
FW 255-255.255. Compatibility validation confirmed that platforms
without UEFI variables remain operational.

[RELEASEINFO]
program=all
ticket=jira:BT-479365
component=ibtpci
hw=all
sdl=na
test=notrelevant
justification=valid: UEFI BRDS/BPMO handling implemented for PeP CNVr 0xA30

Signed-off-by: Catherine L  <catherine.l@intel.com>
---
 drivers/bluetooth/btintel.c | 266 ++++++++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel.h |  29 ++++
 2 files changed, 284 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index b9bb6980bada..017681c7e3ce 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -28,8 +28,14 @@
 #define ECDSA_OFFSET		644
 #define ECDSA_HEADER_LEN	320
 
+#define BTINTEL_EFI_BPMO	L"UefiCnvBtBPMO"
+#define BTINTEL_EFI_BRDS	L"UefiCnvBtBRDS"
 #define BTINTEL_EFI_DSBR	L"UefiCnvCommonDSBR"
 
+static efi_guid_t btintel_efi_sar_guid =
+	EFI_GUID(0x42780dd5, 0x9a7d, 0x404c,
+		 0x80, 0xe4, 0x7f, 0x70, 0x94, 0x36, 0x03, 0x94);
+
 enum {
 	DSM_SET_WDISABLE2_DELAY = 1,
 	DSM_SET_RESET_METHOD = 3,
@@ -3092,6 +3098,7 @@ static union acpi_object *btintel_acpi_get_bt_pkg(union acpi_object *buffer)
 	}
 	return ERR_PTR(-ENOENT);
 }
+#endif /* CONFIG_ACPI */
 
 static int btintel_send_sar_ddc(struct hci_dev *hdev, struct btintel_cp_ddc_write *data, u8 len)
 {
@@ -3107,6 +3114,7 @@ static int btintel_send_sar_ddc(struct hci_dev *hdev, struct btintel_cp_ddc_writ
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
 static int btintel_send_edr(struct hci_dev *hdev, struct btintel_cp_ddc_write *cmd,
 			    int id, struct btintel_sar_inc_pwr *sar)
 {
@@ -3162,7 +3170,153 @@ static int btintel_send_edr3(struct hci_dev *hdev, struct btintel_cp_ddc_write *
 	cmd->data[0] = sar->edr3;
 	return btintel_send_sar_ddc(hdev, cmd, 4);
 }
+#endif /* CONFIG_ACPI */
+
+/* btintel_send_sar_complete - send HCI_Intel_SarInitializeState_CMD (0xFE25)
+ *
+ * Sent once after all SAR DDC writes are complete.
+ */
+static int btintel_send_sar_complete(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	bool enable = true;
+
+	skb = __hci_cmd_sync(hdev, 0xfe25, 1, &enable, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "BT_SAR: failed to send SAR initialization complete (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+	return 0;
+}
+
+/* btintel_write_bpmo_ddc - write BPMO DDC constants to firmware
+ *
+ * Writes DDC_ID_SAR_BPMO_ENABLE (1 byte), DDC_ID_SAR_BPMO_OFFSET_A (16 bytes)
+ * and DDC_ID_SAR_BPMO_OFFSET_B (16 bytes) via HCI WriteDdcConst (0xfc8b).
+ * Values are passed through unchanged from the BIOS UEFI variable; no
+ * arithmetic is performed by the driver (HLD DCR-3475 §5.1 step 2).
+ */
+static int btintel_write_bpmo_ddc(struct hci_dev *hdev,
+				  const struct btintel_bpmo *bpmo)
+{
+	u8 buffer[sizeof(struct btintel_cp_ddc_write) + BTINTEL_BPMO_NUM_MODULATIONS];
+	struct btintel_cp_ddc_write *cmd = (void *)buffer;
+	int ret;
+
+	/* Enable flag (1 byte) — SarBpmoEnable (0x0359) */
+	cmd->len     = 3;
+	cmd->id      = cpu_to_le16(BTINTEL_DDC_ID_SAR_BPMO_ENABLE);
+	cmd->data[0] = !!(le32_to_cpu(bpmo->mode) & BIT(0));
+	ret = btintel_send_sar_ddc(hdev, cmd, 4);
+	if (ret) {
+		bt_dev_err(hdev, "BT_BPMO: failed to write DDC enable (0x%04x): %d",
+			   BTINTEL_DDC_ID_SAR_BPMO_ENABLE, ret);
+		return ret;
+	}
+	/* Chain A per-modulation offsets (16 bytes) — SarBpmoChainA (0x035A) */
+	cmd->len = 2 + BTINTEL_BPMO_NUM_MODULATIONS;
+	cmd->id  = cpu_to_le16(BTINTEL_DDC_ID_SAR_BPMO_CHAIN_A);
+	memcpy(cmd->data, bpmo->chain_a, BTINTEL_BPMO_NUM_MODULATIONS);
+	ret = btintel_send_sar_ddc(hdev, cmd,
+				   sizeof(*cmd) + BTINTEL_BPMO_NUM_MODULATIONS);
+	if (ret) {
+		bt_dev_err(hdev, "BT_BPMO: failed to write DDC chain A (0x%04x): %d",
+			   BTINTEL_DDC_ID_SAR_BPMO_CHAIN_A, ret);
+		return ret;
+	}
+	/* Chain B per-modulation offsets (16 bytes) — SarBpmoChainB (0x035B) */
+	cmd->len = 2 + BTINTEL_BPMO_NUM_MODULATIONS;
+	cmd->id  = cpu_to_le16(BTINTEL_DDC_ID_SAR_BPMO_CHAIN_B);
+	memcpy(cmd->data, bpmo->chain_b, BTINTEL_BPMO_NUM_MODULATIONS);
+	ret = btintel_send_sar_ddc(hdev, cmd,
+				   sizeof(*cmd) + BTINTEL_BPMO_NUM_MODULATIONS);
+	if (ret) {
+		bt_dev_err(hdev, "BT_BPMO: failed to write DDC chain B (0x%04x): %d",
+			   BTINTEL_DDC_ID_SAR_BPMO_CHAIN_B, ret);
+		return ret;
+	}
+	return 0;
+}
+
+/* btintel_uefi_get_bpmo - read BT per-modulation SAR offsets from UEFI variable
+ *
+ * Reads UefiCnvBtBPMO (CNV_UEFI_VAR_BPMO, Revision 0) from the UEFI runtime
+ * variable store for the PeP/SCP2 path.
+ *
+ * Returns  0           on success; @bpmo is filled.
+ * Returns -ENOENT      if the variable is absent.
+ * Returns -EOPNOTSUPP  if EFI runtime is unavailable or revision unsupported.
+ * Returns -EINVAL/-EIO on structural or read errors.
+ *
+ * Layout confirmed by BIOS team (Kobi), total 37 bytes:
+ *   u8  header/revision  (offset 0)
+ *   u32 mode      (offset 1, no padding — struct is __packed)
+ *   u8  chain_a[16] (offset 5)
+ *   u8  chain_b[16] (offset 21)
+ */
+static int btintel_uefi_get_bpmo(struct hci_dev *hdev, struct btintel_bpmo *bpmo)
+{
+	unsigned long data_size = sizeof(*bpmo);
+	efi_status_t status;
+
+	if (!IS_ENABLED(CONFIG_EFI))
+		return -EOPNOTSUPP;
 
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return -EOPNOTSUPP;
+
+	status = efi.get_variable(BTINTEL_EFI_BPMO, &btintel_efi_sar_guid, NULL,
+				  &data_size, bpmo);
+	if (status == EFI_NOT_FOUND)
+		return -ENOENT;
+	/* larger variable = future revision; treat as unsupported rather than error */
+	if (status == EFI_BUFFER_TOO_SMALL)
+		return -EOPNOTSUPP;
+	if (status != EFI_SUCCESS) {
+		bt_dev_warn(hdev, "BT_BPMO: UEFI variable read error (0x%lx)",
+			    status);
+		return -EIO;
+	}
+
+	if (data_size < sizeof(*bpmo)) {
+		bt_dev_warn(hdev, "BT_BPMO: UEFI variable too small (%lu < %zu)",
+			    data_size, sizeof(*bpmo));
+		return -EINVAL;
+	}
+
+	if (bpmo->header != 0) {
+		bt_dev_dbg(hdev, "BT_BPMO: unsupported UEFI revision %u",
+			   bpmo->header);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/* btintel_set_bpmo - apply UEFI BT per-modulation SAR offsets to firmware */
+static int btintel_set_bpmo(struct hci_dev *hdev)
+{
+	struct btintel_bpmo bpmo;
+	int ret;
+
+	ret = btintel_uefi_get_bpmo(hdev, &bpmo);
+	if (ret == 0) {
+		if (!(le32_to_cpu(bpmo.mode) & BIT(0)))
+			return 0;
+		ret = btintel_write_bpmo_ddc(hdev, &bpmo);
+		if (ret)
+			bt_dev_err(hdev, "BT_BPMO: DDC write failed (%d)", ret);
+		return ret;
+	}
+
+	if (ret != -ENOENT && ret != -EOPNOTSUPP)
+		bt_dev_warn(hdev, "BT_BPMO: UEFI read failed (%d)", ret);
+	return -ENOENT;
+}
+
+#ifdef CONFIG_ACPI
 static int btintel_set_legacy_sar(struct hci_dev *hdev, struct btintel_sar_inc_pwr *sar)
 {
 	struct btintel_cp_ddc_write *cmd;
@@ -3202,9 +3356,7 @@ static int btintel_set_legacy_sar(struct hci_dev *hdev, struct btintel_sar_inc_p
 static int btintel_set_mutual_sar(struct hci_dev *hdev, struct btintel_sar_inc_pwr *sar)
 {
 	struct btintel_cp_ddc_write *cmd;
-	struct sk_buff *skb;
 	u8 buffer[64];
-	bool enable;
 	int ret;
 
 	cmd = (void *)buffer;
@@ -3249,15 +3401,7 @@ static int btintel_set_mutual_sar(struct hci_dev *hdev, struct btintel_sar_inc_p
 	if (ret)
 		return ret;
 
-	enable = true;
-	skb = __hci_cmd_sync(hdev, 0xfe25, 1, &enable, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
-		bt_dev_warn(hdev, "Failed to send Intel SAR Enable (%ld)", PTR_ERR(skb));
-		return PTR_ERR(skb);
-	}
-
-	kfree_skb(skb);
-	return 0;
+	return btintel_send_sar_complete(hdev);
 }
 
 /* btintel_send_sar_rev2_band - send DDC command for one Rev2 sub-band
@@ -3544,9 +3688,109 @@ static int btintel_acpi_set_sar(struct hci_dev *hdev, struct intel_version_tlv *
 }
 #endif /* CONFIG_ACPI */
 
+/* btintel_uefi_get_brds - read SAR limits from UEFI variable UefiCnvBtBRDS
+ *
+ * Primary SAR data source that expose BRDS
+ * via UEFI instead of ACPI.  Uses the same GUID as UefiCnvBtBPMO.
+ *
+ * Writes BRDS DDC only — does NOT call btintel_set_bpmo() or send 0xFE25.
+ * BPMO and 0xFE25 are handled independently by the caller.
+ *
+ * CNV_UEFI_VAR_BRDS revision 2 layout (confirmed by BIOS team, 19 bytes):
+ *   u8  header          - CNV_UEFI_VAR_HEADER (0x02 = revision 2)
+ *   u32 mode            - bit 0: SAR enabled (0=disabled, 1=enabled)
+ *   u32 inc_power_mode  - 0=enabled, 1=disabled
+ *   u8  chain_a[5]      - BT_SAR_POWER_LIMITS chain A [2G4,5G2,5G8,6G1,6G3]
+ *   u8  chain_b[5]      - BT_SAR_POWER_LIMITS chain B [2G4,5G2,5G8,6G1,6G3]
+ */
+static int btintel_uefi_get_brds(struct hci_dev *hdev)
+{
+	struct {
+		u8  header;      /* CNV_UEFI_VAR_HEADER: 0x02 = revision 2 */
+		__le32 mode;     /* bit 0: 1=SAR enabled, 0=disabled        */
+		__le32 inc_power_mode; /* 0=enabled, 1=disabled            */
+		u8  chain_a[5];  /* sub-band limits chain A: [2G4,5G2,5G8,6G1,6G3] */
+		u8  chain_b[5];  /* sub-band limits chain B: [2G4,5G2,5G8,6G1,6G3] */
+	} __packed var;
+	unsigned long data_size = sizeof(var);
+	efi_status_t status;
+
+	if (!IS_ENABLED(CONFIG_EFI))
+		return -EOPNOTSUPP;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return -EOPNOTSUPP;
+
+	status = efi.get_variable(BTINTEL_EFI_BRDS, &btintel_efi_sar_guid, NULL,
+				  &data_size, &var);
+	if (status == EFI_NOT_FOUND)
+		return -ENOENT;
+	/* larger variable = future revision; treat as unsupported rather than error */
+	if (status == EFI_BUFFER_TOO_SMALL)
+		return -EOPNOTSUPP;
+	if (status != EFI_SUCCESS) {
+		bt_dev_warn(hdev, "BT_SAR: UEFI BRDS read error (0x%lx)", status);
+		return -EIO;
+	}
+
+	if (data_size < sizeof(var)) {
+		bt_dev_warn(hdev, "BT_SAR: UEFI BRDS too small (%lu < %zu)",
+			    data_size, sizeof(var));
+		return -EINVAL;
+	}
+
+	if (var.header != 0x02) {
+		bt_dev_warn(hdev, "BT_SAR: UEFI BRDS unsupported revision 0x%02x", var.header);
+		return -EOPNOTSUPP;
+	}
+
+	if (!(le32_to_cpu(var.mode) & BIT(0))) {
+		bt_dev_dbg(hdev, "BT_SAR: UEFI BRDS SAR not enabled in BIOS");
+		return -EOPNOTSUPP;
+	}
+
+	/* BT operates at 2.4 GHz only — write SarBrdsLimit2G4 (0x0311) with chain A/B pair. */
+	{
+		u8 buf[sizeof(struct btintel_cp_ddc_write) + 2];
+		struct btintel_cp_ddc_write *cmd = (void *)buf;
+		int ret;
+
+		cmd->len     = 4; /* 2 (id) + 2 (data) */
+		cmd->id      = cpu_to_le16(BTINTEL_DDC_ID_SAR_BRDS_LIMIT_2G4);
+		cmd->data[0] = var.chain_a[0]; /* subBand2G4 Chain A */
+		cmd->data[1] = var.chain_b[0]; /* subBand2G4 Chain B */
+
+		ret = btintel_send_sar_ddc(hdev, cmd, sizeof(*cmd) + 2);
+		if (ret) {
+			bt_dev_warn(hdev, "BT_SAR: BRDS DDC write failed (0x%04x): %d",
+				    BTINTEL_DDC_ID_SAR_BRDS_LIMIT_2G4, ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
 static int btintel_set_specific_absorption_rate(struct hci_dev *hdev,
 						struct intel_version_tlv *ver)
 {
+	u16 cnvi = ver->cnvi_top & 0xfff;
+	u16 cnvr = ver->cnvr_top & 0xfff;
+	int ret;
+
+	/* SCP2/SCP2F with PeP CNVr: UEFI path, independent of CONFIG_ACPI */
+	if ((cnvi == BTINTEL_CNVI_SCP2 || cnvi == BTINTEL_CNVI_SCP2_C0 ||
+	     cnvi == BTINTEL_CNVI_SCP2F) && cnvr == BTINTEL_CNVR_PEP) {
+		ret = btintel_uefi_get_brds(hdev);
+		if (ret && ret != -ENOENT && ret != -EOPNOTSUPP)
+			bt_dev_warn(hdev, "BT_SAR: BRDS DDC failed (%d)", ret);
+
+		ret = btintel_set_bpmo(hdev);
+		if (ret && ret != -ENOENT)
+			bt_dev_warn(hdev, "BT_BPMO: failed (%d)", ret);
+
+		return btintel_send_sar_complete(hdev);
+	}
+
 #ifdef CONFIG_ACPI
 	return btintel_acpi_set_sar(hdev, ver);
 #endif
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d5e125ec5168..338a4beed5cc 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -71,6 +71,7 @@ struct intel_tlv {
 /* CNVR */
 #define BTINTEL_CNVR_FMP2		0x910
 #define BTINTEL_CNVR_WHP2		0xA10	/* Whale Peak2 - Panther Lake */
+#define BTINTEL_CNVR_PEP		0xA30   /* PeP2 / PeP STC */
 
 #define BTINTEL_IMG_BOOTLOADER		0x01	/* Bootloader image */
 #define BTINTEL_IMG_IML			0x02	/* Intermediate image */
@@ -222,6 +223,34 @@ struct btintel_sar_inc_pwr {
 	u8	le_lr;
 };
 
+/* DCR-3475: BT SAR Per Modulation Offset (BPMO)
+ *
+ * BPMO_NUM_MODULATIONS = 16 (indices 0-12 active, 13-15 reserved).
+ */
+#define BTINTEL_BPMO_NUM_MODULATIONS	16
+
+/* BPMO UEFI variable (Revision 0) layout:
+ *   [0]       Header/revision (0 = Revision 0)
+ *   [1..4]    Mode (0 = disabled, 1 = enabled, little-endian u32)
+ *   [5..20]   Chain A per-modulation offsets (u8, format xxxxx.yyy)
+ *   [21..36]  Chain B per-modulation offsets (u8, format xxxxx.yyy)
+ * Index-to-modulation mapping (sc_sar.h scSar_bpmoModulation_en):
+ *   0=BR, 1=EDR2M, 2=EDR3M, 3=LE1M, 4=LE2M, 5=CS, 6=LRS2, 7=LRS8,
+ *   8=HDT2, 9=HDT3, 10=HDT4, 11=HDT6, 12=HDT7P5, 13-15=reserved
+ */
+struct btintel_bpmo {
+	u8	header;
+	__le32	mode;
+	u8	chain_a[BTINTEL_BPMO_NUM_MODULATIONS];
+	u8	chain_b[BTINTEL_BPMO_NUM_MODULATIONS];
+} __packed;
+
+#define BTINTEL_DDC_ID_SAR_BRDS_LIMIT_2G4	0x0311
+
+#define BTINTEL_DDC_ID_SAR_BPMO_ENABLE		0x0359
+#define BTINTEL_DDC_ID_SAR_BPMO_CHAIN_A		0x035A
+#define BTINTEL_DDC_ID_SAR_BPMO_CHAIN_B		0x035B
+
 /* Bluetooth SAR feature (BRDS), Revision 2 - per-chain sub-band power limits */
 struct btintel_sar_band_limits {
 	u8	subband_2g4;
-- 
2.43.0


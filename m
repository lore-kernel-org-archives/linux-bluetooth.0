Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75343BDD4
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734802; cv=none; b=gQ/2n641jdJlrRmOIP83+SmzibpbgpCMsETQqvNV0tY7ZjrLryVb18AfWpqb0HUqRirimD9PfOVoCe104GMhYbWMzGES/Hezqdh2N3Nz+SlB1K4Eqksp/Jz++ljeQRHGn976J1DhSamGeGEwM09X8Dnp6Ze/Nr4hrEZyIGlokQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734802; c=relaxed/simple;
	bh=8jINiUOkUa71fVwPNZxD0OjTnudh03+MWyhgcuCIS4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=doaL5/3pnYXGlTjIC4irB4TjEWiviOx0tw+L6v8jxoK4Cb0HXFDAArJqDc0JKClS29gcqH2tRryLAktSTHlCxWibYx5f1zFRBtifInsKRTC0jneTftbqhLriroc689NPiEmDuxlnEt6x7zL6a7ECVN5nZ1O9dwvWiq7g4inuct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMp5G8aO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMp5G8aO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784734800; x=1816270800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8jINiUOkUa71fVwPNZxD0OjTnudh03+MWyhgcuCIS4s=;
  b=ZMp5G8aOMNPhy2+80V+zuAL+AGHciIy/vApwECWsNs+/qOPlitXMAhe9
   DRcS9gPF/TewobT8hp/APxKlO8RsNKtMKIdK7mZlri17Yt1jYu7o1UEnm
   XUsBraxllJ5p44LzNd/9LB8dvBqWLeQp++IwejPBHLotAxxQtFWi4CbDW
   P4HtUTiDCjFDOTuiiLzKdGhU6+VcaURnuuF5p3gpoKq8lLxlJ984oQ77A
   MiPaymcZ55f6rXmniKUSOlCF6tyWJqx2qzB0dl0OoMhzN5Th79GxAvA+w
   F6DWbY+bcDw5PeO/yR5Df7MfE/QA5d/1K2lwuv92EM63wQVLzlvmcF4l3
   g==;
X-CSE-ConnectionGUID: hkXgr2Q3TDaPYNmlPzNLTA==
X-CSE-MsgGUID: 5fV9hyJjSwaLcfOkk3TGYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85245599"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="85245599"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 08:40:00 -0700
X-CSE-ConnectionGUID: SzREAb9GRFCIVTdovBM2Uw==
X-CSE-MsgGUID: +i4CtfvxTZSFZug4QPMoUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="262426372"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa005.jf.intel.com with ESMTP; 22 Jul 2026 08:39:57 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v3] Bluetooth: btintel: Add Bluetooth SAR revision 2 support
Date: Wed, 22 Jul 2026 21:29:43 +0530
Message-ID: <20260722155943.296245-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BRDS revision 2 introduces per-chain (Chain A and Chain B) TX power
limits across five sub-bands (2.4G, 5.2G, 5.8/5.9G, 6G-low, 6G-high),
replacing the single-chain per-modulation model of revisions 0 and 1.

- Add btintel_set_sar_rev2() which sends the full Rev2 DDC sequence:
    0x019e  inc-power-mode enable flag        (1 byte)
    0x0311  2.4 GHz sub-band limits           (2 bytes)
    0x0312  5.2 GHz sub-band limits           (2 bytes)
    0x0313  5.8/5.9 GHz sub-band limits       (2 bytes)
    0x0314  5.8/5.9 GHz sub-band limits again (2 bytes, duplicate FW reg)
    0x0315  6 GHz low sub-band limits         (2 bytes)
    0x0316  6 GHz high sub-band limits        (2 bytes)
  followed by the SAR-init-complete command (0xfe25).

logs from dmesg when BTSAR2 is enabled in Coreboot/BIOS:

Bluetooth: hci0: BT SAR Rev2: revision=2 bt_sar_bios=1 inc_power_mode=1
Bluetooth: hci0: BT SAR Rev2 Chain A: 2g4=76 5g2=0 5g8_5g9=0 6g1=0 6g3=0
Bluetooth: hci0: BT SAR Rev2 Chain B: 2g4=102 5g2=0 5g8_5g9=0 6g1=0 6g3=0

Signed-off-by: Ravindra <ravindra@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v3:
- Fix comment in the code.
- Address comments from Luiz.

changes in v2:
changes in v2:
- Update commit message to include logs.
- Validate the ACPI types/size before accessing.

 drivers/bluetooth/btintel.c | 191 +++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h |  18 ++++
 2 files changed, 208 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5e9cac090bd8..2f1b78ddb9a7 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -51,6 +51,7 @@ enum {
 #define BTINTEL_BT_DOMAIN		0x12
 #define BTINTEL_SAR_LEGACY		0
 #define BTINTEL_SAR_INC_PWR		1
+#define BTINTEL_SAR_REV2		2
 #define BTINTEL_SAR_INC_PWR_SUPPORTED	0
 
 #define CMD_WRITE_BOOT_PARAMS	0xfc0e
@@ -3104,6 +3105,111 @@ static int btintel_set_mutual_sar(struct hci_dev *hdev, struct btintel_sar_inc_p
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
+static int btintel_set_sar_rev2(struct hci_dev *hdev,
+				struct btintel_sar_rev2 *sar)
+{
+	struct btintel_cp_ddc_write *cmd;
+	struct sk_buff *skb;
+	u8 buffer[64];
+	u8 enable;
+	int ret;
+
+	cmd = (void *)buffer;
+
+	/* DDC 0x019e: enable/disable increased power mode SAR (1 byte) */
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(0x019e);
+	cmd->data[0] = (sar->inc_power_mode == BTINTEL_SAR_INC_PWR_SUPPORTED) ?
+			0x01 : 0x00;
+	ret = btintel_send_sar_ddc(hdev, cmd, 4);
+	if (ret)
+		return ret;
+
+	/* DDC 0x0311-0x0316: per sub-band ChainA + ChainB limits */
+	ret = btintel_send_sar_rev2_band(hdev, cmd, 0x0311,
+					 sar->chain_a.subband_2g4,
+					 sar->chain_b.subband_2g4);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_sar_rev2_band(hdev, cmd, 0x0312,
+					 sar->chain_a.subband_5g2,
+					 sar->chain_b.subband_5g2);
+	if (ret)
+		return ret;
+
+	/* 0x0313 and 0x0314 both carry the 5G8/5G9 value */
+	ret = btintel_send_sar_rev2_band(hdev, cmd, 0x0313,
+					 sar->chain_a.subband_5g8_5g9,
+					 sar->chain_b.subband_5g8_5g9);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_sar_rev2_band(hdev, cmd, 0x0314,
+					 sar->chain_a.subband_5g8_5g9,
+					 sar->chain_b.subband_5g8_5g9);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_sar_rev2_band(hdev, cmd, 0x0315,
+					 sar->chain_a.subband_6g1,
+					 sar->chain_b.subband_6g1);
+	if (ret)
+		return ret;
+
+	ret = btintel_send_sar_rev2_band(hdev, cmd, 0x0316,
+					 sar->chain_a.subband_6g3,
+					 sar->chain_b.subband_6g3);
+	if (ret)
+		return ret;
+
+	/* Notify firmware that SAR initialisation is complete */
+	enable = 0x01;
+	skb = __hci_cmd_sync(hdev, 0xfe25, sizeof(enable), &enable, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_warn(hdev, "Failed to send Intel SAR Rev2 Enable (%ld)",
+			    PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static int btintel_sar_rev2_send_to_device(struct hci_dev *hdev,
+					   struct btintel_sar_rev2 *sar,
+					   struct intel_version_tlv *ver)
+{
+	u16 cnvi = ver->cnvi_top & 0xfff;
+	u16 cnvr = ver->cnvr_top & 0xfff;
+
+	if (cnvi < BTINTEL_CNVI_BLAZARI || cnvr != BTINTEL_CNVR_WHP2) {
+		bt_dev_dbg(hdev, "BT SAR Rev2 not supported on this platform (cnvi=0x%x cnvr=0x%x)",
+			   cnvi, cnvr);
+		return -EOPNOTSUPP;
+	}
+
+	bt_dev_info(hdev, "Applying Bluetooth SAR Rev2");
+	return btintel_set_sar_rev2(hdev, sar);
+}
+
 static int btintel_sar_send_to_device(struct hci_dev *hdev, struct btintel_sar_inc_pwr *sar,
 				      struct intel_version_tlv *ver)
 {
@@ -3130,6 +3236,7 @@ static int btintel_acpi_set_sar(struct hci_dev *hdev, struct intel_version_tlv *
 {
 	union acpi_object *bt_pkg, *buffer = NULL;
 	struct btintel_sar_inc_pwr sar;
+	struct btintel_sar_rev2 sar_rev2;
 	acpi_status status;
 	u8 revision;
 	int ret;
@@ -3150,14 +3257,96 @@ static int btintel_acpi_set_sar(struct hci_dev *hdev, struct intel_version_tlv *
 		goto error;
 	}
 
+	if (buffer->package.elements[0].type != ACPI_TYPE_INTEGER) {
+		bt_dev_warn(hdev, "BT_SAR: unexpected ACPI type for revision field");
+		ret = -EINVAL;
+		goto error;
+	}
+
 	revision = buffer->package.elements[0].integer.value;
 
-	if (revision > BTINTEL_SAR_INC_PWR) {
+	if (revision > BTINTEL_SAR_REV2) {
 		bt_dev_dbg(hdev, "BT_SAR: revision: 0x%2.2x not supported", revision);
 		ret = -EOPNOTSUPP;
 		goto error;
 	}
 
+	if (revision == BTINTEL_SAR_REV2 && bt_pkg->package.count == 13) {
+		/* Element layout: 0 = domain ID (BTINTEL_BT_DOMAIN, 0x12),
+		 * 1 = bt_sar_bios (u32), 2 = inc_power_mode (u32),
+		 * 3..12 = per-chain sub-band limits (u8 each).
+		 */
+		static const u64 rev2_max[13] = {
+			U8_MAX,				/* domain ID */
+			U32_MAX, U32_MAX,		/* bt_sar_bios, inc_power_mode */
+			U8_MAX, U8_MAX, U8_MAX, U8_MAX, U8_MAX,	/* chain A */
+			U8_MAX, U8_MAX, U8_MAX, U8_MAX, U8_MAX,	/* chain B */
+		};
+		union acpi_object *e;
+		int i;
+
+		for (i = 0; i < 13; i++) {
+			e = &bt_pkg->package.elements[i];
+			if (e->type != ACPI_TYPE_INTEGER) {
+				bt_dev_warn(hdev, "BT SAR Rev2: unexpected ACPI type at element %d",
+					    i);
+				ret = -EINVAL;
+				goto error;
+			}
+			if (e->integer.value > rev2_max[i]) {
+				bt_dev_warn(hdev, "BT SAR Rev2: element %d value 0x%llx out of range",
+					    i, e->integer.value);
+				ret = -ERANGE;
+				goto error;
+			}
+		}
+
+		memset(&sar_rev2, 0, sizeof(sar_rev2));
+		sar_rev2.revision       = revision;
+
+		if (sar_rev2.bt_sar_bios != 1) {
+			bt_dev_warn(hdev, "Bluetooth SAR Rev2 is not enabled");
+			ret = -EOPNOTSUPP;
+			goto error;
+		}
+
+		sar_rev2.bt_sar_bios    = bt_pkg->package.elements[1].integer.value;
+		sar_rev2.inc_power_mode = bt_pkg->package.elements[2].integer.value;
+
+		sar_rev2.chain_a.subband_2g4     = bt_pkg->package.elements[3].integer.value;
+		sar_rev2.chain_a.subband_5g2     = bt_pkg->package.elements[4].integer.value;
+		sar_rev2.chain_a.subband_5g8_5g9 = bt_pkg->package.elements[5].integer.value;
+		sar_rev2.chain_a.subband_6g1     = bt_pkg->package.elements[6].integer.value;
+		sar_rev2.chain_a.subband_6g3     = bt_pkg->package.elements[7].integer.value;
+
+		sar_rev2.chain_b.subband_2g4     = bt_pkg->package.elements[8].integer.value;
+		sar_rev2.chain_b.subband_5g2     = bt_pkg->package.elements[9].integer.value;
+		sar_rev2.chain_b.subband_5g8_5g9 = bt_pkg->package.elements[10].integer.value;
+		sar_rev2.chain_b.subband_6g1     = bt_pkg->package.elements[11].integer.value;
+		sar_rev2.chain_b.subband_6g3     = bt_pkg->package.elements[12].integer.value;
+
+		bt_dev_dbg(hdev, "BT SAR Rev2: revision=%u bt_sar_bios=%u inc_power_mode=%u",
+			   sar_rev2.revision, sar_rev2.bt_sar_bios, sar_rev2.inc_power_mode);
+		bt_dev_dbg(hdev, "BT SAR Rev2 Chain A: 2g4=%u 5g2=%u 5g8_5g9=%u 6g1=%u 6g3=%u",
+			   sar_rev2.chain_a.subband_2g4, sar_rev2.chain_a.subband_5g2,
+			   sar_rev2.chain_a.subband_5g8_5g9, sar_rev2.chain_a.subband_6g1,
+			   sar_rev2.chain_a.subband_6g3);
+		bt_dev_dbg(hdev, "BT SAR Rev2 Chain B: 2g4=%u 5g2=%u 5g8_5g9=%u 6g1=%u 6g3=%u",
+			   sar_rev2.chain_b.subband_2g4, sar_rev2.chain_b.subband_5g2,
+			   sar_rev2.chain_b.subband_5g8_5g9, sar_rev2.chain_b.subband_6g1,
+			   sar_rev2.chain_b.subband_6g3);
+
+		ret = btintel_sar_rev2_send_to_device(hdev, &sar_rev2, ver);
+		goto error;
+	}
+
+	if (revision == BTINTEL_SAR_REV2) {
+		bt_dev_warn(hdev, "BT SAR Rev2: unexpected ACPI package count %d (expected 13)",
+			    bt_pkg->package.count);
+		ret = -EINVAL;
+		goto error;
+	}
+
 	memset(&sar, 0, sizeof(sar));
 
 	if (revision == BTINTEL_SAR_LEGACY && bt_pkg->package.count == 8) {
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 37d93abdd5a3..966ec1b02be2 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -65,6 +65,7 @@ struct intel_tlv {
 
 /* CNVR */
 #define BTINTEL_CNVR_FMP2		0x910
+#define BTINTEL_CNVR_WHP2		0xA10	/* Whale Peak2 - Panther Lake */
 
 #define BTINTEL_IMG_BOOTLOADER		0x01	/* Bootloader image */
 #define BTINTEL_IMG_IML			0x02	/* Intermediate image */
@@ -204,6 +205,23 @@ struct btintel_sar_inc_pwr {
 	u8	le_lr;
 };
 
+/* Bluetooth SAR feature (BRDS), Revision 2 - per-chain sub-band power limits */
+struct btintel_sar_band_limits {
+	u8	subband_2g4;
+	u8	subband_5g2;
+	u8	subband_5g8_5g9;
+	u8	subband_6g1;
+	u8	subband_6g3;
+};
+
+struct btintel_sar_rev2 {
+	u8	revision;
+	u32	bt_sar_bios;    /* 1: BIOS-managed SAR enabled */
+	u32	inc_power_mode; /* 0: supported, 1: disabled */
+	struct btintel_sar_band_limits chain_a;
+	struct btintel_sar_band_limits chain_b;
+};
+
 #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
 #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
 #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
-- 
2.54.0


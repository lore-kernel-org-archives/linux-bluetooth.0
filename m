Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795498769;
	b=vO9At7W/qgaooGdPRAM8lp3E8tFfcT6lliQDYGAD84n4TxxQpz6IADgldVFp8L68kV7U
	 TjaVvGGk6eu3LZ7omrTPRN6jwVMqFmwzjAPZuiGSHp1mMtDZzkoi49TCOzA29g4Cxk3nl
	 4TolddNw7L7AX5d2RWDrB92l5+tq7vEkKYe7Y7unwWDmonOcQw3IZCKDy19sCn8esXiUY
	 tOGqzrqYooNb9OnsVN4Z9EyXpK4Sh5zOGkwFpvgoXevuNNREbtMCBylLgfDpmeJC6dz0l
	 zRvcPPbSnVhkQmJCgxlMEFSLLYjjUVtief2Px/BFt5M0FFsZWrF7e0DPPbvklDznQAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795498769;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MPScnmKqU/n5MKA/g3TH54dB/wxLtTjScn4VpvD87cI=;
	b=L5omQqeDu7iexeNyAV5pa5tmUgd9E1jm7/Z1QFb/HGiLbrlMqdjzpNb/okbntoMoR0q2
	 jeawr3UB11aLUTjKlYSQ36Uk4Tf+KT574c8ImNP7Sb6GefC1rYWsBdPnXi7m2fmeDh5qQ
	 LTal3pX019lu5OdlcddOESwcpwLnyvCxPTk87/L/eIPkKlr6pxoN3aHGi/9cXLWO7tOKf
	 MaGEexF4JnHoN6k646y3S5Z3WXQuH1iRGj2UMSkTH5jKEGUTsXbBSHaaY3MWw3BMCkSjm
	 TBzI07MCZOKWVb5LdyQOj09bQyioGu70JlArESrMvCpj8ZmTKDxD9YWY3v59+ozdYsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GU+nPnAk;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D40606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D40606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GU+nPnAk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795498769; x=1827034769;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VaUa+4l2HnLU6DkFt5aQk9AAJbIQZ57em0yDM3SBj4s=;
  b=GU+nPnAkWLDSmzuvjKY1/KAJCLKpQp5lj3K7SCqfBGGFBZRz+fKf4K9S
   SXjNqDk7hrcfeNuDwIdAO+LBhlqOwQEeu1tLZfYqxgoeEJ6hmE4hpq1pu
   dodNNBWFZnb3C9V/OZx5brrJHSs1MKk1Wd7wuWNKePmOqUCJglJuQkMB5
   I1s1rpsnkp+WSNZh+9KB8wAse7ORNZwdi99HDl46nngbFjAdZvmSoAZj9
   0nx2Lye/LzVHz8zuEuNC8u4ZR6jPPX8eIKJrPZDfBZqopSdeq45su17Zt
   NcEqHXsIgrodQkp5aDNSuSl6BAmy3OCOAPAcmfJYk3e5NIBFXpYqPcy4T
   w==;
X-CSE-ConnectionGUID: d11REu3XQVWPWkI9OvqhFg==
X-CSE-MsgGUID: KZfvpJVwT4aPlRNW5+IHmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4304258"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4304258"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 21:39:28 -0800
X-CSE-ConnectionGUID: lnFOM3nPSg+LAzWU3FGdHQ==
X-CSE-MsgGUID: D2vvDaCRQ4SSKEuzdyyhsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11683835"
Received: from unknown (HELO WEBAPTLH152.iind.intel.com) ([10.66.226.239])
  by fmviesa002.fm.intel.com with ESMTP; 23 Nov 2026 21:39:26 -0800
From: Catherine L <catherine.l@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Catherine L <catherine.l@intel.com>
Subject: [PATCH v3] Bluetooth: btintel: Add UEFI BPMO support for PeP
Date: Tue, 24 Nov 2026 11:08:12 +0530
Message-ID: <20261124053812.249973-1-catherine.l@intel.com>
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
Content-Transfer-Encoding: 8bit

PeP and later CNVr platforms allow the BIOS to supply a per-modulation
SAR offset table (BPMO) through the UefiCnvBtBPMO UEFI variable. The
firmware subtracts these per-chain, per-modulation offsets from the
BRDS limit, giving finer SAR granularity than a single limit per band.

Read UefiCnvBtBPMO in the UEFI SAR path after the BRDS and BSSS
handling. When the CNVr is PeP or later, UEFI BRDS revision 2 is
enabled, the SAR tables are locked, and the BPMO revision 0 variable
is enabled, write the BPMO enable flag (DDC 0x0359) followed by the
chain A (DDC 0x035A) and chain B (DDC 0x035B) offset tables.

The values are passed to the firmware unchanged. The existing SAR
initialization complete command (0xfe25) is still sent once, after all
SAR DDC writes. A missing, disabled or unsupported BPMO variable is not
treated as an error, and the firmware keeps its default of no offset.

The existing ACPI and UEFI BRDS/BSSS flows are unchanged.

Fixes: 4bc12982b9b6 ("Bluetooth: btintel: Add UEFI standalone static SAR support")
Signed-off-by: Catherine L <catherine.l@intel.com>
---
Changes in v3:
- Added Fixes tag

Changes in v2:
- addressed sashiko comments
- rebased patch
---
 drivers/bluetooth/btintel.c | 75 ++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h |  7 ++++
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 15c00d833f27..37fd2e31fd79 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -30,6 +30,7 @@
 
 #define BTINTEL_EFI_DSBR	L"UefiCnvCommonDSBR"
 #define BTINTEL_EFI_BRDS	L"UefiCnvBtBRDS"
+#define BTINTEL_EFI_BPMO	L"UefiCnvBtBPMO"
 #define BTINTEL_EFI_BSSS	L"UefiCnvBtBSSS"
 #define BTINTEL_EFI_GLUI	L"UefiCnvCommonGLUI"
 
@@ -62,6 +63,13 @@ struct btintel_uefi_sar {
 	u8 chain_b[5];
 } __packed;
 
+struct btintel_bpmo {
+	u8	header;
+	__le32	mode;
+	u8	chain_a[BTINTEL_BPMO_NUM_MODULATIONS];
+	u8	chain_b[BTINTEL_BPMO_NUM_MODULATIONS];
+} __packed;
+
 enum {
 	DSM_SET_WDISABLE2_DELAY = 1,
 	DSM_SET_RESET_METHOD = 3,
@@ -3739,7 +3747,64 @@ static int btintel_uefi_read_sar(struct hci_dev *hdev, efi_char16_t *name,
 	return 0;
 }
 
-static int btintel_set_uefi_sar(struct hci_dev *hdev)
+static int btintel_uefi_set_bpmo(struct hci_dev *hdev, u8 lock_status)
+{
+	u8 buffer[sizeof(struct btintel_cp_ddc_write) +
+		  BTINTEL_BPMO_NUM_MODULATIONS];
+	struct btintel_cp_ddc_write *cmd = (void *)buffer;
+	unsigned long size = sizeof(struct btintel_bpmo);
+	struct btintel_bpmo bpmo;
+	efi_status_t status;
+	int ret;
+
+	if (lock_status != BTINTEL_UEFI_LOCK_LOCKED &&
+	    lock_status != BTINTEL_UEFI_LOCK_TEST_MODE)
+		return -EOPNOTSUPP;
+
+	if (!IS_ENABLED(CONFIG_EFI) ||
+	    !efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return -EOPNOTSUPP;
+
+	status = efi.get_variable(BTINTEL_EFI_BPMO, &btintel_efi_sar_guid, NULL,
+				  &size, &bpmo);
+	if (status == EFI_NOT_FOUND)
+		return -ENOENT;
+	if (status != EFI_SUCCESS) {
+		bt_dev_dbg(hdev, "Failed to read UEFI BPMO variable: 0x%lx",
+			   status);
+		return -EOPNOTSUPP;
+	}
+
+	if (size != sizeof(bpmo) || bpmo.header != 0) {
+		bt_dev_dbg(hdev, "Unsupported UEFI BPMO variable");
+		return -EOPNOTSUPP;
+	}
+	if (!(le32_to_cpu(bpmo.mode) & BIT(0))) {
+		bt_dev_dbg(hdev, "UEFI BPMO is disabled");
+		return -EOPNOTSUPP;
+	}
+
+	cmd->len = 3;
+	cmd->id = cpu_to_le16(BTINTEL_DDC_ID_SAR_BPMO_ENABLE);
+	cmd->data[0] = 0x01;
+	ret = btintel_send_sar_ddc(hdev, cmd, sizeof(*cmd) + 1);
+	if (ret)
+		return ret;
+
+	cmd->len = 2 + BTINTEL_BPMO_NUM_MODULATIONS;
+	cmd->id = cpu_to_le16(BTINTEL_DDC_ID_SAR_BPMO_CHAIN_A);
+	memcpy(cmd->data, bpmo.chain_a, BTINTEL_BPMO_NUM_MODULATIONS);
+	ret = btintel_send_sar_ddc(hdev, cmd, sizeof(buffer));
+	if (ret)
+		return ret;
+
+	cmd->id = cpu_to_le16(BTINTEL_DDC_ID_SAR_BPMO_CHAIN_B);
+	memcpy(cmd->data, bpmo.chain_b, BTINTEL_BPMO_NUM_MODULATIONS);
+	return btintel_send_sar_ddc(hdev, cmd, sizeof(buffer));
+}
+
+static int btintel_set_uefi_sar(struct hci_dev *hdev,
+				struct intel_version_tlv *ver)
 {
 	/* 5G8 and 5G9 share a limit but have separate DDC identifiers. */
 	static const struct {
@@ -3826,6 +3891,12 @@ static int btintel_set_uefi_sar(struct hci_dev *hdev)
 		ret = 0;
 	}
 
+	if (INTEL_CNVX_TOP_TYPE(ver->cnvr_top) >= BTINTEL_CNVR_PEP) {
+		ret = btintel_uefi_set_bpmo(hdev, lock_status);
+		if (ret == -ENOENT || ret == -EOPNOTSUPP)
+			ret = 0;
+	}
+
 complete:
 	skb = __hci_cmd_sync(hdev, 0xfe25, sizeof(enable), &enable,
 			     HCI_CMD_TIMEOUT);
@@ -3853,7 +3924,7 @@ static int btintel_set_specific_absorption_rate(struct hci_dev *hdev,
 	/* Supported SCP2+ platforms use this UEFI DDC map regardless of CNVr. */
 	if (hw_variant >= BTINTEL_HWID_SCP2 &&
 	    hw_variant != BTINTEL_HWID_BZRIW)
-		btintel_set_uefi_sar(hdev);
+		btintel_set_uefi_sar(hdev, ver);
 
 	/*
 	 * Platforms with UEFI BSSS do not provide ACPI BRDS. If UEFI BRDS is
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 372c6d7d8cbe..766cd69503f6 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -71,6 +71,7 @@ struct intel_tlv {
 /* CNVR */
 #define BTINTEL_CNVR_FMP2		0x910
 #define BTINTEL_CNVR_WHP2		0xA10	/* Whale Peak2 - Panther Lake */
+#define BTINTEL_CNVR_PEP		0xA30   /* Pelican Peak2 / Pelican Peak STC */
 
 #define BTINTEL_IMG_BOOTLOADER		0x01	/* Bootloader image */
 #define BTINTEL_IMG_IML			0x02	/* Intermediate image */
@@ -87,6 +88,12 @@ struct intel_tlv {
 #define BTINTEL_HWID_SCP2F	0x21	/* Scorpius Peak2-F - Nova Lake */
 #define BTINTEL_HWID_BZRIW	0x22	/* BlazarIW - Wildcat Lake */
 
+#define BTINTEL_BPMO_NUM_MODULATIONS	16
+
+#define BTINTEL_DDC_ID_SAR_BPMO_ENABLE		0x0359
+#define BTINTEL_DDC_ID_SAR_BPMO_CHAIN_A		0x035A
+#define BTINTEL_DDC_ID_SAR_BPMO_CHAIN_B		0x035B
+
 extern const guid_t btintel_guid_dsm;
 
 struct intel_version_tlv {
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795497022;
	b=t7MqldIQey4Cgt6EnFsIYC9ws7DmegPSPMLO/dnlLS9F5s6cGRBkMZkUf2s40mUJ3P7f
	 BywATrSQzSmnrvANamsr4tIE84Lz4Ir1eCgAvkAXNLkqPeuugmm0HbUjGQTA7DGr07td9
	 3xIz2LhiZAAe2WmHL9M0GQkBklczI3dpab76JA9Eo8JvFDg8XHNOhol8qcjYmkg2w7bgw
	 2TdXfhoRDj22RUHOCJsw4RdiFecuppkdzliOXHInvvbA+2DoTydxQ44ocsy90kqB3t+1X
	 kGjWxerVdHP8aD4UTvVPZBC8/l+2U6Znk+cHy95w+sX9hQqTorx8047tjfpJmkxhU1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795497022;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BKk9hzdymikXatQykHCYCJVHI+KDP1w4p2aNdQC7+0E=;
	b=J2deebpZcMWSI1PjmPh6uSiw3R9P2scfLmjh2YvYDf1BO/1YJGnwf8xcljDhbMjRL2Rj
	 7AofBV8jqBOPrVAM54dmRlzgdjkpUVU3I+uCMPd5JEF0MxpnrgTJWf0x6Ie0i9mJeCne5
	 9JCnvT+Z9qPYdWDq8KzRdlrDPkjDFBsM6FWUxsScf59qETFwN8C+UT9DIZgB9Id80UYHV
	 6wm9uIlSdI/gSAqizJiFegh46iNoJN861sF4PsF++uXYn6/nfOmI7ExuaeiLeHIs4/rwL
	 1F2x7ttcxkD1Pm/6j8L58x76ibbC2HEqhiSco1dT1xTM0Bvu/YYiIL5zga7Grg0pI4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gMbziRuA;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40507606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40507606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gMbziRuA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795497020; x=1827033020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SoDc3UI9dUNlANyk8diNITrJ7SVIrG/wPpLwcpZfM5A=;
  b=gMbziRuA67cCXHBcp7OHatTlts4wIedC4feiChcf7oVBj4RF7z0z9cqM
   tdt4FU1/xymJRzgaXole+BVJ5GJRKtdS60fWz9Bk4Eo5wgimnJgi2OKf4
   ZnUYlWs/BMLb/Ki+FZjlwETE2JwOZdH6v0aS5z5IYcPMC2suz4kE7CyhL
   ziT8YlDGqFTOEhkc5fadnNWpblQrACF8XWVu9T1o+oryO9YZs4pA8uD1+
   V+2yoHMTnERl4wKbygaTUhzn8hGctgkPwPSDOi3Wg8GLNareIOdjpjhyK
   gK1DxppGvzzIGcnhaBxh5BCxVM3LWzRrHoH+SWC8zC9P7PBQKo0hBHrPQ
   w==;
X-CSE-ConnectionGUID: KGRkNRUiTiySg2gaTs9RLg==
X-CSE-MsgGUID: g4K3FrDkSM29y8byBPA6Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4213082"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4213082"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 21:10:20 -0800
X-CSE-ConnectionGUID: eH1SkbQkQwqJVAg7xqORSQ==
X-CSE-MsgGUID: qSL+h+8VRU6r1iIjR8k+Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11804477"
Received: from unknown (HELO WEBAPTLH152.iind.intel.com) ([10.66.226.239])
  by fmviesa006.fm.intel.com with ESMTP; 23 Nov 2026 21:10:18 -0800
From: Catherine L <catherine.l@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Catherine L <catherine.l@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Add UEFI BPMO support for PeP
Date: Tue, 24 Nov 2026 10:39:03 +0530
Message-ID: <20261124050903.248618-1-catherine.l@intel.com>
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

Signed-off-by: Catherine L <catherine.l@intel.com>
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
2.53.0


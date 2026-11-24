Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795499868;
	b=Wfy0xGvJuWCRABwdmjp/0ow09kNCLdgIaZEecHFdIa6T391VnjjUtVORvA3yNb0iwGVy
	 3vn2Z+bUN5c5kumGgCl5bJCbOohBXYG+GG3892QP7s4CgRv+SK4dcy5ZPNOSL/a+AwtLD
	 rD4PQLZsDQxQIS18EYzYle95wVnJx0x1GZeRh3gYZ7mGp46w6IG89Wirg7akOxgUeZUxy
	 +fgyX7nJ3UveIxeVGEcLRd3Fj6KKWlG9JyEo6xNwcRvcLvD44VCLmg/yvMm+ZSJ+bLesS
	 us93VvZXPaQhini9HFzhEKTriFMnabWsdDLvwKdksz2OKntJoU0sQjjWdYI2SoxJq3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795499868;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YK+OudAIft/FOt4qO0o3cz28TC62bidm40aBh9hU5DU=;
	b=0HD5lpGTqEG+a1lK5BXw0xUJKu9rgObXWFYDj5T1KTn3R5BCpTBjEyury9/FbyPZksTN
	 4sSSY2AoGFE2lj+eGHgCFg1dclDZKtJ6gm3qNHWHyn0H+4zZhvlfEY/sEsjn62AUKKIP4
	 s2nUTD3BguM2ys2V8nl2tbJJW0Yz4sjpzUuM9VeVngvRq7ddrJuMSXGtbj0XjXX5aOKCH
	 RGVWwhR6bOv6lLxrTkWQJ6qSxuP06k5TvmuVKbrSrS2rOm+BsWGoQtZW6PZDQsGYeLLBm
	 K9fyBkZnKI3QNm2MkwmVJaZehYKfnW62/SfwosOnm/HtZ9Ovh7WE/s6zsM5lL2FfwDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oHkEt1EW;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38D606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B38D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oHkEt1EW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795499867; x=1827035867;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xxG1TCxRdnfJrozI6friiGNZOXJpYq8rBZaq3ToVqus=;
  b=oHkEt1EWluFtl30GkNwU0OuAf/E8JfzafwWe5ABDL1aIO1kNmSpRy669
   KrlOy20muCbPHr3MVU1chl26snkIlKFe03rb0ao9Zkx+n8XFc+7Lu/ii2
   LZir2O+fqQS0btY9K527ZJQ2/KTyIDVo6deNO9EtIYkcdyX+dPfZt5Up6
   Pg0crWlmdvq60zYBIPn0n1Nitm/IWEHBp+r6CLl02FEbYa3Cmn+J69DZ5
   2TUQHF/5w/Zc6ADoIYyn/X9JLITiw474etM7LZTk5Su09PayPQ8fT1DA9
   1Wy+4YxH8hlXRmo88bz5XOixB+EWP2K1LzkTGP59mJe5daonx9bWNzM8m
   g==;
X-CSE-ConnectionGUID: gYuQR5QkQD+hd1rDwIDAPg==
X-CSE-MsgGUID: 7k9GxXgWTHq7HHjVMaz2DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4168225"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4168225"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 21:57:45 -0800
X-CSE-ConnectionGUID: rjCq74mMSeWE+kmDIztSCg==
X-CSE-MsgGUID: eC0NZDkrRO++pMCRcwZhBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11857331"
Received: from unknown (HELO WEBAPTLH152.iind.intel.com) ([10.66.226.239])
  by fmviesa009.fm.intel.com with ESMTP; 23 Nov 2026 21:57:43 -0800
From: Catherine L <catherine.l@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Catherine L <catherine.l@intel.com>
Subject: [PATCH v4] Bluetooth: btintel: Add UEFI BPMO support for PeP
Date: Tue, 24 Nov 2026 11:26:27 +0530
Message-ID: <20261124055627.250718-1-catherine.l@intel.com>
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
Changes in v4:
- addressed sashiko comments

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


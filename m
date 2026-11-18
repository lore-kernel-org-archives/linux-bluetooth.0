Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003458;
	b=L2Vn5/Yb/kvHC9XdSPvZzcsbl0/cBUwqhN1IuaKxDS9RfEKL8kjNlZNe5AZEDCLsL3Yr
	 h64w6TYT6x7osMSCMBESx6q/o71Y0l4QMZ9qtP3eHWofWB2THrF4I3jThjzkHu4B/IDnv
	 JCvKoITkqI8hGA8NB4Ys2ZjcUxzdhH+364SfOHmdsox8B/DpifSy62+KpHVuxL8HLfWia
	 kFW60i4q2vRmiL8MWf+dzclycFykMgxESeSYoE1oqa4ka9anx8mkjQKAAKFe5VjDnk379
	 oOwP5JjKZIyML709HNfa0ZyOCUn3JA9ZI08AcIH50RiuCaTQuew+gu4nkIJ58X0XU1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003458;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DEwCRguiZE3z63KGMStvhTtUY9y5olKkcyufxEvBuO0=;
	b=gSTM5VbxwrV86o+ekEYQN6470d6nILqM5yj+wt1z+lVc33NISZuzSGmplkYBy1lR2Jyl
	 ybVlXjJvunLoxTASWGBLE23gpVFHbFiis0MDgfox+UUBxYkHxavHcCE55QvYGbTU3/rwY
	 0pRExw6mpyMx4ScO5G7tx6LrB3VKrkNfqtANbsNTHZHISpjQudiMaSVyIQx5jXnqsJsWs
	 S3NezAFRm2Tl++svBrVWDSD/CxtToMJ2HqM8dvh1gk3YaacvDkGz/t2pSW/VJADYJbGW+
	 2Hh0MZbpaLBL6Rdsi1kE+PEEIzTiISWqj6IYPkWXwG0i/PfssxXrn5ppil+5avAlwCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jTMcmwO7;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2018C606A320
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 12:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2018C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jTMcmwO7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795003458; x=1826539458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mvQ1XR/xKtqx0E3V+jyRGZAQ4vKdmFHNBRmTTXpidV8=;
  b=jTMcmwO7XZhZIjxmRp0keyXF9smCRl4XFZjpv5CRg70oeptPvEG3PHXK
   eZkqgif6F80z6fdAjmIPQzUQg8V1IsT9gfuP2CRm3w/46Foz0OtsCsnCr
   zqiv+hYRCaJ82ncGC9K4+fiawHYiqZGhK6qIRmypewBYES/NsxGe95zSA
   PvrlxByB1oSb3qoNZtZEPcPWRaeYeF/jkvEDrc91VJVc0aqlONWuHGjiu
   FXgPXvzcGhyQgSl/tGHhe3EJF2apt0g36drFDNXesBYvhhl0vzdSTCqUX
   AYtMsXk2qb3m54P+a8SRDqjeRU8FCImknixxdfcGoAR6NPlPGvUzREKg1
   g==;
X-CSE-ConnectionGUID: d36GMcMeRoaP7wrp6At/pA==
X-CSE-MsgGUID: 9OjxN4SUQrmM8ZAis6srOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3835160"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3835160"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 04:04:17 -0800
X-CSE-ConnectionGUID: Bz/1/EtoTUiy6EJvs3b9YQ==
X-CSE-MsgGUID: GsikkHVNTmePNR3ZTESrNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10116605"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa004.fm.intel.com with ESMTP; 18 Nov 2026 04:04:16 -0800
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v3] Bluetooth: btintel: Add UEFI standalone static SAR support
Date: Wed, 18 Nov 2026 17:25:42 +0530
Message-ID: <20261118115542.3167414-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108093656.3857961-1-aluvala.sai.teja@intel.com>
References: <20261108093656.3857961-1-aluvala.sai.teja@intel.com>
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
provide Bluetooth standalone static SAR sub-band limits (BSSS) through
the UefiCnvBtBSSS UEFI variable. There is no corresponding ACPI BSSS
configuration. Applying these limits requires SAR to be enabled in
UefiCnvBtBRDS as well as in BSSS.

Read revision 2 UEFI BRDS and BSSS variables using their shared layout.
Program the BRDS 2.4 GHz limits, then enable standalone SAR and write
the BSSS per-chain sub-band limits. Send SAR initialization complete
after any UEFI DDC attempt, including failures, while preserving the
original error.

Reuse the existing SAR DDC helpers and configure UEFI SAR before the
existing ACPI BRDS path. Keep the ACPI platform and revision checks
unchanged and run ACPI handling independently of the UEFI result.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
Changes in v3:
- Check GLUI/ACPI GLAI lock status before applying UEFI SAR data, following
  the iwlwifi policy, with a write-protection probe on non-x86 when unknown.
- Add debug diagnostics for expected UEFI variable skips and retain warnings
  for unexpected read failures.
- Report setup and completion failures together while preserving the original
  setup error.
- Clarify BRDS/BSSS semantics, DDC 0x019e handling, and UEFI/ACPI BRDS
  precedence; remove the redundant BZRI exclusion and use kernel comment style.
- Expand BSSS in the commit description and clarify that it has no ACPI
  equivalent.

Changes in v2:
- Attempt SAR initialization complete after any UEFI DDC attempt, including
  error paths, while preserving the original error.
- Clarify BRDS/BSSS DDC semantics, initial mode independence, ACPI coexistence,
  and CNVr coverage with firmware-confirmed comments.

 drivers/bluetooth/btintel.c | 348 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 331 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a0aa110f4cddd91bcc73bb6f453aca95db995273..a20330c429510aa32cf3a9a5dbca6e080874992e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -29,6 +29,38 @@
 #define ECDSA_HEADER_LEN	320
 
 #define BTINTEL_EFI_DSBR	L"UefiCnvCommonDSBR"
+#define BTINTEL_EFI_BRDS	L"UefiCnvBtBRDS"
+#define BTINTEL_EFI_BSSS	L"UefiCnvBtBSSS"
+#define BTINTEL_EFI_GLUI	L"UefiCnvCommonGLUI"
+
+static efi_guid_t btintel_efi_sar_guid =
+	EFI_GUID(0x42780dd5, 0x9a7d, 0x404c,
+		 0x80, 0xe4, 0x7f, 0x70, 0x94, 0x36, 0x03, 0x94);
+
+static efi_guid_t btintel_efi_glui_guid =
+	EFI_GUID(0x6c5bed75, 0x0ee8, 0x4d45,
+		 0x98, 0x0b, 0x4d, 0x81, 0x31, 0xba, 0x84, 0xb5);
+
+enum btintel_uefi_lock_status {
+	BTINTEL_UEFI_LOCK_UNLOCKED,
+	BTINTEL_UEFI_LOCK_LOCKED,
+	BTINTEL_UEFI_LOCK_TEST_MODE,
+	BTINTEL_UEFI_LOCK_UNKNOWN,
+};
+
+struct btintel_uefi_glui {
+	u8 revision;
+	u8 guid_lock_status;
+} __packed;
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
@@ -3093,6 +3125,123 @@ static union acpi_object *btintel_acpi_get_bt_pkg(union acpi_object *buffer)
 	return ERR_PTR(-ENOENT);
 }
 
+static int btintel_acpi_get_sar_lock_status(struct hci_dev *hdev, u8 *lock_status)
+{
+	union acpi_object *buffer = NULL, *pkg;
+	acpi_status status;
+	int i, ret = -ENOENT;
+
+	status = btintel_evaluate_acpi_method(hdev, "GLAI", &buffer, 2);
+	if (ACPI_FAILURE(status))
+		return ret;
+
+	if (buffer->package.elements[0].type != ACPI_TYPE_INTEGER ||
+	    buffer->package.elements[0].integer.value != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	for (i = 1; i < buffer->package.count; i++) {
+		union acpi_object *domain;
+
+		pkg = &buffer->package.elements[i];
+		if (pkg->type != ACPI_TYPE_PACKAGE || pkg->package.count < 2)
+			continue;
+
+		domain = &pkg->package.elements[0];
+		if (domain->type != ACPI_TYPE_INTEGER ||
+		    domain->integer.value != BTINTEL_BT_DOMAIN)
+			continue;
+
+		pkg = &pkg->package.elements[1];
+		if (pkg->type != ACPI_TYPE_INTEGER ||
+		    pkg->integer.value > BTINTEL_UEFI_LOCK_TEST_MODE) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		*lock_status = pkg->integer.value;
+		ret = 0;
+		break;
+	}
+
+out:
+	kfree(buffer);
+	return ret;
+}
+
+#endif /* CONFIG_ACPI */
+
+static u8 btintel_uefi_get_sar_lock_status(struct hci_dev *hdev)
+{
+	struct btintel_uefi_glui glui;
+	unsigned long size = sizeof(glui);
+	efi_status_t status;
+	u8 lock_status = BTINTEL_UEFI_LOCK_UNKNOWN;
+
+	if (IS_ENABLED(CONFIG_EFI) &&
+	    efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
+		status = efi.get_variable(BTINTEL_EFI_GLUI,
+					  &btintel_efi_glui_guid, NULL,
+					  &size, &glui);
+		if (status == EFI_SUCCESS &&
+		    size == sizeof(glui) &&
+		    glui.revision == 0 &&
+		    glui.guid_lock_status <= BTINTEL_UEFI_LOCK_TEST_MODE)
+			lock_status = glui.guid_lock_status;
+	}
+
+	if (lock_status == BTINTEL_UEFI_LOCK_LOCKED ||
+	    lock_status == BTINTEL_UEFI_LOCK_TEST_MODE)
+		return lock_status;
+
+#ifdef CONFIG_ACPI
+	if (btintel_acpi_get_sar_lock_status(hdev, &lock_status))
+		bt_dev_dbg(hdev, "Unable to determine UEFI SAR table lock status");
+#endif
+
+	return lock_status;
+}
+
+static int btintel_uefi_check_sar_variable(struct hci_dev *hdev,
+					   efi_char16_t *name,
+					   struct btintel_uefi_sar *sar,
+					   u32 attributes, u8 lock_status)
+{
+	efi_status_t status;
+
+	if (lock_status == BTINTEL_UEFI_LOCK_LOCKED ||
+	    lock_status == BTINTEL_UEFI_LOCK_TEST_MODE)
+		return 0;
+
+	if (lock_status == BTINTEL_UEFI_LOCK_UNLOCKED) {
+		bt_dev_dbg(hdev, "UEFI SAR variable is not locked");
+		return -EOPNOTSUPP;
+	}
+
+	if (IS_ENABLED(CONFIG_X86) || IS_ENABLED(CONFIG_X86_64) ||
+	    IS_ENABLED(CONFIG_X86_32)) {
+		bt_dev_dbg(hdev, "UEFI SAR variable lock status is unknown");
+		return -EOPNOTSUPP;
+	}
+
+	if (!attributes || !IS_ENABLED(CONFIG_EFI) ||
+	    !efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
+		bt_dev_dbg(hdev, "Unable to verify UEFI SAR variable lock");
+		return -EOPNOTSUPP;
+	}
+
+	status = efi.set_variable(name, &btintel_efi_sar_guid, attributes,
+				  sizeof(*sar), sar);
+	if (status == EFI_WRITE_PROTECTED ||
+	    status == EFI_SECURITY_VIOLATION ||
+	    status == EFI_ACCESS_DENIED)
+		return 0;
+
+	bt_dev_dbg(hdev, "UEFI SAR variable is writable or its lock is unknown");
+	return -EOPNOTSUPP;
+}
+
 static int btintel_send_sar_ddc(struct hci_dev *hdev, struct btintel_cp_ddc_write *data, u8 len)
 {
 	struct sk_buff *skb;
@@ -3107,6 +3256,25 @@ static int btintel_send_sar_ddc(struct hci_dev *hdev, struct btintel_cp_ddc_writ
 	return 0;
 }
 
+/*
+ * btintel_send_sar_rev2_band - send DDC command for one Rev2 sub-band
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
@@ -3260,23 +3428,6 @@ static int btintel_set_mutual_sar(struct hci_dev *hdev, struct btintel_sar_inc_p
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
@@ -3544,9 +3695,172 @@ static int btintel_acpi_set_sar(struct hci_dev *hdev, struct intel_version_tlv *
 }
 #endif /* CONFIG_ACPI */
 
+static int btintel_uefi_read_sar(struct hci_dev *hdev, efi_char16_t *name,
+				 struct btintel_uefi_sar *sar, u32 *attributes)
+{
+	unsigned long size = sizeof(*sar);
+	efi_status_t status;
+
+	if (!IS_ENABLED(CONFIG_EFI) ||
+	    !efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
+		bt_dev_dbg(hdev, "UEFI runtime services unavailable for SAR");
+		return -EOPNOTSUPP;
+	}
+
+	status = efi.get_variable(name, &btintel_efi_sar_guid, attributes,
+				  &size, sar);
+	if (status == EFI_NOT_FOUND) {
+		bt_dev_dbg(hdev, "UEFI SAR variable not found");
+		return -ENOENT;
+	}
+	if (status == EFI_BUFFER_TOO_SMALL) {
+		bt_dev_dbg(hdev, "UEFI SAR variable has unsupported size");
+		return -EOPNOTSUPP;
+	}
+	if (status != EFI_SUCCESS) {
+		bt_dev_warn(hdev, "Failed to read UEFI SAR variable: 0x%lx",
+			    status);
+		return -EIO;
+	}
+
+	if (size != sizeof(*sar)) {
+		bt_dev_dbg(hdev, "Invalid UEFI SAR variable size: %lu", size);
+		return -EINVAL;
+	}
+	if (sar->revision != BTINTEL_SAR_REV2) {
+		bt_dev_dbg(hdev, "Unsupported UEFI SAR revision: %u",
+			   sar->revision);
+		return -EOPNOTSUPP;
+	}
+	if (!(le32_to_cpu(sar->mode) & BIT(0))) {
+		bt_dev_dbg(hdev, "UEFI SAR is disabled");
+		return -EOPNOTSUPP;
+	}
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
+	u32 attributes;
+	u8 lock_status;
+	u8 enable = 1;
+	int ret, i;
+
+	lock_status = btintel_uefi_get_sar_lock_status(hdev);
+	if (lock_status == BTINTEL_UEFI_LOCK_UNLOCKED ||
+	    ((IS_ENABLED(CONFIG_X86) || IS_ENABLED(CONFIG_X86_64) ||
+	      IS_ENABLED(CONFIG_X86_32)) &&
+	     lock_status == BTINTEL_UEFI_LOCK_UNKNOWN)) {
+		bt_dev_dbg(hdev, "UEFI SAR tables are not trusted");
+		return -EOPNOTSUPP;
+	}
+
+	ret = btintel_uefi_read_sar(hdev, BTINTEL_EFI_BRDS, &sar,
+				    &attributes);
+	if (ret)
+		return ret;
+
+	ret = btintel_uefi_check_sar_variable(hdev, BTINTEL_EFI_BRDS, &sar,
+					      attributes, lock_status);
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
+	ret = btintel_uefi_read_sar(hdev, BTINTEL_EFI_BSSS, &sar,
+				    &attributes);
+	if (!ret) {
+		ret = btintel_uefi_check_sar_variable(hdev, BTINTEL_EFI_BSSS,
+						      &sar, attributes,
+						      lock_status);
+		if (ret)
+			goto complete;
+
+		cmd->len = 3;
+		/* UEFI BSSS requires 0x019e = 1; inc_power_mode is not used here. */
+		cmd->id = cpu_to_le16(0x019e);
+		cmd->data[0] = enable;
+		ret = btintel_send_sar_ddc(hdev, cmd, sizeof(*cmd) + 1);
+		if (ret)
+			goto complete;
+
+		/*
+		 * After writing 0x019e = 1, firmware interprets DDC 0x0311-0x0316
+		 * as BSSS limits.
+		 */
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
+		if (ret)
+			bt_dev_warn(hdev,
+				    "UEFI SAR setup failed (%d), completion failed (%ld)",
+				    ret, PTR_ERR(skb));
+		else
+			bt_dev_warn(hdev, "Failed to complete UEFI SAR setup (%ld)",
+				    PTR_ERR(skb));
+
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
+
+	/* Supported SCP2+ platforms use this UEFI DDC map regardless of CNVr. */
+	if (hw_variant >= BTINTEL_HWID_SCP2 &&
+	    hw_variant != BTINTEL_HWID_BZRIW)
+		btintel_set_uefi_sar(hdev);
+
+	/*
+	 * Platforms with UEFI BSSS do not provide ACPI BRDS. If UEFI BRDS is
+	 * available without BSSS, let the existing ACPI BRDS path run after
+	 * this path so its later write retains the existing precedence.
+	 */
 #ifdef CONFIG_ACPI
 	return btintel_acpi_set_sar(hdev, ver);
 #endif
-- 
2.53.0

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECB43304D
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978512; cv=none; b=cCMXx6OQzBXuD/bxfCmv5jmVH4BgOVwDVUbeVAkH4WA+hDDX0ESTQn+QHvGgeQumVG/lBsHnRYe3vFSe07eLIpxrY+jLnyzc+hwePhdy9NIbtppWCLrHytyS17xETmMu2gaEMT/sHJnZTyMhViWTXxn5KTg1ONFhrP7MI2yoFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978512; c=relaxed/simple;
	bh=F6SfDQ2clZ1oVatBfLRZXUktNzf8J1y/s/PbKRbJbbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUl8JeQebOXHtkoZk28gkHLo5qU5feOwOGPeZvAljLqaowSAAuFW1L2F4zB8c6DEv3XACLx7OxR+fIrfGwwPaGoFgChunt2q42QgN6t8fP1Xotfj9+TV6Fo5RAso5VTNzSxNOt7+ZjBW1/ivIM6DE0xjQ+xu7rO7mYjpWeskXNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1WpKXwb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1WpKXwb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791978503; x=1823514503;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F6SfDQ2clZ1oVatBfLRZXUktNzf8J1y/s/PbKRbJbbQ=;
  b=E1WpKXwbUX0ZAuWZfkwyaeFG+XZuPl1mL4umhgzQH30QGdcm0nZMBHTX
   wTqtpCti28z1dSyHEhlfTd2f2HpHwoDsJJAh1HSar28RZeGKnbFk/FIr2
   kAkKO7NbSYXsm6fwXmVdF32eIvqEEn1yfimFtdpi7HQElrSjhUpj5e79J
   frianZ1chDvwrvwEtemyf16AZmscnjc2XCcbAfRaV7Z1G9/xBeOrVFgGA
   UbyntHaEOKkdSS6cbtPFuDzUsadk8rWdWlzGUMVbmWH69QctObbHWOjBM
   bPFvuW6w/OTVf//sykjXtgRhkTuINr64XcMeyGgCSVdWtKF3cX4wEk4d9
   Q==;
X-CSE-ConnectionGUID: HLQ+VHjtSMCc3umLDlmL8g==
X-CSE-MsgGUID: aBFD0mlGRS6z0lQBnEofew==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="627111"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="627111"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 04:48:22 -0700
X-CSE-ConnectionGUID: BgXZvhtKS7GFAM23Ec7LEw==
X-CSE-MsgGUID: 0vrF0jo3T460vX67QL5dQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1873472"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa010.fm.intel.com with ESMTP; 14 Oct 2026 04:48:21 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH 1/2] Bluetooth: btintel: Add TOP silent reset hooks
Date: Wed, 14 Oct 2026 17:17:50 +0530
Message-ID: <20261014114752.174669-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an INTEL_TOP_RESET flag so btintel_boot() can abort with
-ECANCELED and let the caller substitute its own reset sequence,
and cache boot_addr in struct btintel_data so that sequence can
replay btintel_send_intel_reset() without re-parsing firmware.
Preserve the flag across the reset in btintel_bootloader_setup_tlv().

Inert on its own; used by the follow-up btintel_pcie patch.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel.c | 68 +++++++++++++++++++++++++++++++++----
 drivers/bluetooth/btintel.h |  2 ++
 2 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0709fb3212f9..f48cda37ffa0 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1238,6 +1238,17 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
 {
 	const u8 *fw_ptr;
 
+	/* Invalidate any previously cached boot_addr up front so that if
+	 * this firmware image lacks CMD_WRITE_BOOT_PARAMS below, the TOP
+	 * silent reset replay path in btintel_pcie does not reuse a stale
+	 * address from an earlier firmware load.
+	 */
+	if (hdev->bus == HCI_PCI) {
+		struct btintel_data *data = hci_get_priv(hdev);
+
+		data->boot_addr = 0;
+	}
+
 	fw_ptr = fw->data;
 
 	while (fw_ptr - fw->data < fw->size) {
@@ -1255,6 +1266,18 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
 
 			*boot_addr = le32_to_cpu(params->boot_addr);
 
+			/* boot_addr is cached only for the PCIe TOP silent
+			 * reset replay path. UART (hci_intel) devices have no
+			 * struct btintel_data allocated as hci_dev private
+			 * data, so hci_get_priv(hdev) would return memory past
+			 * the end of hdev; skip the cache write there.
+			 */
+			if (hdev->bus == HCI_PCI) {
+				struct btintel_data *data = hci_get_priv(hdev);
+
+				data->boot_addr = *boot_addr;
+			}
+
 			bt_dev_info(hdev, "Boot Address: 0x%x", *boot_addr);
 
 			bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
@@ -2059,11 +2082,30 @@ static int btintel_boot_wait_d0(struct hci_dev *hdev, ktime_t calltime,
 	return 0;
 }
 
+/* Returns true when a TOP silent reset is pending on this hdev and the
+ * caller must cancel whatever FW-download/boot step it was about to run
+ * instead of proceeding, so the reset dispatch in btintel_pcie_setup()
+ * is not bypassed.
+ */
+static bool btintel_top_reset_pending(struct hci_dev *hdev)
+{
+	if (hdev->bus == HCI_PCI && btintel_test_flag(hdev, INTEL_TOP_RESET)) {
+		bt_dev_info(hdev, "INTEL_TOP_RESET flag set, cancel boot");
+		return true;
+	}
+
+	return false;
+}
+
 static int btintel_boot(struct hci_dev *hdev, u32 boot_addr)
 {
 	ktime_t calltime;
 	int err;
 
+	/* TOP reset flag set, abort FW download before sending Intel soft reset */
+	if (btintel_top_reset_pending(hdev))
+		return -ECANCELED;
+
 	calltime = ktime_get();
 
 	btintel_set_flag(hdev, INTEL_BOOTING);
@@ -3543,12 +3585,13 @@ static int btintel_try_load_unlocker(struct hci_dev *hdev,
 int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 				 struct intel_version_tlv *ver)
 {
-	u32 boot_param;
-	char ddcname[64];
-	int err;
-	struct intel_version_tlv new_ver;
 	struct btintel_data *data = hci_get_priv(hdev);
 	u8 hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
+	struct intel_version_tlv new_ver;
+	bool backup = false;
+	char ddcname[64];
+	u32 boot_param;
+	int err, i;
 
 	bt_dev_dbg(hdev, "");
 
@@ -3562,9 +3605,15 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	 * same hdev instance if there is any error on firmware download.
 	 * Need to clear stale bits of previous firmware download attempt.
 	 */
-	for (int i = 0; i < __INTEL_NUM_FLAGS; i++)
+	if (btintel_test_flag(hdev, INTEL_TOP_RESET))
+		backup = true;
+
+	for (i = 0; i < __INTEL_NUM_FLAGS; i++)
 		btintel_clear_flag(hdev, i);
 
+	if (backup)
+		btintel_set_flag(hdev, INTEL_TOP_RESET);
+
 	btintel_set_flag(hdev, INTEL_BOOTLOADER);
 
 	data->unlocker = false;
@@ -3597,8 +3646,15 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 		return err;
 
 	/* check if controller is already having an operational firmware */
-	if (ver->img_type == BTINTEL_IMG_OP)
+	if (ver->img_type == BTINTEL_IMG_OP) {
+		/* A pending TOP reset must still be dispatched by the
+		 * caller even though there is no bootloader stage to run
+		 * through btintel_boot() in this case.
+		 */
+		if (btintel_top_reset_pending(hdev))
+			return -ECANCELED;
 		goto finish;
+	}
 
 	err = btintel_boot(hdev, boot_param);
 	if (err)
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 9526acf65959..97fbe0ddf2d3 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -257,6 +257,7 @@ enum {
 	INTEL_ROM_LEGACY_NO_WBS_SUPPORT,
 	INTEL_ACPI_RESET_ACTIVE,
 	INTEL_WAIT_FOR_D0,
+	INTEL_TOP_RESET,
 
 	__INTEL_NUM_FLAGS,
 };
@@ -265,6 +266,7 @@ struct btintel_data {
 	DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
 	int (*acpi_reset_method)(struct hci_dev *hdev);
 	u32 cnvi_bt;
+	u32 boot_addr;
 	bool	unlocker;
 };
 
-- 
2.43.0


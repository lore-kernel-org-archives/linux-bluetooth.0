Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114414;
	b=hS8efLjJTmb2Fojbh09C0B99nMQt/aOT0SRO6kb7toKwDdJkORqkh7qs5FFM2b0yiwJ7
	 y01pCmIGL83v3CbdLS0RW0IO4+0CmwQc0wuTnVlHIka1z+nl2s8KzVf29xGMGlUgIbj3K
	 A6CA0eh3yyU8/et9RwDAhJq5Dct5JMb5DISrw67GIEbSxbkpHxwZ0FdVcANAEYHW/sjPP
	 JsfDSe9hpFqhiT65zLYdxEX76iCZHPDMHKCJZNTvyjMy53WW/q5EM7VslNNPjswrHgNSn
	 PU67jEngjGhoijnqPLv3GQxeZv4deiJuPsXa4HL3KvrV99EjRDkdmI4zMFrm/uXtvrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114414;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QuQo6uzjkbQQahNIXdsu/2FrZB4rL+Fv8PmMYnbTxh8=;
	b=dD1cMewkag0mPnSd0WFojCumrtklyX6s5ScCFZiZKGIgnDDHtenXe2H9YnkwjEyn56DA
	 jGzaC3SAxVRFSKmclHzXyHies9cz4nwC+nfPY3ND6iUeQLlr1BZTtOowhyo4tMBbayX9G
	 wcQP7iHhA9SmY0t5KByNy5+qCkL3fXW+IZwzZLa4qa3FRJPmsHG5hrprc8vVVpvpYQaQa
	 Lki5klqHHPCEjA+rk7TFJKHoj6y+iYA/578bCiUpqAe3IwDFN03MSIchZ1yu1YTCwPY0A
	 MAqHNRSJirzE2Q4ugGfczO0ofcF14ZllXZ7UvE/Y+3nDw34MKjwp1Ap2kLljx/7U0Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kHf+FmeY;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A449160A2602
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 15:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A449160A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kHf+FmeY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793114413; x=1824650413;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mptgmy1UE8LNyC0mK0XYOJHPh5Y7S/UZBn7MuZImbPc=;
  b=kHf+FmeY8ozhhYccTyN8FpDuTfdC2DwKtNLRRTcSevGHqewpxQ3EMUBO
   tnpTqTbfa4hosj7QqoPmKOB11WIxIBgQiAUpMJb16buXiFIOcyP57G7Gw
   boY5ovXfulkqWm4H5aYpkixvBVzclWRyYWzq6sewNdp4HY1FxXK+x4apn
   UsdX16vaZxWel0dqXaM0pZ6hkjOPWhOi748ShVub3prdABRbf+Ps3wN3s
   Pp8da4i6a8GStalfBSGHnUOUhrgvEyI5+d0NEwP4J2daG+SNa2AjRpgB4
   ldh8LSkaUQeoOGYIWPXAmJQ0lFsipQi01brRwityhYr8EdaKj8+8vrTtJ
   A==;
X-CSE-ConnectionGUID: I+QSDXjOQWuLh0hxPtTCIg==
X-CSE-MsgGUID: Jl7sm3WwSWyEJD9LnW057g==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1907157"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1907157"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:20:06 -0700
X-CSE-ConnectionGUID: yohiXN8sR2aY0Doix1CV0Q==
X-CSE-MsgGUID: buTF7oKDTYC1fFDhPv+Ffg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6324614"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa012.fm.intel.com with ESMTP; 27 Oct 2026 08:20:04 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v4 1/2] Bluetooth: btintel: Add TOP silent reset hooks
Date: Tue, 27 Oct 2026 20:49:29 +0530
Message-ID: <20261027151930.386971-1-chandrashekar.devegowda@intel.com>
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

Add an INTEL_TOP_RESET flag so btintel_boot() returns -ECANCELED and
the transport can run its own TOP silent reset instead of the Intel
soft reset. Cache boot_addr in struct btintel_data for the replay.

No functional change on its own.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
Changes in v4:
- Reject a TOP reset on an operational image for all variants.

Changes in v3:
- Fail TOP reset setup on an operational image, falling back to PLDR.

Changes in v2:
- Check INTEL_TOP_RESET directly in btintel_boot(); clear the cached
  boot_addr on version read.

v3: https://lore.kernel.org/linux-bluetooth/20261027054408.318002-1-chandrashekar.devegowda@intel.com/
v2: https://lore.kernel.org/linux-bluetooth/20261023094033.212251-1-chandrashekar.devegowda@intel.com/
v1: https://lore.kernel.org/linux-bluetooth/20261014114752.174669-1-chandrashekar.devegowda@intel.com/

 drivers/bluetooth/btintel.c | 28 ++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 929018428c19..f1d228d89c8e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1260,6 +1260,12 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
 {
 	const u8 *fw_ptr;
 
+	if (hdev->bus == HCI_PCI) {
+		struct btintel_data *data = hci_get_priv(hdev);
+
+		data->boot_addr = 0;
+	}
+
 	fw_ptr = fw->data;
 
 	while (fw_ptr - fw->data < fw->size) {
@@ -1277,6 +1283,12 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
 
 			*boot_addr = le32_to_cpu(params->boot_addr);
 
+			if (hdev->bus == HCI_PCI) {
+				struct btintel_data *data = hci_get_priv(hdev);
+
+				data->boot_addr = *boot_addr;
+			}
+
 			bt_dev_info(hdev, "Boot Address: 0x%x", *boot_addr);
 
 			bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
@@ -2086,6 +2098,13 @@ static int btintel_boot(struct hci_dev *hdev, u32 boot_addr)
 	ktime_t calltime;
 	int err;
 
+	/* Let the transport replace the Intel soft reset for a TOP reset */
+	if (hdev->bus == HCI_PCI &&
+	    btintel_test_flag(hdev, INTEL_TOP_RESET)) {
+		bt_dev_info(hdev, "TOP reset pending, skipping Intel soft reset");
+		return -ECANCELED;
+	}
+
 	calltime = ktime_get();
 
 	btintel_set_flag(hdev, INTEL_BOOTING);
@@ -3571,6 +3590,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	struct intel_version_tlv new_ver;
 	struct btintel_data *data = hci_get_priv(hdev);
 	u8 hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
+	bool top_reset = btintel_test_flag(hdev, INTEL_TOP_RESET);
 
 	bt_dev_dbg(hdev, "");
 
@@ -3587,10 +3607,18 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	for (int i = 0; i < __INTEL_NUM_FLAGS; i++)
 		btintel_clear_flag(hdev, i);
 
+	if (top_reset)
+		btintel_set_flag(hdev, INTEL_TOP_RESET);
+
 	btintel_set_flag(hdev, INTEL_BOOTLOADER);
 
 	data->unlocker = false;
 
+	if (top_reset && ver->img_type == BTINTEL_IMG_OP) {
+		bt_dev_err(hdev, "TOP reset requested on operational image");
+		return -EALREADY;
+	}
+
 	/* Legacy unlocker flow (BlazarI / BlazarIW / BlazarU / Gale Peak):
 	 * Boot ROM -> unlocker.sfi -> IML -> OPFW
 	 *
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


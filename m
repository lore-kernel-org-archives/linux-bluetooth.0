Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748471;
	b=PxkvvGqBwlHeUAfvyu5/ERY09Qg2nMcakLXpgtyxLjQstb7LUalrtvSltdVbB8e20Hh9
	 uikw668neoRbAS69cJYqiHKGBgMyDfgdRLIXwZQTPLTjza7lwhsDj5CHDVSmg8HH+5d2y
	 cDZ9t4UCvleUzx3f79b7QcaoQaco+l8x7ksYGAo6MDw5r2NpL7yX2tpwyETX/QhpRnxhJ
	 jOPj+cesN3P5t29/s5cOJsgYHpSadmXtf4iWUu17STdelJsmSfmatIRwILlAMLNz3CEbO
	 Y9Hky6Ldq7oMjugCQ83zumT7hbGmhHUsId8RKUEXy0ouF+QAc6vDovJslIVZzsENpSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748471;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1ukAlNoeExiDdRRq/0TK+O1V3ytnsNriPovAgZgsNUg=;
	b=U3ARJmBmO95s7xwJqivqjVtxpDsPkyQ5x5aHzrytKvX+ubRlQPovaFy0bH9R1VYeaWGw
	 Db8R4ptTiADRM2+JtmiQ8z55YoD+7DNZdySaKOt//aVyhzSgjZSPotCwqvHqRzFoVVLOx
	 Bm0bG5oDztaPCrTo2ZZKL8Mun3tZ2dcTr0zJ7YKikSPaxjeSQjx28LvXIvEOdxc+vUAlK
	 B6Ofk64D3+v14+y6dsCXON/oCoxH0cxGeQerrr9bFV3YF6qbpn5IGDFrDMrKcbiq5IBT7
	 upFCf4ja1qR69uEQAfCf9BXtypKZXyZRPv8ky7s2dwTrCBmiTfayucvcPsqap2pzr2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CLUSymoJ;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C7E606A31B
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 09:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C7E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CLUSymoJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792748471; x=1824284471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BNf3Vv0mNQJtJRXhT7ApWixgb3r47h3EZlFhGPtTs4E=;
  b=CLUSymoJIN86uDatiFe10S/Maui9YSyWq2SJpLsl/YzEBlG5I+4MHGVD
   G8wTPhIwmkeBFekadclIb6x52ECKn2wHknYTreixp3OYwtnoFtQNwhj0U
   celbW6fS7wwBUMzq4ZTKHi4PlAx3Gd8xW25mFRUE6vILKSeFUGe/kg4Dq
   lkMPUOSoHi7WlWAysUvVlJWiyC7YSf1DmPA3lnWj3N5eGex3PmNADePQe
   CZOKmTRhqxQSjE+YmbSr4Sn5BeffyMp7h9h0Zn0bulhm2wUkGFvFxWoYo
   oIkb+RZX3cEdSyTC0OGGHzRi3XxFaWePbNmIObfozJRdXfrc2RIMs0DSZ
   g==;
X-CSE-ConnectionGUID: m/dUWvYMTi2aGeZ3FW/qWQ==
X-CSE-MsgGUID: kdJEERrpTb6/YhShdK8bzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1396977"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1396977"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:41:10 -0700
X-CSE-ConnectionGUID: F/6wKPZpRZ20iNJ4u/hRSA==
X-CSE-MsgGUID: SgzncWNTQFCSehgeAvMF5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3550458"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa002.jf.intel.com with ESMTP; 23 Oct 2026 02:41:08 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v2 1/2] Bluetooth: btintel: Add TOP silent reset hooks
Date: Fri, 23 Oct 2026 15:10:32 +0530
Message-ID: <20261023094033.212251-1-chandrashekar.devegowda@intel.com>
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
Changes in v2:
- Drop btintel_top_reset_pending() and the operational image special
  case; check INTEL_TOP_RESET directly in btintel_boot().
- Clear the cached boot_addr when reading the firmware version.

v1: https://lore.kernel.org/linux-bluetooth/20261014114752.174669-1-chandrashekar.devegowda@intel.com/

 drivers/bluetooth/btintel.c | 23 +++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0709fb3212f9..999b292bb69e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1238,6 +1238,12 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
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
@@ -1255,6 +1261,12 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
 
 			*boot_addr = le32_to_cpu(params->boot_addr);
 
+			if (hdev->bus == HCI_PCI) {
+				struct btintel_data *data = hci_get_priv(hdev);
+
+				data->boot_addr = *boot_addr;
+			}
+
 			bt_dev_info(hdev, "Boot Address: 0x%x", *boot_addr);
 
 			bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
@@ -2064,6 +2076,13 @@ static int btintel_boot(struct hci_dev *hdev, u32 boot_addr)
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
@@ -3549,6 +3568,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	struct intel_version_tlv new_ver;
 	struct btintel_data *data = hci_get_priv(hdev);
 	u8 hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
+	bool top_reset = btintel_test_flag(hdev, INTEL_TOP_RESET);
 
 	bt_dev_dbg(hdev, "");
 
@@ -3565,6 +3585,9 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	for (int i = 0; i < __INTEL_NUM_FLAGS; i++)
 		btintel_clear_flag(hdev, i);
 
+	if (top_reset)
+		btintel_set_flag(hdev, INTEL_TOP_RESET);
+
 	btintel_set_flag(hdev, INTEL_BOOTLOADER);
 
 	data->unlocker = false;
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
 

base-commit: 27731ba091954eccddb2657053b590d2113e8d98
-- 
2.43.0


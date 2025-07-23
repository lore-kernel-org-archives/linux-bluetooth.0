Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047B51448E3
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251013; cv=none; b=ePJSrNK4sQ7ofgvHBT6DSsKo3tuOObHRgWt1a3YXs4XADqPABUKptRAEeXX9T//dtKNj0vSbYKVwm/VnV2I32qJRsIRkCd6YnAahtTf/Mm7Sok1zTFoaOiPFsmwk1s6uMlXGX5m4tWaC5aaqkrskfX59WwG+2Ee+ec/elbFx53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251013; c=relaxed/simple;
	bh=YTHRq1c6h+7TXDLmqX+vOWJggLJPuBrjbZ7+c4/qSwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MrE8eBxGdYypnfAfw8EQJdSkBqjhcYbp/BfMm+EiNDvVLwTPqH/QrQzQJyNwT33o9xS08mkzTZ36Wvj1D6RpYrWg+XIkr0BE6uVqneKxT444N91fMXaJuMD2KoQagPNqXQ2yS9Wf7S2c04ky+L6q8+2ujK05rA2ggYO+cEmNmxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCSQARwD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCSQARwD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753251012; x=1784787012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YTHRq1c6h+7TXDLmqX+vOWJggLJPuBrjbZ7+c4/qSwI=;
  b=TCSQARwDnfZ0osCDdrPiqfpsp54cajePs1TwYf2F8sWUSGJ+IWEwaiiu
   Pa4+8fyCe3PJnAwXYlR9Yr5zyQMSbJCB6lGV3Bour/A8RDRACxdnKkcDa
   LzhBnQpK8dkMkXEkTAK+F0ICVi2OSCh2aT+LSpMEHWiwqtTd+VIgxRCva
   p/+m33k0KMULhf92Is0ex9IV/10ipaor3Mw+KqdisKwQXkRz0tBsut5YS
   eHr+1fxv9Me/ir7NaaFUG/zeM4aK5E4eQHTb+6x8oToA9hmIP+V0f4Vyd
   QETVdwXZZq0pGukvo/s+sHq6L+HY+PJpbPCbFsTKq0fE9DeV7T5pZoloS
   w==;
X-CSE-ConnectionGUID: SfSD/PFFSFa8eYMO5TEOQw==
X-CSE-MsgGUID: M4SZaudLQTaPWtuGCBH/4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55629322"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55629322"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:10:10 -0700
X-CSE-ConnectionGUID: 8B/cbhSSS32o1Wr9dy3kKw==
X-CSE-MsgGUID: i20t0xglSyyBWImjH6Fx4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159644754"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa009.fm.intel.com with ESMTP; 22 Jul 2025 23:10:09 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	Kiran K <kiran.k@intel.com>,
	Vijay Satija <vijay.satija@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW core
Date: Wed, 23 Jul 2025 11:56:44 +0530
Message-ID: <20250723062644.1296860-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Need to add support for BlazarIW Bluetooth core used in Wildcat Lake
platform.

Signed-off-by: Vijay Satija <vijay.satija@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 3 +++
 drivers/bluetooth/btintel_pcie.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index be69d21c9aa7..ea1521c6b2d3 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -484,6 +484,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x1d:	/* BlazarU (BzrU) */
 	case 0x1e:	/* BlazarI (Bzr) */
 	case 0x1f:      /* Scorpious Peak */
+	case 0x22:	/* BlazarIW (BzrIW */
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
@@ -3253,6 +3254,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	case 0x1d:
 	case 0x1e:
 	case 0x1f:
+	case 0x22:
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
 	default:
@@ -3593,6 +3595,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x1d:
 	case 0x1e:
 	case 0x1f:
+	case 0x22:
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 6e7bbbd35279..d08f59ae7720 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2149,6 +2149,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
 	case 0x1e:	/* BzrI */
 	case 0x1f:	/* ScP  */
+	case 0x22:	/* BzrIW */
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
-- 
2.43.0


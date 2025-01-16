Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D390C24A7C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737026494; cv=none; b=pTtonxCSmkhzLrtT5wkToIiE1/C8NIsep6amB8jZP3f9smUcuVni2IfNs+i7uR3DFdXSXvGlBQBUWvNSRtMdUpddpsHblO6GUSHYa/QOOyH6c0DGf5EnEZm/4KE+s8TedAi0inXqbapqvnqMkfXBcfYiBPJI6btcSthVaAeNXR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737026494; c=relaxed/simple;
	bh=aFzPrSfiRHUeG8LNMKtkk5cdEq1TFnGtAUhEN/2gsmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMR24O3zVqkS5A+kKrXkvv82tzFgLbUBWRzwqw9NGilXYq8Jh12/y9OZhc9s83xC03131WlYpmiAKmJehvjCvKw22rtWUKkGnFpf53k9e745N2FZ6UHGkeTTrl0ZmnLVfr26J7oHziCTzjMy0TScmnCJSBPwojLH7i2ZmcWs6ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcbxuRFx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcbxuRFx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737026493; x=1768562493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aFzPrSfiRHUeG8LNMKtkk5cdEq1TFnGtAUhEN/2gsmo=;
  b=jcbxuRFxHX1apb+d4wLc4ZQHMTFvqSX9ET3l4GipexKzVmcf7uripHnN
   IqESDOx1EHRltHYAzw/3qLpyZta0iIagIPCEfR0bJ57LriHW9aPa6/bAE
   76j5i0+q+JW0AZX4brC4AqNdPjs4xWPOqC3PpvQ68S0DRukBVUhMN1WIA
   Q3027o5b/5SFpoDpkrHIVunlShREIfUPu/Lo9sc6xDOhYmBDA0eAGOxxi
   MdL4gY4jPvC7PmEmuwfBwlcG1laPNoFZzAU0j99AsM2jWQrC2FbDl+2Hv
   kBE+k/2fBhME/rQSoBD8s7ssNfivzg8RWSC37W9qJ050ew7BbGl8wFjKT
   g==;
X-CSE-ConnectionGUID: 7zUkJEHhR86fU4wEUb+Acw==
X-CSE-MsgGUID: tQSxWHNhT1C2cqK/TwVD0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="47995640"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="47995640"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 03:21:32 -0800
X-CSE-ConnectionGUID: +H9xxnp5TA2YxhemctoqNQ==
X-CSE-MsgGUID: 8I26AYPPTSWUATZoNG3Ejg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110439756"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa003.jf.intel.com with ESMTP; 16 Jan 2025 03:21:30 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel: Add support for Intel Scorpius Peak
Date: Thu, 16 Jan 2025 17:07:08 +0530
Message-ID: <20250116113709.566498-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Scorpious Peak core.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 3 +++
 drivers/bluetooth/btintel_pcie.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d2540b28bc7a..03bf96e2544f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -478,6 +478,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x1c:	/* Gale Peak (GaP) */
 	case 0x1d:	/* BlazarU (BzrU) */
 	case 0x1e:	/* BlazarI (Bzr) */
+	case 0x1f:      /* Scorpious Peak */
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
@@ -2919,6 +2920,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	case 0x1c:
 	case 0x1d:
 	case 0x1e:
+	case 0x1f:
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
 	default:
@@ -3258,6 +3260,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x1b:
 	case 0x1d:
 	case 0x1e:
+	case 0x1f:
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2b79952f3628..3250fe6c9f4c 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1446,6 +1446,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	 */
 	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
 	case 0x1e:	/* BzrI */
+	case 0x1f:	/* ScP  */
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
-- 
2.43.0


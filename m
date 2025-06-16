Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5304F20A5F5
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090209; cv=none; b=UMUerKzD62lBx4IlkKgiGNfrJYBwY43hEpfE6KIXcfWGJKbi/JH0TFwptJIZU1wWSqvYs1Hu9+itP5wmFXC5GqiWJbpigfxRXPi0o6ZaKNMCetxLsj4XhdAtYAjX2D3hidwzbxzXJTkpSMCpPCfh9OuQruKwX9xDxPSJJGIseRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090209; c=relaxed/simple;
	bh=hswVXmNwhewoatjWwJXlAU8riYAwp7If7m8rcM4IbjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URtW0QZ5y0YGhEAufrwRDJoVNf5vJNsqpFXocW1t3KXMz+xn+nEsuMIPQZmUbAXYvW1T6tNR4czpmiygKdHdYUXInvVacIsWvW49yeU/UZr9AAc7VDENxSAZN92XEHT1mzjb0jiipHYioVF2r3GQkJ1VWp971kbKRT5foUqPTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANTx+By2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANTx+By2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750090207; x=1781626207;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hswVXmNwhewoatjWwJXlAU8riYAwp7If7m8rcM4IbjY=;
  b=ANTx+By23dYdrBiCXtC7l1LgvKIg026fQquI5LbRXU7p+FdjY49kYwBc
   mCDRh8iHt4WG5RHd5y0CXpS/C4N5URpQ3Gmw9NgWBEj9KJDERq+74V1YM
   Ik/c+azzmMSzpUbsz3v923ipxSlpPCO+KfnQnb+t+7rWNEXwCbcLC9RiZ
   ERqek/8VHXfM6gFFMS5t27IJHnvUIMz8izeUe9U+E4q+WN5fchp6kO6DN
   qi5D7LuFr8YbhNLdNJEHkkDueuuheQ0vwsuBh2H7D2jeUm9yiSaI5+Tae
   bxqc9xYypmXhGNF1usXwxWo8gA95I1alM7TYSCbWf+EoT4gQ0MCB1Kfst
   A==;
X-CSE-ConnectionGUID: d1xMTIL2SGefrIcatMQG9Q==
X-CSE-MsgGUID: aMmLpyVZTpqs4+p4xHMJwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="51352195"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="51352195"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 09:10:06 -0700
X-CSE-ConnectionGUID: Eq8oLQ5TT4OFx2Z4yVidqQ==
X-CSE-MsgGUID: s8UsTfrrQzq4ak/jSiJasQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="179505320"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa001.fm.intel.com with ESMTP; 16 Jun 2025 09:10:04 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW
Date: Mon, 16 Jun 2025 21:56:33 +0530
Message-ID: <20250616162633.756567-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Bluetooth core - BlazarIW over USB and PCIe transport.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 3 +++
 drivers/bluetooth/btintel_pcie.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 55cc1652bfe4..f6805027be0a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -484,6 +484,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x1d:	/* BlazarU (BzrU) */
 	case 0x1e:	/* BlazarI (Bzr) */
 	case 0x1f:      /* Scorpious Peak */
+	case 0x22:	/* BlazarIW */
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
index cb3cf2b9acea..1004264128e3 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2137,6 +2137,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
 	case 0x1e:	/* BzrI */
 	case 0x1f:	/* ScP  */
+	case 0x22:	/* BlazarIW */
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
-- 
2.43.0


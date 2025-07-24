Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B11F283FF5
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753359120; cv=none; b=r1WU525Yx5KsIX/K4RlB+sw6MbD3b8geyEGLepnmuV4k+DOrBzogNmcYwo6r+GnKeOSXqshv4PsDskdv3Hx12mjVcUSmebJk3DgrPpv0BclFwMc/K6wwqN1/cuyOTFGj4qs3zOR6kwo5FdF+xz2eT/js1/EG1hQjbAcW9YTFJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753359120; c=relaxed/simple;
	bh=WwGZTA5i4Zcq5yluuu03PONDfyLu9NlJhruno+EpK3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsHmd9tVmXAz1NRMugSgnmRnGVz3u5W83G/SGN11nBWrVEkQqGqt3saLtxicnjDvkfVB7wpjqn6nvNrj4Ai3R3+4tPAkvSW61Qjag1Oqp7iYZIaBq/zcKzWyqO2bPlE0mdbo4Y+d2rF9n9PhqVgNgetWC5JYUqEixh/2Jce9EiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsZVl7fu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsZVl7fu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753359118; x=1784895118;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WwGZTA5i4Zcq5yluuu03PONDfyLu9NlJhruno+EpK3Q=;
  b=HsZVl7fuY3Zf0fBu51Xn4HTZvm9tezny22AHVrj4DHwnBKE2/8E0/8vh
   +ZaMJGAngvzlVvOuV2A1+D86zgG+HBuITjYsAN9ad9+GtXdevr+M/M6CG
   7XEP56eAf6+llGVdPEoLAAsaabAbEHNq3ikcF/WECiz8dMi8SVMnXBmn9
   J/VfrGDLuv6sh1lwfbwU6/wbuZrmk595o2/oX8Wx7AjOSxdZRKQsW+P7c
   SUkD0D2qpdGTf+tsms/KigoP0JhCDNsa1v6kLCS9nEPDT/SeURo3GpJLB
   8RDv6sw1E5OUoogoxJbSKwoDa9G/fmpXQAs2hgKFtMRDt8TrnNlc5XTmV
   w==;
X-CSE-ConnectionGUID: aKMnRKW4ThyPY/IayICO/w==
X-CSE-MsgGUID: PDqMvp2hTJqOVbd5e2id7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="58290569"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="58290569"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 05:11:57 -0700
X-CSE-ConnectionGUID: KZ/12EncSy+eW3Ag6LEOZg==
X-CSE-MsgGUID: LwcQ0GhySZ6MIM9WbhgdOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="159433122"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 24 Jul 2025 05:11:55 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	Kiran K <kiran.k@intel.com>,
	Vijay Satija <vijay.satija@intel.com>
Subject: [PATCH v3] Bluetooth: btintel: Add support for BlazarIW core
Date: Thu, 24 Jul 2025 17:58:24 +0530
Message-ID: <20250724122824.1347428-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the BlazarIW Bluetooth core used in the Wildcat Lake
platform.

HCI traces:
< HCI Command: Intel Read Version (0x3f|0x0005) plen 1
    Requested Type:
      All Supported Types(0xff)
> HCI Event: Command Complete (0x0e) plen 122
  Intel Read Version (0x3f|0x0005) ncmd 1
    Status: Success (0x00)
    .....
    CNVi BT(18): cnvi (BlazarIW) cnvibt: (0x00223700)
    .....
    .....

Signed-off-by: Vijay Satija <vijay.satija@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---

changes in v3:
- Remove dmesg and include HCI traces of Intel Read version command and event

changes in v2:
- Include dmesg of firmware download traces

 drivers/bluetooth/btintel.c      | 3 +++
 drivers/bluetooth/btintel_pcie.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index be69d21c9aa7..9d29ab811f80 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -484,6 +484,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x1d:	/* BlazarU (BzrU) */
 	case 0x1e:	/* BlazarI (Bzr) */
 	case 0x1f:      /* Scorpious Peak */
+	case 0x22:	/* BlazarIW (BzrIW) */
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
index a96975a55cbe..9792a49886ff 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2157,6 +2157,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
 	case 0x1e:	/* BzrI */
 	case 0x1f:	/* ScP  */
+	case 0x22:	/* BzrIW */
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
-- 
2.43.0


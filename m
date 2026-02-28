Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32703E8C6F
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268848; cv=none; b=nfGGKyollV9uz3GBJVsRLLNQkzS+zHa1GoeLfEV6WuAzK+vDPC1CiBnFXXAAy8ZMCYOSFFDBrUkKBWgZABc3Wz8EXzAuLqpD2unwkUWlieDuAzTt9BMvBis/CZIcrzxX2oQD3m8jAE4Qia9R5ACKvHyVWh+/5ma/mLSFBiFhJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268848; c=relaxed/simple;
	bh=1u5wXeQsC2BUklEy4+AMQOqDvMM4CDqnApcWtCU/r+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZa5daF5TAYlrrszlJE7aAHS0We0cOJiMawJvwOuNV0avGfAWI4oNGz53lSxRWDMHmQ13tu4PxrLrJ+lhxjEH8Er1mBG0r9i13kxE2iYmVjJPC8CaOSwKUTxAiVIFqEhBWKibgNK8JsxEgzDybTzTRiglquHNHbL33Nl1O14EVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jK5unwVI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jK5unwVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772268847; x=1803804847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1u5wXeQsC2BUklEy4+AMQOqDvMM4CDqnApcWtCU/r+w=;
  b=jK5unwVIQahEJ88USb/ab4Pu4gdaM7GYzho2I/tZLu/fdle1Iq0OtPJ9
   IIxMmlJYxk2TdVvuR8bG4Uzr52BsA6eHH5SpFF1E1iBK2VjXiLJnvX/jL
   HPUCBXp/akwt+hIJhNEia0krWiinSB9wUX/2TL10tV+DQH9Roqugpxvx6
   c88KuhzEICNod4DfEBgn6ENXZfQVABa/R09SYejw/y8R+++tVE7xyIdoT
   wpnuP1fqAGaDsfhwjh2IsJRHsg7w44rSJxPKPsKDTIesZuIrMFSMCwmOs
   IhPM1AtXj31iu+QAGEJsIzpe+7BzuAmxN0bKKgU+fe7E6epcb2m8tZzPV
   Q==;
X-CSE-ConnectionGUID: XdR58584TwOxbttYiqr4Bw==
X-CSE-MsgGUID: JHSe4w26T72FzQSIeP/1Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="77189237"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="77189237"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 00:54:07 -0800
X-CSE-ConnectionGUID: 5P8pR5QNSzeJa4aG7YEm3Q==
X-CSE-MsgGUID: ka17FyefSbyFolciiOIFQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="221630145"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2026 00:54:05 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 3/9] Bluetooth: btintel: Add support for Scorpious Peak2 support
Date: Sat, 28 Feb 2026 14:42:33 +0530
Message-ID: <20260228091239.230284-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228091239.230284-1-kiran.k@intel.com>
References: <20260228091239.230284-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Intel Bluetooth Scorpious Peak2 core.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 3 +++
 drivers/bluetooth/btintel_pcie.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 2547b590f87a..26aa8ea7d33e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -497,6 +497,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x1d:	/* BlazarU (BzrU) */
 	case 0x1e:	/* BlazarI (Bzr) */
 	case 0x1f:      /* Scorpious Peak */
+	case 0x20:	/* Scorpious Peak2 */
 	case 0x22:	/* BlazarIW (BzrIW) */
 		break;
 	default:
@@ -3318,6 +3319,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	case 0x1d:
 	case 0x1e:
 	case 0x1f:
+	case 0x20:
 	case 0x22:
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
@@ -3659,6 +3661,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x1d:
 	case 0x1e:
 	case 0x1f:
+	case 0x20:
 	case 0x22:
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 5442a6af5cca..308482d0c581 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2100,6 +2100,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
 	case 0x1e:	/* BzrI */
 	case 0x1f:	/* ScP  */
+	case 0x20:	/* ScP2 */
 	case 0x22:	/* BzrIW */
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
-- 
2.43.0


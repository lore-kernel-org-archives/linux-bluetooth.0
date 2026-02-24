Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4033A0B0E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946179; cv=none; b=KLnRisHcShZ89av/L7ZMDOtxifvtyYNjlTkbF/IJ8MJ8y7cMpe1yYwiXIXOmv/o3j/++FIgdw1w7ri8ZLK7TwNzJ+De0rmP5uZDZrTnFLa2t1BNaTqpcF+ClkWYrEv5alacYPNNHwBoObPijA1DEYgvCNtH2vXZpABDPITe3Xbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946179; c=relaxed/simple;
	bh=axlfXtY670o7l2ABOdE3a+KwdhKULPwH72LH/68iVxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9Cv9o0QKtZdv1KoB0VDWCmYTHHXS0mjK9CH3BGhqDp41c8WFrtZe8e00kjcOVCwGva0UeqjZjAkbijGIMBVWzu6mYK9ErRmE5s8zQw8fcvTReElDlKGEEk3D/9TGLcEL1S8ryFPR+iD5zZ+PPs1+q6pQpLpNNDjbRAVJGsGPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wr3Sj1oX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wr3Sj1oX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771946178; x=1803482178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=axlfXtY670o7l2ABOdE3a+KwdhKULPwH72LH/68iVxk=;
  b=Wr3Sj1oXEwzwUEx6DP3+aEM6SQ+ujGLHKOQTmEkLvkJlW/8dLva7DY8e
   Lhvxj0VgoALBg9X/e8cW2/tWdF9G02D6rO79z3PpSSIFgQmp6y96mawT3
   yFmMGYSMpYkx9JnU88IYgdInwTAsRqNd9kN/avYAtDrCbI5MfflWwff6Q
   EdIithFx46LWgapEv4tyNaB0v9qbJS+AGTkn+eiU28AY7wINeAA0uoosN
   YsZK5jDFrtwPjFxQ2UDV8pRpL/t7zu928Gl+kOOlf+WjM2HyN+KC13hI4
   hnVeRueHHM83f3qbW/9VB3P8PiYPL09okUkuszGrg8z+uSlrmOSbCbZ/M
   Q==;
X-CSE-ConnectionGUID: xub78CmJTfq9dqSnihHe2g==
X-CSE-MsgGUID: KzdradjpREC0r+LiME3xyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72874686"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72874686"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:16:18 -0800
X-CSE-ConnectionGUID: vd3v+n8UQNGp+iCB0X2KTQ==
X-CSE-MsgGUID: XlwW8gQiR9+divgYO6+W8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253676477"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2026 07:16:16 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 3/9] Bluetooth: btintel: Add support for Scorpious Peak2 support
Date: Tue, 24 Feb 2026 21:04:42 +0530
Message-ID: <20260224153449.193551-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224153449.193551-1-kiran.k@intel.com>
References: <20260224153449.193551-1-kiran.k@intel.com>
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
index 1a35cbabcc07..19abffca209f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2099,6 +2099,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
 	case 0x1e:	/* BzrI */
 	case 0x1f:	/* ScP  */
+	case 0x20:	/* ScP2 */
 	case 0x22:	/* BzrIW */
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
-- 
2.43.0


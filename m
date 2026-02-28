Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D101CEACB
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268852; cv=none; b=iKw6SaEbJ6ls62gHeL5VAwNsW8MY2ihK7IF1FJWmyfy24m94KNLaUQoxr7JY/bqASB007vNtEc4j+HgE/nKEtbK73byqGwcS8uoSNDIzC7kWQqVrXSYyIQl9t2coQ8ZiqctkMoDfZJUUBsOl1CzUVnZaXHfCmAlblSx7mRM2x2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268852; c=relaxed/simple;
	bh=3Exdd/S4pMgxwph5xOhX5Lif+FX+hGsbJMWgM7t4kIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kt4hiP740Ce5pEQAQuvJd8uT5GSvIFTYO+u2MC9ZMMViBH4n3B8BrLlHAW2MV1JXbQyV9XjSx+X17c8ujJmWxiuAqUJyA35anPznB7tQQCNXo9Z6VUNZypkuJxF77SCTKG0iSOzn00YwMR1vChr/ZbaRDp4cGgVoP1L7033d7gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFeWkOkf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFeWkOkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772268851; x=1803804851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Exdd/S4pMgxwph5xOhX5Lif+FX+hGsbJMWgM7t4kIM=;
  b=LFeWkOkf764Xk4udMIbUBij2gg8/Hp6tYCPHSFYR3SZW+H/liEe2FAjo
   Pm8PUS9HBWDc5BoQsr+tukk4sp7T0GBwO9vfMWr4pZf6XivZoW3zaNCCn
   i4PW2jFeepshVK6SnIig+VOIQA/eXcHaVi/ZikBRLPMIs3pjlVfU2+1WA
   KPRG5ub2oQQFTHx8jKUppJrdQdgKqBQon9vxvFEGuJ7g0Fh91oYUbIsl3
   9hc/FbyiE2nDxVw1Xi6xGc+TWbdDjAGh/iKAJAs6Xnll/dMBHlFPVNknN
   41LsZo2kfhsM+WlRZFh08pBF6uUl4P8/O0Le1n29I+RVU/yjUDvS86hFb
   w==;
X-CSE-ConnectionGUID: xuRdGaQpQf6+4PXqOywP1w==
X-CSE-MsgGUID: XIDjdeiZR/Wh3VVbR5iibQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="77189242"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="77189242"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 00:54:11 -0800
X-CSE-ConnectionGUID: wOGeMD5nToKFhvsn+7muYg==
X-CSE-MsgGUID: 5cWqYRFASzubBdHqfAPmfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="221630153"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2026 00:54:09 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 5/9] Bluetooth: btintel_pcie: Add support for exception dump for ScP2
Date: Sat, 28 Feb 2026 14:42:35 +0530
Message-ID: <20260228091239.230284-5-kiran.k@intel.com>
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

Add device coredump support for Scorpious Peak2 product.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.h      | 11 ++++++-----
 drivers/bluetooth/btintel_pcie.c |  7 +++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index f16f852b83b8..b5c00be8277a 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -54,11 +54,12 @@ struct intel_tlv {
 
 #define BTINTEL_HCI_OP_RESET	0xfc01
 
-#define BTINTEL_CNVI_BLAZARI		0x900
-#define BTINTEL_CNVI_BLAZARIW		0x901
-#define BTINTEL_CNVI_GAP		0x910
-#define BTINTEL_CNVI_BLAZARU		0x930
-#define BTINTEL_CNVI_SCP		0xA00
+#define BTINTEL_CNVI_BLAZARI		0x900	/* BlazarI - Lunar Lake */
+#define BTINTEL_CNVI_BLAZARIW		0x901	/* BlazarIW - Wildcat Lake */
+#define BTINTEL_CNVI_GAP		0x910	/* Gale Peak2 - Meteor Lake */
+#define BTINTEL_CNVI_BLAZARU		0x930	/* BlazarU - Meteor Lake */
+#define BTINTEL_CNVI_SCP		0xA00	/* Scorpius Peak - Panther Lake */
+#define BTINTEL_CNVI_SCP2		0xA10	/* Scorpius Peak2 - Nova Lake */
 
 /* CNVR */
 #define BTINTEL_CNVR_FMP2		0x910
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 308482d0c581..83b09a63eae1 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -74,6 +74,9 @@ struct btintel_pcie_dev_recovery {
 #define BTINTEL_PCIE_SCP_HWEXP_SIZE		4096
 #define BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR		0xB030F800
 
+#define BTINTEL_PCIE_SCP2_HWEXP_SIZE		4096
+#define BTINTEL_PCIE_SCP2_HWEXP_DMP_ADDR	0xB031D000
+
 #define BTINTEL_PCIE_MAGIC_NUM	0xA5A5A5A5
 
 #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
@@ -1231,6 +1234,10 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 		len = BTINTEL_PCIE_SCP_HWEXP_SIZE;
 		addr = BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR;
 	break;
+	case BTINTEL_CNVI_SCP2:
+		len = BTINTEL_PCIE_SCP2_HWEXP_SIZE;
+		addr = BTINTEL_PCIE_SCP2_HWEXP_DMP_ADDR;
+	break;
 	default:
 		bt_dev_err(data->hdev, "Unsupported cnvi 0x%8.8x", data->dmp_hdr.cnvi_top);
 		return;
-- 
2.43.0


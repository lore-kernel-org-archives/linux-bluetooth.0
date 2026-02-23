Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47F31987D
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866153; cv=none; b=ds/MuCsVExaUYzEqAVgn0haYSZDEVOUxWgbcyfJsjKSJKkX0Gjaxj2vKusmd6xCBgX30baWzXcoQq4z2cKAuFwHmZy2I5mKyU/tysITcwkoHjvFnppF5AhR8nzhLQgwdyKW8Q40UBH+usJU0VZCJ9jWHl+amt9iRDEJvKbOsSac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866153; c=relaxed/simple;
	bh=dlELvtIo1r5xONcz+QJkMSl9SYa2M2qr6QuuxnU/x3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ze2jVnbAXEupa9+35XmztkrAVNzgyy3XaWl79hGlSR8wovr85RTiYBOn5RjCVOQmIPlWYU8OOlbdEAIty8KpO0aUoq/N28GteNvljmNaX1ZZ3P0p/3g149uXgW5EnZPQlpR27stEFFvs/b3Ol3DIHwX7QMhIyVuwneF1eMpeqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dp6eazGP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dp6eazGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771866151; x=1803402151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dlELvtIo1r5xONcz+QJkMSl9SYa2M2qr6QuuxnU/x3E=;
  b=dp6eazGPqKizbEvK9R5dO57OpADNBBF+JP6rkIxHOH0VbZp37qYem8zR
   yi1W++QCLbeOLTVATL5SfGwtYCXO0HNUzBb/dO924aTZGEeUqd2I6oYSU
   CGm+Ty0bdjc9rCrOAfNVwYtZohAJjVgnPIhwrrY9oDo9a4KfW11z7SY5c
   0mYOnH6Dl4wk73qqhVC3II1fTE/EwGtzaO25Jm18evNPhCzPhlSa/dxnG
   udUGohf8jctaLsxlJVAJFJwUXSr8HMfrbcMWXzPPFLanaYVJyyq7BfA4V
   w5W50RKGA+ACgtc38UFj6gbSEWgHiVw2v01JpVV7Z0V2izB88mdWG7ljK
   Q==;
X-CSE-ConnectionGUID: rEri5OtVRmqqMxqZ/UzKsA==
X-CSE-MsgGUID: hcJaqUZ3RyGQ/iFKyVFWHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="95484474"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="95484474"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:02:30 -0800
X-CSE-ConnectionGUID: xJ5MmaISR3ibFWlv35+2EA==
X-CSE-MsgGUID: 3d1I7fJpTkWz4qGHl9+vRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="214698386"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 23 Feb 2026 09:02:28 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 5/7] btintel_pcie: Add support for exception dump for ScP2
Date: Mon, 23 Feb 2026 22:51:01 +0530
Message-ID: <20260223172104.167471-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223172104.167471-1-kiran.k@intel.com>
References: <20260223172104.167471-1-kiran.k@intel.com>
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
 drivers/bluetooth/btintel.h      | 1 +
 drivers/bluetooth/btintel_pcie.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 1d9dde3c7874..bef7ea84b1e4 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -59,6 +59,7 @@ struct intel_tlv {
 #define BTINTEL_CNVI_GAP		0x910
 #define BTINTEL_CNVI_BLAZARU		0x930
 #define BTINTEL_CNVI_SCP		0xA00
+#define BTINTEL_CNVI_SCP2		0xA10
 
 /* CNVR */
 #define BTINTEL_CNVR_FMP2		0x910
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 19abffca209f..bf71817b1cc6 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -73,6 +73,9 @@ struct btintel_pcie_dev_recovery {
 #define BTINTEL_PCIE_SCP_HWEXP_SIZE		4096
 #define BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR		0xB030F800
 
+#define BTINTEL_PCIE_SCP2_HWEXP_SIZE		4096
+#define BTINTEL_PCIE_SCP2_HWEXP_DMP_ADDR	0xB031D000
+
 #define BTINTEL_PCIE_MAGIC_NUM	0xA5A5A5A5
 
 #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
@@ -1230,6 +1233,10 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
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


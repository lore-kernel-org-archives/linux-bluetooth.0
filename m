Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDCB328B78
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866157; cv=none; b=bYiqpp+FPc6lwhMzYedpXXA4MgSfxCHc9qZgY/vI6CJLOoh0/p9zf/jJXAPGwaFM3DIAgeVZlXujy7ArchyPc5eDkO9l3EFrSxySuIv7UUCceNYoeye1FC1LtIIyNrg7YyFd/oiO/DuC4vyaMm0aXsk5bxctuu7dMeX2Vxh6BDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866157; c=relaxed/simple;
	bh=tnnX+X5fGlsFBcK7JyT6TGXZUYAs3eqZ/XzkY6tngcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpuv1g+YAdkQsMDl7oYXvnjCe6O4ESDFDHB3xoUaST2sg9iCe1pn3SZrdkf8IrUftmu7/39drWZPZ98908GXeAl+dY4lBi7blyOk8WnNRjVX3utn2Yj27xPwXcz/BJwjiFoN38PbNO0a5loM1D2ksx1lcQwBRiJk/pH6Tjhg3co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fo0/ILfp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fo0/ILfp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771866154; x=1803402154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tnnX+X5fGlsFBcK7JyT6TGXZUYAs3eqZ/XzkY6tngcU=;
  b=Fo0/ILfpjoYroKPmReXXZeH5qhZiue+YUAywcHMeE128nNU80JRxvin6
   TTpW0n1oUODOAIYZmVdlnXo0BoxyCz1TM7POvpQRuIgrgjNUKxRa/FZLi
   RCr9Jb3NnCK5OgWmAkHQC20EBkj18ceeHJ0pQOXGuDBQEG3JBrL0RD1w5
   fPlQzIIdSCBY7D6+rBPaegvMttu1pehEfnwl3I4q+CYHzIB5Dge7ffMfU
   D1sHyYAl2NKG/AaIkWAU0F5Rd1NjUJn1Q/RWD+WsEyDbk+oKi5mzz4Ac9
   oLA0dlAv+kDaubhbz8lH6hymM1KzQ13tW2TcnZk+vVxxCtCfdwJAC9DFo
   w==;
X-CSE-ConnectionGUID: rK5Xw8RXRRe6dFP3kAJ2/Q==
X-CSE-MsgGUID: 1oeIbc8xTaKr7u3S5qWLWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="95484489"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="95484489"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:02:34 -0800
X-CSE-ConnectionGUID: GTSvSQBmRpCZgfSZux839w==
X-CSE-MsgGUID: VgwHBD6vSLC3fNJcl77keg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="214698410"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 23 Feb 2026 09:02:32 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 7/7] btintel_pcie: Add support for exception dump for ScP2F
Date: Mon, 23 Feb 2026 22:51:03 +0530
Message-ID: <20260223172104.167471-7-kiran.k@intel.com>
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

Add device coredump support for Scorpious Peak2F product.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.h      | 1 +
 drivers/bluetooth/btintel_pcie.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index bef7ea84b1e4..b5e7f0aafb4c 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -60,6 +60,7 @@ struct intel_tlv {
 #define BTINTEL_CNVI_BLAZARU		0x930
 #define BTINTEL_CNVI_SCP		0xA00
 #define BTINTEL_CNVI_SCP2		0xA10
+#define BTINTEL_CNVI_SCP2F		0xA20
 
 /* CNVR */
 #define BTINTEL_CNVR_FMP2		0x910
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index d0cabf4df7c0..d903460bea76 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1234,6 +1234,7 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 		addr = BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR;
 	break;
 	case BTINTEL_CNVI_SCP2:
+	case BTINTEL_CNVI_SCP2F:
 		len = BTINTEL_PCIE_SCP2_HWEXP_SIZE;
 		addr = BTINTEL_PCIE_SCP2_HWEXP_DMP_ADDR;
 	break;
-- 
2.43.0


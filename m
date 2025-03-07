Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3B2E822
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317065; cv=none; b=fFTuS+LTSAMSNy91NrxyNiFhxxjUdcsu8cn9BZnEXrab8DrNGj4s2ILS0fUEKpBuDfPe8+kiOFzTmKyehoZwTXTVLoK2rvCccOyn3GSpLTMUJWXeYsrq0D9kzXGA1S89IjzPcii4V8sVpmBzdzuxyKRuEViUAkhMatMrjpVdhCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317065; c=relaxed/simple;
	bh=/FDLbnFGXlYaq0gtq2r7gzYDooLH5D3j1tX96oTnBzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQWS8UzlZvxMk3HG/0NoKNj9sheNlLqQHL/H513LT8rTpZ3Zu6MG7IQKRN8bnKpTID5tq+kijgXnOCEHqZ41pFW9jiW10F2y1Jjykdx+805aN7ZKkNhzKI4QgNYJiv5Oe2eJW3syYbJpyrIVuYTSNQRRa4j8yttxXlgQLbZ7JYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iB/fQX5S; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iB/fQX5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741317064; x=1772853064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/FDLbnFGXlYaq0gtq2r7gzYDooLH5D3j1tX96oTnBzs=;
  b=iB/fQX5StCmF8S7HKhgVfGxwiDKRHRTG2FuiMwsTZj27FMDXyEEcKH/u
   Kba6Gf7TG9bMNrhyH6knu0naJ4U+/Vq13XCyb5LN7jZVW/5aShLEtHNIg
   iaoTY2zwtCetsNeNeJfgqw3qesJ/NVt5bIiHTglIZ/+D2/8On6psaXyfs
   QulUgd01UsXqTId3pbb3VKs/mcI9MNJfyRjGqfSbrXGSmqgS+0A971AiW
   91XdED4iJnKmNq7laI8BVNPWbFeB01UWkjEkyT/FnD6Cl9zVv0kCcpSWF
   MRKPHZITjHr0Og+YFqaXypxfSewzmEZbgguWTOPvdvXKFidHYJGdNo2q4
   g==;
X-CSE-ConnectionGUID: JoznvSPeQvC0d1dlpLeuWQ==
X-CSE-MsgGUID: jX2ccLO/SOaeuaQxK1fsgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="67732812"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="67732812"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 19:11:03 -0800
X-CSE-ConnectionGUID: FQmhgJKqRfKummIYvfkF3w==
X-CSE-MsgGUID: TvGJkrZzTz+sFIG3HKDNbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150140023"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa001.fm.intel.com with ESMTP; 06 Mar 2025 19:11:01 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Fix leading white space
Date: Fri,  7 Mar 2025 08:40:55 +0530
Message-ID: <20250307031055.285027-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the unwanted leading whitespace.

Fixes: f5d8a90511b7 ("Bluetooth: btintel: Add DSBR support for ScP")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 19530ea14905..dc43c27e360d 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -56,7 +56,7 @@ struct intel_tlv {
 #define BTINTEL_CNVI_BLAZARIW		0x901
 #define BTINTEL_CNVI_GAP		0x910
 #define BTINTEL_CNVI_BLAZARU		0x930
- #define BTINTEL_CNVI_SCP		0xA00
+#define BTINTEL_CNVI_SCP		0xA00
 
 #define BTINTEL_IMG_BOOTLOADER		0x01	/* Bootloader image */
 #define BTINTEL_IMG_IML			0x02	/* Intermediate image */
-- 
2.43.0


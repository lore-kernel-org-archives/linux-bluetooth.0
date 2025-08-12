Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719E22C21D7
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998237; cv=none; b=asajL8pkauhISC3JtgGrKgbwInHhAX9dt/o0LZLftf4KRuDsy3dRuVag32H0FajfYAAbQWCnKhUP4RcE4c7nFVBPgrvjjlgfCEEGY16ua4e0cT6btX6ssqQvbVt1BfY7UACfBlip2stZE6BvPpnZQyv/5lv7SmGejcijZxCypMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998237; c=relaxed/simple;
	bh=YrrBQBi5Vnqu9sA7HctX0DsyoxBVHemRpwgVh22okPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLFxfvgKoB8jVAVaFmGasgEXFLPSjvu+26aZlfVrZx0nUC4X8sxkrCNjmUGluy0oc++JpyQgp1cAMt4crMEng8ISXDH2joBh0xYxqgVx+7/17vSkynrclkBSbfmpyZIaoYDXWsFeDWA0TcWnnvktKRke968vN6bEUbF04QxFpFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXEJH9Fe; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXEJH9Fe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754998235; x=1786534235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YrrBQBi5Vnqu9sA7HctX0DsyoxBVHemRpwgVh22okPY=;
  b=HXEJH9FegWHXNam0VVuWcLrN6llMndAI5iYAd5lZOuHRpTYEdJUumFvi
   f74gkTtE/ZrLskdNHkMiQRtHqFhpcE7bSV8UNAaMJnNzKZcCUzwECc9rp
   tkPiFk2G2Mwhqxv/VT/8EF4Xpe6S7jhvAgysTPw4rsg+9fCKeNKUi5u7+
   HYL5RMUoq2Zt5Zfvk5XTgzauXZG068ZAsLcmz0coh7FEvNh+OQ+Brw9xe
   YZW58h0ofB1hV60r6cLUiI8CVVHxFafrgU5Jlfsk0UPc73NImTX2x6uZx
   99VeRuInqOtlvAwthMdDBQMKg3SPLkRvA1IwnSYIFjY1L9tvKuWwBht2G
   Q==;
X-CSE-ConnectionGUID: EjmdSnFGSF60JSwrmTvr8A==
X-CSE-MsgGUID: /I7BFzb8SdS8oWRKf0T0Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68724683"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68724683"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 04:30:35 -0700
X-CSE-ConnectionGUID: o3q3D+G4T9WH6IwIg1moaA==
X-CSE-MsgGUID: jns7GKj0ShKCtPAzNNx2eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="171422317"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa004.fm.intel.com with ESMTP; 12 Aug 2025 04:30:33 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 2/2] Bluetooth: btintel_pcie: Add Vendor and Driver Name in Coredump
Date: Tue, 12 Aug 2025 17:17:04 +0530
Message-ID: <20250812114704.1596969-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812114704.1596969-1-kiran.k@intel.com>
References: <20250812114704.1596969-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the vendor and driver name to the device coredump to facilitate
identification of the coredump source.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 13 ++++++++++++-
 drivers/bluetooth/btintel_pcie.h |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index a78e24aa5e38..ae47a65ed664 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -627,6 +627,8 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 	struct tm tm_now;
 	char fw_build[128];
 	char ts[128];
+	char vendor[64];
+	char driver[64];
 
 	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
 		return -EOPNOTSUPP;
@@ -647,6 +649,10 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 	else
 		return -EINVAL;
 
+	snprintf(vendor, sizeof(vendor), "Vendor: Intel\n");
+	snprintf(driver, sizeof(driver), "Driver: %s\n",
+		 data->dmp_hdr.driver_name);
+
 	ktime_get_real_ts64(&now);
 	time64_to_tm(now.tv_sec, 0, &tm_now);
 	snprintf(ts, sizeof(ts), "Dump Time: %02d-%02d-%04ld %02d:%02d:%02d",
@@ -667,7 +673,9 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 		sizeof(*tlv) + sizeof(data->dmp_hdr.cnvr_top) +
 		sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_top) +
 		sizeof(*tlv) + strlen(ts) +
-		sizeof(*tlv) + strlen(fw_build);
+		sizeof(*tlv) + strlen(fw_build) +
+		sizeof(*tlv) + strlen(vendor) +
+		sizeof(*tlv) + strlen(driver);
 
 	/*
 	 * sizeof(u32) - signature
@@ -691,6 +699,9 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 	*(u32 *)p = data_len;
 	p += sizeof(u32);
 
+
+	p = btintel_pcie_copy_tlv(p, BTINTEL_VENDOR, vendor, strlen(vendor));
+	p = btintel_pcie_copy_tlv(p, BTINTEL_DRIVER, driver, strlen(driver));
 	p = btintel_pcie_copy_tlv(p, BTINTEL_DUMP_TIME, ts, strlen(ts));
 	p = btintel_pcie_copy_tlv(p, BTINTEL_FW_BUILD, fw_build,
 				  strlen(fw_build));
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 0fa876c5b954..04b21f968ad3 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -132,6 +132,8 @@ enum btintel_pcie_tlv_type {
 	BTINTEL_CNVI_TOP,
 	BTINTEL_DUMP_TIME,
 	BTINTEL_FW_BUILD,
+	BTINTEL_VENDOR,
+	BTINTEL_DRIVER
 };
 
 /* causes for the MBOX interrupts */
-- 
2.43.0


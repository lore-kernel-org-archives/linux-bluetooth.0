Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA91720E717
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347261; cv=none; b=nH6ZiSojoITREeiNw2uxsUAOW/3C4yy6TLs4DFmV+Gwas7if0WA8+eP6SChUpdM2GbibbJwEfoxMjflSR90AN4HzEnUFFde9hXvFdT7merkT4w60Nu403F48ToCHDOBXAuwkdPKfbHZu6+BimJCzYPCzLp8PXbQImKAw4d0fJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347261; c=relaxed/simple;
	bh=3rKrXa0vrumhkxatBak8IFAWS7zv6C3y8p44DEw0/0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGpVF1oDma/EPgIVUpYGsgACg379ryqHmzarhIaKksAWcz6ZPFIzq+s+sacAf48jRBEXKQM5t/MHRhM7yMEUGrPqyMVMd9x/9VoC6fnnxLf11yZFsrHDyMk9jQhMVPuwK7PsbiaC80yAxB+A3aornMhjpynnbhtFYwtB/zd3Ywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYT6wE+i; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYT6wE+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741347260; x=1772883260;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3rKrXa0vrumhkxatBak8IFAWS7zv6C3y8p44DEw0/0I=;
  b=ZYT6wE+iiioyvNpUurkoKI9QlfDCwC6avPtAjCbMUgE4Ti2T9UsAJwfC
   a3i9JFsVgIU+6LJf+YHNBBfnJKG0SVVNI5e/8TD2PiWLKhJy00ZEAWpnA
   LAw7KaVOlnpPt9W49MdHnuFPbJ6TIpG/SDvaSCpfpXD6uv0jqQcPY5Goq
   kWBwMY7T9/ledJKJKekvDbw+/Vy09UCmhc5OFeSqBYsiV+S5ir5Sd1vzY
   +7f+sxeKJxEcXjegthQydMqRZiAMQdAU/LUeK8HvtKS/UlERFgb0h2YJS
   71p/QwWFT145FUB7BKNO92QNpKpqTBWS+W822KkDktWX1fBqaJuDDu0wP
   Q==;
X-CSE-ConnectionGUID: 03MG2963TPWR1XD953HOOA==
X-CSE-MsgGUID: C3qIM+IITcmuKQ3plZDYfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53380771"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53380771"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 03:34:19 -0800
X-CSE-ConnectionGUID: x3o7UaZaSdyfomve01mnGg==
X-CSE-MsgGUID: pi6KTIS1Rcm9CwPjCG8/GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156513776"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa001.jf.intel.com with ESMTP; 07 Mar 2025 03:34:17 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Fix leading white space
Date: Fri,  7 Mar 2025 17:04:08 +0530
Message-ID: <20250307113408.291310-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the unwanted leading whitespace.

Fixes: 00b3e258e1c0 ("Bluetooth: btintel_pcie: Setup buffers for firmware traces")
Fixes: f5d8a90511b7 ("Bluetooth: btintel: Add DSBR support for ScP")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.h      | 2 +-
 drivers/bluetooth/btintel_pcie.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index f3ab5b41b050..eadbe4fedb61 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -49,7 +49,7 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
 #define BTINTEL_PCIE_HCI_EVT_PKT	0x00000004
 #define BTINTEL_PCIE_HCI_ISO_PKT	0x00000005
 
- #define BTINTEL_PCIE_MAGIC_NUM    0xA5A5A5A5
+#define BTINTEL_PCIE_MAGIC_NUM    0xA5A5A5A5
 
 #define BTINTEL_PCIE_BLZR_HWEXP_SIZE		1024
 #define BTINTEL_PCIE_BLZR_HWEXP_DMP_ADDR	0xB00A7C00
-- 
2.43.0


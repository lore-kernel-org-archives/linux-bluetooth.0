Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD54690
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Jun 2025 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750487020; cv=none; b=MVHnFwHvecKha95hfkkrIXzC7dfhJlhkEXg6EMOgy7hd+UPC3g0blZ35TYrdDrExvudSkVaBLNt56X5nixcUtksYvGuOeiyutga5hzL4jv50SB/HLcJQYOewSlv94j+vOgurzuebnDGHZWL4FPuRwye+mMM4AeSp5MChIRFjJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750487020; c=relaxed/simple;
	bh=WszhSbtZKpnLp+w0oI9Nchv9dA5/zG1jJ28dOZqGsuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q/v6x/DSHGbhzYLGwMoAF27l2wvXsA7yiC/cQmi6825Yord0GoiYpz49+m8kIEJNwBePZGgOa9Vxnq0FCp7gPe4ioHAB3YlGb4eDDopeqQoERkRvftFrZbYWhs9huRbLYTsIY6woxl+kHzFmhfms4LNhOsw/N/dQ0MStmlg/pyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYNoaehj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYNoaehj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750487019; x=1782023019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WszhSbtZKpnLp+w0oI9Nchv9dA5/zG1jJ28dOZqGsuo=;
  b=VYNoaehj3+HCqhjZvG1ke4W8+BsXOPHLLz+ELj5oQljoJhD0m8Dw1jx3
   TS5TKn4klPY6L4SCHKaAHbD52gIhwvZ2reOaQQnnFNq8HTyjFfe1QH7re
   EvDBaMgwmoLxirC/mZVOahDXfSf1+A1DzTgPkZMzsGYpozKOP3FhJNkDx
   4TkvSiZM49Cny0ZxBY75a/sP4b1hvYlZmKvvpxL1ISoenH043YLvSKdqy
   fXzrNXac/8Dw1HgGg628NItsbkMso9QM5YMojTY2ZKxuGxUUjIEM/5ORP
   qGA+Ocmf9VKR3Uvj1uyGuRyYUDTtIdV7c1z4km/wj+kfXom+25Y4/ZR3+
   A==;
X-CSE-ConnectionGUID: MY65wKPgS0ibZsbaA9MD8g==
X-CSE-MsgGUID: 10tehKNpSGyBFT8ukXdKog==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="70321199"
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="70321199"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 23:23:38 -0700
X-CSE-ConnectionGUID: eRor6BhaRi6fhna/bs7Twg==
X-CSE-MsgGUID: llXxOeVqS6KD8lFKRBBoqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="151234893"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa006.fm.intel.com with ESMTP; 20 Jun 2025 23:23:36 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Add support for device 0x4d76
Date: Sat, 21 Jun 2025 12:10:13 +0530
Message-ID: <20250621064013.781631-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lspci -v -k -d  8086:4d76
00:14.7 Bluetooth: Intel Corporation Device 4d76
        Subsystem: Intel Corporation Device 0011
        Flags: fast devsel, IRQ 255, IOMMU group 12
        Memory at 13013328000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [80] MSI-X: Enable- Count=32 Masked-
        Capabilities: [100] Latency Tolerance Reporting
	Kernel driver in use: btintel_pcie
	Kernel modules: btintel_pcie

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index cb3cf2b9acea..1113a6310bd0 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -35,6 +35,7 @@
 
 /* Intel Bluetooth PCIe device id table */
 static const struct pci_device_id btintel_pcie_table[] = {
+	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) },
 	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
 	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
 	{ 0 }
-- 
2.43.0


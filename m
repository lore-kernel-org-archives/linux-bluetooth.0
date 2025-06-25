Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FB815A86B
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839748; cv=none; b=Ftxyq69/OnmyZ42UC8p9oX9C5xJN5+x/ogtY7wDgZUHK1QkMHlUCAkVhNkfM4N/c8PPgt/jhnHladAWzkoRh3CNS8tnlTVZd1rYQbSkOq5p60jZ+GLkt3RD0JwAJ4RfsTBuF6WhNaIaoS5qfpcmTAkDZ11Id1DNzSx90ByHo65s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839748; c=relaxed/simple;
	bh=x/RgigVbTKjHOXadICwTZDVqMyatOolVQB0fSUrkOtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ur+IrkeNL4zTpvOQJJpiTa+jJfp9JqRah+LUB77ty4h2pKyim3r+P7jTqaJAkQlxIWCP8JgFDp17tQ3HzOs23SMrj2Qpgv2SEuWm9UHa0gLABwY9FvmRhQFKRzWYsjQi09Q7Zvsnxx6iLafbj+djItVa9r2+Ea6v95I7cjPirqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2pgWNsq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2pgWNsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750839747; x=1782375747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x/RgigVbTKjHOXadICwTZDVqMyatOolVQB0fSUrkOtQ=;
  b=I2pgWNsqc0rEKrwj0GohA4O2s42w6cS7fPqnf/mwygw6nXXGNJgjY92e
   ipslnid5oowtnoHMQzmtSNfitryeyZvuI1lCFIZUOTcCMEJSs4PvZjalO
   kuLZU9NTz04zd6rZwoxu62Ngdu1z9l507ucApgkk3Q7Cq5gzDZwrImaPs
   r9Ltk96jW6vTEY3L4AVepyNrcAVsioo/+eqKbpPvWCcNvMj1NZXmOQky3
   GwCWl9hSfhc+g9sq82ph7uFYMRgBuEAHvZVCo8goXjMtGOQPMNZIiEVao
   szKLsnMMs1eh0amSBCaxP6VIHR1/eEA3D/PXLpLc9xiIjPFn6v3vWc7/m
   w==;
X-CSE-ConnectionGUID: TcO/4I4FQoiwDgZjkdy3fg==
X-CSE-MsgGUID: iUYxPEk6SDK9rFs4eXtrbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="63788281"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="63788281"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 01:22:26 -0700
X-CSE-ConnectionGUID: mAL/VRKNQSytETtIN3+L1Q==
X-CSE-MsgGUID: bTizEfGfTkKuwiios/bfMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="156554008"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa003.jf.intel.com with ESMTP; 25 Jun 2025 01:22:24 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v4] Bluetooth: btintel_pcie: Add support for device 0x4d76
Date: Wed, 25 Jun 2025 14:09:01 +0530
Message-ID: <20250625083901.822922-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wildcat Lake platorm supports Whale Peak2. Add pcie device of Whale Peak2.

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
index cb3cf2b9acea..2ae00332085c 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -35,6 +35,7 @@
 
 /* Intel Bluetooth PCIe device id table */
 static const struct pci_device_id btintel_pcie_table[] = {
+	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) }, /* Wildcat Lake */
 	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
 	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
 	{ 0 }
-- 
2.43.0


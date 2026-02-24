Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF623A0EA2
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946188; cv=none; b=ZnG1+0MNu+hd++Hf7zyLwcj4OubVkfef6OUt7e+K8R/8P73OhfqtlJxXYDYfAaxVrisjjWef4I3P02PYvK6IAQZUAyB3GtuxOjYAVWqpdAVFfh0RUyB1Ox4nwjo+8LA5r10yJK0pLjbLef7D0LncRBmQkAjZODdR1+1iEQtsF0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946188; c=relaxed/simple;
	bh=kRN4yLJI1osZiTK7mr75AnZj8nUr5Zq6AO5Lb9PQ5u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAgIjJSYFflaX0R1AdoiAf1HRfI6AcnZflOJ//RGaFkf8iSYlh6PeAyttx3AWem4Et4k17+clmBOjvB/CjmdVOxbUcd9k7rTZCcUQJR1FbSjZcjI8MNlIB+0ayvhh4/VFJCInnJykupbrheBvJ3/dJ10pTcfyQbh06Tp+beY8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6ZCvDU8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6ZCvDU8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771946187; x=1803482187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRN4yLJI1osZiTK7mr75AnZj8nUr5Zq6AO5Lb9PQ5u4=;
  b=L6ZCvDU8YD1UBSW47alE6/PTYvFWiCO9dmP7OFHSY9oYj23ihlBx0kV/
   SxTynsdyzUzZPwhtq8mSfb3eyB8OuwwT4C7AuyNUkCrD94HwUhlV3vTre
   jWTioI6V8pEPZZiHgtSJY2ZVhUstWswb8tEvRznOXQfJqWwCZeaXBt1I0
   KCYBILusT6xLKidDSszZ5mX+zsctelcVMT7JDG5L1fEsNjz50TbNX0g3Y
   GHIbKHuX4C+pHzOK8JVUDBMWIXpSoHwWJPuvAeIWdmDfVRJ3BFGIsg0Y3
   25wCMCt0Yru3nbyIVjcT4Y7E/8WJMOtONrjOisi4qRDQbv5fbhWThfPyH
   g==;
X-CSE-ConnectionGUID: MQqenG5IR+6l1cdYR4l5zg==
X-CSE-MsgGUID: maWQvJzFQmKMui96NWLmpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72874709"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72874709"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:16:27 -0800
X-CSE-ConnectionGUID: JPKKdjMFQvmrtH4K1PYUGw==
X-CSE-MsgGUID: iLa7SqL3R9yA04Asekn6ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253676526"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2026 07:16:25 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 8/9] Bluetooth: btintel_pcie: Add device id of Scorpius Peak2, Nova Lake-PCD-H
Date: Tue, 24 Feb 2026 21:04:47 +0530
Message-ID: <20260224153449.193551-8-kiran.k@intel.com>
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

sudo lspci -v -k -d 8086:d346
	00:14.7 Bluetooth: Intel Corporation Device d346
	Subsystem: Intel Corporation Device 0011
	Flags: bus master, fast devsel, latency 0, IRQ 16, IOMMU group 14
	Memory at b018378000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [c8] Power Management version 3
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
	Capabilities: [80] MSI-X: Enable+ Count=32 Masked-
	Capabilities: [100] Latency Tolerance Reporting
	Kernel driver in use: btintel_pcie
	Kernel modules: btintel_pcie

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index d903460bea76..b63b2ea9e296 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -46,6 +46,8 @@ static const struct pci_device_id btintel_pcie_table[] = {
 	{ BTINTEL_PCI_DEVICE(0xE376, PCI_ANY_ID) },
 	 /* Scorpious, Panther Lake-H404 */
 	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
+	 /* Scorpious2, Nova Lake-PCD-H */
+	{ BTINTEL_PCI_DEVICE(0xD346, PCI_ANY_ID) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
-- 
2.43.0


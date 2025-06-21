Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29CC2F2
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Jun 2025 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750487399; cv=none; b=SJ+atHrCbe26pUQm+K9NBaXIA0SIGEZGD2LFAoflMEX9ai5bAne9h9Q8JHGSK4GoVs5X0IWctg3tx9iBc1uP44mspMYtpg9+iDiWGMS4YIO2kYDpppZtXuLkOscHOmaPE4fGEnNNIweFYcJ+LPnoRY/l5HvSHnlDdctAUL0AnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750487399; c=relaxed/simple;
	bh=h9iU4Q7c02G1GWkTW8d7VEqwZQBhKJbDu+Rbnzk/vPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KvNDVsSbesoY50y/wB/zUMAmzHPHe9/RCK39UDpWMSNg0RLwkJDuDZoMm0nxgnyP7yh2Los+VSyWtUZoIP9rxin82vGqQobA3mv2EZueQo3H8dbRjYUjc0t7lNDcYoMST6QxM+aq74Get7KORFpXli0Wq3anKWzCDYULfonIMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6wKP+u5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6wKP+u5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750487399; x=1782023399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h9iU4Q7c02G1GWkTW8d7VEqwZQBhKJbDu+Rbnzk/vPY=;
  b=W6wKP+u5invXExG64iQETkBCvta0Gjm6V6V0VraylP6S8jORVu2LqcVt
   gVc75EG0+mB6XghR2sgztMcogRY9CCw4oXzqQnQg3lVx0xIXWt5aG6ZEi
   SpRBd5MX/qD2wtXrakjLEoLRSEqUVXusYt0mXrwhEAFyAUskT+MD2JDXr
   MKmHASpn//PIP8lC9YKY2UZfBfIpjRL54YBuqGixYV5wDcpaz+N1ordC1
   9LbVibRiFKSFDEdPv12zUVuKBQVXH2QKGTWvzTicqUxn4WwEi8VdksJ6R
   1zQIflJs9mW7U1v/VveRByG6lF9s7l9VPjHWKjNId4IUxepoXjF/JhFt/
   A==;
X-CSE-ConnectionGUID: 6fAkBnZcQ8mtEY6fPSqPcw==
X-CSE-MsgGUID: 37hpk3h7TzKWhb5aoiIpog==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63799506"
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="63799506"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 23:29:58 -0700
X-CSE-ConnectionGUID: 2UJnAnJKQiiIMKhVf93Z0Q==
X-CSE-MsgGUID: B3knEkehQNuujmgvPPTrag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="182126457"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa002.jf.intel.com with ESMTP; 20 Jun 2025 23:29:56 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3] Bluetooth: btintel_pcie: Add support for device 0x4d76
Date: Sat, 21 Jun 2025 12:16:31 +0530
Message-ID: <20250621064631.781861-1-kiran.k@intel.com>
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
changes in v3:
- Fix indendtation issue in commit message

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


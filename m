Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37017D346
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 03:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753413305; cv=none; b=ipb1D5l0SwXcSCw1K808UvQILw/qEAFvC8/2Y2z9C6sTduyWMTiHNpEeMFNj65lTzi5JJAmrPgEGCfiSqtwZoAYXIXlmo6d8gLGPRrmv3CzHrWjwJGm153VGuWgBGjNqs5nGRjhktFaZlVA4MVry0CuE3NM7JBUDX7HDCld7V1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753413305; c=relaxed/simple;
	bh=FQS0GDvClh4hKfi07Zxw3OSSlpooxVXK/kJ0kD/LnvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIdqlxyICBWJggH0o9j4Bjd5hae6btjKlvsL+MOc7tjGs8C31y/vNHHaqAeKUOXkRPkriekApmEEgFSkDQEU04BL1dTaNL2r3e2NMfZ4KYMGUfdBbILTeEL1/j9F+DtFUDPAu8vgHm80buRIz1yEUlSs8LFcFe3fLRUb35YR5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWtyPkPr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWtyPkPr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753413303; x=1784949303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FQS0GDvClh4hKfi07Zxw3OSSlpooxVXK/kJ0kD/LnvQ=;
  b=SWtyPkPrXwQtUaknU9/Nxo9YE2R2y4+KlBlwkK00KZCeJJtOPkyIQAKl
   ya7MmGHzEEs+nRkMxsU8c1jOCcz+ZJH2rmMYLHyOf4n4yq4QYSn5qZJpH
   7bBZ22ozk8pwY1eg756/CK/fm7xddtqz3QVxLHb1JTHwB8vRfx9deFGvQ
   3eJMEIgG/wmieaBu7uu2KVMqFIxhP7PmNR9X9rlVxJGEpTyh4A7djuHnP
   NXdh31TRobl7XMyoEzteBcZrRtBHhxRTEkCFEw43okEN9o2RdoYV6CHPV
   7MQCDyzuQX2KA9DJQMqQCtiIZecUVBaoi1/yLzNF/zVw8wUMyYkLs4C0L
   g==;
X-CSE-ConnectionGUID: eo3ORiToQse9tj2deht6kw==
X-CSE-MsgGUID: y3rhyDtoTFK+vmNxoP+Umw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="73325087"
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="73325087"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 20:15:03 -0700
X-CSE-ConnectionGUID: BOPokLIPRfunqmj22R5PNg==
X-CSE-MsgGUID: cF+GCIsVSbWAtcBD4UmL4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="165173681"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 24 Jul 2025 20:15:01 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btintel_pcie: Add support for device
Date: Fri, 25 Jul 2025 09:01:34 +0530
Message-ID: <20250725033134.1351301-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725033134.1351301-1-kiran.k@intel.com>
References: <20250725033134.1351301-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sudo lspci -v -k -d 8086:e376
00:14.7 Bluetooth: Intel Corporation Device e376
        Subsystem: Intel Corporation Device 0011
        Flags: bus master, fast devsel, latency 0, IRQ 16, IOMMU group 14
        Memory at 14815368000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [80] MSI-X: Enable+ Count=32 Masked-
        Capabilities: [100] Latency Tolerance Reporting
        Kernel driver in use: btintel_pcie
        Kernel modules: btintel_pcie

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 14d59d1353cd..cf0b77ba378e 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -37,7 +37,8 @@
 static const struct pci_device_id btintel_pcie_table[] = {
 	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) }, /* BlazarI, Wildcat Lake */
 	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) }, /* BlazarI, Lunar Lake */
-	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) }, /* Scorpious, Panther Lake-H */
+	{ BTINTEL_PCI_DEVICE(0xE376, PCI_ANY_ID) }, /* Scorpious, Panther Lake-H484 */
+	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) }, /* Scorpious, Panther Lake-H404 */
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
-- 
2.43.0


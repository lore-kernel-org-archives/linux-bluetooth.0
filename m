Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEF184524
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268857; cv=none; b=d0QfyhzjJv31+72Z/KOCR2iC0ygt84UUnKcalvz1Z0HGKzE2TEH7V8dutwV1V61965XDs5h2ouhnrKus+DjP7goy7zTkJxYFMKyF4/5gZmZn8BtJ6N1FIFbsEKpxHC508c+asFbwwOxossrtpfJ4dvYawtD6hzu36r/Luahv7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268857; c=relaxed/simple;
	bh=H/KvE4EwPlTyuTE/Ei7rx7DAVX+frR7DBBiVgXqWfAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWr1EBAhABY0SfGj3jpRyeAezGHj0+EP+0BOaFg/7As1AsPckfsg+IFgB5py/FVW8T+ySF5nen7ySWipC6x+SPl+xY16/AokIUG3PU5OhOnwhEkKnBhNKxHUXq/t70qq7LIQ6QzQZR0XydLGAPHbtxmcV2NKSf5V3xy0zl/ZQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsLexKSA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsLexKSA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772268857; x=1803804857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H/KvE4EwPlTyuTE/Ei7rx7DAVX+frR7DBBiVgXqWfAU=;
  b=WsLexKSA/7fVFP0gpJGjL632cFhljhoUC1Ca0bo28jeBICztKbNWJDOq
   qddpObCnum9Sv5lRAkosh1N4wkIOLcdPR+rmDDt5pqAx9U2kXxM2pTfMS
   oidUYNTmQc7arjluDL46SzgLdHfsDmUZxiG1XvMhI/t6xQVlGF91STms0
   /LariSe2LhmLqLOV3hzYr4sbbll1+d0dTCwCeHuWXfBUR9Mk09YDcWmT5
   VLXZAtZWgaVkeODSRm+yqxaAZGZ5Ggow4Nv8xVDpEHe+v+QSzphvHlkmR
   2RroZTROBrmo2GZTZ2/DB1a3Vx1NH8MUkvt38Gs4oq/DPdxN8C4q+/W7b
   Q==;
X-CSE-ConnectionGUID: 6RmItlAFTHaWfN0QfzJixA==
X-CSE-MsgGUID: uMCjFJsZTFWZaCoygFJBIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="77189246"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="77189246"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 00:54:17 -0800
X-CSE-ConnectionGUID: coM+ngXTTpG05ZzOnGn7DA==
X-CSE-MsgGUID: QISyJJqcS2yC5dQtom1R5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="221630162"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2026 00:54:14 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 8/9] Bluetooth: btintel_pcie: Add device id of Scorpius Peak2, Nova Lake-PCD-H
Date: Sat, 28 Feb 2026 14:42:38 +0530
Message-ID: <20260228091239.230284-8-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228091239.230284-1-kiran.k@intel.com>
References: <20260228091239.230284-1-kiran.k@intel.com>
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
index 058ccb328112..7aef219770e5 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -47,6 +47,8 @@ static const struct pci_device_id btintel_pcie_table[] = {
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


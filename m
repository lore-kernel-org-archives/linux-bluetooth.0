Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B941D63C7
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692564; cv=none; b=Pn9LnTZuPoqGB24SSjVF3PCoXN4qxcNABbdW8MYfdEMxXbWVcczpJMiRrZ37wSHfsbOGbshNGfaJjzqqnXzWVgjh9ovsg8nDh7j+DYHUCUhMumvacZeMLQ3qqh+7hC4joyfH2IIkR2F6GXEZPApiSGMvLwW8VoK96AN97ycWAKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692564; c=relaxed/simple;
	bh=FUnuFAHi2HPtV4ApXB31LJC6fzSauuVrmoXjzaa+R08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n69uCpczGIdasdcCwt4lfEvwS2VeIQkGO/2cVlEyskwcSxrcIW7xb5tQaqJCN7K7B/QbVMBch/j06i+Mknrlglki/kyesX8fVpFVPZ67lXaC6/tfjHwsQThf029FKCKrKqNAy+pN1oxO5dGztuBWRwnsR/wL6DOLGuiUsHA2IoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSpY+lZO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSpY+lZO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753692562; x=1785228562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FUnuFAHi2HPtV4ApXB31LJC6fzSauuVrmoXjzaa+R08=;
  b=jSpY+lZOFIkEZ1LQKm13uAfLBORIbsNHlDcVbmV3XvzBBLtSxpZ8AQy6
   1V4f3+er/GjILgzLjG3ORXZeDsbUMmGZO6pf4AMq/NJdU71uwz72htzN3
   CrXG+LbOpCK9D6fEMCkUVgj4LBWyl2SwflvAy2xyBAe2kO07WSZm8CNI3
   ZgllKqkJP0KKe4rZfC9/ar1+t9Gg/7sBHC2MiZzdBrY3JQVP4y1MtdaPC
   nvXCUv0jRCBA+Uzk6UoFyZNdunHk0q5WBSbzRuiBx5IaMyAHxlAnCYJJK
   K5KZBSu1WvE1vqafyWAGn57PE5Cz7r56Adj9I6sqyV5t2A1IZizjg3UNq
   A==;
X-CSE-ConnectionGUID: 7yvGuMa5QDm+4vcjzXxOKQ==
X-CSE-MsgGUID: a6DkMTU1TFSnMH/Ly2/q0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="66504894"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="66504894"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 01:49:21 -0700
X-CSE-ConnectionGUID: Y3A7cOTXQ8qPAbA3IbtzHQ==
X-CSE-MsgGUID: B1jYi9onQxaC06dlxTY5Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="167770822"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa005.jf.intel.com with ESMTP; 28 Jul 2025 01:49:20 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2 1/2] Bluetooth: btintel_pcie: Add Bluetooth core/platform as commnents
Date: Mon, 28 Jul 2025 14:35:53 +0530
Message-ID: <20250728090554.1425120-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Bluetooth CNVi core and platform names to the PCI device table for
each device ID as a comment.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v2:
    - Update commit message
    - Include reviewer name in commit message
    - Include the complete platform name in the comment

 drivers/bluetooth/btintel_pcie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 8e65def192a9..8f02c27bc544 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -35,9 +35,9 @@
 
 /* Intel Bluetooth PCIe device id table */
 static const struct pci_device_id btintel_pcie_table[] = {
-	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) },
-	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
-	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
+	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) }, /* BlazarI, Wildcat Lake */
+	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) }, /* BlazarI, Lunar Lake */
+	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) }, /* Scorpious, Panther Lake-H404 */
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
-- 
2.43.0


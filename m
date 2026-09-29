Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A8339394
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662856; cv=none; b=bENbjibqsCL/+OAOjUK1dw2Xtj1N4tuxNIC8ZAAunQNiGYgJvoOkppSNBJJ7S3yOvYuhEmv8YcsThQzFKt4vrJT/px+oddPmlt/DDLIylGCxA8hDw9qOztfM47uYtp62U3LalIuniVnrwDyrssor6cFX3BuSTq+HZ17B6qNYTV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662856; c=relaxed/simple;
	bh=mCvrLJ/AcMXIgexXdV30ziyNMD4/Yt6U6Evjgc3/Y2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NihACWfyGRsrhrGz2kEzOyYGBnh7lKzgEaRjK+OvaygzJJqjOy2OGcl2k+9ul5AVYLy+TnSCecXhBMk8UObyBu/8BzW8kCPNdWXV2YN2rJ8e51aa3lPbZlfZeVBiXtadAijXk5f2oQ6iq9Q/OZyFWJC5DinPTpxW/G+pP+YrfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIJp3fjK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIJp3fjK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790662854; x=1822198854;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mCvrLJ/AcMXIgexXdV30ziyNMD4/Yt6U6Evjgc3/Y2E=;
  b=HIJp3fjKGVZ3nOEZ8jPKiUh+J/r0qXgZhWljp8UjEGkBUm8hTlRLx+Yg
   o2A/2zfJ8bXyWuF/toxQYOqgFrmFbJ78v3fBl8CodI1stgldlwhcq+HrC
   Dg7oomzAPiZfokSakAb3yU+tMOFVCpwZbRWvmh+FxJrBIXL9X+qX8xHJ9
   y0p4giyG4FvlzMPPx4MSOiQrAfPkAx78L2sbqHe7CubnTWLPA23+Pt7E+
   eMu/ZFKrm8KJaop0i7nKVZM7T8Q+esz4PJ81wcSq+/aE4QEscJuCBF4hx
   Wm1eSBTJAG5CUCm5c+e0PaqhE1XgN+T6yiFEpfDMCgtaiHklkViZKNni3
   g==;
X-CSE-ConnectionGUID: 2y3WOYjCS9yqas4AiBMj9g==
X-CSE-MsgGUID: REMbxI/vRrSS9n/sxfJ3Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101943381"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="101943381"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 23:20:53 -0700
X-CSE-ConnectionGUID: HU62sjN/T1aCO56cVSJx1A==
X-CSE-MsgGUID: DG+Vk0HLQUSa0txsD8cVag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313215255"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by orviesa001.jf.intel.com with ESMTP; 28 Sep 2026 23:20:53 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Add shared HW reset for clean start
Date: Tue, 29 Sep 2026 11:42:33 +0530
Message-ID: <20260929061233.204406-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reset shared Bluetooth hardware after mapping the BAR and before setting
up MSI-X interrupts, so stale device state is cleared before IRQ handlers
and interrupt masks are configured.

Propagate reset errors so probe aborts rather than continuing when the
reset fails.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
-----
v2 changes:
     - Added Fixes Tag
---
 drivers/bluetooth/btintel_pcie.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 84a6cf2f4920..6cde68ce0304 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2876,6 +2876,13 @@ static int btintel_pcie_config_pcie(struct pci_dev *pdev,
 	if (IS_ERR(data->base_addr))
 		return PTR_ERR(data->base_addr);
 
+	/* Do shared hardware reset to ensure a clean start before
+	 * configuring interrupts.
+	 */
+	err = btintel_pcie_reset_bt(data);
+	if (err)
+		return err;
+
 	err = btintel_pcie_setup_irq(data);
 	if (err)
 		return err;
-- 
2.53.0


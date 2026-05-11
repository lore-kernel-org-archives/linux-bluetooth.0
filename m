Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C240A3A4F26
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504911; cv=none; b=OQI7gJICK/6gGdsBSOD2Ai4cTEKI6mns+HbmYLeKdTTOT82dSIbysXKsNKoH+mIFsp0KttTePYR1OdvnBbup2NOHwgDC9i3A5RYH/LrZ87ylYzWvvgcJuSsY8MM/YROYHtBWn7+31x1XDLVCsAAKyw4LjQBBdI0R2YOs3o97dhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504911; c=relaxed/simple;
	bh=JI6WN1VubWt0CM3oFGCbwDoz6Ynb2vWPWQlt+zoAoN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=przfjytz8dcrkVfR+jGFMBdnycmLOsqMPnfv2G0mZMBxXfulIx1Va5a09nmrWNW9DUh4p0TXHuEqaTSs+OajZ07RNU7RC85ZqzoCSA3+B4PnugqcOpH1vYtnTfgF6AyFdecw30GSWOxrX7IYqSTjGslyQhAiDT15r6M5uKN2TgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hf3Tt/BQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hf3Tt/BQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778504910; x=1810040910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JI6WN1VubWt0CM3oFGCbwDoz6Ynb2vWPWQlt+zoAoN4=;
  b=hf3Tt/BQ/CBftnG/Yq3EolRdX+34gCSNV5eod5ps8AUnm1S/l/1E140B
   JgCWCcSFxQljtBNjzV8/zOz/ciqZ3qPm60Z2hzNQ/EG+bKhLs+gQ4Rd9U
   yZelFgbfHqpLihlx+dlAeVqPhjkLRcNRxkAOdCKwQftOXW0g0kMq7cw/k
   ehY3vdWoTwQ7N4H8oBOj2To86QZebDxN5tgGMveBM4okwmKSuSIfN1rTm
   Z25JsMrVVka4yWdU5zyc3SpW7fXBSfEBFPe84HKv31ZOTvqW3Z5Zw/WZX
   nu77sz52gqwM2FdXNiopEbjETTiIMly/httN2/SWzFF3H1Q4O10iTlJuo
   Q==;
X-CSE-ConnectionGUID: 3r5W4nPUS9mkzbJ7BnnFSw==
X-CSE-MsgGUID: JbJ/+FKQQGCRodD+ocNpfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90856083"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="90856083"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:08:30 -0700
X-CSE-ConnectionGUID: rR+jdTPYRT6H0tXMt1FZpg==
X-CSE-MsgGUID: kYq92WOWQMaI+IQC21XAqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="261190124"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa001.fm.intel.com with ESMTP; 11 May 2026 06:08:27 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Reset controller before configuring MSI-X
Date: Mon, 11 May 2026 18:57:11 +0530
Message-ID: <20260511132711.1216139-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>

Perform the shared hardware reset in btintel_pcie_probe() before
configuring MSI-X so the controller starts from a known clean state.

While here, move btintel_pcie_config_msix() out of
btintel_pcie_config_pcie() and into the probe sequence, and propagate
errors from btintel_pcie_reset_bt() so probe fails cleanly if the
shared HW reset does not complete.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index fda474406003..6ff08de9ec78 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1646,9 +1646,6 @@ static int btintel_pcie_config_pcie(struct pci_dev *pdev,
 	if (err)
 		return err;
 
-	/* Configure MSI-X with causes list */
-	btintel_pcie_config_msix(data);
-
 	return 0;
 }
 
@@ -2659,6 +2656,14 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	if (err)
 		goto exit_error;
 
+	err = btintel_pcie_reset_bt(data);
+	if (err) {
+		dev_err(&pdev->dev, "Bluetooth shared HW reset failed (%d)\n", err);
+		goto exit_error;
+	}
+
+	/* Configure MSI-X with causes list */
+	btintel_pcie_config_msix(data);
 	pci_set_drvdata(pdev, data);
 
 	err = btintel_pcie_alloc(data);
-- 
2.53.0


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568281465A3
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864456; cv=none; b=iG0mdar1URGaTEod0pun7lB7MAM3Ye/8WeyjieUFz/ZKeilBOyuLMGIlJlMuXyuU6mqxk3b7jGDTTLcmI1oqD7rtCH+wZJ6eM6fMFcJZO7thEM1Fa7EAGIWKtXOO5ZztDr5pPOw+nsxFg7D4wviupKtDT7zCukXEpQ24yRoLGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864456; c=relaxed/simple;
	bh=nkCyRO4jkYn3c8ngYpJkV5ohAAjLZ1vlieH2SqDDF18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itCbGAWl0uBmrXRehn+ePzoCFz1IOiQIc0N0idiSIRS0Vev0pGlzmLPWE28xcsYCDA7GjVTBEzf+Jvum9NLPmPI2JpKxSe3XT+ILJ7sOWgceVDnj+jK3/srWyF6unLND6L+AMBYOR5Y89FMYAmtsSR2/S5nOONlhlpKHHmtguxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihMqfx2N; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihMqfx2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715864454; x=1747400454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nkCyRO4jkYn3c8ngYpJkV5ohAAjLZ1vlieH2SqDDF18=;
  b=ihMqfx2NtguPcRMeqJyrsvbUMMnbImmM+FDXkw0rcfyfoRUij+qjK66e
   F/gz059eBIg0NfmJlMVRdeGtZ4mAoZfG+Etm8YhKciYuGS8WKuBpNbihf
   AMqqKwwKFVFFCPUzFAlVLbVepi7MNqj1rNaG/kofpmH8bDu7WLnFF+pAx
   +msC7xu1gpOTs80xxzaDSNt65q5njnQ6AKhPDs1PcB+MhLx5VpxALRhyZ
   fKF3C8GTOAIwHzafGzJBxcYyUdDD7+Ghy3wJjmEaC+uxr/L6Khr8Xd/tH
   j4IRacX9KR80b9eRa0aI5J0BicSqRti6cn2/Rrmu54mLJPk1jJPmAFDLs
   Q==;
X-CSE-ConnectionGUID: 1QJ1p/YtT6CItqc4u+/JRg==
X-CSE-MsgGUID: T32O36tXRYu2ja1gsqkf6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23108539"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="23108539"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 06:00:53 -0700
X-CSE-ConnectionGUID: xJ6SNpgiR1qQ8HbkWFCWYQ==
X-CSE-MsgGUID: NstKWZ2nQ8K9ojxbwE78LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="54623616"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa002.fm.intel.com with ESMTP; 16 May 2024 06:00:52 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	vijay.satija@intel.com,
	Kiran <kiran.k@intel.com>
Subject: [PATCH v2 2/3] Bluetooth: btintel_pcie: Fix irq leak
Date: Thu, 16 May 2024 18:45:09 +0530
Message-Id: <20240516131510.904787-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516131510.904787-1-kiran.k@intel.com>
References: <20240516131510.904787-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiran <kiran.k@intel.com>

Free irq before releasing irq vector.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: Kiran <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 8d282ee2322c..d8f82e0f6435 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1329,6 +1329,12 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	data = pci_get_drvdata(pdev);
 
 	btintel_pcie_reset_bt(data);
+	for (int i = 0; i < data->alloc_vecs; i++) {
+		struct msix_entry *msix_entry;
+
+		msix_entry = &data->msix_entries[i];
+		free_irq(msix_entry->vector, msix_entry);
+	}
 
 	pci_free_irq_vectors(pdev);
 
-- 
2.40.1


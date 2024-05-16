Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC604145FE0
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862316; cv=none; b=sBdS/vFhYcHknGhN17PEta4WK6f69AVUXLJVRzHlw50W37XFjfTULGPnFSQTqXcLC5t1VwB26nYtuYpLHI1xGWz6UqtTSX5AmbJtMdzm65AcKqdSDI3vRvFKg8CAhD30i5bcJHyKLzH80igMer9qpPft4/8wMK1nWhsROH6+FDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862316; c=relaxed/simple;
	bh=IUcCbclcqeUC91mwJjsGY1jGJw/BBIqKtTAQ7C6QwHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cJfZ20prV+jsByCszy7lMDIDdAxczWkghHQuLyxqQiHJ3BOYFWQDS48c7rD7Dr8RFNIpf9jo5l+Icty1OCXfJdQb4H0a4NSuq9QCFrM2ZGAfL+lk8YsOunOOXvWtH0R/E6fLCh22qCcsQ22eqGY21nwjrHyXwYlUVAbkGpPOt6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikBoOZHK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikBoOZHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715862315; x=1747398315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IUcCbclcqeUC91mwJjsGY1jGJw/BBIqKtTAQ7C6QwHA=;
  b=ikBoOZHK0oUC3y0P+rOHWdcNxEmR0ZusZ4nXQCfhsoWtDv1zZ/thfWD7
   QBaZsvllaYs9rSmoAfrCdv+r1S0gQb61Ul6Ve+YpCZflzjQ0O94EF6LGM
   kWEVSWVgthhr6APhgXzWhuzaw/XFk4FE8e5kDHk2xaGb+WvlQpkihR6AP
   idP+gkrW1wbjGduVZYDYH5hQ04xlbm6L1ARoY/gAZbVnauD2OLHgTHeu5
   RnuWFQZN4jkD+Ulr7F8ctGYmMoRCO6nq4dNxeOgBBggI4ANFJ8383iQkA
   HEz0eiAVrgWss43X3uk6tE3HTczeHsNLnJO1cDp1Hvxc015JuVl1UfQGr
   A==;
X-CSE-ConnectionGUID: X0tCd/y6SFmyX9c8SigeXw==
X-CSE-MsgGUID: I400cUfSQ1m6iHIIVCEUyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15790875"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="15790875"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 05:25:14 -0700
X-CSE-ConnectionGUID: eeO+zO5mTaWsFXydAeb4YQ==
X-CSE-MsgGUID: HBaHm1PMTsSo7OUKKXmJnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="62246357"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa002.jf.intel.com with ESMTP; 16 May 2024 05:25:12 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	vijay.satija@intel.com,
	Kiran <kiran.k@intel.com>
Subject: [PATCH v1 2/3] Bluetooth: btintel_pcie: Fix irq leak
Date: Thu, 16 May 2024 18:09:37 +0530
Message-Id: <20240516123938.891523-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516123938.891523-1-kiran.k@intel.com>
References: <20240516123938.891523-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiran <kiran.k@intel.com>

Free irq before releasing irq vector.

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


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F42561D
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938831; cv=none; b=Tqb1zm1jZHqJcd9i/vPahVLCsldXsRxH+o+nyEiWvn+6T52axJl8x1Gg8QUFAyIei9vPuYO9EUbQSarUExGXG3YvTuavysj5qP0V2ZoTW0Hd9112Jkp0xykweU3q9jYCa+YLogssQRmb6RA3zhFhRrbiECC+R7dvctY7KZ5prnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938831; c=relaxed/simple;
	bh=r4l/mTS+Vd9XiXbtciJInuK5e3zeGDqb618TRLJZS2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jsLVAepibMcygtTEcl4grCQJ5wlBfoyN4W0i+jhgqosBDs9sYud+PzrfIHzQI+CXDtBQmNKj4xWo/tU2eHhJRILZvt8yqGSrsbXArm6AhM1dql8RPHri+FkMnrNnpcAnq8S2FfkNjV+5xkf257aKzknWjeaLBLR+EQoM3RVd/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PY83nQLo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PY83nQLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715938830; x=1747474830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r4l/mTS+Vd9XiXbtciJInuK5e3zeGDqb618TRLJZS2s=;
  b=PY83nQLoSnfoc8F7q5khQSwGAjq8//Bpleuy+hGJp6d8nGh86NHbc4uV
   pTfaRifQbUz0aMZ5yrHHtq4EWBxPEp8kIQBFGTWU2Tk9T0wYo0NtC0RO9
   uYqQv2eswRGczLEWQ7dDKUxOGDu7cUSN/Otxb1d7nESIgknrBNV6sYzBT
   J2JncKW+DJLKLGWo9DhEX6KRG9Uf/yAbCof2tzrRkZEYqiga0hzIr/xaA
   mWeYaCz5p9Ddng2jKRhkBaNgzla1k5NZ6PBqnHe4z6DH4xJL3g5YNoAR6
   WmRDrfxWk43GIKXl+7vqJ+xAZVI4xCCe4yKxlMIJYLk8R1aY7lJMIiJxB
   Q==;
X-CSE-ConnectionGUID: d1V7eEmsT/y9J7VNkm0b5Q==
X-CSE-MsgGUID: xWG9voB5R8KZ+NIVBIhhZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11976643"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="11976643"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 02:40:27 -0700
X-CSE-ConnectionGUID: 9pTeSyODSiKqO6nJr08Zyg==
X-CSE-MsgGUID: uQNantj+Qx+Je3gzlGqo/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31676452"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa007.fm.intel.com with ESMTP; 17 May 2024 02:40:25 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 2/3] Bluetooth: btintel_pcie: Fix irq leak
Date: Fri, 17 May 2024 15:24:46 +0530
Message-Id: <20240517095447.956132-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240517095447.956132-1-kiran.k@intel.com>
References: <20240517095447.956132-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


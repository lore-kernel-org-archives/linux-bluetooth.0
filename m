Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4C424A7C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737026500; cv=none; b=WRhIB3/UOX09bR+e+q4RLtl8M4WzF7swoh0L5OAb4XRSRlREDETKyzMeOZFhDhxO9OE0OJdUwapLUZn+CeoalYjjfHMVhSRAGGldb4nICrvwFuUju2z2i8Ofwfwqj240MbiomCXo4oGfDLtos6IWETRiYM9AY5d3QYs2vMPF9MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737026500; c=relaxed/simple;
	bh=Hqt/VrAe+g4W2sxlDXOEfi9pMFNilZUFrM3Fa4Ib7v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+NDwKcgGJkA5ImYs6Rs/IUDul4pSHTQybqw/qLUELsfGGkOy2ZoJp0vxLShd6bDoSIsuwrq4dwkp3JOj8sABeY3AaD9uHTljMIj9Y+t6Jm1kQBY4yIiEha33N4XBWsiWfFiuEl1HiliEsiVbfstVlspYVno6Hlry9UpQ10j6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8o5pJn+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8o5pJn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737026498; x=1768562498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hqt/VrAe+g4W2sxlDXOEfi9pMFNilZUFrM3Fa4Ib7v4=;
  b=H8o5pJn+AJa6LFzWJ5LG/c11XFDmjdbjx6vW/opB8mKrKqBHgRpi3xkh
   88VbSOUEg3pWaCyCCfptNrk1/j0deUM5cNL0O+guvTSx7Pphv/ex3CxRm
   onprSFe5HaQu7duo3uavAn/1GYcwuZ/nfyX/JeDu2dFQgkLlBCyl+2ZTY
   VHP9qz5a5LxIeqAR/nzV1uAzPqxxCkO7vlJqHEAXm9yXSLY8KWSFTAzw0
   4hIzeOeVOidoJJyacnQh80KguFX+K+2cXYYbzXhnp8M2sJWTZqJnJAu5k
   1IF2ZO5sfaeJ1Tz2a4p3THm6FSli2lVMd9RBh55J3Z3CGGv7F0zrjMmMF
   A==;
X-CSE-ConnectionGUID: wMVSAh5cRWOxPhDD+9Wt5w==
X-CSE-MsgGUID: JnD736QLRDSVDzWTq49KSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="47995659"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="47995659"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 03:21:38 -0800
X-CSE-ConnectionGUID: 6WS0ypjeTO+qrhGnKIKTSw==
X-CSE-MsgGUID: nVFf4LAYRe6CA8OWMZbr1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110439790"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa003.jf.intel.com with ESMTP; 16 Jan 2025 03:21:36 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btintel_pcie: Add device id of Whale Peak
Date: Thu, 16 Jan 2025 17:07:09 +0530
Message-ID: <20250116113709.566498-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116113709.566498-1-kiran.k@intel.com>
References: <20250116113709.566498-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device of Whale Peak.

Output of sudo lspci -v  -s 00:14.7:

00:14.7 Bluetooth: Intel Corporation Device e476
        Subsystem: Intel Corporation Device 0011
        Flags: bus master, fast devsel, latency 0, IRQ 16, IOMMU group 11
        Memory at 11011c30000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [80] MSI-X: Enable+ Count=32 Masked-
        Capabilities: [100] Latency Tolerance Reporting
        Kernel driver in use: btintel_pcie
        Kernel modules: btintel_pcie

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 3250fe6c9f4c..63eca52c0e0b 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -36,6 +36,7 @@
 /* Intel Bluetooth PCIe device id table */
 static const struct pci_device_id btintel_pcie_table[] = {
 	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
+	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
-- 
2.43.0


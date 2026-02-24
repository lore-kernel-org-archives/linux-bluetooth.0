Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1B3A1A2C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946190; cv=none; b=fM3MvKw6p2vTCoaWgSNCoPRNc7coRm0G8FusDgWEBfbkK9E7XSApqJURopIDDeSwsB6DE6dshgVv9azlIcaX22uADmMSYSTVamLsn+VxcPlmOWjXbkE5TZWC4DqmrGdFCIzrmsP87/iDVqZ5ZzHNt1apIcqGj2yMbG6cblaPdiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946190; c=relaxed/simple;
	bh=mZS8IcLZB8uqmpbvEZSQhb4v95EuXqeQqY7tOkpGOgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXtDy+Bob4AGTtNQOvcnMuC6c1C4wnM5fpVjXMImsQIjnUFckVLYSC/p6F0JA9+Snxtfpw1T7Ic2d847WpmXTIFE9cnipELdk8GyeTlg+R3Zu6UEG+1wHpsowexLppD6+/el+QHiOSHaTetfbuAWVdXXHrbEmyHiWIfr2CsJG7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOx1ifhB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOx1ifhB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771946189; x=1803482189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mZS8IcLZB8uqmpbvEZSQhb4v95EuXqeQqY7tOkpGOgU=;
  b=HOx1ifhBf2W4nLjC+SFoOelmLDu537LnUtBX+e/RP0sSvxwZmd12C1wK
   eFzCxfyrMDIukr1GZsJ44JoYAol39nXIYJm0Pi36OzBiF51flWhhFBTl5
   NNdNMrZEq7P7B3Mnvjo6Q43gbev18IwGbOshIMF05wWg6ML18eNNeG1JJ
   ipyjw6W8kIarBmpR2QDGl4DZ1TMLnXgl493SmHmvfzXlaPC1frcM1EhzR
   hpjrbr09gHOlrHhXb5b3WtkVlBoLppm8/5sUv24QykbJOAM6YNUkqZ0ng
   dnq6DeQNB4FMIRZlfuyuvogcBuFs2tSqbXzf8yyk1mdatO473Qq6r0rc3
   g==;
X-CSE-ConnectionGUID: v5MavujnSbKwOU1CdgU9wA==
X-CSE-MsgGUID: h3/LD0S9Qn+I/LoFZjljqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72874711"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72874711"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:16:29 -0800
X-CSE-ConnectionGUID: PDOEzDizRq+KC0SNywkhVg==
X-CSE-MsgGUID: 9g3dzH1aT1+lOK77onF6Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253676541"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2026 07:16:27 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 9/9] Bluetooth: btintel_pcie: Add device id of Scorpious2, Nova Lake-PCD-S
Date: Tue, 24 Feb 2026 21:04:48 +0530
Message-ID: <20260224153449.193551-9-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224153449.193551-1-kiran.k@intel.com>
References: <20260224153449.193551-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sudo lspci -v -k -d 8086:6e74
	80:14.7 Bluetooth: Intel Corporation Device 6e74 (rev 10)
        Subsystem: Intel Corporation Device 0011
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at 200002a8000 (64-bit, non-prefetchable) [size=16K]
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
index b63b2ea9e296..e19b2c7750f1 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -48,6 +48,8 @@ static const struct pci_device_id btintel_pcie_table[] = {
 	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
 	 /* Scorpious2, Nova Lake-PCD-H */
 	{ BTINTEL_PCI_DEVICE(0xD346, PCI_ANY_ID) },
+	 /* Scorpious2, Nova Lake-PCD-S */
+	{ BTINTEL_PCI_DEVICE(0x6E74, PCI_ANY_ID) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
-- 
2.43.0


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A513FEE
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716760; cv=none; b=caQmbQSzmOs486DOMEOr/eZp8r20eX/UpfIAAVWuB0yST5Hv/dZxUAcajOKLtBI3kbydcCckNKOhuMPSTBD52Z7g82wtRU90R/woBw8VNbb2U5ZkFvyHT+SkB1ReKi9j8qsOjZ2jKxzg3VOj2i1pgA9VYjyzS1bXmWq4FMxHO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716760; c=relaxed/simple;
	bh=rseOZvbBEk2jKf3101CvrWf2n43WlkPmkGJPP8j6jWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTfsobkAAl5Yd+K8GGv1iJbS+E5uxFVkmqpR8IgYvA1++5tlVODEgmjCK4uCOdezvCs6wh2bkHzjka2rKgz0Y/Pom/qctputzoHihIA4IIutyhyGoouH14FElwLjYlrc9IDyY0YTPHbtJFS2CbqKewpolqyIUyw5CnviuSYt+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGMLlvjK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGMLlvjK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753716759; x=1785252759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rseOZvbBEk2jKf3101CvrWf2n43WlkPmkGJPP8j6jWc=;
  b=CGMLlvjK3sKvbclKcM+SKg754EO41nhAcUA6NSgCEffUMYypdd8XRH31
   JMzcfolN9Cr50HsoYmrcZYc1j/HTZgyTp3d++ITSss45aU5+JcO6CFN6V
   mj96MLRmXHk0nPbhjzvi8aAmFhK0NWw3dul/na5d5CTaNhfG0VADCG76i
   5Ow5zPrIVk0RTbmtidVj7LEx/gTBq0WdckOkapP6ew7KozgnaniooNZCU
   OLCPvxqlrRGlpnOqfiqf+/fzUVhjt1yCNIaz8dHlI5V2p9DT0X4OWqLGO
   skADvgFn3fDy/2MIiU+r150O8HVjd6nGDjScl7kaFDcjfxJncEXBoNlfx
   w==;
X-CSE-ConnectionGUID: YrPKihiRQceLVW5wAUcwOQ==
X-CSE-MsgGUID: VkJDYXKbR46ESKkuFe31Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="56048082"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="56048082"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 08:32:39 -0700
X-CSE-ConnectionGUID: XZ1x2jsqQOKCglZtirjggg==
X-CSE-MsgGUID: DF1sCjNdRLGNT0NZX3jdNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162316868"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jul 2025 08:32:37 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3 2/2] Bluetooth: btintel_pcie: Add id of Scorpious, Panther Lake-H484
Date: Mon, 28 Jul 2025 21:19:09 +0530
Message-ID: <20250728154910.1428086-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728154910.1428086-1-kiran.k@intel.com>
References: <20250728154910.1428086-1-kiran.k@intel.com>
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

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 8f02c27bc544..c0c3e17a4fa4 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -37,6 +37,7 @@
 static const struct pci_device_id btintel_pcie_table[] = {
 	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) }, /* BlazarI, Wildcat Lake */
 	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) }, /* BlazarI, Lunar Lake */
+	{ BTINTEL_PCI_DEVICE(0xE376, PCI_ANY_ID) }, /* Scorpious, Panther Lake-H484 */
 	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) }, /* Scorpious, Panther Lake-H404 */
 	{ 0 }
 };
-- 
2.43.0


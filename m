Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46986288C25
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250783; cv=none; b=nuoE4biDw5Tx+ai8aRMAk2DqdWIT5GoGIf9I45R2xBg1dW5d6bQp02AzHr9G5cKzn27NM8B73jfxEUSiMIOTTwC0GH20dkrnKXKIWZCXx81jwh/+J7SqclyB0uSAGYDa9KLUmD4BukpEHRMYTm4RLdg4Nl1yBTJlu+hfxnSwytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250783; c=relaxed/simple;
	bh=7Mk0JSSs2PvlP2a6M5+CsIKw2CR9loAgbRANbpcxGfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cSQwIXikNe6Q3Km4lVKvgb9itYTO2ah3NFa+gL5HOF+YCttWIci1EMO+IkRzBHxumpDsTO1hKDqm7UN6wVAOJVQHkncHHmr2+5RNI0kn6QLmY4iHoqAe/dzsGQLRYD7X+TLDdywxD0NXSyKst6rFH8VSZyq5ZUcqlYw1dFn0mpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fj/FSlSz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fj/FSlSz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750250781; x=1781786781;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7Mk0JSSs2PvlP2a6M5+CsIKw2CR9loAgbRANbpcxGfQ=;
  b=fj/FSlSzDLtNTNz566TuFXvmXh+tX+tAgfHy2KomYr5UrXd0mkRsD+Fp
   OY+wA8RHAapuLUL4GrAKTvRMyY9tkgdz0NvWQA+w7TQ8tVAEE1NINAK5w
   ezzsfu3ym2LaXrJj87gUfmkFnVMFjN3YA8FGXTojiFTNGrAz3NnRBEYmo
   HmqnMGUbf9418vQBii/BWJw89PZVOtaUPbkS8gaXvoMAmsrcLTpkwYmv5
   cP2geiuTDpOb5vE7WxitpfEiqRaVOjcxe6a+IuJA7bwNrKbMkFb5t7N62
   ptQy5Drudoj1mnm3l75qKbj0ta314LOhFrQONF2bMQIcOAl0ITLJnwoCV
   Q==;
X-CSE-ConnectionGUID: rN+p9P6tSqWudhy5DUpsjg==
X-CSE-MsgGUID: 1iw34FAmTVaqiBcw+ycWkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52384641"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52384641"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 05:46:20 -0700
X-CSE-ConnectionGUID: pHDcxLv4TkSGHTXScdkyHw==
X-CSE-MsgGUID: QAlT55ddSjyWyoIElmwO+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149336654"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 18 Jun 2025 05:46:18 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Add support for device 0x4d76
Date: Wed, 18 Jun 2025 18:32:51 +0530
Message-ID: <20250618130251.774085-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lspci -v -d  8086:4d76
00:14.7 Bluetooth: Intel Corporation Device 4d76
        Subsystem: Intel Corporation Device 0011
        Flags: fast devsel, IRQ 255, IOMMU group 12
        Memory at 13013328000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [80] MSI-X: Enable- Count=32 Masked-
        Capabilities: [100] Latency Tolerance Reporting

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index cb3cf2b9acea..1113a6310bd0 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -35,6 +35,7 @@
 
 /* Intel Bluetooth PCIe device id table */
 static const struct pci_device_id btintel_pcie_table[] = {
+	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) },
 	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
 	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
 	{ 0 }
-- 
2.43.0


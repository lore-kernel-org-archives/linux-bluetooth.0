Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30254C651A
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 06:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058370; cv=none; b=ds39egT3ZCuf5kmEwIXaC6nvnsJBniZh7Vl/pUXBNUflC8T1JpXJkGl9zTnrzzA6bhJ+21ueN47Gv/57kIKEY1S9E6xgMYk1gzMy7J8lUGC3nxcvNb95lyxDwqDLpqv2p0iFi79hUGIhTxZ1wetSYkqEMahHgIHygRhtuJPrT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058370; c=relaxed/simple;
	bh=RebVCZjQkvccGysAHel07QZm0fu6a9Vz24IMz03gOGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WlPI45KvmjocyU7LplHMPO1aachc7zUyqy/+xz8dssZ09TELodKugyyytSNoELpGIJVdCxh4kBlgadu7OizctBW3TX1UA+DwDcrfjDQPjr4EypnlLPVDC6NAZwWfJ3H9yHp0ZpmBPETBoKseF/1tSdz+dtkzd68yjCc9CFNERFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTbkv4de; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTbkv4de"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790058365; x=1821594365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RebVCZjQkvccGysAHel07QZm0fu6a9Vz24IMz03gOGQ=;
  b=lTbkv4de5xrtWy0dCh2YmQJ94IVxtWVIOu/zdQbe+kUQEsAd0MPPmQlQ
   PSthRs5Xv6vY5LkJnnvbZn0qO04ZWEGqCZvaWO2GrAeoR8zvq7n/iPkJZ
   v8AGOlM5xuXxSmoWCPjxsxLjlcKJy5EBllc5s0sFRmMXqpPat5Iiv8i9W
   +vQNpABlX1j6TjILsfq+D6CztrexQRBiA+m9+qvz8UTyJfK7LNOKR7rT4
   jJuf+YeRcs5yuVaV8195RwrGPnZsE+puE0OEulKnD0KLitomKssH8Lqhu
   NTcBBkJXqIV8atanOVIs7cPlae+UmGz81u9bHxYICAKSMSLwwVyMjm3TW
   Q==;
X-CSE-ConnectionGUID: GoFinXqxSGCpsilEQLpkrQ==
X-CSE-MsgGUID: KEnp1fq7S/iXyFf3vXyW9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101294858"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="101294858"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:26:02 -0700
X-CSE-ConnectionGUID: xZywf8ULROGWGYu0SJ61Pg==
X-CSE-MsgGUID: +GJ8rh5QQ/OPQTJslynF3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="277775604"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa004.fm.intel.com with ESMTP; 21 Sep 2026 23:26:00 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1 1/3] Bluetooth: btintel_pcie: Add support for Intel Draco
Date: Tue, 22 Sep 2026 11:47:44 +0530
Message-ID: <20260922061744.20192-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Device ID for Intel Draco support

From lspci -v -d 8086:2731

02: 00.0 Bluetooth: Intel Corporation Device 2731
        Subsystem: Intel Corporation Device 0012
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at fe000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [80] MSI-X: Enable+ Count=5 Masked-
        Kernel driver in use: btintel_pcie
        Kernel modules: btintel_pcie

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 444cc50174fb..cc474694b9ba 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -55,6 +55,8 @@ static const struct pci_device_id btintel_pcie_table[] = {
 	{ BTINTEL_PCI_DEVICE(0xD346, PCI_ANY_ID) },
 	 /* Scorpious2, Nova Lake-PCD-S */
 	{ BTINTEL_PCI_DEVICE(0x6E74, PCI_ANY_ID) },
+	 /* Draco */
+	{ BTINTEL_PCI_DEVICE(0x2731, PCI_ANY_ID) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
-- 
2.53.0


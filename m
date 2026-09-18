Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3B3A873C
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739416; cv=none; b=MTRqZU1PncBE01qXs8juErgLJRuw4lb5K2NkWSwF03MezxQlwlLXZHWupE1zxSY6bfKzSDpsviJ83cc4czPoTG50mSbJktA1C6VXnoifsmOPqsH33StoBWSpwTjCad9PQMuuRoc3lhG9HzfCQCv+7GdQs3/tc3N0ksspZDSNn2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739416; c=relaxed/simple;
	bh=CerhYsT3jVqPT1a98BKD/EsFGDuIOd0m7TmDLn8fifA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJMKZUeFWD3VUh2Xev8OJYriFi3Il1mXxiTv8rmUjeQ/FpFkzX2lbqpACn0rY/nb01oAYHEQt/QCMJuKwQOQHDTXD8/4O2ikc1h2BpEvhlis/A+pccOyAK0eUs/JHokEdEmOOqzK+G37aWKii+Ww8SysJiCFFEEnHrpgEtNiN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRHdkfc5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRHdkfc5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789739414; x=1821275414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CerhYsT3jVqPT1a98BKD/EsFGDuIOd0m7TmDLn8fifA=;
  b=cRHdkfc5/XhrQ0lfzwgnsVJf8OM1RNHVDLnlapdnB0NAZ6dJGQIBJ2I/
   4ibXMd+Gc4MkTFi3MhtKCCGEw2O1fef+E9ul9tdYfkTMSC0OgQD7PVA/c
   kh4rmp5Ghafbp0lSp74MqdkfyM5bbDPbVwGgq78mVA6KAjXnlTK8s0tha
   83KrF22I5h2/ACpS1AmrebWDnFMmAGMDEXpQqMU/90rAEkmObsW181N7b
   Lf3DjM+GhrHYOTsbm06JUS49XFGCDsCPNuYpxjfBEcjE/GifS5DengzSJ
   Oxp6gunGrrVleiScHKD02s3DXqCMuezgaYpMlIJNi3Cj8U697dLbMRTpz
   A==;
X-CSE-ConnectionGUID: 7j3+CA9HQOWFSt83AzeNBQ==
X-CSE-MsgGUID: OtsTSQJmT5Ogc1IdI3cyyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="89178012"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="89178012"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:50:13 -0700
X-CSE-ConnectionGUID: EeCFfh4TSXar8cGi38GzmQ==
X-CSE-MsgGUID: M8c+tT59Qw+VM+jmTpgn6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2605709"
Received: from unknown (HELO WEBAPTLH152.iind.intel.com) ([10.66.226.239])
  by fmviesa012.fm.intel.com with ESMTP; 18 Sep 2026 06:50:12 -0700
From: Catherine L <catherine.l@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Catherine L <catherine.l@intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btintel_pcie: Add PCI ID for Titan Lake
Date: Fri, 18 Sep 2026 19:19:46 +0530
Message-ID: <20260918134946.39151-1-catherine.l@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PCI ID 0x9329 for Titan Lake (Scorpius Peak2 C0).

sudo lspci -v -k -d 8086:9329
02:00.0 Bluetooth: Intel Corporation Device 9329
        Subsystem: Intel Corporation Device 0012
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at fe000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [80] MSI-X: Enable+ Count=5 Masked-
        Kernel driver in use: btintel_pcie
        Kernel modules: btintel_pcie

Signed-off-by: Catherine L <catherine.l@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 9dbadef31324..969725c8a520 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -54,6 +54,8 @@ static const struct pci_device_id btintel_pcie_table[] = {
 	{ BTINTEL_PCI_DEVICE(0xD346, PCI_ANY_ID) },
 	 /* Scorpious2, Nova Lake-PCD-S */
 	{ BTINTEL_PCI_DEVICE(0x6E74, PCI_ANY_ID) },
+	 /* Scorpious Peak2 C0, Titan Lake */
+	{ BTINTEL_PCI_DEVICE(0x9329, PCI_ANY_ID) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
-- 
2.43.0


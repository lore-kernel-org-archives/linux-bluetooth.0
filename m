Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF1488225
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058388; cv=none; b=dl4GY9/3qp+6bKd+p1uqKOMucUh3Ol7AS7eLrncdBE4Jq7PPIkdNXHdmYDIOUddqIGmXJYWkBrkGqztKj48YMHJVOIokFfhQJ5kJazTIj1VqsWokoVYeDu+RzkDTQUtWs3AYUq3pLTkam+LFyJIhJ+8GpDLcIJkwwaNHkzyKbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058388; c=relaxed/simple;
	bh=ow4h2O2gGZRzcfOTswOaw4QZRs48fwFAZXnOFxh8FYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JtwV9QFYZGerzRCO7gdo5279n2pb6KcO6ANluH3pc6K9JRYR75ZvSvcBiHhE3FSztaQxDlyz1jIsPcGqa562s6TPSzHqrqaX8VGC46PYNhMnS2pxdBG8mRE3KlZWqnwEuzJuxudOKGZXzdnKbKQYSNruAbGQkDi1DGk8SeXqW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRrahvGc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRrahvGc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790058385; x=1821594385;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ow4h2O2gGZRzcfOTswOaw4QZRs48fwFAZXnOFxh8FYc=;
  b=eRrahvGc3NTrbnswuYcUgwhxd48QjyyYVGMHytNVNYztMKAgHc0M4tZX
   2qWw+NDmVmIA7KsHdudJwq8TIhcHlPF8XJOfMNJ7FI8Xk3wn7swHajNNO
   FIYcWoF5SXobDKb+G/AB0229xADbuvwu/gCy+oruv+xy2/5mKUf5CyXbe
   /qGuMetKR9HTFQ/8jir3SggKLS75RUEWR3JFWb6bPRbjAElEhWvyBf/om
   FXUVroMBPp158COM1Xc8IAkqqtamXd9+VJmwAW+Bg7C7t4BxXvcW9u3Vf
   R7nzOzENq/PkEWfljkHDmvAUQWbJGkvn2UapuFWOEgID7BCkiIIAZw7jt
   g==;
X-CSE-ConnectionGUID: McrfIShDSVWLR7QbTwAebA==
X-CSE-MsgGUID: rjbyW5LHSESEv94v1B5A3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90749139"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90749139"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:26:21 -0700
X-CSE-ConnectionGUID: VAuzMY1GR164aVTyOMHcyQ==
X-CSE-MsgGUID: 9FD+JwBVQx+lK+f18Zi68g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="300921219"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa001.fm.intel.com with ESMTP; 21 Sep 2026 23:26:19 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1 2/3] Bluetooth: btintel_pcie: Add support for Intel Draco
Date: Tue, 22 Sep 2026 11:48:04 +0530
Message-ID: <20260922061804.20205-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Device_id 2732 for intel Draco

From lspci -v -d 8086:2732
02:00.0 Bluetooth: Intel Corporation Device 2732
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
 drivers/bluetooth/btintel_pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index cc474694b9ba..cfa437e76ad5 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -57,6 +57,7 @@ static const struct pci_device_id btintel_pcie_table[] = {
 	{ BTINTEL_PCI_DEVICE(0x6E74, PCI_ANY_ID) },
 	 /* Draco */
 	{ BTINTEL_PCI_DEVICE(0x2731, PCI_ANY_ID) },
+	{ BTINTEL_PCI_DEVICE(0x2732, PCI_ANY_ID) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
-- 
2.53.0


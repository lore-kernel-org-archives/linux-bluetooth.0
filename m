Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBA4BB278
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884357; cv=none; b=XfToVwn5FhDBv+C3Nx8l4tOqiN+KVL/0h8hcIIZTbEumOABYW4TpqOizzvzSVs7GtFcEi+uX92cZOaol5kuIP/hu+npN0qOap9LxaGAxILyS/UXRCKlWjbuI9Wh+2s4r8nwsI5kf++mS3G9MMGUOmNhO38X+GURnjIGSBYNxqRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884357; c=relaxed/simple;
	bh=+mUYCdJxBPyu99HVLcmXE5DY/Ee8XZIRLRRNi37Vnv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s64dstWzU5YHjwsEmDcFXRAucIBhlWmAJYh8xy3MCaHC2gOD4EDR+TanJRUDvYrfRsQPFyCsDlhyaytvkRu93/pnPU3ncElXuZ31I6YKJRA1SDX5XjjV3VpP8RwJkFIYqlQ0/TuPQMvYSHzHK8Tw6KrvzEJXC6Qf5EJf/KvpKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2Ie0O3i; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2Ie0O3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791884355; x=1823420355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+mUYCdJxBPyu99HVLcmXE5DY/Ee8XZIRLRRNi37Vnv0=;
  b=P2Ie0O3iRywPcQa5nAKmdHBdzZ5MnCF26AfKJMmTXxGISsUpDg4q6h38
   rvl3GH+IVTRUXhOhu59AHAnUpd62wUPrelQ0oFKGOP03OxpphdnkuvxY6
   9sDpj1ZlWbkSyzL8V8aG3ct5jY39YnroQ25OwkH7BeShM5ULJXnSjta+t
   w+6QrUTMhMhhZ7JtBBvFPRfNkYJukiQXhzas7MA9VHAHopAfneGPIHMk2
   daNKSZn5aghIk7kvk2gHMSgodvmZtDmsxyn+nVgQpjFHugrNIH/C3Fbb7
   N6deXE5FWIWL3bJ6MaEQi2/h+fsy5FJ9XnsOmF792XoELw93tsSchs2ia
   A==;
X-CSE-ConnectionGUID: 4yWOmASmRKSq61699zfltw==
X-CSE-MsgGUID: vxNC29x/SnS/IKJLtnNwAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="610541"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="610541"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:38:16 -0700
X-CSE-ConnectionGUID: HZYpIDCDTJmq+qYAxacWEg==
X-CSE-MsgGUID: 24rBhnF3RiqMfbhFojIlSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1444271"
Received: from unknown (HELO WEBAPTLH152.iind.intel.com) ([10.66.226.239])
  by fmviesa007.fm.intel.com with ESMTP; 13 Oct 2026 02:38:14 -0700
From: Catherine L <catherine.l@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Catherine L <catherine.l@intel.com>
Subject: [RESEND v1] Bluetooth: btintel_pcie: Add PCI ID for Titan Lake
Date: Tue, 13 Oct 2026 15:06:50 +0530
Message-ID: <20261013093650.423572-1-catherine.l@intel.com>
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
index 3a555aa50c87..91b1ee9d6010 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -59,6 +59,8 @@ static const struct pci_device_id btintel_pcie_table[] = {
 	 /* Draco */
 	{ BTINTEL_PCI_DEVICE(0x2731, PCI_ANY_ID) },
 	{ BTINTEL_PCI_DEVICE(0x2732, PCI_ANY_ID) },
+	/* Scorpious Peak2 C0, Titan Lake */
+	{ BTINTEL_PCI_DEVICE(0x9329, PCI_ANY_ID) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
-- 
2.43.0


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096E02BCF5
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716760; cv=none; b=LA2KmFO+/W+TYTg2dWXmbtvIHLiF6HHy6u9PECmKrKeZglWN9q7FLOhaIf3Jn5g17ERp45YJtfgURbBxrgQG/nE9UYeds+siZM9gX/HuniVCOKyVE6bzpjpVTvNXj/dBOTBnQZzRvNc3ek8qMr+0aqKzMOS5m7LIk8U8ELj0hfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716760; c=relaxed/simple;
	bh=LaFo3iBE72aytuS8/DnP1M10D1pTT4YAzMHcKamAJhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=foiS7sFCLWbDDx5UiG5kchewhJ1vHOnqvV5DOkFhERvVnbVmcJbL2xGwq4tMSQkTHLhpDqnqClZZz3hJt/YbD+EXaszW98rut0C53JK0EVt1ILGDYxdto5cwnJueiIC9mugUrTnNGwsBwjjN3+IpL+YV3iyDiMgOGprwDmfn1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grLpEjOd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grLpEjOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753716759; x=1785252759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LaFo3iBE72aytuS8/DnP1M10D1pTT4YAzMHcKamAJhU=;
  b=grLpEjOdLOcBOeGEPSmhsNRV2funmDx4Dx5NdyyM0estS9SL1pCQYZwg
   I4OTwKQV99aFAILSXPZUgKPtXAhDfjyi6v/Uiy6Hj+BlsCePIeSbRhPbA
   F8he/rUPPvgTN+ewgBE5Ulq3zM6L24V6j+zEJpVwAaeRc7jww/hXBcJFX
   kKJ5MVFDCph3yjOwNaeVZB0DeTm5D11HvK+PPJshc07vsX6c0a3eag6xH
   VpA4HhPaaB0zk3ObSTlopcbTGkdiVd/XTb2UdD5iLitvW1GqnXbEhXv0o
   DR7662GDqCtwURXbU/RUx3DEB7S9q1CGYg4veCDM3kvmAQ032oGtFz6+9
   Q==;
X-CSE-ConnectionGUID: VD28sjSdQWSHKcFIdjrEKg==
X-CSE-MsgGUID: YGmHskNJT/eEGMUVuxsLOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="56048077"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="56048077"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 08:32:37 -0700
X-CSE-ConnectionGUID: UXNtzTEeRea72Ln84dIJ1w==
X-CSE-MsgGUID: 6zUwqap3SFa4hsMwyCie+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162316864"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jul 2025 08:32:35 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3 1/2] Bluetooth: btintel_pcie: Add Bluetooth core/platform as comments
Date: Mon, 28 Jul 2025 21:19:08 +0530
Message-ID: <20250728154910.1428086-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Bluetooth CNVi core and platform names to the PCI device table for
each device ID as a comment.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v3:
    - Include product and platform name in commit message
    - s/commnents/comments/g

changes in v2:
    - Add complte platform name

 drivers/bluetooth/btintel_pcie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 8e65def192a9..8f02c27bc544 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -35,9 +35,9 @@
 
 /* Intel Bluetooth PCIe device id table */
 static const struct pci_device_id btintel_pcie_table[] = {
-	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) },
-	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) },
-	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) },
+	{ BTINTEL_PCI_DEVICE(0x4D76, PCI_ANY_ID) }, /* BlazarI, Wildcat Lake */
+	{ BTINTEL_PCI_DEVICE(0xA876, PCI_ANY_ID) }, /* BlazarI, Lunar Lake */
+	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) }, /* Scorpious, Panther Lake-H404 */
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
-- 
2.43.0


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032E23505F
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753413304; cv=none; b=ZcQRkNSaJfqsg8mXeP166Qcz/avTsC8qO9SOiYJW6DexAf+N7codecuifkS/V1R1j0xgKHYtKs6PL7Fk48B+1NxVoWZXDtt/bWhWLXBb6IyUkrvhOv4LvCeRFKu6jm8K2QGIkcN4w8U1/s8gnWadyp7QboCKD8FNvtMeld2RMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753413304; c=relaxed/simple;
	bh=91IJFguu+C42jA4nLZak8ZkoR4F7GOiLVivqQbxfWRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1sc+FaiM9syJYe50Hbni+vboPRjGHufGBYuBPTbL+LcE5qxO/Al2+6/3N+TdDPRNK7bzlWgoMG6EPInF7ee1C6I6yrsf87JVHdWMAlOBUARSbND9eA5twrfd7Fbfxz5u+dbuRxyJFp5ojEunqRuOBOTm44S9K8sTTRYI/SZcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhmAuiMu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhmAuiMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753413302; x=1784949302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=91IJFguu+C42jA4nLZak8ZkoR4F7GOiLVivqQbxfWRs=;
  b=DhmAuiMuQphbeM1v/NZa9JA1SFLDNOysOwT0qrF0JPaBG6ztmWqEGK3Y
   RzN9GZG1ly2u1ctx4aUQt1HjWy7bLSzY1v3y8WdcW0m5jFJyEnCTxhzNj
   Lt1FzLdadW0pxgsL6y+sHJ0dTVh79knlrC4eFjNki8lSMK8yRDoa9Qvae
   eaj4Rddnq7bsacCZKZaeoaBWciKpQukU4sJvMK8Ck8icfbPfbQdQuLvJO
   TW4j6WYWWLKq3z3ZFOnaxduF+KNxAGiaurXV7WmyJQu+ZzSkIssjRn124
   sSSwdYPcM/AfRfEbDnpuH76prBmgS7WPhGHblTIP4Tn55fJ9S1nvW74o7
   w==;
X-CSE-ConnectionGUID: g5oh0O2wSeeaLSSFE0Thsw==
X-CSE-MsgGUID: OiDdudCNQNerZR+E9WXLcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="73325085"
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="73325085"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 20:15:01 -0700
X-CSE-ConnectionGUID: DTKb4RzkQWaxUmku7K7dtQ==
X-CSE-MsgGUID: h45nxP4USH6ic/kKt90QAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="165173662"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 24 Jul 2025 20:15:00 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel_pcie: Add Bluetooth core and platform details
Date: Fri, 25 Jul 2025 09:01:33 +0530
Message-ID: <20250725033134.1351301-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Bluetooth CNVi core and platform details to the PCI device table
for each device ID.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 9792a49886ff..14d59d1353cd 100644
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
+	{ BTINTEL_PCI_DEVICE(0xE476, PCI_ANY_ID) }, /* Scorpious, Panther Lake-H */
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
-- 
2.43.0


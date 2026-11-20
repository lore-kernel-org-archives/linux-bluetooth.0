Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166562;
	b=3MOXoFAlx3iCCJooItogeZ5YwSyGcAdlEUekQmFBClkV8yL+KzXkKkZ8b0JbBv2qXHa7
	 PfcOYoEf8c2KwEvHa5WyR/CbkobLXFOvpnD7/3VCXe+otnvuEHaVFhgvwb387d1PDRAnl
	 RK4pnSBY2XixbfCijt/bmatgYHnQGdkUECs46WdN4tMGgTZ4s/51DKYa8rO6AdZxMR+b5
	 NIbEWqP94dHU2KVDfS6+6ssbfjp+EI/F3lBfelrdsstzGH/pxk/CyhnMY9D1F+/2SDyD1
	 +oRTtv22eLX6S6O7XzX21ye9AFbJoke33C37CB5jVMCF8axrK6YmmXrxQn3fxdiW/Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166562;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YjR5k59UT47s6yBsF0l7vHb/E+RngyAk9H/cLwS1WkI=;
	b=UFQMXc9TMZ+9z25I30tdVReXomDQtPNBm6smzkUOxDjBAWGzNv/Yv1mbo9afg86bwvDM
	 48M1fB0EtRge+CmUNZAR7m7Z4AXd/wkma1FDj9rz0vFdgpGOxnYytm5U/npkopjEdN7v0
	 iUzFD4xXIiIdQl4ShOtOxo8+688tSLTHZ7bp95goBEFs2hjHRU3F0v5SZObMhqWgSgEA8
	 US9MIb4rvvvaxsQehxGUAO1PxLSZGDTXsqgAtDfmS2KDcaoSRttrr8AHV6mkLriKihk4l
	 3N1OjVlA/UUkk5wk0OirlPmyo8ImEcZKl21Z6IAmiZWOlM/Fa4SmUgENuJJtg4tgmdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="jjd/6kKf";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEDC606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 09:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EEDC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jjd/6kKf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795166563; x=1826702563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UbBqzs+/3VP6MuUkrf+lE9sMTVZyWCwCxNGAQ3ykpk8=;
  b=jjd/6kKfT1FzbT/ZlIFWI3LMYbVkyazUAwyVWBHRnfPUAET3KtXMYSyS
   xLBj4BftmlNs0SqGIomEnsX85xyUzXGHg8XM/wgucRffjemJpWiGVg94h
   n4ofBwc+NuG0EjiUu3NRTEIfDNr1DJ2OmUVsJicigx9QKXiIEbfUG4WJ/
   0d4bIpbHgmUXRfEeDrRPQrt8ZGbNFHLz5EGLS4QJ3WZd336+NdtigxzMv
   9yVILZQV0X7ih4E4MABZM21Akah+4ftxpg9NwIXl8RHJ759ZQF3pBoUl/
   7PYWOntFgx5dLsHQ58prXnqkW80fmycMgooF4/ArvpHQ8Bx3567LKu3QU
   A==;
X-CSE-ConnectionGUID: +E9ZLG+8SGKucwmYHeUJMA==
X-CSE-MsgGUID: 7sVpFPppS2Cug7QDT6RSqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3889053"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3889053"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:22:42 -0800
X-CSE-ConnectionGUID: LBiOd3j1ToKgG1ZBbiCHWw==
X-CSE-MsgGUID: voTAazZcSDSP3EVz3BuEiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10736872"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa005.fm.intel.com with ESMTP; 20 Nov 2026 01:22:40 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3 1/2] Bluetooth: btintel_pcie: Set only MAC_INIT in btintel_pcie_mac_init()
Date: Fri, 20 Nov 2026 15:12:48 +0530
Message-ID: <20261120094249.2419421-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_pcie_mac_init() is called prior to reading device memory via
target access. To acquire MAC access, only the MAC_INIT and
MAC_ACCESS_REQ bits in the function control register need to be
programmed.

Currently, btintel_pcie_mac_init() also modifies FUNC_ENA, FUNC_INIT,
BUS_MASTER_DISCON, and SW_RESET, which are not relevant to MAC access
(though doing so had no observed side effects). Leave those bits
untouched and only set MAC_INIT if it is not already set.

Fixes: b9465e6670a2 ("Bluetooth: btintel_pcie: Read hardware exception data")
Assisted-by: Copilot:Gemini 4 Argon
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v2:
- Split the patch into two

changes in v3:
- No change

 drivers/bluetooth/btintel_pcie.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 12a2cca09d7d..9b75807065c0 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -874,14 +874,11 @@ static void btintel_pcie_mac_init(struct btintel_pcie_data *data)
 {
 	u32 reg;
 
-	/* Set MAC_INIT bit to start primary bootloader */
 	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
-	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
-			BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON |
-			BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET);
-	reg |= (BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
-			BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT);
-	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
+	if (!(reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT)) {
+		reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT;
+		btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
+	}
 }
 
 static int btintel_pcie_get_mac_access(struct btintel_pcie_data *data)
-- 
2.54.0


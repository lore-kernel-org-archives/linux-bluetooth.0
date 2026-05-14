Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789338B143
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784254; cv=none; b=NG46LjnNq5pBg2FEksSLqLGqbPK2tmoCD+QKHQN997uwa0ggldJTEwKDvEZYyU/92uKEMxhh4G7yxFyJSLAI7gvBAyPblnieRyRws9wxkC3EN2fLq/uFAqajAkPPZnOsUuGm7eoqM8cQsJGVsmfoiwMNLcpOjmkUkh9rV5GBDmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784254; c=relaxed/simple;
	bh=iUXFRhM5wRWeA9Abs+0EIT0O1F4te9AGIlgE8zrnOe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXSs/tyVYIUrLyyRusqzXW04SD57kw+cXItWnbIZqtAAnK4X00P7SmLSwTbwRjJwY1BRo7EqzbKJ1HgYNA/Vnjbl+AtQBkUPqZmgywYtmsQLCK9AC23ugY/OJr9S7f1xipG776rQePzlRGbgMUibgyCFVxpgZMCi3gbUnFv5fD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1KIZw0j; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1KIZw0j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778784251; x=1810320251;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iUXFRhM5wRWeA9Abs+0EIT0O1F4te9AGIlgE8zrnOe8=;
  b=F1KIZw0jCTyeBw5mai2jtdzVMcmJWIe5pZfyMZMrU71NMmrLNK1riTgr
   ZjIKfVByAbHo6/HTThj1aBnLRbDW85BSub/S+ZhtJ3fMXv5jO4BGIO9DA
   kE5uMaWBxH1CtlGQCMAl5uzNoBMebm231ZzGkaAH7966IeG9XpqwE1Uv8
   T2Q4WipqvhCsXP9W8AVgxBeC92YQ/BC1zI62cfHLQWzCAKm/YAYVemUgm
   UkO9n4D/uMcWcd/L/BapCV7UEnRHlUgNa7422oIQD22jwCyP4sHPQ9ex1
   bOQlMQeoAYJszSSbON6eNLFORb6++9wDr2NUWSt4YQyqFKgey+2x0CyUG
   Q==;
X-CSE-ConnectionGUID: yyWfGlLXTMOpbQcSjW7N2A==
X-CSE-MsgGUID: lhnihgfPTBGnYSud0DiICQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91199069"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="91199069"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 11:44:10 -0700
X-CSE-ConnectionGUID: kHE686yPTB+M2SgXyq2ASQ==
X-CSE-MsgGUID: +9C6t0N0SgOZdpv1ewp87w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="232069756"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa009.fm.intel.com with ESMTP; 14 May 2026 11:44:07 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Fix incorrect MAC access programming
Date: Fri, 15 May 2026 00:32:48 +0530
Message-ID: <20260514190248.1275299-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_pcie_get_mac_access() and btintel_pcie_release_mac_access()
were programming STOP_MAC_ACCESS_DIS and XTAL_CLK_REQ in addition to
the MAC_ACCESS_REQ handshake. These bits are not part of the host
MAC-access handshake on the supported parts; the driver was
programming them incorrectly. Drop the writes so the register update
contains only the bits the controller actually consumes.

Fixes: b9465e6670a2 ("Bluetooth: btintel_pcie: Read hardware exception data")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
Changes in v2:
- Reworded commit message and subject; describe the bits as the driver
  programming the hardware incorrectly.
- Added Fixes: tag.
- Skip the FUNC_CTRL register write when MAC_ACCESS_REQ is already in
  the desired state in both get/release paths.

v1: https://lore.kernel.org/linux-bluetooth/20260511133932.1217624-1-kiran.k@intel.com/

 drivers/bluetooth/btintel_pcie.c | 20 ++++++--------------
 drivers/bluetooth/btintel_pcie.h |  3 ---
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index fda474406003..eba563b66090 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -594,12 +594,10 @@ static int btintel_pcie_get_mac_access(struct btintel_pcie_data *data)
 
 	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
 
-	reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS;
-	reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ;
-	if ((reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS) == 0)
+	if (!(reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ)) {
 		reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
-
-	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
+		btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
+	}
 
 	do {
 		reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
@@ -619,16 +617,10 @@ static void btintel_pcie_release_mac_access(struct btintel_pcie_data *data)
 
 	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
 
-	if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ)
+	if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ) {
 		reg &= ~BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
-
-	if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS)
-		reg &= ~BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS;
-
-	if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ)
-		reg &= ~BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ;
-
-	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
+		btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
+	}
 }
 
 static void *btintel_pcie_copy_tlv(void *dest, enum btintel_pcie_tlv_type type,
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 2db85f71b2f8..7fc8c46ed689 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -34,9 +34,6 @@
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS	(BIT(20))
 
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ	(BIT(21))
-/* Stop MAC Access disconnection request */
-#define BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS	(BIT(22))
-#define BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ		(BIT(23))
 
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_STS	(BIT(28))
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON	(BIT(29))
-- 
2.53.0


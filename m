Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7E8394471
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505652; cv=none; b=mwypJ1C7h+jCFIsbEHKlaI39/uYzLYg1OO9PuHePJ6RXPyTKVp4eAtUsptUzcGRYhvfYyVk+nnuo4fa2bLDzdiRGPn8PUmz73ocMR3lQwhzz1tKL7F/OdtaYeOZ9csCk0XO3bfquhtHotI6IlGnzE+GCeaNFiVoUowHm2+nJI/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505652; c=relaxed/simple;
	bh=0Sdo9/dqiZ+82UMv/AcK0plQeb4oqVYtkinWUWV4kCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCA/FmpkB5Q+YPVvcNKotcHXIx9ivTdtFgxUk6nycO5ihVvOOKUmAtLN4UwaI3zrYnyRIEyo0q0KpIoly/vnfzN7pXxcAlc9KISNOLkID001Zu1RjUQcHrkTpgyDUuDccqi9RaVwP4sE3WIaOtephbwfqs4fO4dqqnO4AXN9Xjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5ps+KPn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5ps+KPn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778505651; x=1810041651;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0Sdo9/dqiZ+82UMv/AcK0plQeb4oqVYtkinWUWV4kCc=;
  b=h5ps+KPnXbBIj2/+/IgncYYOP1ULlE4PHCLwb5y7o5FHRbNbXvML5aY8
   MK/643plA/F2SkveKYx7RB0LwTiz3kgdMzk2A6+1Xie9WSNGQN9LkC+Vo
   G6FTCYBaQzsLerQNzfZY/nNdSSJuf38IfMs60kT5GwrOuPS/i1YbN/B04
   PdITausLZFw8wU3QNfLP7ep1Jn11ieWNXuU6Rc7fQfY0Al7w6Jp77WXlt
   D0pIQOaOHxYbTrqmvLLRwVEhm7AJDkvn1+cWTTXhFhzSU+In7aMGsiJns
   zH5xbGmpSA9eUuYd7/SrtZGCC8cL7rcVlBAP90ZJOOVorreWkcgH1H6cy
   w==;
X-CSE-ConnectionGUID: 6SF2qofnSCiWbeA65sO85w==
X-CSE-MsgGUID: qlg8Plo5SOmEb0DMpTDRLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83003297"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83003297"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:20:50 -0700
X-CSE-ConnectionGUID: 7Kdv4SrERbmaq5mgR0Gnsw==
X-CSE-MsgGUID: 5ypU6Pw8QuWv5BTM6+jr/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="242436049"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa005.jf.intel.com with ESMTP; 11 May 2026 06:20:49 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Simplify MAC access request/release
Date: Mon, 11 May 2026 19:09:32 +0530
Message-ID: <20260511133932.1217624-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the STOP_MAC_ACCESS_DIS and XTAL_CLK_REQ bit manipulations from
btintel_pcie_get_mac_access() and btintel_pcie_release_mac_access().
These bits are no longer required to be toggled by the host driver for
MAC access on the supported parts; the controller manages them
internally.

Also fix the idempotency check in btintel_pcie_get_mac_access(): only
assert MAC_ACCESS_REQ if it is not already set, instead of keying the
read-modify-write off the MAC_ACCESS_STS bit (which reflects grant,
not request, state).

Remove the now-unused STOP_MAC_ACCESS_DIS and XTAL_CLK_REQ register
defines from btintel_pcie.h.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 10 +---------
 drivers/bluetooth/btintel_pcie.h |  3 ---
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index fda474406003..53a4ad80b871 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -594,9 +594,7 @@ static int btintel_pcie_get_mac_access(struct btintel_pcie_data *data)
 
 	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
 
-	reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS;
-	reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ;
-	if ((reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS) == 0)
+	if (!(reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ))
 		reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
 
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
@@ -622,12 +620,6 @@ static void btintel_pcie_release_mac_access(struct btintel_pcie_data *data)
 	if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ)
 		reg &= ~BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
 
-	if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS)
-		reg &= ~BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS;
-
-	if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ)
-		reg &= ~BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ;
-
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
 }
 
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


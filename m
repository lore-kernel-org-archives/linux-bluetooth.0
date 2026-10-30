Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369341;
	b=XXq4KW1bPlvoNKCdAW/nDWXLAwC42W6i/JnsP2FHr5fVWi+sBETNZhvSIxHAII7GC6U9
	 bQKQCKZF1xDN9X5EF/Bn8HggapJBhkqh0Wl8CMNzu390QlabAdKHFCJFlT+CZhLWd3puc
	 7+J3DVa79uQeZsok4E+BqoybkVaIUQ/lUA//hSjC8wqOEC8tv16hcu8gXZevjfw48+JDp
	 XDk6WDFZJXimKG45XC1csT8AVRL7G9q98tsEBlylvyKMQau2cu0mhYQrP0OLGOs4NkMhr
	 NhKOtDCV4AdtbDHOcfmQ8w0E+VphyXlAB6xQ/XuumXn9huHIaY21sU7b/sQ8R64xEUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369341;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UD6nXSfFjcFuFs03/DBMrs2H5NY+JJhfNCNdLgowjX4=;
	b=zxyPh4mVY7NVFRMrhjmBgicWO71AWQ3o6Sc/8An1TyuhbLr0Nmawc8QCBU5vcKWfVAaq
	 tjx0Pt8eYQEO1PdvKn8wX/u+/2knC9+ofOVV2WcSzuX+2y9XDJ3j5N6tefd1W3jfDE6xp
	 nJQ7mmtWN8P4YsMH2NXR87lsWS0ffEdxlwOTXEqmePCSU8aznpeF8QtrIQD30PNhUFVd6
	 9fIDNBiuFxNRypfkxjxY5PKEXhQRjlSnXqU0mEHZ9kR2yLm8j2xZOA2cnVcdEy3SMKxe8
	 amPl9GtbHjQbhQjJRP1UTtiA3iHPvtNWjMLT5HYbm/D0AP7iXpsc+fzHWKBux/zkrHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LHIcqGo7;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A8606A323
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA2A8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LHIcqGo7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793369341; x=1824905341;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pCNb1rbAKmpQnGIvnvqgjPjp+iEY75S/VOw4GlPUj90=;
  b=LHIcqGo7OzylY6V4bwuPGL+5jQVLOqn5JwK88L1tZpK31fjjt1bLhJPE
   0oX+GhiCkKN8Yh+GbpsIOAalghdOsTPK7mvv1YDH94q6nkByGH2TSC+Pn
   tCWr8rl+ZLM+r8wXZWa9hjRs3sQd70WsCAfuj+1hxyetJgNfMH8ZsSEn4
   plOu6KWVEJjbakyJnFANclrSlytjeIa285HrJaskpIWBEIpEfhn0p/R3e
   FK/5PEX+GtrgTWov/cfhiNbDZVpoNJYcDsb0POVB3dBP6TggKL9yzwJse
   ZjvlJUZR8TnHWiyfWJRWwGsqaoZHQ293qAEqO9TxEdRgZSatpdZqT/1V0
   Q==;
X-CSE-ConnectionGUID: TbT+RtDDS3WS1GOWnFA2MA==
X-CSE-MsgGUID: Z2JE/zXhSnKCZKf+/LxGqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2038574"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2038574"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 07:09:00 -0700
X-CSE-ConnectionGUID: KDivjlYIRT6VqXKUXH1PPA==
X-CSE-MsgGUID: xD80DJpDS+q2ENQJXEJajg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5981101"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa010.fm.intel.com with ESMTP; 30 Oct 2026 07:08:58 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Set MAC_INIT in get_mac_access()
Date: Fri, 30 Oct 2026 19:59:07 +0530
Message-ID: <20261030142907.139369-1-kiran.k@intel.com>
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

Every caller that read device memory had to call
btintel_pcie_mac_init() before btintel_pcie_get_mac_access(). Fold the
MAC_INIT handling into btintel_pcie_get_mac_access() and drop the
separate helper along with its three call sites.

Unlike btintel_pcie_mac_init(), which also modified FUNC_ENA, FUNC_INIT,
BUS_MASTER_DISCON, and SW_RESET, leave those bits untouched as they are
not needed for MAC access. Set only MAC_INIT and MAC_ACCESS_REQ with a
single register write when either bit is not already set.

Fixes: b9465e6670a2 ("Bluetooth: btintel_pcie: Read hardware exception data")
Assisted-by: Copilot:Gemini 4 Argon
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 7d84c8106cf1..025c4c64d020 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -989,31 +989,18 @@ static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
 	return reg == 0 ? 0 : -ENODEV;
 }
 
-static void btintel_pcie_mac_init(struct btintel_pcie_data *data)
-{
-	u32 reg;
-
-	/* Set MAC_INIT bit to start primary bootloader */
-	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
-	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
-			BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON |
-			BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET);
-	reg |= (BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
-			BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT);
-	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
-}
-
 static int btintel_pcie_get_mac_access(struct btintel_pcie_data *data)
 {
-	u32 reg;
+	u32 reg, val;
 	int retry = 15;
+	const u32 req = BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT |
+			BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
 
 	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
 
-	if (!(reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ)) {
-		reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
-		btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
-	}
+	val = reg | req;
+	if (val != reg)
+		btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, val);
 
 	do {
 		reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
@@ -1951,8 +1938,6 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 	if (!buffer)
 		return -ENOMEM;
 
-	btintel_pcie_mac_init(data);
-
 	err = btintel_pcie_read_device_mem(data, buffer, tbl_addr,
 					   buffer_len);
 	if (err)
@@ -2643,8 +2628,6 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 	if (!buf)
 		goto exit_on_error;
 
-	btintel_pcie_mac_init(data);
-
 	err = btintel_pcie_read_device_mem(data, buf, addr, len);
 	if (err)
 		goto exit_on_error;
@@ -2732,8 +2715,6 @@ static int btintel_pcie_dump_fwtrigger_event(struct btintel_pcie_data *data)
 	if (!buf)
 		return -ENOMEM;
 
-	btintel_pcie_mac_init(data);
-
 	err = btintel_pcie_read_device_mem(data, buf, data->debug_evt_addr,
 					   len);
 	if (err)
-- 
2.54.0


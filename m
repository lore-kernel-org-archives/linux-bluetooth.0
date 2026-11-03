Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715483;
	b=LCOvnHohiRH0G7GaSAX1ASKf/GAbi5zNhgccXc2iH0fx8aNX0UN1ARazZMVktMJFxR1Y
	 7zkco2kmuo53U+uvtWgzfd/HPEbDolzAflDHPHgRdlgdvb8m7S73H2Ll3IDl0U+Achc3a
	 9QFSstuSWtQzOHkHtqpRxShdBPo7SyyMVEhWJx86K87ax4DYBJ12x3S6fwIoler9ysIMx
	 xOrnATztxUrWa2wcBA13YKVHbRJbpfaJ5qnbPUrHjhTgNicQXrBpuZImtuu9Fscqe49iI
	 gwc0bU+FuDRFIS2+62WgL4JRAtHKsmnYSiTjm4nvzzXmqbNnwYedSYMaqOHgN3KtprQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715483;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rCEjxiC84nHoFDGRpquIAkGngVrwwn4FjV6YT+pjpyo=;
	b=x9llKGdLNrBSOpbos38uMAk1iJkJy1diTOWFZ7B68Xv+go9c2EDoeLEdGqj+6OY57bkp
	 czTDTc7zJSYZZ9Q6ZBvuXQB4+lmhIMuOOW3/W5Jv9/4ddBFKlRFJ2jyhtc4vk3FDq3XgO
	 0hGLLINusDNWHub+vAKBLP8Yaw6KcTJ9wpF7otAFavv5HSqgPhOcLMIBHYCDZ+JrTfvjz
	 uoAbvPqa5JBTOsReaoMIoK9ap7XtidMvFpze5ttyM/v05jM4FSTTfCjIMGoBJnJNdqOLp
	 zcc6Rkv46ZWe4o+yvrPmRekASOmrZuOsDvSe8mSCRAUvMPUUG/2zAc+jcEgafPUIyUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mi6IiIFj;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14393606A326
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 14:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14393606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mi6IiIFj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793715482; x=1825251482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ec3/TyqK4WpGU/AqO/CRqUSAlyxqqOllWvIzzB+RCzs=;
  b=mi6IiIFj4xVnj/+hH3W/q/TFEtiU6qemQGnaglo3WPJufLAt6+sJTZGk
   l5c/H3qdCP2AG8jraX1IPCUfActhEDMgimnrNHVbeba/ObIcIT04Kk55e
   TLI5hLFm16ZKizTwZ3CN8pNSoxXrlhMjvNmlsCEFU0TQixUqR31R9g2s+
   TQ6C/cDjgUPVpXaJhjOhNAWeo3I3wTUJVRBS+Ey355OWIOnSFjG7YnLnQ
   Y28CZ3RcNYFGYnQnIE1Vmj0DK0GmCKj1PBlbuLRAL+n5OjKm1JD5zsWcS
   PFg6whaXg6Di76SPhGo0VGRtO9aHxlvR1kxdSEvhbQX68aQs1Fc0SL2E6
   w==;
X-CSE-ConnectionGUID: 2jhvJU5MSaaru81PZQZXnw==
X-CSE-MsgGUID: whq1hoOISUavTek4JpNH8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2319652"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2319652"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 06:18:01 -0800
X-CSE-ConnectionGUID: CzbFopVlThi73Z4mhHPIWw==
X-CSE-MsgGUID: GIeeJoFYQtOCl00bM8jnPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6337324"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 03 Nov 2026 06:18:00 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2 1/2] Bluetooth: btintel_pcie: Set only MAC_INIT in btintel_pcie_mac_init()
Date: Tue,  3 Nov 2026 20:07:58 +0530
Message-ID: <20261103143759.555315-1-kiran.k@intel.com>
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
 drivers/bluetooth/btintel_pcie.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 7d84c8106cf1..eee49bffe148 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -993,14 +993,11 @@ static void btintel_pcie_mac_init(struct btintel_pcie_data *data)
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715484;
	b=U7fY3wzQUtgPmbpyYshB9emSNESN7AUWb1w/3AclhupEYu/7H16514gdNCC6EvCl9FaP
	 tCd8LXzu9BKkOJkTWTeJLICq0VebER98qVIQVCh4LS2idrw4aHIk3HlA5kErwlfbVIDGa
	 KcGju4HzrNGdLbJB+JJbDsom8vRKW4oeFEWBQZK8EprdXwiFzX/Qpq9QH6mqYXzpUqa80
	 +rWqCu47sBIgTOwXthvlYl0ckZ3bXpgHjj5qi+wTJivzgnzRQsFHOEarrFKDc6T/7+pRr
	 FWauNhZqyUzVv3+vEnyXsZqCxJS1zPTT0qpWhN4MzvAcNsnamV0pMf1mboqunP8XNYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715484;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=muTcSeh6vm0HbDvQLUGgyU18mme0A/5kIpB+FK0IMJw=;
	b=UeDz/w95UMuROcFehQtXzFYnwAByk4ENs8fRMAK2+ou5L0Aw23WgGzgGrUlSgjVHnMWs
	 at6JC9iFLE3ZzPUDJEmUZuxcRys7u4FL20/cND5zbszeazXhhXyWXCqQ9Wn46KM3dKyd+
	 9CZY7wHZQgFimNRrs0u3PAltD6vA6j3CN8qbIT6qRRg4xKPEdpmaqbKzhK3COUjcO8ao1
	 OQnQBHTnPS+sbFIkQex5Wcb7F3aFgHqgIt6V7SEH+QHFGRmyw9MNsZhYeaNu5BVdJQDTi
	 tDHe1/a73vaiSwranUwHzEUDAwHj1hVmqblCYk2S0aIG31QYLDL3p0oYFLr4xIEPP/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nqALkv3G;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645FD606A327
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 14:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 645FD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nqALkv3G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793715483; x=1825251483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bQQkr94Ur6ugBOfPOr0Pw2BSkp7bmwzh7eoONiBCPQ8=;
  b=nqALkv3GFuQmNhhVS4vSiwf1yEwMrUp+mlzUGG9uhsCxPPYPuT0t+QuF
   7ugRl9xH+Gb44PxBGQ0Gml0wrwICFEd59kOZrHtlai6qbZj5GKQMynlNL
   Y9Lk4vpIYB7mhnr/Y9BOVcs7ad9/p+qsWrRLHPjgUOjt8YbHsegIHusnl
   2Bevfv1UQmuir4bB08f+2T2mHgtUBxH+UGJAADfoq2cx480Ux04Ng9vlO
   +9LtTOQ78sOolKSwktApLEhgcBpsFcSy6bH+qcOp/iw0BXSOgrjmSi/X3
   y03aj9iqeUC2jKMsD4GY1zf3QhF79hZU199JqL0DXRGgIELK2UNUROtJo
   w==;
X-CSE-ConnectionGUID: r9EJnvGpQ2i0b6mQQo/nsg==
X-CSE-MsgGUID: gIpfH300TaqagmYL6qyBOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2319656"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2319656"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 06:18:03 -0800
X-CSE-ConnectionGUID: Ykg/isTcS6OF4ByH4nFljg==
X-CSE-MsgGUID: 7sFmhKYAQfeZZK4w1jcJxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6337334"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 03 Nov 2026 06:18:02 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2 2/2] Bluetooth: btintel_pcie: Fold MAC_INIT into btintel_pcie_get_mac_access()
Date: Tue,  3 Nov 2026 20:07:59 +0530
Message-ID: <20261103143759.555315-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103143759.555315-1-kiran.k@intel.com>
References: <20261103143759.555315-1-kiran.k@intel.com>
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

Currently, every caller reading device memory has to call
btintel_pcie_mac_init() right before btintel_pcie_read_device_mem().
Since btintel_pcie_read_device_mem() acquires MAC access via
btintel_pcie_get_mac_access(), fold the MAC_INIT handling into
btintel_pcie_get_mac_access() and drop btintel_pcie_mac_init() along
with its three call sites.

Set MAC_INIT and MAC_ACCESS_REQ with a single register write when either
bit is not already set.

Assisted-by: Copilot:Gemini 4 Argon
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index eee49bffe148..025c4c64d020 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -989,28 +989,18 @@ static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
 	return reg == 0 ? 0 : -ENODEV;
 }
 
-static void btintel_pcie_mac_init(struct btintel_pcie_data *data)
-{
-	u32 reg;
-
-	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
-	if (!(reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT)) {
-		reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT;
-		btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
-	}
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
@@ -1948,8 +1938,6 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 	if (!buffer)
 		return -ENOMEM;
 
-	btintel_pcie_mac_init(data);
-
 	err = btintel_pcie_read_device_mem(data, buffer, tbl_addr,
 					   buffer_len);
 	if (err)
@@ -2640,8 +2628,6 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 	if (!buf)
 		goto exit_on_error;
 
-	btintel_pcie_mac_init(data);
-
 	err = btintel_pcie_read_device_mem(data, buf, addr, len);
 	if (err)
 		goto exit_on_error;
@@ -2729,8 +2715,6 @@ static int btintel_pcie_dump_fwtrigger_event(struct btintel_pcie_data *data)
 	if (!buf)
 		return -ENOMEM;
 
-	btintel_pcie_mac_init(data);
-
 	err = btintel_pcie_read_device_mem(data, buf, data->debug_evt_addr,
 					   len);
 	if (err)
-- 
2.54.0


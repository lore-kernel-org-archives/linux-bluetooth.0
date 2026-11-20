Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166563;
	b=FjqgqtSichJQ/TmLLKKfVdsLYFI7V5x2FRyGMU0NsYx4/aujCcJgqmj1MmZ6Sxe8cqtc
	 Wy5q6bS1W4PM4FR/W/UW29c6qzFVAi/LtciJbZ6sy5rq7u9xx207gysCJDCYkevJxnLgT
	 hGPnPuDU5RqzUHXiC9m3jZD9ejGa8jGXk+hD/MpBVrUfMMd8ggF2qrqUySrvNOxuks+hn
	 AsdtTmCMnrmNYTeUVrHkMNrw6y7EkOkhXSsgEk3448DF/FcHv4ut8GpRy64ak+s5QI5Uq
	 InSspyEkkBfI9TI50f8I5iJiCNfwINLFoUewVX2DnYTSNFdSV/+3yMz8q2aNrGTkXMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166563;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RaceszebryK7NIblWQyiGSw/u11nKtNU2iC8B5Mt2Uk=;
	b=muDp/D4Z4gO4D1mf6r68On+Lf4Y5ZDBpIT09d5MPPfmeajZoSQf2H6NOtaVscVpFiLHo
	 JCZxONySvLg9MiII/eZIe6I2bkeUwK/xMQlpUDZP38eAqWhn+OEzSs++qoEU/8K03RwnM
	 W5z+ZMVVhmiC0CL06+V6ZKABMvfA0Jvv0D46sTXuRhrLlmZWf94UpIL86Oi8Ot4ZwpILd
	 PMyzeIO/WI0jQD4hz1wK9VSLTLZsLMA+dIGXXI44WCPplDIwRBofZQYZDRBVIHegLEFVJ
	 AJnTnGu0DViv2QreQf+MMgLG4npIG+rD1blq9zigcj5dF2vXjGKQIUFMOMVLP6nz2xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jPOYJ8x9;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103E606A330
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 09:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8103E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jPOYJ8x9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795166564; x=1826702564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LcuEpJgzaLL7JqzSkPjUNIjMOboo2lZkCEu949w7jPg=;
  b=jPOYJ8x9Aucc1YbqCc3R5thP5k8Hb5KckgdGRb4QJ6OLOoeRQjkUGKuL
   aIZD55hhovJc/eyZGt7tHJoL38EuR7La8KsKSiWmXVUnOShiot/zIFidi
   PvZ5bT00HJwDsdjXUoug4GA1h0iEoMS49XTrNwocHwaS3nZmPeOi6tj4S
   fE4mMu9ZHv+Kd8KWdoReTwK57juoWP4mdhahvD00NSOYOPfTM6pf00/fj
   +3cnlDuRxeeHLKDtEtJdvWbj8kzmGwkxNoZ0qEnd3IoXXJtAfiU8pQ4TG
   MwiSuUmHJ5ubyu9q1luvuzRlAZFsYbSP74LQK5NV8xOB/0AIQvh9Ombzr
   w==;
X-CSE-ConnectionGUID: 4IkasEUxR2uecgugw+0GQw==
X-CSE-MsgGUID: wWKiPkHUSKWYVtlmvwdIsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3889059"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3889059"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:22:44 -0800
X-CSE-ConnectionGUID: aCQ2pKBeQAKG8471BkReLw==
X-CSE-MsgGUID: MqIFEXMoTd6lfZOabNLzcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10736896"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa005.fm.intel.com with ESMTP; 20 Nov 2026 01:22:42 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3 2/2] Bluetooth: btintel_pcie: Fold MAC_INIT into btintel_pcie_get_mac_access()
Date: Fri, 20 Nov 2026 15:12:49 +0530
Message-ID: <20261120094249.2419421-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120094249.2419421-1-kiran.k@intel.com>
References: <20261120094249.2419421-1-kiran.k@intel.com>
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

MAC_INIT and MAC_ACCESS_REQ are the function control register bits
required to acquire MAC access for target reads. Currently, MAC_INIT is
set separately by btintel_pcie_mac_init(), which is called right before
btintel_pcie_read_device_mem() in btintel_parse_mbox_tlv(),
btintel_pcie_read_hwexp() and btintel_pcie_dump_fwtrigger_event().

btintel_pcie_dump_traces() also reads device memory under MAC access,
but it never called btintel_pcie_mac_init(), so MAC_INIT was missing on
the coredump path.

Fold the MAC_INIT handling into btintel_pcie_get_mac_access() so that
every user of MAC access programs MAC_INIT. Set MAC_INIT and
MAC_ACCESS_REQ with a single register write when either bit is not
already set. Drop btintel_pcie_mac_init() along with its three call
sites. This also fixes btintel_pcie_dump_traces().

Fixes: 07e6bddb54b4 ("Bluetooth: btintel_pcie: Add support for device coredump")
Assisted-by: Copilot:Gemini 4 Argon
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

changes in v2:
- split the patch into two

changes in v3:
- https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103143759.555315-1-kiran.k%40intel.com
  by update commit message and adding fix tag
- For pre-existing issue, patches will be submitted seperatly.

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 9b75807065c0..55454900322b 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -870,28 +870,18 @@ static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
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
@@ -2045,8 +2035,6 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 	if (!buffer)
 		return -ENOMEM;
 
-	btintel_pcie_mac_init(data);
-
 	err = btintel_pcie_read_device_mem(data, buffer, tbl_addr,
 					   buffer_len);
 	if (err)
@@ -2737,8 +2725,6 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 	if (!buf)
 		goto exit_on_error;
 
-	btintel_pcie_mac_init(data);
-
 	err = btintel_pcie_read_device_mem(data, buf, addr, len);
 	if (err)
 		goto exit_on_error;
@@ -2826,8 +2812,6 @@ static int btintel_pcie_dump_fwtrigger_event(struct btintel_pcie_data *data)
 	if (!buf)
 		return -ENOMEM;
 
-	btintel_pcie_mac_init(data);
-
 	err = btintel_pcie_read_device_mem(data, buf, data->debug_evt_addr,
 					   len);
 	if (err)
-- 
2.54.0


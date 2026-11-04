Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774762;
	b=JlXQR4nNVPNGUHsuupGNCqiD/CxIzhYavz4IrywEkalo2gL0GozFUd0NPVJMpH5h0bh8
	 vvoQwJbjO1zk6nBb839pleE01nF11WfdaoMIaerDg4eVVJmo9IuxTilgeArBHUeoC3Yi3
	 XW7T7eJBKwl8kZ7ypMJ603XTPcnQ5kQnYCzgyawIlMmHij7Kj/JCN3rPoT66qnDivg4Se
	 qC+X2BZHQ7KuiYZr4TNnPU+NtoZFDkaoOo7BChZDpohXocO+O2FWqz4HhYhfvAQ/zKXJ8
	 d9y83D0sp3WM4w1YcQume+CzRhDQSO5JovBU2idHCbmIM1pUcVXy8EYbnlsM8b2pBaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774762;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uB/SCP7Iti+F8/HeaHU1knaf9oruw23V/dbucu/N4S8=;
	b=EW70C7q/hEcMdWVQpkGpAkDyTBte1+F/4KoPEe+7zjMhepwd/+GV66oAXz0AdoQ2FLZb
	 CeBI7OcidirszVBptiCS8K4GbDTrE4Z/nrTFpM25Y4+P74fHxiiked/7/gtJqQNAbGuqQ
	 KYkG0aCnnvgygreu9mTtRRqFM51sfwXZi55hsy/U/LJJJ9MVYJRICOl49dszWLvZE0z1d
	 JxZZwgXjyDdFNTigasqezpiAlhLyWECqp61nw8fVYqBegQVgxHp6n+Y4SSJbZXzk8ix6m
	 R1ORGlTlW2fVUQSM+a5qrbUKfmarLjwtVfdzIaETmtJejkPU2eP1ZSnAijaHRJSBw/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oCmFJnmH;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2988606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 06:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2988606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oCmFJnmH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793774761; x=1825310761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FI1eTouaRX8jAlfKOiRX3cAO/1ILH38dNJ9jCMaYk0M=;
  b=oCmFJnmHzAlKg2J0S8jGT9u1C0DbJix9rYETN5FLbIBjJ3mC9ZOt1Mlz
   vDuOLv7L8aWolT+zZQn+vrbbbbZprifWkTV2uF4gWUNznhUhEtVshNrtx
   91fJT0jgBdfIqDHEeY0VWMKVpqd29QZcWGxX+wxoY48PoQynJEJAtEwET
   S3pXznWMFunsfX64UwjHl62mZO0QTyicUgpMYyLZqu69FzSCr0Zeh9AeM
   Du1WevzdIMg+Q1yQInP/fjDvCKAfip6sz0dfipqC27Gaxa4hY24rM1BER
   LJTILDkD/MKk3TQPO4jmBAegI8If4j/yP9wt1jlLN4yI0fBll7AVC3m5P
   g==;
X-CSE-ConnectionGUID: Fv1WbXb6Tm63i2gRgzMXtg==
X-CSE-MsgGUID: YNS45GY2TbSVtIHH7k8B2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2536193"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2536193"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 22:45:45 -0800
X-CSE-ConnectionGUID: gayNPZdJQKq8hGMymDcx+A==
X-CSE-MsgGUID: arqzRv2rT4Kjg4/7HxxJLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="7197110"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa010.fm.intel.com with ESMTP; 03 Nov 2026 22:45:43 -0800
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Fix SCP DBGC base address
Date: Wed,  4 Nov 2026 12:15:07 +0530
Message-ID: <20261104064507.2600483-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
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

BTINTEL_PCIE_DBGC_BASE_ADDR_SCP is defined as 0xf0d5d500, one register
row past the base of the SCP debug controller. The status and
wrap-around registers derived from it at offsets 0x1C and 0x2C
therefore point at the wrong addresses, and the debug buffer status
and wrap-around state read while dumping SCP debug traces are
incorrect.

Use 0xf0d5d400 so that the derived offsets land on the intended
registers.

Fixes: e43b33bf8d67 ("Bluetooth: btintel_pcie: Load IOSF debug regs by controller variant")
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index f04dfb0b30fa..c11620dbec46 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -82,7 +82,7 @@
 #define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS		(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x1C)
 #define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND		(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x2C)
 
-#define BTINTEL_PCIE_DBGC_BASE_ADDR_SCP			(0xf0d5d500)
+#define BTINTEL_PCIE_DBGC_BASE_ADDR_SCP			(0xf0d5d400)
 #define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS_SCP	(BTINTEL_PCIE_DBGC_BASE_ADDR_SCP + 0x1C)
 #define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND_SCP		(BTINTEL_PCIE_DBGC_BASE_ADDR_SCP + 0x2C)
 #define BTINTEL_PCIE_DBGC_ALLOCATION_OFFSET		0x100
-- 
2.43.0


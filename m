Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B013A22616C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250363; cv=none; b=dUYNLlqg3r5+qWrh/z5ycZ73luQKXbcu5UDEUSOzpa11lT0hN3tSzAnlFxiWU1IcXerJpsqR4mVg003mRWUklvzQqZW0V8UkegUJFZc/phX4ayU3qZn1bW28YVWUJCFLqQ0JWnW5DpvWEGTEn3nU7wPnxaF5VQHyrN0PrFOuliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250363; c=relaxed/simple;
	bh=C9u8oBGdfy81ZnaMxSVGZmmdk4LMQkr+EJYq9JQRVrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WnIDx2v6uqdGfblx3oJZMt9PcBs3TMnd5jCR04fc6dlld8JdQH55eAJEzPr1ECocK3EZWcO/V5/frAYGfksfMFLxb/+9WI2hjEFSZdW0F5v0EElbDNtb/uKvcNjFj+HTcrXEhcpi3f0h73zNntqfN+WXOl3FFsWQYLSDSvyJ+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffDXHdmV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffDXHdmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750250362; x=1781786362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C9u8oBGdfy81ZnaMxSVGZmmdk4LMQkr+EJYq9JQRVrQ=;
  b=ffDXHdmVAECEMo6pe6WWqptVKZJTBystS9Tn2g/H/0sGcOM7qiTtZEPC
   PXkQ7XXYfAUpuKxYj9ObhItDozZ0w+x7qni6mq8C8j1IIYoJtiShtasIJ
   r0kAlb0p1fGz4+17c42v1gDx+XG9wY2M1awZjnlcHMt+vsf4YBFGMyTBr
   T30X+kowTL4weKURTDnYpv+OabRXiRuJq+Hr+Pt6hikBo4s1yg/Dl420h
   5Rl9DUvZ8sbBfZ1vr/u3ZASq3r5PaLGr+Q7ClqaO9Qr/ZFhbT4MmPLotP
   pzPe6dpIC5zEBnXiKB9/DGF8k3hhsmiJl/v+cM/Y4EhCfQ2tKwJB4+jO0
   g==;
X-CSE-ConnectionGUID: e1TXRxlXTtWpNzQKakEPSw==
X-CSE-MsgGUID: EyjtbManR52wnfkraMgO/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="62741320"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="62741320"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 05:39:21 -0700
X-CSE-ConnectionGUID: JuV1rFxiQ32iMcjfZSa1bg==
X-CSE-MsgGUID: NTlvcaSQTUOFqjwuUQ05eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="180565718"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa001.fm.intel.com with ESMTP; 18 Jun 2025 05:39:19 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Add hardware id of BlazarIW
Date: Wed, 18 Jun 2025 18:25:55 +0530
Message-ID: <20250618125555.773327-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hardware id of BlazarIW cnvi core for USB and PCIe transport.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 3 +++
 drivers/bluetooth/btintel_pcie.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 55cc1652bfe4..f6805027be0a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -484,6 +484,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x1d:	/* BlazarU (BzrU) */
 	case 0x1e:	/* BlazarI (Bzr) */
 	case 0x1f:      /* Scorpious Peak */
+	case 0x22:	/* BlazarIW */
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
@@ -3253,6 +3254,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	case 0x1d:
 	case 0x1e:
 	case 0x1f:
+	case 0x22:
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
 	default:
@@ -3593,6 +3595,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x1d:
 	case 0x1e:
 	case 0x1f:
+	case 0x22:
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index cb3cf2b9acea..1004264128e3 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2137,6 +2137,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
 	case 0x1e:	/* BzrI */
 	case 0x1f:	/* ScP  */
+	case 0x22:	/* BlazarIW */
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
-- 
2.43.0


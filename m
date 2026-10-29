Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266422;
	b=uzGGwFsgHZPX0OOfB+jVBKMOcDsvoTSAj+ocNH8h8+bp+s5lYcFL/FSynyD1JYKMqpB8
	 lnNCU+LuPt800YOEZUjyvPKchs7/TBjTF0NKClgnM1rndPD7Ae/ULuTp+Fy4LTfgv2VqL
	 OMjs5LgQ1iRDgE2UnEJHu905DjwWNoY4ZsGf9cGLpZVgTcwhfT7H2dgqUWBAI2iF3sf9Q
	 Pay2NkUbnoGSIZL1Hf/7tfGkL0jOvJ//BgWZiCelB/VoAbyuc+Q4HCAp6gqRmCJXAR619
	 VsU9eGWyFniAW0UDQ18vgC1DdwdfYAHYw53ehAeygWtViwmyaSBDXonLfMNSFQzgH8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266422;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7UBj5hnMGCFw4P5Ori+aqUcIK9l/X7l0OqRp+kI+AkI=;
	b=O2pClZACONUPkzlpDjEn4TO3djJPJDQwJxnUVN3WcFDCFT4xh9uk9tG/YRw6+8qkrR8/
	 vGv23aeWjEG5FtaiNa+X4V+v/9R4v8e3aa5qD8JtvmRiYiAgk73eJKCl/ORduyxBEE/Kj
	 bf0g53d4nNbLvIj1/z9QmXCG7XsrVTbe+8gkfhbjOe83XdCQUxtMm8Si9ZgcpQiNKtln6
	 hmGSKh68WoZEmWjRz/xsMIgw6WItT4EEImrvvsmqaKvzcxB6kMlmfUOYIg+DOzy3Z3jTX
	 erzz0APGE/EVFyDetzdOmrHHFjR+NsB+q2OP+uz9qk4u7KfNB4Va56LIAraMPxRcP/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=goY1dpT5;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD3606A31F
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 09:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54CD3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=goY1dpT5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793266421; x=1824802421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r+oOudmCkOl2sEBrKRxSBMvfL8svPViQKz3NnjU5Va4=;
  b=goY1dpT5RuNdtZCPAdXFet7l4EAbkglcTIdtjwqrab7yYgZFJvXOoAik
   GWuCI90nli/MJPNX/k+bPOLLHV5nomjRSvqpM+0Dvh4/6Blx8lE5WQjH6
   cRv6u2/NsvgFmiVDq9m8mjmMvHItn6FUOb+/DKbDBoEW4pFjXgCRK/oHR
   MIyJVrqXDFbL4a3f5Yp/WvMm7haFAxLPEH+H2KMt4N+BmytNonyyXlUCp
   mt3K4EDCS/2qlWwrUDP2YDVIjGX5Sem7tCwXlvssswTSFvDqwwAURjrcP
   ThlNreHBCVaf+/y/66CawOJj2OpqNGa/bGsOnnDwlk1HYH/zJUdyRDqSI
   Q==;
X-CSE-ConnectionGUID: oeRoTdImQ6Kz0b+W9o60tw==
X-CSE-MsgGUID: K4xxlxwOTfWa20twBTNYEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1887603"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1887603"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 02:33:41 -0700
X-CSE-ConnectionGUID: GWJPc1pBSYOK1kMjWQngMg==
X-CSE-MsgGUID: ensMKIVrQJ+Wg7iLNaMbbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5183772"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2026 02:33:39 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 5/7] Bluetooth: btintel_pcie: Add MAC access logging under LOG_MASK
Date: Thu, 29 Oct 2026 15:23:42 +0530
Message-ID: <20261029095344.3989729-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029095344.3989729-1-kiran.k@intel.com>
References: <20261029095344.3989729-1-kiran.k@intel.com>
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

Log MAC access grant and release along with the FUNC_CTRL register
value, gated by BTINTEL_PCIE_LOG_MAC_ACCESS (bit 4). Also report MAC
access timeouts unconditionally as errors since they indicate a stuck
controller.

Assisted-by: Copilot:Claude Opus 4.7
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 56c76e5fe473..878bcc1412fd 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -36,6 +36,7 @@
 #define BTINTEL_PCIE_DUMP_RX		BIT(1)
 #define BTINTEL_PCIE_LOG_ALIVE_INTR	BIT(2)
 #define BTINTEL_PCIE_LOG_SX		BIT(3)
+#define BTINTEL_PCIE_LOG_MAC_ACCESS	BIT(4)
 
 #define BTINTEL_PCI_DEVICE(dev, subdev)	\
 	.vendor = PCI_VENDOR_ID_INTEL,	\
@@ -1014,13 +1015,19 @@ static int btintel_pcie_get_mac_access(struct btintel_pcie_data *data)
 
 	do {
 		reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
-		if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS)
+		if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS) {
+			if (data->log_mask & BTINTEL_PCIE_LOG_MAC_ACCESS)
+				bt_dev_info(data->hdev,
+					    "MAC access granted: func_ctrl: 0x%8.8x",
+					    reg);
 			return 0;
+		}
 		/* Need delay here for Target Access harwdware to settle down*/
 		usleep_range(1000, 1200);
 
 	} while (--retry > 0);
 
+	bt_dev_err(data->hdev, "MAC access timeout: func_ctrl: 0x%8.8x", reg);
 	return -ETIME;
 }
 
@@ -1033,6 +1040,10 @@ static void btintel_pcie_release_mac_access(struct btintel_pcie_data *data)
 	if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ) {
 		reg &= ~BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
 		btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
+
+		if (data->log_mask & BTINTEL_PCIE_LOG_MAC_ACCESS)
+			bt_dev_info(data->hdev,
+				    "MAC access released: func_ctrl: 0x%8.8x", reg);
 	}
 }
 
-- 
2.54.0


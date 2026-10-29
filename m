Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266419;
	b=mBu4L4OLoNIIFS40vMljf21mnZIIwrC2+aq/lQzx/X9Zao4MU2ZAMeW8ZNHMvSN3Uqx6
	 JDn7+aI1Xsp5oc4q6LciUuey2Ty3WlZD+bBlqnsAGKQhX4XDAyGzOXzo+2m/1sFm1HFNQ
	 +gMyATIH/Uhs8fSHTVqxcmaTFL5zZx86Y/NVXlE311RVP1ZlyUagtg1cIdnY2ZtrW/eiO
	 dKNfqkpRVfkkIc60b3HWBW+9H7KNzYK65xY3Kfl2c/AvwTJ7msjh01ZnfeX+IRQlStQYt
	 VIlmlsvFK0opwYkv1zKJZeuT/HkyY5Mln2KhLt3QJhBHsbraGFsDVEPoP7ah2OJcjgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266419;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fb56ETfdFE4ZnNQgDXuLsjt5vjNzZvYNfm70OrbsDjI=;
	b=0wKcSYIQyyLgSqzfsDeAQ9X8FuPt1rRKce8QHdzNRHWa3a/uIDi21ujUSpSl3p14xVNx
	 Jsgx4XqYxLPheeRByzedFwVoGnapDNHjsR+5Wb/eQTzBlxcBM1Cbi8wBj1sJoF3GO5dvO
	 woKvzcedG8sxa/NKAg6xDFcK74MvXK8MsFhYk4GUUfGTLbSmaLT5UfRMUDhDv2geCWLZp
	 Tc9kcHY4Echc1ZY1HUNJZcxFlcAe7Gn1IL8fYw0+J8bIkmTVbrSaNrkC7WWqWMEFojG53
	 g3SelnqJM5JjHjON5nC1uDCjFg3wIFUTw9LSCUB26a+2UNR/D5bCAqDEJnwbW4qncng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KcDnzIwE;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030E606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 09:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E030E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KcDnzIwE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793266418; x=1824802418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l8b12tRP/dUSSgNtg5lHfKxGfYHO8qTqEpUqswCn0sE=;
  b=KcDnzIwED05rvJh+/SkIvNQMV2kcvTXTlf/Ise5E+JS999I/p5avYaE1
   0nL3MvZoysVCgMSNHiaoFdQtijgk0pWufTEUkMXjewj8HB8v//VM2Gnz1
   K5N1K65xrXVq5FqfvLEmzSLov/81YkjFL4gdDni/h7cG1b6XDWVG5acmZ
   YskTod4HFT7P6rh4pUS6eNGOU/eXY8Xn2vvAsCpGBYhtAy/kDF6bF+p2i
   9eb3Az4hEEulRSo3M4YBu74ta/WyeOlb42XRQbv+Cii4gnBBGK1G9YW3H
   s3BYsBb0BvVhVxsMl8BjyLH05NsWWc1mw20DH65++0grhlJRCellc3FlY
   A==;
X-CSE-ConnectionGUID: QFeBgHP6RB+HgEsLbm9V+w==
X-CSE-MsgGUID: sPnoq2qiSaqVoeVHmv6o6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1887599"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1887599"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 02:33:37 -0700
X-CSE-ConnectionGUID: M6CtVNDTTOaCthkcvflLdQ==
X-CSE-MsgGUID: fdLfkbJtT26AnY+x57LiWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5183764"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2026 02:33:35 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 3/7] Bluetooth: btintel_pcie: Add alive interrupt logging under LOG_MASK
Date: Thu, 29 Oct 2026 15:23:40 +0530
Message-ID: <20261029095344.3989729-3-kiran.k@intel.com>
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

Promote alive interrupt context transitions in btintel_pcie_send_sync()
and the GP0 handler from bt_dev_dbg() to informational logs gated by
BTINTEL_PCIE_LOG_ALIVE_INTR (bit 2), and log when the driver starts
waiting on the alive interrupt during MAC init.

Enable this category by default.

Assisted-by: Copilot:Claude Opus 4.7
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 34 +++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 6fdffda6a1a8..5088a9c39b3d 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -34,6 +34,7 @@
 /* Runtime diagnostic logging bits loaded from LOG_MASK in the debug INI. */
 #define BTINTEL_PCIE_DUMP_TX		BIT(0)
 #define BTINTEL_PCIE_DUMP_RX		BIT(1)
+#define BTINTEL_PCIE_LOG_ALIVE_INTR	BIT(2)
 
 #define BTINTEL_PCI_DEVICE(dev, subdev)	\
 	.vendor = PCI_VENDOR_ID_INTEL,	\
@@ -783,9 +784,12 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 		data->alive_intr_ctxt =
 			(opcode == BTINTEL_HCI_OP_RESET ? BTINTEL_PCIE_INTEL_HCI_RESET1 :
 				BTINTEL_PCIE_HCI_RESET);
-		bt_dev_dbg(data->hdev, "sending cmd: 0x%4.4x alive context changed: %s  ->  %s",
-			   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
-			   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
+		if (data->log_mask & BTINTEL_PCIE_LOG_ALIVE_INTR) {
+			bt_dev_info(data->hdev, "sending cmd: 0x%4.4x alive context changed: %s  ->  %s",
+				    opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
+				    btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
+			bt_dev_info(data->hdev, "Driver waits on alive interrupt");
+		}
 	}
 
 	memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &pkt_type,
@@ -1692,6 +1696,10 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
 
 	/* MAC is ready. Enable BT FUNC */
+	if (data->log_mask & BTINTEL_PCIE_LOG_ALIVE_INTR)
+		BT_INFO("%s: Mac Init: Wait on Alive Interrupt",
+			btintel_pcie_dev_name(data));
+
 	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
 				  BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT);
 
@@ -2184,12 +2192,14 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
 	 * with cached value and update it before it wake up the queue.
 	 */
 	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
+	if (data->log_mask & BTINTEL_PCIE_LOG_ALIVE_INTR)
+		BT_INFO("%s: Alive context: %s old_boot_stage: 0x%8.8x new_boot_stage: 0x%8.8x",
+			btintel_pcie_dev_name(data),
+			btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt),
+			data->boot_stage_cache, reg);
 	if (reg != data->boot_stage_cache)
 		data->boot_stage_cache = reg;
 
-	bt_dev_dbg(data->hdev, "Alive context: %s old_boot_stage: 0x%8.8x new_boot_stage: 0x%8.8x",
-		   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt),
-		   data->boot_stage_cache, reg);
 	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IMG_RESPONSE_REG);
 	if (reg != data->img_resp_cache)
 		data->img_resp_cache = reg;
@@ -2290,10 +2300,12 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
 		wake_up(&data->gp0_wait_q);
 	}
 
-	if (old_ctxt != data->alive_intr_ctxt)
-		bt_dev_dbg(data->hdev, "alive context changed: %s  ->  %s",
-			   btintel_pcie_alivectxt_state2str(old_ctxt),
-			   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
+	if (old_ctxt != data->alive_intr_ctxt &&
+	    (data->log_mask & BTINTEL_PCIE_LOG_ALIVE_INTR))
+		BT_INFO("%s: alive context changed: %s  ->  %s",
+			btintel_pcie_dev_name(data),
+			btintel_pcie_alivectxt_state2str(old_ctxt),
+			btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
 }
 
 /* This function handles the MSX-X interrupt for rx queue 0 which is for TX
@@ -4624,7 +4636,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
 	data->dbg_path_cache = BTINTEL_PCIE_WIFI_DBGC;
-	data->log_mask = 0;
+	data->log_mask = BTINTEL_PCIE_LOG_ALIVE_INTR;
 	data->pcie_alloc_init = false;
 	data->enable_ini = false;
 	btintel_pcie_yoyo_init(&data->yoyo);
-- 
2.54.0


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD62F2E
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Apr 2025 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745112923; cv=none; b=E7ODTscFC3U+iqQ+rSf30FNebNn/b3a5v+ZRfDsmXKwKe2audKdIO0pPI/njuyhreRxp3S+QpXgj+3RcyEV7X/z2wnJzEHNYr8BSbCpNd8KtSbBZIEaX5kaaByxm5ST0Bz6BK1A2oX6zL+sFcLx2arAfxkFAQXHauk5xXct7OBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745112923; c=relaxed/simple;
	bh=e5FOpdeQYyfZ4Pgs95G2k194B2gcNFmls5hoqGwfgLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSNjBsDuD96FYkRV9NT9oi5facI9C4Ge+tnzIkOQfhvjQRcrpjSa6/hWHhG09N8hmiNOT3we/yWSJ8svw+VbNWuk8ylBrY/hSb3DDMAcmzulBAcRxekTleUBQQX9g0o461vUY4fYagh1/p+sX+IjGiGqRQmEXPgC7sCZKtzuubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgm0bS9l; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgm0bS9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745112921; x=1776648921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e5FOpdeQYyfZ4Pgs95G2k194B2gcNFmls5hoqGwfgLE=;
  b=kgm0bS9lJ5XE2gZnkH6q/oLuZ53WnC9Ct4dMAQHlb353VHtltnXwt6Jo
   ofBNDdH8aF9VZG13qPiMpZbYfGzTYNJryi97aeRYxXevb2cWlyasD9psi
   O/TF83eEYXbNeuQWygeG3+/fyv/vUa8jsJoDzHRbgNbDDIgsnNK+gkQMh
   SIHFJZh6Uf62VSXrk7fQWZ+1s7GK0x9FSo7ZaoSz5aHSFhbgr9kIFTcgc
   gmg52PCgeZkUUnUMZIDVkGbEH+hrWdvaX/6FX2t2kWer7KRqVqvoARoby
   Xz5Q6XlgFHdFnNVjVz+lL7EkwFEB1JvNnPpoau4UdC2vCm3gO2TAl7khP
   g==;
X-CSE-ConnectionGUID: HAEIgsJdTgGWJkhyLM20Hg==
X-CSE-MsgGUID: vwRXZdJBRGaui6KsKWrWzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="34310924"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="34310924"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 18:35:21 -0700
X-CSE-ConnectionGUID: qj2uPorqTp21mkUq+euS+A==
X-CSE-MsgGUID: YYhGkXigQDK16mMMBYo90g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="131273611"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa006.fm.intel.com with ESMTP; 19 Apr 2025 18:35:19 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Add additional to checks to clear TX/RX paths
Date: Sun, 20 Apr 2025 07:21:56 +0530
Message-ID: <20250420015156.192605-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to a hardware issue, there is a possibility that the driver may miss
an MSIx interrupt on the RX/TX data path. Since the TX and RX paths are
independent, when a TX MSIx interrupt occurs, the driver can check the
RX queue for any pending data and process it if present. The same
approach applies to the RX path.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index b73928e38d34..c23823e2a3ec 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1262,10 +1262,8 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
 	bt_dev_dbg(hdev, "RXQ: cr_hia: %u  cr_tia: %u", cr_hia, cr_tia);
 
 	/* Check CR_TIA and CR_HIA for change */
-	if (cr_tia == cr_hia) {
-		bt_dev_warn(hdev, "RXQ: no new CD found");
+	if (cr_tia == cr_hia)
 		return;
-	}
 
 	rxq = &data->rxq;
 
@@ -1301,6 +1299,16 @@ static irqreturn_t btintel_pcie_msix_isr(int irq, void *data)
 	return IRQ_WAKE_THREAD;
 }
 
+static inline bool btintel_pcie_is_rxq_empty(struct btintel_pcie_data *data)
+{
+	return data->ia.cr_hia[BTINTEL_PCIE_RXQ_NUM] == data->ia.cr_tia[BTINTEL_PCIE_RXQ_NUM];
+}
+
+static inline bool btintel_pcie_is_txackq_empty(struct btintel_pcie_data *data)
+{
+	return data->ia.cr_tia[BTINTEL_PCIE_TXQ_NUM] == data->ia.cr_hia[BTINTEL_PCIE_TXQ_NUM];
+}
+
 static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 {
 	struct msix_entry *entry = dev_id;
@@ -1332,12 +1340,18 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 		btintel_pcie_msix_gp0_handler(data);
 
 	/* For TX */
-	if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0)
+	if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0) {
 		btintel_pcie_msix_tx_handle(data);
+		if (!btintel_pcie_is_rxq_empty(data))
+			btintel_pcie_msix_rx_handle(data);
+	}
 
 	/* For RX */
-	if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1)
+	if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1) {
 		btintel_pcie_msix_rx_handle(data);
+		if (!btintel_pcie_is_txackq_empty(data))
+			btintel_pcie_msix_tx_handle(data);
+	}
 
 	/*
 	 * Before sending the interrupt the HW disables it to prevent a nested
-- 
2.43.0


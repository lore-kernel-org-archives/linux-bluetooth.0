Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F7B377ABE
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 05:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789448993; cv=none; b=jNZtSTVcrhoBMkcanetAkJkQ6WRMvT/jJ2NukmY2dbfATtE/vNoLYGdDeWNzvue1KpLhAaIMZQev4ldE5Gpvr634AnAKnKbAlMReY1Obg/yBf2PlDiogfT5LLVHsmvLDHWf3WAQ3hKDM5R8Rk6wYK/+CR8QtbpresmVmMX+663M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789448993; c=relaxed/simple;
	bh=p46ww9nqNp2YP0orOeAvu2G1R8g3ZWCwlA4FT1c8q20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fq6rdGfCwHGpOZdLKkIPFLIojEN/7bwPHfih/L9ahLkAV9NfTZQXtvQo5FlKJ9Wpaa00d19Kpb5dK4HB4Xax1UwhS6S0Tczb/KD9Xtu+VPVQZpCRofi5OZ+X+ETgtcpCQIgGpVkLtNWWEOHbYCzkiZ8dV8K/iDNA4FSupw1Qwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWgnf4Xt; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWgnf4Xt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789448991; x=1820984991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p46ww9nqNp2YP0orOeAvu2G1R8g3ZWCwlA4FT1c8q20=;
  b=cWgnf4XtClxM7DmhsT40mvaqUiwS9BFnnql9HNNHWsYuUJ9+NlDqaruA
   QrpDRJydxDval7ZdqqveTBd/rI6yqeXruPBXzGKqbqOOQRsF1uNRY+Z6P
   lyWVOSZbfcHEoKL55JbVU9GLd3Ee0O6VZGDpTpvnHE5yvVYIzRN4b6FWR
   sL3nTrXzp7m/T7fZ1LEECT6kKBrsPtKr6bHohPw7V8hh9safd4r+hfGE/
   4T7M7l2G7v1hn/52nXEXtGjIHxxHdK+e26H9dELYTs1H4Ze0n9VpP8JQj
   JuB8X1e+KTBnK0+z0R3ymCQ3/S8OvmR+Hcj//NvhFfDcQV2y0YqSY5uXb
   A==;
X-CSE-ConnectionGUID: awUt5C3WTha2/D3rJMzgtQ==
X-CSE-MsgGUID: b4MW+TqARNeDHO13kctA6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115339600"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115339600"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 22:09:50 -0700
X-CSE-ConnectionGUID: uy+2k/ILTuW7i2CVdmu3mA==
X-CSE-MsgGUID: hyfGDPtqQYqnhVx0o7Z+4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270213697"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa008.fm.intel.com with ESMTP; 14 Sep 2026 22:09:49 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: validate device-supplied DMA indices
Date: Tue, 15 Sep 2026 10:42:15 +0530
Message-ID: <20260915051215.2691851-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In btintel_pcie_msix_rx_handle(), the driver processes RX completion
descriptors (urbd1) written by the PCIe device into DMA-coherent memory.
urbd1->frbd_tag (a 16-bit field fully controlled by the device firmware
via DMA) is used directly as an array index into rxq->bufs[] without any
bounds check. rxq->bufs[] has only BTINTEL_PCIE_RX_DESCS_COUNT (64)
entries, while frbd_tag can be any value 0-65535. A malicious or
malfunctioning device can write an out-of-range frbd_tag, causing the
driver to dereference an out-of-bounds data_buf pointer.

Additionally, cr_hia is read from a DMA-shared index array also writable
by the device; if the device sets cr_hia >= rxq->count, the while-loop
never terminates because cr_tia is wrapped via modulo rxq->count and can
never equal an out-of-range cr_hia.

Add bounds validation for cr_hia and frbd_tag in the RX path, and cr_hia
in the TX path. Log invalid values with bt_dev_err before returning.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: Ravindra <ravindra@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 4807361a58a7..444cc50174fb 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2065,6 +2065,11 @@ static void btintel_pcie_msix_tx_handle(struct btintel_pcie_data *data)
 
 	txq = &data->txq;
 
+	if (cr_hia >= txq->count) {
+		bt_dev_err(data->hdev, "TXQ: invalid cr_hia %u", cr_hia);
+		return;
+	}
+
 	while (cr_tia != cr_hia) {
 		data->tx_wait_done = true;
 		wake_up(&data->tx_wait_q);
@@ -2644,6 +2649,11 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
 
 	rxq = &data->rxq;
 
+	if (cr_hia >= rxq->count) {
+		bt_dev_err(hdev, "RXQ: invalid cr_hia %u", cr_hia);
+		return;
+	}
+
 	/* The firmware sends multiple CD in a single MSI-X and it needs to
 	 * process all received CDs in this interrupt.
 	 */
@@ -2651,6 +2661,12 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
 		urbd1 = &rxq->urbd1s[cr_tia];
 		ipc_print_urbd1(data->hdev, urbd1, cr_tia);
 
+		if (urbd1->frbd_tag >= rxq->count) {
+			bt_dev_err(hdev, "RXQ: invalid frbd_tag %u",
+				   urbd1->frbd_tag);
+			return;
+		}
+
 		buf = &rxq->bufs[urbd1->frbd_tag];
 		if (!buf) {
 			bt_dev_err(hdev, "RXQ: failed to get the DMA buffer for %d",
-- 
2.43.0


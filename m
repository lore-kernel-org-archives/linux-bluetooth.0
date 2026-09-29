Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC43D9689
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664846; cv=none; b=JbSGx/8LuX2uqn3XZuQWgGBiGBWpaxblwJZAKEYfvPjMGcuia1cAsjzob67+ej4WjB3lZh9PiDpEnQmcop1ABYSzCsPlzibM0knwAIYA9sEHP5fzCA9BmY9MIfoZr+nb44SADXzLPpg0O/95nJQew8eJI+v6ZJjCx1mSJdhmDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664846; c=relaxed/simple;
	bh=zBLKavF/bwCZJbCDmotmD9Fx+4LTVeIgxhwvUUwXCgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FiERRTJuzzXNIwWF5uTlsFJJ8IE53NOvnbr743NRgDL1M1JqQLQAZX/DjEbVmLqTSQD4S4ZWxivbihkhuzNc0FkvfgiHQRlzNiV50TsaS0J74kCyT0e9pvwo6ux1Olwov0MzMg3+ZM0gFdDPTw+z+zirFVb+lBwQOh8++RTedEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOn8ld66; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOn8ld66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790664844; x=1822200844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zBLKavF/bwCZJbCDmotmD9Fx+4LTVeIgxhwvUUwXCgE=;
  b=SOn8ld66EhtiehjSJtqWEp4fDda0qj+pfAF0hw1gIc87SVzNftnp8++M
   vHQjaNT0zfOWP4wgjq/Oosmxcn6PgVS6BLktQ9zts2pMk+CyWK6/0Tciv
   Zmf1wcpMHPw1N5t3PPxTG2+7ujiQaYwk0i/jQTEOvjbya5aKnbB5OdpV7
   QbkVEDLYlauBpkFsZDz+3Sp5sbRYIwA+cnr+1Ttc4PJlZuf+mVC6+sOVr
   Qt/yoWfucrHV5+ELAciqGOhU+4Tt4jwZncPcNJA/VuzcM6J3pQweFEanM
   R7YACPeljqvIgKYbis/FaXifKcK1izhc8wk0Pzcj6ejJNfRr93T7w8HKx
   Q==;
X-CSE-ConnectionGUID: ukj6sM3ERhijFqxnBU20zg==
X-CSE-MsgGUID: nSXpEZEdRsWbSQahxKdKlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101540850"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="101540850"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 23:54:04 -0700
X-CSE-ConnectionGUID: Yzg5G3iPQMWqdf4q05s3mw==
X-CSE-MsgGUID: nuGW5HGtQoCg1K7aWCFrdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274392003"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by orviesa008.jf.intel.com with ESMTP; 28 Sep 2026 23:54:02 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: fix TX descriptor bounds check
Date: Tue, 29 Sep 2026 12:26:41 +0530
Message-ID: <20260929065641.2936267-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_pcie_prepare_tx() uses tfd_index to access the TFD and data
buffer arrays before the index is advanced modulo txq->count. An index
equal to txq->count is one past the end of both arrays, so reject it in
the bounds check.

Fixes: 6e65a09f9275 ("Bluetooth: btintel_pcie: Add *setup* function to download firmware")
Signed-off-by: Ravindra <ravindra@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 84a6cf2f4920..b4142a78a049 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -536,7 +536,7 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 
 	tfd_index = data->ia.tr_hia[BTINTEL_PCIE_TXQ_NUM];
 
-	if (tfd_index > txq->count)
+	if (tfd_index >= txq->count)
 		return -ERANGE;
 
 	if (skb->len > BTINTEL_PCIE_BUFFER_SIZE - BTINTEL_PCIE_HCI_TYPE_LEN) {
-- 
2.43.0


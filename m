Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42A13A960E;
	Mon, 28 Sep 2026 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574257; cv=none; b=kvS46cC5rR9rxETAE6UMfwjTF5AaaYqja6Evlm54odqqMtN5696yN6oZuFijEnmNSUmCUAJn8NtdO64sEpueZ8PLusk+zY2wsE7POhwh25peGfh5+h3foWCYUr9JRpgtOsC4WiiN3HmstjXpOD/m/kGV4NzOSS2SQlTg9JIrDaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574257; c=relaxed/simple;
	bh=Ipu0aQLEZwkrQ/3ROvq+SK0Z63ymV1lizompOBw5b7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DjVdxTZbouyIklqOLiBmcUcHv7dMEILh+uFfGj6K9F3v+Bpck1Twmj2O3wRqUm5LUBxKIx1IlfxMskYpjboRYmHh8mto+FD2TJ2xieQ3k9vsNOoySdFouAQsyZYE3/DqooTm+PXRzXMnENIaH2YrsdE02hZgFEH3IZK4Oqlpx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHMBtxg1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHMBtxg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790574253; x=1822110253;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ipu0aQLEZwkrQ/3ROvq+SK0Z63ymV1lizompOBw5b7U=;
  b=jHMBtxg1CFnPNg8NTHb0sRAGidzz02/meUgCMz2uUeOGQOxPK0q/xAxr
   ZO8ACa8xzOesvYqX1ellnBqNyN1CDLKvwnVAKbKRr6f3WmvsfbLySDXf8
   7/9El1iIuWIcB5DBlVKnsX2ObaZCUIGGuP5HIDXV53IKOwUtzeJWDoqc7
   IB6xoe/o2P+1AfaSvY4WeCU7y2JrE4fl9zCqLE022NmuryVJ9sMeAcVrG
   TBkaaQeZoXPTzrS5N15O/XirPuJf3z7WFjSuEi1L9lScLnhr/90e/8Y/Q
   Yk8NZ8zPbFUh9uH9yuSg3NubMx/YS/Sox5TDLswcsIuY5txnzZY44UC/P
   Q==;
X-CSE-ConnectionGUID: mPvVIsIMSXi7n++BRIHMbg==
X-CSE-MsgGUID: NaI7oeKpSoCeV/nDKM8WiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90305708"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="90305708"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 22:44:09 -0700
X-CSE-ConnectionGUID: nxWBrnHyTOK5IG3hf0WoNg==
X-CSE-MsgGUID: 1NvdpN3SRq2eMvD4edpwHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="274465278"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa007.fm.intel.com with ESMTP; 27 Sep 2026 22:44:08 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Ravindra <ravindra@intel.com>
Subject: [PATCH] Bluetooth: btintel_pcie: fix TX descriptor bounds check
Date: Mon, 28 Sep 2026 11:16:46 +0530
Message-ID: <20260928054646.2897679-1-ravindra@intel.com>
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

Signed-off-by: Ravindra <ravindra@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 59cf600014bb..aaf409a9afb1 100644
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


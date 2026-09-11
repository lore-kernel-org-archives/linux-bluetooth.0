Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5743AAF66
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128036; cv=none; b=DmZAcW6ICwbio6eZQ9FVVZeXMw9psy1sc22z0CPKLlrZgzOlaDCxoO6tqyFmtPdvGpe324hMffMy+0+EizrkpyOEj5OVaJEwHApbGVGkZGxyMCWXlbpV2zZivbFr79fEV9KlCdaKqvYZgVTGTY6EpKZulKgmBMQGJosSxEyiPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128036; c=relaxed/simple;
	bh=Sh9RXu1dsznhE7Ar7OOoNTdNZJzdYi/WAFj4UTbJOoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCC5SvouamCVMr+M42ebKegfKF9oo/kpoR1bl7zbwJRsIKzdwV8RkAVa/NxWpspcXZAe/YcBMR5YFuktr2kYgyjTzbcA8JnAEXSTWpwGYAQ7hhgNIYGBKcNcfrpo9lK51/Gqu166PtZ8oXRQMU2yvw4X5AWZhALIJKbTw4ETjrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOaOj+1Z; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOaOj+1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789128034; x=1820664034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sh9RXu1dsznhE7Ar7OOoNTdNZJzdYi/WAFj4UTbJOoE=;
  b=AOaOj+1ZJwEsQr0N1AhzuSX2mKFKUXy0k13SCwDDsuPanIhj06MV1nnC
   Ei5YFzyG6RL7PQ2eN3XNc20CWEsHXjwrCaHRGnsjl+xt+ktZA5a/a6zix
   6XDadwh5ZiKZHx6cMwGx54Wh8FGXchnpbl7FupK5OLgKsq57aJ9gzhQEf
   eFwK65XjVR5yIIaipyVk8sYq11lzAh1HOkFhAsNr+hYafQqp3PtsFwSi4
   2oLele7/grxGoN8b6qCdON5bbwi89ONoNVNk3IabtIRp2i7Rt36yBDDB8
   5pPnLdqAuLPZclkHXvTVkGsYPno3coTONqlPiv3hy4nVt/riaOan4UEnJ
   w==;
X-CSE-ConnectionGUID: ns/0qxbbTQOCKnkCU4w36Q==
X-CSE-MsgGUID: muHZ+QK1TpaEWfQJUFgnvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="115129232"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="115129232"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 05:00:33 -0700
X-CSE-ConnectionGUID: G3GV0A/iTPy/Wa+IpObw+A==
X-CSE-MsgGUID: CAbJDPtSQX6Eze9XAIwVRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="295387295"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa002.fm.intel.com with ESMTP; 11 Sep 2026 05:00:32 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: fix off-by-one bounds check in RX submit
Date: Fri, 11 Sep 2026 17:22:22 +0530
Message-ID: <20260911115222.7651-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_pcie_submit_rx() used frbd_index > rxq->count to guard the
FRBD array access, allowing frbd_index == rxq->count to pass through
and index one element past the end of the array. Change the check to
>= rxq->count so every out-of-range index is rejected.

This issue was reported by Claude Mythos.

Fixes: c2b636b3f788 (Bluetooth: btintel_pcie: Add support for PCIe transport)
Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 7a2139a04ddb..4807361a58a7 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -640,7 +640,7 @@ static int btintel_pcie_submit_rx(struct btintel_pcie_data *data)
 
 	frbd_index = data->ia.tr_hia[BTINTEL_PCIE_RXQ_NUM];
 
-	if (frbd_index > rxq->count)
+	if (frbd_index >= rxq->count)
 		return -ERANGE;
 
 	/* Prepare for RX submit. It updates the FRBD with the address of DMA
-- 
2.53.0


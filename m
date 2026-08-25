Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE133D4F0
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673911; cv=none; b=WDw3Sr7MLChZdn9vLreC99SazCFK13UraIus9gXdmoXFbzXqUJKXojlohCUryTlkMdvZxzpiv+nYsrTuKkfxohoqFg3UJ4EV1OCG58yaUfvkBjKkqppMaSjgKaeK7QnwztiZp0LGLRpMgnqoQLyIEcNJ3+0T3LsLlmwUNoq6g/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673911; c=relaxed/simple;
	bh=FJeav/G7wk1LfTqjyTJiDE/0HbozAAna9Jb+yLyA6o8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MfFjrkq4/mJAGCLcRzTsKtp/rDTOQFUnmRmZ7L1TopbIFYyBuXgYuoTwB8H8ZfaJ17jsKr9MZwGt6XGKe1x1TnxkbkeYsZzYNOrsQO9Y6v1oqrxAERl47SOt4wc+Bgw7ZO/yvI5cxVCDx+ZopUbpGSvCBwMqzON1ktNtTVvDjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwzS6Lzz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwzS6Lzz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787673909; x=1819209909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FJeav/G7wk1LfTqjyTJiDE/0HbozAAna9Jb+yLyA6o8=;
  b=IwzS6Lzz6OtXdGJXn2eeenZcm5CQBDm4sXrkrAWqGHsyVCntL6MW5lvC
   KOlIaS0SCKO66ZESDSPcnuFkGM/9+arpVJEq0u13t0KWA61n3GzZz/1zP
   STUTkvuXhYlBYFaBqsIJLhxkB52LsVcHteUk2zY39Itw0ln3ppqj6YVoK
   cuy0pkaLV2okdmERLEXoGoUmCJ7zbdbBaOlHWTm96RBHeBsz56QNkJXsd
   aTcgZycYZC35wMZm7r9Wo2IDJ0ctxiFZvO2q2oYNVsvcv7cLmJX7HzGc1
   u/hgnPuP7OCkveszEKJaqM4vJysaaNgx9Pj3Sd9cKOk7juAib0KZpoOmn
   Q==;
X-CSE-ConnectionGUID: YvZeSR9jQJWSGwPqPQ/Yaw==
X-CSE-MsgGUID: kuBL1/q2SPGG1yxoIQNpIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87092143"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87092143"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 09:05:08 -0700
X-CSE-ConnectionGUID: jxMoO6cNQGWbTsy0ykBMcQ==
X-CSE-MsgGUID: +aFKEMoiR3eh0PhKd7bJAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="266759714"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa008.jf.intel.com with ESMTP; 25 Aug 2026 09:05:07 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Clear automask on spurious interrupts
Date: Tue, 25 Aug 2026 21:55:12 +0530
Message-ID: <20260825162512.143965-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On spurious interrupt where the TX and RX causes are not set, driver was
not clearing the auto mask which can block all the interrupts. Driver
needs to clear the automask even if no causes are set.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index baa621b3fef9..30923eaabed7 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2051,6 +2051,9 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 
 	if (unlikely(!(intr_fh | intr_hw))) {
 		/* Ignore interrupt, inta == 0 */
+		bt_warn_ratelimited("Bluetooth: btintel_pcie: Received spurious interrupt\n");
+		btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_MSIX_AUTOMASK_ST,
+				      BIT(entry->entry));
 		return IRQ_NONE;
 	}
 
-- 
2.54.0


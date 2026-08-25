Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F733372A
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787677379; cv=none; b=cSNeogoDxUPPN6UCNcey7ev47WVDBQok0z6pQcerV6aGte6UtsEhg5WJLNRzz56VS05R+D2hDZE9JJvrCuj3n+f4sU3F4QikAEqTPtwSFgZRSMAWiuIXp1lE3YBlWdELFDyr79zE0s3e+kmJFGStgSu7gd1FpW2xuhjdeCuYIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787677379; c=relaxed/simple;
	bh=pkv5NEsfaXW+e+fq+LQPL6NKF+T1vhb+kNDlZBuphWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oqXmTjYV0RPTbmO3qxnrO6xmpX8LxLt9GrNEmuUFoPGR9HJROSoyOx6mwQ7MmgDsoq480Jdwt9AR8Ek77U73/UtLCrxBUmyZqdbBCo74lhpCI4y3t49+i7wFYlv30XHT3TCtqAjFzDDF2yCDnc7FKAOSXjKMvX26IHw0EB50VYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6wmbrNv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6wmbrNv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787677378; x=1819213378;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pkv5NEsfaXW+e+fq+LQPL6NKF+T1vhb+kNDlZBuphWc=;
  b=D6wmbrNvpOa6UTKn0KIPSK8c0v80gaHbV48AuzieE/dNPxhCfCbLW8rL
   18TRoeIiZj9JAi9d1l6ouBUmbsEZlQXcz8NaykrMOUwwj9lJBUhyWB9Qp
   v53itffoZ3DfREhLJC2FfJmPXo0X3nkcsMXCzuIrfU2yqqMmY7E/5yUEq
   NrvFmIPjfTshEhNGQYpg3eXd/F+VLGwc0jRQXCTr1aL2Xa5SOPGtL0cFu
   Xom3S9lhRhE+jynRxQ97vbYRwkgITk346sTQ3D8GXB6+8nWv4lmuXWRGz
   FAQgIdINSXuM30VKN+t1XqcNhO1HSIDef5uWRatTFX61bK4OHJQF4FY69
   w==;
X-CSE-ConnectionGUID: 2FCgx3+BRaWeIMcL9TBnrg==
X-CSE-MsgGUID: eq1R/joCRxulX8pNFAyQnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87919607"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87919607"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 10:02:58 -0700
X-CSE-ConnectionGUID: kukg97saTgCrs7Tdix/8Xg==
X-CSE-MsgGUID: Gu3JLhxTQQmlWLbQ8ClYnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="265545312"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 25 Aug 2026 10:02:56 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Clear automask on spurious interrupts
Date: Tue, 25 Aug 2026 22:53:00 +0530
Message-ID: <20260825172300.150440-1-kiran.k@intel.com>
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

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
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


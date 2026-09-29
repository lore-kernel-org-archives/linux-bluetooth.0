Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A425B090
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790658193; cv=none; b=CRpycRibCH4YYPQcoAgYwNFaQrZwz5CEESUfpJcb6Crme4F/zie1CmhbMbnXrutOmduyELcMtEJZ0c+04pO2qlqCMDd+jDzJLXsz1e47t1LU8D/6ZX3eebrCzqUNrjJZb5sMq9WwPCKbPkpkTdbz69xJcDjxV7OSJ00C9/QMBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790658193; c=relaxed/simple;
	bh=v4orIUMjfKygHZndCeBqfkZ6P9Xq6fKt21pme1BOit4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFSWL26UTMN08hs/fIpHcgxvVU013g3jp6dJ+tJ/KCuu+TPPI86Fz87O2nYCUhrtLeWZ8oIkELAdzXuqASLlDD27XRJj4sh9RILLGNVy07I+H2rXyjZ0sB9Ic9t5fYCo8ZqEHq0KIHLFizkZXk1WlORoLGgCaiKeEYjqknMVEc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSgTm448; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSgTm448"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790658191; x=1822194191;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v4orIUMjfKygHZndCeBqfkZ6P9Xq6fKt21pme1BOit4=;
  b=aSgTm448Hdj25hIRRwmvixAXyAI9lJl4KOaeohrCUXzy7y6udbmfH/b1
   SNmRbKyVjwaUi9eXD9FOcQjJZvsWyyTKDBnZ6fAG+EpetZBhEGiwO3PDt
   rtH/YyEo/ZGDVO8cWXqBDXjoSizqmNrWV98eYPd7yb5yhdXQ4D0ithbmP
   flGCQNq7ZBQFtmLBqgheBfzz/f8rzTsDAOx3qPou79QRZK7ytXw2C6vHl
   WtEipdZiwVgjUthd52kOQ+bbHhy1aLbGTd2liUTAyQ2I4oh87lV8It2Yt
   4bo0VnMMWgrbJH49TwmwN7IRhdtDziNczTpIP/jzaeLYHRVWXnswRZTJI
   Q==;
X-CSE-ConnectionGUID: ZyTQCIDhTwyixrelsNBQHQ==
X-CSE-MsgGUID: A2s3arQGQTC+k6e8UWf5hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="93858100"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="93858100"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 22:03:10 -0700
X-CSE-ConnectionGUID: JmLODqAHRFKP6mxrNrz7sQ==
X-CSE-MsgGUID: 4j/BuNzMSxSjsPSYvwpUwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="301538253"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa002.fm.intel.com with ESMTP; 28 Sep 2026 22:03:08 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Add shared HW reset for clean start
Date: Tue, 29 Sep 2026 10:24:49 +0530
Message-ID: <20260929045449.200096-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reset shared Bluetooth hardware after mapping the BAR and before setting
up MSI-X interrupts, so stale device state is cleared before IRQ handlers
and interrupt masks are configured.

Propagate reset errors so probe aborts rather than continuing when the
reset fails.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 84a6cf2f4920..6cde68ce0304 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2876,6 +2876,13 @@ static int btintel_pcie_config_pcie(struct pci_dev *pdev,
 	if (IS_ERR(data->base_addr))
 		return PTR_ERR(data->base_addr);
 
+	/* Do shared hardware reset to ensure a clean start before
+	 * configuring interrupts.
+	 */
+	err = btintel_pcie_reset_bt(data);
+	if (err)
+		return err;
+
 	err = btintel_pcie_setup_irq(data);
 	if (err)
 		return err;
-- 
2.53.0


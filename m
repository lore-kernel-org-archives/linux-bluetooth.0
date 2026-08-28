Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6645FFD2
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927309; cv=none; b=KyJjFNiKFOSQ0J2NNeerG8T/XByo8mYk1YeSISXThFFkAZ2pRO8Otpk6l1Uss796vlmx2pv+ReeDfymP7Z2U6oqmY1Xv0kQ/zv/m0rpoIx+eO4d00lbLWNAbKElC+ALHqOOwBbx6FY4Y9zrkWdUO8PFWfzeksvwzadMBYaZZSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927309; c=relaxed/simple;
	bh=NwtOlr6lNVt/NQiUE47zQwrmGWGXipnJjVKGn4ffqu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xss1+ZDERrjhtd8aqoRE3wCPt5sZfeUOUfFltw3b3I6ZOFdV86Iul1xVxLkcuh/ncI2lXmawUp54pch79DsiieASabarKQ/F/6YILfHDHQOBZJzOhath7qgy7jjXW7hshXrs3/RqmgYYHKdd9OEgfcrcb2zv9Yvas8PPaqqR03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjZdD1OQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjZdD1OQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787927305; x=1819463305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NwtOlr6lNVt/NQiUE47zQwrmGWGXipnJjVKGn4ffqu4=;
  b=IjZdD1OQmNJo7HqlpNZ4iyguXOw2fhwE2Px0qPpqCjlW2xfbKN0sijcu
   2/odRD/mqLIXpqD3IqMgkMwcPqKhyn4a/ZT2IqkajRwPCAkNQNbNCZgGo
   R6q8DpzuarjZox+OX9tOhMNd1qneqJWgrnDsOqJdlfVluCKADnaxDRP0f
   sslYxZl3NMgqQ6x46kk7QNT9dHoZ92Oh5R34TSqpHkQlYdjLy2yvOo10F
   NBGoTEe+89gtvNnvnL87YcqfrT5cO0EaGOXRIfIzD4ViwhcBIuM4qJUes
   lkVxQscHm1YZLDmphYvw4IaYxQpNKeO2Z7Rl5hx/P8Qokkc2hxwQWovTR
   g==;
X-CSE-ConnectionGUID: QP3PvqnoSNyrOOkqOeegtw==
X-CSE-MsgGUID: NjsBhqlwSgiYBcOFggyAAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="105811865"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="105811865"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 07:28:23 -0700
X-CSE-ConnectionGUID: 0DgC97/TSW+PESVewYg2eA==
X-CSE-MsgGUID: i8P21/paTE+dbGwDle0BkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="306398245"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2026 07:28:23 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v1 1/4] Bluetooth: btintel_pcie: remove duplicate BTINTEL_PCIE_MAGIC_NUM definition
Date: Fri, 28 Aug 2026 19:57:22 +0530
Message-ID: <20260828142725.241243-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two identical definitions of BTINTEL_PCIE_MAGIC_NUM were present in
btintel_pcie.c, one indented with spaces and one with a tab. Remove the
space-indented duplicate and the surrounding blank lines. Kernel coding
style requires tabs for indentation, so keep the tab-indented copy.

No functional change.

Assisted-by: Copilot:claude-opus-4.7 sparse
Fixes: 6ed83047389c ("Bluetooth: btintel_pcie: Setup buffers for firmware traces")
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 30923eaabed7..b90f87e8368d 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -73,11 +73,6 @@ struct btintel_pcie_dev_recovery {
 #define BTINTEL_PCIE_HCI_EVT_PKT	0x00000004
 #define BTINTEL_PCIE_HCI_ISO_PKT	0x00000005
 
-#define BTINTEL_PCIE_MAGIC_NUM    0xA5A5A5A5
-
-
-
-
 #define BTINTEL_PCIE_MAGIC_NUM	0xA5A5A5A5
 
 #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
-- 
2.43.0


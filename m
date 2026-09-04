Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476422157B
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481832; cv=none; b=TAG2xchAtM/a16TlWIxKgB61KUU4zFvBc/XNTa8jFdwRPYuHoLd8Ha2ifnpSqNuk11V0kwR6oAfr86GP1NYOqXioJX3klyu7yr45Q4EL2bImDEOD1k80fpPwM0YsxJMcwJJ4JwjV37D3V+Prcs2fO7/ReKPtYha5cRD/3FB8sug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481832; c=relaxed/simple;
	bh=+6vSCSgiYT9XtF98SPB/A+HJx4VWKkgXnoRmrTyCU08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX2OF4m+HZRSIRjGDJEGOoLGD6NMk5amfvH3nzhJ1IWL9stJeKvw1j+MoUAYYojPZChRO72ejk3jD4IReaj8UcggIR+fYuhYVXQu7eExB9wSPxuiVBNmMoZsUhIxem3Wr80+oUSxA1d9qK0YPeML/1OK9ciy5eScNnFyaGGNPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNQfZY85; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNQfZY85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788481830; x=1820017830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+6vSCSgiYT9XtF98SPB/A+HJx4VWKkgXnoRmrTyCU08=;
  b=lNQfZY85DsuxyYvXkEyVENcusdQR2ZazIVOnG6NiRCvqzSmUqjYMtFzY
   hbJg9y3L1yhPTbjHookCXPd7Ct5H/9crLkp6/ErPMPwEHzQM/GFrvju/K
   2AGTc10ia95A9k9P3hQj3vb/iI3XRkMvVHB6fRz+0qYswDrNWMb+zSBJV
   sZteopWAhh7XUZvu1qpWQ/yRP3QIH6u6T7SlD13Zgxm6yB3LKq0z+EIFp
   ScvxJeJwSpZ1LbkMl5mDm7h5l1rxHyhLKRfDW3G7WCqliOqv1X/5GupAq
   mI5F4Dsml1XoIr3nzm8QLVzI4T4YWwlMzcVcLr2Ny9Bdex4dPWT/ZI5xU
   w==;
X-CSE-ConnectionGUID: yBcelZOkR62bOuUaZH0RQQ==
X-CSE-MsgGUID: eko5HPxJQNO2qYjl6yL4mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92851826"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92851826"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 17:30:30 -0700
X-CSE-ConnectionGUID: ZL3BTcHXQ6eRwCoZ5sqpMg==
X-CSE-MsgGUID: 7VvlzWfoQwWwsUkE7ixqJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="274034608"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa005.jf.intel.com with ESMTP; 03 Sep 2026 17:30:28 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v2 1/3] Bluetooth: btintel_pcie: remove duplicate BTINTEL_PCIE_MAGIC_NUM definition
Date: Fri,  4 Sep 2026 05:59:36 +0530
Message-ID: <20260904002939.622659-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828142725.241243-1-chandrashekar.devegowda@intel.com>
References: <20260828142725.241243-1-chandrashekar.devegowda@intel.com>
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
Changes in v2:
 - No changes; re-sent as part of the v2 series.

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


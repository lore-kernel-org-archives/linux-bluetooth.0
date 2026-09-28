Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9A1368D57
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790571685; cv=none; b=iHiT3fomIWdcjPHPUx+VrAi78Lp7PJH/jB52+3K/Jl//s6ZJActxK06EHpI5iBVv7TrIClk4OiuN7O2mbfgRTw+IeE6pkFKe2cktCBw0ljfD7UzEWLzhjLZu0y1oTeHh4CcM23kNEoMmLhyYFBjU1mQXnubL/O8/ClT1wXb+MmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790571685; c=relaxed/simple;
	bh=FQM/ruADMOym6KGApNEvM7khVNFquULrNY/5y63Kevk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRFGHPMyIdjDgSw9nqbBvhp7z6Kz8PzpMgYpAJdBkOT8Ds+jz+MjkDRpJxj+rrJqSlwJp2geGo06n4YgdicLS3hdbd30OA7ILlItU01Ou0dHFouzem4BetIe+VqY7TWc3Xn7OuhP5P1xrd0hYk9MTk3ERWrWWjcNjPvPOHgvbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTH97hvF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTH97hvF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790571683; x=1822107683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FQM/ruADMOym6KGApNEvM7khVNFquULrNY/5y63Kevk=;
  b=PTH97hvFWVmGcO9pcbOdoNmhe+C6dnftsrpDAV+6a3znpf9qNxxAKUn8
   XJHY+XjIonAHuclnr3gOfzqhHYaGZIeC6PLIlMArZt9CC9/MmoK4Dm+Lc
   JtfSb+NYpztBhe0BgobXDs2VWe5qvn2/zRxy7yU0ZfjUqsFQAQkJZtXrG
   eIaXk/xZQmV7Za4xEMRNLQbFr05CRvrcoOs8tBP5MPdUyJG1lBrHIwWjD
   M1sCYd1seLnxgoacrK50tWDMGBiKXR7s1ucAAsmI9AS/so5AQkmLme/rD
   8VJh1hOAf3gFQfw9TYbSySEKZbAmesnVvfGmzkL/RRvK8WiFraTwuiaox
   A==;
X-CSE-ConnectionGUID: 3pnH9qR0TNSoK9eUEK14Nw==
X-CSE-MsgGUID: XCOJ4o66TYqMlOJ2IBvwSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90127814"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="90127814"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 22:01:23 -0700
X-CSE-ConnectionGUID: a/Y33OhcRReEeQQ1BLPTfw==
X-CSE-MsgGUID: oGkNCmVaRSWvm0S3fOrsZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="312863776"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by orviesa001.jf.intel.com with ESMTP; 27 Sep 2026 22:01:21 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org,
	lsa.uz@pm.me,
	vladimirkondratyev2@gmail.com
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	pmenzel@molgen.mpg.de,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v5 4/4] Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write
Date: Mon, 28 Sep 2026 10:33:44 +0530
Message-ID: <20260928050344.2893790-5-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928050344.2893790-1-ravindra@intel.com>
References: <20260928050344.2893790-1-ravindra@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSIX_HW_INT_CAUSES is a write-one-to-clear register. Using a
read-modify-write helper writes zero to GP0, leaving the cause uncleared,
and can acknowledge unrelated pending causes through the read value.

Write only the GP0 bit directly, matching the interrupt handler's W1C
acknowledgment convention.

Fixes: 88c6216a52ea ("Bluetooth: btintel_pcie: Suspend/Resume: Controller doorbell interrupt handling")
Signed-off-by: Ravindra <ravindra@intel.com>
Tested-by: Sergey Lebedev <lsa.uz@pm.me>
Reviewed-by: Sergey Lebedev <lsa.uz@pm.me>
---
 drivers/bluetooth/btintel_pcie.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 553fa927cf0a..9fda057ca9a1 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -4217,10 +4217,12 @@ static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
 				    "Timeout (%u ms) on alive interrupt for D%d entry, retry count %d",
 				    dx_intr_timeout_ms, dxstate, retry);
 
-			/* clear gp0 cause */
-			btintel_pcie_clr_reg_bits(data,
-						  BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
-						  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
+			/* MSIX_HW_INT_CAUSES is W1C. Write only GP0 so other
+			 * pending causes are not acknowledged here.
+			 */
+			btintel_pcie_wr_reg32(data,
+					      BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
+					      BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
 		}
 
 		/* gp0_received is set at the top of the handler, before the switch on
-- 
2.43.0


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553A7478
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412638; cv=none; b=JWfTmaOcdYJK92bjFIrYsM2Ih9rK3qeB+rTJmaklPtMLkN+4ddtsNYNBDBUDaEAMG9/U0cdQLahE9XV22Aajp0UxkNuoh5fq5WYr3vgwKUbp6J0uayWMpwjSn0Hs8CZu1dmOzKGlKgXlc1YCQ+oEMCLJwf6FIqsrEtFSJx79o9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412638; c=relaxed/simple;
	bh=5JnkC9hE8b9FNppfqevx+gqBenUFuC7BooX9sg+soo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCRa9UzQSc13UNYqdG45WiqshtKomd2m1oZuNefkQ2b/u6BeeT8p1DqxOlt+O3Ji30JjdSxLgVCJOuN7t+/BKAtKbcQL320ekf4tgkYMGm4abXQHksUALxqSqhyZ7roEMgAmzsuMeZ/5HY3bcSOUxIYgOiEjf8IfTNRcutjHH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaZ/cPrO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaZ/cPrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790412636; x=1821948636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5JnkC9hE8b9FNppfqevx+gqBenUFuC7BooX9sg+soo8=;
  b=QaZ/cPrOyeUNABW1Vvppv0Q90efyBAjzA0NlEKdJzSJoJqbcur2yfBYl
   0QWdynqZc+BoxBIQ1oDK4O/ZarspGG0sI3UYm67al5eLkqIHYzCu325yn
   9veob0yJ6P50NR7aFCFpAk4ZDoza3vjjolA8miloHLXV5+fulLuB/hxb8
   qiFKdAGuMvl+5uFY3YY5sPtQ38TaRSVActuMqI1a4TujMemydudg+XHi1
   xV41OpYpk3wtIar4t6S9ndPSQIZbSwPmV5TcGdl1tJpfhVOxubv+eIiGt
   z7bSlFN8ZIUubp6dkr3H93VYjwjrZ/d1tif6XvSkwM30jP/9fHy6KTCsJ
   g==;
X-CSE-ConnectionGUID: qYJdEGo4S0OBAnMnGE7Saw==
X-CSE-MsgGUID: dvgcGQCkQMCR1W7rVGb3Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="89952813"
X-IronPort-AV: E=Sophos;i="6.27,124,1787036400"; 
   d="scan'208";a="89952813"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2026 01:50:36 -0700
X-CSE-ConnectionGUID: bCVPOPlXS4mvax4frn1IFA==
X-CSE-MsgGUID: mBelBw3tTDqRPK3uRnyE2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,124,1787036400"; 
   d="scan'208";a="279264761"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa004.fm.intel.com with ESMTP; 26 Sep 2026 01:50:34 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org,
	lsa.uz@pm.me,
	vladimirkondratyev2@gmail.com
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v4 3/4] Bluetooth: btintel_pcie: verify state after alive interrupt
Date: Sat, 26 Sep 2026 14:23:01 +0530
Message-ID: <20260926085302.2879093-3-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926085302.2879093-1-ravindra@intel.com>
References: <20260926085302.2879093-1-ravindra@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Lebedev <lsa.uz@pm.me>

The gp0_received flag only reports that the GP0 handler ran. It does
not guarantee that the handler completed the requested D-state
transition: a matched case can leave the state unchanged.

Refresh the boot-stage register before treating the transition as
successful. When the controller is in D0 but the handler did not
re-arm the interface, restore the alive context, reset the interface
arrays, restart RX, and complete the mailbox/alive handshake. Propagate
RX setup failures to the PM caller. Likewise, when the controller is in
D3 but the handler did not record it, restore the alive context so the
next transition dispatches correctly.

Signed-off-by: Ravindra <ravindra@intel.com>
Signed-off-by: Sergey Lebedev <lsa.uz@pm.me>
---
 drivers/bluetooth/btintel_pcie.c | 64 ++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 082f5ec8ba71..553fa927cf0a 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -4200,7 +4200,7 @@ static void btintel_pcie_coredump(struct device *dev)
 
 static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
 {
-	int retry = 0;
+	int retry = 0, err;
 	long status;
 	u32 dx_intr_timeout_ms = 200;
 
@@ -4212,30 +4212,62 @@ static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
 		status = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
 			msecs_to_jiffies(dx_intr_timeout_ms));
 
-		if (status)
-			return 0;
-
-		bt_dev_warn(data->hdev,
-			   "Timeout (%u ms) on alive interrupt for D%d entry, retry count %d",
-			   dx_intr_timeout_ms, dxstate, retry);
+		if (!status) {
+			bt_dev_warn(data->hdev,
+				    "Timeout (%u ms) on alive interrupt for D%d entry, retry count %d",
+				    dx_intr_timeout_ms, dxstate, retry);
 
-		/* clear gp0 cause */
-		btintel_pcie_clr_reg_bits(data,
-					  BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
-					  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
+			/* clear gp0 cause */
+			btintel_pcie_clr_reg_bits(data,
+						  BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
+						  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
+		}
 
-		/* A hardware bug may cause the alive interrupt to be missed. Refresh
-		 * boot_stage_cache from hardware, since only the interrupt handler
-		 * updates it. Finally retry only if the state check still fails.
+		/* gp0_received is set at the top of the handler, before the switch on
+		 * alive_intr_ctxt. Error and lockdown are filtered out above it, but a
+		 * matched case can still complete without doing anything - D3 breaks
+		 * unchanged while the controller has not reached D0 - and a hardware
+		 * bug may drop the interrupt outright. Either way the flag says a gp0
+		 * was handled, not that the transition completed, and only the register
+		 * knows. Refresh the cache here and retry only if the state check still
+		 * fails.
 		 */
 		data->boot_stage_cache = btintel_pcie_rd_reg32(data,
 							       BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
 		if (dxstate == BTINTEL_PCIE_STATE_D0) {
-			if (btintel_pcie_in_d0(data))
+			if (btintel_pcie_in_d0(data)) {
+				/* Do what the handler's D3 -> D0 branch
+				 * would have done, unless it already has.
+				 */
+				if (data->alive_intr_ctxt == BTINTEL_PCIE_D0)
+					return 0;
+
+				data->alive_intr_ctxt = BTINTEL_PCIE_D0;
+				btintel_pcie_reset_ia(data);
+				err = btintel_pcie_start_rx(data);
+				if (err)
+					return err;
+
+				/* Complete the mbox<->alive handshake */
+				if (test_and_clear_bit(BTINTEL_PCIE_MBOX_PARSE_PENDING,
+						       &data->flags)) {
+					set_bit(BTINTEL_PCIE_MBOX_PARSE_READY, &data->flags);
+					wake_up(&data->mbox_parse_wait_q);
+				}
+
 				return 0;
+			}
 		} else {
-			if (btintel_pcie_in_d3(data))
+			if (btintel_pcie_in_d3(data)) {
+				/* Do what the handler's D0 -> D3 branch
+				 * would have done, unless it already has.
+				 */
+				if (data->alive_intr_ctxt == BTINTEL_PCIE_D3)
+					return 0;
+
+				data->alive_intr_ctxt = BTINTEL_PCIE_D3;
 				return 0;
+			}
 		}
 
 	} while (++retry < BTINTEL_PCIE_DX_TRANSITION_MAX_RETRIES);
-- 
2.43.0


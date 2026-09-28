Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297A4F3EB4;
	Mon, 28 Sep 2026 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615260; cv=none; b=LKmQkTyKi7rNIPN6ACBcHBEBSeRmJh2QCs+QlIC33/yY22PrMsosOlr37H2ybilVVRYib/QbHFPhshjwRkY8ibNBaJaxe1vTA9ae2RRns1ari/aoBjG0sgdG9Xcf1OlPSileaXeoWY0fWFb9XOKHPzU7WsXq3EpjckF+O/J6Y2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615260; c=relaxed/simple;
	bh=JG7LiyLv+1UFwOX98+syOo4zFyL1gKBzEs+Iu26U0QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwwrpM7tqbLg4Wz1pHSR1QtpkcYMRIcVmWkQYJLlB472p1j34y1tNcsV6ZqxG6YmyTP36mFsHWNOVmIE1nh48L0e1e2NGRByy8oXsqX4pqr1v13Ma8vh1S9WyS8iPxaH0pnWHNhnRUmaXdMQ4bzlHUW0auu/lNCAMaG73K/NYQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e81Ef7LS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e81Ef7LS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790615258; x=1822151258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JG7LiyLv+1UFwOX98+syOo4zFyL1gKBzEs+Iu26U0QA=;
  b=e81Ef7LSL+AZqW9b2e3GZZDyZormgA6Dz3JBg72k1bkzMlJ5jR8lWH6Q
   hv+o2a4S15l6letCwmIEBCkmsxeRMI41T3R85bKv/C77TW9PK7xKmjgHe
   xpyGz+m8dIDfPwGz/+XqDKJvCI5WxP6wchzNKoOBr5zhcUuDWmXiye58Z
   +e8xln+JN4mjawd6UChNJEnswAnZ3gSUplyrw7xqrZeUFx7A8ikmuWf7H
   dG+QQXsH1AzHNGkuyEFbTF1Z74LEXtvki7POb6WQW098U1nBWZhF22Nyq
   M/AthsdP6DS13I9CljIB3/AiykoZofqvXlGdndRKz6skSObk0a7GwafF2
   w==;
X-CSE-ConnectionGUID: VpIRtEKoQgCIySHPBlEn4A==
X-CSE-MsgGUID: jMvoYzjORQ2+foOSoQbGXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="116847880"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="116847880"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 10:07:38 -0700
X-CSE-ConnectionGUID: 9BCyHgmlTXmQzfbsY7rJEg==
X-CSE-MsgGUID: kCuMSS/jQ+mCsIxrIzNc9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275222338"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa008.fm.intel.com with ESMTP; 28 Sep 2026 10:07:36 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: lsa.uz@pm.me,
	pmenzel@molgen.mpg.de,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	linux-kernel@vger.kernel.org,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v6 3/4] Bluetooth: btintel_pcie: verify and serialize D-state transitions
Date: Mon, 28 Sep 2026 22:40:02 +0530
Message-ID: <20260928171003.2925480-4-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928171003.2925480-1-ravindra@intel.com>
References: <20260928171003.2925480-1-ravindra@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Lebedev <lsa.uz@pm.me>

The gp0_received flag only reports that the GP0 handler ran. It does not
contain proof that the handler completed the requested D-state transition:
a matched case can leave the state unchanged.

Refresh the boot-stage register before treating the transition as
successful. When the controller is in D0 but the handler did not re-arm the
interface, restore the alive context, reset the IA, restart RX, and
complete the mailbox/alive handshake. Propagate RX setup failures to the PM
caller. Likewise, when the controller is in D3 but the handler did not
record it, restore the alive context so the next transition dispatches
correctly.

Serialize the alive-context claim between the GP0 handler and the
set_dxstate() fallback with irq_lock. Only the path that claims the D0
transition resets the IA and rearms RX, avoiding concurrent updates to the
shared ring state.

Co-developed-by: Ravindra <ravindra@intel.com>
Signed-off-by: Ravindra <ravindra@intel.com>
Signed-off-by: Sergey Lebedev <lsa.uz@pm.me>
Fixes: 88c6216a52ea ("Bluetooth: btintel_pcie: Suspend/Resume: Controller doorbell interrupt handling")
Tested-by: Sergey Lebedev <lsa.uz@pm.me>
---
 drivers/bluetooth/btintel_pcie.c | 80 +++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 082f5ec8ba71..a5b0576e922c 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1975,6 +1975,10 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
 	submit_rx = false;
 	signal_waitq = false;
 
+	/* Serialize the alive_intr_ctxt claim against set_dxstate()'s
+	 * register-based fallback, which can run concurrently.
+	 */
+	spin_lock(&data->irq_lock);
 	switch (data->alive_intr_ctxt) {
 	case BTINTEL_PCIE_ROM:
 		data->alive_intr_ctxt = BTINTEL_PCIE_FW_DL;
@@ -2030,6 +2034,7 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
 			   data->alive_intr_ctxt);
 		break;
 	}
+	spin_unlock(&data->irq_lock);
 
 	if (submit_rx) {
 		btintel_pcie_reset_ia(data);
@@ -4200,7 +4205,7 @@ static void btintel_pcie_coredump(struct device *dev)
 
 static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
 {
-	int retry = 0;
+	int retry = 0, err;
 	long status;
 	u32 dx_intr_timeout_ms = 200;
 
@@ -4212,30 +4217,73 @@ static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
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
+				bool armed;
+
+				/* Claim the transition under irq_lock so a
+				 * concurrent gp0 handler run cannot also arm RX.
+				 */
+				spin_lock(&data->irq_lock);
+				armed = data->alive_intr_ctxt == BTINTEL_PCIE_D0;
+				if (!armed)
+					data->alive_intr_ctxt = BTINTEL_PCIE_D0;
+				spin_unlock(&data->irq_lock);
+
+				if (armed)
+					return 0;
+
+				/* Do what the handler's D3 -> D0 branch
+				 * would have done, unless it already has.
+				 */
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
+				spin_lock(&data->irq_lock);
+				if (data->alive_intr_ctxt != BTINTEL_PCIE_D3)
+					data->alive_intr_ctxt = BTINTEL_PCIE_D3;
+				spin_unlock(&data->irq_lock);
+
 				return 0;
+			}
 		}
 
 	} while (++retry < BTINTEL_PCIE_DX_TRANSITION_MAX_RETRIES);
-- 
2.43.0


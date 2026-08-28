Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDCF46AA8C
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927314; cv=none; b=X2pHvZl1SjDEolVG6y9XHMyf978jUksi9pfXU4ReT2xjW0wKKDVKCOKNShdyS+PDu7R5W2BHbZ+9iK06l48JnMVHhOGVfD7X3xESi5TICE/jdfqIa+XrS2RY9JbZB0LtqN4PT9+p3za+GAJ7HFEAA9xeTsDzDfw8Ail45+s9888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927314; c=relaxed/simple;
	bh=U/CIDNRVhIcIL2wweedom/2PRCCMPZS4xjUPBMnkZ5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3YsNeve9EYQNhG8vV9MDQhK0Igqi/IxLhJ3pSQzeejG1MrIyobgkYTJ5A4Cu2sqtR6qFbbiSYe0fXM6swHx7mer3YptW2ndHURhDP+RL70cfSrlwUk+plV93DRFdMrOJP3KlpFuN68J0VNjRx+psbAXnkRaT5XasqsQ6NCKkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVCVeqf8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVCVeqf8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787927310; x=1819463310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U/CIDNRVhIcIL2wweedom/2PRCCMPZS4xjUPBMnkZ5g=;
  b=WVCVeqf8RcJuBwURV+XEL4m0MMb9UrlzcI3EvylJZps1rzc0KgZUAnNK
   G/PVW6Qqro+lEjhHJC4TO9KHBezdxRXhl6br35COCPXaF99bJbPF0Jd2/
   K+iC3H3Js7tC04HNQOKS8gFOLbUkKSwBI6beRSMs0D2/FvTwOmsb/OS3/
   Bd6PDutKkSlKAzAjM0TZ3CcZ4NJOVAIQsEUHnv6KTSGzNBg9syG8IBnzG
   oKK2K2RGOiNwHyxtCCmUBlW7QlZIioVRs+xaG/oKDYhgwA9mXJuISMb2h
   rA5s8O4PrVTPsfFJlI8yUliB/0icqIHmY+Xm1MI4iyLZwvdMU7PUcUya4
   Q==;
X-CSE-ConnectionGUID: U/fmyrkIQB2fK46e022C5A==
X-CSE-MsgGUID: 2PNvK5r1TM6R6g2fOyvEsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="105811870"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="105811870"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 07:28:30 -0700
X-CSE-ConnectionGUID: viUgKf3LSK+OhblrurmW3g==
X-CSE-MsgGUID: ssqddjoAQ5uB8R/tHRzKag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="306398255"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2026 07:28:29 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v1 3/4] Bluetooth: btintel_pcie: log mailbox handler latency in msix_gp1_handler
Date: Fri, 28 Aug 2026 19:57:24 +0530
Message-ID: <20260828142725.241243-3-chandrashekar.devegowda@intel.com>
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

Add ktime-based measurement around btintel_pcie_msix_gp1_handler() so
the time taken to service the mailbox interrupt and acknowledge the FW
can be observed via bt_dev_dbg. Drop the informational log emitted on
every mailbox interrupt (it is noisy at bt_dev_info level and the same
timestamp is now available through the new debug print) and collapse a
couple of over-wrapped lines for readability.

No functional change beyond the log verbosity adjustment.

Assisted-by: Copilot:claude-opus-4.7 sparse
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 0946364a63ba..6617ad157ca0 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1331,6 +1331,10 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
 {
 	bool target_access = false;
 	u32 addr = 0, size = 0;
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+
+	calltime = ktime_get();
 
 	/* Read the Mail box status and registers */
 	data->mbox.mbox_status = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MBOX_STATUS_REG);
@@ -1338,8 +1342,7 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
 		data->mbox.mbox1 = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MBOX_1_REG);
 		if (data->mbox.mbox1 ==
 		    BTINTEL_PCIE_BUILD_SPECIFIC_RESOURCES_MAPPING) {
-			bt_dev_info(data->hdev,
-				    "mailbox for target access");
+			bt_dev_info(data->hdev, "mailbox for target access");
 			target_access = true;
 		}
 	}
@@ -1373,10 +1376,6 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
 		set_bit(BTINTEL_PCIE_MBOX_PARSE_PENDING, &data->flags);
 		data->mbox_intr_ts = ktime_get();
 
-		bt_dev_info(data->hdev,
-			    "mbox interrupt received at %lld ns; queuing mbox_work",
-			    ktime_to_ns(data->mbox_intr_ts));
-
 		WRITE_ONCE(data->debug_table_addr, addr);
 		WRITE_ONCE(data->debug_table_size, size);
 		if (!queue_work(data->dump_workqueue,
@@ -1387,9 +1386,13 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
 	}
 
 	/* Mailbox is read, ack to FW */
-	btintel_pcie_set_reg_bits(data,
-				  BTINTEL_PCIE_CSR_IPC_DOORBELL_VEC_REG,
+	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_IPC_DOORBELL_VEC_REG,
 				  BTINTEL_PCIE_CSR_DOORBELL_MBOX_READ_CONFIRM);
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+	bt_dev_dbg(data->hdev, "Mailbox acked in %llu usecs", duration);
 }
 
 /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
-- 
2.43.0


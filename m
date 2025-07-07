Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E392F1E48A
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751859027; cv=none; b=ETDydGbd2PrDlsoUH/XkhdJPYWYyWrtMeujbeFCwUob+ullR5kCcs92WTaIZ/o43mp/If+xU5mlCtp2ZQDDc83p7hOGR55d35Cj8vthAlqkM8nZ3qBwMJ+SeUN4druudQcZc7CHVp0l9ogMwFNAMfd/c31G6m7+gVv9K5g1JgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751859027; c=relaxed/simple;
	bh=InLn7A2YlAhV57wokox8y4A6sdxX0K1AvFRwCTkaHjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7lczjtiKxcvbBgr/F8mWTx6gVOS51kDiyyKmbP43SRDqd8zRyU5zdvE5Z3FhXNWD0vt+rqgCdyEXOVAqC39+5xyIn9WgUmFfnwwn7z+ThljmS9kbVveObHauVqUnvc9TZa6IzgAgMcShwcMY6JhzAm4Vr5kN248eacR9KWGFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDLfrL3m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDLfrL3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751859026; x=1783395026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=InLn7A2YlAhV57wokox8y4A6sdxX0K1AvFRwCTkaHjk=;
  b=cDLfrL3m/uzx4FZx0j8rLmm7BGzK1bKaVcP4exbAZuc4Kh2OVhNJ1pR7
   NhWCM5XhxBkf9MXL+T+W3dmHCsEjTYYs22+r2sS1pYTYyOS3kz23ODQYW
   qPa/QXzwciNwDkTKHEi026VQ6Hhf9UCIno92Q8JGntLh2Mobc7n3tABZc
   uqKEe3BlK1QoQHqpXXtO3rWxMxAafkH9zQFkirzofik3D9md5TzciwRt1
   22RxwFJW/SDRnkxcV0MRFfYOC3pUFcJ+Ew47jowSbWXEZLIFO5qrxEkaR
   izMtvmZDi7ikdZ3FVAwdZV4TXkicbHpF+09iaMS+0fw8SxfeUOr3/02x3
   g==;
X-CSE-ConnectionGUID: mOYQF5UNQ6CdpKyhd7/CNQ==
X-CSE-MsgGUID: DC780QcJRaiI9dEMow0LTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="79507174"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="79507174"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2025 20:30:26 -0700
X-CSE-ConnectionGUID: 2QLAuuwgSpi9zE6oaXkA+Q==
X-CSE-MsgGUID: oL3xEATaTfuB7fE6BqfbNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="159451541"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa003.jf.intel.com with ESMTP; 06 Jul 2025 20:30:24 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix alive context state handling
Date: Mon,  7 Jul 2025 09:16:57 +0530
Message-ID: <20250707034657.929092-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707034657.929092-1-kiran.k@intel.com>
References: <20250707034657.929092-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware raises alive interrpt on sending 0xfc01 command. Alive context
maintained in driver needs to be updated before sending 0xfc01 (Intel
Reset) or 0x03c0 (HCI Reset) to avoid the potential race condition where
the context is also updated in threaded irq.

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Fixes: 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
---
 drivers/bluetooth/btintel_pcie.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index f893ad6fc87a..d29103b102e4 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1988,10 +1988,6 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 				btintel_pcie_inject_cmd_complete(hdev, opcode);
 		}
 
-		/* Firmware raises alive interrupt on HCI_OP_RESET or 0xfc01*/
-		if (opcode == HCI_OP_RESET || opcode == 0xfc01)
-			data->gp0_received = false;
-
 		hdev->stat.cmd_tx++;
 		break;
 	case HCI_ACLDATA_PKT:
@@ -2012,6 +2008,20 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 	memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &type,
 	       BTINTEL_PCIE_HCI_TYPE_LEN);
 
+	if (type == BTINTEL_PCIE_HCI_CMD_PKT) {
+		/* Firmware raises alive interrupt on HCI_OP_RESET or 0xfc01*/
+		if (opcode == HCI_OP_RESET || opcode == 0xfc01) {
+			data->gp0_received = false;
+			old_ctxt = data->alive_intr_ctxt;
+			data->alive_intr_ctxt =
+				(opcode == 0xfc01 ? BTINTEL_PCIE_INTEL_HCI_RESET1 :
+					BTINTEL_PCIE_HCI_RESET);
+			bt_dev_dbg(data->hdev, "sending cmd: 0x%4.4x alive context changed: %s  ->  %s",
+				   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
+				   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
+		}
+	}
+
 	ret = btintel_pcie_send_sync(data, skb);
 	if (ret) {
 		hdev->stat.err_tx++;
@@ -2021,13 +2031,6 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 
 	if (type == BTINTEL_PCIE_HCI_CMD_PKT &&
 	    (opcode == HCI_OP_RESET || opcode == 0xfc01)) {
-		old_ctxt = data->alive_intr_ctxt;
-		data->alive_intr_ctxt =
-			(opcode == 0xfc01 ? BTINTEL_PCIE_INTEL_HCI_RESET1 :
-				BTINTEL_PCIE_HCI_RESET);
-		bt_dev_dbg(data->hdev, "sent cmd: 0x%4.4x alive context changed: %s  ->  %s",
-			   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
-			   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
 		ret = wait_event_timeout(data->gp0_wait_q,
 					 data->gp0_received,
 					 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
-- 
2.43.0


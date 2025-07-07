Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21689F510
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751859025; cv=none; b=lJVM5wtMd1gTB4raWhwRTPJ8GvA5oq5aehmSgVPK29jcSCcRKGgFue34B5BUcJh6qkAPjllKyTR2Xy7mXWNj2AbQ8swSTzqbkjwT8Y8et4tTKmbGXMxyoySb5UMVPdsF/5DhOi9TvBS2My5aggDa1NsHIX8H1cgmNVG4wcNJ7zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751859025; c=relaxed/simple;
	bh=SGQZFaJu+EoiqC+B/HYWqatTcjbOdNYVYkUJWooOyWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPilvTHkC8kiTHKxfIYK3r1sui+4i84y8Nz3hR1TmcPb8RJb7gMxFBYsPEhahEkdFKY7P9kmoRb6267uh+GjDy3mXyvbzD7ipqMpeaXhBd2PTLE3pxLWmm469zwyRjCm86989xujSrNDAAih2TLTfzMoMj52vYfYXqopClNOu8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emZwbb+y; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emZwbb+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751859024; x=1783395024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SGQZFaJu+EoiqC+B/HYWqatTcjbOdNYVYkUJWooOyWI=;
  b=emZwbb+y2B7S4enK1FyKCM6g6f5iah3gMFEysiBXsEPnzCTY2krDZ/ah
   7J1hjeB9Nfpd3LwWzT3kKbtJaNyrcWlvWjJk1ihHF3aCmUxK1Iq44oVAP
   8pn6Sy2im9gGC0jK4D+lGneMHWWQqN/c9+3cdJW4h2nw1aeYxxutwh8kc
   LNyq3HhuNqBE1GCqDAtj9IFaDV14+Yq9RW8jDkVTW2jUlTXAytjTmRuZK
   nGBSVkZla7CLOkRK0kOpqbhNCW5utT1GeaXc7f4meK42ZkRqZjZvP48Sm
   YUN1IR4fCOdYrmpsL1cuxBwDIyk7LLM7OC+rLZ9Jr485/COPwEWsq17Wj
   Q==;
X-CSE-ConnectionGUID: 9QGpZ/psRei6fpcUlJ/aOg==
X-CSE-MsgGUID: hfXvwUJHRr6ko77gnPcZ6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="79507173"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="79507173"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2025 20:30:24 -0700
X-CSE-ConnectionGUID: KHHu9iPQS7WXPt1X9ZA7CQ==
X-CSE-MsgGUID: 3/Ka3bkhTceitjYUyhVyTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="159451538"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa003.jf.intel.com with ESMTP; 06 Jul 2025 20:30:22 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel_pcie: Make driver wait for alive interrupt
Date: Mon,  7 Jul 2025 09:16:56 +0530
Message-ID: <20250707034657.929092-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware raises an alive interrupt upon receiving the 0xfc01 (Intel
reset) command. This change fixes the driver to properly wait for the
alive interrupt.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Fixes: 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
---
 drivers/bluetooth/btintel_pcie.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 1113a6310bd0..f893ad6fc87a 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -947,11 +947,13 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
 	case BTINTEL_PCIE_INTEL_HCI_RESET1:
 		if (btintel_pcie_in_op(data)) {
 			submit_rx = true;
+			signal_waitq = true;
 			break;
 		}
 
 		if (btintel_pcie_in_iml(data)) {
 			submit_rx = true;
+			signal_waitq = true;
 			data->alive_intr_ctxt = BTINTEL_PCIE_FW_DL;
 			break;
 		}
@@ -1985,8 +1987,9 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 			if (opcode == 0xfc01)
 				btintel_pcie_inject_cmd_complete(hdev, opcode);
 		}
-		/* Firmware raises alive interrupt on HCI_OP_RESET */
-		if (opcode == HCI_OP_RESET)
+
+		/* Firmware raises alive interrupt on HCI_OP_RESET or 0xfc01*/
+		if (opcode == HCI_OP_RESET || opcode == 0xfc01)
 			data->gp0_received = false;
 
 		hdev->stat.cmd_tx++;
@@ -2025,17 +2028,15 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 		bt_dev_dbg(data->hdev, "sent cmd: 0x%4.4x alive context changed: %s  ->  %s",
 			   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
 			   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
-		if (opcode == HCI_OP_RESET) {
-			ret = wait_event_timeout(data->gp0_wait_q,
-						 data->gp0_received,
-						 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
-			if (!ret) {
-				hdev->stat.err_tx++;
-				bt_dev_err(hdev, "No alive interrupt received for %s",
-					   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
-				ret = -ETIME;
-				goto exit_error;
-			}
+		ret = wait_event_timeout(data->gp0_wait_q,
+					 data->gp0_received,
+					 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
+		if (!ret) {
+			hdev->stat.err_tx++;
+			bt_dev_err(hdev, "No alive interrupt received for %s",
+				   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
+			ret = -ETIME;
+			goto exit_error;
 		}
 	}
 	hdev->stat.byte_tx += skb->len;
-- 
2.43.0


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35053288C80
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090087; cv=none; b=IfVnrRqFPcmMJdLL+81n056g4vLgQ3GveIodgr7VLVxEclz+Iwoxc28Ww1Pq/VXn0xxKA3ryHTaKhb6L+pjGfBPMrFgC9SScVccLgcmqdiBpILQWYkoKzDscxbTm/fRLXARLBrpM30A/in5cStOqWiF15Xa4a3eaxBQ8WlkAnso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090087; c=relaxed/simple;
	bh=EWD0cYGxwzzRZPhmO/8gXWwc7DVvxoV6Q+oTZ9arS2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZlSjhppQyLphfrRpoxdpwDgipm0wzDnzeQew9oAi7wEJ/H8MYHdp3lbQDj0pHs7oLLIwTUzkhbcH8tFT9pRq8JSkgh1x7ztEWBnqJamS/jzMyttj39P7GYVKsVwbbB8seZnQWA3wmALy0jZpEt9N1Ttub2VjEU7fiMP8MnqvqKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJYaqJ6y; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJYaqJ6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753090086; x=1784626086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EWD0cYGxwzzRZPhmO/8gXWwc7DVvxoV6Q+oTZ9arS2g=;
  b=cJYaqJ6y7zTyLK/0AHdctPMnurB8y+vwiRAT77Vjsos4DV5NumhJHQsT
   6PspB4T3bSrByXZYN/D3fZXJFjYIJsIhBcMV3k/mFEZEeZ9wl/+idwz/p
   LrhPNK/KXeEPElS+zvcQG7q5ZsEoC6dPc24AdBsilvP+gfout5ggtt2Gw
   SJEdESnKvXknhs4YOSVKnm4kn+auoK/olBinMzCTkrrmoxVNT+/erMp9I
   CYJwysV+HpIKiYYlgAQ55PkcKesgeICK3Eit3QwUGp5EbvKPxoAr2qQm2
   EaOGElfxZa9qphVwr+nXj/Cikv6YZUqFUmeIYQM3mLAU6qQFZ0qfXkBa6
   w==;
X-CSE-ConnectionGUID: R/BQ/IBqQ+KvSlk9+b/FvA==
X-CSE-MsgGUID: 0HlwzozQRHOZTYB8BLA9uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="65558491"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="65558491"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 02:28:06 -0700
X-CSE-ConnectionGUID: lQajFbXlSXmyDnMqPZwpUw==
X-CSE-MsgGUID: EliOqV8FQ2CDVr8UYD9taw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="182493031"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2025 02:28:04 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 1/2] Bluetooth: btintel_pcie: Make driver wait for alive interrupt
Date: Mon, 21 Jul 2025 15:14:36 +0530
Message-ID: <20250721094437.1163753-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware raises an alive interrupt upon receiving the HCI_RESET or
BTINTEL_HCI_OP_RESET (Intel reset - 0xfc01) command. This change fixes
the driver to properly wait for the alive interrupt to avoid driver
sending commands to firmware before it is ready to process.

For details on the handshake between the driver and firmware, refer to
commit 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between
driver and firmware").

As the driver needs to handle two interrupts for HCI_OP_RESET and
BTINTEL_HCI_OP_RESET, the firmware ensures that the TX completion
interrupt is always followed by the alive interrupt.

Fixes: 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v3:
- No change
changes in v2:
- Address review comments


 drivers/bluetooth/btintel_pcie.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 60528bdc4316..a17c438784ae 100644
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
@@ -1985,8 +1987,11 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 			if (opcode == BTINTEL_HCI_OP_RESET)
 				btintel_pcie_inject_cmd_complete(hdev, opcode);
 		}
-		/* Firmware raises alive interrupt on HCI_OP_RESET */
-		if (opcode == HCI_OP_RESET)
+
+		/* Firmware raises alive interrupt on HCI_OP_RESET or
+		 * BTINTEL_HCI_OP_RESET
+		 */
+		if (opcode == HCI_OP_RESET || opcode == BTINTEL_HCI_OP_RESET)
 			data->gp0_received = false;
 
 		hdev->stat.cmd_tx++;
@@ -2025,17 +2030,16 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
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
+			bt_dev_err(hdev, "Timeout on alive interrupt (%u ms). Alive context: %s",
+				   BTINTEL_DEFAULT_INTR_TIMEOUT_MS,
+				   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
+			ret = -ETIME;
+			goto exit_error;
 		}
 	}
 	hdev->stat.byte_tx += skb->len;
-- 
2.43.0


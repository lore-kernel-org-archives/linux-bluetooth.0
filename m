Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637331B85FD
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546956; cv=none; b=NPICA8HrSrOqe40OBkACGfQdv5hCnER9/+9IRLNdWyhTTvI0gDhhHYrA2jw1goiwCA4S3N2lJQVtz5IdK4+OiSixqI6DI2s+mXyP9zLbQs8MXlzrMKmNHsXz8XKNW/hWvm78F5QUjLM8FLXA6I4KetzsPcu5OmAucZaRpXwbakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546956; c=relaxed/simple;
	bh=OyGf8/MSUZBnsbq7n/cGkR7A122zocSxMTNP5Qd912U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGdxVvxDe++uM9EY2IzjZWHrDZzpf283tK9YqPx7ot/mlX+UtoSRuoKjnanWQSVQX/LK99BQOZCeJQ5EKlyuoiLG5IjmdA8UMwu6uZFEskb6LAIdBgxJSstIGTrXn6MH+P7IiinzDjvxf+G0E71MoUAKms2tRh8l60tB05ZHUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlUGvlsb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlUGvlsb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752546955; x=1784082955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OyGf8/MSUZBnsbq7n/cGkR7A122zocSxMTNP5Qd912U=;
  b=jlUGvlsbBEQRLC4r5wySfCKl++lPepQJqBTDcI9cpTcEqPiR6/ZPElfO
   yDVBbV17n8sUBgzHrXG7pKWQryR1a74hYNyaDbWPignORIJ8effxBKygQ
   Invzx/A5S8UN12hrF9aiTlxh6PAEHduqXoFKW/3yuy7xDQyNL+IUJ0bwf
   p6HlzXdysYBZhyMneKjKmpKt5Az1GK98JQd6/opi1bWRIWzf6qI6QqHdG
   4mMih5xIjBClbdbRPD+xQMO4F6q2eFMykJPqUnBxsXK/l+IOsPsWaeU53
   9noDXkijbtzlHyu4xjvSObHQB3nGbTXd+IRMPZTnwXblP4/rSVGRbCSXj
   A==;
X-CSE-ConnectionGUID: +9P/lne+S4inNAMA9u59ew==
X-CSE-MsgGUID: 1I/1Rw7rQ+WWhk5gFtUXnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54460687"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="54460687"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 19:35:54 -0700
X-CSE-ConnectionGUID: 4brp+uHqTbuMSHvPpGYuIA==
X-CSE-MsgGUID: L08Ez3GURJ2h1bg5yXfV6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157194054"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa006.fm.intel.com with ESMTP; 14 Jul 2025 19:35:52 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 2/2] Bluetooth: btintel_pcie: Fix Alive Context State Handling
Date: Tue, 15 Jul 2025 08:22:17 +0530
Message-ID: <20250715025217.1005089-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715025217.1005089-1-kiran.k@intel.com>
References: <20250715025217.1005089-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware raises an alive interrupt upon sending the HCI_RESET or
BTINTEL_HCI_OP_RESET command. As part of handling the reset command,
firmware initializes the hardware and data path and raises the alive
interrupt. Upon receiving the alive interrupt, the driver must enable
the data path and grant RX buffers to the firmware before sending any
commands.

The alive context maintained in the driver must be updated before
sending BTINTEL_HCI_OP_RESET or HCI_OP_RESET to prevent a potential race
condition where the context is also updated in the threaded IRQ.

The issue was observed in a stress reboot usecase (1/25) using "sudo
reboot" command where the firmware download was failing as the driver
was not granting RX buffer to firmware due to race condition.

Bluetooth: hci0: API lock is disabled
Bluetooth: hci0: Debug lock is disabled
Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Bluetooth: hci0: Bootloader timestamp 2023.43 buildtype 1 build 11631
Bluetooth: hci0: Found device firmware: intel/ibt-00a0-00a1-iml.sfi
Bluetooth: hci0: Boot Address: 0xb0301000
Bluetooth: hci0: Firmware Version: 167-12.25
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 99902 usecs
Bluetooth: hci0: Alive context: fw_dl old_boot_stage: 0xa0db0003
           new_boot_stage: 0xa0db0003
Bluetooth: hci0: sent cmd: 0xfc01 alive context changed:
           fw_dl  ->  intel_reset1
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device boot timeout
Bluetooth: hci0: Firmware download retry count: 1

Fixes: 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index a17c438784ae..6680ef3207ed 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1988,12 +1988,6 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 				btintel_pcie_inject_cmd_complete(hdev, opcode);
 		}
 
-		/* Firmware raises alive interrupt on HCI_OP_RESET or
-		 * BTINTEL_HCI_OP_RESET
-		 */
-		if (opcode == HCI_OP_RESET || opcode == BTINTEL_HCI_OP_RESET)
-			data->gp0_received = false;
-
 		hdev->stat.cmd_tx++;
 		break;
 	case HCI_ACLDATA_PKT:
@@ -2014,6 +2008,21 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 	memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &type,
 	       BTINTEL_PCIE_HCI_TYPE_LEN);
 
+	if (type == BTINTEL_PCIE_HCI_CMD_PKT &&
+	    (opcode == HCI_OP_RESET || opcode == BTINTEL_HCI_OP_RESET)) {
+		/* Firmware raises alive interrupt on HCI_OP_RESET or
+		 * BTINTEL_HCI_OP_RESET
+		 */
+		data->gp0_received = false;
+		old_ctxt = data->alive_intr_ctxt;
+		data->alive_intr_ctxt =
+			(opcode == 0xfc01 ? BTINTEL_PCIE_INTEL_HCI_RESET1 :
+					BTINTEL_PCIE_HCI_RESET);
+		bt_dev_dbg(data->hdev, "sending cmd: 0x%4.4x alive context changed: %s -> %s",
+				opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
+				btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
+	}
+
 	ret = btintel_pcie_send_sync(data, skb);
 	if (ret) {
 		hdev->stat.err_tx++;
@@ -2023,13 +2032,6 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 
 	if (type == BTINTEL_PCIE_HCI_CMD_PKT &&
 	    (opcode == HCI_OP_RESET || opcode == BTINTEL_HCI_OP_RESET)) {
-		old_ctxt = data->alive_intr_ctxt;
-		data->alive_intr_ctxt =
-			(opcode == BTINTEL_HCI_OP_RESET ? BTINTEL_PCIE_INTEL_HCI_RESET1 :
-				BTINTEL_PCIE_HCI_RESET);
-		bt_dev_dbg(data->hdev, "sent cmd: 0x%4.4x alive context changed: %s  ->  %s",
-			   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
-			   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
 		ret = wait_event_timeout(data->gp0_wait_q,
 					 data->gp0_received,
 					 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
-- 
2.43.0


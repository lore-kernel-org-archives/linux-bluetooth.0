Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C2A126F0A
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546954; cv=none; b=lG1EHAJMgPfKr2WCS6WAm/vAu8M0GI2Z9VK/NjeV+hKPNp0oeidF/CIiJffIJxAEG/KNHJkaROeT/1v5Ew24ZGycZ7A7ZvjZfMvZVYr/HIzjgeNktgHGX9mHeB2O8xWAWzy4zpdcQdr4IzEB7og05c/2OIx9j0dtr1MQkidVS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546954; c=relaxed/simple;
	bh=jmL+aj4u0AN6bkpbzgK4Ww/H4UtlIhxAgA8DXfaU1Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqNIlaqQ9UuUZ1cA7BT0PHwoYVVTvzGToStPZXmKjT0hK9PiKWlkDSoLF3I+REG7MLROzWg8E+tLpAtJC4BB1ut29VKYLJVAfUFpPeJT93JPTvfHWzK1n8i329VwJp9c4owZoa4k1TtsMJi3hyjRlyrW/508Zu24x6AWq62E9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqhdhjgv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqhdhjgv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752546953; x=1784082953;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jmL+aj4u0AN6bkpbzgK4Ww/H4UtlIhxAgA8DXfaU1Q8=;
  b=eqhdhjgvdFC0VVZejXn6r1kS5zL8eO2Ps+Ie5Xu34Yi9/CNi5yQn2fjg
   l1/xZrDZ6k08UpZi+lRV6bus+NXW967XELDX1IDLyhQj20me1oGY9eCzo
   h9UUxl0X660naZKfK3lpBK+QRxHaa0f5aNKT3fG4a9ewdUEu+4VG5FLxV
   c6NILd16VQ/2bU3BrGvOJGiy5Kt02TwY9s0JmkJtlQsJvMsFoBYaqXdiI
   0eU6dXYHGfWuXX3rb6Lr+6I2JM9HCbLyraPYbc+IR4JHj9P27uzTmuSo7
   LKU8uI7dtfsZTW+e/ArtgsMhRmIklITVXIhBSY2HnxtYeU+xAWdjk7DuI
   A==;
X-CSE-ConnectionGUID: bu91QB72QByxrjQwaPnDMA==
X-CSE-MsgGUID: 0aiW+uDqSqaCAY1dyq1LpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54460683"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="54460683"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 19:35:52 -0700
X-CSE-ConnectionGUID: chNK5Gs9STqOeRDfz+23nA==
X-CSE-MsgGUID: iGdsk8pvSyWBA0ETE1RDqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157194036"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa006.fm.intel.com with ESMTP; 14 Jul 2025 19:35:50 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 1/2] Bluetooth: btintel_pcie: Make driver wait for alive interrupt
Date: Tue, 15 Jul 2025 08:22:16 +0530
Message-ID: <20250715025217.1005089-1-kiran.k@intel.com>
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


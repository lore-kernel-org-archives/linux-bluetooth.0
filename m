Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00350207E1D
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227522; cv=none; b=N8u2S+AhbvbSYNDxVE1F/7fdDeO0FIPzz/3m4dTVc8Jh1my0Ad25RSlOKI5lsSvkfu2MP8Hde3JQQdSugX+C93nOyrG6WX5JuPxEFd4+wTymNeLrBzs5N+S3zxcIdOJgbSCPrD35jJY2mhGVmawaAFn9a3sMm12CDI4+0l5MmCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227522; c=relaxed/simple;
	bh=XptooG4uIt0rlRwvknuW8slWvpRFV5BOyTcjwbrMBO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNSNW5CeD8yh4csnFmSj5E4tiLWAwc5nJJEcuUNNvmy+/UGv6SO4rTBLfwSFxU9XrcgoAx7RYHR02e+2k4bMbb4I5DTQTR02oUgeYten7YxmgpqLVF7NDN+d3oriJMdn0LlNOJGJktjMgti8gbq4z5lxzSAe32k96COgY58R2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFwXHA3y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFwXHA3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752227521; x=1783763521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XptooG4uIt0rlRwvknuW8slWvpRFV5BOyTcjwbrMBO0=;
  b=SFwXHA3y7K1Bvyr1UyTuP+dNWR6gafZFZ++khxFX/EWzBhwGhJLYdh72
   diXzdaMf1DmjvHN/ETW6/p4Chp5dPmFW2QP3KDPJGvSJ1wAf9iSat9Kep
   jDgrUJcbRfpuHnhjWgF6bqsFsE7q/ZHy/a/pijLMtdnGDytyuCCZ44Svj
   nTWOaEAuiAsppX7X36fzv8CNpIwjAjJ+BL6NdKrAh4NbvzGJZ/+qzqx3h
   9OFnhbGszYkmlUV78D3b5I5Y/RG9hMlLcaIc8yqvW6ORdbCn71F1DMj2D
   sgvEsal/D4FNv4UyVWTnsSO0YiA08YU2q6XcCcwnIcM71wWTT6+Z9q2/O
   w==;
X-CSE-ConnectionGUID: UszcA+/bS2+NlbGR8nTJjA==
X-CSE-MsgGUID: C5unCbvbQMK3Lpi2W5nk9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="53742787"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="53742787"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:50:52 -0700
X-CSE-ConnectionGUID: seunI/pxQtewEmbGcR6w2Q==
X-CSE-MsgGUID: YSkCPdNgTYaqgFCGsdyVLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="160877982"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 11 Jul 2025 02:50:51 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Define a macro for Intel Reset vendor command
Date: Fri, 11 Jul 2025 15:37:25 +0530
Message-ID: <20250711100725.956159-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use macro for Intel Reset command (0xfc01) instead of hard coded value.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      |  4 ++--
 drivers/bluetooth/btintel.h      |  2 ++
 drivers/bluetooth/btintel_pcie.c | 12 ++++++------
 drivers/bluetooth/btusb.c        |  8 ++++----
 drivers/bluetooth/hci_intel.c    | 10 +++++-----
 5 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 06575a0b9aee..50eebbec4cf4 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -889,7 +889,7 @@ int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param)
 
 	params.boot_param = cpu_to_le32(boot_param);
 
-	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(params), &params,
+	skb = __hci_cmd_sync(hdev, BTINTEL_HCI_OP_RESET, sizeof(params), &params,
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to send Intel Reset command");
@@ -1287,7 +1287,7 @@ static void btintel_reset_to_bootloader(struct hci_dev *hdev)
 	params.boot_option = 0x00;
 	params.boot_param = cpu_to_le32(0x00000000);
 
-	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(params),
+	skb = __hci_cmd_sync(hdev, BTINTEL_HCI_OP_RESET, sizeof(params),
 			     &params, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "FW download error recovery failed (%ld)",
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 1d12c4113c66..431998049e68 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -52,6 +52,8 @@ struct intel_tlv {
 	u8 val[];
 } __packed;
 
+#define BTINTEL_HCI_OP_RESET	0xfc01
+
 #define BTINTEL_CNVI_BLAZARI		0x900
 #define BTINTEL_CNVI_BLAZARIW		0x901
 #define BTINTEL_CNVI_GAP		0x910
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 1113a6310bd0..04cec76ff5c5 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1977,12 +1977,12 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 			struct hci_command_hdr *cmd = (void *)skb->data;
 			__u16 opcode = le16_to_cpu(cmd->opcode);
 
-			/* When the 0xfc01 command is issued to boot into
-			 * the operational firmware, it will actually not
-			 * send a command complete event. To keep the flow
+			/* When the BTINTEL_HCI_OP_RESET command is issued to
+			 * boot into the operational firmware, it will actually
+			 * not send a command complete event. To keep the flow
 			 * control working inject that event here.
 			 */
-			if (opcode == 0xfc01)
+			if (opcode == BTINTEL_HCI_OP_RESET)
 				btintel_pcie_inject_cmd_complete(hdev, opcode);
 		}
 		/* Firmware raises alive interrupt on HCI_OP_RESET */
@@ -2017,10 +2017,10 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 	}
 
 	if (type == BTINTEL_PCIE_HCI_CMD_PKT &&
-	    (opcode == HCI_OP_RESET || opcode == 0xfc01)) {
+	    (opcode == HCI_OP_RESET || opcode == BTINTEL_HCI_OP_RESET)) {
 		old_ctxt = data->alive_intr_ctxt;
 		data->alive_intr_ctxt =
-			(opcode == 0xfc01 ? BTINTEL_PCIE_INTEL_HCI_RESET1 :
+			(opcode == BTINTEL_HCI_OP_RESET ? BTINTEL_PCIE_INTEL_HCI_RESET1 :
 				BTINTEL_PCIE_HCI_RESET);
 		bt_dev_dbg(data->hdev, "sent cmd: 0x%4.4x alive context changed: %s  ->  %s",
 			   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8e98ba1eab57..484e8fe3bc07 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2605,12 +2605,12 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 			else
 				urb = alloc_ctrl_urb(hdev, skb);
 
-			/* When the 0xfc01 command is issued to boot into
-			 * the operational firmware, it will actually not
-			 * send a command complete event. To keep the flow
+			/* When the BTINTEL_HCI_OP_RESET command is issued to
+			 * boot into the operational firmware, it will actually
+			 * not send a command complete event. To keep the flow
 			 * control working inject that event here.
 			 */
-			if (opcode == 0xfc01)
+			if (opcode == BTINTEL_HCI_OP_RESET)
 				inject_cmd_complete(hdev, opcode);
 		} else {
 			urb = alloc_ctrl_urb(hdev, skb);
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 811f33701f84..b45e65a93828 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1029,12 +1029,12 @@ static struct sk_buff *intel_dequeue(struct hci_uart *hu)
 		struct hci_command_hdr *cmd = (void *)skb->data;
 		__u16 opcode = le16_to_cpu(cmd->opcode);
 
-		/* When the 0xfc01 command is issued to boot into
-		 * the operational firmware, it will actually not
-		 * send a command complete event. To keep the flow
-		 * control working inject that event here.
+		/* When the BTINTEL_HCI_OP_RESET command is issued to boot into
+		 * the operational firmware, it will actually not send a command
+		 * complete event. To keep the flow control working inject that
+		 * event here.
 		 */
-		if (opcode == 0xfc01)
+		if (opcode == BTINTEL_HCI_OP_RESET)
 			inject_cmd_complete(hu->hdev, opcode);
 	}
 
-- 
2.43.0


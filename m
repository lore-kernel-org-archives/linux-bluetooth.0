Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01953C13D
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Jun 2025 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748747513; cv=none; b=cfjKPojn+UZH3ATq3Qt49DCWee+2tyGyX58YxmNRCwrMlxWWjfl5/Rt4KdYlQKBE/9344P+JzEGXgE15hrqwS2pgcGssqPZ1hNg6ja+ATiGC6YeqY1N8PX65MNOBwSjHhFyJ4WlYYN7tocuzA/KU5Sn65QXpuullrzkvl+iOOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748747513; c=relaxed/simple;
	bh=jTUWuMstUPVXBnRto1gbfvICEJwSdNlzWV7TItHNmGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WEDIObYjbUyjOqPsD6lat47owNgsdAaNJMpmS3RoASqaDnQAk61YkTBeXNKwVhYdyC78vqs3ePDSuL+thlwTS2Nub/50YSHlwMzG03BMz//C8y1aTJyRkqaqvLBS25W9Pb8FZg0dxLRgFM8HhYK/4Xrdxk5Kae0AUAa4o4MrDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwahW0oM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwahW0oM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748747511; x=1780283511;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jTUWuMstUPVXBnRto1gbfvICEJwSdNlzWV7TItHNmGc=;
  b=dwahW0oMFCm8ZCICDUx01ot+5p7dm+J5VrsCQmWs/rGCKmnPCWo/bJ4g
   lY+bJUuhx7tgfc6hZTDSOWZWn7o5bbDKcpMvQQsQQp2sHfMtDSAXqbE4d
   YLoFQTY1ub/ekONdZP30UsgpOQrE1xfPZIcT5dXU16+aMqa4C6y0aHpxP
   aj6624IB5dEKbsDdeJM+FVMbOPhS02EtYNXczXqDwRqGfyptleyC6GTGT
   WLfn5lt3rS+0cHeD+Rp2UT0FpjDSLk6/eK0lHC3+GYfP0GVD8KlMKK0zZ
   B+0SyEH4RzH88YhyEy2DOZC23TP40LAYeg1IoQjs018F+6RuYnRRZCy7j
   g==;
X-CSE-ConnectionGUID: QBtRAklWSwKgBFMNMZ+qbw==
X-CSE-MsgGUID: VeiB5RItT5Kyqy2MFBoc9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="50491214"
X-IronPort-AV: E=Sophos;i="6.16,200,1744095600"; 
   d="scan'208";a="50491214"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 20:11:50 -0700
X-CSE-ConnectionGUID: xP8m4QFuSfukM73Qdy2wnQ==
X-CSE-MsgGUID: /5zLCZBpTU24eESOIxNHxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,200,1744095600"; 
   d="scan'208";a="145214760"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa009.fm.intel.com with ESMTP; 31 May 2025 20:11:48 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 1/3] Bluetooth: btintel_pcie: Fix driver not posting maximum rx buffers
Date: Sun,  1 Jun 2025 08:58:22 +0530
Message-ID: <20250601032824.572001-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver was posting only 6 rx buffers, despite the maximum rx buffers
being defined as 16. Having fewer RX buffers caused firmware exceptions
in HID use cases when events arrived in bursts.

Exception seen on android 6.12 kernel.

E Bluetooth: hci0: Received hw exception interrupt
E Bluetooth: hci0: Received gp1 mailbox interrupt
D Bluetooth: hci0: 00000000: ff 3e 87 80 03 01 01 01 03 01 0c 0d 02 1c 10 0e
D Bluetooth: hci0: 00000010: 01 00 05 14 66 b0 28 b0 c0 b0 28 b0 ac af 28 b0
D Bluetooth: hci0: 00000020: 14 f1 28 b0 00 00 00 00 fa 04 00 00 00 00 40 10
D Bluetooth: hci0: 00000030: 08 00 00 00 7a 7a 7a 7a 47 00 fb a0 10 00 00 00
D Bluetooth: hci0: 00000000: 10 01 0a
E Bluetooth: hci0: ---- Dump of debug registers —
E Bluetooth: hci0: boot stage: 0xe0fb0047
E Bluetooth: hci0: ipc status: 0x00000004
E Bluetooth: hci0: ipc control: 0x00000000
E Bluetooth: hci0: ipc sleep control: 0x00000000
E Bluetooth: hci0: mbox_1: 0x00badbad
E Bluetooth: hci0: mbox_2: 0x0000101c
E Bluetooth: hci0: mbox_3: 0x00000008
E Bluetooth: hci0: mbox_4: 0x7a7a7a7a

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
---
changes from v1->v2:
- Update commit message
- Add dmesg snipped related firmware exception

 drivers/bluetooth/btintel_pcie.c | 3 ++-
 drivers/bluetooth/btintel_pcie.h | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 50fe17f1e1d1..2c7731803c9f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -396,8 +396,9 @@ static int btintel_pcie_submit_rx(struct btintel_pcie_data *data)
 static int btintel_pcie_start_rx(struct btintel_pcie_data *data)
 {
 	int i, ret;
+	struct rxq *rxq = &data->rxq;
 
-	for (i = 0; i < BTINTEL_PCIE_RX_MAX_QUEUE; i++) {
+	for (i = 0; i < rxq->count; i++) {
 		ret = btintel_pcie_submit_rx(data);
 		if (ret)
 			return ret;
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 21b964b15c1c..5ddd6d7d8d45 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -177,9 +177,6 @@ enum {
 /* Doorbell vector for TFD */
 #define BTINTEL_PCIE_TX_DB_VEC	0
 
-/* Number of pending RX requests for downlink */
-#define BTINTEL_PCIE_RX_MAX_QUEUE	6
-
 /* Doorbell vector for FRBD */
 #define BTINTEL_PCIE_RX_DB_VEC	513
 
-- 
2.43.0


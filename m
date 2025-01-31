Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CFA1B4145
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jan 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738328428; cv=none; b=A4qTM4YXytoJ9GfyUjmf+wPrcielufhs6l6/wTLuhPBc3T5EVXx7zTsUNoIbD6r8f6Ea2CYMqyyGvShu4r+9ESPwdYlHrgPfTuGUfPFhj+Ei8PTuVdvWImia1JeU/vhRqsPs4Cggv5yfI2UWfANqMVW24kOqFyegpBU00GiFDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738328428; c=relaxed/simple;
	bh=CYMUD0Xj9jz4LOcpSxxXu5C9B/Bb1PhxJyI0BWN4kL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjeNMZxxLYXy0nohzk1zKala0OvK/ayD2iM+MMOtTttLwXgolgW1hIEClZ0wSQFqAVPcKRj9+RmwG8Ct2nYUmIKgC+9sySVsPMYrH9GyAje2kXMQbkaOK6OD/Eziz9nwU/EVSqN6H1HObDKuymc39xW4/ys0FK7fy15E1DQRnT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ER7lUCvP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ER7lUCvP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738328427; x=1769864427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CYMUD0Xj9jz4LOcpSxxXu5C9B/Bb1PhxJyI0BWN4kL4=;
  b=ER7lUCvPz6fXT23gZ4TziDsmDIpkdF1lNRBVC0dq/43NgkCfPxveeftk
   Jdy9e8qlgAiUN+dDQwqkWvr7d86/a3GBW7vPkC1IE2yQXim95hsWxO541
   zTrQfv6d8IG3UEK7yCutD1oduOq75rUJa+3/h+A+tMET9dOgDuL8dprrQ
   zpyZsEY7VKoQqrr1rSjBzu3HmfEflRjtFLUliJvh+cuCAtjvstMHKCBp6
   hn3MbJW/GZl+97tDY70pvQpxcR3bWVu/zouFfcCheNOCVA6i7BviR1lBu
   zUfamPaJDWoWdd7GOLtrMTjtPqEgy+Ie/rB86gTslwz5XzWVVrEq9SMQ2
   Q==;
X-CSE-ConnectionGUID: +h+Gh9XgQDKwVnbcsG05Yg==
X-CSE-MsgGUID: a2kNuckGQyOQfDwM8h91Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="38600201"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="38600201"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 05:00:26 -0800
X-CSE-ConnectionGUID: 9En2pnjKSB+EUv0YnwhLzA==
X-CSE-MsgGUID: RM1YXAKkQqqAt3EtOeX9jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="114618402"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 31 Jan 2025 05:00:24 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Fix a potential race condition
Date: Fri, 31 Jan 2025 18:30:19 +0530
Message-ID: <20250131130019.1648758-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On HCI_OP_RESET command, firmware raises alive interrupt. Driver needs
to wait for this before sending other command. This patch fixes the potential
miss of alive interrupt due to which HCI_OP_RESET can timeout.

Expected flow:
If tx command is HCI_OP_RESET,
  1. set data->gp0_received = false
  2. send HCI_OP_RESET
  3. wait for alive interrupt

Actual flow having potential race:
If tx command is HCI_OP_RESET,
 1. send HCI_OP_RESET
   1a. Firmware raises alive interrupt here and in ISR
       data->gp0_received  is set to true
 2. set data->gp0_received = false
 3. wait for alive interrupt

Signed-off-by: Kiran K <kiran.k@intel.com>
Fixes: 05c200c8f029 ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Closes: https://patchwork.kernel.org/project/bluetooth/patch/20241001104451.626964-1-kiran.k@intel.com/
---
 drivers/bluetooth/btintel_pcie.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 63eca52c0e0b..b8b241a92bf9 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1321,6 +1321,10 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 			if (opcode == 0xfc01)
 				btintel_pcie_inject_cmd_complete(hdev, opcode);
 		}
+		/* Firmware raises alive interrupt on HCI_OP_RESET */
+		if (opcode == HCI_OP_RESET)
+			data->gp0_received = false;
+
 		hdev->stat.cmd_tx++;
 		break;
 	case HCI_ACLDATA_PKT:
@@ -1358,7 +1362,6 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 			   opcode, btintel_pcie_alivectxt_state2str(old_ctxt),
 			   btintel_pcie_alivectxt_state2str(data->alive_intr_ctxt));
 		if (opcode == HCI_OP_RESET) {
-			data->gp0_received = false;
 			ret = wait_event_timeout(data->gp0_wait_q,
 						 data->gp0_received,
 						 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
-- 
2.43.0


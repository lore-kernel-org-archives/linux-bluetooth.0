Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C488488
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Apr 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860728; cv=none; b=BjGkl0/vi7UPAIQ93/AKXVRD+2yWJi8IcRuUmAC3C2QtQV8ydXv6CVAvz0IrP3aZPtgv0XRvCrm8YdwNOD+/C5T6P6sAIK8mBYOZTAzXolfFl4OvG3DdFeAQN13lfWbkNFb4YTK1oy3TzQNJR3S4uGsJIulas0kNOHpp5/7Qmjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860728; c=relaxed/simple;
	bh=kTB2Zx8f/9t3hbKG5egoNoItUvtTj5lF6AEH4PwdseE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EaVjUHDZcCNFnBlS1tKvL23yzbJ9ETGIp97T8edymc1dT5ZmWOBDrr9W5yv/uamvutN4u6RrwtVw7a+ldt6uEgdWEy7A5tJNelvnbcxGxKqQ9fnlLiEyUMZzKaIFv5jkdnbtI2hTWtjNsw+bTpCxmY9gtkUGKxmlRvwd0LN6Jok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KP9nCkja; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KP9nCkja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744860727; x=1776396727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kTB2Zx8f/9t3hbKG5egoNoItUvtTj5lF6AEH4PwdseE=;
  b=KP9nCkja3+RFeEU9CWAOnZqCBpvzJp9RpnAbwenlI069CF/0pM23YNq1
   VusOz3CEOHQIVZrgyeq5mqECFrL8tXjK3BCbzt8suIqhAh0IrjN0bpwbt
   plSen0MSoRgm2LC54LnXkvgoAXB5pqYdTRk9em6a/4SiE/toKL/2s0pB4
   hSJ12wR7YFfKj+tBTYC09kInTeZK0dTIchoPTE3Lvuhbe4lbE6Wy+Rj0r
   SAW440Gp/zrz8zmezPKNkxPiespJHEZpxyKeO9r7I7aTZjOLpNOwIU9vT
   FUmuk0qxYKHmUAqgd9t7yMCnugvQwIC+sNA94tYHgAAenLoNuaosVxAfh
   Q==;
X-CSE-ConnectionGUID: NyUul3c0TWCRHi+9ceu60w==
X-CSE-MsgGUID: isDkgcvrSmGqS8GnlsD3xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46522601"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="46522601"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 20:32:06 -0700
X-CSE-ConnectionGUID: Gl+f9aFXSrm2o5M00SyU6g==
X-CSE-MsgGUID: WWLz086PR6KlcH5FGNHvjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130537854"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa006.fm.intel.com with ESMTP; 16 Apr 2025 20:32:04 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Avoid redundant buffer allocation
Date: Thu, 17 Apr 2025 09:18:42 +0530
Message-ID: <20250417034842.165796-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reuse the skb buffer provided by the PCIe driver to pass it onto the
stack, instead of copying it to a new skb.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 33 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index e0b50513403f..b73928e38d34 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -947,8 +947,10 @@ static int btintel_pcie_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 		/* This is a debug event that comes from IML and OP image when it
 		 * starts execution. There is no need pass this event to stack.
 		 */
-		if (skb->data[2] == 0x97)
+		if (skb->data[2] == 0x97) {
+			hci_recv_diag(hdev, skb);
 			return 0;
+		}
 	}
 
 	return hci_recv_frame(hdev, skb);
@@ -964,7 +966,6 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 	u8 pkt_type;
 	u16 plen;
 	u32 pcie_pkt_type;
-	struct sk_buff *new_skb;
 	void *pdata;
 	struct hci_dev *hdev = data->hdev;
 
@@ -1041,24 +1042,20 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 
 	bt_dev_dbg(hdev, "pkt_type: 0x%2.2x len: %u", pkt_type, plen);
 
-	new_skb = bt_skb_alloc(plen, GFP_ATOMIC);
-	if (!new_skb) {
-		bt_dev_err(hdev, "Failed to allocate memory for skb of len: %u",
-			   skb->len);
-		ret = -ENOMEM;
-		goto exit_error;
-	}
-
-	hci_skb_pkt_type(new_skb) = pkt_type;
-	skb_put_data(new_skb, skb->data, plen);
+	hci_skb_pkt_type(skb) = pkt_type;
 	hdev->stat.byte_rx += plen;
+	skb_trim(skb, plen);
 
 	if (pcie_pkt_type == BTINTEL_PCIE_HCI_EVT_PKT)
-		ret = btintel_pcie_recv_event(hdev, new_skb);
+		ret = btintel_pcie_recv_event(hdev, skb);
 	else
-		ret = hci_recv_frame(hdev, new_skb);
+		ret = hci_recv_frame(hdev, skb);
+	skb = NULL; /* skb is freed in the callee  */
 
 exit_error:
+	if (skb)
+		kfree_skb(skb);
+
 	if (ret)
 		hdev->stat.err_rx++;
 
@@ -1192,8 +1189,6 @@ static void btintel_pcie_rx_work(struct work_struct *work)
 	struct btintel_pcie_data *data = container_of(work,
 					struct btintel_pcie_data, rx_work);
 	struct sk_buff *skb;
-	int err;
-	struct hci_dev *hdev = data->hdev;
 
 	if (test_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags)) {
 		/* Unlike usb products, controller will not send hardware
@@ -1214,11 +1209,7 @@ static void btintel_pcie_rx_work(struct work_struct *work)
 
 	/* Process the sk_buf in queue and send to the HCI layer */
 	while ((skb = skb_dequeue(&data->rx_skb_q))) {
-		err = btintel_pcie_recv_frame(data, skb);
-		if (err)
-			bt_dev_err(hdev, "Failed to send received frame: %d",
-				   err);
-		kfree_skb(skb);
+		btintel_pcie_recv_frame(data, skb);
 	}
 }
 
-- 
2.43.0


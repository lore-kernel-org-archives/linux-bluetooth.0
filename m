Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85BB661
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743559461; cv=none; b=Ii+kD5wtsEZkp87PahjWDI5+eIIBT4QppGDbyWQajgDS9q6vY13zylvcXw3EyR70qq1OBg2HKUjr9jH8/XUOmVhzGKUEhanxNVP8O7/bqhV6R8DjyCbIM3nxP1sb8pv1ozyZp2+EGrphJDobAkbzvQD3S4LsJxEPEhFGcDmcLvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743559461; c=relaxed/simple;
	bh=BXCLL9o8V5y2hoqFdkrDIOPHPs1yeTVAmgUEK8wMO7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gkzdGABM7dRI6BOYjI0UyDYlVROW/U5SQT7l5PGEqMgOO9Zl3s2lzEWFTKiORjQ0FC+CYi+8PB6UibkXANAyLxl30aCmyx2bux4fcWWeR/iNkepMIQwnFhY3ayo1wH6fZ9epOZPN7EhTshpsIsMQ/wFNLVwcfN8zPXE3eq7D0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hosnfUSt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hosnfUSt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743559460; x=1775095460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BXCLL9o8V5y2hoqFdkrDIOPHPs1yeTVAmgUEK8wMO7c=;
  b=hosnfUStykQrBIfxEeVIOJE6OnTVKsoR37T2axihwWqo+qqD2IKHw5e1
   4uMxVlaptQIk5hvua0uOFxF2f8aqvloXANoKtSbJfDKQIfJzPaCdsuLYe
   L+yR7rnS1+vJaY9IWPlHETtqVIw1OUbH4Z7+sQcwwWCNPCa77Rp4CKXlI
   apT2JEuieZ1O3H4s5Qq7SYjOM1eokEmRqSFL898RFTzwrSIXPgdMsu6BU
   qoTng7FXUgCvpjcs3X40xDiUYYXfLgF7oO7sPL8PU32416vwp0myiF2Xz
   PRY6N3Slv015Yasz9N61sX2w76F92Rz6KQfJgKWVoE47nQzJgEwXHm33F
   g==;
X-CSE-ConnectionGUID: unZz/4g9ToO6S3Oav9alPg==
X-CSE-MsgGUID: NQwosqJ2TSe8myLDjLTMkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="44614039"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="44614039"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 19:04:19 -0700
X-CSE-ConnectionGUID: W1XrR0eMRteSPqPTibeSlg==
X-CSE-MsgGUID: lbTqC2YKSJukVo5FarYTBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="157495138"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa002.jf.intel.com with ESMTP; 01 Apr 2025 19:04:17 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Avoid redundant buffer allocation
Date: Wed,  2 Apr 2025 07:50:54 +0530
Message-ID: <20250402022054.64501-1-kiran.k@intel.com>
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
 drivers/bluetooth/btintel_pcie.c | 58 ++++++++++++--------------------
 1 file changed, 22 insertions(+), 36 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index e0b50513403f..ebc36fd33de8 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -947,8 +947,10 @@ static int btintel_pcie_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 		/* This is a debug event that comes from IML and OP image when it
 		 * starts execution. There is no need pass this event to stack.
 		 */
-		if (skb->data[2] == 0x97)
+		if (skb->data[2] == 0x97) {
+			kfree_skb(skb);
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
 
@@ -974,8 +975,7 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 	pdata = skb_pull_data(skb, BTINTEL_PCIE_HCI_TYPE_LEN);
 	if (!pdata) {
 		bt_dev_err(hdev, "Corrupted packet received");
-		ret = -EILSEQ;
-		goto exit_error;
+		goto no_or_short_data;
 	}
 
 	pcie_pkt_type = get_unaligned_le32(pdata);
@@ -987,8 +987,7 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 			pkt_type = HCI_ACLDATA_PKT;
 		} else {
 			bt_dev_err(hdev, "ACL packet is too short");
-			ret = -EILSEQ;
-			goto exit_error;
+			goto no_or_short_data;
 		}
 		break;
 
@@ -998,8 +997,7 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 			pkt_type = HCI_SCODATA_PKT;
 		} else {
 			bt_dev_err(hdev, "SCO packet is too short");
-			ret = -EILSEQ;
-			goto exit_error;
+			goto no_or_short_data;
 		}
 		break;
 
@@ -1009,8 +1007,7 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 			pkt_type = HCI_EVENT_PKT;
 		} else {
 			bt_dev_err(hdev, "Event packet is too short");
-			ret = -EILSEQ;
-			goto exit_error;
+			goto no_or_short_data;
 		}
 		break;
 
@@ -1020,45 +1017,40 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 			pkt_type = HCI_ISODATA_PKT;
 		} else {
 			bt_dev_err(hdev, "ISO packet is too short");
-			ret = -EILSEQ;
-			goto exit_error;
+			goto no_or_short_data;
 		}
 		break;
 
 	default:
 		bt_dev_err(hdev, "Invalid packet type received: 0x%4.4x",
 			   pcie_pkt_type);
-		ret = -EINVAL;
-		goto exit_error;
+		goto no_or_short_data;
 	}
 
 	if (skb->len < plen) {
 		bt_dev_err(hdev, "Received corrupted packet. type: 0x%2.2x",
 			   pkt_type);
-		ret = -EILSEQ;
-		goto exit_error;
+		goto no_or_short_data;
 	}
 
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
 
-exit_error:
+goto out;
+
+no_or_short_data:
+	ret = -EILSEQ;
+	kfree_skb(skb);
+
+out:
 	if (ret)
 		hdev->stat.err_rx++;
 
@@ -1192,8 +1184,6 @@ static void btintel_pcie_rx_work(struct work_struct *work)
 	struct btintel_pcie_data *data = container_of(work,
 					struct btintel_pcie_data, rx_work);
 	struct sk_buff *skb;
-	int err;
-	struct hci_dev *hdev = data->hdev;
 
 	if (test_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags)) {
 		/* Unlike usb products, controller will not send hardware
@@ -1214,11 +1204,7 @@ static void btintel_pcie_rx_work(struct work_struct *work)
 
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


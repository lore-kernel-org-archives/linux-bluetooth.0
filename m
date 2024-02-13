Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421DE5DF3A
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839381; cv=none; b=LP4Q2Jv5az+Hy/t6/e2RTDocKkpVJrt/lkN9sfEoxXZr7yzNMkVhbBk/Xu6KO6zi1pr7vxwi0Ng1sogY8LWGRnu8kCFvBCasAEhtpXTUq11R72pyTSPT8pgMTMG+/nmTJw+TCy/GEklcaHmZcO48QcWDIvzqf9CH/iLPhESviBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839381; c=relaxed/simple;
	bh=SMKe+T9bfzSbROFtvbzNZibyf2sYxzkZnW2FmJHL3QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cF/4S1IVE1NRCke4NABtEZaoFTNvhbiCRIwBA7Ezwda4az+w9/pBgGeYfg0t1E2n59eqtOZRoB6DXiQ0MmaiXjufDSko8cXHZKpAl8Sv+lsgZ8m0QVdpPcHr7BoBD0RvmyRhuE8q8EmKz6GtfZyztr4p5dh9rU8xgEbbbIEU+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emk2BUfG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emk2BUfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707839379; x=1739375379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SMKe+T9bfzSbROFtvbzNZibyf2sYxzkZnW2FmJHL3QQ=;
  b=emk2BUfGIf/MaU6b0Fes3HZOCsaBh50dSIPlOeeXRnhwbftBNGk42oP1
   8PqD9XOgABH6s76xIqeyqMN5hXZDHkWw6ZbBod7LH0AprlYo3u8/lOZEV
   0r3Rf6NVc8JBIFc8KaqO/JKzH/flvjSaDXihzHjIdTKLhzZKfA8mL0vGU
   eawHJ7Tsxo6AyOt7LE8EVYSoekKG4cMtuurjIqrQHMxGElsLBuS6ajCTj
   L7iOfQ5H2BQinE1Aivw2JWV/y/HDZw40wuRkijr6dZ6w+pvtnQ8D3ydz7
   9+Bv6r7xmYpe5Jwr/aLR18tpTwfd/1GmFkWnbQXyA0qT0UC2k0C4a+Ci6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1974448"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1974448"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 07:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935372926"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="935372926"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2024 07:49:36 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Print Firmware Sequencer information
Date: Tue, 13 Feb 2024 21:31:52 +0530
Message-Id: <20240213160152.2836131-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware sequencer(FSEQ) is a common code shared across Bluetooth
and Wifi. Printing FSEQ will help to debug if there is any mismatch
between Bluetooth and Wifi FSEQ.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 106 ++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e5b043d96207..0d067ee39408 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2670,6 +2670,111 @@ static void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	}
 }
 
+static void btintel_print_fseq_info(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	u8 *p;
+	const char *str;
+
+	skb = __hci_cmd_sync(hdev, 0xfcb3, 0, NULL, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_dbg(hdev, "Reading fseq status command failed (%ld)",
+			   PTR_ERR(skb));
+		return;
+	}
+
+	if (skb->len < (sizeof(u32) * 16 + 2)) {
+		bt_dev_dbg(hdev, "Malformed packet");
+		kfree_skb(skb);
+		return;
+	}
+
+	if (skb->data[0]) {
+		bt_dev_dbg(hdev, "Failed to get fseq status (0x%2.2x)",
+			   skb->data[0]);
+		kfree_skb(skb);
+		return;
+	}
+
+	p = skb->data;
+	/* skip status */
+	p = p + 1;
+
+	switch (*p) {
+	case 0:
+		str = "Success";
+		break;
+	case 1:
+		str = "Fatal error";
+		break;
+	case 2:
+		str = "Sem acq error";
+		break;
+	default:
+		str = "Unknown error";
+		break;
+	}
+
+	bt_dev_info(hdev, "Fseq status: %s (0x%2.2x)", str, *p);
+	if (*p)
+		return;
+	p = p + 1;
+	bt_dev_dbg(hdev, "Reason: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Global version: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Installed version: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_info(hdev, "Fseq executed: %2.2u.%2.2u.%2.2u.%2.2u", p[0], p[1],
+		    p[2], p[3]);
+
+	p = p + 4;
+	bt_dev_info(hdev, "Fseq BT Top: %2.2u.%2.2u.%2.2u.%2.2u", p[0], p[1],
+		    p[2], p[3]);
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Fseq Top init version: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Fseq Cnvio init version: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Fseq MBX Wifi file version: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Fseq BT version: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Fseq Top reset address: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Fseq MBX timeout: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Fseq MBX ack: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Fseq CNVi id: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Fseq CNVr id: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Fseq Error handle: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Fseq Magic noalive indication: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Fseq OTP version: 0x%8.8x", get_unaligned_le32(p));
+
+	p = p + 4;
+	bt_dev_dbg(hdev, "Fseq MBX otp version: 0x%8.8x", get_unaligned_le32(p));
+}
+
 static int btintel_setup_combined(struct hci_dev *hdev)
 {
 	const u8 param[1] = { 0xFF };
@@ -2902,6 +3007,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
 		btintel_register_devcoredump_support(hdev);
+		btintel_print_fseq_info(hdev);
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
-- 
2.34.1


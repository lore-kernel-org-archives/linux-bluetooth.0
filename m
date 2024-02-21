Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135B03D96B
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521694; cv=none; b=rhYn1wkumy+PXLUSYENL5BpvWHoaQxvhEqCbkTvrbfDERW8hKulfpZ9IPKIdoYVd5hJsQg1FE8aBH1cZYeqZfc2D26+z64Wo/hNLapCal3Qo5HlGdmopsWhh8PWvKn1bOmmrDskH8a5HVXKIWLN7AYZrGlG0EF7115El89jKwdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521694; c=relaxed/simple;
	bh=KygwWH68/Lk7gaKpwF06qqBuz4R9SK37igQFBHRR2bY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nT5GmmupdOdlFDeMosHMmgK24K2Ff8V3hE5a8CZHP6meNbO3e9IdgnfSRbefXBgPCuA8vBiCt7CaTLmcqj4S0qbCN2sybvf2XaPntCxbT5Zph7luXsZ04OWdR90z12QhISDUvytXvfKBYSW27sLSr7PquTK/DlqNhNMUiXSIAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6M4dyPA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6M4dyPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708521693; x=1740057693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KygwWH68/Lk7gaKpwF06qqBuz4R9SK37igQFBHRR2bY=;
  b=X6M4dyPAp6T49hZu2d/cB60mmepYJAodWMURTrHa5mXhHW3ca4NENj/L
   r5fd26cElV186iIeq6MeD7n/mjHnWm3uJ1ys1jscr52uzbULxzQWjJGgl
   NLbj48jlTBrZ9EEdot0WlmlDposmTiYwsuR7sgf3WDUab4kOL6F6EEted
   ar4g0c5Rckq7kOy+PVJ89zuZ3gdWpx3OIwKP/jrgpk44WDKOdfv0KPgWc
   u0ItiX3kToZnABKkaCh4rdHmO+F7KkkUwG0G2C/VqJ2OMe8WsTpf2PJzW
   IeX3e3FypEKpZ/hGF1jRhpnu2Zt0n6Chp+AU9F7USnql70u2IO0zxW4Ap
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2803574"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2803574"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 05:21:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="827347213"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="827347213"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga001.jf.intel.com with ESMTP; 21 Feb 2024 05:21:25 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Print Firmware Sequencer information
Date: Wed, 21 Feb 2024 19:03:46 +0530
Message-Id: <20240221133346.3295639-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware sequencer (FSEQ) is a common code shared across Bluetooth
and Wifi. Printing FSEQ will help to debug if there is any mismatch
between Bluetooth and Wifi FSEQ.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 114 ++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

Kernel log snippet:

[    3.643765] Bluetooth: hci0: Fseq status: Success (0x00)
[    3.643769] Bluetooth: hci0: Fseq executed: 00.00.02.41
[    3.643771] Bluetooth: hci0: Fseq BT Top: 00.00.02.41


diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e5b043d96207..a083c4b8621c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2670,6 +2670,119 @@ static void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	}
 }
 
+static void btintel_print_fseq_info(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	u8 *p;
+	u32 val;
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
+		bt_dev_dbg(hdev, "Malformed packet of length %u received",
+			   skb->len);
+		kfree_skb(skb);
+		return;
+	}
+
+	p = skb_pull_data(skb, 1);
+	if (*p) {
+		bt_dev_dbg(hdev, "Failed to get fseq status (0x%2.2x)", *p);
+		kfree_skb(skb);
+		return;
+	}
+
+	p = skb_pull_data(skb, 1);
+	switch (*p) {
+	case 0:
+		str = "Success";
+		break;
+	case 1:
+		str = "Fatal error";
+		break;
+	case 2:
+		str = "Semaphore acquire error";
+		break;
+	default:
+		str = "Unknown error";
+		break;
+	}
+
+	if (*p) {
+		bt_dev_err(hdev, "Fseq status: %s (0x%2.2x)", str, *p);
+		kfree_skb(skb);
+		return;
+	}
+
+	bt_dev_info(hdev, "Fseq status: %s (0x%2.2x)", str, *p);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Reason: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Global version: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Installed version: 0x%8.8x", val);
+
+	p = skb->data;
+	skb_pull_data(skb, 4);
+	bt_dev_info(hdev, "Fseq executed: %2.2u.%2.2u.%2.2u.%2.2u", p[0], p[1],
+		    p[2], p[3]);
+
+	p = skb->data;
+	skb_pull_data(skb, 4);
+	bt_dev_info(hdev, "Fseq BT Top: %2.2u.%2.2u.%2.2u.%2.2u", p[0], p[1],
+		    p[2], p[3]);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Fseq Top init version: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Fseq Cnvio init version: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Fseq MBX Wifi file version: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Fseq BT version: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Fseq Top reset address: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Fseq MBX timeout: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Fseq MBX ack: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Fseq CNVi id: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Fseq CNVr id: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Fseq Error handle: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Fseq Magic noalive indication: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Fseq OTP version: 0x%8.8x", val);
+
+	val = get_unaligned_le32(skb_pull_data(skb, 4));
+	bt_dev_dbg(hdev, "Fseq MBX otp version: 0x%8.8x", val);
+
+	kfree_skb(skb);
+}
+
 static int btintel_setup_combined(struct hci_dev *hdev)
 {
 	const u8 param[1] = { 0xFF };
@@ -2902,6 +3015,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
 		btintel_register_devcoredump_support(hdev);
+		btintel_print_fseq_info(hdev);
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
-- 
2.34.1


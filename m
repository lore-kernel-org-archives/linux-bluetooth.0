Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266418;
	b=aJJQ9/81aZpHqfWDJ+49HXs+JhpNAnM7cCQ7PZbtqIq2aIH9w9A7nYItgr/CPOq6j1jg
	 8z7ENAG+5QXCCHNY1xIIy8rezKsmSCLAdBmXL175OqW3XesSUIl45qOA8Tke2j7kFHFVN
	 w+Ll68tbxbVRWMvGZacMERuPuE+YUlY5j4ntF9gDRqwqPRtKQI0Mzr5ABAo+lkZYf2xso
	 ipEVECW36Pyz0H4G2lH+OMAmsvGKwxb4VhhOxLoHU7rJi9gx7RQve556KRQrW4/nN9/sm
	 sHddWs70uzKpAViCOAos9p+wB8k9XUtO54infG5cspsU73+wxvKIMKmNRpHrC7VqZBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266418;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ipIslu0M2w1vw7w5Y6anaUMXLqT/8SXZvh1slp7DYk4=;
	b=ewqNTD0VLivT8pbzUG+XBHouyNFhoeAQejST32biHEVsOnT9/PW3DWAjrPJZbdlNMipJ
	 uCPkjjjX6duBS8gUsARQmPDdIdyubH2jRpV/QG4sWSLtcsRL0jxCx/id+xTfWO0LuBDgZ
	 U7kA+BPJ0zALGmpR80QhFHf8rad9idUNh3ttRbPwdcSPZxhoj5c/5kSQnF6yPr8gAWa+3
	 es1zh/Cv/2GsrZZBf74CD80iqEHbnxomUDHU2XBHPYICQ9DHEhwg2OmELgm0mms+/9l4g
	 LxJ49LNhfSnKePqhkWLzhLroVxQp417kHlBrI/cWjLOFX7kNyhzDSJ5ZF2GKmVAd26g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cnyeNr5K;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C95606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 09:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04C95606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cnyeNr5K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793266416; x=1824802416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LqVgKDc5gLMdJ52xEpXiiKuaZXfhAUfrLGB3BZkeTjs=;
  b=cnyeNr5KdWX7lswV/Q6bervLYjZFTp8FOPpHY2NFODzfixzetmB2PR16
   BvbiXvpVIabqdmFp+ku0IV8jBfjMVMIFMwCLHazBR/xdYvqGVReSc4zAP
   WzRIbNhUA614JtyY0aIPHLlzu9vKaALTKD6XUS2kIk9wu2lGrawKfMwwl
   Q6Xcoyb/Ai5JX4wZbr8fMFCO/rlXeIKGc7If92fwSdeXWJwmj8UhFRbtv
   q0GuafM58Np2SqDGVtsOXHL+7tppoJRgNNoOFGhATrOov1o9s6q2Tsebx
   O1CxuLE6ncehP8getyiY1FSEi/EyYIuTab0IM8FbliJRK9MWeFJpGMyG2
   g==;
X-CSE-ConnectionGUID: 8M52tsy0QX2wTJldgiLPHw==
X-CSE-MsgGUID: /f/cFgNEQEWdvQ9uj3oSwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1887595"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1887595"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 02:33:35 -0700
X-CSE-ConnectionGUID: bl6E078vQweE3gwP03pmyw==
X-CSE-MsgGUID: SNeIETHpTfminpt3SN/fxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5183758"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2026 02:33:34 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/7] Bluetooth: btintel_pcie: Add TX/RX packet dumps under LOG_MASK
Date: Thu, 29 Oct 2026 15:23:39 +0530
Message-ID: <20261029095344.3989729-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029095344.3989729-1-kiran.k@intel.com>
References: <20261029095344.3989729-1-kiran.k@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Log a one-line summary (packet type, opcode/event/handle, length) and a
hex dump of every HCI packet sent and received, gated independently by
BTINTEL_PCIE_DUMP_TX (bit 0) and BTINTEL_PCIE_DUMP_RX (bit 1).

Prefix the hex dump with the device name via a btintel_pcie_hex_dump()
helper, falling back to the PCI device name when hdev is not yet
registered so early messages do not print "null".

Assisted-by: Copilot:Claude Opus 4.7
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 73 ++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index a25f4d866f57..6fdffda6a1a8 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -32,6 +32,8 @@
 #define VERSION "0.1"
 
 /* Runtime diagnostic logging bits loaded from LOG_MASK in the debug INI. */
+#define BTINTEL_PCIE_DUMP_TX		BIT(0)
+#define BTINTEL_PCIE_DUMP_RX		BIT(1)
 
 #define BTINTEL_PCI_DEVICE(dev, subdev)	\
 	.vendor = PCI_VENDOR_ID_INTEL,	\
@@ -198,6 +200,42 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
 	}
 }
 
+/* Returns hdev name once registered, else the PCI device name so that
+ * logs emitted before hci_register_dev() do not show "null".
+ */
+static const char *btintel_pcie_dev_name(struct btintel_pcie_data *data)
+{
+	return data->hdev ? data->hdev->name : dev_name(&data->pdev->dev);
+}
+
+/* Hex dump with "Bluetooth: <dev>: <tag> " prefix */
+static void btintel_pcie_hex_dump(struct btintel_pcie_data *data,
+				  const char *tag, const void *buf, size_t len)
+{
+	char prefix[64];
+
+	snprintf(prefix, sizeof(prefix), "Bluetooth: %s: %s ",
+		 btintel_pcie_dev_name(data), tag);
+	print_hex_dump(KERN_INFO, prefix, DUMP_PREFIX_OFFSET, 16, 1, buf, len,
+		       false);
+}
+
+static const char * const btintel_pcie_pkt_type_table[] = {
+	[HCI_COMMAND_PKT] = "CMD",
+	[HCI_ACLDATA_PKT] = "ACL",
+	[HCI_SCODATA_PKT] = "SCO",
+	[HCI_EVENT_PKT] = "EVT",
+	[HCI_ISODATA_PKT] = "ISO",
+};
+
+static const char *btintel_pcie_pkt_type_str(u8 pkt_type)
+{
+	if (pkt_type < ARRAY_SIZE(btintel_pcie_pkt_type_table) &&
+	    btintel_pcie_pkt_type_table[pkt_type])
+		return btintel_pcie_pkt_type_table[pkt_type];
+	return "UNK";
+}
+
 /* Returns true when firmware traces are routed to the WiFi DBGC. In that
  * mode the host must not allocate DBGC buffers and must not publish their
  * addresses in the context info.
@@ -2454,6 +2492,23 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 	hdev->stat.byte_rx += plen;
 	skb_trim(skb, plen);
 
+	if (data->log_mask & BTINTEL_PCIE_DUMP_RX) {
+		if (pkt_type == HCI_EVENT_PKT)
+			bt_dev_info(hdev, "RX %s evt=0x%02x len=%u",
+				    btintel_pcie_pkt_type_str(pkt_type),
+				    ((struct hci_event_hdr *)skb->data)->evt,
+				    plen);
+		else if (pkt_type == HCI_ACLDATA_PKT)
+			bt_dev_info(hdev, "RX %s handle=0x%04x len=%u",
+				    btintel_pcie_pkt_type_str(pkt_type),
+				    le16_to_cpu(hci_acl_hdr(skb)->handle) & 0x0fff,
+				    plen);
+		else
+			bt_dev_info(hdev, "RX %s len=%u",
+				    btintel_pcie_pkt_type_str(pkt_type), plen);
+		btintel_pcie_hex_dump(data, "[RX]", skb->data, skb->len);
+	}
+
 	if (pcie_pkt_type == BTINTEL_PCIE_HCI_EVT_PKT)
 		ret = btintel_pcie_recv_event(hdev, skb);
 	else
@@ -3665,6 +3720,24 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 		return -EILSEQ;
 	}
 
+	if (data->log_mask & BTINTEL_PCIE_DUMP_TX) {
+		if (hci_skb_pkt_type(skb) == HCI_COMMAND_PKT)
+			bt_dev_info(hdev, "TX %s opcode=0x%04x len=%u",
+				    btintel_pcie_pkt_type_str(hci_skb_pkt_type(skb)),
+				    opcode, skb->len);
+		else if (hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT &&
+			 skb->len >= HCI_ACL_HDR_SIZE)
+			bt_dev_info(hdev, "TX %s handle=0x%04x len=%u",
+				    btintel_pcie_pkt_type_str(hci_skb_pkt_type(skb)),
+				    le16_to_cpu(hci_acl_hdr(skb)->handle) & 0x0fff,
+				    skb->len);
+		else
+			bt_dev_info(hdev, "TX %s len=%u",
+				    btintel_pcie_pkt_type_str(hci_skb_pkt_type(skb)),
+				    skb->len);
+		btintel_pcie_hex_dump(data, "[TX]", skb->data, skb->len);
+	}
+
 	ret = btintel_pcie_send_sync(data, skb, type, opcode);
 	if (ret) {
 		hdev->stat.err_tx++;
-- 
2.54.0


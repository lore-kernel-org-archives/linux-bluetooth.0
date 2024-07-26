Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D87148FED
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989746; cv=none; b=fRzVUmitYSQMdBpKI3oRB1//GpN8Xb0PlXPRgB/jwJyjklK9i23NGgMxdb6/pl290UQmdCYKBpksyZE/4llmd76yo66B5amaOC2zMN3ycKLf81qD5QoDajjKs2nzpvB6XDW4wj+Gle7WqAL+LgJsypVJPx3+3MfJuw4Q/ng48E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989746; c=relaxed/simple;
	bh=A2hjOcOR8cXTmtGO5rrYPKr3Bik9Fmc0q+1ucHYFj9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZUx2+FWuiCk01ax6ashE6iohJTV+9vbvLnvLvC5gilW1MWohe0K6DQVCQGfENcURuLTlqZmlXE+sybu15x28k67OwHHvLJflkaek7b4sFMbEg+U7JKY/YJQ9ELp7XBGvlAeiOTv1EmastcYU1ssvcEPJB5fbUqZxgTi/3eQWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHtTC3yo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHtTC3yo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721989744; x=1753525744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A2hjOcOR8cXTmtGO5rrYPKr3Bik9Fmc0q+1ucHYFj9E=;
  b=FHtTC3yo2ysQ3vV1NPajlyA4MURjfRVFFZvqZBWm7MypodxxgQBgXoWB
   HWYOL4k0RffU5K563IKS3Yx+sc+CfNO3ljtwRRTkdxNjPwELafLfncF16
   vadNgBaBJOAe2QmSlC4fPz7Gcr8Uo2CBDFwcYMg/dRz3a++NP9GW6+ndo
   ihYVbNDEXEPO2Dghuai5ZVsPND0BGrwjFVaOAohjxnbOZv7HRc8KPyBs9
   y1f6Rw57C7La6quR5vWSyHBpX/l1OdvgkDZvZaYn5JcMQL1xdtMZ+167L
   +rMO0Q/2T/iEr3pmkaYA4LYKbtvhX4sbcOLZC0U7yIR1396OhOR39egkA
   Q==;
X-CSE-ConnectionGUID: LB4pvmDuRPCbCm8fPJt4Hg==
X-CSE-MsgGUID: mG5GDIv2R7yGYyXKKJgITA==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19575422"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19575422"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 03:29:03 -0700
X-CSE-ConnectionGUID: bvyaian3S2myAiwlW82FUQ==
X-CSE-MsgGUID: javLJVjVTf2FxwO1CKHYHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="53146372"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa010.jf.intel.com with ESMTP; 26 Jul 2024 03:29:02 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran <kiran.k@intel.com>
Subject: [PATCH v1 3/3] Bluetooth: btintel_pcie: Add support for ISO data
Date: Fri, 26 Jul 2024 16:13:26 +0530
Message-Id: <20240726104326.459668-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240726104326.459668-1-kiran.k@intel.com>
References: <20240726104326.459668-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiran <kiran.k@intel.com>

Add support for handling ISO RX and TX packets.

Signed-off-by: Kiran <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 0d1a0415557b..8a5b5bce0a7d 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -46,6 +46,7 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
 #define BTINTEL_PCIE_HCI_ACL_PKT	0x00000002
 #define BTINTEL_PCIE_HCI_SCO_PKT	0x00000003
 #define BTINTEL_PCIE_HCI_EVT_PKT	0x00000004
+#define BTINTEL_PCIE_HCI_ISO_PKT	0x00000005
 
 static inline void ipc_print_ia_ring(struct hci_dev *hdev, struct ia *ia,
 				     u16 queue_num)
@@ -423,6 +424,18 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 			goto exit_error;
 		}
 		break;
+
+	case BTINTEL_PCIE_HCI_ISO_PKT:
+		if (skb->len >= HCI_ISO_HDR_SIZE) {
+			plen = HCI_ISO_HDR_SIZE + __le16_to_cpu(hci_iso_hdr(skb)->dlen);
+			pkt_type = HCI_ISODATA_PKT;
+		} else {
+			bt_dev_err(hdev, "ISO packet is too short");
+			ret = -EILSEQ;
+			goto exit_error;
+		}
+		break;
+
 	default:
 		bt_dev_err(hdev, "Invalid packet type received: 0x%4.4x",
 			   pcie_pkt_type);
@@ -1082,6 +1095,10 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 		type = BTINTEL_PCIE_HCI_SCO_PKT;
 		hdev->stat.sco_tx++;
 		break;
+	case HCI_ISODATA_PKT:
+		type = BTINTEL_PCIE_HCI_ISO_PKT;
+		hdev->stat.iso_tx++;
+		break;
 	default:
 		bt_dev_err(hdev, "Unknown HCI packet type");
 		return -EILSEQ;
-- 
2.40.1


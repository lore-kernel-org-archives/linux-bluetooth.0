Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD07E31E845;
	Sun, 12 Apr 2026 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775986393; cv=none; b=CkTHlZiav/P1fpvs5E3in+GKExvE/l7CN7TB+nbnsBeyzsjiSmxhyFFnfMM0zuWlVewLu4/1BzigF9Ub0Asl171ng2uwj6kQlumHXD0cyHHsZPYO7+Hc1mPoEPVBEmeH3kNHxHkcDVBWXKZURJU+pKUgPJsiy2xAFfOtyjLcfKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775986393; c=relaxed/simple;
	bh=UxHLX5c71n1eUJs1wHZNommuSug90KCdOCb+bplWQ18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NdJhyE6OSpau4WBkIqIYhq24OxayEOOJZTrpARsjVNldX8rLiHycwZskba6ro70PE3ETrV6jiCyZDnS+P1vt9hgAj+0/V9i9pE77EtfM5P047N/3CuYwwgSAHp8c8264r6TOGxDskAKDYT7/Qn6k225e9giW0Hwbwu6uadockRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AIEtBjxo; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AIEtBjxo"
X-UUID: 5ef13b98364e11f1ae70033691e9ac7d-20260412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=eswdepsRpw7C5ySDeJmU7CTcV9FFqFZQAQ3ydAH/FJg=;
	b=AIEtBjxo7H8BY4cwD9fF2KTvV0Gj6uDHfHwGJsHBIRoz6WijwrU14WU7x5fy+KuIV3h05KKSUQjAO+XAc4NtjEfHXf+tbiX/pWitsAcf2takfKxqtHyVMEAl7CDRz8gqlFnT2y251a2QvnVyNDgd4S0dkVvnMBAX4VAPv91IvjE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:34b8f43c-efc8-4f02-a09e-c2b2c8efa1db,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:c66d528f-6df4-4a3d-a7a4-fbdc42d669ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
	15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5ef13b98364e11f1ae70033691e9ac7d-20260412
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1143948933; Sun, 12 Apr 2026 17:02:45 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 12 Apr 2026 17:02:44 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Sun, 12 Apr 2026 17:02:44 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v3] Bluetooth: btmtk: add event filter to filter specific event
Date: Sun, 12 Apr 2026 17:02:42 +0800
Message-ID: <20260412090242.1129701-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add an event filter to filter event with specific opcode to prevent BT
stack from receiving unexpected event.

Event with opcode 0xfc5d is generated when MediaTek's Bluetooth enable
firmware logs and is not expected to be sent to userspace.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
v1 -> v2 : update commit message
v2 -> v3 : add boundary check in btmtk.c in btmtk_recv_event; keep using
           hci_recv_frame if CONFIG_BT_MTK wasn't defined in btmtk.h
---
 drivers/bluetooth/btmtk.c | 23 +++++++++++++++++++++++
 drivers/bluetooth/btmtk.h |  7 +++++++
 drivers/bluetooth/btusb.c |  2 ++
 3 files changed, 32 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 55516b4602db..78e84ecbbb91 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1503,6 +1503,29 @@ int btmtk_usb_shutdown(struct hci_dev *hdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btmtk_usb_shutdown);
+
+int btmtk_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_event_hdr *hdr = (void *)skb->data;
+	struct hci_ev_cmd_complete *ec;
+
+	if (hdr->evt == HCI_EV_CMD_COMPLETE &&
+	    skb->len >= HCI_EVENT_HDR_SIZE + sizeof(*ec)) {
+		u16 opcode;
+
+		ec = (void *)(skb->data + HCI_EVENT_HDR_SIZE);
+		opcode = __le16_to_cpu(ec->opcode);
+
+		/* Filter vendor opcode */
+		if (opcode == 0xfc5d) {
+			kfree_skb(skb);
+			return 0;
+		}
+	}
+
+	return hci_recv_frame(hdev, skb);
+}
+EXPORT_SYMBOL_GPL(btmtk_recv_event);
 #endif
 
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index adaf385626ee..c93652508f14 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -218,6 +218,8 @@ int btmtk_usb_suspend(struct hci_dev *hdev);
 int btmtk_usb_setup(struct hci_dev *hdev);
 
 int btmtk_usb_shutdown(struct hci_dev *hdev);
+
+int btmtk_recv_event(struct hci_dev *hdev, struct sk_buff *skb);
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -296,4 +298,9 @@ static inline int btmtk_usb_shutdown(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int btmtk_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	return hci_recv_frame(hdev, skb);
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f9d515ee9124..daf8a387e660 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4150,6 +4150,8 @@ static int btusb_probe(struct usb_interface *intf,
 	} else if (id->driver_info & BTUSB_MEDIATEK) {
 		/* Allocate extra space for Mediatek device */
 		priv_size += sizeof(struct btmtk_data);
+
+		data->recv_event = btmtk_recv_event;
 	}
 
 	data->recv_acl = hci_recv_frame;
-- 
2.45.2


Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B4217648;
	Tue,  7 Apr 2026 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544496; cv=none; b=hCD+KwSPblqzLgp5VMalDf6hUt4ujpJMCOiSRdKY8fxQTk+WwDUtKh+DQFRfL3aPdwcVuanu4DnBkcOyvzv4zzx1XnCeQWK+/i1zvSd8Wyw35IcYMq2S1WuYvUaoh9XEBSPzvQtDbFvflZaPHWrK1kwOBeohMtYU8X3VUfxJrRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544496; c=relaxed/simple;
	bh=Ff8QS6H8Wb9yiDCGQp7YCpzzvk83KP/5JfAgK98fzbE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QY0iE88DFHFBpzdQ2EplPMBKCEcocvzCGsHNj4PdUA6w0jc98smuw0Y2kSE88PNuxosR2wuIZYE42aJolScg56icViNKjii4wgL/hvdUNKJEY2v6XRYRafTfuQA02oVfnQS9/aS3VwUdRqwlphXubVACpfTNOZb1MUzBZgLbaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uU5y19o9; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uU5y19o9"
X-UUID: b948b364324d11f19a16598d5ca7f8ec-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9MpSWEeOtFVXl58+rDfFFbpljSaaJoXfG6V58eCnX3o=;
	b=uU5y19o9CgafvqY5OoutrtKyB+NDd2KG8yTEgxnlMXtlhmeuVwfG+A0hlKa4xoKy6yLS6/UmPSwdMIbdubjHLHp0TsALgM0ZEHE15TLFNMk/IrFFJ6HbzxKBt5GWnokBA2y4g2MS5jLybURtHLoBPbB4J3zrSDKEj62Tk6OhAy0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:68d47d53-6c5e-4670-b12a-de014039abb4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:361991d5-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
	15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b948b364324d11f19a16598d5ca7f8ec-20260407
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1865566283; Tue, 07 Apr 2026 14:48:02 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 14:48:02 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 14:48:02 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v1] Bluetooth: btmtk: add event filter to filter specific event
Date: Tue, 7 Apr 2026 14:47:59 +0800
Message-ID: <20260407064759.3036650-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Due to some Bluetooth hosts have mechanism to detect invalid events,
causing abnormal behavior. Add a event filter to prevent debugging
events from being sent to host.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 22 ++++++++++++++++++++++
 drivers/bluetooth/btmtk.h |  7 +++++++
 drivers/bluetooth/btusb.c |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 55516b4602db..302d6ddf9062 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1503,6 +1503,28 @@ int btmtk_usb_shutdown(struct hci_dev *hdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btmtk_usb_shutdown);
+
+int btmtk_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_event_hdr *hdr = (void *)skb->data;
+
+	if (hdr->evt == HCI_EV_CMD_COMPLETE) {
+		struct hci_ev_cmd_complete *ec;
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
index adaf385626ee..08b73927c8f3 100644
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
+	return -EOPNOTSUPP;
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


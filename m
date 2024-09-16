Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89477156644;
	Mon, 16 Sep 2024 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726486800; cv=none; b=Qz5jL3JiupJEQ66OIMfhDwQ8EQaY9CpUvMsiBJkK8pk5PhPTPzh4CBxKF6KkS+8DjZ/IQojjQYQLu61RlP4PuBzxQkC8CyDoz6941JMbNLW8dszKdsFn9LJcLcev+9R6MoIfp27kr+JbW3z6l1MjOG3uM6n8Dj+Y9UVoYlrmEX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726486800; c=relaxed/simple;
	bh=ErlmQATV3KUxZ0pNDbOp/Z8kjpZtkw+CDEdk+T4exgE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9lvuA+cmKGfWnR4pbMapQv2BgBTNeB21cEqhuW8d9GyipajKyu4JRbf3sfN+pYmq4Ufpl+xk23OCz/9jsN+jHeXZBQRRbE00MWv7a703oNVmfLrjnRoJ1p9jFLaP6J7pwlvZ1qvqXXhVWGEtphCHkL8mgeE8+Qh/5GOA99nJos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=L3RD7B8t; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L3RD7B8t"
X-UUID: 604c5c3a742011ef8b96093e013ec31c-20240916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XipE8K6FG5ApXm17jslcvcuiOVDMbsFWv6YXb7+IIOc=;
	b=L3RD7B8t94NGlhfQ3AAdEUiJDaet9fBg33awxH/O4kMHzKx7Gnd1XXbfUBeOHdTF9zeRQAa+ucLtg6pjoIt4/P3+p5D5v5JsY267h84ISmfKFk/X9PWvBgV9j39NAAWCInjPGTzffmAMZEQSSG62uUUh8YGjEDtEOUl0e85sryk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:7223fcab-d338-4348-b5a8-69589cb0ad4c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:7b6317b7-8c4d-4743-b649-83c6f3b849d4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 604c5c3a742011ef8b96093e013ec31c-20240916
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 218482625; Mon, 16 Sep 2024 19:39:47 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Sep 2024 19:39:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Sep 2024 19:39:45 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 2/4] Bluetooth: btusb: add callback function in btusb_disconnect
Date: Mon, 16 Sep 2024 19:39:36 +0800
Message-ID: <20240916113938.30285-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240916113938.30285-1-chris.lu@mediatek.com>
References: <20240916113938.30285-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.331900-8.000000
X-TMASE-MatchedRID: y/MOm6ldwRI1vivz3L6ga8LPXKYZysJR9l9p8mNlkgm0ObdxMohq2ICu
	qghmtWfXXj+G1I2Cld+xpBP9Oramp2Vnjx+sD6KyngIgpj8eDcAZ1CdBJOsoY9mzcdRxL+xwKra
	uXd3MZDUo5EQfqvblfre1p4GsFJbVsIc0+IeBu7qxuSf5TeAQ1D/t1QR3QKuETaQP2XYPQ2kaQs
	z7R1kd2F9TyrSZzhrbyUQ/Y5AoRrhBLAb/FTpmUnQE0HbT5LEft/yYljnuhl10loENhqV3WYc7S
	1VgNXhPQwymtxuJ6y0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.331900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8F41247AB12269AF3FFC251FDDBFABFFF2330610EEEE6839226E252932ADD27C2000:8

Add disconnect callback function in btusb_disconnect which is reserved
for vendor specific usage before deregister hci in btusb_disconnect.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6cf1729a8225..dfc42bdc8aaf 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -846,6 +846,7 @@ struct btusb_data {
 
 	int (*suspend)(struct hci_dev *hdev);
 	int (*resume)(struct hci_dev *hdev);
+	int (*disconnect)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 	unsigned cmd_timeout_cnt;
@@ -4011,6 +4012,9 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (data->diag)
 		usb_set_intfdata(data->diag, NULL);
 
+	if (data->disconnect)
+		data->disconnect(hdev);
+
 	hci_unregister_dev(hdev);
 
 	if (intf == data->intf) {
-- 
2.18.0


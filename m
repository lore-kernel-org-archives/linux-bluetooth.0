Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9108194125;
	Mon, 23 Sep 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081238; cv=none; b=hiHTQcFJVUlslekmB8+19Lw/bUDlNPQm6pTEMYfLefY3nD6rqi0JX2Hx4/05XsBywbc88mFcDMj51fAdVGTpqvyCae+kOzSLAEcP0kSXb8xEwS3aCMMX4GNVjR2gJaV+BSoql+PwMFyM8qFDdeZYA8ulRMVa2SDsDcWZgqP1mAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081238; c=relaxed/simple;
	bh=ErlmQATV3KUxZ0pNDbOp/Z8kjpZtkw+CDEdk+T4exgE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S33lhFRqBzBRaEoUJe4aPYu0bfygKUokvjzrrQDAw00NZzvI+buED4xl9s21KlIdbVs7aJHjYAU27W9Tata54jeBhoqVmSWgo2ZAcd8AdiQ2PpdBazVNuyJ5/KQU/3BoJOWJXpSZL+JfIjLlXFD3VTGFxV1G770SLEpHjuYF3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nKXjdnv5; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nKXjdnv5"
X-UUID: 6b64dd82798811efb66947d174671e26-20240923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XipE8K6FG5ApXm17jslcvcuiOVDMbsFWv6YXb7+IIOc=;
	b=nKXjdnv5vhaNCy9eH6KX8TZ8P7op6sGHMf7EQHbrEcJ9qqVr/usW6m4Iht3/CPkgNzxRhZKdI1ejN3hiTUP2vwI9uh8hDHDI/NsXQMR3LW4GOxTRkiNIM91Rn/CKxo6FqBg9bzu8d82pv8kbD7w53adDprIngI6dTi9PujWV3hU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:74d0ac6d-3bf8-4279-a8ce-d1eeca3c402a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:fe276a9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6b64dd82798811efb66947d174671e26-20240923
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1562995415; Mon, 23 Sep 2024 16:47:09 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Sep 2024 16:47:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Sep 2024 16:47:08 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v3 2/4] Bluetooth: btusb: mediatek: add callback function in btusb_disconnect
Date: Mon, 23 Sep 2024 16:47:03 +0800
Message-ID: <20240923084705.14123-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240923084705.14123-1-chris.lu@mediatek.com>
References: <20240923084705.14123-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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


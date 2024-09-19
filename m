Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA015198E81;
	Thu, 19 Sep 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732183; cv=none; b=WP5anyCsirRYUPKtsxz7ZqrQ0na4dCY8Y/jR3Be8blCHM75XNPJ6SL1q1loe/nCvvDajjqX+ET81FeE68hqu8GK/CxqNU7z93IRWV2y+skk9cUx7Jn3Fd/BQy/LwGMACh8nFWZ6dV5/hgR1corT8iUSO8uES/eOb86mpJ1g5JXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732183; c=relaxed/simple;
	bh=ErlmQATV3KUxZ0pNDbOp/Z8kjpZtkw+CDEdk+T4exgE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBHbgM2iMRPPsSPeWSTTqkhlSTKL/pMqRqnGvDkN+rzmGbZEI0+n+OAEQaEvw8sZJqY9r9mu/uIqyaEJ3AawwCF3BztUnw99pevTnA3Dburp25tJdpbobKyPJwh2sagTD/4sD9RviCqs47rH91r5PP7nKRfC2h58EFWTMwdkTts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bi8L07pN; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bi8L07pN"
X-UUID: b3b820e2765b11efb66947d174671e26-20240919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XipE8K6FG5ApXm17jslcvcuiOVDMbsFWv6YXb7+IIOc=;
	b=bi8L07pNLHSysGcsDEpN1VIN1mDF2ZvYWCg6Nllnf4tNyxjS0jyWWCCbv4IRSwbV90YhpoI1DmgrgueHGdXn6sQF1YsjRjnOaHOo+d5nL6vPIr3aPcrycDXFAKKM32QtiEk402tKlu0naMWjh/uVp39xvl83ztYldd/KzwLZKrI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:b7a8ac71-c1a6-4746-af2e-d3805202cd19,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:9fda6ed0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b3b820e2765b11efb66947d174671e26-20240919
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 665664720; Thu, 19 Sep 2024 15:49:30 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 19 Sep 2024 15:49:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 19 Sep 2024 15:49:27 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2 2/4] Bluetooth: btusb: mediatek: add callback function in btusb_disconnect
Date: Thu, 19 Sep 2024 15:49:23 +0800
Message-ID: <20240919074925.22860-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240919074925.22860-1-chris.lu@mediatek.com>
References: <20240919074925.22860-1-chris.lu@mediatek.com>
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
X-TM-SNTS-SMTP: FF418458DD37296C8B691E6333DE9605397CF74A140DDE005066AB14311AC2F62000:8

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


Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD0E1953B5;
	Thu,  6 Jun 2024 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674222; cv=none; b=NPukGlGmbDlgerQkiH3J/vxYvDWPjLbJV15exJKixb0VFWA3TnYyqAInfEmPpLPGhiAeahhRFVLuVxw9r+FS1Jn8vftODAKdMPQRhuWiJ81J0ixv1LLSdh/LQhpgC1VDkXgVBjS+DiIS+QkxE9DDhYT5sB9DJMwmD1IZTM0Q6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674222; c=relaxed/simple;
	bh=lcjRJkwx6YePXxgAZnrNXOpG4HN97NTYEfY8cW1DhIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTn4m7eB2ZHD20mU8gkPKKXqvJJevUh7TIYPUkdOw0YibCm3+RVfJfgIQXYBRhEUKdMvxxfLHwSCVNr6c/ntObKtzXQv22mTuRRyE2OvnLeszDAbHtqyWj3qJCq71XsAJvLQ+R3YzHIxNoUVslZLNs3Gp4QSKtNfTgt/96k6nv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=L8mZnmf5; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L8mZnmf5"
X-UUID: fce7b69223f911efa22eafcdcd04c131-20240606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YUWkF0EjrHqCvoEKuIYDl0OYArHcuV5t20sbJAKBaX8=;
	b=L8mZnmf5/W98QLeXSHG+72wZqrcidXTnQNgei4RSyRi4rD6Pmo/F7baOGUkZV5em4bPYpU5bl2H3Yqyei+x0dwlZqK86iAZeoMdWF/R2CC6olKvD0XUvc302/SMrjT0sT0bmYdLrikVclk22sFyv2yC2l82rs9eiNNbCbmki91I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:ce7b06bb-7d42-42a0-8701-720e611984fb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:7a0ccb84-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: fce7b69223f911efa22eafcdcd04c131-20240606
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 124994621; Thu, 06 Jun 2024 19:43:26 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jun 2024 19:43:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jun 2024 19:43:25 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v4 2/4] Bluetooth: btusb: add callback function in btusb suspend/resume
Date: Thu, 6 Jun 2024 19:43:19 +0800
Message-ID: <20240606114321.30515-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240606114321.30515-1-chris.lu@mediatek.com>
References: <20240606114321.30515-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add new function: dev_suspend/dev_resume in btusb_data which are reserved
for vendor specific usage during suspend/resume. dev_suspend will be
added before stop traffic in btusb_suspend and dev_resume will be
added after resubmit urb in btusb_resuem.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btusb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 79aefdb3324d..83765c0c14b4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -891,6 +891,9 @@ struct btusb_data {
 
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
+	int (*dev_suspend)(struct hci_dev *hdev);
+	int (*dev_resume)(struct hci_dev *hdev);
+
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 	unsigned cmd_timeout_cnt;
 
@@ -4715,6 +4718,9 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	cancel_work_sync(&data->work);
 
+	if (data->dev_suspend)
+		data->dev_suspend(data->hdev);
+
 	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
 
@@ -4818,6 +4824,9 @@ static int btusb_resume(struct usb_interface *intf)
 			btusb_submit_isoc_urb(hdev, GFP_NOIO);
 	}
 
+	if (data->dev_resume)
+		data->dev_resume(hdev);
+
 	spin_lock_irq(&data->txlock);
 	play_deferred(data);
 	clear_bit(BTUSB_SUSPENDING, &data->flags);
-- 
2.18.0


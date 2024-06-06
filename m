Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D36C13F015;
	Thu,  6 Jun 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665835; cv=none; b=r1Cxc+4ZEjxhkKc4CT7gv5MWxTGj2u3AHhpSbT2ZfvaR+jDEKIzmR5FzwZXZJ2XfijWJ+DL5hrFtwPVtP/EGFS/2xD/qQDaLGBCJQ5opGrWLX3I/jK1Xm4OVa8dFeljUK58kUeqrYxfh9M9QnMMsRF6743nD3TwzH5wOPPrDaAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665835; c=relaxed/simple;
	bh=lcjRJkwx6YePXxgAZnrNXOpG4HN97NTYEfY8cW1DhIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMVG0Rf2Z0MmIH2IZTkD/Lz3W3MhwUPACs65haNwrfiZW/Mfn+3XXxEGVMoj6uEn+n05onIlaDqNPAxvDQrHSeu+34s2h4b1vQD1AvLisl0lSHjFFW2CKsXRmh6dxl+56U0k+YNZhmBfJnM3euDV+8qx0McM5diRRO50jkcIIUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=E5Amf2qy; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E5Amf2qy"
X-UUID: 7a2a5a2e23e611efa22eafcdcd04c131-20240606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YUWkF0EjrHqCvoEKuIYDl0OYArHcuV5t20sbJAKBaX8=;
	b=E5Amf2qySzd55tJBDfoeXNcqZ3aQKQlWaMTom7BDRSMf9gctASs71sf7+nTBMzNKKdQkU2Lr1Gy2HwKcZJDQy6MqdpL+XGtqa1pokxlWp4Jm0mV64CW9MddubduAcJIv9f6zWicYVEwnscc96czgNCLpLB7TZOFYO4BOZxniwWc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:cc737f9e-7517-4c8f-a0ff-a2305b230004,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:ebaeb093-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7a2a5a2e23e611efa22eafcdcd04c131-20240606
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 139493817; Thu, 06 Jun 2024 17:23:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jun 2024 17:23:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jun 2024 17:23:45 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v3 2/4] Bluetooth: btusb: add callback function in btusb suspend/resume
Date: Thu, 6 Jun 2024 17:23:38 +0800
Message-ID: <20240606092340.27675-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240606092340.27675-1-chris.lu@mediatek.com>
References: <20240606092340.27675-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.166100-8.000000
X-TMASE-MatchedRID: xKwqdG8zLkdQs1SN7/4/ILiMC5wdwKqdgRykyfrH1xl0Rk5xb2PnltXf
	akMEIQ7HfLIS8FLmihpf1xEson1kFmQkHQEHAoWZJsxvR/kPS6pMkOX0UoduuQqiCYa6w8tvb7e
	EsDP9hR2F8NrNX0LQ3A/uoMrYx9wGVOSZp87t6zCeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8hxKp
	vEGAbTDpA4qPsOFhGU2AcfteNpKqCv4HZLkRYL2yB16cmW2l1XxeTCd0IgD9vg1qtq6TmR6fzU0
	+t51hhPdCxMVm/tSlF6biAvwhuk1HmVKZusLp922v9OjYWA2uMMswg45VMfPXY3pGDmoik6
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.166100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	AFBE66133EF398CF08C94DC5187EB8B22737B0F790BA5777F38581CEC15F941D2000:8

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


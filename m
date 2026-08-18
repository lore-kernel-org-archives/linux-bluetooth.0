Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A03D0BE5;
	Tue, 18 Aug 2026 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039629; cv=none; b=plzAxMBilSwY/ZH770mg+APPsf8Q9e4vgJYLhQZn4wzqz5moLQkDyN0HVsZiZGi73M1TRBxVtUN3afqtfpcPrSlZBGGAGEYxlmkKi/iGvK5Wg+/PL+nT1/pER9vQxy3nEcY1ZdnIUdTX6AGc+gd+jZJlP6mLz+IWqfM5YjXdszs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039629; c=relaxed/simple;
	bh=St19Pl0mftkYZFYjEf/SQrJWd+yl1c5vKDKc/ymbbek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gtZrga4h5QuGBR0p3HMrOzXUgq1INjfJPVOxTSlMmtfbZQ7SJpYACymWYCn+9+MJ7jGK5Iet1ZNxHVnCTvQiaFQhoNVLZR7NtN5hmSaGcCQlBKURtmcXg18OTUF1VIzqGjGOzmNzZtLBH6zY2UItsD61/JfVbsvwwWvbzjYc1E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ec0692c29ad911f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d2326a37-bd2a-44f2-92ad-f6f7c88e8710,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:70bffb1bdf9e52cce7602c3f90b7257c,BulkI
	D:nil,BulkQuantity:0,SF:102|136|865|898,TC:nil,Content:0|15|50,EDM:-3|-100
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ec0692c29ad911f19a56ed5b684f684d-20260818
X-User: liujiajia@kylinos.cn
Received: from nature.lan [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 299611927; Tue, 18 Aug 2026 15:53:38 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Ying Hsu <yinghsu@chromium.org>,
	Archie Pusaka <apusaka@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jing Cai <jing.cai@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Jiajia Liu <liujiajia@kylinos.cn>
Subject: [PATCH 1/2] Bluetooth: btusb: Fix leaked runtime PM reference in btusb_reset()
Date: Tue, 18 Aug 2026 15:52:15 +0800
Message-ID: <781dc2cd5ab0533fff9ee7fdcb92fff573431f18.1787039123.git.liujiajia@kylinos.cn>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btusb_reset() calls usb_autopm_get_interface() to resume the device
before queuing a reset of it, but never calls the matching
usb_autopm_put_interface().

usb_queue_reset_device() ends up in usb_reset_device(), and since
btusb provides no pre_reset/post_reset callbacks the interface is
merely unbound and rebound: the interface device object survives
this cycle, and so does its PM usage count, which is not cleared
when the driver is unbound.

As a result every reset permanently leaks a PM usage reference,
preventing the interface from being runtime suspended again until it
is unbound.

Calling usb_autopm_put_interface() right after queuing the reset: the
reset runs asynchronously in a workqueue and usb_reset_device()
resumes the device on its own.

Fixes: c9209b269afd ("Bluetooth: btusb: Introduce generic USB reset")
Assisted-by: Claude:qwen3.8-max
Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2bae85b0016c..cc19828893c6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1051,7 +1051,6 @@ static void btusb_reset(struct hci_dev *hdev)
 	int err;
 
 	data = hci_get_drvdata(hdev);
-	/* This is not an unbalanced PM reference since the device will reset */
 	err = usb_autopm_get_interface(data->intf);
 	if (err) {
 		bt_dev_err(hdev, "Failed usb_autopm_get_interface: %d", err);
@@ -1060,6 +1059,7 @@ static void btusb_reset(struct hci_dev *hdev)
 
 	bt_dev_err(hdev, "Resetting usb device.");
 	usb_queue_reset_device(data->intf);
+	usb_autopm_put_interface(data->intf);
 }
 
 static void btusb_intel_reset(struct hci_dev *hdev)
-- 
2.55.0


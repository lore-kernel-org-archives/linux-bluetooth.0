Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.61.82.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795487008;
	b=h3QysV7YvWJR+qK1mwO/zD5ZVIVPfo8ibQqaNPq7Ne0l32a1qbcdOFGTbNLxJ8BVPBPH
	 ztjL54ETtH8Jei7catCr5OnisLLK/LqMTbYQ8chqv28bfWbfsXq4B5/A4WkmgD1AsGtiV
	 KT9EjhTPlW1dYbWye5EXlMRXuY/6SFVezmVZjc+QF0PAyTl/xRhrBff84hbrQczUdH2PG
	 2FzQb7H6k8hDL2Ez9F47LGhRcuvEMXpIH3D+Prp2Kx274xbtDCfArv6Hvk7vB/pMzdTaN
	 YARQEsfuBqaHuZ806NbgPB0PZX1sMkAgeT+NAAD19FLqoD9OgGvMAz9oHQfpF+5JkHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795487008;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=UNUvkkoXMlvuDfjJLSm2/fjyDo5rQyvistv2Jyy+JQE=;
	b=AHVqadHvUcCGJXEXSKyAt851W7T6xcp4PBWn6XfwW35GF6oZFDcykGEdzZWlMaFiIbjw
	 1p8LAo0a+F1K1qIvj2gVryhLeMfE1vb6t1Ee3JOJHSkChDxqecqZR3a15or50TRo3YMc5
	 Pf3/GUJAJ4n88PXF9oQc1UkejxcosVb3MjTJWrEU9w6mYPHVab4JzPKZ2A1X1JhBzL7zl
	 c8B4NFl7rCsu0C1NcTyKxTI5eIU1oF+uetrFzITuE3ssjURNhQNgYTnUOm+bq+GKpuWIf
	 EnisBCmb3EOntd7NzwD099P/HQ/FtjiXFpUFlbHDJ5EFV4vUAskhT2R25EHhCfRKDYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=U25I7SPf;
	arc=none smtp.remote-ip=210.61.82.184
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD753606A31E;
	Tue, 24 Nov 2026 02:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD753606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=U25I7SPf
X-UUID: 0545d542e7ae11f18dc8c9802ae25ab1-20261124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=UNUvkkoXMlvuDfjJLSm2/fjyDo5rQyvistv2Jyy+JQE=;
	b=U25I7SPfWYuJ7xEQ5DSjVMZLVQioUJw+0TR8UKh9ZY6JJnSo02pvNO/FvmamMIoEAb4gDqhOUHVzemK5+hjeU8A+AUZEzGsWBNtOIfo7mrT2VNHKpER2rzaFyLNMA1Tx0XNTieVBFCcd6K0jgTBibjQGZXgvgLpshx/vZxJ1x/k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21,REQID:1276a6d1-74bf-458b-8ecc-f6b3a45e6eb3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0318ac,CLOUDID:702816ea-4eb9-4755-ac2a-8e95ba251d29,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0545d542e7ae11f18dc8c9802ae25ab1-20261124
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 737341873; Tue, 24 Nov 2026 10:23:22 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 24 Nov 2026 10:23:21 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Tue, 24 Nov 2026 10:23:21 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Hao Qin <hao.qin@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Will
 Lee <will-cy.Lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH] Bluetooth: btusb: Add USB ID 0e8d:e028 for MediaTek MT7928
Date: Tue, 24 Nov 2026 10:23:17 +0800
Message-ID: <20261124022318.663787-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
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
Content-Type: text/plain

Add the USB device ID of the MediaTek MT7928 Bluetooth controller.
MT7928 is the marketing name of the chip, which identifies itself as
MT7935 (chip ID 0x7935) in hardware.

The hardware ID of the Bluetooth interface is:

USB\VID_0E8D&PID_E028&MI_00

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btusb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 95398e2ca098..e94a5d0ca1ec 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -848,6 +848,10 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x2c7c, 0x7009), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* MediaTek MT7928 (MT7935) Bluetooth devices */
+	{ USB_DEVICE(0x0e8d, 0xe028), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3394), .driver_info = BTUSB_REALTEK },
-- 
2.45.2


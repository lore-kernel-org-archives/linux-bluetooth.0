Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=60.244.123.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795487015;
	b=LOs6dRaHiESaA+fRox3zb3lnpyGZmfvzt0k5TzneSSidLbJ32CdtGBHZixO80ldNyy+c
	 yAlmAzQNs1zR4EXS0rhhn5DplTEX+Qno+ltUhG8mKGd8+sRRKpkKlikLTfw+hSOfmqL8S
	 xt7xrLdEeKGLK+eBEnSqIxu6MyayIiBtErhFe6X2WQCWoh+kKTEFDYNxlnoL8CiIEYBnt
	 WnrOX9nX/ElKuXZm1e7JKy8QUKFyf8LOg0iZzJhnQ4JizKf44AyQkxzsolpd/WaUct+n/
	 5ad7FvH8ks/ywb+4S6cj9B0dZW0cHUjDU3DlAU224cly5h3iNvYBQe6rrn0uhZFuJ4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795487015;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=P0xXakZdv0vwsCXEeKqDEArbRa7wMVxfx0H1jm89ElQ=;
	b=uvVtNttF5oqsVqKv6MuojA1THWQJiIdfnosvpUFIIiG9l0RqdNq1mOqJimpyWvZaEMwh
	 tvJygQi8GWZvDOqNwPdFxHaPHjYwpKpLHQpp8Fk6QpsVQ8zrtep/WfM+dfJ2soQUoXSAi
	 RZL6Lbj7dmQvzFMcs0Y/V/nYyNBHRA1VodqmxWIC/8idJ0LmCdzO0JMAToSyUASUayPXV
	 rL8hUBVcrv9yMUy/A+CWIIZuDzf1LsU/gzEnU4/WaEyhASCTiMQy/L4KGHBbcZ2xkTjWt
	 LjRKRNz7vtvyHXKEwRUr3wbO9xDLGRl798SlFF+tPv1N4NgGsEIpmxvp+uDuj1lmKiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=Nya9iYFg;
	arc=none smtp.remote-ip=60.244.123.138
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A4606A321;
	Tue, 24 Nov 2026 02:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B80A4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=Nya9iYFg
X-UUID: 05516a92e7ae11f1b1788b6acf885367-20261124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=P0xXakZdv0vwsCXEeKqDEArbRa7wMVxfx0H1jm89ElQ=;
	b=Nya9iYFgjGqPP5bRvKamH4giYGWR9BFuhmSwlVIberVDNi2Lsl05Ekcg9C/h2jE+RYj+VwQsyUcR4Wq2vW+4JN0LN2s5pfdbuUvtJ5vaL+zV+vBHZSBRW8pGHXcogKI+iAv2fZcYePsiEy4Cm/T2QMUMMic1lNAEDDyymGeVro0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.21,REQID:aeaf9b20-f37a-4379-ba20-e1de1ca6ebcd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0318ac,CLOUDID:bedbacac-906b-4a61-9d37-76e40377bd21,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 05516a92e7ae11f1b1788b6acf885367-20261124
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1241682080; Tue, 24 Nov 2026 10:23:22 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
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
Subject: [PATCH] Bluetooth: btusb: Do not set BROKEN_ENHANCED_SETUP_SYNC_CONN for newer MediaTek chips
Date: Tue, 24 Nov 2026 10:23:18 +0800
Message-ID: <20261124022318.663787-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261124022318.663787-1-chris.lu@mediatek.com>
References: <20261124022318.663787-1-chris.lu@mediatek.com>
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

HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN was set for every MediaTek
controller, which makes the host fall back to HCI_OP_SETUP_SYNC_CONN
for SCO connections. MT7921/MT7920 and the older MT7663/MT7668 need
this fallback, but the chips released after MT7921 are expected to
handle HCI_OP_ENHANCED_SETUP_SYNC_CONN properly. Note that the chip
model number does not follow the release order.

Set the quirk in btusb_mtk_setup() only when the chip ID read from the
controller is 0x7663, 0x7668 or 0x7961, so the behavior of these chips
is unchanged. MT7920 reports the same chip ID (0x7961) as MT7921, so it
keeps the quirk as well.

For MT7922 and MT7925, verified that with the quirk removed the host
uses HCI_OP_ENHANCED_SETUP_SYNC_CONN to set up SCO connections and no
problem was observed. The chips released after them are not expected to
need the quirk either.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btusb_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 95398e2ca098..f0ced6e3192f 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -3205,6 +3205,12 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 		if (platform_is_ryzen() && is_direct_child_of_root_hub(data->udev))
 			set_bit(BTUSB_WAKEUP_BROKEN, &data->flags);
 		break;
+	case 0x7663:
+	case 0x7668:
+	case 0x7961:
+		/* SCO does not work with HCI_OP_ENHANCED_SETUP_SYNC_CONN */
+		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN);
+		break;
 	}
 
 	return 0;
@@ -4621,7 +4627,6 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->reset = btmtk_reset_sync;
 		hdev->set_bdaddr = btmtk_set_bdaddr;
 		hdev->send = btusb_send_frame_mtk;
-		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN);
 		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
 		data->recv_acl = btmtk_usb_recv_acl;
 		data->recv_event = btmtk_recv_event;
-- 
2.45.2


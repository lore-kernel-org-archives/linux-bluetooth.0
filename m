Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C930F815;
	Tue,  9 Dec 2025 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765281979; cv=none; b=kAxTdNUpIX7nSiEYa5/JinFktwvoVV8MoG4NzLrVyCY/V4JU2pG/JbdFSkX5WfeEI5HY0lhLCByorw3odYKN7It1GCoAlSLZSfYHcIQ4dMVC1orZsdZuxwJ+N7I3alJXQEsY5VW1NavWzGvuQd4LSLa9TtV5fQtHRrus70jI3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765281979; c=relaxed/simple;
	bh=V8ZbFNitZxZ0q6LoUIU6sh5wINJxFzeJhsg5BYpoR1w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dW4QyaB6zms0v8BOQg6dr6RZ0irBDmOP0DQSWC9jDzCIrw3txbZ1YzELDBJijXtV6UkllREn0aCByMcFWaXhWgmNrMu+fCnpVNx3ypKSlZRDdhAaLreW/o5aKoaA6+hwLiM7+bXvS9EtmfvW9BOJ0NDcoCCboxXfhs/qxK/3VLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DGAdVkpe; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DGAdVkpe"
X-UUID: 6f05039cd4f711f0b33aeb1e7f16c2b6-20251209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=biSx7WZ/dzqIzHa74Ww6F9siP+61NLhUlnmYjDzhZbE=;
	b=DGAdVkpeTpPLxliFZwMmRsNKZF0YRw3Y6g52gkDVEZtxMhpKVMRcnceuZGvuE8N/mfhGSQ9jm6ovZ+qGAYnAPeCrhVI0bb709GhZWHMsSe9ayqqwbWSUbu28oL1tQRIYmcylJHdqw3jWJgBrUdQ9JVaGuIgIQ11VBCrVHcUhTN4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:335daf81-1d4c-4606-ab40-4f18d303d5d0,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:0547ffa9-6421-45b1-b8b8-e73e3dc9a90f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6f05039cd4f711f0b33aeb1e7f16c2b6-20251209
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 69700997; Tue, 09 Dec 2025 20:06:03 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 9 Dec 2025 20:06:02 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 9 Dec 2025 20:06:02 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v1] Bluetooth: btmtk: Trigger reset on firmware download failure
Date: Tue, 9 Dec 2025 20:05:59 +0800
Message-ID: <20251209120559.2991698-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Initiate reset flow if MT79xx series BT failed to download firmware when
doing setup.
If driver is not able to get event after reset in the first section of
btmtk_usb_setup, the protocol is deemed unuable and driver will return to
prevent from repeatedly executing resets.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index a8c520dc09e1..8b1443b9e9cf 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1333,7 +1333,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 						btmtk_usb_hci_wmt_sync);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
-			return err;
+			goto reset_fw;
 		}
 
 		/* It's Device EndPoint Reset Option Register */
@@ -1353,7 +1353,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
-			return err;
+			goto reset_fw;
 		}
 
 		hci_set_msft_opcode(hdev, 0xFD30);
@@ -1444,6 +1444,13 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 	}
 	kfree_skb(skb);
 
+reset_fw:
+	if (btmtk_data->reset_sync) {
+		bt_dev_err(hdev, "Mediatek do firmware reset");
+		btmtk_reset_sync(hdev);
+		return err;
+	}
+
 done:
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
-- 
2.45.2


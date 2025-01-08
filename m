Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725A417C20F;
	Wed,  8 Jan 2025 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329844; cv=none; b=sxC+dLss/jJ7u5awgqvGDEjs5LwzBGlptE4pJgDHm3OLvGe4uwfPwfK1VDNS3/lnXyripmX1p7DdwSf9QJKoQGeP0XLzvhWYUkY31vPGVShjy6Nl1cXBczt6eZ1VHbfnqeAqGZWG/80ZEG5GonW2m6UR/mjeKCyY7i9Z9iFNWd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329844; c=relaxed/simple;
	bh=BCsEKawGTxlsQpABQxDSNlkAABFgOYwJVLWAX33g0zg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HQUuVHVzLBpn/8x1ndIGZuKHY0dbJwL5cX7I2opew06Yggk9yo4E4zhQj1UwpN9VksPVvCE1P5RS54LBeB36woZTqc5eUIz74Lm91ktUea+hRmiZNYQ48YcFBMFlBv/BBkrjzHk/aUFuzhMG0V1SEFtNecAtOiQdzKa5ICuYdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=R2VtLKjr; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R2VtLKjr"
X-UUID: ffaa1a54cda511efbd192953cf12861f-20250108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2IVKhhITELaXn/nWTY/Xejs1YbOB4PDUF+l+l+ii61E=;
	b=R2VtLKjrt6FQ7YxcpzPCDKZSOtEy43P1OmNLVyje7q31FyHMIUJdmR1OIqzc1Z+bFdbYg23bBg/yB400H5B6wL4dxLdFANWaWlXl/KCWH1ZpJhxOm31bJP5IBDQkOw3WRWJTzK6kldrhKbfcEKuBRDk+jO16zpzfwFWJ9MGWkkQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:9cbd2026-4e4b-422a-a57c-253253f28d8a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:e29ce3d1-15ca-4d8b-940c-bbea7162947b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: ffaa1a54cda511efbd192953cf12861f-20250108
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1393148939; Wed, 08 Jan 2025 17:50:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 8 Jan 2025 17:50:30 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 8 Jan 2025 17:50:30 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v2] Bluetooth: btmtk: Fix failed to send func ctrl for MediaTek devices.
Date: Wed, 8 Jan 2025 17:50:28 +0800
Message-ID: <20250108095028.2299510-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Use usb_autopm_get_interface() and usb_autopm_put_interface()
in btmtk_usb_shutdown(), it could send func ctrl after enabling
autosuspend.

Bluetooth: btmtk_usb_hci_wmt_sync() hci0: Execution of wmt command
           timed out
Bluetooth: btmtk_usb_shutdown() hci0: Failed to send wmt func ctrl
           (-110)

Fixes: 5c5e8c52e3ca ("Bluetooth: btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c")

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
v2: Update commit message, add Fixes tag info
---
 drivers/bluetooth/btmtk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 7fd9d5ddce02..224eafc27dbe 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1472,10 +1472,15 @@ EXPORT_SYMBOL_GPL(btmtk_usb_setup);
 
 int btmtk_usb_shutdown(struct hci_dev *hdev)
 {
+	struct btmtk_data *data = hci_get_priv(hdev);
 	struct btmtk_hci_wmt_params wmt_params;
 	u8 param = 0;
 	int err;
 
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		return err;
+
 	/* Disable the device */
 	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
 	wmt_params.flag = 0;
@@ -1486,9 +1491,11 @@ int btmtk_usb_shutdown(struct hci_dev *hdev)
 	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+		usb_autopm_put_interface(data->intf);
 		return err;
 	}
 
+	usb_autopm_put_interface(data->intf);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btmtk_usb_shutdown);
-- 
2.45.2


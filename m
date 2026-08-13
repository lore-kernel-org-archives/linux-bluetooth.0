Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C4346AE1;
	Thu, 13 Aug 2026 03:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592036; cv=none; b=qisHmpDVBNwKsLou6l7tWyBGiT6LTatBEX34PwyLcYkHhWQKbrmh6pTb8n4U45zyrZsIiQNIroJ/Me5kKTkNmYt5wgWqbgogLSO+mCG5Bdag158m3J2w8NBZay5kCCxg2MZlu+FpPM4K/X7uYjX843IKLKHDA4xYWQLl8CiEmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592036; c=relaxed/simple;
	bh=1t7RyIuYAB6NZkLxWnhyL1j8CeytxE2mADWRHplUjSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCYkx6bAk6L+jm1Ri2Bn/8mHuONDWqX3yewapwVid1k39U2oAQyeq0RiHIwyfCHAxB8GSWb3uUt6aft0JpJhQoSpIGc+Qpj8y99DRkhtAJAb3FD9IbZzkA3KxRhO+E/3BydX7ppsxkigVmVct2Gw9bcVQYqn1A0FQmYnnQrwo5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ca9f14d096c711f1aa26b74ffac11d73-20260813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b62de0c4-7218-47b1-88b7-d6ec9577c968,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:a88ee5ec89d770e9a1f874af51a1efb3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ca9f14d096c711f1aa26b74ffac11d73-20260813
X-User: liujiajia@kylinos.cn
Received: from nature.lan [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 681806574; Thu, 13 Aug 2026 11:33:46 +0800
From: Jiajia Liu <liujiajia@kylinos.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Jiajia Liu <liujiajia@kylinos.cn>
Subject: [PATCH] Bluetooth: btmtk: improve error logs of MT79xx WMT operations
Date: Thu, 13 Aug 2026 11:33:17 +0800
Message-ID: <20260813033317.23914-1-liujiajia@kylinos.cn>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some identical error logs, making it difficult to distinguish
which step has the error. Improve them based on BTMTK_WMT_FUNC_CTRL and
BTMTK_WMT_PATCH_DWNLD calls and comments.

Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---
 drivers/bluetooth/btmtk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 02a96342e964..bbd0ac41fdb7 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -198,7 +198,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 
 				err = wmt_cmd_sync(hdev, &wmt_params);
 				if (err < 0) {
-					bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
+					bt_dev_err(hdev, "Failed to get wmt patch status (%d)",
 						   err);
 					goto err_release_fw;
 				}
@@ -251,7 +251,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 					err = -EIO;
 					goto err_release_fw;
 				} else if (err < 0) {
-					bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
+					bt_dev_err(hdev, "Failed to send wmt patch data (%d)",
 						   err);
 					goto err_release_fw;
 				}
@@ -1424,7 +1424,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 
 		err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
 		if (err < 0) {
-			bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+			bt_dev_err(hdev, "Failed to enable protocol (%d)", err);
 			return err;
 		}
 
@@ -1550,7 +1550,7 @@ int btmtk_usb_shutdown(struct hci_dev *hdev)
 
 	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
-		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+		bt_dev_err(hdev, "Failed to disable device (%d)", err);
 		usb_autopm_put_interface(data->intf);
 		return err;
 	}
-- 
2.55.0


Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C621CA13;
	Tue,  3 Feb 2026 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102683; cv=none; b=Ei79vVDGRddlt1F0UJ5SMIkv0nIMOpXZpBgdCXlquYY10EYiwzhU+0nutxs3ZlM/UZJiP2Ji1rV7SRhE+vC9BszhdDwmaPJqpLeQkOG/er/Bhn+uv4gFZwqy5fUHUA7Na6BbBj7wL9xALEbo6BBtiAtbcLs1kTMMlRp2IlBenjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102683; c=relaxed/simple;
	bh=0aSr+P7iQ+SwTnB8MET0t+3sfonootQ8wLtOAm51iac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UoaxyUUVwzLb3W2QWDckC8pdPwqoAMCfQ/92ourQvT1G7P6ly46KIc5rWzUpZqwhHLuawah17C3HrYqBUR0G/Nl7r3ZfvHC3coktHblmVBaopG+TipP5vJ2mT3/eW1zRaR37Bsdj0Cnh6fhuc+6HCp/qwxNScnux45dX3ir0zMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 866f57ae00cf11f1b0f03b4cfa9209d1-20260203
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:dde7ddc8-d6fe-4e87-a284-3bf9547aa378,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:846838dc3ff6ece4b67f818d95f9c410,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 866f57ae00cf11f1b0f03b4cfa9209d1-20260203
X-User: jindongyang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jindongyang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1790071685; Tue, 03 Feb 2026 15:11:13 +0800
From: Dongyang Jin <jindongyang@kylinos.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dongyang Jin <jindongyang@kylinos.cn>
Subject: [PATCH] Bluetooth: btbcm: remove done label in btbcm_patchram
Date: Tue,  3 Feb 2026 15:10:48 +0800
Message-Id: <20260203071048.1624461-1-jindongyang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no point in having the label since all it does is return the
value in the 'err' variable. Instead make every goto return directly
and remove the label.

Signed-off-by: Dongyang Jin <jindongyang@kylinos.cn>
---
 drivers/bluetooth/btbcm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d33cc70eec66..dccfbeee4721 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -223,7 +223,7 @@ int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 		err = PTR_ERR(skb);
 		bt_dev_err(hdev, "BCM: Download Minidrv command failed (%d)",
 			   err);
-		goto done;
+		return err;
 	}
 	kfree_skb(skb);
 
@@ -242,8 +242,7 @@ int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 
 		if (fw_size < cmd->plen) {
 			bt_dev_err(hdev, "BCM: Patch is corrupted");
-			err = -EINVAL;
-			goto done;
+			return -EINVAL;
 		}
 
 		cmd_param = fw_ptr;
@@ -258,7 +257,7 @@ int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 			err = PTR_ERR(skb);
 			bt_dev_err(hdev, "BCM: Patch command %04x failed (%d)",
 				   opcode, err);
-			goto done;
+			return err;
 		}
 		kfree_skb(skb);
 	}
@@ -266,8 +265,7 @@ int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 	/* 250 msec delay after Launch Ram completes */
 	msleep(250);
 
-done:
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(btbcm_patchram);
 
-- 
2.25.1


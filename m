Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547F23FC5A;
	Wed,  7 Jan 2026 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767754118; cv=none; b=jNV8OogQM/+ZEWzz/8wVY4c6kU11Ab0Vg5ASjKOkGzUWmKIuVeOJlIDK7PE/ARfPqqc+jF5DTnmFMbbQqs6qMQxokJ6U8ZvdJuXq3aZ9+gM1iPuQ3tzkH94RjKwceZDWpBMS8LFD7z/oHorKed38xBUf2spcmHkb2OEWOuZp3Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767754118; c=relaxed/simple;
	bh=kLdbw7Qo0qzMh5qaMgE2a/D4q8wiV4ZTu9l2wRryBdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lIA0NlqoxjSRDpnyM78AkmXvawyQ3JLSvrR2xUQvLR3UhtJ8OO+il7X7tw8tkNzI69b/VOKvMbsXvck37kzaOY6xvuLDmw8zvpb3llXZrbpaUTv7TXRW1RbZs8W0C+lKYC4fFFaunVQGDSKNqIjDpswyMWDwbhQINyveOTS/bpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 581b20f2eb7311f0a38c85956e01ac42-20260107
X-CID-CACHE: Type:Local,Time:202601071028+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:38bb8a90-d56b-49ef-8bbd-f24b20784e49,IP:0,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:876cb7553d37f6d7eed15638b3e44cb5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:2
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 581b20f2eb7311f0a38c85956e01ac42-20260107
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1352299388; Wed, 07 Jan 2026 10:48:28 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] Bluetooth: btusb: Reject autosuspend if HCI inquiry or LE scan is active
Date: Wed,  7 Jan 2026 10:48:20 +0800
Message-Id: <20260107024820.1722270-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If USB autosuspend occurs while BR/EDR inquiry or LE scan is active,
the ongoing HCI operation may not complete successfully. On some
devices, this can leave discovery.state stuck in DISCOVERY_FINDING.

Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/bluetooth/btusb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ded09e94d296..885c3d8c0a10 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4469,10 +4469,13 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	BT_DBG("intf %p", intf);
 
-	/* Don't auto-suspend if there are connections; external suspend calls
-	 * shall never fail.
+	/* Don't auto-suspend if there are connections or HCI operations in
+	 * progress; external suspend calls shall never fail.
 	 */
-	if (PMSG_IS_AUTO(message) && hci_conn_count(data->hdev))
+	if (PMSG_IS_AUTO(message) &&
+	    (hci_conn_count(data->hdev) ||
+	    test_bit(HCI_INQUIRY, &data->hdev->flags) ||
+	    hci_dev_test_flag(data->hdev, HCI_LE_SCAN)))
 		return -EBUSY;
 
 	if (data->suspend_count++)
-- 
2.25.1


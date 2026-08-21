Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD88125B083;
	Fri, 21 Aug 2026 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293610; cv=none; b=Z8P8mep5U0NfAgKyqffav4/cHbyhfnaLmA2YEh8TMm5KaKFaAzWfM+2Qb5Gd+VE4U9w85D7R79+WxBnYBZrXE9gkPjUQKJSByVztI4QgOlsfWiZIXO0k9C3hShU1huehU0By+G+GGMaWkal/aJExM3DLYmpIhA8jm+w88qfSL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293610; c=relaxed/simple;
	bh=y79pm9AFGbrBM1uVjag7IlOVItG1fuEIRXmxF7XmIaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOIsMfQ263i28UfJFKmMJsutudQYahqbcgHBz4nWCbyFvbEos+avbkGuevLyherwR05QOt/ObASMbna70LzJlaUSIZcAe0qcAOKv27gR7wD3LKbTE/sfWT9D76tTyIVVSIa9+lTuZ5UbsKqQRDOmtueVxPTap2pJae0Fd+X5Jjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 44ebf3729d2911f19a56ed5b684f684d-20260821
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ea2dd339-2e51-48a9-b8f5-b693a065e600,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:174f451884da7a4254b19c996bfad2f4,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|865|898,TC:nil,Content:0|15|50,EDM:-
	3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 44ebf3729d2911f19a56ed5b684f684d-20260821
X-User: liujiajia@kylinos.cn
Received: from nature.lan [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 513112561; Fri, 21 Aug 2026 14:26:40 +0800
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
Subject: [PATCH v3 2/2] Bluetooth: btusb: Fix leaked runtime PM reference in btusb_reset
Date: Fri, 21 Aug 2026 14:26:06 +0800
Message-ID: <28298803062863c449241bff5112175e1f5b8d70.1787292206.git.liujiajia@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <290cf3c065ebee3d1dcaaa4e805e1875d0f999e8.1787292206.git.liujiajia@kylinos.cn>
References: <290cf3c065ebee3d1dcaaa4e805e1875d0f999e8.1787292206.git.liujiajia@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btusb_reset calls usb_autopm_get_interface to resume the device
before queuing a reset of it, but never calls the matching
usb_autopm_put_interface.

usb_queue_reset_device ends up in usb_reset_device(), and since
btusb provides no pre_reset/post_reset callbacks the interface is
merely unbound and rebound: the interface device object survives
this cycle, and so does its PM usage count, which is not cleared
when the driver is unbound.

As a result every reset permanently leaks a PM usage reference,
preventing the interface from being runtime suspended again until
it is unbound.

Set BTUSB_RESET flag after usb_autopm_get_interface so that
btusb_disconnect drops the reference. If the flag is already set,
drop the newly acquired reference and return.

Fixes: c9209b269afd ("Bluetooth: btusb: Introduce generic USB reset")
Assisted-by: Claude:qwen3.8-max
Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---

Changes in v3:
- handle multiple reset requests int btusb_reset (sashiko)
  set BTUSB_RESET after usb_autopm_get_interface. If the flag is
  already set, drop newly acquired reference and return.

- drop the comment

Changes in v2:
- Fix the race window (sashiko)
  set BTUSB_USB_RESET_ACTIVE flag before usb_queue_reset_device.

Changes in v1:
- add usb_autopm_put_interface after usb_queue_reset_device

---
 drivers/bluetooth/btusb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 360cec460ce7..37946cff6156 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1033,13 +1033,18 @@ static void btusb_reset(struct hci_dev *hdev)
 	int err;
 
 	data = hci_get_drvdata(hdev);
-	/* This is not an unbalanced PM reference since the device will reset */
 	err = usb_autopm_get_interface(data->intf);
 	if (err) {
 		bt_dev_err(hdev, "Failed usb_autopm_get_interface: %d", err);
 		return;
 	}
 
+	if (test_and_set_bit(BTUSB_RESET, &data->flags)) {
+		bt_dev_err(hdev, "last usb reset failed? Not resetting again");
+		usb_autopm_put_interface_no_suspend(data->intf);
+		return;
+	}
+
 	bt_dev_err(hdev, "Resetting usb device.");
 	usb_queue_reset_device(data->intf);
 }
-- 
2.55.0


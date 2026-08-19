Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C77448D05;
	Wed, 19 Aug 2026 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133151; cv=none; b=qqvYXm/D/bo4R/gMwg7W1DsX0IM2eK+88iL2JZ1gvhNvEK/yEL/9ebPRZVzD3YZdCkLhxt9BYKcd+V9Z8xpMF6uJMFG7TkKBtWgjQfwIH9dvR5N2/RuYTxphCI+WVJoLvhRjhfmDMrd9QH8sxAAgB+nqeh9jW+/6JtKC+gtpdJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133151; c=relaxed/simple;
	bh=0nVDA1G0HPIyzTSTV7Z2F62gsGwoHj3FU2F/6zEhkUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/deu+ABfJMmu2ZYp3rfR2z/WmcOaErv1CfACq3KKv923nD5+G0dWsRO5t9VAAnaT6tr21hGTGUGbbr5EMbYJyx+QerQ8oyUMWjxYZgzjPwspPd37AgxIO+NLa/5dNqdSjarIXJARnjt+Xac4Xo0+YNUHc56DISuPWnaMdtk8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ac9cfda89bb311f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:bc74f226-5ddb-4fcc-a10d-29476d432c8c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:f1bb0513c15bb466cbd6d68b5bffb98d,BulkI
	D:nil,BulkQuantity:0,SF:102|136|865|898,TC:nil,Content:0|15|50,EDM:-3|-100
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ac9cfda89bb311f19a56ed5b684f684d-20260819
X-User: liujiajia@kylinos.cn
Received: from nature.lan [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1108759978; Wed, 19 Aug 2026 17:52:22 +0800
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
Subject: [PATCH v2 1/2] Bluetooth: btusb: mediatek: Fix leaked runtime PM reference in reset
Date: Wed, 19 Aug 2026 17:52:08 +0800
Message-ID: <ec23dae6c247005e8eccd312d326a626163ea491.1787132512.git.liujiajia@kylinos.cn>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT7925 on HP Pro Mini 260 sometimes timed out during reloading driver
and reset usb device. btusb_suspend is not called again after closing
bluetooth interface.

 usbcore: registered new interface driver btusb
 Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260605184935
 Bluetooth: hci0: Execution of wmt command timed out
 Bluetooth: hci0: Failed to send wmt patch dwnld (-110)
 Bluetooth: hci0: Failed to set up firmware (-110)
 usb 3-10: reset high-speed USB device number 4 using xhci_hcd
 Bluetooth: hci0: HW/SW Version: 0x00000000, Build Time: 20260605184935
 Bluetooth: hci0: Device setup in 1856545 usecs
 Bluetooth: hci0: AOSP extensions version v1.00
 Bluetooth: hci0: AOSP quality report is supported
 Bluetooth: MGMT ver 1.23

btusb_mtk_reset calls usb_autopm_get_interface to resume the device
before driving the hardware reset, but never calls the matching
usb_autopm_put_interface. Every hardware reset therefore leaks a PM
usage reference of the interface, preventing the device from being
runtime suspended again until it is unbound.

Add BTUSB_USB_RESET_ACTIVE flag and set it before usb_queue_reset_device.
Release the PM reference in btusb_disconnect if this flag is set.

Fixes: 25b6d7593a3a ("Bluetooth: btmtk: introduce btmtk reset work")
Assisted-by: Claude:qwen3.8-max
Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---

Changes in v2:
- Fix the race window (sashiko)
  Add and set BTUSB_USB_RESET_ACTIVE flag before usb_queue_reset_device.
  Release PM reference in btusb_disconnect if this flag is set.

Changes in v1:
- add usb_autopm_put_interface after usb_queue_reset_device

---
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 184e95c1625e..45a726bed0dd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -957,6 +957,7 @@ struct qca_dump_info {
 #define BTUSB_USE_ALT3_FOR_WBS	15
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
+#define BTUSB_USB_RESET_ACTIVE	18
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -2915,6 +2916,7 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 
 	err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
 
+	set_bit(BTUSB_USB_RESET_ACTIVE, &data->flags);
 	usb_queue_reset_device(data->intf);
 	clear_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags);
 
@@ -4497,6 +4499,9 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
 
+	if (test_bit(BTUSB_USB_RESET_ACTIVE, &data->flags))
+		usb_autopm_put_interface_no_suspend(data->intf);
+
 	if (intf == data->intf) {
 		if (data->isoc)
 			usb_driver_release_interface(&btusb_driver, data->isoc);
-- 
2.55.0


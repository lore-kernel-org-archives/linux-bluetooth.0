Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8923EAB3;
	Mon, 24 Aug 2026 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787534069; cv=none; b=Mr8p02ZL8+k6Bchz+NNIFYxRsCbzWj/aMqcU108vlhh0Jl2ME8owD/AzHIgqAzllehnh/7BKMzxJ9KF7gJT4Wg0L2nYbvwhMaWlNPCaMaS1xIsDFNhIzWACKcTIyYOOvMced5/muREPiYMNpteo2ycWEc7Z5SeXnr37wPcZlUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787534069; c=relaxed/simple;
	bh=HCM0x4GBeLTrZB40ETUWu+NtQxTPtzcCdTeuLWypJUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=buTzxPwfg8E6UZexxaBfH6TZboN42xQsh97WPA8E+VinPrs4mIJbeE180NDvMbkjFtkAF4XC7VojffkjDPxAZlHnqUcy/VgjTAA2Lkws+JZNNPaQiQ5RnnwyGRfTRZmHZGhh94NzxjZwD7DhESyXGRUXcxbpGSWz7nI950Az+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6a57d9ce9f5811f19a56ed5b684f684d-20260824
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:140851fc-e384-4fe3-ad9b-98d3cb667b51,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:dc90ac184cdb00c67510a7f936423c1a,BulkI
	D:nil,BulkQuantity:0,SF:102|136|865|898,TC:nil,Content:0|15|50,EDM:-3|-100
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6a57d9ce9f5811f19a56ed5b684f684d-20260824
X-User: liujiajia@kylinos.cn
Received: from nature.lan [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liujiajia@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 211265000; Mon, 24 Aug 2026 09:09:11 +0800
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
Subject: [PATCH v4 1/2] Bluetooth: btusb: mediatek: Fix leaked runtime PM reference in reset
Date: Mon, 24 Aug 2026 09:08:59 +0800
Message-ID: <59a4c09e1cb02ad8c375a08e5af164d64a3d7061.1787477831.git.liujia6264@gmail.com>
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

Add the BTUSB_RESET flag. It is set before usb_queue_reset_device
and is cleared in btusb_disconnect, which drops the reference as well.
If the flag is already set when a new reset is requested, drop one
reference.

Also clear BTMTK_HW_RESET_ACTIVE if usb_autopm_get_interface fails,
otherwise no further reset could ever be attempted.

Fixes: 25b6d7593a3a ("Bluetooth: btmtk: introduce btmtk reset work")
Assisted-by: Claude:qwen3.8-max
Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
---

Changes in v4:
- do not return if BTUSB_RESET is set in case the first reset failed.
  move test_and_set_bit right before usb_queue_reset_device (sashiko)

Changes in v3:
- rename BTUSB_USB_RESET_ACTIVE to BTUSB_RESET (Luiz)

- test_and_clear_bit BTUSB_RESET in btusb_disconnect (Luiz)

- handle multiple reset requests int btusb_mtk_reset (sashiko)
  set BTUSB_RESET if no reset_gpio after usb_autopm_get_interface.
  If the flag is already set, add log and drop newly acquired reference
  and return.

- clear BTMTK_HW_RESET_ACTIVE if usb_autopm_get_interface fails and add
  error log. (sashiko)

---
 drivers/bluetooth/btusb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 184e95c1625e5..c95f72484fc0f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -957,6 +957,7 @@ struct qca_dump_info {
 #define BTUSB_USE_ALT3_FOR_WBS	15
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
+#define BTUSB_RESET		18
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -2891,8 +2892,11 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	}
 
 	err = usb_autopm_get_interface(data->intf);
-	if (err < 0)
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed usb_autopm_get_interface: %d", err);
+		clear_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags);
 		return err;
+	}
 
 	/* Release MediaTek ISO data interface */
 	btusb_mtk_release_iso_intf(hdev);
@@ -2915,6 +2919,11 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 
 	err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
 
+	if (test_and_set_bit(BTUSB_RESET, &data->flags)) {
+		bt_dev_err(hdev, "last usb reset failed? Resetting again");
+		usb_autopm_put_interface_no_suspend(data->intf);
+	}
+
 	usb_queue_reset_device(data->intf);
 	clear_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags);
 
@@ -4497,6 +4506,9 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
 
+	if (test_and_clear_bit(BTUSB_RESET, &data->flags))
+		usb_autopm_put_interface_no_suspend(data->intf);
+
 	if (intf == data->intf) {
 		if (data->isoc)
 			usb_driver_release_interface(&btusb_driver, data->isoc);
-- 
2.53.0


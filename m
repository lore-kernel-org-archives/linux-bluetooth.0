Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EA0280325;
	Fri, 31 Oct 2025 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898548; cv=none; b=TQA+mudao2nHN4wlnjtrQ/0ip1REaa9tnT0GZxGWIv11BMzCvQ3TxPUArergziZ05UH0n3pR0t+lLRvobn5wmO1wTYWjFeJwy3Q5LsirpO9zQfnIvFfd2d9drTOARka2p84T4M1GAxfCSpvxeHJoj1w1COPcTWBYl/5BPNRzyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898548; c=relaxed/simple;
	bh=BQEfkHAA/cvrsQwoFjP1JCUVNTwO17DlLYDFoE4HyC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nco1KG/Jn/cMIMgCqt9xZ6u/RGmrQorO/7kGbNIz7ukSg33FTln+PNRuzMON34mGNNFjkrC/v0fKtXEqZr3KZue4OkDkoOtqgSjO/ppsvkaJp/D9DaxZG31Bgd5TVv7yvvISDt8tQldnM+PYXXEEvxWQ/b1UnqQvFLZ4Y1xw65A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c35c19e2b63111f0a38c85956e01ac42-20251031
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:eed4762e-8c93-4ab9-950e-9de796f78dfd,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:6a368bf88c433b2fdc9f1f42fedcc099,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|15|50,EDM:-3,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c35c19e2b63111f0a38c85956e01ac42-20251031
X-User: lilinmao@kylinos.cn
Received: from llmserver.local [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1474029217; Fri, 31 Oct 2025 16:15:29 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] Bluetooth: btusb: Prevent autosuspend when le_scan_disable work is pending
Date: Fri, 31 Oct 2025 16:15:25 +0800
Message-Id: <20251031081525.2275894-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When USB autosuspend occurs while le_scan_disable work is scheduled,
HCI commands sent by the work fail with timeout, leaving LE scan in
an inconsistent state.

Scenario:
  T=0:     LE scan starts, le_scan_disable work queued (+10240ms)
  T=8s:    Autosuspend check: tx_in_flight=0, suspend proceeds
  T=10s:   le_scan_disable work executes on suspended device
           → HCI command 0x2042 times out

The tx_in_flight check only protects actively transmitted URBs, missing
the window where work is queued but hasn't submitted its URB yet.

Fix by checking delayed_work_pending(&hdev->le_scan_disable) during
autosuspend. Return -EBUSY if pending to block suspend until work
completes. Only set BTUSB_SUSPENDING after all checks pass to avoid
leaving the flag set if suspend is aborted.

Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/bluetooth/btusb.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5e9ebf0c5312..a344ea1dc466 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4389,6 +4389,7 @@ static void btusb_disconnect(struct usb_interface *intf)
 static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
+	struct hci_dev *hdev = data->hdev;
 
 	BT_DBG("intf %p", intf);
 
@@ -4402,14 +4403,19 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 		return 0;
 
 	spin_lock_irq(&data->txlock);
-	if (!(PMSG_IS_AUTO(message) && data->tx_in_flight)) {
-		set_bit(BTUSB_SUSPENDING, &data->flags);
-		spin_unlock_irq(&data->txlock);
-	} else {
+	if (PMSG_IS_AUTO(message) && data->tx_in_flight) {
 		spin_unlock_irq(&data->txlock);
 		data->suspend_count--;
 		return -EBUSY;
 	}
+	spin_unlock_irq(&data->txlock);
+
+	if (PMSG_IS_AUTO(message) && delayed_work_pending(&hdev->le_scan_disable)) {
+		data->suspend_count--;
+		return -EBUSY;
+	}
+
+	set_bit(BTUSB_SUSPENDING, &data->flags);
 
 	cancel_work_sync(&data->work);
 
-- 
2.25.1


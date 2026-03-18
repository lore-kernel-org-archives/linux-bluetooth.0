Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B982274FEB
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 02:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773802740; cv=none; b=Yb9bWAUnqQhjgLeVodclQCbWYqnGevi4DksczE430M+QNrp/D240IbtHAgXxqF1msXzY5+dxD1KxXN3J3EdmwkfEDaxM7Be+dWbCNHs4L34ihYNb6hlv81BErv9NebNtYV6lhLRNJt1niUfyLo19ljaT2AQKN+ITZjivWyi2dZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773802740; c=relaxed/simple;
	bh=T9KFNHfNA/c1421yKwLI9yjNdXiijp6CmQJtYqehCfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cfe3AWfF+PMLBAjpwpnGdIO/+5yKyPuvMu3/fGS1HCOF83WVbAF6/uFKVxxoVKI4+jeO0w/9pFrEraZxtkA8CLNRPG5nGxOquqILnX/ojTiHu6Sa2WIFkKpTwBrwDEvin/73Rq3wADYMtnMAv1JunMaBKDpC3SpO0D9uHjVicbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k1eKJovs; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k1eKJovs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Go
	rFROAI8URQKXNATon1Gt2eHbVdn164+Ooav0/gAHA=; b=k1eKJovsopnQPNnqDY
	EO7ddGN4QtX0WIMepuKqWAudevUR1WSQn//Zymlsor7HrPfRaN82rgyXAkmsAkBg
	4ZK3p0ZKwMy8+Hv6cRO4loQCw4l+PL911Y850DIQORuinsad+kEw95uFXZpo5ZmR
	q/cypz7nzUxTZurzrpTa9Wv4Q=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3P3eXFLppCWcUBw--.23043S2;
	Wed, 18 Mar 2026 10:57:29 +0800 (CST)
From: zhangchen200426@163.com
To: luiz.von.dentz@intel.com,
	pav@iki.fi,
	pmenzel@molgen.mpg.de,
	kuniyu@google.com,
	yang.li@amlogic.com,
	kees@kernel.org,
	ceggers@arri.de,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Zhang Chen <zhangchen01@kylinos.cn>
Subject: [PATCH] Bluetooth: HCI: Fix hci0 not release in usb disconnect process
Date: Wed, 18 Mar 2026 10:57:24 +0800
Message-Id: <20260318025724.1431313-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P3eXFLppCWcUBw--.23043S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF4xKr4fXFy3Cw48JF4fKrg_yoW7Jryxpa
	9IyFyFyry8XrWfWry8Aa18AFyYkw4I93y7ArW5G3sxC390vw48tr1UAryYqF9xZrWDJw1D
	ZF4vqw4a93WUWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn4SrUUUUU=
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbC6Bk00Gm6FJl7pQAA3V

From: Zhang Chen <zhangchen01@kylinos.cn>

If hci_resume_dev before hci_unregister_dev, the hci command will
timeout and the reference count of hdev will not reset to zero.
Then the node "hci0" will not release.

The output in question is as follows:
Bluetooth: hci0: command 0x0c01 tx timeout
Bluetooth: hci0: Opcode 0x0c01 failed: -110
Bluetooth: hci0: command 0x0c01 tx timeout
Bluetooth: hci0: Opcode 0x0c1a failed: -110
usb 10-1: new full-speed USB device number 95 using xhci-hcd
usb 10-1: Product: Bluetooth Radio
usb 10-1: Manufacturer: Realtek
usb 10-1: SerialNumber: 00e04c000001
Bluetooth: hci1: RTL: rom_version status=0 version=1
Bluetooth: hci1: RTL: loading rtl_bt/rtl8852bu_fw.bin
Bluetooth: hci1: RTL: loading rtl_bt/rtl8852bu_config.bin
Bluetooth: hci1: RTL: cfg_sz 6, total sz 65603

The call sequence in question is as follows:
usb disconnect:
  btusb_disconnect
   hci_unregister_dev
    hci_dev_set_flag
    hci_cmd_sync_clear
    hci_unregister_suspend_notifier
    hci_dev_do_close
    device_del

device resume:
  hci_suspend_notifier
   hci_resume_dev
    hci_resume_sync
     hci_set_event_mask_sync
      __hci_cmd_sync_status
       __hci_cmd_sync_status_sk
        __hci_cmd_sync_sk
         wait_event_interruptible_timeout

This patch add hci_cancel_cmd_sync in hci_unregister_dev to wake up
hdev->req_wait_q, and stop __hci_cmd_sync_sk by judging the
HCI_UNREGISTER flag. Then stopping hci_resume_dev process based on the
returned error code.

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Cc: linux-bluetooth@vger.kernel.org
Signed-off-by: Zhang Chen <zhangchen01@kylinos.cn>
---
 net/bluetooth/hci_core.c |  6 ++++++
 net/bluetooth/hci_sync.c | 22 ++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 22598581b1ad..c6238a69a0d5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -50,6 +50,7 @@
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
 static void hci_tx_work(struct work_struct *work);
+static void hci_cancel_cmd_sync(struct hci_dev *hdev, int err);
 
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
@@ -2696,6 +2697,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_dev_set_flag(hdev, HCI_UNREGISTER);
 	mutex_unlock(&hdev->unregister_lock);
 
+	hci_cancel_cmd_sync(hdev, EINTR);
+
 	write_lock(&hci_dev_list_lock);
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
@@ -2878,6 +2881,9 @@ int hci_resume_dev(struct hci_dev *hdev)
 	ret = hci_resume_sync(hdev);
 	hci_req_sync_unlock(hdev);
 
+	if (ret && hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return 0;
+
 	mgmt_resuming(hdev, hdev->wake_reason, &hdev->wake_addr,
 		      hdev->wake_addr_type);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3166914b0d6c..ac4c973dd976 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -174,10 +174,11 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return ERR_PTR(err);
 
 	err = wait_event_interruptible_timeout(hdev->req_wait_q,
-					       hdev->req_status != HCI_REQ_PEND,
+					       hdev->req_status != HCI_REQ_PEND ||
+					       hci_dev_test_flag(hdev, HCI_UNREGISTER),
 					       timeout);
 
-	if (err == -ERESTARTSYS)
+	if (err == -ERESTARTSYS || hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		return ERR_PTR(-EINTR);
 
 	switch (hdev->req_status) {
@@ -6346,6 +6347,7 @@ static int hci_resume_scan_sync(struct hci_dev *hdev)
  */
 int hci_resume_sync(struct hci_dev *hdev)
 {
+	int err;
 	/* If not marked as suspended there nothing to do */
 	if (!hdev->suspended)
 		return 0;
@@ -6353,10 +6355,14 @@ int hci_resume_sync(struct hci_dev *hdev)
 	hdev->suspended = false;
 
 	/* Restore event mask */
-	hci_set_event_mask_sync(hdev);
+	err = hci_set_event_mask_sync(hdev);
+	if (err && hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return err;
 
 	/* Clear any event filters and restore scan state */
-	hci_clear_event_filter_sync(hdev);
+	err = hci_clear_event_filter_sync(hdev);
+	if (err && hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return err;
 
 	/* Resume scanning */
 	hci_resume_scan_sync(hdev);
@@ -6365,10 +6371,14 @@ int hci_resume_sync(struct hci_dev *hdev)
 	hci_resume_monitor_sync(hdev);
 
 	/* Resume other advertisements */
-	hci_resume_advertising_sync(hdev);
+	err = hci_resume_advertising_sync(hdev);
+	if (err && hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return err;
 
 	/* Resume discovery */
-	hci_resume_discovery_sync(hdev);
+	err = hci_resume_discovery_sync(hdev);
+	if (err && hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return err;
 
 	return 0;
 }
-- 
2.25.1


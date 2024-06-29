Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CD71E4AF
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jun 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719681771; cv=none; b=BxVwuMyL6SyBic7DxPLGSn5lBtwJ4XMkAMRdYj1D6P0IaERA0rvgbn66q6o19o15NZ2Wx6apXoYQrP6b6hxsyYq7kQhiuibxmAE8keFJk3js6lSzYZnFoJ3RUwxKaVXX9OI8uZSXhOEUaCUB2c2LRJ+9QBGRIELbKonr61pWEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719681771; c=relaxed/simple;
	bh=GBsVH62zV6MrDDNMXQvcUgZ9KsQlbUGwNcOiGMclPjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTjnwU5HOiWi2hJhzPf0Y3vRkDk1c2/nGiSp57qjIpqMkMr/jixzOaLZ5nlj6ibwh8H4f5DUsRupKW1pj28Ngrcdgq5HNEVXXKl+9f7/FpnwbrANaHYv6dzCaGkMAQmJIotYais+2H3/T9nWNJ0lQiVSGRJSfJGwEuemhgi73uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=BeK2mAPZ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="BeK2mAPZ"
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 8C0AB87C86;
	Sat, 29 Jun 2024 19:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719681767;
	bh=zNaCxoi+jOcZ1UhqLxhXttg7o4tmkGI8giElsMg3Ggc=;
	h=From:To:Cc:Subject:Date:From;
	b=BeK2mAPZ6TO+M887JRalQEFgDWTWTphBwfPYUBuIUW0e1TAMUskthqizM6FU+/1Qs
	 MiExl8Q/UE3uGQw5vsKV8ILI1WpAaC6gX02jqmXi8/uHXgsCCgdzanKeREcXoVe5R/
	 CYCisKnLwGjgCUd8sxhuQVXuTECFHv2E8lMVqn6LrD+6N+CakbzWl3lOD3TrkBjDWQ
	 UBYmBm5TQfjxXGgUAYDQ0Bg10+tUyXVqcWXSQfbQ+9l6U8VfvOl3vt8hRhUVhs+9y9
	 ZegOm4OJVQ1eHK8fiuizMGVwRqwbrBUfyPiTV6PVKuOPjacZlhEXb7iXv/e+htGBv3
	 3M11XiaNJH46A==
From: Marek Vasut <marex@denx.de>
To: linux-bluetooth@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	kernel@dh-electronics.com
Subject: [bluetooth-next PATCH] Bluetooth: hci_bcm: Configure sleep mode on RPM suspend/resume
Date: Sat, 29 Jun 2024 19:22:04 +0200
Message-ID: <20240629172235.29901-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The Infineon CYW43439 Bluetooth device enters suspend mode right after
receiving the Set_Sleepmode_Param sleep_mode=1 HCI command, even if the
BT_DEV_WAKE input is HIGH, i.e. device ought to be awake. This triggers
a timeout of any follow up HCI command, in case of regular boot, that is
HCI_OP_RESET command issued from hci_init1_sync() .

Rework the code such that during probe, the device is configured to not
enter sleep mode by issuing Set_Sleepmode_Param sleep_mode=0 instead of
sleep_mode=1 in bcm_setup(). Upon RPM suspend, issue Set_Sleepmode_Param
with sleep_mode=1 to allow the device to enter the sleep mode when the
BT_DEV_WAKE signal is deasserted, which is deasserted soon after in the
RPM suspend callback. Upon RPM resume, assert BT_DEV_WAKE to resume the
chip from sleep mode and then issue Set_Sleepmode_Param sleep_mode=0 to
yet again prevent the device from entering sleep mode until the next RPM
suspend.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: kernel@dh-electronics.com
Cc: linux-bluetooth@vger.kernel.org
---
 drivers/bluetooth/hci_bcm.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 89d4c2224546f..fde5e0136c392 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -389,13 +389,19 @@ static const struct bcm_set_sleep_mode default_sleep_params = {
 	.pulsed_host_wake = 1,
 };
 
-static int bcm_setup_sleep(struct hci_uart *hu)
+static int bcm_setup_sleep(struct hci_uart *hu, bool sync, int mode)
 {
 	struct bcm_data *bcm = hu->priv;
 	struct sk_buff *skb;
 	struct bcm_set_sleep_mode sleep_params = default_sleep_params;
 
 	sleep_params.host_wake_active = !bcm->dev->irq_active_low;
+	sleep_params.sleep_mode = mode;
+
+	if (!sync) {
+		return __hci_cmd_send(hu->hdev, 0xfc27, sizeof(sleep_params),
+				      &sleep_params);
+	}
 
 	skb = __hci_cmd_sync(hu->hdev, 0xfc27, sizeof(sleep_params),
 			     &sleep_params, HCI_INIT_TIMEOUT);
@@ -412,7 +418,7 @@ static int bcm_setup_sleep(struct hci_uart *hu)
 }
 #else
 static inline int bcm_request_irq(struct bcm_data *bcm) { return 0; }
-static inline int bcm_setup_sleep(struct hci_uart *hu) { return 0; }
+static inline int bcm_setup_sleep(struct hci_uart *hu, bool sync, int mode) { return 0; }
 #endif
 
 static int bcm_set_diag(struct hci_dev *hdev, bool enable)
@@ -647,7 +653,7 @@ static int bcm_setup(struct hci_uart *hu)
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hu->hdev->quirks);
 
 	if (!bcm_request_irq(bcm))
-		err = bcm_setup_sleep(hu);
+		err = bcm_setup_sleep(hu, true, 0);
 
 	return err;
 }
@@ -767,6 +773,16 @@ static int bcm_suspend_device(struct device *dev)
 	bt_dev_dbg(bdev, "");
 
 	if (!bdev->is_suspended && bdev->hu) {
+		err = bcm_setup_sleep(bdev->hu, false, 1);
+		/*
+		 * If the sleep mode cannot be enabled, the BT device
+		 * may consume more power, but this should not prevent
+		 * RPM suspend from completion. Warn about this, but
+		 * attempt to suspend anyway.
+		 */
+		if (err)
+			dev_err(dev, "Failed to enable sleep mode\n");
+
 		hci_uart_set_flow_control(bdev->hu, true);
 
 		/* Once this returns, driver suspends BT via GPIO */
@@ -810,6 +826,16 @@ static int bcm_resume_device(struct device *dev)
 		bdev->is_suspended = false;
 
 		hci_uart_set_flow_control(bdev->hu, false);
+
+		err = bcm_setup_sleep(bdev->hu, false, 0);
+		/*
+		 * If the sleep mode cannot be disabled, the BT device
+		 * may fail to respond to commands at times, or may be
+		 * completely unresponsive. Warn user about this, but
+		 * attempt to resume anyway in best effort manner.
+		 */
+		if (err)
+			dev_err(dev, "Failed to disable sleep mode\n");
 	}
 
 	return 0;
-- 
2.43.0


Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B238BF6C;
	Tue,  2 Jun 2026 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425526; cv=pass; b=mD7HjnYtaVrnu1Dl5zvYNkEHsi6L+T/29igeWtFggJ6GG0T6bM0GaOBksn8hjMT7YOm5VeBPuKv274X9uvu/yI133zLQcP+KZvaGtCZ7ux0xZw9BrPDPPoQYCXQ4WxO6BTRiR1WM+rJymOTOqOXq071IsJFKCr9bSyLTMTwqia0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425526; c=relaxed/simple;
	bh=/vC9qk/++wVxd8/XAI/30MRORw4uUJcw1ko9SHcAF1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j5lNwED7BtU3lz7O95ObhI2XiWzttMUyKjQ6/trZMeDIanrF67g2AiWdJJosSfzmmMPA2Fb4FWTuXTacWrLRviyyfwY1YQvnivoEJ8635B0jPzaUDjJrjMSkvRBJiqmVhfA43NF7KYkylakm2MidmqbzzF9XT01u+zKt2uuH984=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=qIDsWr5j; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="qIDsWr5j"
ARC-Seal: i=1; a=rsa-sha256; t=1780425508; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TvA/v8z3zJpF6ASip88x0r5DmZ+Ubddx5xhoYTPwmXl0KG9ySNblDLqt8b1bYDScnyEdZqW/WJp16M1UybL1Zohx6qIBtyCEF5SIXFWBXGz5wl9h9BbZoZcdw3RXCrS7YAD9fCgC9zfSfPKPIPsmnur0kIMc/QOfcRWxCHH9G+Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780425508; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=o6QSHn+bWpbFxZV+XX27moTnu4Gwm7clToWp0ddbfl0=; 
	b=djO7bNSIgCdP6AXpFPqS/mImLg4ffyO1uTzNsrtF7CSoE0Rd3ht4f5W+OoUpZZOLwPYCgBjTQF+XEEl5QTteEvofZEj08xy5ZXQ65dPBsANgr4N86epH/EO4r6bsr7+U5Gqscv3OjhkDbHdG09Jn55VLnW7D1fEOeY6tuyHVi5E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780425508;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=o6QSHn+bWpbFxZV+XX27moTnu4Gwm7clToWp0ddbfl0=;
	b=qIDsWr5jZkzSVcnuQikmp3szrn+vZTVeytDgrP5qLV1h9QBPI9JYm+zXTtFs4KPM
	/DyOo0a1Qf4Lx02FLWAWafu/Uju1/8AGysTNxfxOYWu9OKU6wuzx9jf3B55ro8q0Nb8
	Yz+3z1Gc6SuCG3J1Dbqnh0FXGaWQIarqIKu9167ADv3kYzv8qcN9IuZI5wS0wLm8gQe
	wL9+mO507Xw/KdS7aIDycT7syCwf4EE5oHlX+D7UYo9p6FoPkWWCgcQdpQiVXJN+6EU
	GQP/zVf7UycquEFzss7M/VTFFBXp77ZQuecvoxZDkebKC16i4qV6CB5gcV24tqEK7hP
	lDwmTwDA9A==
Received: by mx.zohomail.com with SMTPS id 1780425506915761.0970031020775;
	Tue, 2 Jun 2026 11:38:26 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Wed, 03 Jun 2026 02:38:10 +0800
Subject: [PATCH] Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-btmtk-remote-wakeup-v1-1-5c1006442f36@rong.moe>
X-B4-Tracking: v=1; b=H4sIABEjH2oC/yXMSw6CMBRG4a2QO/YObJsIboU4KPUvXgmP9IEmh
 L1bYfgNztkoIggi3auNAlaJMk8F10tF7mWnHizPYrJGKaW15i6NaeCAcU7gjx2QFzaN8cY1N+v
 rmkq5BHj5Htf2cTrm7g2X/iva9x8Aib94dwAAAA==
X-Change-ID: a4222333-btmtk-remote-wakeup-494f4c97af88
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-d5d98
X-ZohoMailClient: External

These NICs are often reported to lose their Bluetooth interfaces, i.e,
their USB interfaces suddenly become completely unresponsive, causing
the USB core to reset them, only to find that they are no longer
accessible. A power cycle is required to make the Bluetooth interfaces
recover.

After some investigations, I found that their USB autosuspend remote
wakeup capabilities are so broken that they are precisely the culprit
behind the issue:

  [27452.608056] hub 3-0:1.0: state 7 ports 5 chg 0000 evt 0020
  [27452.702018] usb 3-5: usb wakeup-resume
  [27452.716038] usb 3-5: Waited 0ms for CONNECT
  [27452.716642] usb 3-5: finish resume
  /* usbmon showed that the device was completely unresponsive to any
     URBs after the remote wakeup */
  [27457.836030] usb 3-5: retry with reset-resume
  [27457.956046] usb 3-5: reset high-speed USB device number 4 using xhci_hcd
  [27463.332047] usb 3-5: device descriptor read/64, error -110
  [27478.948117] usb 3-5: device descriptor read/64, error -110
  [27479.172430] usb 3-5: reset high-speed USB device number 4 using xhci_hcd
  [27484.332035] usb 3-5: device descriptor read/64, error -110
  [27499.940039] usb 3-5: device descriptor read/64, error -110
  [27500.164060] usb 3-5: reset high-speed USB device number 4 using xhci_hcd
  [27505.196142] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command
  [27510.576045] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command
  [27510.784038] usb 3-5: device not accepting address 4, error -62
  [27510.912215] usb 3-5: reset high-speed USB device number 4 using xhci_hcd
  [27515.948307] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command
  [27521.324380] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command
  [27521.525107] usb 3-5: device not accepting address 4, error -62
  [27521.525928] usb usb3-port5: logical disconnect
  [27521.525996] usb 3-5: gone after usb resume? status -19
  [27521.526230] usb 3-5: can't resume, status -19
  [27521.526434] usb usb3-port5: logical disconnect
  [27521.526469] usb usb3-port5: resume, status -19
  [27521.526493] usb usb3-port5: status 0503, change 0004, 480 Mb/s
  [27521.526528] usb 3-5: USB disconnect, device number 4
  [27521.526736] usb 3-5: unregistering device
  [27521.804029] usb 3-5: new high-speed USB device number 5 using xhci_hcd
  [27527.076067] usb 3-5: device descriptor read/64, error -110
  [27542.692027] usb 3-5: device descriptor read/64, error -110
  [27542.916047] usb 3-5: new high-speed USB device number 6 using xhci_hcd
  [27548.068043] usb 3-5: device descriptor read/64, error -110
  [27563.684073] usb 3-5: device descriptor read/64, error -110
  [27563.792133] usb usb3-port5: attempt power cycle
  [27563.924381] hub 3-0:1.0: port_wait_reset: err = -11
  [27563.925213] usb usb3-port5: not enabled, trying reset again...
  [27564.184398] usb 3-5: new high-speed USB device number 7 using xhci_hcd
  [27569.196322] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command
  [27574.572040] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command
  [27574.776053] usb 3-5: device not accepting address 7, error -62
  [27574.900165] usb 3-5: new high-speed USB device number 8 using xhci_hcd
  [27579.948039] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command
  [27585.324331] xhci_hcd 0000:67:00.0: Timeout while waiting for setup device command
  [27585.528040] usb 3-5: device not accepting address 8, error -62
  [27585.528389] usb usb3-port5: unable to enumerate USB device
  [27585.528424] hub 3-0:1.0: state 7 ports 5 chg 0000 evt 0020

To reproduce the issue, these conditions must be met:
- a noisy radio environment (cafe or office) to cause frequent remote
  wakeup events
- no Bluetooth device is connected, so autosuspend is not prohibited
- the Bluetooth interface is opened, so remote wakeup is enabled when
  the device runs into autosuspend

Then I can reproduce the issue within sereval hours each time.

Increasing TRSMRCY or setting USB_QUIRK_RESET doesn't help at all.

Since the remote wakeup capability is super broken, just disable it to
get rid of the troubles. The device can still be autosuspended when
the bluetooth interface is closed, which won't break the device as
remote wakeup is unneeded in this case.

Link: https://bbs.archlinux.org/viewtopic.php?id=308169
Link: https://bbs.bee-link.com/d/7694-gtr9-pro-ai-max-395-usb-issues
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/bluetooth/btmtk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 8ff66b276af0..3d2a8598892b 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1379,6 +1379,16 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		break;
 	case 0x7922:
 	case 0x7925:
+		/*
+		 * A remote wakeup could cause the device completely unresponsive, and
+		 * recovering from such a state needs a power cycle.
+		 *
+		 * Since the remote wakeup capability is super broken, just disable it
+		 * to get rid of the troubles. The device can still be autosuspended
+		 * when the bluetooth interface is closed.
+		 */
+		device_set_wakeup_capable(&btmtk_data->udev->dev, false);
+		fallthrough;
 	case 0x7961:
 	case 0x7902:
 	case 0x6639:

---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: a4222333-btmtk-remote-wakeup-494f4c97af88

Thanks,
Rong


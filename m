Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793448997;
	b=nxfrzm13BgDsoarZ6Ep4JIP8YsJlLYmPrlmM6GlWx4tF0Ohh1Ixvd8mLZtsDECRrFa+b
	 0Noz+zXzpBDhkm/oJ61RkJ68sWPmoAq7lHLS9tyK/F2yIYUbkpwwhJvBmchTiKoadDx7I
	 PqPWE+fP073DfKWa/QbNY/rkygN98sBotI/3/k+IydW7swiZAz+lV2LksKpN9iL7e/QSn
	 htc1dvXJrBemDnMKTEbHJs+kb0cu44KikC6nlylzeVQrHqlf20ON84GxGA94gilTz701K
	 flv8Pdrr+TfdGAZl2T6tGq6yDPEuCZPNflx2nWpGkS0bKM+ONcbUg8mvmPZvieHk+tA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793448997;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=u85XSISWPysWcstcJvussxvAsuxTNwSFhcA4brqqkXU=;
	b=UEp1Z3WVsgmPIal6oRlxrTYSxop6QCuu6xEQZNhrhSsMCpMgZr+mMmrydPtf4ejEkwbA
	 EAmMoct5Hc1zZQSgD/z1PN1vK5X7cSNQ15/6HCP1OlufMzZaKrimeLPeSzh6sEDPST+Ok
	 kk3rqwoY9sVpBs/D3xuQdtpB0gEBf+HUDhRpMeyLDG/wr7WZ1rslQvvVfcoJWL2IMhMYZ
	 I60O5x5aFUpPMHkkm1cahx+5CFMNI2wHNjXccml4HG/CV/wAZIBRN4BcTqzef4UAFIfOp
	 A50fjcVaHMU9LrX0FYbAc927ul9BFVwmi8JfO72gBC2wnEFG1l+huYHIL3fLNiUMNxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPy5znbd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0D606A31F;
	Sat, 31 Oct 2026 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPy5znbd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793448996;
	b=y4EGAmfUCt/y/M0Tjm8NYyvaJAZPm2mIMdheeLE/TdZA4bBmeMXe1opNX8luL80EWiVd
	 2bAMyN/vi/GwMSX9QShIaNpZpdC74lwPddKzj00U0NkR4zbCyy8FpeneqpM5mxOwj9RYm
	 ys8yxTlV4KM0LmQGj284BTPpGZKQge+ui6bB5wzK3R4Es8ZL213cpqBjhYr0Alrchhg5T
	 /jxIWtMMzRJ5W6Wpv9vB46qR8sPjwGrdVGR+5ftNCAlv06VouoUOugN1ebTJzFUM2y7nP
	 dXaq9JSNb42zQP6wNI/enfH9xV5qIqdK+q6j0qbFBTYnSj+mOapRyN0k1D2qc1nyCvA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793448996;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=u85XSISWPysWcstcJvussxvAsuxTNwSFhcA4brqqkXU=;
	b=SCodzZUCvpmDbM3ZxyJFvKwYTjXweuqSCmA3v/DQwl41+0SleCujLVmGHIP1A9ceWIPG
	 3k9RcR3ucz5C3+khiYnQLkWP4VClcSsClwsT2I/+ojfJc6r5bHLSezvkMoQ664nNY5fUQ
	 mGMfvxODwolvGgzRYBHdhVrrVMjvRYlNQturi9ZmNb6LdgN0Q4nChlOSfxYL4gcK73D19
	 ZpNHBm1gkZ591DdvSo62eMbhfwQsnB8OO6oCE7m5/d1vAIglWKdTzC6kgjMZqlDFL/ua+
	 kYo6qcT7muHzZXfpVAO8N2zm1KHFFxEjEmdU5k9DPuVwrz7C527uL2+N64kCpu+yiqQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C29901F00919;
	Sat, 31 Oct 2026 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793448996;
	bh=u85XSISWPysWcstcJvussxvAsuxTNwSFhcA4brqqkXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bPy5znbdQbC8BhgRV0sB8gMzafx4gQTMLZtTFxtaPEj4wIx7dGcnVKi/bVLldrrwf
	 s5myNjDOwHxNSPEfyxrSiNonxQY2xfYnpmbyROQzJyTVBj+PNAyTov1AeCVojHs6Zf
	 aB2ga0LGJYMaAWNTxQVRfXIT1I2xy4dWAgNzygwHvagRtury9ars98Drg0IXLr4dGM
	 wU0/ZN8B8s+u3PGc8PxLaIznIURUabFkAaKFJ0pSSQnoDPT1EjZxDExs/03z0rz6o1
	 wK4Jnbj1qTPlBNwW95S29TWLfyuqZEKPYfeIg2WrlG7MCmGALn4VjdKiF1C4s2ayuA
	 L4Y4xmsbTvTCQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4C71445EC8;
	Sat, 31 Oct 2026 12:16:35 +0000 (UTC)
From: Ernesto Salvetti via B4 Relay <devnull+ernesto.salvetti.tambosi.tn.it@kernel.org>
Date: Sat, 31 Oct 2026 13:16:17 +0100
Subject: [PATCH 3/3] Bluetooth: btusb: Disable broken LE extended scan on
 Barrot controllers
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261031-barrot-le-fixes-v1-v1-3-30e2089882bf@tambosi.tn.it>
References: <20261031-barrot-le-fixes-v1-v1-0-30e2089882bf@tambosi.tn.it>
In-Reply-To: <20261031-barrot-le-fixes-v1-v1-0-30e2089882bf@tambosi.tn.it>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793448994; l=2029;
 i=ernesto.salvetti@tambosi.tn.it; s=20261031; h=from:subject:message-id;
 bh=Fo2F/LHMZlxUCU94fy+cZtcQarZ+SAzum0VbRoH027c=;
 b=veY8SItlpCgGAwnU3X9Ogf0M1oE2m3jCTQ/d76N/IcfE0CkaC2Q+LTNIJ9pn8kr3SBvuCxDxE
 yALEr2ZmKrWCfFmwG+yuPYbm7NJVTYf1SnU2rg3FJNgoDfc2hTLoqrL
X-Developer-Key: i=ernesto.salvetti@tambosi.tn.it; a=ed25519;
 pk=OLNiuyRbYD4dcNYoAvM99nt/1KZTKeM316r91BCQDUs=
X-Endpoint-Received: by B4 Relay for
 ernesto.salvetti@tambosi.tn.it/20261031 with auth_id=1370
X-Original-From: Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>
Reply-To: ernesto.salvetti@tambosi.tn.it
Content-Transfer-Encoding: 7bit

From: Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>

The Barrot controller in the UGREEN Bluetooth 5.4 dongle (33fa:0010)
reports support for LE Set Extended Scan Parameters/Enable and LE
Extended Create Connection, but stops answering commands as soon as
extended scanning is used. btusb then resets the device, it
re-enumerates and the same thing happens again, in a loop every ~4
seconds whenever a scan is started (e.g. to connect to an LE device):

  Bluetooth: hci0: Opcode 0x2041 failed: -110
  Bluetooth: hci0: command 0x2041 tx timeout
  usb 9-7: USB disconnect, device number 13
  usb 9-7: new full-speed USB device number 14 using xhci_hcd

Set HCI_QUIRK_BROKEN_EXT_SCAN and HCI_QUIRK_BROKEN_EXT_CREATE_CONN so
that only the legacy LE commands are used. Extended create connection
has to go as well, since legacy and extended commands can't be mixed.

This depends on the previous two patches: without them scanning fails
with Command Disallowed and LE connections are dropped right after
they are established.

Tested with 33fa:0010 (bcdDevice 88.91) and an Xbox Wireless
Controller: scanning, LE Secure Connections pairing and HID input work.
33fa:0012 shares the BTUSB_BARROT flag but was not tested.

Assisted-by: LLM
Signed-off-by: Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>
---
 drivers/bluetooth/btusb_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 92a78a7e6039..d5f18134ee3a 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -4735,6 +4735,12 @@ static int btusb_probe(struct usb_interface *intf,
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT);
 	}
 
+	if (id->driver_info & BTUSB_BARROT) {
+		/* Support is advertised, but the controller hangs on it */
+		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_SCAN);
+		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_CREATE_CONN);
+	}
+
 	if (!reset)
 		hci_set_quirk(hdev, HCI_QUIRK_RESET_ON_CLOSE);
 

-- 
2.53.0.697.g625c4fb2daa



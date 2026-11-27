Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795740472;
	b=WnCsDLU5CczkvnpxJu18knlb78P05bP4Cw6AtS/vK+R5cZ+RU8bStAsQrwOTLa1d1Ida
	 J4LSzmJPIs22QbRuSGSlfmYAc8UdXr3u/mDjkr2hRrUx8ZEB7+s8PvDRa19xh1W6I9Q2t
	 cqAAiY3YdQllbEXcBkwo/iTLBJFhwpwVTV02wU+GlqdDhTS6RRK1T1f9HiVSnKCYpuCmG
	 aZwe+xxhLZD8YgxazQnXRO2JLM4E8Sio5e9RWzjjnlcZegW2fzWu2OAd3sCg1N+KcIs1i
	 f0Rs6iwn0pmSh2t4SjMN6uF2jBxFVxaURENFj2EZejgE9vg8QR3d4tzHckNHUwfxHEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795740472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dCfn2DRCtfqqxPpOlmoy4RkBjr9+3cGVgFmExiqCNdQ=;
	b=Fj3g2pELAyGza2huozQq6oV55dXKz9g8O1uFUiE75UxELvc5KC1kIZlRn2JRjpIOx3Hj
	 WtDb5bw9MNyHy0ytiHXDxvBT6Lj8Np6KFlW3Ptclv5hIzO+xJ3s5QeHdj5IRhAfG+aW6y
	 Tu9ewKpyiCE6DkXJvc7eT6CdtePEypscTerBwpgFxHGcnwyurd5IsZCSiU+QQsgzCd7sR
	 iVlQarmb7sX2EUAJzV6jCrIlRy8ZCyHc8WzEplLKS2pDRY9PJaJX7pRJr28XBBvhhE8FQ
	 InX3DVa+xeoJIzGGjBwHqbcTucieYhi2FOzr6/XzAjx1IsyPSF18JH4HoGPWgouNmcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l8GHix/s";
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC11606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFC11606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l8GHix/s
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1ae58d17cd9so8488636c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 16:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795740471; x=1796345271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCfn2DRCtfqqxPpOlmoy4RkBjr9+3cGVgFmExiqCNdQ=;
        b=l8GHix/s9ySTdlfMsFNH8y36VMA/K99QrH4N2GWUz3A7tKr0DMigq3xJnQJ4SeS6Z8
         mSkjqLqw5Pzqz9weT7laNOAeCl2nopFg+bf+S3a3H/aJ7YSToVB7wbDsYsY+R13vXT2e
         GQ3aEHriCtZFUWtNcJJt+EuRc7a9co40RPtbcMyqlmXsFYaWfjNMTPeJvO/GSdkKPcSI
         rhDWKkLJ5YPVfXTabZbwdtnxuSqFfVvBXmvI5GGBQEFrbIId9oCNvFzj1JOHgjn7JaLp
         yCOqIkEvE0WMwvuCWBhK3ppBdz6Ha0MUJbZoB9wMEm4de1ORiD/nyPOU5Khw20G++lhp
         bL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795740471; x=1796345271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCfn2DRCtfqqxPpOlmoy4RkBjr9+3cGVgFmExiqCNdQ=;
        b=hmNq8S1NbBz8kSHfOyA5l83gzdEdfhVfGT3DCKBx+4g51KA8UhPCMxyRntVJGcdh7C
         FjXNGcr9UGYfn+n0g4VH6eIvC2XruG2DJ0oWI2AGxVERtocfHjqZnG2XMDUf2tPSL2TN
         /XKrxOLS2o96oZ+tvYJb/Arph5H1ntQI15om2RTPbPLUM+5diqHeOrqcmWAmw+ZlVCAx
         h03wdNpwoZlIvK2iWrJTVjUqjYOOzbs+kkGX/8ARi4/T1B+RG1cBOPudW8KVIUi50lUC
         cwe8EEA3gQdXGfZWwa26b1TuDlW5c8m/Xh9tVsSkkh2eI4BaStp8nn0WPLjC4PFoOuvE
         73+Q==
X-Gm-Message-State: APuU4Z8xJOGcFPGkACHIH3HqFMI1epWJho0AdG7S1JIk7QroSlQ3/G3+
	r54xzR/ri2Yuzwy1E+nbGMIax4Kd/fWUWxYzVNXRIOo4itcm4jSQsgCi
X-Gm-Gg: AZFdTZfFSW5XSKmyQRFOR3N1Lhe6eTLSqVzU8tfxlwfFbuQBWUm+A0xvleD3FtMU+uN
	Ag5shpQNaccAgkMB8kMrZwvUku72PpKP6mgDskS3gTr4KE3+46OqH1/jKE6zyznyIyOedcAbbG7
	gW0QUMMrx/SpgqwY2F4L+GKabPlaK0Rhbck+WlxZAlfPzTyTDBLYsSnyP5HmybG42MzOV21LEEw
	lUpMInjxex42TrTlAY0QDQW27eAjBxZKUDMCCwqVeB+DPa+4GcJ2R5AygdGwiu8WmKOMyMm8HRZ
	RCIlIENuAEO6FDba282MUgmAkc/Mwkg/AgWYKqLr7YeTLgDky22BsB01PsMS4/JjtthC5vAIGuR
	s4w/NqKnR/vxmQRA74ME7HDBZWTFk6o/U7nxmaaFhfiDnZim6miE21sTfXF2NWh4zjGVRyS199U
	wfsVq0IYv0aHc4l86FN/rbrr+suH8nIrs0ErD67HWzOKz7bhCHsoogMgMiIziLFffgqgbdpCwlz
	/SNPbB0v4Jrcnc2gPfKh4h4uJftGxXVhvibJMaYCfUBXCnhnAMBL7h2IlWMzjD4v6z7kVV0OY3P
	bmdelhjNWaO6Do+TeQ2J4cLCAF9d+Xexx6dxAJ6b911ub21Jc10C
X-Received: by 2002:a05:7022:1708:b0:1b2:3742:828e with SMTP id a92af1059eb24-1b5567b21c1mr19909237c88.3.1795740470832;
        Thu, 26 Nov 2026 16:47:50 -0800 (PST)
Received: from penguine ([157.15.89.48])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55682d301sm53593082c88.10.2026.11.26.16.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 16:47:50 -0800 (PST)
From: Swapnil Shinde <shindeswapnil028@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Swapnil Shinde <shindeswapnil028@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Disable autosuspend and add shutdown reset for RTL8723DE
Date: Fri, 27 Nov 2026 06:16:44 +0530
Message-ID: <20261127004644.8363-1-shindeswapnil028@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Realtek RTL8723DE combo adapters (0bda:b009 / 10ec:d723), enabling
USB runtime autosuspend puts the USB Bluetooth interface into L2/D2
suspend while the PCIe Wi-Fi MAC remains active, wedging the shared
power rail across a warm reboot when Bluetooth is toggled off mid-session.
Additionally, btusb_driver omits a .shutdown callback, leaving Realtek
firmware active across kernel_restart() when Bluetooth remains active.

Disable USB autosuspend for 0x0bda:0xb009 during probe and add a
.shutdown callback to clear remote wakeup, reset active controllers,
and stop USB URBs cleanly on reboot.

Signed-off-by: Swapnil Shinde <shindeswapnil028@gmail.com>
---
 drivers/bluetooth/btusb_main.c | 38 ++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 95398e2ca..5b1bff4ae 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -1016,6 +1016,7 @@ struct btqca_data {
 #define BTUSB_HW_SSR_ACTIVE	17
 #define BTUSB_WAKEUP_BROKEN	18
 #define BTUSB_RESET		19
+#define BTUSB_NEEDS_SHUTDOWN_RESET	20
 
 #define BTUSB_PROTO_LEGACY	0x00
 #define BTUSB_PROTO_H4		0x01
@@ -2143,6 +2144,7 @@ static int btusb_open(struct hci_dev *hdev)
 	}
 
 	data->intf->needs_remote_wakeup = 1;
+	set_bit(BTUSB_NEEDS_SHUTDOWN_RESET, &data->flags);
 
 	if (data->proto == BTUSB_PROTO_LEGACY) {
 		if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
@@ -4721,8 +4723,13 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->reset = btusb_rtl_reset;
 		hdev->hw_error = btusb_rtl_hw_error;
 
-		/* Realtek devices need to set remote wakeup on auto-suspend */
-		set_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags);
+		if (le16_to_cpu(data->udev->descriptor.idVendor) == 0x0bda &&
+		    le16_to_cpu(data->udev->descriptor.idProduct) == 0xb009) {
+			enable_autosuspend = false;
+		} else {
+			/* Realtek devices need to set remote wakeup on auto-suspend */
+			set_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags);
+		}
 		set_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags);
 	}
 
@@ -5093,10 +5100,37 @@ static void btusb_coredump(struct device *dev)
 }
 #endif
 
+static void btusb_shutdown(struct usb_interface *intf)
+{
+	struct btusb_data *data = usb_get_intfdata(intf);
+	struct hci_dev *hdev;
+	int err = -1;
+
+	if (!data || intf != data->intf)
+		return;
+
+	hdev = data->hdev;
+	data->intf->needs_remote_wakeup = 0;
+	data->udev->do_remote_wakeup = 0;
+
+	if (test_and_clear_bit(BTUSB_NEEDS_SHUTDOWN_RESET, &data->flags) &&
+	    hdev->shutdown) {
+		err = usb_autopm_get_interface(data->intf);
+		hdev->shutdown(hdev);
+	}
+
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+
+	if (!err)
+		usb_autopm_put_interface(data->intf);
+}
+
 static struct usb_driver btusb_driver = {
 	.name		= "btusb",
 	.probe		= btusb_probe,
 	.disconnect	= btusb_disconnect,
+	.shutdown	= btusb_shutdown,
 	.suspend	= pm_ptr(btusb_suspend),
 	.resume		= pm_ptr(btusb_resume),
 	.id_table	= btusb_table,
-- 
2.56.0


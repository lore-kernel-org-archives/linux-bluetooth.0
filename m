Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765331A571
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227821; cv=none; b=nqX0PsIKt8ZWTlwGSzI0idwmliX4cUANCDm+IBy2DTycsyrVQzUPEsAjolKq6gfjbMtlN3h2Tdfwn7jCDh32qkY/L+d2ngW9XSnh60YCdcZTk//wWxoJwxB1bmNZqjGemZr9QtO0Y2+RVDB1gSkD3HX3XnjgWqHbfrEST3aCdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227821; c=relaxed/simple;
	bh=tvSO6gSC8/rNdohIjb/OE8VtLeU6Qi6+ryLhdRRfips=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+fud+OoHpWq24bIslZQduIQRmxE8NO7y5i0RVMBNCXpKk8gi2zhhB/6lD/z62l71SBARrdWxKAk0+SRIKZEWUbzTP60D8ckUZ+RIWGxc5w16eg97oHxJr/DAeXBZfZ/iWsb08CQyOOt/+2Gjdb8Is8k6N9Dt4hMty9kX+AHrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5Wv7Ob6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5Wv7Ob6"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7a0442bso971852566b.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 10:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756227815; x=1756832615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjQ5D4uludUIETB7mZVVGkp3VsP6wPEJqU+C8m5nTWU=;
        b=m5Wv7Ob6t+CaX8FprM+pIy5z9xJrLD/138bSJ92wXpqH2wUnyCYqLVrkVmh3k0Mp4F
         XVeM4eeJ80HIB+Y/OR/WbBElucJqC1f7n5+yG9WY6yseI2l+NSWx5rN3N6ckxRhIiaJo
         Vatcll6GVnAbgSn26WZJxy+U71CNAmoZDmIddlKfjFFu9SRqeA+KpbgYcn6AWc0RQhDh
         M/a0AbZNy+tYVB6h52aUviAhdrVHs9j0OzrAU8XyLLPehCquI0XrC7iXy/dDqyGD51ys
         Qj/Q7QVLwpCx9Ntwk0sFvbDWI2CeU/987kBqggAAxUUvry06PncyCOzyhLGdj5JiNZzQ
         yHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756227815; x=1756832615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjQ5D4uludUIETB7mZVVGkp3VsP6wPEJqU+C8m5nTWU=;
        b=poQ6MJQKg+/0WCytgDHIPIQDpMRP9hIkTgpKHayMCnwhwmI8i+LWHgH3Ww2GJpaOVP
         2z1MfyNB+CA5aJZ/pQpk0A9bb4jVh88UT4WWrra7xrtM7JZCBe1FxV5j858MSKTU8DEc
         H9sgRbshzctiZZ59Oev5/WuVaxuOiUXcf9uIsGgZFW5OziJskPupM+QWp5xYqb/Su9JS
         jCYKTHlggJ7fhINJgyZ/rDGeA1uQDIVrzCoH5O2PStzqiW1T+AtHpw7ab5/xF6Jty2hA
         VARAVTEDguQrth3xdTMZc+70c+TgldDRJ7oH3egbRjvI0tnJYNDrtZjcxVLAz4gXmPwR
         J4Zg==
X-Gm-Message-State: AOJu0YwRyDUsXTBewnuOEfGtzfTl/D1RCT8PXQpJO7E7EdfVqPphF6eZ
	1cbKol82JLn7YC84rfrjrdXlSXAthRxJ6UZilnFMasd4nuFR7xJgX1kkoUkuQVIN
X-Gm-Gg: ASbGncufvysftpIBvtU4UAb8thXgvSjTGWhBNrDuHlypMdnmyrW2MI+pquzMQKUdnmM
	heXNewyTy0ZuW46Q1P7NbeOrmi5v3gzfykYZ1W+ZJOWeetLFsmbdtdTXYM19Qh6fV6TLCifv/Rs
	TwJVy6FFO/tJ1DIdbZWK9Jl0I3VFOQ5U4muoscV7jzDbkczv9FU/s9EFIlMpYyK7Ek5xD09Egx8
	qQBJOMofLBRuQXBQcpCaxoCiFGXQUh6/FuFL+kp8wvJmlWVAToteWepOpm5GyURllCPAO1A8jEO
	ODhZnRSd+OhZyls4S4ILPczv1yZ76Zb+yIj+6fmhWtgzb428fHOyfwRYaxObMiH8gPpqlf+p4Os
	YKhI4EJiIKvjqRGMKkSaVy1Z8qUIWr5O78CE/Z5/GzvRiF21enzK+yUb4gyWdN6Se9YP2nce5T4
	GBfjAilLca2A5ZgUsg2w==
X-Google-Smtp-Source: AGHT+IGzPntnD8r8j0hN9Lks3oBhRjHIWzQZ+w3u0JBgcPl0x3hff8tYhIwRil5VZlw5UoVgFYqy4w==
X-Received: by 2002:a17:907:6e92:b0:af9:5b3f:2dfc with SMTP id a640c23a62f3a-afe2965ac9fmr1342168566b.47.1756227814365;
        Tue, 26 Aug 2025 10:03:34 -0700 (PDT)
Received: from localhost.localdomain (46.205.200.232.nat.ftth.dynamic.t-mobile.pl. [46.205.200.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe6cdbd545sm611515966b.54.2025.08.26.10.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 10:03:33 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH v2] Bluetooth: btusb: Check for unexpected bytes when defragmenting HCI frames
Date: Tue, 26 Aug 2025 19:03:13 +0200
Message-ID: <20250826170314.352122-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <CABBYNZLmTCh_mn7w6U31B82cBZsmLaj92dxwfK9PVWZeMqk54Q@mail.gmail.com>
References: <CABBYNZLmTCh_mn7w6U31B82cBZsmLaj92dxwfK9PVWZeMqk54Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Barrot based USB Bluetooth dongles erroneously send one extra
random byte for the HCI_OP_READ_LOCAL_EXT_FEATURES command. The
consequence of that is that the next HCI transfer is misaligned by one
byte causing undefined behavior. In most cases the response event for
the next command fails with random error code.

Since the HCI_OP_READ_LOCAL_EXT_FEATURES command is used during HCI
controller initialization, the initialization fails rendering the USB
dongle not usable.

> [59.464099] usb 1-1.3: new full-speed USB device number 11 using xhci_hcd
> [59.561617] usb 1-1.3: New USB device found, idVendor=33fa, idProduct=0012, bcdDevice=88.91
> [59.561642] usb 1-1.3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [59.561656] usb 1-1.3: Product: UGREEN BT6.0 Adapter
> [61.720116] Bluetooth: hci1: command 0x1005 tx timeout
> [61.720167] Bluetooth: hci1: Opcode 0x1005 failed: -110

This patch was tested with the 33fa:0012 device. Now the device is
initialized properly:

> [43.329852] usb 1-1.4: new full-speed USB device number 4 using dwc_otg
> [43.446790] usb 1-1.4: New USB device found, idVendor=33fa, idProduct=0012, bcdDevice=88.91
> [43.446813] usb 1-1.4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [43.446821] usb 1-1.4: Product: UGREEN BT6.0 Adapter
> [43.582024] Bluetooth: hci1: Unexpected continuation: 1 bytes
> [43.703025] Bluetooth: hci1: Unexpected continuation: 1 bytes
> [43.750141] Bluetooth: MGMT ver 1.23

Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Tested-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
---
 drivers/bluetooth/btusb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8085fabad..24a249d1c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1192,6 +1192,18 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 		}
 
 		if (!hci_skb_expect(skb)) {
+			/* Each chunk should correct to at least 1 or more
+			 * events so if there are still bytes left that doesn't
+			 * constitute a new event this is likely a bug in the
+			 * controller.
+			 */
+			if (count && count < HCI_EVENT_HDR_SIZE) {
+				bt_dev_warn(data->hdev,
+					"Unexpected continuation: %d bytes",
+					count);
+				count = 0;
+			}
+
 			/* Complete frame */
 			btusb_recv_event(data, skb);
 			skb = NULL;
-- 
2.47.2


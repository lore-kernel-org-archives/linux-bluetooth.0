Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119458;
	b=x7wzY4cwIIgN14Icfir7ngiULiG6va3kGhedzNkw+zfX2c3USh4pSVRp5yALxiPXZiGj
	 jBfEwWnwlwd9f2bhd1Fu7o8nUppMalHAKNutXMatjd5zTvMxTxZ1Gj+IVSGRVP1mLfGPp
	 a1px7pKGy01g544b2JEYX6jBfug9C0RJsjh/O3mtObtwT82qV9CeU267ThF1jl/g0aU2M
	 pnUZd+5UwVztLOKrDVHfvLtIaBraSRs8i81jXR1wfYJ9jpTGCxiaCfElvtft7nYMg0Vyd
	 IZID6kMiwGHsjkL3yHMA6ndL+vHaqCOgMLMjoFExjFhfifI8UXhWwx31Fd5dB/iA8xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WhJahr3WUJU1qY8vy85c2uHoo0Or5WAKLAI0s9GBRkA=;
	b=feFjT8muywNHOAw7R06Ye+SWbhgZ2X3THSqJPmMahTgtMl3XLnnUD+VOpv5kWlI4vIOy
	 hvcujofSnh3zf3bOG5b8IsBjxy2l5rHBBWwo5uobqUS32GbSxJIPRr/31vb/l+z46wUdp
	 8A7D6GxLOYKuZ3nxKXzdWVB1Av7Y1wHF42olzV/iJUW0U6DeK8JsTE4FxERpvYop6Vc5t
	 Kmu1h+Xf8U4soJwXVgLQ/yXA/enguGpx0ysNqF8WwiiDP71TSOAcd7daJFNS6d4ggYCfg
	 RZbhkAP6rjlv/oaR7ck+b0DTB6xNEDsSCuyTXa0awrP9bsL36N4ACd4Y+2Pc4vCvSyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QfUNQaSL;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDADF606A31D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 16:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDADF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QfUNQaSL
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so117174241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119457; x=1793724257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WhJahr3WUJU1qY8vy85c2uHoo0Or5WAKLAI0s9GBRkA=;
        b=QfUNQaSL1FBOUZYFB3KuR/aB5MdgqchkcAiWHEJD9cbjwqg43/0W/oCs0NuzZgGExm
         zHA7kbnPNn0RyTnHWMbj/Bz7qidNPcQ2jzZNSxngSeakJ4VjNHHh8LPR326QNuMLu3b0
         FJCN0xY63Q1sEpcfm4tOFeXu15KOOsoLf+wxUojkqUYpcV6zJpMhyOxvSnB9mzB+Y0Gy
         3PnnLZL09N2oqOKRzefO84vrxBEhcPJ8+BS8vS+h5a6kaoTXoCddagmtxcD2twGT5l0v
         lrhBMvPmrsvrWN8ZzAQxzPGjhZMqCBAEMcXLUl5+VAEix2bRA5EPfA4HLtkBb5LzSvN9
         /D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119457; x=1793724257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WhJahr3WUJU1qY8vy85c2uHoo0Or5WAKLAI0s9GBRkA=;
        b=ZRnq5oCG3oFgwxlhEgdN77MfDZuG9wGiWZCNrVRnyvhrNCPbDbt/KJVDIxEmWb8dTq
         v2gKaknLIdDqsmfpeRDFIW/GOgHJBKqYXirK8gv9HkYbRux3slFsdtbI4cP8k8BTObnW
         bhxLv7Jvq8dXLuQ+rmxDesV1RUEECe+vWXJmQ8UAodIaCB8e9xAb7Fi+EZEtWLXX4xG8
         jfocLOdx6d8KZaVkCE+SnGcy8p3p+4JVbwlt5ejzmS3VjB2Ah25LgVrS3vHX/AW6LIDk
         IRTPYmLhyPD4qd+J9jTaLit2gIN8VqCbjbg3Xzvl2yTCgoRik2fHyb1BYqLWn5zyayVc
         Bdkw==
X-Gm-Message-State: AFq9FYKkZMj0Neu3o6aHawctCiNIdjdq7C1e7AIp4nNogRaD8DVJfqpQ
	uvWKOgbzSQRz/bSobYYZ8UrsNcQ2+PvYqFgP4HAeCicdcpZzfFIiuwqy
X-Gm-Gg: AYBFou08rLWFuJBVL2wVScbp8LlrpVYy0pPvRgjY50/nEMydZnBA3S579fYdnBS8mcR
	pTjAb0LvGC1jieI6o0/FeRlXc4Rs//l9whLOFv7KopKeR48/FLYb53BvOIevuZbrEvXzS0BgiRB
	VIItfXJqTMCwmFLxdFFk4pjK2hZjDZ5CqwpjASJRWm/64gIqgD4WE91JKBYDmTxO2Gi0UQKbBTt
	9d3rK8dwpVbN7as5OYZsw6HCpTf9OzxAnyrDpRcdMuNoU2NVxmEmdW+wsNuxSw+zebanNM+hE3V
	Gdy0TlIrkaUx4ooJ8bFVkn14OogIwi+63nTfwwB2bN4oFVUkRkBI+EheUpycOumQatio6EK/6fW
	2fQHZxHCdMjHEXi0c0CJD5htdaJ/vOVl2UJxQ2yBuXIZBMWQ50EyKAnPrkYp2HPuG+pOF/hm94Z
	YiVU6+2bUXyIb+Yq6QAXwPR5C4Z29U2cpudpDKfBw7eJ8JCKlN3iMzz0sMkulvMeObqHco62Z+2
	9hqmw6pGLsxOU/QB8bb58cEdy0PUOWYaQfhTk5R+ubU3pGyyoc99FcjjBh6TsqzGGyIfZci
X-Received: by 2002:a05:6102:4423:b0:7c3:f07c:f49c with SMTP id ada2fe7eead31-7ce5cc795admr4139341137.11.1793119456384;
        Tue, 27 Oct 2026 09:44:16 -0700 (PDT)
Received: from Notebook35 ([201.37.177.8])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3bc3816sm3023920137.3.2026.10.27.09.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:44:15 -0700 (PDT)
From: Diego Francio <dfrancio@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: btusb: Disable LL Privacy on Intel JfP (8087:0aaa)
Date: Tue, 27 Oct 2026 13:43:59 -0300
Message-ID: <20261027164359.460369-3-dfrancio@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027164359.460369-1-dfrancio@gmail.com>
References: <20261027164359.460369-1-dfrancio@gmail.com>
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

The Intel Jefferson Peak controller (Wireless-AC 9460/9462/9560,
USB 8087:0aaa) reports LL Privacy support, but since commit
e209e5ccc5ac ("Bluetooth: MGMT: Mark LL Privacy as stable") the kernel
uses it whenever the controller claims it. With BLE HID devices paired
(Logitech ERGO K860 and MX Vertical), the controller firmware then
crashes every few minutes:

  Bluetooth: hci0: Hardware error 0x0c
  Bluetooth: hci0: Exception info ...

The reset drops every connection, so keyboard and mouse stall and
reconnect over and over. Older firmware builds (2022.50 build 97 and a
2022.22 build) behave the same, so this is not a firmware version
regression.

Tested on an Intel 9462 (CNVi, Alder Lake PCH) laptop running mainline
builds: 6.1.190 and 6.12.70 are fine, while 6.17.12 and 7.0 crash every
3-15 minutes. With LL Privacy forced off in hci_sync.c on top of
Ubuntu 7.0.0-38, the same hardware and devices ran for 9 hours without
a single Hardware Error. With this patch applied on the same kernel, the
controller then ran for more than 4 hours with the keyboard and mouse
connected and no Hardware Error. The exact HCI command that crashes the
firmware was not identified.

Set HCI_QUIRK_BROKEN_LL_PRIVACY for this USB ID so the resolving list is
not used on it.

Fixes: e209e5ccc5ac ("Bluetooth: MGMT: Mark LL Privacy as stable")
Cc: stable@vger.kernel.org # 6.14+
Signed-off-by: Diego Francio <dfrancio@gmail.com>
---
 drivers/bluetooth/btusb_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 92a78a7..6a75341 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -70,6 +70,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
 #define BTUSB_ACTIONS_SEMI		BIT(27)
 #define BTUSB_BARROT			BIT(28)
+#define BTUSB_BROKEN_LL_PRIVACY		BIT(29)
 #define BTUSB_QUALCOMM			BIT(30)
 
 static const struct usb_device_id btusb_table[] = {
@@ -529,7 +530,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
-	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED },
+	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_BROKEN_LL_PRIVACY },
 
 	/* Other Intel Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
@@ -4608,6 +4610,9 @@ static int btusb_probe(struct usb_interface *intf,
 			btintel_set_flag(hdev, INTEL_BROKEN_SHUTDOWN_LED);
 	}
 
+	if (id->driver_info & BTUSB_BROKEN_LL_PRIVACY)
+		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_LL_PRIVACY);
+
 	if (id->driver_info & BTUSB_MARVELL)
 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
 
-- 
2.53.0


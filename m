Received: from mail.nercone.dev (x162-43-93-16.static.xvps.ne.jp [162.43.93.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FD36BCC2;
	Tue, 31 Mar 2026 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.43.93.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968477; cv=none; b=EddAa43K8mGZtoXfuPusDg9zfsk4FPIcrynu6V8+cyj2VDrGUcplVWiBtv3wVb6OKbDQV1StSU6wMWJnZIYu8VAs4NqSZOCEGD4HOSz7GqHdZlbbQxfKZi1WUGbtgDeuU2hRCwbKoZEgaaw8gv4HgzvryFGioVopFk0t6XG7uuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968477; c=relaxed/simple;
	bh=x5KIR7w+pB/x01TpAfB85sh62UT/87XsbdL5QKXULyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D98GGcu45g8TNGJdQT324GTyjgug/lsFKcKTMWDhVral50iVkxeLYDtNspfVd8Q04PrhjVlkFmV0KcUMAs2s19jsdtIljYEigBHD+NjbCU4YJ3hiGzZy9X9E0h3RL26s02KjBcce3Q422P9iytgIuBEgINtQePlJ9xL+ax06IJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nercone.dev; spf=fail smtp.mailfrom=nercone.dev; dkim=pass (2048-bit key) header.d=nercone.dev header.i=@nercone.dev header.b=jiww0uxd; arc=none smtp.client-ip=162.43.93.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nercone.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nercone.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nercone.dev header.i=@nercone.dev header.b="jiww0uxd"
Authentication-Results: mail.nercone.dev;
	auth=pass (plain)
From: Kamiyama Chiaki <nercone@nercone.dev>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kamiyama Chiaki <nercone@nercone.dev>
Subject: [PATCH] Bluetooth: btusb: Add VID 0489 & PID e11d for MediaTek MT7922
Date: Tue, 31 Mar 2026 23:45:32 +0900
Message-ID: <20260331144532.10697-1-nercone@nercone.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.nercone.dev (Haraka) with ESMTPSA id AA3628E8-A808-48CF-A662-43DBB6F9F8BC.1
	envelope-from <nercone@nercone.dev>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Tue, 31 Mar 2026 23:46:40 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nercone.dev;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=s20260328969; t=1774968401;
 bh=zGEb1XkPD3XzjlNz4FMYOr2+KNIv02UJC6+k4GP9sRA=;
 b=jiww0uxdoS/mvRWihHMN+TEULP/Pa4Zg5fYV57NysyfYfBWt4hoZF8df/C6nPYHQ6MFlE8luD
 vLoT4+IJ7xprNsIhYNa8g7OZZ/sniRUlA2gVGbq0o2HhX2xNr0CIGWFIRCKeCPn0ancatNJOybQ
 LPXvIUkulzxqLsy0Ec9EcxBQPrULOyskAo1eg6h/+WxufAOFu1qOPwZ4ctPFYch7ua+luegi0No
 00d7LEQvAyZ0K6Nzkqeh1JM0LYSL3oNzIVosD4Hs6dORv1MTlchrU/xs5mz219CjpUsOISJYrkH
 hlfKeXMcHgTVBR0EueZuQaSob04tHepf/5WZakvtlKow==

Add VID 0489 & PID e11d for MediaTek MT7922 USB Bluetooth chip.
Found in Dynabook GA/ZY (W6GAZY5RCL).

The USB device information is as follows:
  idVendor  = 0x0489 (Foxconn / Hon Hai)
  idProduct = 0xe11d
  Manufacturer: MediaTek Inc.
  Product: Wireless_Device

Signed-off-by: Kamiyama Chiaki <nercone@nercone.dev>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5c535f3ab..dc7df146a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -697,6 +697,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe102), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe11d), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe152), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe153), .driver_info = BTUSB_MEDIATEK |
-- 
2.53.0


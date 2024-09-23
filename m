Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A387B19408A;
	Mon, 23 Sep 2024 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082305; cv=none; b=V3nuTw1YaaUoSUVzZdvuj0uKStR7d8g0BEfk1IGhaj1MvjJAfFHik6AHAq46GjSOP3Q6TJlZNFsQNtFLlNuUzBboxKHmuUNdsJEz3hHETqgwE/JZCsWDL3VYxv+Ns9LO3SDr86CzwCDZhYV1AeBIQrVs1CeVnHuiFwhsVVTklKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082305; c=relaxed/simple;
	bh=k9xp4HT0KfmMEah7RTJzHOqd+Psq/6SKQaWSl+s9GHs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K/n1wVj5sZYRdiwzzIE52e3nQqHLwI2jx0NRriIqgitX8ZcNcoszkUNClcZdhKNDJWCbj2EVNxDz2k5vKg9IBEL6MnIcxKDnFZ0PS8Z+qsaIiD4OLe6WFWF+rWnEwbDmo+XkEmbTHeGqizfUUBTDjlfJr3Rwhe+Hcw5iU267r/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kWDnVxso; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kWDnVxso"
Received: from localhost.localdomain (unknown [222.129.37.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EF3E43FAD1;
	Mon, 23 Sep 2024 08:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727081752;
	bh=tFqbx20s3eVOndjh3nVrsPXEtwFY8lQ0VrYHujgxud4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kWDnVxso8qF6rJE89XoTgmCgElUCnv9OYMPFijvBAEHpUXWrONkbHogFsHSOEXG4O
	 0DYwjGZzawg2eNqui3AElJ1BuB91jbnMNOdSxpbF2m03Pi4ZjvIOYbFbEN88IPZTKu
	 cAMUH/1S4esij9bNXNluzTm/EVQsFtDzqiYssHHRK9rC1HZ/xEG9m/AHqt19CujUMP
	 0jkcNE71STcPmMSGIfqMPIs+BqpA/PT83Kh0JuNTDnCPUOpuqKs+/2Ev/dBfQUwZPy
	 HaGOWUqMoBCOiVJseZLfXyU29jWvJIovS6HHy2u90wb3qHKSkjmdA8kCuU0vbWJ/+L
	 DKKxNU++ouqKA==
From: Aaron Ma <aaron.ma@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	aaron.ma@canonical.com
Subject: [PATCH] Bluetooth: btusb: add Foxconn 0xe0fc for Qualcomm WCN785x
Date: Mon, 23 Sep 2024 16:55:19 +0800
Message-ID: <20240923085519.19074-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmwares are already in upstream.

kernel boot log as following:
Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00190200.bin
Bluetooth: hci0: QCA: patch rome 0x190200 build 0x5656, firmware rome 0x190200 build 0x43fb
Bluetooth: hci0: using NVM file: qca/nvm_usb_00190200.bin

Paired BT headphone, output is good.

T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e0fc Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:  If#= 1 Alt= 7 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  65 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  65 Ivl=1ms

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6c9c761d5b93..9a96a8e38f3e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -371,6 +371,8 @@ static const struct usb_device_id quirks_table[] = {
 	/* QCA WCN785x chipset */
 	{ USB_DEVICE(0x0cf3, 0xe700), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe0fc), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
2.43.0


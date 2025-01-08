Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE5719EEBF
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736366527; cv=none; b=U75LY2dWlTmGv415NJMCdN8LzTt+17nXT3gG+tHC/15h3rnLoyhqM7SfcHvyXaDptmwwwQy4H/1rgqcfHUYcleTfIZBF2KaRqAooRJSH09NkzCn2MyhXlrVWvtiP5tKwbtXSMD+ASB73IJXu3Ehy/nDwU9Kcg/GnxON/R1jax3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736366527; c=relaxed/simple;
	bh=lyuJ/wBVcSKAQHANq1ER/9y4U4K42lnnr4YEIaOZ6ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sbWRji1uQpL5WObiVm7DnyTcEHNsOhUV4f1mhbpd73gim5XwcVlR4wqKsFuUFFiRUh+44r6PbjNFMy18W+8lBk6rQGqjVJsTY1BBWGNTwtg5jpe+ocmWWoxZ5HiF5st4O5VBg5HDJXIMPhcExi9XX2VR9kjDWOEyHHyfKDQAVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=system76.com; spf=pass smtp.mailfrom=system76.com; dkim=pass (2048-bit key) header.d=system76.com header.i=@system76.com header.b=eFmZlqWI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPu5hRcq; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=system76.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=system76.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=system76.com header.i=@system76.com header.b="eFmZlqWI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPu5hRcq"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E735B1380232;
	Wed,  8 Jan 2025 15:02:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jan 2025 15:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=system76.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1736366523; x=1736452923; bh=cdVxuJ6uK7fHdFCi9bAXo
	NXpbSCWEXY634jEVzbX8hQ=; b=eFmZlqWIQhOqr143jKgeiRD4ZUlwXYhUz7b1/
	TkLhNo3kF7tkCSgQGtNpggC56QN8sHJUqCYhjohfpycbeDOixoTbRPc9CzKjTkin
	yzoDf2vhBV/wS9z5UqKrmLzKFjpJwi0qgSCyJn2MXifuOOJTE5a/Q29GyMgHfTwN
	Mw6JMCiEf5SFQaT2psSLVCoxrtFmnsIi5dxTLrphImG/sMbStcjleHmwLGgi1azn
	B9UXSGD9QPWeCtmrnuKxSlZ70q9cUSbelgcI9qiJYwGf5D+DbUkv1DwcKol6ZGpp
	h2E/9quNv9Ss6qIVyNM+jJylyv7iiTCMDGiSNoKqpHvXKamzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736366523; x=1736452923; bh=cdVxuJ6uK7fHdFCi9bAXoNXpbSCWEXY634j
	EVzbX8hQ=; b=FPu5hRcqzdQDFRC5H/2NRGAmtrCyVWE0RHcXD3XywDimnQGJcQZ
	2mnBAo3fk4ud9+iKd09NENDjd3g0XVeldpzqdxYPbf4eklFSE/IMyPcPAlOhm5Ep
	erJNaXSSdNsb5Be8Z3UmIC8nspm/+855zQgilGFEyR4mvmLoMgg2BOg6ijzjn/B3
	Xv45fCpgYX/AUQ9ZZZ4M/JLoKQwB6l4HOn+2WzpQ9jufhoi9r558PnavjBz2l/Ax
	TvpmiGOKk9UBolBibah1hYfASNGOglOLpK5r+UHkBHfArmWigJ6267WAJBkFUciB
	LjkioRQ41OfRHNp08SkzdZ7NdzzNerGDG3Q==
X-ME-Sender: <xms:u9l-Z98mrLR5l1pZD3Y-kUTDxiYjOoNSTtCs30t9tlsj1XrCH4jvQQ>
    <xme:u9l-ZxsDwxfGPj-A0UxjAbWAQHo5X8ib_sqyzRI8njFZcvEiomk-U9hy0ZkPf6rQW
    tjBxyVGmPVNv_kc_A>
X-ME-Received: <xmr:u9l-Z7DsFpHYjxWtw7LrwSbac_hbz1kvPpx_0aeprA9RqwxmuIiRdNmqa0sFFDzuS8ADdYUORvshNDb7vHPgZpE0SWEG0Ixq3M5B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefvihhmucevrhgrfihfohhrugcuoehttghrrgiffhhorhgusehshihsthgvmh
    ejiedrtghomheqnecuggftrfgrthhtvghrnhepkefgteefvdeivdfhffdtfffgieffhfet
    geduudekieefueeutdelfedtveeuheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepthgtrhgrfihfohhrugesshihshhtvghmjeeirdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlih
    hnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphhrohguuhgtthguvghvsehshihsthgvmhejiedrtghomhdprhgtphhtthhopehgrg
    hrrhgvthhtsehshihsthgvmhejiedrtghomhdprhgtphhtthhopehttghrrgiffhhorhgu
    sehshihsthgvmhejiedrtghomh
X-ME-Proxy: <xmx:u9l-ZxdTjHaiA9YFgIAcoLC8kbSk72xKA9JmpkzR6WM6_vw9qMOXLg>
    <xmx:u9l-ZyPP3VMxcIUUuagzBzeXRY0Bw2AZqzT5K52vc4iwvu9aaPPf-w>
    <xmx:u9l-ZzlAtcw7oSrfRmVDKXuD6psRwZofIg7b8AFiJXAkLJBAFYds6w>
    <xmx:u9l-Z8sfCRaKtZEFCZnC0FTBwnGroQu8jpdkIGg81meFiW7mwI8hYA>
    <xmx:u9l-ZxeKLwkV8-Lc2dfrfnpoNtjDNj3nc2aL4Vph2JBIzq8_nT4q5yUk>
Feedback-ID: i1761444e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 15:02:03 -0500 (EST)
From: Tim Crawford <tcrawford@system76.com>
To: linux-bluetooth@vger.kernel.org
Cc: productdev@system76.com,
	Garrett Wilke <garrett@system76.com>,
	Tim Crawford <tcrawford@system76.com>
Subject: [PATCH] Bluetooth: btusb: Add MT7921e device 13d3:3576
Date: Wed,  8 Jan 2025 13:01:40 -0700
Message-ID: <20250108200140.29719-1-tcrawford@system76.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Garrett Wilke <garrett@system76.com>

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=03 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3576 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
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
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Signed-off-by: Garrett Wilke <garrett@system76.com>
Signed-off-by: Tim Crawford <tcrawford@system76.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ab0506148e84..30ba45a9a75f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -602,6 +602,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3567), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3576), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3578), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3583), .driver_info = BTUSB_MEDIATEK |
-- 
2.47.1


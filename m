Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889B202C25
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360555; cv=none; b=UNpH2qXtOSeHtcGlL9yIR7rsHZZRJWY24GYo1s3/bz/WKyro958BtP0D9mvAlve1Kwyi5bR4Jn6JQYqvzycXqgaO5kN8R7tNMqsjt5wyAk85wyc/yK+ywiim0XeVLlz39gvf8SZR+EAmvbjiftWFf9vZLi6oKGlbR5+QWAcHL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360555; c=relaxed/simple;
	bh=U43nYkoYzxGW16Uvl38MLlObuRqlLAKKwJ2bIxTnQfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gH0/9D3kxYN6PM+546l05qL4KXWZee8pR2VA0anqK3A1dQ4n3HrPScM2X4DWwSzq/xxN1O3yTxlhjs7KSt6HoDKaQ8QTiME2tPzfP0SnmDF8YYh4rmu5pX2PLECNh+rpE7fx1zD/FQ57iBo46qezum6uSZK+P7nWbcbZG5A3ZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=system76.com; spf=pass smtp.mailfrom=system76.com; dkim=pass (2048-bit key) header.d=system76.com header.i=@system76.com header.b=PSYpnpel; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8o+Hc37; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=system76.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=system76.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=system76.com header.i=@system76.com header.b="PSYpnpel";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8o+Hc37"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E44F114022C;
	Wed,  8 Jan 2025 13:22:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 08 Jan 2025 13:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=system76.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1736360551; x=1736446951; bh=34yVTUD09fOA6EMumodV+
	EhLqbgaW/KiUy02JoKDmB0=; b=PSYpnpelLn1PXpMjEkJnaqEKX84zb4fgyFybT
	PDhAM2Czw64cQoADX6tjPX0Be76fNwtRHVWxfLC4R2WVQVtQcHhFPdnXbgydvpLy
	J3WE/IytbUD9qRDG0yabOfB/9Dsr+TzU18fLNPaQbq3M3/GVJGMsd8+cW0c37dmw
	v8dUMBNlAAnAtSFu0+fZMskObwhPDQbtwM0uqj8bRXp0oPcueo/wFf34yAcRA5Wr
	9UsY8GNmj3jylhk67oRLLSY3M6IBtNfH9echWP9hZhojdtO7BTpX2UdVUjiOglEt
	31qHNK52rPGMGIlQzQ7OZjT5ZWCYGQZQhBQkmttKYPYO9KeVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736360551; x=1736446951; bh=34yVTUD09fOA6EMumodV+EhLqbgaW/KiUy0
	2JoKDmB0=; b=e8o+Hc37sp8ghq66Q6IGpwsQ9N0+oSLlomjEoU4P71akfxqSZ2w
	VlWgF+yfi88r7y9610fs4KNf2j27ctNjGA+3T9LAEH+ZbBVmiZoWoyd7ORlINnkW
	Mt0a1IHRS41axBlGQAwoPQmDRqjE4phhCuDX+EvWSTcWLuvK/GAl5vPq944pRi0w
	lzJtDXmQhMzuGoznAd4+IgiZ+7if7KLz2EuPUbkjf3mLzlpxsT9uIrBBViaIsh8i
	t7gN4D39IHMTcjHkYC8OpLsT7jGWacnC4g5QYZJfFGLa3fB+/tRa70PFFrim6r7T
	Hyo6JJcR66132WEJUYK849y/nGteesaqxdA==
X-ME-Sender: <xms:Z8J-ZzPPhJoWe7O3EO8anPdg_4EYpRxK1mRxQSw7VclQng1xEkzLoA>
    <xme:Z8J-Z98mrqGqFHUIDtMPKbnUQE99C1_a7RVXgvURJ75iCa5xteZmwXdS_fZ8ENjQW
    _Nv6bN5XGjmyCwxVA>
X-ME-Received: <xmr:Z8J-ZyQ_B316M7HNvtt0dp23vX10bclHmihxJdd1VailOLbcpH09h5h9O3PxO_cBDqE75eBgdYKVdA08Rjq8_qrSvHcEObmlMClQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgudduudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Z8J-Z3um43CvwNrWHI_hbF8uvmSRDKXyOntyTwORgc99uN71nLrl0Q>
    <xmx:Z8J-Z7coKPgV57kTiE_3vuHPFL2XawVEAN7OhxSxlfbUPr2tYgg0YA>
    <xmx:Z8J-Zz1cSHmkeQOfxODjXmtDXBVrR5LYHjHPgDdUeHv6sly5WDF3kA>
    <xmx:Z8J-Z3-lhwdhbYGW0MsQsuzEPeFJbQzhJIBQPJSk28ZXboR4Hiix-g>
    <xmx:Z8J-Z9sm-5j0TekC0X9WvFlT5rmigPUgckG02z4xjuTYEG0x6I6fE_Cy>
Feedback-ID: i1761444e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 13:22:30 -0500 (EST)
From: Tim Crawford <tcrawford@system76.com>
To: linux-bluetooth@vger.kernel.org
Cc: productdev@system76.com,
	Garrett Wilke <garrett@system76.com>,
	Tim Crawford <tcrawford@system76.com>
Subject: [PATCH v2] Bluetooth: btusb: Add RTL8851BE device 13d3:3600
Date: Wed,  8 Jan 2025 11:22:13 -0700
Message-ID: <20250108182213.23326-1-tcrawford@system76.com>
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

T:  Bus=07 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3600 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Signed-off-by: Garrett Wilke <garrett@system76.com>
Signed-off-by: Tim Crawford <tcrawford@system76.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ab0506148e84..71caf297aa70 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -483,6 +483,9 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3549), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Realtek 8851BE Bluetooth devices */
+	{ USB_DEVICE(0x13d3, 0x3600), .driver_info = BTUSB_REALTEK },
+
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.47.1


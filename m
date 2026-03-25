Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3733A3800;
	Wed, 25 Mar 2026 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774481438; cv=none; b=Kc8FGx7jyNrWKoNTNnAbkugByx+AUnCVN8tme0TYxKdN2Rk0DQl3CaVG0PyRrd0TYtbPvO7bUaWhMvYQHhDCYEwEP95GXDM9MLwIhtv9eAZ3iP758zYKzzH7VZxf/+TcUdCL5yuGy/HgZvB+3zRspEjGok6KHfVluidZ43QWv7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774481438; c=relaxed/simple;
	bh=lWryKhkw4iLj5N6UVE9I7cEeZDeTwxGqMUn3iSX25wU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=eyy7ll021f362MVm+WOyM7eh8QVevebj9dINS4Gd0BGy+CXmhiPs+auSw2bD+iqkWkp3UBXavc4boI9CkqnZoZS5lhFPERavvaag4g0H28mACsfcYM4scImY7e3gwV+J0syu+8CdJ8R0B5f4/EaWT6fMNwZ8iL6mKDWlkclsSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=Gh4PRkMe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uNrbFs84; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="Gh4PRkMe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uNrbFs84"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C08561D00192;
	Wed, 25 Mar 2026 19:30:35 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 19:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774481435;
	 x=1774567835; bh=XVHd+2ZauyHwNk7khM0QiFJuTBAS85ERsapbSIu9KaY=; b=
	Gh4PRkMeRmGqB8vRh25A4vrK7xNGbJI8HQY19+K0MteiBUZOuXt6mjpRqaX81ABT
	78TefQVaDlkqN4VODzfLjJN9SiULO7a7PU+sw3jm3nmPjS5gz+jj8sVYwzooezf/
	IOF2JjavV7tmXt6ggj2LM8qYMT55Tu5zbueI6mZk5qcVGiuJxj2+MfeVjBPH9Q4t
	6h8+H29RJ/Of930q3vSJov4H6C6bPiNnZoOmzS7oPNEnqCmxhH7uozTNOBnaIS++
	pKwS6auWZUI5xjNCpR64hjLuAcpCpSb9CWNJ4EbKPLH9t6RxrlrsEdS3SBzf9sD8
	4Gqbtv0OG9JKPRkHPvP3Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774481435; x=
	1774567835; bh=XVHd+2ZauyHwNk7khM0QiFJuTBAS85ERsapbSIu9KaY=; b=u
	NrbFs845hb7H7qVUSDLSf5NDhyyr5eVlhQOs4WI5I3UyaoRuuC1BNo9Q81cqNakZ
	yweAAe3LAdbFd1CDa7rAGpnNGpsPwoCuS/xH7pAQF2OKtJfSo8dwhonL1EJaIDL1
	Q5Uwag4A0bfo9KsHx57xL6S9CubOYan/cqXwCFF0ft/vayaOLUFQiEBtdyam8GM2
	2i7vedE0d5RdS1iVbg1kz0GRmL1h8d/sDnexC8ijPj+QeYyebC08dDlqu6myHC9i
	L/9UYJehf3ckTHXQgWYf8Upjod1UjDR9CK24pbymwx4qiOdEEr3R7oxdWc6eJF1i
	PongdWTSFSll3PCXYF7Sw==
X-ME-Sender: <xms:G3DEabqdCnBvjRaPeeimrnb2KkMDBI-UsEdbRdrKWGf5dGOp7L1ksA>
    <xme:G3DEaQcYQc01ugEC7EdjWrQUiz1kQ3rUqKrzm3cS70-gZvDZCBnZMhnnAybjRaBd0
    ho5PF-wN5m7rLr0LOpIsl98z7tNjAVv9QldP2oPaLqf1_n6dOGn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnheptd
    efvdefkedutdejfffhheehfffgfedthfeuieeiteetgedttdfhveefledvkeejnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhm
    vgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    grnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgr
    rdgtohhmpdhrtghpthhtoheplhhusghnihhnrdhivhgrnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehm
    rghtthhhihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrtggvlh
    eshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhn
    vghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqmhgvughirghtvghksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    ohepjhhnvghtthhosehmihhnvghirhhordhiohdprhgtphhtthhopehlihhnuhigqdgslh
    huvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:G3DEaT1IA4JbGCeaOpFiXnEbcQnS7p-xp4z1BktCK_0DR9GNsptc_g>
    <xmx:G3DEaQUWAS-CI8dYeKdw4kgKgc5NToNz2kGD5B8auClR4gRpZEtNug>
    <xmx:G3DEadMhKZcQL7yyzJhDSPEGjiexl2tvAuXmPbGN14frpcAk7syMUQ>
    <xmx:G3DEab3LT3DxO-0EdC6b8KEUMdN4ws9S83ktk6UIKZv0Yma3cX0oIQ>
    <xmx:G3DEaVHkR2ZafVQs33XygKrWtCxje1PVho5ZggLgl2ls2rBBOQujFCSz>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7463B1EA006C; Wed, 25 Mar 2026 19:30:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 17:30:25 -0600
Subject: [PATCH v2 8/8] Bluetooth: btusb: Add MT7927 ID for ASUS X870E /
 ProArt X870E-Creator
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-mt7927-bt-support-v2-8-b892a3252880@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>,
 Ivan Lubnin <lubnin.ivan@gmail.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2450; i=floss@jetm.me;
 h=from:subject:message-id; bh=lWryKhkw4iLj5N6UVE9I7cEeZDeTwxGqMUn3iSX25wU=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxHAKtflmLkRqGjxW+McWt6zvAtmhrwiIy9u9O
 VlvN0XKw+iJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRwCgAKCRC17sMLqGd3
 H/dhC/0RkKcvlwts+4nHpJSslpidynecXn+0J/dyn8euUvdxWGfaSBNW/9UbTLnyDxqsuQU26xo
 2531Yct8j4031UfwHPxElsZhTfe7zTPoMvX+pxpz+fQFr6pkReByg6zUyyZE0iaFetAVBMNT4M1
 G7iNxhGDj3hEqia8HbbwiOjG2J6bvHqU868MbivFwrFuQ/+flhKoMVlV1TGkZGS/eEqefvlqtTI
 oP33pysPxO/vc+7cZvE0LcaUlQZFzKq6TVfEGVQJKOhgVH3Cq5sgr0EMorw+FvlxGUFVjWXDxui
 lyW1/i1pefIk5Vg1dqa1D7PxEQmiwgqqdRDe74EYeUB+Tyonxwq1GwKb+TIl+2eGwxDHId1M069
 vZNpUXLJaig++Mwm3CHtj8iadePMIrYz+cNi97/+oLzHyYbds5+SH5JYYKZMiLzN5dbGAPQGf9P
 FzvxI0ithXFYJbCITeAp28pzoK77WOLhgEz38vIbrtOQsKWy14ashSTHp/ALHX89QalwM=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me>
References: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me>

Add USB device ID 13d3:3588 (IMC Networks/Azurewave) for the MediaTek
MT7927 (Filogic 380) Bluetooth interface found on the ASUS ROG STRIX
X870E-E GAMING WIFI and ASUS ProArt X870E-Creator WiFi motherboards.

Note: boards with this USB ID report only one ISO alternate setting
(alt 0), causing a non-fatal "setting interface failed (22)" during
setup. Bluetooth still functions but initialization takes ~19 seconds
instead of ~2.6 seconds.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3588 Rev= 1.00
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
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221096
Link: https://github.com/openwrt/mt76/issues/927
Signed-off-by: Javier Tia <floss@jetm.me>
Tested-by: Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>
Tested-by: Ivan Lubnin <lubnin.ivan@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 55a000540439..45ef0d008bce 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -761,6 +761,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe116), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3588), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14e), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14f), .driver_info = BTUSB_MEDIATEK |

-- 
2.53.0


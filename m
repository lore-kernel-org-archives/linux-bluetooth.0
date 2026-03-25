Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D039DBE6;
	Wed, 25 Mar 2026 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774481429; cv=none; b=hFs31GgJKatr2X06vhF4S/OeQCqN4+dyfyzDCHxJgsDRI29Mvyyg0lgPGeiYicG2RgFI67hPh+BBOmnnEmyIq3SeP9xt7eGBrzmQgLNGNUSppKrr4UbN6MGeOnecFYuQpc/zG5g/N4fCuckVuUnrWcVJwe5Lk98r0c7/U2978n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774481429; c=relaxed/simple;
	bh=9VC/j/XdBMGnjdaMjoJsd1+eJl2LQOX2dwL92kQTdgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=sHLK6FbcrI5PMP4HhL2UyJB2rB3WMPyMPTTVq0OwfaODy+okdKgRCDfEd19dPQXsiNZIb/2X+1zgmQzMKKfGiG2s6maIXek1orl2gKRvMfzoC416A5T/aRTTaM+xmi3PTfyp2VnPKgGKEf5aCiQUPYN/wOMtAhmTRU+LgELWx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=je4EL6eE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uokLqQIe; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="je4EL6eE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uokLqQIe"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 305067A019D;
	Wed, 25 Mar 2026 19:30:27 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 19:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774481427;
	 x=1774567827; bh=bpy+NjFmQ1UZzVo0QwIuf1cqhqfKorIEk2o2QMNh51g=; b=
	je4EL6eEIPJfZu3Incoye9CBSHyIKGfWv94O0LRtsh3A0mn6oFgKormWARs0mCMy
	2RpfPjz3kzMCfctWRNjE+7y1/wzFHI25VZBtrWQopNRB/tdKGr7jjfocVHPwpAjL
	iYiOVA2+QxzjCl4r30Q0Ux99CLhyX+sKQkFttrtkS5apTBO59VnHY8B+mn1Jywwc
	TXM4iFLA+iD6Bq5DyCeFQtaF7H9zq6d5rd2Nqh7hGI6h+kECskSKQ+N+m15cwIM4
	aEcvGDGa0AppIiT2Ekcw7iPvsNqI38yxQju+ycYUF1G2OxeZuBL/0jxXhOf2m1W5
	i5wdvLNs/tZQviGb1xVuww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774481427; x=
	1774567827; bh=bpy+NjFmQ1UZzVo0QwIuf1cqhqfKorIEk2o2QMNh51g=; b=u
	okLqQIekFiHO6jmGEajLuLD268SDHk4WEGSoqdCZ32sqnKopMfrw4u0dNm/QEpoG
	MJ1WChTjZ70w0ik8WbRi/5t7t25M8f1v+Q/K0ZoxATAL5tvEvv+KvBR9yumRpB2Z
	JM3EjI7NpZCyeLC9M6T9CKSb5qS5oRxvaWMzqmb+2/FzenJC8s2p6FMFKNXS4nWW
	PKwfOaqKsnd+iaIUudY7zMEQgCi/OBnVX4xNODgXQBMqgtWdssdPAta6zKNm/kdX
	IrSlEcUeIVVzOTHvboOP+v/nd7mLowTN7woBg0y9Y66DAIEojNIkkro+nqmFxhlx
	scgdybJVk0ASvC6tEiVUA==
X-ME-Sender: <xms:EnDEafecDdmgqXXIdU-fRBu27k3I4m-RuNWgTwdZuxVGk6uewYO7Nw>
    <xme:EnDEaQCTFGePBHD0lX2MaMsM5EM1UmLKVCwNgjdz0pcEnW0V-4-LmFFm3rAp8CF8f
    9YAPKDCfAYrk9UY94WdvzusnOKpAWWqTOhoe89GfCIq6VcfxtZzIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnheptd
    efvdefkedutdejfffhheehfffgfedthfeuieeiteetgedttdfhveefledvkeejnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhm
    vgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdr
    tghomhdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtph
    htthhopehmrghtthhhihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtthhopehm
    vghlihhnkhhovddttdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhgtvghlse
    hhohhlthhmrghnnhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgv
    lheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hmvgguihgrthgvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    pehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EnDEaa8PZ-lA-J7Evg4l5AVoz8W7cs8qduR7j_FUIjoWRqbhrT3GhA>
    <xmx:EnDEadzowWAMPxS9tfL9AhXOxOIaBkPP8myy-w0ZU0MCRotm8_X4Sg>
    <xmx:EnDEaaqlszjrS3lnu9kHVjhbMLLx_8DufgyBE9-VTxT8l6zf8F2_ZA>
    <xmx:EnDEaeq8Dol37FfaZx__c3gxy-G0LUV5HtCe3rTdHWZJBBl4zbzFsg>
    <xmx:E3DEaflDYk7Nau92M_t8k6gMBRbzMvhfYY3hh09wy8m_7bz6105lpKNW>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D86981EA006B; Wed, 25 Mar 2026 19:30:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 17:30:21 -0600
Subject: [PATCH v2 4/8] Bluetooth: btusb: Add MT7927 ID for Lenovo Legion
 Pro 7 16ARX9
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-mt7927-bt-support-v2-4-b892a3252880@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Llewellyn Curran <melinko2003@gmail.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=floss@jetm.me;
 h=from:subject:message-id; bh=9VC/j/XdBMGnjdaMjoJsd1+eJl2LQOX2dwL92kQTdgA=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxHAKwNSlJ0BpVh+o2CPSWFKji3jaAkqGgnmZG
 2XfPr17PMeJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRwCgAKCRC17sMLqGd3
 H2T3C/40ur8ArNb5drsWMovbikhiRHty1V9gs6AX3Dv5AeVdHD72Uufc9yQDsgKJadvuoEJjrmt
 g3g5XK0ssWkgP5KkWpfKaQTA/7SFb2fVGWQ7Q26zYDkjm6a3KtWFo7ih44zdffAAzOO2O3iZlZN
 uGqSpeMl3agBNgSW7Ra1P+JR6ekh+bdly2Wzdgn+pYdGmQ2ERv8b1kMWowwmjy6RH1dBhxEormb
 dYpg3ErIAadrkY5spoQLyxDSNiumz08fbTXUTP/WQlNWUzUgKUJG+XHs378TXuElHqFqrIaNTBo
 zKqNu5d3QeL2NuOeAFsg09zSDjK0GZo5FHBCdnYd3ZdS+rd7vDXq17rYWxZpMy6JuSi/xq5nKyA
 wSbDda8iSETSCWJ5fAPT8OJCvIHq5vrnYVMw8HreTQPo3snKIRBNTCAS05e3oxwznrmGThxwrV6
 agd0fMjqZp0v5tphSBV0doJ8qPb/gVTPslNlpye/TLlW9VrvuJfWBVUGTgIeX3U2VnQV4=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me>
References: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me>

Add USB device ID 0489:e0fa (Foxconn/Hon Hai) for the MediaTek MT7927
(Filogic 380) Bluetooth interface found on the Lenovo Legion Pro 7
16ARX9 laptop.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=04 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e0fa Rev= 1.00
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
...
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221096
Link: https://github.com/openwrt/mt76/issues/927
Signed-off-by: Javier Tia <floss@jetm.me>
Tested-by: Llewellyn Curran <melinko2003@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 58309af0f7a2..2c9ca3d6016b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -753,6 +753,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe13a), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe0fa), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14e), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14f), .driver_info = BTUSB_MEDIATEK |

-- 
2.53.0


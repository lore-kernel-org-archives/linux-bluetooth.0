Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4673446CA;
	Thu, 26 Mar 2026 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563211; cv=none; b=dIN1yFgk88eOE7XBmh46Md2zsKmsK1D0gKwnulBnhhbIuISNYm4qlRhZ8t0aSGD0KBdpznl4TK8RLTIx9vyC+8X/NOfGzOYhdPow3p0ydSnfdhUdfDcsLu1rwKaTqNk5yglwGJFyQJNUTWHedlMNDac1CK16/vlaHty68+ynnis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563211; c=relaxed/simple;
	bh=0X9iYzgDtL2noTXAFbHuUBjE+Gu6Hwn5WtC2t2VD+ZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=W2m5KKWYpBYCBSuB++j2vfDnR9K06u9K++2CF0sZNXlyeXWTElF+piGvoEoXyoHo3uUQqTIMIMnUw86blzg4Ecur82qIvTumMCaWsGE12hRelbSaSP/raNMbR6vC681b3Sg36V/4cR69RYHr1ZQRxYWayuu68RMhoFLGkRDLpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=MjPqzKsi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O3f2jUIi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="MjPqzKsi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O3f2jUIi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7DC2FEC0211;
	Thu, 26 Mar 2026 18:13:20 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 18:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774563200;
	 x=1774649600; bh=OKYvgQ1t1lSRkNHRJOJY5btuo/K6VYFBYLipl68nHhQ=; b=
	MjPqzKsiFfeojxT9XfyjZ9BI2j1Zg1cIRxgJv4T/OUY413O+yE62kD4S2WtdA4ii
	N6nRJEHgT3Rt3YxRUy0pzca2usdicwsSRODCvmEl4ItCOoN19dJRKPRKzolNZNPf
	rMHI+lC9KXhkduV0Uxtqj/EoTUcY+pcCWHDjHNsif1sIIKfhSuyFrujLoev2GIVh
	k5hnPb2YYW3RI+3lDTYMwlGL93ali7nTSMyJEz87g4WHv1N9eZlf2Yoh/zq7hVYF
	9N9BBK8vy2drk+r5lLqJt/daJCVP9//LFw+wSo+lc/8xf2hIVBcCi7VHINeAq0U7
	aswlx9h9YyTJvi7uCRak1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774563200; x=
	1774649600; bh=OKYvgQ1t1lSRkNHRJOJY5btuo/K6VYFBYLipl68nHhQ=; b=O
	3f2jUIinHKzj3lLYQKrUmloTfiICSvHHRlw/TunRrSmjzM0FafhTLZofsV8E/Omr
	gAYpaQTh+FZzDRucmBlhXuVD8XG2X6ISvrtYK5riCJl1m05E8RqDx/SG6YKYZ9+x
	XwOnzmPC7LlvrisA/EsWamE89w6sq/Qo5w+/7JrYop0/LNmZxb0n8yXtQ4v3p5K5
	cnQ3pIqUv8pOiNUZbUnGUZm3JeY8hvqswzK7Zt5V/4t9GYShsSk29NUasEsCvrXf
	ddRT7jGbn5KvBJVG4vT7UiMjG9Dc/cJhfkFYOb0jR1VrEXE9rCIA8mQa/x9+GU3s
	69f6G39bkbsACVDu4dlGg==
X-ME-Sender: <xms:gK_FaS18IuvunJCQXrf5vuBCeFXXKNxyNHo-I-DW_tpSqW2qTzZRGg>
    <xme:gK_Faf4gSnTXhljtEWDMbhiVSLjmcZEntGcUL35vQvrE75TWLtxswL0W6UFvtkMZ2
    _Hmx9g8nySwu6S1qjFeOTSGVYFF_z0ym-W7R2shuFIB9T2lQ2lLru0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnheptd
    efvdefkedutdejfffhheehfffgfedthfeuieeiteetgedttdfhveefledvkeejnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhm
    vgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdr
    tghomhdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtph
    htthhopehmrghtthhhihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtthhopehm
    rghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtohepthhisghosehhuhhmvg
    hurhhlihgsrhgvrdhfrhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlhes
    lhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhmvg
    guihgrthgvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gK_FadqkODAaTAQxEaxXxTO-ofGTrwKxmszwSfssf22nipW1fP6Tbw>
    <xmx:gK_FadDkT80Z21pylc2hQpiRkeO8odzHYR3HxxhfylY3e7o6QD1oeg>
    <xmx:gK_FaRjEWVuuvUn5tedCHrI1OYGdOmctH1eeltGHBbNUinW5usfNJA>
    <xmx:gK_FaTZ3RrVwJq4t04-ErkI7NKHA1NmB3okYCJt86DFLJrynSvTJKw>
    <xmx:gK_FadU3h-V9Dm3aJ49hx3oKWsF_pR5SdkJhiXyxhG4p_q58Zf0vApAj>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 586E81EA006B; Thu, 26 Mar 2026 18:13:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 16:13:10 -0600
Subject: [PATCH v3 7/8] Bluetooth: btusb: Add MT7927 ID for TP-Link Archer
 TBE550E
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-mt7927-bt-support-v3-7-fa7ebd424323@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Thibaut FRANCOIS <tibo@humeurlibre.fr>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=floss@jetm.me;
 h=from:subject:message-id; bh=0X9iYzgDtL2noTXAFbHuUBjE+Gu6Hwn5WtC2t2VD+ZU=;
 b=kA0DAAoBte7DC6hndx8ByyZiAGnFr2+iHqNKpXIigHyqWstaPJ5vRo/H8d9K0ur99uohI2kNk
 okBswQAAQoAHRYhBJsTsgvPDt4jRUqTybXuwwuoZ3cfBQJpxa9vAAoJELXuwwuoZ3cfITYL/ibr
 htZeOHXNCyCdpEZRyY5bKoau9CJv6WQYkQ7xrW7URUIdf3bgCf+PAHRNwY+/Zhg4ZgCZfkyB/+j
 DKWodNbVhpABGf7J82kZqTPAM8ExVkdT7mRFnjMK5UHkDcWVd6VNlEuPFNSojlF47i09H2hliiU
 xKwLZGuaCBa47v20wpWH8p74LjnNTDXqE/YWFM32NQYftVqWv1zFqvDgYiqX9wvIWKe1WkAIw+z
 cRohdi1xWXDmmWCx8ekjpKo+C4Q2Hq6brRzqNbOt2CYFAmNVBI0M1hY6rv0u4qfGbt6OwZhLbte
 u2dvahMLdzENamkT4dxkXEMDFKh0FwcXKXxJC0ybrPoz9VYWJodNmlSMZqMdW0HfEOoEu/iK8do
 C6+xlhWJbzzr5qnKRxZYj3ycxSTUNUu+IUfUxKvtsDkJpSZUCowqHYdSvVrPZak0emAr7vc3YPP
 v/SqfRmXvix6ud1c/lZddpHt6oot+e5FGbfh8053fHOHT0151w4qdjtmazyw==
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>
References: <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>

Add USB device ID 0489:e116 (Foxconn/Hon Hai) for the MediaTek MT7927
(Filogic 380) Bluetooth interface found on the TP-Link Archer TBE550E
PCIe adapter.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=04 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e116 Rev= 1.00
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
Tested-by: Thibaut FRANCOIS <tibo@humeurlibre.fr>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 96882e9b831c..55a000540439 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -759,6 +759,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe110), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe116), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14e), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14f), .driver_info = BTUSB_MEDIATEK |

-- 
2.53.0


Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396D3A4F48;
	Mon, 30 Mar 2026 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903181; cv=none; b=jem9ct5u7k732i0aaEm57yS1d6OoMqUM1dfsbVMFlMfRaxJJiLx2TvcOoFvSAyx/JY5EP0wMBICWaqErPbQyYunuPp2DEpSEskkGmqrTm9aSn8mYIeoHxy9hs6qYg7GtsLwzRu5QDFGkBppegk0Jrd4WxxwW/Z8XKsa5Dy/Vnqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903181; c=relaxed/simple;
	bh=oX9RcQEWF2VJoE6RgvKmZHprs09/2hbUA9uGu4FFREs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=I2aHRMXPvNhYamI46fIcTpJ/pyifDywtEFH4m/LXodqfsmD3QTvDgsdeGjAqYrMpMz/DLY1o+FrulNUL3gMZdOnj7IZOg+eYv4SvIi75YlYQK54CFQnp+LwQv9n8UGvlh24pYZ3k7hsykPCzRCzlsglmUdIVkjRGaHeI1Y3iRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=p9+JGIo8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1rR+Bfig; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="p9+JGIo8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1rR+Bfig"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 40D0AEC0263;
	Mon, 30 Mar 2026 16:39:36 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 16:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774903176;
	 x=1774989576; bh=kQJQrCceeT3vdLIN7zWnldzYwpMDL1GuLvYlQTM7xZE=; b=
	p9+JGIo84WnX8h238/67WbniDjz10Ji7tIX/PCFk7FclITG3tYAj8msPOfs93UVY
	ed2yLL+z9Ilnio7fmU5iLADKFEgLp6FQC5FLB5jVV59Okd4PyABw8/JoY4fFBGr9
	aOPtf2HD9Rat+p2z0QrYVw1VCzC7yQgnoCXkeRaWzh64PipFqzeQ33Xmr9MDsvkZ
	jZDy/b0s/fB6gp4w3w8ftcWWXaTk7mMwbxVTTlbKXw8/Sx78qMomltuUlht60tVJ
	ctcFstiFA1uqEUnzFZXT/yaHRprkL07x+yp+5VXq+mbyOqwY73qRLhBDvUbKiI27
	4Dt7R84rnaqtPKxP4rQEbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774903176; x=
	1774989576; bh=kQJQrCceeT3vdLIN7zWnldzYwpMDL1GuLvYlQTM7xZE=; b=1
	rR+BfigdzCBWenmD3VN5yicbXebrOWeTzqsz1goDer9qhemtyC7eg7pP/hRHIhIK
	JGBqSaAmaZVWkdWEav8d+WNI0MZ7hQ/mama1MRLVcPDjIL18m+Se8K+EDqopVhfn
	gU/GA7gVgbIvNcBgzQiMAJ5y4pKP70Whms4+ItNC/+bzKmrqZ9h9SedFNiUZmXgc
	fNQnQufLYUcfmHeriptiHS1A7oMFbRZWRLbECuS3J5ELxRh13A8CWZGu03ZD/BqI
	oC+T7JGMQwyrvaVFhk+te+ICdYWNqvmYcImlTo/RwFeZ4wkGP3xPXxGPoUHp3Pv0
	kpztNoUAZfuVNlZG0inIg==
X-ME-Sender: <xms:iN_KaYlt1LEvRKnVK8VXQuIrUgZTG48t0OU6lHomZ3I6vSHOXmZWxA>
    <xme:iN_KaSqNtjWW2vK-aw19ixeWLJ_us8nL6ghPEt-JlWJ_tFJ4D_gj6Mg-fD8XliG8G
    xSBEK8LJTsq5bdymAztIhfNQemfJS67jylD0_IOVf1HwamO9aKUf54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelleeiucetufdoteggodetrf
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
    htthhopehmrghtthhhihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtthhopehn
    ihhtihhnrdhrvgguugihkeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhgtvg
    hlsehhohhlthhmrghnnhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghr
    nhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhmvgguihgrthgvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphht
    thhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iN_KaUHClc2W848lMomtD6uakIiIUo1d19dFRntawgNeWt-j4UApzA>
    <xmx:iN_KaQYdq7eJkYCcdnnMLwSDRZrz0-XgYRrg9587-fnAvVRTQ3nqqw>
    <xmx:iN_KaYyXlEEAD-Ibyh9XUdrFqGrzPcXZ0jQB1wGte7MlayyWkupkPA>
    <xmx:iN_KaSTGfmJvVUn9GFK_JbDaMpW6IsYzZd2S8MNAewUpoDpLCyyWPQ>
    <xmx:iN_KadjNBZJxqk5ckzupS-znAZFEee5yHQOAhfAJu2URsoXFFCr2GlBx>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1D4A91EA006B; Mon, 30 Mar 2026 16:39:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Mon, 30 Mar 2026 14:39:28 -0600
Subject: [PATCH v4 6/8] Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace
 Max
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mt7927-bt-support-v4-6-cecc025e7062@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Nitin Gurram <nitin.reddy88@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2170; i=floss@jetm.me;
 h=from:subject:message-id; bh=oX9RcQEWF2VJoE6RgvKmZHprs09/2hbUA9uGu4FFREs=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpyt97BaqY/zbN9L9A7pSx1KBlGc+EIDJ9mghuQ
 g6Z7XUhumCJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacrfewAKCRC17sMLqGd3
 Hx5UC/9G/Mdxdjl0Kq/mxFIVJnTpts57tvwpx1bbi6GkWwGMJD9sDqSD81fCz1RdhWmp5vp34Nz
 Rv0C4UAm7b2HEZqRDM7IcpuAbWKKPAbatcvlRrtpUsVY8Fy2xvn0DXVU1wLc7KVgx8EKa6AA/Yg
 rQNQq2VeSwJ2ps59qsV4e9CytThkmNjQf7mrJ/Jkq+NbVdW0TGQaNmmyBfHZXAUV8Gugv7LbYu3
 Ea+Ua2FUGFQegI0qhdWbjH+IfbLR+hXsM6t70oJNa8F5w4waP8j5mY1ehXEutqbRDGAnBvvSitn
 LxIorqzo9tH3XCOv/s7aTeS2M4xIWDGSqPWM5FZUCpAdp7WHbqSAJ9MsJe4XuoJc81mreU3Z6kb
 qGF8cCKilXuNjKfcXitoPkP/9yY2umaThBIzxtYLQ1Hbka6dYK6EbQda7l9r1OJyxopDIN4EZhB
 JhBzzdP0LkZdXfBVSBXrLhMt1Lk4fxjMjdjgwG3PEO7NKYgMl+IlPN+8hiaKUdbEI/f5Q=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>
References: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>

Add USB device ID 0489:e110 (Foxconn/Hon Hai) for the MediaTek MT7927
(Filogic 380) Bluetooth interface found on the MSI X870E Ace Max
motherboard.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=04 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e110 Rev= 1.00
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
Tested-by: Nitin Gurram <nitin.reddy88@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d60798331bb3..96882e9b831c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -757,6 +757,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe10f), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe110), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14e), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14f), .driver_info = BTUSB_MEDIATEK |

-- 
2.53.0


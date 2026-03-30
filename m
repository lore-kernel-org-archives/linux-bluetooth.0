Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA13A0B31;
	Mon, 30 Mar 2026 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903180; cv=none; b=Xi458PfMEhruVUjt9M57kazAV489IDlggNf9s9hJfqc7UQoEMplEzoFmqAXDqbPnxn0OBMu2oarb94iLKVt+dvahupj7zy079ILJxLbf8KCP8dPEQtgCCXoMgie46Lr1I7W434Wxu7ocxip+EfyGpX5Cz9t9++rvSqvd247w1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903180; c=relaxed/simple;
	bh=9VC/j/XdBMGnjdaMjoJsd1+eJl2LQOX2dwL92kQTdgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=mcu0apLiAUFwPK6gGqnLBoEvB7mBJL/wEnG/B5nG8BQVBTQZC/Y51FTrplgAJ3wDHeK58tAoQkenGEQKefghHs64ryks351YBrv3k7wTupzQOUdsjm32XFpTj79DemW0gvYXgKSUiv33OPu0pW38p5hn2QaX2ppECKIn/e9hb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=i3Bt0OcZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uhys8nzT; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="i3Bt0OcZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uhys8nzT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 183E5EC026B;
	Mon, 30 Mar 2026 16:39:33 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 16:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774903173;
	 x=1774989573; bh=bpy+NjFmQ1UZzVo0QwIuf1cqhqfKorIEk2o2QMNh51g=; b=
	i3Bt0OcZUVQyo3zJwYMiCS6eUU+IOHdwFirH8aguQS1zlOwD1WyFCkxm1+4igILJ
	G2GvGFOHOFwtskIQYrTNVzdsEdjLL8MXP+pdlbbbyNHaEzgc9ycfRvycuLnxpaJQ
	exTWRHYZ9MeU2o1x91gJ0fPXtnAS/qfiyjXe8TsoIyz74lrMVtEZAmf8W0Hon8Kh
	SPD8M6EoGGqnNtz+YnniCO3h9wp9jWLg/4g1t5HCPBNsLkFpuLeVTHrs7uqOYJs+
	qvRyC9JhpAxmo+HHJ7CmkYAhShN49s7ZHB0iJLjrQ+gdw/GKd4dRPyANEdousIHh
	b6G8W4F4IE2CyZWY5+tT2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774903173; x=
	1774989573; bh=bpy+NjFmQ1UZzVo0QwIuf1cqhqfKorIEk2o2QMNh51g=; b=U
	hys8nzTai4t6f0BEeVhl6LSPg/+YaKYrfVuFZkXKQOqwnYUgJpM6LzXUS081YWHy
	7s6mwZK3EOcSf6REA+fpkjRMQmTQ+abVZbNt7lN8MTzyMqj3ic+0DvhscY0R2ecH
	nyE18zkxV5TFgtOpxmASiUekoUEQkuCQ7/k7mE6B7u7HXEj4h4I9MFWINb36VQyz
	QJ00zeXB/g/wJJte9R2g/H8S1Kg4QC16iLTFMeh4c/Z0LWtuPREgdEf+8DTtU9+m
	52OyjlFB3zYcsnIa7vUu+wNQ5QLfaPcnLn8EOIrQZEygLglWlLRQiLiE8qdbIFNY
	vOhWcAgZOHxW5yHrM8iQA==
X-ME-Sender: <xms:hd_Kacv7U-LDaM1oq7MA8KxSDFKDli_KnFaALat9Rn0lqtV6kmZ8aw>
    <xme:hd_KaURrrdZnYRMbD7GOTXgwdpbknjU8FIIaaQKKy-boRFh4zrFDE8miLaHUQ8k1X
    NAnfuZjMp0OAHFDemKZ7lH-xARiCpngJpMN2Iq4IAwe26eUjapfBnZ6>
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
    htthhopehmrghtthhhihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtthhopehm
    vghlihhnkhhovddttdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhgtvghlse
    hhohhlthhmrghnnhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgv
    lheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hmvgguihgrthgvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    pehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hd_KaYNi6mvtFrwLM-1bymUmp6xfctXJnmMhsu5grV6bPJEXBwcApg>
    <xmx:hd_KaSClhiIo3edj7a24D2_QRG5JrDeuxlQBos5mo9S8Itpln8BlPg>
    <xmx:hd_KaZ7mTAHhZSGbc-oPvkgHqjvQLWQATD5-mSNUXTlyCu4Ut4aeWA>
    <xmx:hd_Kac6cmhv2oW89j9QBGfJbNP99pKTKNCRoHW0WgpzBL9qs3gWZCg>
    <xmx:hd_KaWoY9WHiicwcFLr5p3cGOGTOxYVzkF12HvVbmeexgcsE-WmKkDwG>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E749C1EA006B; Mon, 30 Mar 2026 16:39:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Mon, 30 Mar 2026 14:39:26 -0600
Subject: [PATCH v4 4/8] Bluetooth: btusb: Add MT7927 ID for Lenovo Legion
 Pro 7 16ARX9
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mt7927-bt-support-v4-4-cecc025e7062@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Llewellyn Curran <melinko2003@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=floss@jetm.me;
 h=from:subject:message-id; bh=9VC/j/XdBMGnjdaMjoJsd1+eJl2LQOX2dwL92kQTdgA=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpyt97CPiNJOAEXVwrEfpjgVNH8JhPhYhdU4FvH
 tHsYov61gyJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacrfewAKCRC17sMLqGd3
 H0p8C/9ggMvJ9k8K8lcoa0z4EPoXJxK8OpqiiwBYQ/5AnqnPWgs0aadwVtiY3C5KkSnrVtHcHpY
 KrxG43URYqV0ZiKHDiWB4omoYLRiA6cu82LiiYaVe4LXoN3UdtBVgXxtM+7W2Rm7NSDaSEvWDaU
 3u0S54cvMtDUg3x3rsmVygrBqGqc5qA0EZLdfJveVUBKgyGcbO3AsyGwr1rdVXOg6V9ft7IPqnP
 N9usKNQ9qccfcWvSTpSBFNV1icvhIDnz1meQNDx8DbE5hqZtlxrt6jIWaZ3vj//y2c4YZNY4ch3
 icrzyQOcKPUi+GZIYeOoTXt+QOIISbScV8SGnO5l0ifm6qRP+RXmfCURFatBuJQDM34IId3XPbL
 0xaQkMYBKZ36qcP2Ru3NASLEgEMmcvI/fnCOCFSFaGtFsTzRY0gnG2iS6oMIWJ7yVnnGJWyq8hh
 NmpzufVq99GWFlP5vI3T/hS7YTQ69gi18LznEgJVc46tuEbkRgn0rFRmdsfAQQlj0Ikc4=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>
References: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>

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


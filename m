Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745E33D4F2;
	Thu, 26 Mar 2026 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563212; cv=none; b=pWtLd++IQN0i8tL/8LmDco3bt4laSNdizeWuI7Cn5JMc0XGLHoTqxUmEHI5qxHNtkQn3C3HYMWJMPQUibDk6G0qAKZX0MxoRHAFiBc7EyvOo92czYizyAxnxDrcsrm4hCOFTFwfdMnf4TAVxNnaJwFV07qhIxBhWJZDsOgsPeKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563212; c=relaxed/simple;
	bh=lWryKhkw4iLj5N6UVE9I7cEeZDeTwxGqMUn3iSX25wU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=t5TQDEu8FMNddVdUXg6G/j8N82yNfae696TNH1NJe1eXfxgH6GCimEKbuLBjVQFXlcoXn+DrKkTP0ujOdhcKW8jMTmobqUmmqukJCguaOQL4v/yVxX5d1Zd6BvHXRfJ4evXRzOH7dNRZrNuKKb8DPQjdoyy1Vl7awSHAA5JO1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=cOLcmFin; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cu4Gr5Hv; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="cOLcmFin";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cu4Gr5Hv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 245C8EC0221;
	Thu, 26 Mar 2026 18:13:22 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 18:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774563202;
	 x=1774649602; bh=XVHd+2ZauyHwNk7khM0QiFJuTBAS85ERsapbSIu9KaY=; b=
	cOLcmFinU7LaUkO7L6JT/hJ8qH/UzgS9HQWVFU6mXuEXsVEYWV+8KQKo44jhMG55
	TmeoUwl1sOFHWqrreg6IAxTBUfOLgfp+s10Fkf2Hr+Ac0steJgDDUpPe6qhFvBSY
	E/TK+iYfoTD3uQ01/rWUMOW82ccr5CcoVp4+cUnHFKAUzRTTJzmJHU8DQJFNC1XH
	hOrk+sN6RqFKHn28WWHz4ZDL36NXHvhpGe3KEjPY1Io5/d4uHcgoDX1VVpFste+8
	AD1fEiMAMXPB+MbNCpGcoVxY2j28cnh6RSKAdSNA3krFlFRafKjyOX28Bmmw53lG
	01ri1QPoWGO0GUZJSBpQVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774563202; x=
	1774649602; bh=XVHd+2ZauyHwNk7khM0QiFJuTBAS85ERsapbSIu9KaY=; b=c
	u4Gr5HvF2+SoyQBypJ2VvoFfYGZ+/MzWX36IKDSWgQIqtpfUO4eQxjbUKBhtoCte
	IBf9wQNe2HGWkOohVITRbDSOxR8sTOXQAyvCgOnoEBg1kb+knDB3jQDG5jKJqvob
	diDInzapjjnzNcn6Xs6OSviT2qS5J+dWmZw6zTu6SG/DsE2xQMMlSLTUJtq/v1u6
	ibtU3EHe9/n8PwYClYpcXM7vwABIUqGcSLKHTuFXQfKyPHTVvmuvrUjHoqoY2XRV
	VeJQS9lndfTnoPJyzse68MsI4R9vOOqf4eDL0UrSBpCngcMDXLfQ25cWNazP4tud
	TNsTnbWO6+0Cm3YGc2PFA==
X-ME-Sender: <xms:gq_FaV-6e3tWC8mv0pJXa0mCu2BO1RG4wqKp3_qNW9-zbUzteLYKoA>
    <xme:gq_FaUiIQsqDtmxoM-y8G4EZvYkJBTBbjtNBxUc4sRBsrYfk2PFzR-z2prldCd7XY
    0rgrrSvjGjw8-d9v0JwnS3PEZj7QnbGz7e_Oqj3Z74rQBtmcux0muY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnheptd
    efvdefkedutdejfffhheehfffgfedthfeuieeiteetgedttdfhveefledvkeejnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhm
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
X-ME-Proxy: <xmx:gq_FaboMlYOmuQJbn11AbVIDbsl242sORGw7HEBCIpX0OSCdHhdp7g>
    <xmx:gq_FaT4N1llVQD2PbaoS3ReHqHOqDFjiUhs6I-oyw3do4ErmhLnYMQ>
    <xmx:gq_FaRibf4AXWvWdrDLTiEc0hxGy0qrWl95oscEI926knFRznELKmQ>
    <xmx:gq_FaR5ssRxhrhmcKXHUHu8ySfL__VGOORIjfGszqFjM-jlbzuFxeQ>
    <xmx:gq_FaTLb--XKww4ER2tx1mTNM80jsS9nL3bLvj5ZQny3nrACYNhpMAP5>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F24C61EA006C; Thu, 26 Mar 2026 18:13:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 16:13:11 -0600
Subject: [PATCH v3 8/8] Bluetooth: btusb: Add MT7927 ID for ASUS X870E /
 ProArt X870E-Creator
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-mt7927-bt-support-v3-8-fa7ebd424323@jetm.me>
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
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxa9viQJqHMAFlMuykY6MSErmc4m3WLkT3y8m8
 jHXOgIm9SCJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWvbwAKCRC17sMLqGd3
 H1wCC/9LeE/71Hzfm2mTNh+TWY3QZ9Vn6ez4kLYBdIC3z63PljOFtyNNmQIJErwZE/fFRypw3ab
 A9RWJs5idxhujej1FO673+XC4qHQ11AdZmOri4umBCt12ZLUIjD3cGQY8bfxWVbyouBkLp0mgAb
 wsCW+bGqd8zPuosu4uZEsMetmHhvmLzP5dOGQuRrzkB8cwAyzTv4gDTEUBQch8y9roClSaNrC0v
 E/ZL5MKMha04fIvPjs+M3rs0JApC6G0PjtMq8KQUIhKSaqO1D0O8Ku0ccxsfxuvY9mTRbhd0cUd
 medXmJkAtdX6s599HAFRrzGVusFFxrlcqdldi9kXg/uq0HhN10jLDx7O1Sacbn8ls1qxHKsvWpT
 PQhluIk7cIzuyFMyTzH/evWBHBkLnirEL6YB6gSmAsBngq6x+F75JZhqw6j9T4ESuCHhVOcfob0
 quntmK07RiF1fnGiteHglnCF/J+v3s0PVz2IojWuIvPizckUm++BoJkQSUuw1+NFA8fT4=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>
References: <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>

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


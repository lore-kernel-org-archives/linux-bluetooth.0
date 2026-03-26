Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9033F5AF;
	Thu, 26 Mar 2026 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563196; cv=none; b=k7KyiORWO4/dSQ0cZii7OaMhOGgY4DUtsaAx6e8S3lKB9k09oVeE7XCDohkyDi3xjauyMuoOJSwFU2ouAKU0QMZ9sq6SchkU343BuQBcp6AIKCQ3R9bXkdd+GJwf/9BmJs8H7ep6P2cGQCiICkUI/WGZwOjKhscg4z1dvaTL+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563196; c=relaxed/simple;
	bh=M/B2rUsIc9XPtt7O3AdFVlNy7Muc9x3nvF7epwhHRKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=nkCBjgg3xX3QacugwrM/+MHSAtTnHKAvGGFKIG5t7xWp0Sb53pic9w6ZQdQ8/+zdlf1zmtkNXzf/cU2bT+atbjCtv+jLk0d06iqnSH5u1wPCLCw2hhvsrlHzhPe/3ga2nOnbyqCJTWg/FBfOiZjIPAzC8sIiWkZDapK1nHx6bu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=W03OovYV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sziV9h81; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="W03OovYV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sziV9h81"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06EE8140022E;
	Thu, 26 Mar 2026 18:13:12 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 18:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774563192;
	 x=1774649592; bh=2qHp84u4lfDr+6YeO86QEXq5X1hXYtGUt81s2Al/O8Q=; b=
	W03OovYV4WEyvXpwpUl66TK++puY4KdRyfZOy2YHveMn6eleLmVb2bPYPWgK4RSO
	fOZSMt7HwUWJ3JOeKpte3+jZh25hSZlUWrx1VsAUYZWymEg3ASQjVkkT/0vzgRnu
	rIKuOGllpSZF+rwo/Q/byJEHjG9QZbEZakuBNlcaqPLYAVvtXQiiZeoHzWIOVEd2
	JaWRRvkPJOzAmAKrqzIyAG+hMka+ghduAx14tIYc+lvLyaACxVqva6ztWiP5VE04
	wb30IqvyxODHhLoekVbzuyI8voYMKjxD9YQKDWDKv8yXTBo9B9QzxHVlmBYljC8p
	FP2DOraV5abC7w5vt12lCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774563192; x=
	1774649592; bh=2qHp84u4lfDr+6YeO86QEXq5X1hXYtGUt81s2Al/O8Q=; b=s
	ziV9h81BoOqELiP2ilVRDTf52rIL1XUwznCCociBJacsQ8s/5xl7fcPpmNhcsq94
	Nigz0nileSi/box6E4FjvrtmVeWdiZkn/LqHSTkCYUeFA8ZM4e5hXAs/5wpHNW5H
	0zS2wP2SCCoDakXN6ACOCOWbN6yHHRlqXU82jpOeDujp7rzMKo1MRSTEHbnbfsMg
	0es/IZ0G1hvjeVyVHq4dgRl+S6Qge1eHj9vMfG1rqT2/NRFjvwJPX4ci9AEgUJ64
	zZ5AJztpuNgjiRePlK1UCPGeoyurdRf+5GEjM+xUMUUoP6PDb2wqvUQ1uMic4pii
	VfXYH3wTuE04rvzEbmIiQ==
X-ME-Sender: <xms:d6_FaRskssXXmxXzbfqi8wWBhqE2vaejblIdtXUdAGQb44ZpU-NnGw>
    <xme:d6_FaVR1vMeju3OIVtRGO7wvCt8T45l3NtTCQWKzcSSM_NLD01kdnQH8HJtjMBek-
    _ZsI2Ef-FMHLtmdhJy0mJzUELr06Q_ATnPmUNR8M58NAGw7ucTSxtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnheptd
    efvdefkedutdejfffhheehfffgfedthfeuieeiteetgedttdfhveefledvkeejnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhm
    vgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdr
    tghomhdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtph
    htthhopehmrghtthhhihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtthhopehm
    rghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmh
    dqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    lhhinhhugidqmhgvughirghtvghksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtohepjhhnvghtthhosehmihhnvghirhhordhiohdprhgtphhtthhopehlihhn
    uhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:d6_FadNaMYWvf6bl7SR0mRjecsF4ZBi1WkA1OUc2dFi9F-uPn1ooSw>
    <xmx:d6_FaTA_lvLx1kiufTESuigwrc294SSqAMeBUP-WwzJxifM1FhpiuQ>
    <xmx:d6_FaW7fG4MTHzE5Ez0ho6tvzEqaQxa5yRuQemc6F9LP61KLbaHojg>
    <xmx:d6_FaV5tBRQ_UOICUTGWlcukBtRI8jm3mLN-peSQaPNuTdtg19ZUgA>
    <xmx:eK_FabbmYq1Y2edsyWn_ii305zEAoRdBLg57yNlfUhIJUQTzkrH-QUFn>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D3A071EA006B; Thu, 26 Mar 2026 18:13:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 16:13:06 -0600
Subject: [PATCH v3 3/8] Bluetooth: btusb: Add MT7927 ID for ASUS ROG
 Crosshair X870E Hero
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-mt7927-bt-support-v3-3-fa7ebd424323@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2196; i=floss@jetm.me;
 h=from:subject:message-id; bh=M/B2rUsIc9XPtt7O3AdFVlNy7Muc9x3nvF7epwhHRKU=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxa9vWxoC5654A3OOyMXqe2D+NDO3LCGUCUEn9
 Q6vkaQoj42JAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWvbwAKCRC17sMLqGd3
 H0bpC/9HkhTiHerRco+nW3YlruTs1y33O5i7RwBGz3i1mabmCYieK5Z1T3g4MwSQNHR4z+qdF24
 qaFGkgM2jvXYzgqXo+u39vups6PDJXnh6c8khqPZzUXQCK5r5OP3VKOLh80KeafF2BD4E3TcxKW
 lpa5GJSASucRud+/u0JrnBTyRJw+5C+dYkgJhxy31Bhk8y8B5GPsFeWfQOumksUbOB5ThNW3DQr
 6uoFf+1uDsRjaiCNvaq+dA3i0Oarys5DVH4U4Lia+1BunKrYVawjoqb5I74OQZj37BSDvEDcWML
 62m30PwRrNjYuHsvuOc5W4YNbdkq0fsJmkX+cMJ2KPcHyxOw3XKX6h8xQAC9lAvwyZ+/617Dudy
 diuPw/35n25X3C2QQOj6i3gR2/xXxfeTzXNE1IMfxSqZjMBqO1C1qj0Ecr5h5N7QKZ+PK0LzeXM
 JJqWyrivin7PyZhZs0glZXGBFQ9VGRcnQ49WW1zQJWNOgnxtMyx78In3T++7sGfTaNweg=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>
References: <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>

Add USB device ID 0489:e13a (Foxconn/Hon Hai) for the MediaTek MT7927
(Filogic 380) Bluetooth interface found on the ASUS ROG Crosshair X870E
Hero WiFi motherboard.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=04 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e13a Rev= 1.00
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
Tested-by: Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a5e44887a5b5..58309af0f7a2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -751,6 +751,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe139), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe13a), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14e), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14f), .driver_info = BTUSB_MEDIATEK |

-- 
2.53.0


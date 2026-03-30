Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2103A2542;
	Mon, 30 Mar 2026 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903177; cv=none; b=CUlIQIF7FRLn8sG/keDqWHIrBLGtVUtT0PRRIybZTyH6tN0H83kYAkFLh22AsdawBYjvVXyzn9H2+Nv4DvHElEXg+j43UBKLw5Nx+pMeoQ1LjnNTLiamUWcRXOIhJyt/K3Rc0H9oiB1HGRLMatfkrr/CLLrsCA/QNH/7jQf5vIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903177; c=relaxed/simple;
	bh=M/B2rUsIc9XPtt7O3AdFVlNy7Muc9x3nvF7epwhHRKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=NFf4xCxvPWp8ayvHz+I1vg0bEgxOfZPbQMwbruVEHMnOv911/+sXjuHoXH0hDqW2d2Q04j7MnxjdxO0zY26fKIMV9kMswAXj1KD3EVFG8jgnI5I3ryWmJvyHVnfzqUE+LAY7Jo2tVjS3xAcWbh2r893dDG7PR/zAccQHB0p07RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=qzBWrBXd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H3gkvqX0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="qzBWrBXd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H3gkvqX0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F473EC0268;
	Mon, 30 Mar 2026 16:39:31 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 16:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774903171;
	 x=1774989571; bh=2qHp84u4lfDr+6YeO86QEXq5X1hXYtGUt81s2Al/O8Q=; b=
	qzBWrBXdqobl7OWEFOHW5Ie/iW6C1XGik5e0CCJp6Zr+LJkp407jf6UAAGtNrAte
	hCcV49HDPvfTvqW23e46638OyCeOZrCoqeGZLY6o0E51KuB7cpvVNDgNe20UY+m+
	RfNk67I0ho6vCT6Ox2Cmt/HDIvRECa2EZ3RV0dnPeN8m2XVOcsql/vUgcHWMuUfD
	kSFe14Nv+1NFQIopKJ09EqhuEdAvmLRXfniy2jY79K+Jt0Sbl15iAAVZgFM818rf
	b6QQiQaItrx/wZVWvPF20vS6xBJa5wF3y9RFYXQJ48PDpTYK8ugAsOP1dOF4tVgD
	lmQASQYURKXR/Ivgf8i0uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774903171; x=
	1774989571; bh=2qHp84u4lfDr+6YeO86QEXq5X1hXYtGUt81s2Al/O8Q=; b=H
	3gkvqX0LporRzlC3FcAo5nJpZl6RPYtsC+3ztrS8yx+V9SmH0m2Ilg23JHIB0v0Z
	eYi3o1Ujsxm9aa04Ou3HODaZpTVYXjh00vUenEr4D+V1/qEJSxmnKaQ1CBmYWEAI
	oHzY7+rl1sWWFuiWEq2ar/Bnc3N4S/Nty+mZbWd2jG0LZnXnoi/nUrf7Utcmtn1d
	0PPLsuHIGqui6ac9aeYsBvHh9eWCnIiBXTi6W8R8EV4+v9waVCSWs2AAKhe3Irrj
	V1NgaHDoK6YsgwRQarZLpor+xm7m5ERrXFPWvu/yt6Bw0T6L+KDKfanI+86000H/
	AEtINlQ+gg0QL0YluSUHQ==
X-ME-Sender: <xms:g9_KaSAQdl5sHgSdhiaXIwVoFehOAwaYsEpHapvDmxzjlNjNIRgLTQ>
    <xme:g9_KaXVx0MMXhl1FFX5MynmEsPCa567iXztTqP8X4kc9trjLPZyGFkDSymdmedw2k
    y1l69gUpJJp1iULk8Ily4Y2BFaR9U6e-kGM-u9BmjM7SSi44JN-b7I>
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
    rghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmh
    dqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    lhhinhhugidqmhgvughirghtvghksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtohepjhhnvghtthhosehmihhnvghirhhordhiohdprhgtphhtthhopehlihhn
    uhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:g9_KadhTOWDxGt_f4uxxRq1VoCd6d-Fp84rRGK3Cp311MYCXVDzlvg>
    <xmx:g9_KaVHEUUVwiY-af3d11gTknLVdVQ9CFbXUVrQLtzxqhs1FIhkGxw>
    <xmx:g9_KaXs0-46dD_NR3WY8XKIV3tPTaJt9NrjmlTwvF7YYJAVrk_B6Kw>
    <xmx:g9_KaedRgnZsTZ0IacTgEOOK2vq4L-_bL2QaTwSsLjXoaG3K3YuddQ>
    <xmx:g9_KaUNwJWpAyBkeOG6DXHL9wB1AAmQEupii_pPaFJ41Bjxss2LFtV4w>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 59B4B1EA006B; Mon, 30 Mar 2026 16:39:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Mon, 30 Mar 2026 14:39:25 -0600
Subject: [PATCH v4 3/8] Bluetooth: btusb: Add MT7927 ID for ASUS ROG
 Crosshair X870E Hero
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mt7927-bt-support-v4-3-cecc025e7062@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2196; i=floss@jetm.me;
 h=from:subject:message-id; bh=M/B2rUsIc9XPtt7O3AdFVlNy7Muc9x3nvF7epwhHRKU=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpyt96d/Lwrb45tMsu5QXFTXkhaUZ1jxz9JCX0g
 v2Apf8Hrp+JAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacrfegAKCRC17sMLqGd3
 H8xoDACgoAfk/xcP5GhtLL92sxEhxGC2tIz7x+oG7YFL0Bu+73fSWu20nFFG4ky6ejnroO18cvE
 uLGda8Sk2Ilu5lU/WeWmlz5F624a/MVkGE/mzSKwLLddKLRr/ATF+cenaJ5UMfnvmW3vVjUguam
 w6uZF8kXYnR4akam+Mz3RDxT8MdVRMvj2jGVa1INafJja3Wt2Q2em5OpZjhEoplz1KS9RS5MEJh
 fDDhanRtkxQjbQjU/od1TO6K9la3NdVjH2KPQ2g6rW0r1NuCE/PKFJblLGt1GnFyWL5j7esJdON
 tSzgmnyAJHYXJVAVVMYmq8Q4hbb1YmhXzIqlaC87X9sl24t/2/0pGTcfJ5UvSxK5XdyXINLwY2E
 ubIdIrwh9ZndvD9pOoyYO3HC/Ss5Mlm0KRdEczVjjbw/gDQWoRahNXZsDLbONZMmqGcaQDM6q9E
 c/aRjRz6tyEDouqADEwig/n6IvxiqycbfCd+YeXDU/xsgKZnaIjWrarnqP7qIT4lPGU9o=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>
References: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>

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


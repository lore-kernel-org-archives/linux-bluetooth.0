Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336539A7F6;
	Mon, 30 Mar 2026 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903183; cv=none; b=dutt4/vDGQNY62jkviB6evBuVwtc/6GLIgR2PBhQtbUcBXIOFwOTFTueP0QzSu73FaNEHG6puG24fiJr+VBYq42KmLPjeTszoMcoJWwHBS2JQqKPBR32P9i2b9eJPX81XDDNVeRK3NwmoppKyoyBlUS344oO4+cRZci4v8Y9zKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903183; c=relaxed/simple;
	bh=0X9iYzgDtL2noTXAFbHuUBjE+Gu6Hwn5WtC2t2VD+ZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=cW+ElYKnZCQVPmj3W21qVd5f8skdV0npfiTeXXdjMZ9Rhh2BEDvU5n2rT8v+n73cBbHeIY476hohGfxnG/qsx+CIJZCrgskWxm33IOo85txbI/uPahWQFYEZPcBzxZ8x0AxnKA80Lg05m7QOXJxQHHAk8HkXOXE1kSlZqTYyuw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=S0UmgY9z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=djUF2ntX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="S0UmgY9z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="djUF2ntX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DAEE0EC0266;
	Mon, 30 Mar 2026 16:39:37 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 16:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774903177;
	 x=1774989577; bh=OKYvgQ1t1lSRkNHRJOJY5btuo/K6VYFBYLipl68nHhQ=; b=
	S0UmgY9zxhxAgZdTyfvI268WvCUqEgvT5wfhpGIEk8g6fM6rWNWOn1O/ivwpg8Yp
	P02pvjQi3qYnfC/aa1gmRbC7xom91nqGFQ9xDhheMwNuX+Soe6dxeDLPfza6Uxo+
	GFa2Zb4GUtAgZNxvLQYpWAOWDV2Zdi6ichH9ZCwia+hMHptQZxxK8rWSzBW+8o5w
	tU9aOF8kD3qy7RmT6ddfgyJpaCh1Lfa/1hWw0V9FqvrvSZZAY0MQEjY0OKA4xIkf
	kn+x48IkiwbqWGHpBHvjkMdOUJMA5S9e403gjhkK4A8YDkqiAORQxfBBS7qeneZ9
	ukxSucwMXRUVbZ+K4usWsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774903177; x=
	1774989577; bh=OKYvgQ1t1lSRkNHRJOJY5btuo/K6VYFBYLipl68nHhQ=; b=d
	jUF2ntXCYPkyUUfpgJSZClSyaoX0AiH3AgUiFdzcsboQ756FT34BnPA+MWMo+mD/
	i2Z/38xEVD15xlIy7uGeQjWQfJ3P9QacLVJdPzDGxYq+5NTMXS4EzBkgvTmP0LxI
	xrZTydu5BB5y5q3i2S12OPc1YQFNaRAJ9eyH/VRm0rB6cI7UTSy0DZLjZc6hg5li
	qsWmvPXVpLlgRkL1wf8lZG+rUUZ1cT7Exi9gokghF2ftS4MaMZgLPYwQ/qG1Fdtd
	2mlZNrbT87V3rHm7Wm+dCaVpR3wrCPuZ6RjsBnXXdjh1LF1+9WN6PiaBCOsf/BSE
	3FTktHc1KOtGilmsmA2mw==
X-ME-Sender: <xms:id_KaYShDuxeilWmys9R7TvYmMM4MHEdpR6Da0UteZarpVP73Z6ysg>
    <xme:id_KaQkxluBJqB-6OidQj3e7VSmEsCT5LNgLHyQjpUsfxj9BR5hj6KJ8ruRuK4b4J
    N2b6bYDTNicsFxZ732OXKh6YmA3PgT9LXOL61ewwOCtcWTRE_g5v8p4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnheptd
    efvdefkedutdejfffhheehfffgfedthfeuieeiteetgedttdfhveefledvkeejnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhm
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
X-ME-Proxy: <xmx:id_KaeU3g7iJpiWyVi95jJhfnQZJ_io454LpLrM4eWtTmBQme098iA>
    <xmx:id_KaX9iUO3EIXMZJ1EwEsSKeefIjW_6CkeqmLjbgV7HSZUSwYYQQA>
    <xmx:id_KaZuBzgvmhyROrnWUALMuG6vdovsx07xJJuaJr8SW7inrUyzc4g>
    <xmx:id_Kaf3ZAgiMiWjID-LV_cHxmC67Y4zPIJx5kIU_gu2R3Oe2-AKgXw>
    <xmx:id_KaYDGOgKKlDkYodeOM0_omZPNz8ogNS0qfxjwyVGK7UZAlA7fjSPC>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B54DB1EA006B; Mon, 30 Mar 2026 16:39:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Mon, 30 Mar 2026 14:39:29 -0600
Subject: [PATCH v4 7/8] Bluetooth: btusb: Add MT7927 ID for TP-Link Archer
 TBE550E
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mt7927-bt-support-v4-7-cecc025e7062@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Thibaut FRANCOIS <tibo@humeurlibre.fr>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=floss@jetm.me;
 h=from:subject:message-id; bh=0X9iYzgDtL2noTXAFbHuUBjE+Gu6Hwn5WtC2t2VD+ZU=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpyt97LY/SZ5rcg3G9k7qesMrweJaMUpx2LZVGh
 jHNrZUjVgiJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacrfewAKCRC17sMLqGd3
 H8osDACISz3fln6X5a5+tcmN3bLyDlP19FlfSZCrCBWxWbaf+SfY04x8nKkxBLtTx6R/F/A8W6K
 u0OBLE0BIQC6uwwVZiWluh9NunaYuzA+XeBO/yUPv9fTz1yPJKK4bfBMfW5Gx9ZQzedKJTeScUU
 cIZAu9sxbkL1RjkKWZ31BjSUvqTopwvmckkwRNf6/ceTf0dQnCgitzysRvW62ZuukeRBlwcOPYO
 JMmpx/HEL8cBehsj/1PFOmfXwYOgxnt3EjwdMWELjg7izEFx04A+y796jZZwBv/OAxUzXEl5RbU
 72p7CJy3pdpaPV6tzHMGN2xexn6UecuoTfbOGzrLLxMUJ2r1FUOAMf5XrQmWAE8EaAFjD0qmUzC
 EjkR4ofNIqqTGq1igaey1tL9LdXaGWQcb6mkAUlKocnSmYHoYdnFsGaTbKPRWgRg0DmlFJao/TO
 GzWdnlM3905iqRgwXasusyvTobQN6gCFokcGSiesP3/JoHeTXMLh9FqV7aeQMVykB+zV4=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>
References: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>

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


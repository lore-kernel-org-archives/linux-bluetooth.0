Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213FA399036;
	Wed, 25 Mar 2026 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774481427; cv=none; b=AaUQtz4BlIw9IIsCwGgAU05reTzhIY6dEridaf/kQAgvnzvnHvGiF6nkvmJIiRvv5IgARyayiukyjaMb2pJmNZFu89uMrvDyMlrQuzPV+OnywOgVaY6k9/c+RoWjhTanIhmIx/pH5WiJFB+3g1aKJgPfE0Wvr2lVNb8v1DNBsko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774481427; c=relaxed/simple;
	bh=M/B2rUsIc9XPtt7O3AdFVlNy7Muc9x3nvF7epwhHRKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=ROoT2FX3G02YYhdv6nWR6nZPPmY6j2OzMsu4c8JS2obbfHXBGs42pnzU8Z7SALJ3jBex+kpCfggZYIbUdQESl60Uon85Wh/3MoDBeY+kGcZWTBiDeu1bUPNCYkxeqrgqDYPzqhmxODI9BNEv8lfkDfBa3vIoPJgjSyUGVSyqliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=hohgp3Jh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AUDxJs9+; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="hohgp3Jh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AUDxJs9+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 476A61D00192;
	Wed, 25 Mar 2026 19:30:25 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 19:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774481425;
	 x=1774567825; bh=2qHp84u4lfDr+6YeO86QEXq5X1hXYtGUt81s2Al/O8Q=; b=
	hohgp3JhacWkXIcqV6OTOUBzW5lp+d3ebqyCrO3NHwkqLD3RyzDGoz9MJb5KAWTk
	FSkukoa1GZQtou2XkVUgvZ7E/1bxp9NKvAB5FAYeB4gIjgZJ9enGYz4A6w7AQUyE
	Y4B+LHA0+7BFBnXOZlje3skBumcSPO5NrS+2jsfD05g0VoTPXvUpM5R9wFiEaGkc
	80GE2IgIirvP8HTJBndwecWTCiRpth2OO+767VrROqVAMIyltVyRc56PJuA9n0MY
	VB+gLuqFsqqhVj3U8ktKWF5//s32V7MlSCW/+uyBiV9WkRTmUneUl2Sbp+O+FtyL
	8a2xtLMFJyGvPuGm1jv5WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774481425; x=
	1774567825; bh=2qHp84u4lfDr+6YeO86QEXq5X1hXYtGUt81s2Al/O8Q=; b=A
	UDxJs9+qVvBFQtlmTg6YLNUajM8kvu3MAfZNCKMQ9mp9EVROrXBT1uiXw2JEE6/1
	n3ClUrT1KgjoDRcM3/CHsW7VeXlkVyXQnGr3SF8b6jWqC9ZqAUGEpX8ocNUprC9/
	CO+zT/cyFqisEEPzR355FJ8x2dOGVxQQs8QmQCqnPzH7DR7C7HfODl0qx2o2x6Zx
	15VAu+PAstGFqR4WKJBaBdLU7FPuFYHvF5qO6ixYhc+VBhGGNJFn+WCs2r7MpRjt
	z3b6+dXgQfylFF5Se2KnJXoTul2joot0Q8v/aRF2bo9uyysltip6UbktGbOAc7RA
	j5FjmFWl+BATpUXYu47Pg==
X-ME-Sender: <xms:EXDEaZIO0KOU_FJmjGI5aeiIPZixzprmfU2uzVfyxfCouC2cfyaURA>
    <xme:EXDEaf8z1JJTU3q9EcDfAfpzg6D_Pe24KhEfqoPNgAFzpEDr4CNRfgBJdashUOK4F
    -uU5dhlpiYV7oHXLTzxQba_1Owz4x8iA1ApslL76yhFHXy0QlF1>
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
    rghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmh
    dqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    lhhinhhugidqmhgvughirghtvghksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtohepjhhnvghtthhosehmihhnvghirhhordhiohdprhgtphhtthhopehlihhn
    uhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EXDEaUoUDCMSkM9PkTlgp-_iOGm7qLToMFfesF9-DJWDejRQ76CAtA>
    <xmx:EXDEadsgDNccH_vHxDS0QKbJ9HoE1qfknCQjU-N-jkjY2QZM51wUDw>
    <xmx:EXDEaT2XsAXb3h1E1erJekbbfaN9NJZZT1mhcDvtesClxRwZR0EZPA>
    <xmx:EXDEaYGqTz-DD9iEg1imHc6AiSwMmsrlJuYJN32Z6JWT52ksrz698w>
    <xmx:EXDEaQWAHAG9gjBO_GHkoeI43BmC7WpOpcuPm3sBb1_qFXde0WJUONLy>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E7EF61EA006B; Wed, 25 Mar 2026 19:30:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 17:30:20 -0600
Subject: [PATCH v2 3/8] Bluetooth: btusb: Add MT7927 ID for ASUS ROG
 Crosshair X870E Hero
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-mt7927-bt-support-v2-3-b892a3252880@jetm.me>
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
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxHAKGiGk2azJvxv4hwrlUssI/lPm3PFT6aFx+
 adsUSRqtWaJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRwCgAKCRC17sMLqGd3
 H2P3C/42gbDNeKLwoRn6jTn3G5cIlS5Q/mo3IK8iEnNUfqhSzGjqpaobFyhydB2xVyAOpiXgp7d
 xinVOQCMK6Zf4jDLftyAD5ybtAW6KMdwHhAXt7pykpShi1oruQa32nWRq9wRaBdf6sC73qlF+z9
 5XVG1CJvUUMdfiYqallYWuYLvrHJkIHpIWhD874sjKViUmLEL3tfszHT1lLhIp4Qu9AwGiSESFA
 /m+wERVyelH0DiPxawVQR/O3Idx0orcpezOifyY9UKuHdwotcILRIlOVtEPiKL4u0syZb4xHI5Z
 mNSO8bD+KvyHSAOO3z9OxHafcKWu0kk2z4mmkn1nCnz+RD0HaaRfV20pPi2aAGobfdGgXZ6zvjm
 ff2tDaSKWjUgDYHRsOSxIX8BRTQLOF5KKvBbTAh9cuW+fg9wvBnUGWfEYt/b1VodVK+oh3ZXEhy
 TGk9b7d2x1zno/5US/pyTX9Y8CJHRtR7i95O2VfYBNGIP2tKJVifmNr0/NnGt/02Ivfdg=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me>
References: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me>

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


Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C133C51D;
	Thu, 26 Mar 2026 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563200; cv=none; b=mOqa6cei5mqrf5Vn2Y7qB+zN87NwXSXmpmlgseP39O+YF+vkbmUNnUCi9JpKmqTkXSO3Ak0RmSI0DlZN1SJC4mOAcRsF4FtT7EDIXPZkFyCo4Mdf1vG3xzIuevll4I6eHsbWmQxfolAiBzbue3O9lpG1iYIP7NyhHwSUMJxmzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563200; c=relaxed/simple;
	bh=oX9RcQEWF2VJoE6RgvKmZHprs09/2hbUA9uGu4FFREs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=ZanCqH5oJRHe+/KAOSI2NMvc3Z6ZHi98lXdyUHXlpYmGD2THlVxQUlmCk0vQ6zRfJPtxQEIz4mnpI0oMhfubGFVHT0LhhzZD796+ejBA9k4GstwfVdTRsHniWq4lJzeezHMdj5oT6y+/xCfEhtiZt/myg93hwHb/U/5EjO5wn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=ewoBNaB4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bA6xEreV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="ewoBNaB4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bA6xEreV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB1E6140027B;
	Thu, 26 Mar 2026 18:13:18 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 18:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774563198;
	 x=1774649598; bh=kQJQrCceeT3vdLIN7zWnldzYwpMDL1GuLvYlQTM7xZE=; b=
	ewoBNaB4wzpnJO9m2WEdbnPjjtQEHhgLmycmxQscKFHWXdBBcw7U6fonirVpaJlt
	MooD3TTyyKuWOoQk9OLs5CqoODn60afCmVsXGyZbAXKT9Wo/voGN+5OQZIuS5utB
	h3Axi4PB5QZnQ7E+e98Zm39DSQ+q79LOU83c51kQjiCfI367RCMRRH0WMLjX0TpU
	7B6uM3wG4zgYY7PEtEa0VJE/bCw/GbqZR91/m9EUgFgtYwdZh2hrIceBja9lrIEl
	K4x/FOPcOaKHJ2ZbRiPshg8SZCmVmau3Wb+w59CIUSCCiv/EOThrpKrlypldax0z
	1EifWo4OWQiJo8/IjD4Eyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774563198; x=
	1774649598; bh=kQJQrCceeT3vdLIN7zWnldzYwpMDL1GuLvYlQTM7xZE=; b=b
	A6xEreVMUoabrj75zOoThWd+GUHRhMPsGLnxDsdAy6a+kG46AWz9bFdcnxsXwJgR
	D9Ne+wGbMW2VfEC2rU/kRbKDxxtOrjQpsW6UuPqbDxHC8NYeUlOHMMi9StxDNfy1
	gMs6m2h7wg0i8tLauWcglNXnpD5g7dGc6izBOllZm2nFqNAoztiTeMuocEr6qAZA
	THA5D2hOd8FTaXTN63B3bpDRA/RSVOizzAU1voErCYa74xTVL1tGbLyYyss4PGmx
	hY3nHusoo1qK7GtzGYxtHzd2HpDFAIofWFoQYV32RFpopB/2mzyX6aZXf931VdCq
	18gHxogRXQ/e4tyZIpssQ==
X-ME-Sender: <xms:fq_FaXczBU54gQZL9XKQiZEaMQcQ4lVu6pcqudufqlQxli4LcCaU_w>
    <xme:fq_FaYCntmPVdLqBXdT71hqtXWnWTfJCx9Kr8twVENPGoBUg9AIdLO3kz4h5slbKs
    zWJkPPgTojFNTQlIdoL8xFa6qe01uYtYpEMtR16SNfB4XbiNcWXALU>
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
    htthhopehmrghtthhhihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtthhopehn
    ihhtihhnrdhrvgguugihkeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhgtvg
    hlsehhohhlthhmrghnnhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghr
    nhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhmvgguihgrthgvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphht
    thhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fq_FaS8mGf5zRW3nofOOh5BsPsfJY1OS1kHV2y3YQIMVL2oegxt89g>
    <xmx:fq_FaVx9zO799qBUoB_2aaf-QzW2iRnZx9WkNseS90d_JJD4XqGDsw>
    <xmx:fq_FaSrgnxq4BHeyUZgB3zBR5LMrp-GeFKPatYRr_veNjxmlKhvjGw>
    <xmx:fq_FaWqlMuVp1D2i5n8jP6Qp_j7GEgL9EdvMok9OHGuDK81hJqVaAw>
    <xmx:fq_FafYuNm7VgZdeP28zeg47gzv1gZg2ub7rEOErdgx39TWIG2ZdBusl>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B7B111EA006B; Thu, 26 Mar 2026 18:13:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 16:13:09 -0600
Subject: [PATCH v3 6/8] Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace
 Max
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-mt7927-bt-support-v3-6-fa7ebd424323@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Nitin Gurram <nitin.reddy88@gmail.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2170; i=floss@jetm.me;
 h=from:subject:message-id; bh=oX9RcQEWF2VJoE6RgvKmZHprs09/2hbUA9uGu4FFREs=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxa9vDf4NhcgghkrDgpw7tNCVItkPt09dZd39G
 WDVICxyGh6JAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWvbwAKCRC17sMLqGd3
 H+dZC/0apGy01N9vIiUz03/hIpCtmGEO3MtblMe9h1lMrqRBrjopUrNv7Vs5U4XS9q5YzSMHk4j
 Ma7jEtsHAzbJPUrd/d15ow6N9SeWmBsUVM+/wAZNUatTj6sDursK76dlZdeRGosgeyBlx53tZ06
 eFengr/of2SXgaBfw3Kx1HCfBbJAL9znXzJNSLsauHyvEF3kyd5DgHy0mhTKZQ5uZpZ/jjMoV9U
 u3pPgxBNm03E5zXWIfahA+U49ogwtXkcn3vi1TFerv36Fbo5zLAaaaBVh9GpuNwOph9EVDB94m+
 LmOdm9vOKPtLaGS0F+FCT991JYLr83m8EtglRtm3KGmAkg6blkEFLhf0vdhZeJkAHwvHDtNmVPP
 K+XSSApXeLMfRGI+1sQvmRuqihJ/Em2h2LqEGhgfVOQxoUWmqMeocCsqX+6FOaZl8DHTd2DKDb3
 wgXhAkejw90wA6yDVzb0+W/iQjrP3hTci/6c4/AWu5JdpYPMi5FJeopsWbLVouMssrKGs=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>
References: <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>

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


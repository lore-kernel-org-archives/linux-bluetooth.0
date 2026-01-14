Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F894225415
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jan 2026 04:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768363443; cv=none; b=KEDGvdOOFB8WbQTe5FBD1snIcA6xKmJnaGDfNQtMTgUk3eG6em0zpJUSmNKmDr1QMhivbVrMoVUTEXhWLGDxAtjze0MPBqAV415QSRtBg27/PtTQBFEjAV3wNSFCDCDLue2D5QuZYq8YB11phdg2KzeiYwFp02GQSrRRJ+hlBA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768363443; c=relaxed/simple;
	bh=rQm1M7YBpSWS6onORR3w/UEiUbii+4joW8pNsDdGBh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lnvwr612T21K9k4lBVyxUpLV6fcA/RF2rknoDvnsoZmFcfb8jth50Lucc1GYgAUSDPodfvOahcm8n3vmTsB7XAXPpiqfsRhyIBf693VuWgZvpWF2HVE8l9P6qqmX9wBjGZYGIXNRvdCSBwBhMT1fLUlwu6g6m8L8hE/dJPlayc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sorz.org; spf=pass smtp.mailfrom=sorz.org; dkim=pass (2048-bit key) header.d=sorz.org header.i=@sorz.org header.b=toU8iHLq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSFdBwAB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sorz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sorz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sorz.org header.i=@sorz.org header.b="toU8iHLq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSFdBwAB"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8ACB81400009;
	Tue, 13 Jan 2026 23:04:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 13 Jan 2026 23:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorz.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1768363440; x=1768449840; bh=K8c19Q+ze7fIwmXOrtZ1o
	iF9rQEPab6IHqyoj4LjBUg=; b=toU8iHLqjePHaK7uV6+1BWamfoOPK1xIn/A6Q
	wnfHOBAVEXpLFZhTPzfnS0XZBimRXwSyH4CwLmIcQGmdTxCI2tbnWBZLQP6CJ3Vu
	3sC9U+9hbMr+VGqvvMFAkpCgAUfN3Oh5GTZatubT+GN2u7oSoT4rndcI6lUQXD9B
	wHuYaWHZ/Bk/DrX9FWM7i/apQShFbLjdyRfR/Vtcd0MQroaAkUGiHNrJ3dHGkJpc
	4DCbL8QuVki/RfIMPxAAiU/2Z3uwFlLjA0u5x4N7Kl3YZKg4sn0XgsmYOu/P2mtO
	PJXr5Ye3TUfud6v4Dvo3CY5eRi/ogMRr6TgXDT9IpXAq/c5Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768363440; x=1768449840; bh=K8c19Q+ze7fIwmXOrtZ1oiF9rQEPab6IHqy
	oj4LjBUg=; b=YSFdBwABP7xI7s1dOWlDqT7QKHTiwCid5t5HWcFrxhr5D9JSEB6
	5d55q20LcfTHgFBJaimmTkmJcQh/zZDOHVEPTdTwKkklZcYqu0PcTm2eeArhc+MW
	IopCKqzCoE+EoWkvPFaJJ1kW/xWzVxjYZm0ZHJKK1J6qVQCEflryzfz+C+UE/rQO
	D9cInRgpktcaHOTudc9X9YehBsnCwLDhBuzhIlgfClTc0VLx0DCh8SCXk5PkzmH3
	u+yD/uX7BrfaR/T4NbXyUnhgYlfkZosk3wxqEOrYKrh1DcYqPMskfyh1VQT1GBr/
	/R2H+W20ni0PXXLKAEiQqXWT05/CFRGUZpQ==
X-ME-Sender: <xms:sBVnaeGsLjIrBxpGS98FLGj1CfzRSCsgAEPPCQBM_Nup60exydU4lA>
    <xme:sBVnaWWCzC2jsjhuCLoir5wbOr21ROaOYD3PBU8OG5z7_6lDCVC8DLlq3CR6P5pH1
    CRb6hUAV4wp5aSnIfJosJRbtNloZTckQlAr51GU-G6-II9VwhJljA>
X-ME-Received: <xmr:sBVnadJQQHaw5CKbpkV7trqfsdbeRlqpRoC9tj7ikzX4nTrQ1fImaw-zaQteXOKOWvCuTremlDgROiAOBJ1e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddvudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhhvghllhcuvehh
    vghnuceofidvjeesshhorhiirdhorhhgqeenucggtffrrghtthgvrhhnpeeihffgkeekie
    duudeutdekjeefveejkeetveegleeiieeghfehffelteejudduffenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifvdejsehsohhriidrohhrgh
    dpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhi
    nhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhuihiirdgu
    vghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepfidvjeesshhorhiirdhorhhg
X-ME-Proxy: <xmx:sBVnaW8jt5jxFYIjlU9yLUd3xtt69XFUhEkkg81o3axAloEeCiJVsA>
    <xmx:sBVnaQIGZSl1pv6vmFoPcnwA3EMG_SVGj2qzkPhaEgoumIozMK1_KQ>
    <xmx:sBVnabmo1_fcDKAOpBUHVQPX7sqiXpleEs5Kyf1l0tMbfMqF6tZ3Mw>
    <xmx:sBVnaUMg4MhSpLeurT3NfsXHATNDlgmb0ZfuY3qwGUa-TCtbe-d79Q>
    <xmx:sBVnadFKY9s-3yx79L9wwgieyO1R6cgkO1Wgw1dP6s8xGoXf238OOOkE>
Feedback-ID: ic14149f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 23:03:57 -0500 (EST)
From: Shell Chen <w27@sorz.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Shell Chen <w27@sorz.org>
Subject: [PATCH] Bluetooth: btusb: Add new VID/PID for RTL8852CE
Date: Wed, 14 Jan 2026 15:03:35 +1100
Message-ID: <20260114040335.118108-1-w27@sorz.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add VID:PID 13d3:3612 to the quirks_table.

This ID pair is found in the Realtek RTL8852CE PCIe module
in an ASUS TUF A14 2025 (FA401KM) laptop.

Tested on aforementioned laptop.

The device info from /sys/kernel/debug/usb/devices is listed as below.

T:  Bus=03 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3612 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Signed-off-by: Shell Chen <w27@sorz.org>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 51278a0e4..236701283 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -559,6 +559,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3592), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3612), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe122), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-- 
2.52.0


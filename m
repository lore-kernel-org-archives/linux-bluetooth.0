Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E191C1F22;
	Wed, 11 Dec 2024 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954644; cv=none; b=E/0yYgx9cXwum6t4EDfyZv16I11mmk+9jPea/PcN7HNU4MDbokZpY3nLugl0SJWybQRRRXPfyXrRYLEgMrpD1xg95CxCAmi2e5WayQY45gxKWuq97CRaOCUgsPp97SavA7f69seSkHFFvivLVWzZJdknZijHySg+Ihn8AsmsZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954644; c=relaxed/simple;
	bh=Hv0zWzOQEs6qRg/VUin3ERVsmFe9Y7g3hCYYWIeTv4I=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=ZXjiU4ijq+am27WtUlxMlhbAdO0TEZPjeoTob7NjVXl0piW6Y8lMfDC+zwN5+xAjd+J+vRYISwutyq3VsHIrvvtBpLPYKmyZWyv0UfTLiZwm6zqUDnPZgMypJjadmkzR4NTqe5lK/xZG68lszkZz79wD+2n7AN7FikVpNEm57G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=doridian.net; spf=pass smtp.mailfrom=doridian.net; dkim=pass (2048-bit key) header.d=doridian.net header.i=@doridian.net header.b=KqeM4W7A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vxj92516; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=doridian.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doridian.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doridian.net header.i=@doridian.net header.b="KqeM4W7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vxj92516"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5466111401E2;
	Wed, 11 Dec 2024 17:04:00 -0500 (EST)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-12.internal (MEProxy); Wed, 11 Dec 2024 17:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doridian.net; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1733954640; x=1734041040; bh=QM6eF9GvfG
	SbVYjB4dW/iVwNkGRvMd6wEUj09flznnI=; b=KqeM4W7A2NHOKNYxwe1ChnNK8V
	fDUaX3tXfx8yes2DYCw/SRuPB+cpGSA44S6T6tOx3hYXXinU6aMgJO/mYSkPIXko
	1VDGoRj1N1iwh1dyiTC77lPfPbSmZ5lFqqK1NQr6QeUH164U+mEA4ZKbyNK3JYLe
	ilWv2XTtNxqN2ct+B+QMGFcUi3CPUkHsbeVz6nr1VQrobq4IvsYnJ69WwgEgEv2t
	+qyAyw1vHHLU7PKhz8/4/6CDTaHI19VA3F87Ir/wndTlqpbvEm8SUGQGcDrNADWX
	+hRJAPqr7T4gD0/i+w50hgyRYSc49fKXPpzTaCkm4TQ+bxMEMDo108KMYlkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733954640; x=1734041040; bh=QM6eF9GvfGSbVYjB4dW/iVwNkGRvMd6wEUj
	09flznnI=; b=Vxj92516Sqy2D9Wy5l1V3+6yKPpf/IZAFUa0WoY8ni9tpJckZs+
	TqTmC13Te+4zO/9NGAzf2W/brwr4I3O45pNoGTdtPXC6Ba4udKvo+OG5i7kqZDql
	5nLSGrlXs9vGuWj81iz70xI+l4p2anB9grboSx4AgQcBYqzp6TyWF7SbnA/jGHvj
	fVR2YEv6AfDg5K+XV0l3ZhE7N6bybRGs+8cEiOGGcSIstJQvQhFDbkqchji8cgFW
	SJOR4q/iAupG/tJEghnXZfRTCY8DJ46LP8UcR5H0BJfq1kw5wfZIWsFXCz+4QbHA
	5zRMDPoOnu6BvTcUi6SJOSzzhwUpSL4PPGw==
X-ME-Sender: <xms:UAxaZzu7N4HT6bnyqeGT5Vj8faRr8w_ENk7JaIiCf4ECTnkNPONVSg>
    <xme:UAxaZ0fWSyPUfffTnC7zf6Beq7UioP91PrRkT_I4n-TQanutAz-prxNxxhU2S7aEk
    BuI51pl5yuVaHf_zTc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkffutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhkucffihgvthiivghrfdcu
    oehgihhtseguohhrihguihgrnhdrnhgvtheqnecuggftrfgrthhtvghrnhepkeduveeuhe
    eiiedtuedtiedttdehleefgfetleelgeetledugfethedtjedujeelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithesughorhhiughirg
    hnrdhnvghtpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UAxaZ2xeojxdIVd6bPWEr4m8y_V0o0S5NIyVnZiXl3k3dSnTx3SYIw>
    <xmx:UAxaZyOoaqoVnbEvjeybL5LrnFmfCiEj-bpOgXtdqHfOo2_OQrl97Q>
    <xmx:UAxaZz_NAPlVVqdKKe3TjUs1-53xiZ4H3IxNFPYyrk6t_OwLhPzZjg>
    <xmx:UAxaZyWauBYqwQGblLpt06mbtKNCXWZwD8gjoQtpMGXNUzn4vc6m_Q>
    <xmx:UAxaZ9l0k1v_WMXr5-3W1lRIjHtOqa9mAAgR4keMvaE0hNROVwtHW-NP>
Feedback-ID: ie91947d0:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 169C529C006F; Wed, 11 Dec 2024 17:04:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 14:03:39 -0800
From: "Mark Dietzer" <git@doridian.net>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <85c64500-b6e7-481f-94fe-5d8fa78b008c@app.fastmail.com>
Subject: [PATCH] Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Adds a new entry with VID 0x2c7c and PID 0x0130 to the btusb quirks table as it uses a Qualcomm WCN785x chipset

The device information from /sys/kernel/debug/usb/devices is provided below:
T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=05 Dev#=  7 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=0130 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:  If#= 1 Alt= 7 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  65 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  65 Ivl=1ms

Signed-off-by: Mark Dietzer <git@doridian.net>
---
drivers/bluetooth/btusb.c | 2 ++
1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..20ba8ceff7d1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -377,6 +377,8 @@ static const struct usb_device_id quirks_table[] = {
     BTUSB_WIDEBAND_SPEECH },
{ USB_DEVICE(0x13d3, 0x3623), .driver_info = BTUSB_QCA_WCN6855 |
     BTUSB_WIDEBAND_SPEECH },
+ { USB_DEVICE(0x2c7c, 0x0130), .driver_info = BTUSB_QCA_WCN6855 |
+      BTUSB_WIDEBAND_SPEECH },
 
/* Broadcom BCM2035 */
{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
2.47.1


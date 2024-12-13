Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8943F7E1;
	Fri, 13 Dec 2024 00:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734048211; cv=none; b=iTiGw6DzP5gSRl2VEtzDso0J7in7T9/Vlm7dxx/EKNSP1NGtwXotj/+ulK251PApH/4asHpFr7tRijWBmBfTpLAuBSXCg5quz3U+udF2ICbFd0wz/eX4zd6pxKFxtloVHIm2VXylzbaz1ys88lB36uc1ggq9aGaXzkCWEC53p9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734048211; c=relaxed/simple;
	bh=Lk6f0uzezwahTh8JH7ef4ZHbgva7DIkzzA3sc6WR7U0=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=VDj7L6O+qTIlkff2xqUnDcLb4lS+Ylpuev0X3QtlyA2ewjvUr1GrcvcJpHcIKL1kO/+caBNVFV1jBrErHOchUYXgK06ZJrskxmjeFb84FfSNqhd67s6vHVFTmGWZL2IM4sZPKTjmIFZzEykHogelGeVjVrFTb2evsL/xaEqiHkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=doridian.net; spf=pass smtp.mailfrom=doridian.net; dkim=pass (2048-bit key) header.d=doridian.net header.i=@doridian.net header.b=uo+f+YT6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5Zu30W5S; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=doridian.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doridian.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doridian.net header.i=@doridian.net header.b="uo+f+YT6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5Zu30W5S"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 584DC1140205;
	Thu, 12 Dec 2024 19:03:27 -0500 (EST)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-12.internal (MEProxy); Thu, 12 Dec 2024 19:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doridian.net; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1734048207; x=1734134607; bh=DV5U0ZWSR1
	rohst9/i4ud6oX1W3yQnMrXQx4zizLV7E=; b=uo+f+YT6ySP2DcJCsGO1tc6Wdm
	/m02PE8rzpmBBmaYFTCnX2p4LT0vBB6no4wdz6bCPRLhCDYL8uUG3qJuI64FfvK/
	LLH8zDCIedaOasQbvP6DWEWII3mT8nPlWho8cVuzXQ11qyR23UNohO/SaDPzT5Z9
	ySitZ05cW/szadCynWbzCRDXlrmEhgSKWzCVNwqRPZ1kF13+xDxYb+fr6fK6HhSl
	WNVGOquIdaf1nyIq4Y4cdeP6Tvp/z1oe8RqTmNASoSvupuz2t+ZZfkEsjOrpFV+F
	FWxV5kd4stwtvK7ckQMlJ3v9DTlvsqE69F98BhQDiEusbgT8v7XEz9ZQSwkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734048207; x=1734134607; bh=DV5U0ZWSR1rohst9/i4ud6oX1W3yQnMrXQx
	4zizLV7E=; b=5Zu30W5SoOEZH2HWb2nzq8T1Qrb84RiuLR6102U4EnCQ5F7w6nW
	1zsxLBODN3A7AsI7JvUGzLxbZpEBvJIjbaaCkHHu9MeKn99lL1N3RhKE0kOlbJnb
	RssD+Vtuuxk+xrw5acgyKFhdppY0TJD0+ebD90TlCAA6Nh4B3Ykh0G2Ur7jc8DOv
	wyFiV4GSO7Fb7CkYlDJTOrgAOe5ruQ51ssLpDNt4axycNsV0b243R45kWqBA/Vhf
	oQ69bLFO5uAI0mlVMjp/6Aw5cQNS1f8D6er2MhNZUs75+ZgOEhMr+mlxPtIEjCEu
	UjnhjOwVZf8tDJoYUmj8mc/xmgsR8vGmf4w==
X-ME-Sender: <xms:znlbZ3faqvZffwSj8T0eeDDrKwfCoMynJZOgf1N4rkXNtaHOQiXRhQ>
    <xme:znlbZ9MKsGaHJtOyaEKfHh-SQSieZh6uXolRjKqS3W8i2MD-9gqujOT3sG5fKPu41
    ijHkhTWOAoV92pVQp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    fkufgtgfesthejredtredttdenucfhrhhomhepfdforghrkhcuffhivghtiigvrhdfuceo
    ghhithesughorhhiughirghnrdhnvghtqeenucggtffrrghtthgvrhhnpeekudevueehie
    eitdeutdeitddtheelfefgteelleegteeludfgteehtdejudejleenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtseguohhrihguihgrnh
    drnhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:znlbZwiGks4Q98YVDGbTsVg36dmbl3yBN70PJ-Bif5ux7wdKI7vRYw>
    <xmx:znlbZ4-tEV2ApH2jGxnLEnfkQWWGoYGueFI04bee2kR1gLX7kQsoSA>
    <xmx:znlbZzskjcBLMo7AF8V963ZbEPkXpts6G24WDOvyaNO6LucDTMcMbQ>
    <xmx:znlbZ3EL8NsEWHV09Rpk_-DY0fc7DDfutHc2RkzWU_YEPOkeV8LrEQ>
    <xmx:z3lbZ8U7FfxudOHfX7vBijusmCVPhhVn7EYTsMu75sAu0DeT1J6RRkF_>
Feedback-ID: ie91947d0:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B685529C006F; Thu, 12 Dec 2024 19:03:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Dec 2024 16:02:55 -0800
From: "Mark Dietzer" <git@doridian.net>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <b9a5c3cb-d3d4-4fae-8171-5b8c2ab9744a@app.fastmail.com>
Subject: [PATCH Resend] Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x
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
+	{ USB_DEVICE(0x2c7c, 0x0130), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
2.47.1


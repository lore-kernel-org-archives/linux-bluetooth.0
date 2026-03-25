Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9A399352;
	Wed, 25 Mar 2026 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774481434; cv=none; b=WlMW4pUluHyJFOwzs8D4Izau/k+xD40Ui3iIDZugDbhakuGQB7tGY7xOxweBht/+f1H5bDkNE8soms72/17hG4H1YaY+v0KsU4rrB8Y3n75bnlApc49/5RLV+vdFf08Koqg4ThKcBZH06xXNRHa97aOr8l0cxvHpD7lZhORvghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774481434; c=relaxed/simple;
	bh=ItHosnZu7H1mNrrTRjn4sCIedwANuQwyB1Q8xUanhcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=Z52nqGBRRGa1Ew/BcAWwMjXH5rbIwTY4foTYhU5EIHmlCgxzPeW4Tvo0Smf06y1vrzc2SFGZzs0KcRiIJ7Ok8dTHFGnntYYOkMqUBjCASOXjeeFzTf88KD0kJUHF2UIuLhwkw8Q/Yrc8UxmsakdUGBG0SQ+CFRdu/3qmxu+zdSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=TU2cHLa3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cChGFTfB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="TU2cHLa3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cChGFTfB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CE431D001A0;
	Wed, 25 Mar 2026 19:30:32 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 19:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774481432;
	 x=1774567832; bh=QrjGFY+Gbu6Jc1h5ZG1ncjOCew9qO4k4Nn61N5CYRPo=; b=
	TU2cHLa3m8WHU2OUDYv72DD+/ffl4ygqPBFwGE9Uaw1oWHF4xOcrWEcZ4HZCYcn3
	3JRmZZmC9k7E3Ex5iPf5k31Y+YJ47or+NXOb+L8jc+oeAKOF2tnDrL8mu6Ura6J1
	tlShY+Y2XFxNHh2DUbqHPEm0QzA1C3Gl69xLDhc0dxYNvJDHNwXNNbrtWUQx8U7o
	kjvT/1u73tF4UPAUXiKUwY+BooumYijrTEfmJjACTgoenyNYO1mVeXOyJJcBLcA6
	zzwZQ8Pom6PxrSE8UThRiOo9iW0bkRn8NSB85rbE/mXJpkHYkNAc2ol2Kt2sIqu/
	qI+yhppjwKK9XL64CIfVLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774481432; x=
	1774567832; bh=QrjGFY+Gbu6Jc1h5ZG1ncjOCew9qO4k4Nn61N5CYRPo=; b=c
	ChGFTfBBSIjToEdIBXyhQTHCvfymYOphsgUKXVsp6DfZvQaELuJhDT6JjiM290yw
	jGUuhHzYfCUdxMnnqQSW3YvY2bAJz6qM0jpRMxlAYFMLVWTtmaX2DENRwNh0c3h4
	DoRjhDeuzdn7+5wZw60XOIgpE3H2mIdTgHXR5Xf2lfXt7ZVl/VxBjS9fb0n2x8fm
	oTAV0PRI9hi5hqUX3lMVdmmHN9v/Ybg9zS8EiRGTIjdEhw6DYpDqhC7wn86ukCxM
	2BRS38NGZ2+8ntjJ4uoprvm+oC3v1UnRuTj/PrSjKnYFAqPEaCjA5txIPMswYybU
	KDLd+qrDa15lfxEukTKGA==
X-ME-Sender: <xms:GHDEaenZekK8JCkdu-EIsKMEwQLsAF3IccOsCD3Pn6jC1-n6_ldidw>
    <xme:GHDEaQrycHrcdJ2t88gu7VxdjkdNMeldKpj3vM5is1LIfT4_rzZ6NimPG9NrJ0c9l
    4ijOJOsvLPZeY-erZmn0J_qRJeSm9WcnRSrxm4nKRm_akJjhLZyWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnheptd
    efvdefkedutdejfffhheehfffgfedthfeuieeiteetgedttdfhveefledvkeejnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhm
    vgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdr
    tghomhdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtph
    htthhopehmrghtthhhihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtthhopehm
    rghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmh
    dqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    lhhinhhugidqmhgvughirghtvghksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:GHDEaXDq63niuv2JWDPyiUw_TF9nGG5Y7H6LRrmJarFlJ6ijIFVtcg>
    <xmx:GHDEaScn4CpejSlTxMByFqaHHU-4VbGZgex5hNRjE1CFJ-jRT-AZ_g>
    <xmx:GHDEaW3lERBV6tj1TMkE1NjgMQbkm9dDXn0TJ9eYCnKjpf46niVjxQ>
    <xmx:GHDEaZhT3AONduPILjnujEejfNKWAS-7SKK5GmRW9TZyQ4iiUWhZPg>
    <xmx:GHDEaX8_jdd342aUgphGdvIGE-Bfv9CE9gP1TyHj1aiMRcWJHf5FgMHM>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 479E11EA006B; Wed, 25 Mar 2026 19:30:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 17:30:23 -0600
Subject: [PATCH v2 6/8] Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace
 Max
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-mt7927-bt-support-v2-6-b892a3252880@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=floss@jetm.me;
 h=from:subject:message-id; bh=ItHosnZu7H1mNrrTRjn4sCIedwANuQwyB1Q8xUanhcc=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxHAK42CZnGMcBDam7MSX2y+xCs5BpK+lN7u0F
 cfPcf4yXziJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRwCgAKCRC17sMLqGd3
 H1ogC/wK265DsaIWHFrC39MgIVGgu7z5aFpezekfsJX3o2oPcaHFtSczZ5FanZm5n0jsBDOurC6
 cXQXag8N3XuG33KjdN4q2dqmDS6P9Kk/6ncfdIrhrdDqbbDgOOyCsRzQb/ivDwF1Z/iJhdkE/qb
 MaEIOMazlEoWibTQixDmiNu2dN3/unb7jIAie4owP+UiUbL/uE/Yas3IRPIWZLZ5RdpvkLghnKh
 cWRtO73BuZZJeq8ziZan5BJQB+BMHMb5NZjI0r+ptoUcjoqHSQE9DN7hK5wMYWBExROPlCVTPWI
 E/Wmi4vP/Tj/C7pkSYbZri6eSeMxCLFApMkjcJAvavZmE8XczDmAWiAiCY+wTdG3Ua4O5S21Sxk
 muP6EZCpgf6UTYsOtYFH120h65pQBPNkqe+PID8IEIx9l9sdBl1P7iz2c9TfJqQ3Pf/nbTdTMat
 fWRmVq6im1j82mqpOz+dt5ym+iDTRw7tP9M3mqsoRUC30/X3lwDdHeew+3BYhOOo+VQHY=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me>
References: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me>

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


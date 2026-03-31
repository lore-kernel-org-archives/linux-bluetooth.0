Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5D32E143;
	Tue, 31 Mar 2026 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976991; cv=none; b=AHQ7ddzOGkB4V2yydDXW38NfsmAlQTicK8XiM/Bu7E3d1XyUxYrmqXuqGJvAi+y72h83hV46bTDSTm+UvPXeX4hlCnw6J89gXuZxfzonI54uQCFmqxVOBZA91jylRIcjQllalw2HXlcwoACp8gEc0EM/BXIeYvnjZMZuSjyn/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976991; c=relaxed/simple;
	bh=8NiEFq38NKkFmvwY/mN3CAlXohfffWqUmamDonLVJMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=kRpReRJLZm8z07DVgyshbNhBx9HI9+IkZs8rP7sEPik+Jh4ShGppiTtEJ2J0ZEi0/lWB+znluBuDYy923jRhd66zblP2oMZ2O72xeR8OtF06jqRrnokAZIDJEYdohRA+Vx1gxsQwam4D/eGj0WZoq7G+ZEdrRa6zilQ8rQDxXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=kzUPmCCW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U2a/ojja; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="kzUPmCCW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U2a/ojja"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A3E117A0017;
	Tue, 31 Mar 2026 13:09:46 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 13:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774976986;
	 x=1775063386; bh=nbJpCNzvHJam+rUziHKJZBNyfJWodsXSIZ9h0C856SY=; b=
	kzUPmCCWVl7BV85MKSs0NxCIcj4zFm/L0AZ5kf1k8URQSuO3L6r0VvVpx/p66bWf
	0gbiNRK6znzb628yKCCfc5ueM34e2VACUAhXCnXRzsfmA26KkMr3J/9zhVc0Fled
	5zJE7+tofdGc3tN8yVMM+rqK/F0/v1ppoIAxd/YLUjde2wvUwmLdsM4m+EBdup4b
	OUgw87DMxRCz4D0rdguJj+cJyu/g4c+PewVcI33zMS4LJmztZnVEnEV8a+LxkFpg
	qJXWVQ1UyhKG6KCNHywSWOtBNEqlzgn63kGBxpL7YN+FtqoXyt6Cjj6zGoNBF7bh
	mzJXBN3DoPLShRGCV2123A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774976986; x=
	1775063386; bh=nbJpCNzvHJam+rUziHKJZBNyfJWodsXSIZ9h0C856SY=; b=U
	2a/ojjaJ6Xyg+VYZiQntssxeq6y9CD9NaYBjr+NMQXpm8GkV02tujNCkxz5xD5zp
	KguLjZxOPBo60VUo3fQGC34d9HEB2DVwtHpi+Ee19/4LLrzXj18GpO4ikwRc2XPS
	xDhp5jk2P3iJMIKAO91QQc/mcXaUewPQEGfvBmECeiSg/44VKOlxCeB/sL4NM5Tx
	zPftMfsxOIABM4nWH4GdKLGvx8FBsJsr58KBrdi6vlX+8OgNICKk2fr+nSJ4rg/u
	tE9JnP8kCFe1Xn817j4L3EoVunAq03zCOlztSFfbkzkTduPSCeXtdzvf+KxiZIoN
	+WWpAmbEtkjmSWKW1hO4Q==
X-ME-Sender: <xms:2v_LaWh6mzHME1Y2qtfCeisPDIpmIFWgEXbgxI3VXT9Cp5fD-4kzww>
    <xme:2v_LaR1im7L-Erb7NDyJacsK6NiA1xzxKI0Zd6lGoL6xmG2Vc8T3UBkXuv176bLWV
    FKPBQ0NHdZxnK2Qf31-btfUBE4rpTdz9leRcom5USFGQ7cMTOyy4GM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fohfffufggtgfgkffvvefojghfsehtjeertdertdejnecuhfhrohhmpeflrghvihgvrhcu
    vfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtffrrghtthgvrhhnpedtfedvfe
    ekuddtjeffhfehheffgfeftdfhueeiieetteegtddthfevfeelvdekjeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhhoshhssehjvghtmhdrmhgvpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghngh
    gvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtgho
    mhdprhgtphhtthhopehluhgsnhhinhdrihhvrghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrthht
    hhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhgtvghlsehhoh
    hlthhmrghnnhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlhes
    lhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhmvg
    guihgrthgvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehj
    nhgvthhtohesmhhinhgvihhrohdrihhopdhrtghpthhtoheplhhinhhugidqsghluhgvth
    hoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2v_LaXvdGerFZIhn44KiVucW8peeaSfJX7ItIiSgJdPlcnNO73xp3w>
    <xmx:2v_LaWtV3CNPtSjKWXSsgBiKjKVyTjJTXUcMRCzWLcATIV_grdiG3w>
    <xmx:2v_LaUHEgLkft31KDaSmYPBwLvZQML2CgQP-J4IpwyBb-W2Xa08tGg>
    <xmx:2v_LaZPI9uxRlGWduwBUSuhWq3f5UZBubw1VtvYQqC8ErQFYc0WoQQ>
    <xmx:2v_LaSeQR_DQfc-ZOF4K2OmebWanyRdN_Ux9qcHUV9MWrNvd_0a-9CYC>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5FA701EA006C; Tue, 31 Mar 2026 13:09:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Tue, 31 Mar 2026 11:09:38 -0600
Subject: [PATCH v5 8/8] Bluetooth: btusb: Add MT7927 ID for ASUS X870E /
 ProArt X870E-Creator
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-mt7927-bt-support-v5-8-6f31b4342daa@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>,
 Ivan Lubnin <lubnin.ivan@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495; i=floss@jetm.me;
 h=from:subject:message-id; bh=8NiEFq38NKkFmvwY/mN3CAlXohfffWqUmamDonLVJMo=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpy//LOTqi0MACw6Ubi2CO8Xtrlxq/biBPG46L1
 sg58W1RdNuJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacv/ywAKCRC17sMLqGd3
 H3TAC/4x+9AIpYI+9XZLOd4mAJlusy62eznPfJq8gafwuFNm+m48UNlefkRt0SXMHhKF5e7wRdg
 /z6F3I8r3LYu8mR+wt4gmCcs3K0Vpy33Dn9GMVIagw9cfWzEeiEeUjDj13cqNHUjqNcjNzMPR6/
 6luFgQX2dqMmS0LdMsNJdbQb3AIs43SSj0TrQrBMAJPB4MyDnK33O3TeZDJ1z4qekrs8fxce3R4
 5+NPMdwCw7jpucVAEMtS7AgS4yFE+yvGuCvoPvcA90lJn+cRn149uZN3P4joqAVmgVBcdKFb9yO
 ZZZlm9ZJCvpUHlFclEhc7ezXb2eWp9OY5aj8nznbQWVyQ2uE404IVKjavHZbjR2el9O+IFlFIfF
 +SiHGDeezmXtn5tQgcLrs141R6J6cT05Sphm8lFSbC+31SoA5v6NIjvBZwhGWTcYKp/z1LkBKWl
 gcUS0uwWFcA79OmNg34BZreoIB+6OAhdMGUeHhUMIlGJJJKdJDC2Sa46j7M6/NdFuzxaE=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>
References: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>

Add USB device ID 13d3:3588 (IMC Networks/Azurewave) for the MediaTek
MT7927 (Filogic 380) Bluetooth interface found on the ASUS ROG STRIX
X870E-E GAMING WIFI and ASUS ProArt X870E-Creator WiFi motherboards.

Note: boards with this USB ID expose only one ISO alternate setting
(alt 0). Without the fix in patch 2/8 ("btmtk: fix ISO interface
setup for single alt setting"), this caused ~19 second initialization
delays. With the fix applied, initialization completes in ~2.6
seconds.

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


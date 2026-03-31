Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5731B10B;
	Tue, 31 Mar 2026 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976984; cv=none; b=D4W+XPyAY4788V3/19pVuVrNZ8eJbYjFz3HatOjup+nAfqTI5e43smm7Zc+IoteeZg0eAzl9Am8+O4S/6h3jctE169Sf9JUHkw6UREGyuhpro63oHO+MnQCzpx7SNLSQf871Cl8NUovsHCDl4fSdXayPaeLIao7doURs8ysL6OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976984; c=relaxed/simple;
	bh=9VC/j/XdBMGnjdaMjoJsd1+eJl2LQOX2dwL92kQTdgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=IkuDvfs2u3t62872enf3jFVm7JKG9/GL7lOIeVU2o/OegvsDkI3b7jSTHdDOJdGXtgnsidVR1+c763oeZFYCBAViX8wmxEOOG9v5lC/lfVsL6NV1q8fMCXQLkz5n3qvxusBmzVUj1wLaHPpHcowcSImqex1f0aoKozkRaE37MyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=G8tPB2Q2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kiI5ZKT7; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="G8tPB2Q2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kiI5ZKT7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1397F7A0204;
	Tue, 31 Mar 2026 13:09:40 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 13:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774976979;
	 x=1775063379; bh=bpy+NjFmQ1UZzVo0QwIuf1cqhqfKorIEk2o2QMNh51g=; b=
	G8tPB2Q2LczRwKjSvJ4gGvtSA0vwr6AwC1OrUOvE4jaXDWBYLV8zeP/e6Sr3sTlx
	fEm49iSWKFxSrl1lR6VsZkA6cyy9w2lnbyEnfBX712UrI8TnVWdjTMjTm/G2+KY/
	JslsH8/1EktT4C4LgEUuc2fP3KgiD9oWmYiXXQ85n93WhCO5gNuH4W4gjt/607Tw
	NNK7Qziw7Jh4JB8bYlIvPTKpheOQMFLBCyPdROtRT68pabaQ3XbjlQxBo6m5dCgo
	crNvGePGzcQwBNv8gutMkxezHj3B4+z4Lp0bYqQNa54cuVLXVb6i2kyOx9XeuXsW
	rQPB2i/IP9BEeNMhk3A4rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774976979; x=
	1775063379; bh=bpy+NjFmQ1UZzVo0QwIuf1cqhqfKorIEk2o2QMNh51g=; b=k
	iI5ZKT7XZrt8TZI5z8o6X2OJZTPA4OB2gXXbbMfCphBVkvN1gQWTeX4PD1R4Ilgy
	N1NxnSZj3il5OEZ0fB9/3KeR/wjqRIza9qxDiHGP9QFtJGTc5T/EgyaOEHpQ5P7N
	JrLtbo1r6IB2X5Cc1nsLI3GokphoLHdXw98JYMKJOsapzSOK0CCh+xCsI0lhLHAM
	HRvBK8CJlXvNrOosuUMmuReYAdzMS8D6YMKdT35pOOo7tyEW1TpgsPqXk+1SE7/7
	tBPn8uW86y1Crg23qf+/NqhblWNcyfRYW6qHTg76t8W2Hi/R71CNDSA9RXzY2QHO
	u7sRgXc+mFuwQ83JSljNA==
X-ME-Sender: <xms:0__LaWOwHbNj0HYsH6rWlzjA6e9YIARzVO-ghUBRuSZYtQs1QoR8gg>
    <xme:0__Lafzf70CJGz8mJn_eHL-3UEUVvCPNTnaWKQqlRUGJluFdvU23oGHW_7-Vvpz-j
    IkEYZ0K54al9esr8GCAGRaSR0rtDccKExsllaC4E86mJYjJWSXa6fQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fohfffufggtgfgkffvvefojghfsehtjeertdertdejnecuhfhrohhmpeflrghvihgvrhcu
    vfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtffrrghtthgvrhhnpedtfedvfe
    ekuddtjeffhfehheffgfeftdfhueeiieetteegtddthfevfeelvdekjeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhhoshhssehjvghtmhdrmhgvpdhn
    sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhgvg
    hlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhm
    pdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epmhgrthhthhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvlhhi
    nhhkohdvtddtfeesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrtggvlheshhholh
    htmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehl
    ihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqmhgvug
    hirghtvghksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0__LaRtvlvplrBXEr9R9miIvAxu_TVn1pTjMCGP2U9rifckRi3XZ2A>
    <xmx:0__LadiROOExOhc-H3V1-9sSZ4igemUb-JNJ2ST0iAcCmWmSugt10w>
    <xmx:0__LafYAXNdvBczahLjtcRAnsg140jeoARqc71Dzg_WHVY6nvErYRw>
    <xmx:0__LaUbk02pt_w6UdLZWja5t2ItJugKZyWqsEEvybfprNy_rmziMgw>
    <xmx:0__LacKczpAJCbnpZ7yLvUtQfqgYDS8LtPYv-WpctTWHceQt9Hf-Dee0>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C37641EA006B; Tue, 31 Mar 2026 13:09:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Tue, 31 Mar 2026 11:09:34 -0600
Subject: [PATCH v5 4/8] Bluetooth: btusb: Add MT7927 ID for Lenovo Legion
 Pro 7 16ARX9
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-mt7927-bt-support-v5-4-6f31b4342daa@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Llewellyn Curran <melinko2003@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=floss@jetm.me;
 h=from:subject:message-id; bh=9VC/j/XdBMGnjdaMjoJsd1+eJl2LQOX2dwL92kQTdgA=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpy//KSBzZgcsjrmG5RLREEW9KGZl8f3ot1EOxJ
 100uWsvw/qJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacv/ygAKCRC17sMLqGd3
 H8YrC/wIAw1iEXpaRXl5lMdwK8SfyMTu/SwbxLz7w6mZ5TZZxZrgG6pn5tqTFCHwCAV16p/Hg5W
 jAclwBHOZo+etgMddOyY6gSkh0EYRmBHcFae2Wjj0GiI3ykTTJm0g36UDMpl7g6y4aSDdgdFCVD
 8oUE554Vzf2ogwP0MJPGuVuwvI5gkdAHSADGsqet33J4Z9Te9yGckTcqaRQS6xtvSiaPnGcvu5G
 QI0h4hTKCQovKQKjtpWNzMh1vWGqqsA3SdgjQM+tLUy0XwHQQVZJHO80GdgHk3zXkVHWnKDfMEj
 NE+23sbFNjjSvEgMGcpR6eEFKzrZIrWAL66c3wqyv0VUUG1fJGKdkCmxfcI13IJLdbo6EUO5Pnd
 G9aZtGlZrzSqfoznAOnHLXaxH8pHrde2D6etFBz0LEUkcgAA+JO1kU1ZSCZG/XXgmWir7SRkm2S
 Fd2RK+Z7YvWXVqx7GjiIosJvbJ9enC7ZEwNoOzFB4XDnSU3mxy1qu0tZa8e1sqz2lunYo=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>
References: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>

Add USB device ID 0489:e0fa (Foxconn/Hon Hai) for the MediaTek MT7927
(Filogic 380) Bluetooth interface found on the Lenovo Legion Pro 7
16ARX9 laptop.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=04 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e0fa Rev= 1.00
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
Tested-by: Llewellyn Curran <melinko2003@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 58309af0f7a2..2c9ca3d6016b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -753,6 +753,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe13a), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe0fa), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14e), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14f), .driver_info = BTUSB_MEDIATEK |

-- 
2.53.0


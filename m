Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0103A3A0B1C;
	Wed, 25 Mar 2026 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774481436; cv=none; b=jF+uh13syfNs1lAi+1YpipjhrvpvjjPDq6GKDAMnAXekjPyMiTc4JlwI+QhLxa8vN0shEwXcwZpR+D09fc8WNzrfz41Ho9g1iaKNhi62VrZ3cs4KsM1JDVM7t3BZIpgOl34xIUVTdd0GMb3xrp8/SVk7yJzhA5cKNgvv3b1TERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774481436; c=relaxed/simple;
	bh=0X9iYzgDtL2noTXAFbHuUBjE+Gu6Hwn5WtC2t2VD+ZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=StnTdW3jQAETPtSyBS6A+q2OtupHZ6dmVFCeCyCoHBnt54Qt8++COWbMA4NskQENwbF9/QcbBe0pQ0V0gp/RuBLsU/D22HrNELtNec9f5sN1lZ20C4glHKG0kErlrZcUo4I12TQiwzMmrMd2FjClN97QJRliquBiu6wcqX6VYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=fWqVVJ0x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZD4imEN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="fWqVVJ0x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZD4imEN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3AD7B1D000E8;
	Wed, 25 Mar 2026 19:30:34 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 19:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774481434;
	 x=1774567834; bh=OKYvgQ1t1lSRkNHRJOJY5btuo/K6VYFBYLipl68nHhQ=; b=
	fWqVVJ0xIurQcpvGrfZaxuG6DSr5lWBn24El2lYP6MSmYScS5qTXrpg/kZBJL0uq
	LdDugbmx9iwQxtusu6IV6wQh9l526BD9AJuSGWrT3xJPiTPucReqhAFq3WGJA7Qx
	Oe+OGgCwhAhJXwkcAHiXVLM4xRv23NI+Qg41mS5CGIs34JnxAKrKbLsYTx4t48hn
	VyJSpFxTAJRJUfpc605i/V/aGqYSqUM5Lmg7AMvAhfoBrO5HHHOPKxhhTBgZeO8t
	TG16Gxk9Emgy/EwGra8KvcneYJr7zLzu9n/p3fFXNyfxQRppI6VeUx1p6Kk6pj6T
	1Mu5CX9mcJ8KihNBG0hl8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774481434; x=
	1774567834; bh=OKYvgQ1t1lSRkNHRJOJY5btuo/K6VYFBYLipl68nHhQ=; b=B
	ZD4imENqwA1VPttmKlmRzrvc7WMo8RdmF/zukGDOJQScXVNqfA3PFFLHkeQtrsN2
	dT+kg6+8w+xhwgLYxbMEN3LwZfObRGt4g5v0sf3I/aJJsbfjVlttLIRPtFjay8nw
	kczWaO7eSz5OSdNfav5B11UP6KSmMuZD49mRSZf49ha3QehBSfKxKTSszSQip+tf
	k9/aDNbQnmXql+aFdSWRNytQVFVTHLQAXhppzmQiNBD4HRmYK03NdQd4kl7IDqmF
	BmucUfAVlfrtGB+mT6PIWulBV620RxIgE3QYN6Qk5t+5oVmx5569VRxYGvnXoVX0
	qqnO0n8foq7VZjeFYMKvA==
X-ME-Sender: <xms:GXDEacHzjwPRPRj_KybFArObK3X5DFP_pty2kLepehoKjPsDFkqRnw>
    <xme:GXDEaQIDxcgz84Q5VLewX0fiPtFR6O2cKLB_b6hYDY9qjZigguncdltgeFesEQnuk
    4B84XYH7hadqEPEJyWor4Wa3Ln_yUNSiL2fFTVUddGF6cQ073bR6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnheptd
    efvdefkedutdejfffhheehfffgfedthfeuieeiteetgedttdfhveefledvkeejnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhm
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
X-ME-Proxy: <xmx:GXDEaXlA7ripNOlXyNOsKb3afFg-IbhxXPQyTSEHXtGs1_ogiHLfdg>
    <xmx:GnDEad4qX1l5viqPfUJAEJ82b3BSpm-T76_Vnc5_7zE0MIFl29lmsw>
    <xmx:GnDEaYSMzvKCWy9ZiplSD4ziTCbQ2WUZKIgnMu510oedgEFdijKRIQ>
    <xmx:GnDEabzj4s6FyRJO4TVxAtSUpUydpO2ZpBMn19RXHEiis8Wea1v1CQ>
    <xmx:GnDEaYvMUHpGMIYkA6bPvS6ZbdtQpv6DC4gO4kEGmBo8SbVQ68QvThf_>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D9D1B1EA006B; Wed, 25 Mar 2026 19:30:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 17:30:24 -0600
Subject: [PATCH v2 7/8] Bluetooth: btusb: Add MT7927 ID for TP-Link Archer
 TBE550E
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-mt7927-bt-support-v2-7-b892a3252880@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Thibaut FRANCOIS <tibo@humeurlibre.fr>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=floss@jetm.me;
 h=from:subject:message-id; bh=0X9iYzgDtL2noTXAFbHuUBjE+Gu6Hwn5WtC2t2VD+ZU=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxHAK/yFnvCgToj8LUUt6cGYPVj9MteEYTZQvp
 ea4KfYu/wqJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRwCgAKCRC17sMLqGd3
 H84mC/0U2Z7HaeetMr1JEN47MWOYa9tO3QykcE3JuLDW6tBkhYV+yevOZ7PkdPqehtPYXriJf28
 MdE7EaqbOwFDLVwt5/Cc3p4sPxRTwudEZjPmchA90nOXZpThW2hJv8fLmS7mPn4GfyHf96RcNFH
 Cce8FZ4zL+0zrzMoPyc5rib3CT10nlAuFfLXJjBuRm1dYydP3sV2RnNPD4PVzI0o5R2CygINYxH
 itq7AAVOjK2f6tXLaXhYnj3qc/8qWDSixj5FyTuvd2q9w0xeC14Og03ohLRyTNNEHyBKIP0Rw7/
 C8HxqgahfUMp/0RGBOg3hB6jyWlyLRy8LH3DaJ/RrlhNtGMrBHp+7OQnXVK0EkM12XSq6KlSycC
 gX/HevQeem1m5eo71bYV4KW3dV6bNyX8KdtOFNYbgqsQqBVO4fJi0nUT8Djac159IDBTC7pKAAB
 qdov0aFXdX+b43P6oa6xmN4TZKB4VGSJeX5oLnzD1GYTb/QxUmM/9P1w8xPY76gODWfQA=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me>
References: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me>

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


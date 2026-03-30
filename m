Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A9639EF2B;
	Mon, 30 Mar 2026 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903181; cv=none; b=QQNdkujLjkbRwZw8cuaO7JCmIOgSoL+PJ4o2QWW6MuvrCDvvsQsUFBUE2piouBMCtbaXz2GbeHXjs+GVYbAk09sMrbBRQJljtx+KOPwgGCdV4iKS94+GhbVhpG24TtqxaaRoOuoZt+dsLdKwxd2U3R3A7/alpRyYMNVNkJBUoa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903181; c=relaxed/simple;
	bh=em1RqiSQd0riysmowuL1VUyKfo405wv/OJvCy5th3/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=XgS9YYBDeGTKy8EffHQgXjgdOQbm5RoaeV8+EceJCUaY3yirterABMg77hojV5lUa4OO0mZe5VbG5iSQoZ5jWtq8qpTNSCiUIfbV5hD4h0aX7D3b2QjyuymU04uE/aS9x1M05qlcmyWP9S8CAq/IPyBl35HWVhUPfKcnaQHntSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=LTUDoagH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T+aukxX9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="LTUDoagH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T+aukxX9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A41EAEC026F;
	Mon, 30 Mar 2026 16:39:34 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 16:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774903174;
	 x=1774989574; bh=yOxP62o7cM1WT3zP9+AmG5fhiGJNqhZB89OLn2KAGlw=; b=
	LTUDoagH6VkIJIpADs7Jla/zgC+W5TN8vhTU2XFDCV8Hs6IPWz+tMR2nereYD+Yc
	xJ5gqy2ygF3U5FuIcTa1ToDDMKbx/Nh6xLi7rhVm8SWmEaIRqW1Nd0jBE4v9mnxe
	SmjnJE7LL7zgwYBf+nYFLae8MttC5VBuHRxid2PFkp3S9RY0iA+mb4xjrocnhKuD
	GruVuowimV40NlcxtiN8R4FwnUHFSMo6Gzt5yUFGsRUEB8qyAjXLn1ocDaeoX9zJ
	eR1ZFMU+l0NgS99iJxth58E137U5i98IdTbTGauhE1oO39IXhD4ruJ8OjxL9juHd
	wdmSTedrdMYpf6Y8oLc5SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774903174; x=
	1774989574; bh=yOxP62o7cM1WT3zP9+AmG5fhiGJNqhZB89OLn2KAGlw=; b=T
	+aukxX9qy6Abviq/fECn3aBFx8c/j29XaL/YD/sJagO3l49D3aE392u4XNg0Y7rd
	wdal7GQAcU5EaClKVeeau8Q2DVgvKdba9Vn1rIVB11W69k1q4M/H8lL/1Iz/YYOp
	dT5DKz7T7D4UysE1/8uWeBAayDw4JazPjXmVZcc6bFd/KW6TGFT6LplF6LWjDmgD
	n5kIjpa5N5mJfEGT6BzN571Ue3PMF1eyALuzTvPvXhaEg8bL5uSZwnm5hbzk9Qas
	as/Nxpyrjz5WXG9ZAeWIT20q+60J7YNMSVl0pzpRv4UFDQCNMBEvqT0qX5qIlMDn
	mOIi2Xw5VqIAc4Nwlyesg==
X-ME-Sender: <xms:ht_KaYjiq4HbyAOZvgZE0pdEg3Dd49UjaNNZ9-FtR8d2GyqVGRjSQg>
    <xme:ht_Kab13pER7VLPLTU7oSc0WfgORqGtqL7RYh_JsR0oU_ToAXay1gX698Erjxj4-n
    wtBwkRHOnBse_VvQwxiyd139GuBFoQ5oX7D1cYiHdo_1l6ntOnGR2TE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnheptd
    efvdefkedutdejfffhheehfffgfedthfeuieeiteetgedttdfhveefledvkeejnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhm
    vgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    grnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgr
    rdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdprhgtphhtth
    hopegthhgrphhuihhsuggrrhhiohegsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhu
    ihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrthhthhhirghsrd
    gsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhgtvghlsehhohhlthhmrghn
    nhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtsh
    drihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhmvgguihgrthgv
    kheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqd
    gslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ht_KaZsk6LIhXjFAGkbaUl1ZKcKnVct3xghf8LJ7f5CG6LLGBihACQ>
    <xmx:ht_KaQteF0kq7QPNlALMtbyLHHpbqMje0JEgNXNXLHtqKFAWd0ovWg>
    <xmx:ht_KaWEw41DwjMi68XZI8YxjtGY3TDou9FcnUvj3wn3tpaAlrQcnZg>
    <xmx:ht_KaTOSgzzvEGAFkTDcYnfnqNsYpt3NTEqQWJy1IPBNh4XjKW-2Kg>
    <xmx:ht_KadhgBVqKHOO6dOnG3pvqwtmVHJSbUI-SCQsyU_nKlPPTX6VPkn47>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7E4531EA006B; Mon, 30 Mar 2026 16:39:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Mon, 30 Mar 2026 14:39:27 -0600
Subject: [PATCH v4 5/8] Bluetooth: btusb: Add MT7927 ID for Gigabyte Z790
 AORUS MASTER X
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mt7927-bt-support-v4-5-cecc025e7062@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Chapuis Dario <chapuisdario4@gmail.com>, Evgeny Kapusta <3193631@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229; i=floss@jetm.me;
 h=from:subject:message-id; bh=em1RqiSQd0riysmowuL1VUyKfo405wv/OJvCy5th3/Q=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpyt97MKgIx4cXnY3eqzf8uMUUC446fCf8n1tcF
 2pAPhYzX/uJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacrfewAKCRC17sMLqGd3
 H+4WC/9kZvO0/+QQloBtSzCPc/4zjIp1506hnohXVFYAXe9NV3ri0hD/7IRuG6zbyG3G8xdkxAE
 IH9KyyVsUpMzXuFmh+/w99XxqfHpSdbyNOYRru+PIqiY0gh9SnLKzb8/J8v1G00xsnM47e/O3tG
 X3Hb6I1n4jBSB9WXpDu7k6lvxleEThQA5Hv+/euQsF4TEdMNvpOzqxlc7qapH695JSlzdrGCuOU
 XlEV/ta4vMyE/7UFlQ6d0jDIyuQ89PiQtYlyps6Axonzlo2Q24yN5Isgo823w4uK+BJBD89zZVW
 NKfr8dvDZONRVvoi2/GeP0as0GWbD1KAND1vDH+lkcxNbrtPyyeSqgbmFut1R6hKb5HH9uT6X5c
 ZN4YmbbkshBn1z8zvNyelHQfTWqlRZE23IsE6L1KF/l80yFgy7UrZNlDb3BCcC1CwiyNLG6T3pN
 4XQq3Zlpqjh0X5tn9f1VF6gctjgWV/wP7iMZzm9X+TjGmMSbN9a2oWoONH89pONUUIhAA=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>
References: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>

Add USB device ID 0489:e10f (Foxconn/Hon Hai) for the MediaTek MT7927
(Filogic 380) Bluetooth interface found on the Gigabyte Z790 AORUS
MASTER X motherboard.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=04 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e10f Rev= 1.00
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
Tested-by: Chapuis Dario <chapuisdario4@gmail.com>
Tested-by: Evgeny Kapusta <3193631@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2c9ca3d6016b..d60798331bb3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -755,6 +755,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0fa), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe10f), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14e), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe14f), .driver_info = BTUSB_MEDIATEK |

-- 
2.53.0


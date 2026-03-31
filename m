Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9931E846;
	Tue, 31 Mar 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976982; cv=none; b=ZfKdaEbrDRoi/f6k09bOWzpZfhZFC0Kwt9x8r4/fTZi0Zr8PGaovVS0UG40NFCxMSsUhUKPRbQPvSugR5v8sLdZ3U4H2p9rWzRWjvZi/Vh5a3Hoj5Op7x5PoHrhJYDEqm+MQAyYpXw4DOwxbQzxxM/MPzZ7LL97/qA9dyupBKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976982; c=relaxed/simple;
	bh=M/B2rUsIc9XPtt7O3AdFVlNy7Muc9x3nvF7epwhHRKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=CDWvRlBgwyw3iwtnAb4aPwSXkOsslA24rNaqG8P24sSfsesQztYuOdgq664TUpT1Cc/4lb/yTPYKCOc+Edu6b8CjNBkHAiRXbMH26F11fLd96qG7rBvT08yzUQIVVV6d9MA84HfVgSoYp49eODEtEMvQCXG1Nth5QTWvaPOxuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=j+S8Zylj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UMpUUybm; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="j+S8Zylj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UMpUUybm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 87E9C1D001A8;
	Tue, 31 Mar 2026 13:09:38 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 13:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774976978;
	 x=1775063378; bh=2qHp84u4lfDr+6YeO86QEXq5X1hXYtGUt81s2Al/O8Q=; b=
	j+S8ZyljEFCXScF/pjiDMer+ZJt4LGBRY7uH0MA7/jEz4FGxy+WY4Nbr+1Rit8iP
	huZTHWhr8NV0+R2L5wrhGaE1BUouji+PNnC/AN4EhcwnuFxPyh0OUpPuKo1UXsEi
	Kc6fJlLHjuFAdyfx7FnyhY4lOKE0Ml7dYt5vHy3fvSDe6NyHbgiU0RK3LGP8BfKI
	w30gnL+Pm/xI5IlVYU9NWbD3klQe4X5h/ApcL+pyrnz809MS5XmTcAoxVqe4b4u3
	77GSxagnULChjun7zdkbOz2uLU9xmkGblU+2C0NW5nDp552WM1FRWa0Bkgiah3xB
	kQ/o5okBw0PEFqqVcUvMww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774976978; x=
	1775063378; bh=2qHp84u4lfDr+6YeO86QEXq5X1hXYtGUt81s2Al/O8Q=; b=U
	MpUUybmZXgGjzEhql0LOpUI/0T15Q304lc7cRG6/SEiykyzrpZgeu7/89Lzf1EfV
	JqVVHl0rm+kIntLhaoO2ZS9QnJHl+6B8hoVzP8UVHHYtP766CLGzq0GTHBdTX6dH
	hutxO6de45Nad59UR7K4khSy3kgEhYiXqhIbwHqov9zVIuhAI2pQWhlTzoPG61mz
	TAMQLbnVO07THCOYvnKh0UGn9GEmPp+9fOxUKlpit4iY5M1gk86KMkxZkvI8hRWF
	HZvoaaPxoBwQtYG+UCGH3glNTojH2IQpfgOFTIEx3DoRADDesvWAQIbirUz2jDmF
	Ab93yNL8lbkd6APJl7ICA==
X-ME-Sender: <xms:0v_LaVv3MJO86wApBvBvwEOto64V3CKQGBbcTuTmzZ6xwwXaq7ejNg>
    <xme:0v_LaZTnh3f_QaaWP-HdMb1k1aIy1SpMGi3NODI5b0MJaya9g-4r5wSfa1T6opSp_
    V0wZaG3b6GO94GmBjHO9pyBh_oE21bdvHlRI1ylAODdv8rRJ6sJKBg>
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
    epmhgrthhthhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhgt
    vghlsehhohhlthhmrghnnhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvg
    hrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhmvgguihgrthgvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtph
    htthhopehjnhgvthhtohesmhhinhgvihhrohdrihhopdhrtghpthhtoheplhhinhhugidq
    sghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0v_LaRNu1VBuW_b74VECixpJl3UR0qbz9Z2tRTdVzLAmKb3gw_8vGw>
    <xmx:0v_LaXDxvU8S-bL9tMNM7IJYpHJCSh2yqzMzVsFZrklWFFfs_jOLZQ>
    <xmx:0v_Laa5EKKpO8cOk5m8S61je--35fjGBzwh_0zrCRJVt6w7YLq7gwg>
    <xmx:0v_LaZ4JRK4bif5Tv7DSH2B-CAkB3hzKtVxj1a8IMe82xBlACzoBFw>
    <xmx:0v_LafZrWSdq5a7YqFZzM2zOb_iOJzac94pMipGfU5L2iHCw6GIFO_Na>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 045011EA006B; Tue, 31 Mar 2026 13:09:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Tue, 31 Mar 2026 11:09:33 -0600
Subject: [PATCH v5 3/8] Bluetooth: btusb: Add MT7927 ID for ASUS ROG
 Crosshair X870E Hero
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-mt7927-bt-support-v5-3-6f31b4342daa@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2196; i=floss@jetm.me;
 h=from:subject:message-id; bh=M/B2rUsIc9XPtt7O3AdFVlNy7Muc9x3nvF7epwhHRKU=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpy//Ky/9oCYbDWTNjcE9EF4FH9rQkOLrp1U1FF
 WGH4BjcAGqJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacv/ygAKCRC17sMLqGd3
 H5gwC/9r20l07KbZ8Qg8sRl6KSux+U3xfFk/mYC7diGYFOL9o4epKop6ZkpLAJZ6OCLaV+aer6u
 sl/z5DM4Mi7svWOL39yxpw3eq+e5TGN6QdmuVCbktRNzNyyE0dD6E/YKIL+ezwCRTB3sE+TueZ1
 vabOdSd/xjWk44AuyEHU32If8+y6ymkOxsbuOd4IYIGMVtHP1NyhyC2gm7maLJkLnHWNi7I8P3t
 0C0AF+sNvAZ4B10rhcvW5nXJ9Mp6HFxuYewaZDvv/fIh1DkEXlkXoXS+lVuSfXgBsR5rWoUVfex
 QEFuGkeeHqzDBxyBbjYVdw/0qjyKpoPFOfDTE8ammOXb9wHX2L8eD4BcsrHjC6ghhrZO7L9kzrs
 +4YOy2qy2yRXDPW0RZkGiLATBTeD6btIGt0rnbdZUZBogyYi7hoO/Yidb4oPJkALkoNKb1pGF3T
 9OOSIZzocnJrp33UW3spr0ktdCrm/JdMl4he/vxG8kYt2EVxhE1EZo4CxA4Iy7uWXVIhs=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>
References: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>

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


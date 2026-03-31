Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCCB31E824;
	Tue, 31 Mar 2026 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976988; cv=none; b=YMVnhg8bVU0SyRmanbVsmAY1PsebbV8vWVMmmK18En8x3fWhJpfzs53zpawv0cUBctKhLai/niI1TVmMvj4eUAwEji8wouaQ2+Bm9sk6C0nRYrmN0TDtrq+qs+DbnHBegXsDmp9mpv0ppq0RA+5U+9KM6nH5NPLVhnpUPRjNmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976988; c=relaxed/simple;
	bh=oX9RcQEWF2VJoE6RgvKmZHprs09/2hbUA9uGu4FFREs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=Bc2+cz/FaGapUu1bg2GwuuAPyQ1rkS6lCGc7QeTHq9lGUy71vbmxQNugjBAI82YTKOSHsAvl7J2ZuZMQeCCTXr7oQS0BRqLHPBGdMQWOXQwJjE7toy/xrSWZ5jf26zErG0zWWbbs+ffua7CTKNEM2l7yYefxISjCRQ48/W0rg4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=R2mL6ZaL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fNjvAqUN; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="R2mL6ZaL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fNjvAqUN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED0C27A0220;
	Tue, 31 Mar 2026 13:09:43 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 13:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774976983;
	 x=1775063383; bh=kQJQrCceeT3vdLIN7zWnldzYwpMDL1GuLvYlQTM7xZE=; b=
	R2mL6ZaLZJ1fwzHToTZDRpAKUJ/+41V26TOrvztPyoKvRjjuCIzzkoB/M7h28umV
	QyZyT2OYMgDkmamillAyC23au4REP0G5GDnmGOBlsYt5DcnUHNhhY+xl6hNgW/3N
	9Aad2qP+POHS9fndREbrrfel0K71nO0JHXCZVMb1+vibBP7Fvd6ZP8IKTL2v1l/L
	x76yYW7LI/eE8yzx9eEirtPmpDkomfbG/wA6RCsz6Aoc2vskGcMY50aUJtbZhEbB
	9jDJuEemKAhjEVFHKgXT7K9Rrf4WT4cJGaiL408MIVhlDwfmRlaXCTzwavwZsXn6
	MVol1K748XcZMY6kQ6apXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774976983; x=
	1775063383; bh=kQJQrCceeT3vdLIN7zWnldzYwpMDL1GuLvYlQTM7xZE=; b=f
	NjvAqUNzdjhlAZ3ne5ew4h2BymB70lAyyV/J2q9aNF+FF1HYTDfpNk02Gw9ZOtzn
	2XyMGX8eBdkNRQx437QXe9/aiTFEz514WIv8dvwLORcxTRK5F1nJAKsWC0PZcplR
	fQqCecHtut/GUmETJOT9Ctxpazmfc4wIcrjvtY7ezPXkAkB1Hj8s8ajflI6/XO0u
	UKDKc7NS6RBbEPpCxpGEcmhwbZkBB4Igki3ohzKlQzOO9M/hyPF0eFT3K3FVE2dL
	o8bayIeBRsNiqwDRAWgnq7399LqItBrVYn8uKnqbLXm9XJiCpS+9whw8EoXRPvge
	SNpdl9GrKH/HwlkRiVDcQ==
X-ME-Sender: <xms:1__LaVhXKxr90CVXBD_lBc2uz5MyhiG0qeTJe1mUOf2I77FuijV3ug>
    <xme:1__LaU0UnMUlK_UcMBpmgNDAPx4KJN0fdpXu5OB9mTTxTO86_CSskkIQ5rgdnVzAk
    Li5m71gOqgw99DWS91LTCFMg_HHgqJDkUoNM6gmc9cHvmxoqH3qS8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fohfffufggtgfgkffvvefojghfsehtjeertdertdejnecuhfhrohhmpeflrghvihgvrhcu
    vfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtffrrghtthgvrhhnpedtfedvfe
    ekuddtjeffhfehheffgfeftdfhueeiieetteegtddthfevfeelvdekjeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhhoshhssehjvghtmhdrmhgvpdhn
    sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhgvg
    hlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhm
    pdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epmhgrthhthhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhithhi
    nhdrrhgvugguhiekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrtggvlheshh
    holhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghl
    sehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqmh
    gvughirghtvghksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    lhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1__LaRCTtCNmwkCOH4z3vmoKj4zj0hox5pCeFjAg2dONhr_13ugAiA>
    <xmx:1__LaSn_NxP3NhSxAC3sdBttVDIMUUauCozDycaAv2jSQPpRekBTnQ>
    <xmx:1__LaXNSAKI5g9oodmpt3MggEFHHVBOyz_vGOnRiXg6-lqX5XkMyVA>
    <xmx:1__LaX_kPNkv1E2Y10A29eOSuH_lOKnrXHUF48VaGmLBXsGVfz_9AQ>
    <xmx:1__Laf9uJz7Lcw__scZ9D8L55oNzNqEJSLflTVgARf6MNLuajx3yQiVK>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0AE5A1EA006B; Tue, 31 Mar 2026 13:09:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Tue, 31 Mar 2026 11:09:36 -0600
Subject: [PATCH v5 6/8] Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace
 Max
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-mt7927-bt-support-v5-6-6f31b4342daa@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Nitin Gurram <nitin.reddy88@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2170; i=floss@jetm.me;
 h=from:subject:message-id; bh=oX9RcQEWF2VJoE6RgvKmZHprs09/2hbUA9uGu4FFREs=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpy//K5Hh+xH9Lca7ABRd9LW3lECg1KIcry2COq
 vy/bNQDLymJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacv/ygAKCRC17sMLqGd3
 H43NC/9dxAA2Dpl66RUSx0Psnfho7VkbaxLNfZXrjWoooYk0Y6JepRlwKZic8EPs+auzcyO0OqG
 PJ1/RGYnr4bd6BZ37jo0EmMVnfo1aYsE8HUdVWJ2HTbrM6h2y9aPNI9owkQGj8qd5jM8B0bmOxQ
 APjwZcz35gRmUtummhjqaISb6jo50mafnRz27sj5Pz1DTFR8VkMF0VZO46tcLo/trK/IKtc1MXF
 vX4a5Hd+jZDR7XOlx5E9nlNZYCjbYHqR3npyx/uhoOD1TlbmFoUKExALSl7q2JUt9Pi3EPLG/5+
 iqKwH0RU2UDelcnkvrm8i1BcmCIq9Dv33AlesM1UFZ+2Ucj/U5E1yoATyXlpLJgIvA94LBS53TW
 UC79j/Emc+FEuMRMhjbCueOdbYq2izRX02TlfUPFbj0Lzup0GzyurKkjvjpnZpL8P9K5w4/8nQA
 Ma/ztXRWAiJL46Y3pXYhDS0HeEVkr1xQ11TBPwQOH4u5e0vqOADAStrTHBSZCjV3Iwjic=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>
References: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>

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


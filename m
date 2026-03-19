Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B1C3A75B2
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962450; cv=none; b=TFXdnJGMrnVkNa4qU5SpT0Y9FRdNb5DUyOBC+l3kws3nf1HT9y8j2XLB9KuhLUIMhcf/yVOcPTzrzoEEnKvQN8PbDDsxvUDP7XSMise6Jai1jYdlG0iSE61zfokNig9RdPZEsXEGKDGpN/Xq6s5cBR6KiuP5jOJDgFYHHHsyTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962450; c=relaxed/simple;
	bh=i/ZHP3nIoR1Lrccv6ggi1m62foVVsgKFwZ85KWaAgMk=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:In-Reply-To:
	 References:Message-Id; b=Ed6EWA0zhj+N9k+xlbKa2q6n0ev0IqRFHr5TPICCGhMTuqpxBhFoEYYasf592R/BKJAhnGiLrpo0Ho0+P9/Cyj19Q3SKuKUj7p9Y4sYGwvUHB8jgXE20v5QgS82J4rcFkKsoVd/TT7hQU/VW7sV8aIs/3mJOIAdqW7ZWwEidEWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=EptwHYR4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MnY8U9pM; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="EptwHYR4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MnY8U9pM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C73D1D00211;
	Thu, 19 Mar 2026 19:20:47 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 19:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773962447;
	 x=1774048847; bh=bPJ6Lyfn7yPn7UuxN3CPtATH7ID+bUNGaaGcyG0DoZw=; b=
	EptwHYR4QaamRWF0cBFOUqX7GlTJjobjA8QT0AIDLXEa0HpcJ3aCq+0QtNNIkj6w
	30KzMj4o4zUl4EaMHqFtmear2zcjV2WfMQXQhPYr4h2M7Xlg3k6V8qH/PsC3XCT1
	8VO6xdmHyrq6NjhiRqcsKbXCb+8NIo4MjkKGoPTCaA/taJNbbu91XOFnP9eu+KYF
	oyCYL8bltkahlLXT434oWsEaRul9sFYx9+i2ACG9vIT2HtWqvwnR4j6NqvK7yViC
	OFNsV+bZz4gfNPr0qZY4RAgWmoNFSJy7guEQ8U0XJSYvEZx0P+Ukmec0H+zsEJmv
	JQ3rjhjP7zkI9widKAMhaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773962447; x=
	1774048847; bh=bPJ6Lyfn7yPn7UuxN3CPtATH7ID+bUNGaaGcyG0DoZw=; b=M
	nY8U9pMcRw5ZyYEmLY/SmoJVIqAZC5OYZ/YPQNwfn15Thl/v7K+lL+1LxrI3gUMu
	3Bz90tl0hEBAo+CCX85WraWFs4moRzbLN7EqW8yytSu7YpiqXO2PYeoKxLIjPZ/d
	xPGP7GfD9oBX3aK1KvRLzkDJcqg+5OFUO8VbY3uqt9Zo6ZBCCWXEIEoZXQsREUpq
	cLWjVCAbZfaAD70OwzIhWTjp2Vnq0h3xYh4RNsIDRJsNfdQcfIU0cQvrUOb6I8WU
	rwCoj4TvblDCT/nweyzBcX85FQEG6fkvI0xjH2r0XKMjQPkfgod5MtQ0IrgvRLE8
	XmKdjg1nk4igKpzeuFVSw==
X-ME-Sender: <xms:z4S8aYDMSyak7F72ds5pBV30zlhPe89XjAqvUGXiqOdEv3ximihRfQ>
    <xme:z4S8aVXmj8ksKa_vesdGmHf8KXYJPBy57TzCUvMkSo4suIZfMB_5p4R36kOZpiP8W
    bwcEUAq7O1PlzwM1stq7IC-sAS4WoYhj3YgYAd8oFM19ciyKB6pCF_x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegopf
    hokfffucdluddtmdenucfjughrpefotggggffhvfffufevjghfsehtkedttdertdejnecu
    hfhrohhmpeflrghvihgvrhcuvfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtf
    frrghtthgvrhhnpeektdffveejhfeffeevgfefhffhuedvvdfgfffhieetleefvefgfeek
    tedvffffgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhmvgdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhuih
    iirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgvrghnrdifrghnghes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhgvughirghtvghksehlih
    hsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqsghluhgv
    thhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:z4S8aRoLbIB86xOUchVrPgnbHyOYABS0b5iEC_oG8uItdgmbssfXWQ>
    <xmx:z4S8afFjiNb-yTUG2lhv4DmDyX-tJJJPmyRZZxgDgeyW-4fsKz_OTw>
    <xmx:z4S8aRsn9ImPVSAhLoohRepPUPFs6zFX98HYlAs8jc1MtxzFefTdew>
    <xmx:z4S8aRXPJ6o3yMDUsE-j_EUKTIVSzpvBCAsxRZcETvP0vX27gEUQDw>
    <xmx:z4S8aTvanKQl1XiweKSpUrG5WWlhlhbo5VuW7QF07AMG0i2EJhLGQKk3>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E361D1EA006B; Thu, 19 Mar 2026 19:20:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Javier Tia <floss@jetm.me>
To: Sean Wang <sean.wang@kernel.org>
Date: Thu, 19 Mar 2026 17:18:10 -0600
Subject: Re: [PATCH 1/2] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
Cc: linux-bluetooth@vger.kernel.org, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
In-Reply-To: CAGp9Lzrysz8Tyh2KUMWVgHMsfUqojiJgPseG+CTULTqH=QQhaw@mail.gmail.com
References: 177272816248.352280.12453518046823439297@jetm.me 20260305162928.5E8F11EA006C@mailuser.phl.internal CAGp9Lzrysz8Tyh2KUMWVgHMsfUqojiJgPseG+CTULTqH=QQhaw@mail.gmail.com
Message-Id: <20260319232046.E361D1EA006B@mailuser.phl.internal>

Hi Sean,

Thank you for the review. I have a few questions before
preparing v2.

On Fri, Mar 7, 2026 Sean Wang wrote:
> BT and WiFi use separate firmware.
> I'm not sure why those WiFi sections are included in the binary.
> Another concern is whether it is appropriate to upload the firmware
> used in Windows to the linux-firmware repository,
> The firmware files are probably intended for dedicated OEMs.

Understood. The BT firmware we have came from an ASUS Windows
driver package because no official Linux firmware exists yet
for MT6639.

Regarding the section filtering: the MT6639 is a combo chip,
and the firmware binary we have contains 9 sections - some BT,
some not. Without filtering on (dlmodecrctype & 0xff) == 0x01,
the chip hangs irreversibly during download. I'd argue the
driver should handle mixed-section firmware correctly regardless
of source, since combo chip firmware may inherently contain
sections for multiple subsystems. But if MediaTek provides a
clean BT-only binary, the filtering becomes a no-op and can
be dropped.

Three questions:

1. Is MediaTek planning to release official MT6639/MT7927 BT
   firmware for linux-firmware? A clean BT-only binary would
   simplify the driver code.

2. The WiFi side has the same firmware dependency. The WiFi
   series I sent to linux-wireless [1] uses
   WIFI_MT6639_PATCH_MCU_2_1_hdr.bin and
   WIFI_RAM_CODE_MT6639_2_1.bin under mediatek/mt6639/. Is
   there a plan for official WiFi firmware submission, and
   would the path be mediatek/mt6639/ or something else
   (e.g. mediatek/mt7927/)?

3. Luiz requires a MediaTek engineer Signed-off-by on the
   btmtk patch confirming the changes work as intended. Would
   you be able to review and sign off on v2, or point me to
   the right person at MediaTek for BT driver changes?

I plan to decouple the driver patches from firmware
availability - the btmtk/btusb changes are valid independent
of which firmware binary ends up in linux-firmware. The
linux-firmware MR !946 can track separately.

> This is common logic for the other mediatek chips. It only takes
> longer on the first power-on.

> If the firmware download is properly handled in
> btmtk_setup_firmware_79xx, we don't need the extra bit.

Got it. I'll drop the BTMTK_FIRMWARE_LOADED flag in v2 and
let btmtk_setup_firmware_79xx handle persistence the same way
it does for other chips.

[1] https://lore.kernel.org/linux-wireless/20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me/

Best,
Javier

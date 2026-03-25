Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934B371D09;
	Wed, 25 Mar 2026 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774481425; cv=none; b=U+/f1Pi5S3so3GbXuc+9P1n9a5jMgj/6Mnju3oGiJtswuU/FV4qNhQ1InDIX0mxSFy+/G0ol0uo5xREaoOEaBxNhmR7uljrIKhT+wv+h1IYk05URio5W7wfbQqZE4pHmTh39zlAFYUxsz2hB4J35SwgXFEON0MGa7NVAJqlUHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774481425; c=relaxed/simple;
	bh=nsOzojii9d+fob0mA/+5E9MFraVa0JqIsD4t0SDPxxU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SPhWqZlt7JMo11o/7NmfggwgHMD8LG1vCO2XoQ2YqGZMQTpL96ZpCx7nx4ycdswKPAxhsmvDIq9WlowNP5kTVPyyrWeUsJJzspwCxIImiEtVjmkLoszj+WjKwA4+f5almtG/lmnHPD6aexjxWyveCyI7NspN25U9TBYUhWgFhmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=K9MNJie+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=McjdehOq; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="K9MNJie+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="McjdehOq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 408537A00D9;
	Wed, 25 Mar 2026 19:30:21 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 19:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1774481421; x=1774567821; bh=gQyLhBL9Ub
	mzshQJvtblVnD4ZAy3WacbYAsHE1insk8=; b=K9MNJie+EYgMzW3BFgLJFjG8Av
	/ZxZIiYHlUdoJUMwrRRyFegxpp3hYcuVoVvhDYiLHWf9JYPbIL61adPnF+pQnwRt
	gB1Qq6+iJV36qX0uC4xIgp3mkY/MctJd1QGTAiFsc5gE29dnV733zHOHFvwDRp35
	F0xeRhK6itNQ/WnXfnwU+FGOIz/4907MtBIbsIbYhaLam60FmG0nHgHyzhIO/C5K
	a4r8V5OYZ4WIlf8dhCu7Ttc93DYMWuQ9VpqwAwR/3sVHkMHAgBRZx9vbs71Ug7k8
	OHSViIlCSQzo2neowPA0gFeyK6ZDvzZbJjBrDCRTINYiJpJ/16+OdcWOkIHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774481421; x=1774567821; bh=gQyLhBL9UbmzshQJvtblVnD4ZAy3
	WacbYAsHE1insk8=; b=McjdehOqaHBKhICEBUcEkLBSCcQKjtQ9+XVmGmFnVGHF
	1kctnH4DHXvC2iI1fnlga15R/XnVWRrVjoh29jgBQ7ifjbUpCm6Mrcnaycl4Pp6p
	TNWeVwQ5T6BKG0upcTKrs/rnP2am/Dj+11sAbYkdYSqojjYZsOOosK9LWyjl5KDF
	ohT9u4+sAFMNd2tRWzC6Y70xmUTloU5fCV3lj0LBjpOn2CleYAvJW3u9QqEmj6ki
	5H/45YOIPZP7urn0idL2tIDhWaDj3+8KRh50uhxL7YHWFaSgYMoph3dtaIh/88sK
	nM5SqJuec1mBQFa57fTaAICWrDiXAysGWrZp3rj6Tg==
X-ME-Sender: <xms:DHDEaQjRA4G2RKv7gaDt8OYovXOngnLonjQoS0qrkawu7KsssliIBg>
    <xme:DHDEaT0EXNtb-v_AtHz88uIB23yGkJPfR1exUcg-PttuY-J5BtGdgBPcJRjXdlDZj
    S05DsSpzy89UZsj2xnHZVDaOU-Lan33olUjBiDzY4m3U_vqSJar>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfgrvhhivghr
    ucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhephffgje
    eludfhtdffieeiueejfffgueehueffgfdvvdefvdevieevtdfgkedvvedtnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhmvgdp
    nhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnh
    hgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgt
    ohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdprhgtphhtthhope
    gthhgrphhuihhsuggrrhhiohegsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhusghn
    ihhnrdhivhgrnhesghhmrghilhdrtghomhdprhgtphhtthhopehluhhiiidruggvnhhtii
    esghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghgghesghhmrghi
    lhdrtghomhdprhgtphhtthhopehmvghlihhnkhhovddttdefsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepgigvlhhnrghgrgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghr
    tggvlheshhholhhtmhgrnhhnrdhorhhg
X-ME-Proxy: <xmx:DHDEacYkrjX6uotneRxXzmHyifBkakVgJUHEpPrnN2zV4aUfZix2XQ>
    <xmx:DHDEae9bSUFZJCJ6G6GcUbWCjQ-byF4NlnvoqP-MMRrK2jPRG7jWqw>
    <xmx:DHDEaWnp09GqBj8atAZesspJeD0bTT81diBrE6Ox0gct_o4lXTGbww>
    <xmx:DHDEaTYXbqlvreATnyixcidW2fXigAuFqQa-RkM6JWwMqDOH74_A_g>
    <xmx:DXDEaf5wQUEJi4EGz0Fk_uGH--F5a3ovsaHuYoPhuf1cImPirhp9aB_Y>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1AF001EA006B; Wed, 25 Mar 2026 19:30:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Subject: [PATCH v2 0/8] Bluetooth: Add MediaTek MT7927 (MT6639) support
Date: Wed, 25 Mar 2026 17:30:17 -0600
Message-Id: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ5AMBBA0avIrE1SlZa6ilhQg1mgaUskjbtrL
 N/i/wSBPFOArkjg6ebA55EhywLsNh4rIc/ZIIXUohYK99gY2eAUMVzOnT6iVq0ZlbBGVwvkznl
 a+Pmf/fC+Hw9mrpBjAAAA
X-Change-ID: 20260305-mt7927-bt-support-6589a50c961f
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ryan Gilbert <xelnaga@gmail.com>, 
 Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>, 
 Llewellyn Curran <melinko2003@gmail.com>, 
 Chapuis Dario <chapuisdario4@gmail.com>, Evgeny Kapusta <3193631@gmail.com>, 
 Thibaut FRANCOIS <tibo@humeurlibre.fr>, Ivan Lubnin <lubnin.ivan@gmail.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5003; i=floss@jetm.me;
 h=from:subject:message-id; bh=nsOzojii9d+fob0mA/+5E9MFraVa0JqIsD4t0SDPxxU=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxHAKNqMDRAgL8V++ujLTUdevy9QdIGDmXveKp
 TttrNZ20qSJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRwCgAKCRC17sMLqGd3
 H7goC/4nW7nHaHeRjaevGMskIDLlo8sdcGjpMYsvFD46W8GSf3J96B3SfRPZue01GahviOdw3Dr
 5be/e6s6vGlFbxG6fgDXN6V2sDvq3Aqtu7nEpBAgpYYr7cqlBaES2rN4bEkffDDeQKcG7x1OzcF
 adjBWHd/AUr3gaWliaNWwz4A2JjDgEVzSwPAJni8hLCHmjZ2IAlzCP2Po57amn+RR6fctCIoxTN
 fVKeiOyBN/Eue8gltZeNXIgJGJXfo/mI4leNTBRQy2Im6YRwTna5dJ6jkR9Inx1JgmyGUZgFEv8
 aFIkRtUJR3Bk8yjeVWzdq1QOAg+YWd2LcJhmhuhud2EH7764sbB7UvgqXxCwh6gI/q3IxK+7Wir
 Dz7ki7KPsjx5TX1SQAGh4RcvYEcuRO9RW5PolxmbRuBL1C0imCRNBBGrWvL4aoOZ5pxNtUi0kt0
 S2yRFRqeE8mOfvQlOPvSsQLHqbnetGplejRVFjUOa09ew2vwMIetKwwktDToskQp+0rHA=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F

This series adds Bluetooth support for the MediaTek MT7927 (Filogic 380)
combo WiFi 7 + BT 5.4 module. The BT subsystem uses hardware variant
0x6639 and connects via USB.

The MT7927 is shipping in motherboards and PCIe add-in cards from ASUS,
Gigabyte, Lenovo, MSI, and TP-Link since mid-2024. Without these patches,
users see "Unsupported hardware variant (00006639)" or the BT subsystem
hangs during firmware download.

Jean-Francois Marliere independently identified the same three root
causes and posted an analysis to the list in February [1], though the
patch diff was not included in that message. This series provides the
complete, split patches addressing the same issues.

The series consists of nine patches:

  [1/9] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
  [2/9] Bluetooth: btmtk: fix ISO interface setup for single alt setting
  [3/9] Bluetooth: btusb: Add MT7927 ID for ASUS ROG Crosshair X870E Hero
  [4/9] Bluetooth: btusb: Add MT7927 ID for Lenovo Legion Pro 7 16ARX9
  [5/9] Bluetooth: btusb: Add MT7927 ID for Gigabyte Z790 AORUS MASTER X
  [6/9] Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace Max
  [7/9] Bluetooth: btusb: Add MT7927 ID for TP-Link Archer TBE550E
  [8/9] Bluetooth: btusb: Add MT7927 ID for ASUS X870E / ProArt X870E-Creator

Three driver changes are needed for MT6639:

1. CHIPID workaround: On some boards the BT USB MMIO register reads
   0x0000 for dev_id, causing the driver to skip the 0x6639 init path.
   Force dev_id to 0x6639 when it reads zero, matching the equivalent
   WiFi-side workaround that forces chip=0x7927.

2. Firmware naming: MT6639 uses firmware version prefix "2_1" instead of
   "1_1" used by MT7925 and other variants. The firmware path is
   mediatek/mt6639/BT_RAM_CODE_MT6639_2_1_hdr.bin.

3. Section filtering: The firmware binary contains 9 sections, but only
   sections with (dlmodecrctype & 0xff) == 0x01 are Bluetooth-related.
   Sending WiFi/other sections causes an irreversible BT subsystem hang.
   The filter is gated on dev_id == 0x6639 to avoid affecting other chips.

Additionally, patch 2 fixes the ISO interface setup for devices that
expose only a single alternate setting (alt 0) on the ISO endpoint.
Without this fix, btmtk_usb_claim_iso_intf() fails with EINVAL,
causing ~20 second initialization delays.

Changes in v2:
- Split USB device IDs into per-device commits as requested (Luiz)
- Added 0489:e110 (MSI X870E Ace Max, new hardware report)
- Added ISO interface fix for single alt setting (13d3:3588 devices)
- Added Tested-by trailers for all USB IDs except 0489:e110
- Added USB descriptor output to all per-device commits
- Removed BTMTK_FIRMWARE_LOADED skip logic; firmware persistence is
  handled by the existing framework (Sean Wang)

The firmware blob (BT_RAM_CODE_MT6639_2_1_hdr.bin) is being submitted
separately to linux-firmware via GitLab MR. The firmware path and
filename have not been finalized yet; the driver currently requests
mediatek/mt6639/, but this may change based on the linux-firmware
review.

Tested hardware:
- ASUS ROG Crosshair X870E Hero (BT 0489:e13a)
- ASUS ROG STRIX X870-I (BT 0489:e13a)
- ASUS ROG STRIX X870E-E (BT 13d3:3588)
- ASUS ProArt X870E-Creator WiFi (BT 13d3:3588)
- Gigabyte Z790 AORUS MASTER X (BT 0489:e10f)
- Gigabyte Z790 AORUS ELITE X WiFi7 (BT 0489:e10f)
- MSI MEG X870E ACE MAX (BT 0489:e110)
- Lenovo Legion Pro 7 16ARX9 (BT 0489:e0fa)
- Lenovo Legion Pro 7 16AFR10H (BT 0489:e0fa)
- TP-Link Archer TBE550E PCIe (BT 0489:e116)

Tested on Arch Linux, CachyOS, Fedora (Bazzite), and Ubuntu
across kernels 6.13-6.19.

The companion WiFi support for MT7927 (mt76/mt7925e driver) has been
submitted separately to linux-wireless.

[1] https://lore.kernel.org/linux-bluetooth/496b0f8505eb6ffb19fdbee6f963c62aa6790fba.camel@marliere.fr/

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221096
Link: https://github.com/openwrt/mt76/issues/927

Assisted-by: Claude (Anthropic)
Signed-off-by: Javier Tia <floss@jetm.me>
---
Javier Tia (8):
      Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
      Bluetooth: btmtk: fix ISO interface setup for single alt setting
      Bluetooth: btusb: Add MT7927 ID for ASUS ROG Crosshair X870E Hero
      Bluetooth: btusb: Add MT7927 ID for Lenovo Legion Pro 7 16ARX9
      Bluetooth: btusb: Add MT7927 ID for Gigabyte Z790 AORUS MASTER X
      Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace Max
      Bluetooth: btusb: Add MT7927 ID for TP-Link Archer TBE550E
      Bluetooth: btusb: Add MT7927 ID for ASUS X870E / ProArt X870E-Creator

 drivers/bluetooth/btmtk.c | 26 +++++++++++++++++++++++---
 drivers/bluetooth/btmtk.h |  1 +
 drivers/bluetooth/btusb.c | 12 ++++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)
---
base-commit: 50003ce2085a7f7dacf2426065d1a69c84b5b963
change-id: 20260305-mt7927-bt-support-6589a50c961f

Best regards,
--  
Javier Tia <floss@jetm.me>


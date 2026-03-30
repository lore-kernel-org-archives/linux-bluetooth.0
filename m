Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4B373C1E;
	Mon, 30 Mar 2026 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903168; cv=none; b=LujzZgDQ5hS7HXHdp9b6AN2AvO3jZDaYRCB4YJpv70b1O86vNEJ0h0eFBbFcAPqxqIqPeRVSqiTHt8MXOovQGlyGSYuEkf0+FyScPn6s1voYIG0DQjkKZldYRTV/BPn3sI4qYBFbbnIAJNoaPP2Fss1xuRP7a1zLKyr0TaufHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903168; c=relaxed/simple;
	bh=9QbfEsus5oxjDzaBF1qQRf0uTZqwEXyPCiI/9Rl9hbE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b57LfJdg73A6Y5UYwT6MYCVGxoDR3py5RnGLrD4XKTN+OMPUUjKpduGAwUOjTkexZGdGM/q3tMYkcDeMKRVDqzdsfsMIfnrNq0NZtv/fL72X9xvZmVVJ6jAEbYE4JblsakLBS8nIFdYOjRFvnAHsUbag0JW30R1bHxRrbLmYlx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=ZR7DWJmL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zrv829U8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="ZR7DWJmL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zrv829U8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE3081400231;
	Mon, 30 Mar 2026 16:39:25 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 16:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1774903165; x=1774989565; bh=D/DDszmqc6
	8wuwl8I+3vQKmrECMgQKEVydlEKXUwWoY=; b=ZR7DWJmLAwW76xR1F6FndGNMdi
	sdBqisbD0apIExYY5HpGkSZOpawAxGvFlPeNWC66WFlaYBToj7lH+WaLP3pbNnRZ
	9p5+Vp2pCNPJpvjf/7HIoNwDIwT+XH/fh7uyzW+woEk4SwVOkZTK2Vg98l3U0qLV
	GhNDBjzgzYmeo9DpcdrhQRF/4wMSra9TFLLXJUyeD/0MBlEtTg03VEexe1o+/T2p
	lOMwJd5yF5QLpDmPiBxcL1OvB4VjFj+pzA/V6FyHMbeMSwKwnLxqSZysHt+jOc8J
	8XjkTSYFLOqw0VmFGVTysWoMpIlKSqi424O0It0mdoWB8zhVL1SmhmSH7+sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774903165; x=1774989565; bh=D/DDszmqc68wuwl8I+3vQKmrECMg
	QKEVydlEKXUwWoY=; b=zrv829U8HJ14S18d0l0BLE4UN5csqNumBPh7ETsRqW5r
	v1bTp29WavCfHTFT627A6OvTrKXQqeIQxsKFZ26JzqDFy2FggjzzokONCUJ3hGx0
	hfxQhJKXNe7JcAl+UvR3jn3Z4hYuQvyA+JYt03swNJ5fBzau6gVhQPShm+Xud7TE
	BFKtARclfrnvT2UdKbEsGzQSY3nk+F6ec911qPo/5lzm4beK+ASVbOJKoZHsNbOM
	skxQMYBsyCqE3nXyNz9sZ2aukXsDhrpo52kZxYaanNgLfjGCakwoXifKTIcDgauR
	tE9IkSJm9T8l4hiflK2unVg3vm+1r0FxFk3DdkwmuQ==
X-ME-Sender: <xms:fd_KabYG5X3e8_gcgb_SgerLpjqKZ04ImU2kUJ_ZBxfrqJLtrY2oRA>
    <xme:fd_KaVMz4j0JG4L7SHeMAvEtatUFL9zbglGPZRRs-h0W388Vj0DXWQdWFRyCBHSFZ
    7gO0ZgSxivxRtAhTPzlgCsM_gKvgkBH4JjlFDt5M_olGFSTQQzExtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfgrvhhivghr
    ucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhephefhfe
    eiudffleeliedvhfetvdevieegheeuleefuefhhfekgeefkeegueffgeehnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehflhhoshhssehjvghtmhdrmhgvpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthh
    hinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopeef
    udelfeeifedusehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrghpuhhishgurghrih
    hogeesghhmrghilhdrtghomhdprhgtphhtthhopehluhgsnhhinhdrihhvrghnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepmhgrthhthhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgvlhhinhhkohdvtddtfeesghhmrghilhdrtghomhdprhgtphhtthhopehnihhtih
    hnrdhrvgguugihkeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepgigvlhhnrghgrges
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:fd_Kad9L7cm6uL4SmTpHRpcyXSG6wd2_3Qdt8RyyYlayiqhPdbX0gQ>
    <xmx:fd_KabHzLVFqQ6Cn4n4zY2IPEUTmG9a_s-18vzOgmig6ucOd1MIa0g>
    <xmx:fd_KaTgGrc6gZfKcIz6xkXkTPhsO6HWqwoSfcOfvt8mSdDmkVYZxIA>
    <xmx:fd_KaQ90GvvTd8_HJXwaPXL_ERWO-fXHCI_r0nR4VBsWiBGtHkX6TA>
    <xmx:fd_KabtrvjNWo05ffs6JrD7u2sJm83iy1MuKrMZ_1atHDfD4vhPFLASp>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1A0041EA006B; Mon, 30 Mar 2026 16:39:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Subject: [PATCH v4 0/8] Bluetooth: Add MediaTek MT7927 (MT6639) support
Date: Mon, 30 Mar 2026 14:39:22 -0600
Message-Id: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ5AMBBA0avIrE1SpaWuIhbFYBZo2hKJuLvG8
 i3+fyCQZwrQZg94ujjwsSdUeQbjaveFkKdkkEJqUQqFW6yNrHGIGE7nDh9Rq8ZYJUajixlS5zz
 NfP/Prn/fD4L9+/RjAAAA
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
 Nitin Gurram <nitin.reddy88@gmail.com>, 
 Thibaut FRANCOIS <tibo@humeurlibre.fr>, Ivan Lubnin <lubnin.ivan@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4198; i=floss@jetm.me;
 h=from:subject:message-id; bh=9QbfEsus5oxjDzaBF1qQRf0uTZqwEXyPCiI/9Rl9hbE=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpyt964WdbZ4X2MlcWzGKSbZ1IgY8IUW8C10CJ/
 KmPhe9pzgSJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacrfegAKCRC17sMLqGd3
 H09uDACBpAakeFK1dRDLcyp2eB/ViI6xbh3wHwk/9lFdARVmJmm3ZndTHYIhgjZzqohPcCZZvsU
 NaOWwxBJ9GXAkEdwSPeXuLuWv0Cz25nfNY3ogYGLXrks2QOi5xHR0ahql6rgWGYcP0u9ViNbSKI
 rais3YKmupjPKpsCj7d29KeaAL9pu5b2XHXh27ZqHLajR6ubPLM4gtXOnk3B8MJSH/wydupXROH
 pbtUEJX1LtHd9YCBK651Kfa9sN/EpF+DoSxD6kcYF6ComSOhJWMUpYF89qx1KFEgA8qLY6iK+aL
 b4MT4fE0yrmQt37WeMD6Kg8a0hvR4jTArACBO4UuPOzUUAxicboHP3IrlPJ63rneL3Csyeh2dhV
 fqctCEJtNPVue5YLiK1BiO84i75jPWIU+WDwLyJ/OFWDl/UsAnfG1RWUgypsSVnzMls8H+3IsOE
 Lj5qRWbsq7xu9RpqSvnpkLujbTmbksuuUKF5pzLRNpSdCOnAi9y5n1qbBUVKm+4e06X5Q=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F

combo WiFi 7 + BT 5.4 module. The BT subsystem uses hardware variant
0x6639 and connects via USB.

The MT7927 is shipping in motherboards and PCIe add-in cards from ASUS,
Gigabyte, Lenovo, MSI, and TP-Link since mid-2024. Without these patches,
users see "Unsupported hardware variant (00006639)" or the BT subsystem
hangs during firmware download.

The series consists of eight patches:

  [1/8] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
  [2/8] Bluetooth: btmtk: fix ISO interface setup for single alt setting
  [3/8] Bluetooth: btusb: Add MT7927 ID for ASUS ROG Crosshair X870E Hero
  [4/8] Bluetooth: btusb: Add MT7927 ID for Lenovo Legion Pro 7 16ARX9
  [5/8] Bluetooth: btusb: Add MT7927 ID for Gigabyte Z790 AORUS MASTER X
  [6/8] Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace Max
  [7/8] Bluetooth: btusb: Add MT7927 ID for TP-Link Archer TBE550E
  [8/8] Bluetooth: btusb: Add MT7927 ID for ASUS X870E / ProArt X870E-Creator

Three driver changes are needed for MT6639 (patch 1):

1. CHIPID workaround: On some boards the BT USB MMIO register reads
   0x0000 for dev_id. Force dev_id to 0x6639 only when the USB VID/PID
   matches a known MT6639 device, avoiding misdetection if a future
   chip also reads zero. This follows the WiFi-side pattern.

2. Firmware naming: MT6639 uses firmware version prefix "2_1" instead of
   "1_1" used by MT7925 and other variants. The firmware path is
   mediatek/mt7927/BT_RAM_CODE_MT6639_2_1_hdr.bin, using the mt7927
   directory to match the WiFi firmware convention. The filename will
   likely change to use MT7927 once MediaTek submits a dedicated
   Linux firmware binary.

3. Section filtering: The firmware binary contains 9 sections, but only
   sections with (dlmodecrctype & 0xff) == 0x01 are Bluetooth-related.
   Sending WiFi/other sections causes an irreversible BT subsystem hang.

Patch 2 fixes the ISO interface setup for devices that expose only a
single alternate setting (alt 0) on the ISO endpoint. Without this fix,
btmtk_usb_claim_iso_intf() fails with EINVAL, causing ~20 second
initialization delays on 13d3:3588 devices.

WBS (Wideband Speech) was verified on MT7927 hardware. The controller
reports LMP_TRANSPARENT, LMP_ERR_DATA_REPORTING, and mSBC codec support.
A btmon capture confirms eSCO links establish with Transparent air mode
(mSBC) and 60-byte frames. BTUSB_WIDEBAND_SPEECH is correct for this
controller family.

Tested on:
- ASUS ROG Crosshair X870E Hero (USB 0489:e13a)
- ASUS ROG STRIX X870E-E (USB 13d3:3588)
- ASUS ROG STRIX B850-E GAMING WIFI (USB 0489:e13a)
- Gigabyte Z790 AORUS MASTER X (USB 0489:e10f)
- Lenovo Legion Pro 7 16ARX9 (USB 0489:e0fa)

Changes in v4:
- Pass dev_id as parameter to btmtk_setup_firmware_79xx instead of
  using hci_get_priv, which is not available in btmtksdio
  (suggested by Luiz Augusto von Dentz)
- Skip post-reset CHIPID validation for 0x6639 in
  btmtk_usb_subsys_reset since the register always returns 0x0000
  on affected boards

Link to v3: https://lore.kernel.org/linux-bluetooth/20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me/

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

 drivers/bluetooth/btmtk.c     | 63 ++++++++++++++++++++++++++++++++++++++-----
 drivers/bluetooth/btmtk.h     |  7 +++--
 drivers/bluetooth/btmtksdio.c |  2 +-
 drivers/bluetooth/btusb.c     | 12 +++++++++
 4 files changed, 75 insertions(+), 9 deletions(-)
---
base-commit: 7f9446b23ac77f46d356b354ea8da49113e8000d
change-id: 20260305-mt7927-bt-support-6589a50c961f

Best regards,
--  
Javier Tia <floss@jetm.me>


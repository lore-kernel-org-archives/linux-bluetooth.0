Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125313A4F4F
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728167; cv=none; b=k/M96Mtny/nKK7F3yutxqorhfLneKh8I/4hKoG+G88U36BXOHtq6Vp+wOXhfMMHuAZJcxurpdXww709qXhM4srzINNH8igwj12LCv2iNpKfEX6jg+WUsR8R/lFCMEp+yvpZq+9CPx3WaBiryPzsg/7f4W8WCnFJ4izjNR6U4n0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728167; c=relaxed/simple;
	bh=8ii4KX6K5V75kforp2CvuerwMpQ1ZoeGo3pUhYlLV0I=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:Message-ID; b=tk4HWt8LShmAfavj+goGSvO1/cntpVofkFuU94plqURY0O4l9zIYyEKSDDpNXMzp4f8FQ2r/BW4YijgFpy/M/A8b3qVrdr4hmGJdwjCd9bfccIAvCqPJUnDaXznHet30FwYU8gEwHT+B/O3R4TP1zj9PB0l3OVkDfwxMNueT6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=ZVJxoQvL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v49M467L; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="ZVJxoQvL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v49M467L"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 705381D0017D
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 11:29:25 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 11:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1772728165; x=1772814565; bh=H41lKDr5bB
	jsHRPAs9IhJUpDTcops/Mg9hw2ZKKywDk=; b=ZVJxoQvLEIpkUuEtgE009vuZ2L
	TW34JX79cMBqaPy6llDwVYRRzkC6s4ynjvMma0vGL66qMu1JtOah19Z/HmGIKNuz
	EXUXr5q5T6XAH2pTEIkHZnMBwJFesXkYG1MaQJJDV0jvlhcAROGi25PHr+n0oMWM
	JSBW6kZC/8Fp3v3K7qwsJGWUxs4EEGKarleUQexnjUjgXfeaLuZtaPrKDpCn7cpt
	h2RWD7Jv6SKI8tKmHeZH6KUtxNOGajOrIfXmT65ld7qHm27mYSexZLYNK6wg7kOs
	RhhT+MBFwUQl4jDadoKRkJxDKtewCJmqbMqqxObcCRDPz4w+72mC/XimN1mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1772728165; x=1772814565; bh=H41lKDr5bBjsHRPAs9IhJUpDTcop
	s/Mg9hw2ZKKywDk=; b=v49M467LOLI70RdWZ9MD+vGkOoRyc7kmkjniFdTxQ3OX
	PsdWectactDNtEF5I847MisZ/Wukdhimhpk0rp/bU45GW1g0iZWT8DTBkALQcjnx
	EamAKPXis9js+UOVUbSgbbjtB/vIHql8bI7FcU8ohyNaaHPGBh8E6V8Juv5EQkN+
	BefNRdg1s1e5Rp00UUU4U5PgUUOuIPgnz+2PLBlk8sEaYwKFPtM+9RTGt+z+mdCN
	DK+IzX95qMRgZFVo8hrEHWwgkXldEL0cokthEvQhNx0xIS6+yDq+aCoFmp876Cxf
	fzYVPfkPLHRMK0MUIJYSckFXT9dx5pXU892TGKhfvw==
X-ME-Sender: <xms:Za-paZbbWXpZJQQxx0q7qCdC9bMtTJLeJY0q1ntPmgLO_PuJghoi4Q>
    <xme:Za-pabMWYjHHIG0v5j8NiLbo_Ib8FqAMX2NnQ9BAfM6zmW7rHcH-h4Z8mN6AYcUkp
    CAp0UOGa5ncqUwLvFJX4vCG1rn2gOyT1_OktIzf5lldz9hVkDBiP5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeikeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofgtggfghffvfffuvefksehtkeertdertdejnecuhfhrohhmpeflrghvihgvrhcu
    vfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtffrrghtthgvrhhnpeffgfdtie
    ekueeitedvveehuefgffejteefjeffjeetvdfhhfehfeeuudeugefhgfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhhoshhssehjvghtmhdrmhgvpdhn
    sggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuh
    igqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Za-paRrYl02AlmuQQvWL5g1PZodedhNww-O4Xwle5WnXCXpxDbthJw>
    <xmx:Za-paTngO6LFuyzt7OJM14zrx0nBsMXyv_AbxDpIrH8zT2mMj-wpQQ>
    <xmx:Za-pabGjoqKl5mrNyoY8ojm39ELSUODNSUc0ViR3BM7K8M-aS8mqGg>
    <xmx:Za-paUqlJ4UB3juoup9uYRHdIFAOmnmhD04TkNGty_WhbgPpkGUIzw>
    <xmx:Za-pab-Uk4058iSDrx9-X2EkwSSx8WcM5qmywjTh6QEPmlpy7YTYypUx>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E51621EA006B; Thu,  5 Mar 2026 11:29:24 -0500 (EST)
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
To: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Mar 2026 10:04:55 -0600
Subject: [PATCH 0/2] Bluetooth: Add MediaTek MT7927 (MT6639) support
Cc: =?utf-8?q?linux-mediatek=40lists=2Einfradead=2Eorg=2C_Marcel_Holtmann_=3Cmarcel=40holtmann=2Eorg=3E=2C_Luiz_Augusto_von_Dentz_=3Cluiz=2Edentz=40gmail=2Ecom=3E=2C_Matthias_Brugger_=3Cmatthias=2Ebgg=40gmail=2Ecom=3E=2C_AngeloGioacchino_Del_Regno_=3Cangelogioacchino=2Edelregno=40collabora=2Ecom=3E=2C_Jean-Fran=C3=A7ois_Marli=C3=A8re_=3Cfreelance=40marliere=2Efr=3E=2C_Paul_Menzel_=3Cpmenzel=40molgen=2Empg=2Ede=3E?=@messagingengine.com
Message-ID: <177272816248.352280.12453518046823439297@jetm.me>

This series adds Bluetooth support for the MediaTek MT7927 (Filogic 380)
combo WiFi 7 + BT 5.4 module. The BT subsystem uses hardware variant
0x6639 and connects via USB.

The MT7927 is shipping in motherboards and PCIe add-in cards from ASUS,
Gigabyte, Lenovo, and TP-Link since mid-2024. Without these patches,
users see "Unsupported hardware variant (00006639)" or the BT subsystem
hangs during firmware download.

Jean-François Marlière independently identified the same three root
causes and posted an analysis to the list in February [1], though the
patch diff was not included in that message. This series provides the
complete, split patches addressing the same issues.

The series consists of two patches:

  [1/2] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
  [2/2] Bluetooth: btusb: Add USB device IDs for MediaTek MT7927 (MT6639)

Three driver changes are needed for MT6639:

1. Firmware naming: MT6639 uses firmware version prefix "2_1" instead of
   "1_1" used by MT7925 and other variants. The firmware path is
   mediatek/mt6639/BT_RAM_CODE_MT6639_2_1_hdr.bin.

2. Section filtering: The firmware binary contains 9 sections, but only
   sections with (dlmodecrctype & 0xff) == 0x01 are Bluetooth-related.
   Sending WiFi/other sections causes an irreversible BT subsystem hang.
   The filter is gated on dev_id == 0x6639 to avoid affecting other chips.

3. Firmware persistence: Firmware persists across BT soft power cycles
   (WMT_FUNC_CTRL=0 does not clear it). Skip re-download on subsequent
   setups to avoid a ~2.6s delay.

The firmware blob (BT_RAM_CODE_MT6639_2_1_hdr.bin) is being submitted
separately to linux-firmware via GitLab MR.

Tested on:
- ASUS ROG Crosshair X870E Hero (USB 0489:e13a)
- Arch Linux 6.19.6, BlueZ 5.82

The companion WiFi support for MT7927 (mt76/mt7925e driver) is being
submitted separately to linux-wireless.

[1] https://lore.kernel.org/linux-bluetooth/496b0f8505eb6ffb19fdbee6f963c62aa6790fba.camel@marliere.fr/

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221096
Link: https://github.com/openwrt/mt76/issues/927

Javier Tia (2):
  Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
  Bluetooth: btusb: Add USB device IDs for MediaTek MT7927 (MT6639)

 drivers/bluetooth/btmtk.c | 32 ++++++++++++++++++++++++++++++--
 drivers/bluetooth/btmtk.h |  1 +
 drivers/bluetooth/btusb.c | 10 ++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

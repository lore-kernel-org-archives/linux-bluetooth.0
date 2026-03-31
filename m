Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76743101B4;
	Tue, 31 Mar 2026 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976977; cv=none; b=TpAVbNcCZgA5Vl6dzb8SblICWGXCNAknf2EAi4gVGuDPuZIzejX4KLZGO4BJv0oeVZUMD+k1D5+O23Gg8YTd9rrYzgQwSRpj1xgVx2Fg61sq+If/QwA8/N+DfXF8wSwaf5udTeT8SvcyYYfk4SdxEPBW8g3JDgJJ651v26Stz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976977; c=relaxed/simple;
	bh=oPM2Jg0j6InqzHevyx5pSE1CIlxPjECR4PE/PAKu2sc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N3cgDJJNlbOisTOui77a4OnLUHG1//25E4BlsbKZnhqZGXbKj2NlWp/VfmlrsWSWSujZrZkqHzCWMY2VGbOrY55lrK8JPFfCufG91xbPCafqifUSgJgCicMzHAwRbEZCgmmOgTcThP1doNoYy/BP6n0B6A7GvddOSVWLf7RwPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=X/n3hd5n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s52H8XKf; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="X/n3hd5n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s52H8XKf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 41A471D0012D;
	Tue, 31 Mar 2026 13:09:34 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 13:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1774976973; x=1775063373; bh=XCOa6XgHs7
	P7MjXd2uLBnokMQpK1BW/EVXAqDFRyq8w=; b=X/n3hd5nZQ0YI5ci0I6nFp5onw
	QzCoNOf/Z2cc1MNMtycv9pS8Iw1izIKG/SxA+/TlSV5vSZnKNTezzExs9X6L2GG/
	1MJCJIoBu4RMYzOnum+U/Q11QGp7GVaYUvlqU+dqRBQOuGcgzLXQJHvb5nFjTGfz
	zV+ujtQYIeLX8MBZd5hRuAvRQaPKZVjrSPbdgzNBWu+1DMvHPcnHhzCmSyssHcGN
	L8gne3Orb9W/ejWhsUU66C/YtKKb9CN2joIWM5e7CFkOpMkVrNaulK/IZgpfc7Ox
	lsmbn6Wkr69YuJfAG0SSzhvMqAWL1KeZznYsmsH49z+ZyCXZ8iFGIKgTtF5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1774976973; x=1775063373; bh=XCOa6XgHs7P7MjXd2uLBnokMQpK1
	BW/EVXAqDFRyq8w=; b=s52H8XKf6Aw3pHRFga+kwTJ6pXoSnMZzAOat7zqBHmD4
	TtCbbKDwI2UM3b+75HKjyeccMLUY8Z56iNxfGwKN6pYE48p3qrbFhzX9W3HwHq86
	YjpZGqMOi/5/ceX7Ae/RYYeF7WNlUBMcXxF7BvJzP3qJTxSWW1xJIoYeJYr5A4br
	zJhP1qr3Gl7Ojl4uCHkvKlilSXjVo1mvCdWr2/2KTvStY6es74G+JDUSJ4/qaDHN
	ZY0ROjoJT8kzEEuYLAza/+zKKby5zsEWnE/pFdphh7jTSQAx2ucpb+HeLaitbTdn
	98Uf2TmkedrzFB4efWwB1bn4iB+FydrS+1OVFbhoWQ==
X-ME-Sender: <xms:zf_LadmemNQSK4wqXHrlVyegTqiFJUjmD_E_36I8v-a0Ic9tEiluRQ>
    <xme:zf_LaTpsTR2Onf4yg6nXZeXjERY1VcQxB2cvvLIOJShXeYRa1Qnj2ZKBFjyC4gbHI
    gI7gsR7j_ItoXwlQAHUmuz-zu2haPb3y9hGOumPT-JZQ3jEa97r8J0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fohffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflrghvihgvrhcuvfhi
    rgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtffrrghtthgvrhhnpeehhfefieduff
    elleeivdfhtedvveeigeehueelfeeuhffhkeegfeekgeeuffegheenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepfhhlohhsshesjhgvthhmrdhmvgdpnhgspghrtghpthhtohepudeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhgvghlohhgihhorggttghhihhnoh
    druggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepfeduleef
    ieefudesghhmrghilhdrtghomhdprhgtphhtthhopegthhgrphhuihhsuggrrhhiohegse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhusghnihhnrdhivhgrnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtph
    htthhopehmrghtthhhihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtthhopehm
    vghlihhnkhhovddttdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhithhinhdrrh
    gvugguhiekkeesghhmrghilhdrtghomhdprhgtphhtthhopeigvghlnhgrghgrsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:zf_LaRpN5CJg3vuFIdHYIaldt9qKXVPFoDMXEgAioeMnjPasEONK8g>
    <xmx:zf_LadB72GmAZ-uiceJ9TsHeY8W1AduOePeAIgB4Az_Eb54rP4dcmg>
    <xmx:zf_LaWvVKORh6Z15U-UCwcnBnH7movR1pGw-Y7CqiinJuMJz4OjWQw>
    <xmx:zf_LacZ-_ZlqKoM9NueXsXrbARVPJYFFZxKJVxAMqyBnrdONfMROQA>
    <xmx:zf_LaaO1veoyfBz0fdxJ5e6Pe2eInv7Qg_s8TA1KeSnByv__SCYLmmaP>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 055751EA006B; Tue, 31 Mar 2026 13:09:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Subject: [PATCH v5 0/8] Bluetooth: Add MediaTek MT7927 (MT6639) support
Date: Tue, 31 Mar 2026 11:09:30 -0600
Message-Id: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ5AMBBA0avIrE1SlZa6ilhQg1mgaUskjbtrL
 N/i/wSBPFOArkjg6ebA55GhygLsNh4rIc/ZIIXUohYK99gY2eAUMVzOnT6iVq0ZlbBGVwvkznl
 a+Pmf/fC+Hx86pQhjAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4182; i=floss@jetm.me;
 h=from:subject:message-id; bh=oPM2Jg0j6InqzHevyx5pSE1CIlxPjECR4PE/PAKu2sc=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpy//KLimnmyvdqwCBGYUlBcRu8k6ambK2UB9Ny
 pV2d8TzOTmJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacv/ygAKCRC17sMLqGd3
 H3QLC/91rntZaydtvrm1x+s5Q+hjL2bX0e7eiFjCbbMtd7N8S7M5pXVLGRF3xEojXqww9LfR4hd
 YPc9sBIEWj4QIbt/Zuk5ShKwcmgEfw79OtqjzFFY0BW547IejxkuvZUQfZU5ZwlmDW9c9PfSDh0
 OkyYrXdQd0ZpBGfAa9W84kDwbUMHzUQjfNprQeQOB1N/pnoWMhpr8fnIAlAX+WUHIu63CHKccQ6
 syswCkN8fMXV4Ahb99Qij3J2hMtpLIG0R6PnHrr9rgZarNwZwESJ66A2noW43faLbUTHujDx3Vj
 a5c6XNq45IbSQqqljirNkxRaOT3wEEBubvzYc67o8hOfDkFDBlEyJXbqCHg+wNTT00aZjI/WX85
 4hcUcLmiDnpGVmpeRZB0LpKXL6gL5f4yyT+UI9HRmdDJl3JPuXjCE1TPYQP6yiTcJ7XQEB/k3q1
 BTDalWsjwDW+9N3FXdQOImVSD42XATLb5yNyULP/mFdBcAq+5+ZBat5A+23ae67mKtXMs=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F

Add Bluetooth support for the MediaTek MT7927 (Filogic 380), a PCIe
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

Changes in v5:
- Fix patch 8/8 commit message: the ~19 second delay note was misleading
  since patch 2/8 already fixes that issue. Updated to clarify the
  relationship between the two patches (suggested by Luiz Augusto von
  Dentz)

Link to v4: https://lore.kernel.org/linux-bluetooth/20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me/

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


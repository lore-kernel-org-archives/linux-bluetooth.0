Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390404;
	b=IFMaB3sGp+nnFo/nMbWOez5MeMVuu/WEP0TMl8uiWrDspad51Q17eTQrzaytkbr1k8ir
	 i1cI5NUc9PkvIOu93e18uS1/hwKEueiW1sG5AaiQUnyhIPo2s6reLgV9vV9vfaZtADnD8
	 xqQUj2Oi4oweaoQ9xfXFrc874Fwi2/pC5pRf9uWNMFSYd/pVqpPNRKuysmBzuPFjanSNV
	 4OKA0L5elBiV/oc4NUZ8LlhOYmY5IDCQczqx2q7rJer2U65v18T+ummHMo+G/pHGY4OIJ
	 +4R6IhbN4rjp5Isgnqg49ucy+6DfeD6ZKm1bvCqmMwVhFTLUSAUoXPUYJu/XvBOOzWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390404;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cSfKq6TaMYfXhvJwtGxYyQkyoPg2VJBA/tCs61AB3jM=;
	b=frp/qTGu6wiXkP/n/q8fDx+/DPrYOV7uLAPeZL9OMRVHxQ+YDO9yNQBfKnFt35QnXmVA
	 +snd37H0kg9E575tkQYg+Zl3UEOFdobm/0hgG4eJkuuELTTuAq/OHbEfMySRwsUp/vyMM
	 10TRcU3tvQVGzTnF/WrCCmq9uzs9Qmzkw+R/kWbu839UfzdA2EmksewN+IILkdejFEAMs
	 NdOhQTNflYFgTuVPcpB0J3DaO7Vu1bGk2D/S8kTsNFYj4nNBPuxdP5ieOX7AlyV5IEDHt
	 D4mtr5eGMe6nohEnVzBVIcXmVF+eL9CzLoRthTul0cMr8F6iDLS/QTtYkLVGGDuovkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=UhMUXiiS;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8C1606A31C;
	Wed, 11 Nov 2026 09:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E8C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=UhMUXiiS
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id 5AE5A20DD1E9;
	Wed, 11 Nov 2026 10:46:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id 3177920D7CF3;
	Wed, 11 Nov 2026 10:46:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 3177920D7CF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1794390395;
	bh=cSfKq6TaMYfXhvJwtGxYyQkyoPg2VJBA/tCs61AB3jM=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=UhMUXiiSz+gMpFWPXbet/zD2CYIaqCGw+zxZ8+Ap6dH5zT3KGRN1vcbYPKiu+EIZf
	 UeemDeg3xLmuW0mFweA4eKVYxQMPm5O+ZMbO89md+C3tHKawBwl0G/ouDMj6tGWnkM
	 8u4WikCHB8aIUal5JR5yCY+IyzdNW0h496BLiFqbTZJ7mB8rnmgMYIX9F6qzPmNeHV
	 zxYIvyerGXBSApjvS3KPrP9GTud9cMn/oOhOhLZnzfkfvVP4LS9dovQZeG5PYZle/o
	 iFN4mVTRQAGBO4KUP0sQTpKRIwE4ihzj5Q+xHvXB908O2gQQIcYtnk+bCUel0z4VSR
	 xnaZLbQ8iQIDA==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id S_CcOLjJBBvj; Wed, 11 Nov 2026 10:46:35 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id 14DC420DD1E9;
	Wed, 11 Nov 2026 10:46:34 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
Subject: [PATCH v2 0/2] Bluetooth for the RTL8852BS on BPI-F3
Date: Wed, 11 Nov 2026 10:45:55 +0100
Message-ID: <20261111094557.443481-1-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The BPI-F3 (SpacemiT K1) carries an RTL8852BS Wi-Fi + Bluetooth module.
Wi-Fi (SDIO) has no upstream driver, but Bluetooth on UART works with
the existing hci_h5/btrtl code and linux-firmware's rtl8852bs files.

Patch 1 documents the compatible, with rtl8822cs-bt as fallback, so no
driver change is needed. Patch 2 enables it on the BPI-F3.

GPIO usage was tested one line at a time: GPIO 63 is the power/enable
line and GPIO 64 the device wake line. The vendor DT also drives
GPIO 65 and GPIO 67; Bluetooth works without them (and RSSI is the
same with GPIO 67 high or low), so they are left out.

Changes in v2:
- Patch 2: set slow_uart2 to 48 MHz with assigned-clock-rates instead
  of relying on the bootloader (Troy). Checked that a 24 MHz setting
  is applied, then 48 MHz.
- Patch 1: add Conor's Acked-by and Alistair's Reviewed-by.

Link to v1: https://lore.kernel.org/r/20261110074607.363918-1-frederic.ma=
he@cirad.fr

Fr=C3=A9d=C3=A9ric Mah=C3=A9 (2):
  dt-bindings: net: bluetooth: realtek: Add RTL8852BS
  riscv: dts: spacemit: enable Bluetooth on BPI-F3

 .../net/bluetooth/realtek,bluetooth.yaml        | 11 +++++++----
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
--=20
2.47.3


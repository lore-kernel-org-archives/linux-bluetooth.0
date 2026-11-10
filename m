Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296833;
	b=Oz38uiOgUxwK/TgB+aFsIbDizigkQRSvVRzAptjW8pF75N/CI1LMavizQGATpDiLzzBt
	 usYEGedo+GgyTctA2H449FS+Ijeft6sZ3W8c5wBWj5aLdzNbA/IN7S90RT3UwjcK1USpD
	 ZZ/47aeTvr4IiIYT8bD3dhZbawDom4mRrOVKqr9c7qelnj/avedqJO+a5J3SXwxvaDoBR
	 cebwUNsARXAi2RRytEx4jUHmpTPmS2UHIAOOYM5y8O22+sdMHd5XqNFH2+2GF26Q7hzh7
	 xoJT3NEpB3AHV8cmH7SrNueQmiCvDn+r7dvKFjHg8/KCtNTZbaZx3Hk1RLxXOiSPHLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296833;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mfTY212zApa5ehOLo+920M5IDmH72kkgNtIxDrvSizo=;
	b=te+fSz7Gh7BCoIniW0GoUdZh9MrC7MhWflmecoOwuQi4w9soIGo7fWSHXO6yxjTcfx4L
	 RaB2v9Exk0yeiQbVv4nzp8/iK0SkJJw9W4G2By8YOsK22f4M6jHnYzTgxP/U4cg2Hkouc
	 ZC8wXxhEoSSMUVyl7AR6Y4CC+97hFg7mPHXYBxsYBeYcXsAWHA547k3YotG0bLtlRIhYx
	 hOn7jolxgWAlq91AiidsD3W+2li4m8+Y3zRGk2vSqRalNRLy6Vu2e86Tv/uh8oetNnZGE
	 1DlyIsXFsrCM8zaT4KUHqHbR9XL+0lk/ea5DuAALSJSVCqj9FGK6kwreljRz8WNgarg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=c3QPy4YH;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED502606A339;
	Tue, 10 Nov 2026 07:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED502606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=c3QPy4YH
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id E98E320D78F8;
	Tue, 10 Nov 2026 08:47:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id C9D7620D7CF7;
	Tue, 10 Nov 2026 08:47:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr C9D7620D7CF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1794296829;
	bh=mfTY212zApa5ehOLo+920M5IDmH72kkgNtIxDrvSizo=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=c3QPy4YHf6uoEBpjCpO2aq4SeEQklbaMPaB1SxoJmL2pfYAxXnHOmBbM8Ce/6SjZe
	 KzQr3/RswObM+fKbEg9CRG3nMVtl0fCbdx8QkkbAxwUc/ZfK7TwVgb6tzDXr+PyTwq
	 h5uqtUMtjamdqozSHKzmxJRYVIp5e30Hievr6oF4i5fhN6YyEHhl2dPQ9fGuFtm8sg
	 VGEQKHGWArHOp6vUQTfeGshTf4A/puahEadfkW98UJT6W0tSFHLMnp5x8spZLQekWn
	 uWkI4lm4Lt+t5ILJZ1bSeClwARJOapjSZkEzWs61hSsb2Er55ggiaOJxd2EdEthyj0
	 mFFmgwD4T564g==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id QGSqc_bMMjO0; Tue, 10 Nov 2026 08:47:09 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id CF35F20D78F8;
	Tue, 10 Nov 2026 08:47:08 +0100 (CET)
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
Subject: [PATCH 0/2] Bluetooth for the RTL8852BS on BPI-F3
Date: Tue, 10 Nov 2026 08:46:05 +0100
Message-ID: <20261110074607.363918-1-frederic.mahe@cirad.fr>
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

Fr=C3=A9d=C3=A9ric Mah=C3=A9 (2):
  dt-bindings: net: bluetooth: realtek: Add RTL8852BS
  riscv: dts: spacemit: enable Bluetooth on BPI-F3

 .../bindings/net/bluetooth/realtek,bluetooth.yaml | 11 +++++++----
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts   | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
--=20
2.47.3


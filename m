Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390404;
	b=Y9xusNiYlLUClwgR8c2Pghfvigizl8l7acBICVWBndKazFQ1stvWPdcWJETmUlGKU81B
	 Mau53AwyFFHjT/Le1zfxX3IdDdxiMM2g/PTpmMd9cCWAI5azoimiPA37iUz7d5bq0fFoZ
	 v7TwJWHHTBhBBfpN1HkRA26zXJYDSYGSwbt+Ig00MYOtYu7ANSg3FxppbEIdG3PdffjIK
	 K57JGs1vxOep7m8hVoaTEmCYxHkwXmfTgdAwWwPG390ZYT65Ja6lVjA9nlUWCcPJii4gb
	 2lO1C8UWCjMNiwSJ1YtoXss1fDao+h2xpfJjLmWYszGF6zPt20aF72sTyo5pfbP87ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390404;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fctwqUuDVlumK1xq9MaroNVF6hgHu7zzWTPoB/suOs0=;
	b=uo9en6m8CiOOuunrRijUI4xIGpN93OBhxNDZevdkz0B1Ij57EbRaBIJDGpWrh07o+uXL
	 ep/CPlzlkYLSoJbunHQUI1fjukxkm6hGBCUTYMQo6gXoNmelwCTMrjWi1mE6w+wotSh+B
	 WT6hTc+Tnmrzz4TAox/xMbKlIgcjdNA5NcxgoWQzquVHRPUoum6IX8FwiJbISk1+5wJqb
	 I96SY7ncIzns1taVts/sJQ5mzGYEWRcxnwbsQH3hehHitSAE1T+/dpbWOwkuInJxvUbjJ
	 3PBYZgKpX05uYswLrOYPoMWKbyRYMamJURXZhcZkfePuARKy3jijQo6Elc1AiODbHZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=S9JdeNcu;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0E6606A32D;
	Wed, 11 Nov 2026 09:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D0E6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=S9JdeNcu
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id D023320D7CFC;
	Wed, 11 Nov 2026 10:46:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id A5A2320D7CF6;
	Wed, 11 Nov 2026 10:46:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr A5A2320D7CF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1794390401;
	bh=fctwqUuDVlumK1xq9MaroNVF6hgHu7zzWTPoB/suOs0=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=S9JdeNcuU6OXTxj/PjBi+PHA6zGmsdQ4CGrsUQWb284zyxKHUBRendE/UtRTpMSX5
	 8RA66tAy2K1KO7ASgT3hyvCRxoSSc0H1S62Na8542AT60F7F7kz/j2zwAuKeqf+5dM
	 S0X1WV0LBtt4VAmVoaoLJ8ge1AKjlqxEvPr6G0qTBeuHzPuxJ8dwWD8XMWHQpxPt1Z
	 t0Mj1sfUohF3c7IztBYhdQxmSPsuyOniYnZH85yzpxXavSFwdqtg373KwgN9df9Ndg
	 STLFnz3cdQ/VhDntyC/FaWcwqlP0H7m8X7PLHdoIb1Su4yXAQVrkTusjtjkb626fWb
	 +3Jl9F9fk4f/w==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id vI7VFCsI6kH7; Wed, 11 Nov 2026 10:46:41 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id B9E8420D7CFC;
	Wed, 11 Nov 2026 10:46:40 +0100 (CET)
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
Subject: [PATCH v2 2/2] riscv: dts: spacemit: enable Bluetooth on BPI-F3
Date: Wed, 11 Nov 2026 10:45:57 +0100
Message-ID: <20261111094557.443481-3-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111094557.443481-1-frederic.mahe@cirad.fr>
References: <20261111094557.443481-1-frederic.mahe@cirad.fr>
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

The BPI-F3 has an RTL8852BS module whose Bluetooth part is on UART2,
with hardware flow control. GPIO 63 powers Bluetooth on and GPIO 64
is the device wake line.

The firmware config switches the UART to 1.5 Mbaud, so take the UART2
clock from slow_uart2, set to 48 MHz.

Tested with a laptop: scan, pairing, and l2ping in both directions,
including incoming connections while the UART is runtime suspended.
An 8-hour soak (an HCI command every 20 s) showed no errors.

This patch was prepared with the help of an AI assistant (Claude),
which also ran the tests.

Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv=
/boot/dts/spacemit/k1-bananapi-f3.dts
index 58035d886..ed6d4b7f4 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -383,6 +383,23 @@ &uart0 {
 	status =3D "okay";
 };
=20
+&uart2 {
+	assigned-clocks =3D <&syscon_apbc CLK_UART2>,
+			  <&syscon_mpmu CLK_SLOW_UART2>;
+	assigned-clock-parents =3D <&syscon_mpmu CLK_SLOW_UART2>;
+	assigned-clock-rates =3D <0>, <48000000>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&uart2_0_cfg>, <&uart2_0_cts_rts_cfg>;
+	uart-has-rtscts;
+	status =3D "okay";
+
+	bluetooth {
+		compatible =3D "realtek,rtl8852bs-bt", "realtek,rtl8822cs-bt";
+		enable-gpios =3D <&gpio K1_GPIO(63) GPIO_ACTIVE_HIGH>;
+		device-wake-gpios =3D <&gpio K1_GPIO(64) GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &usbphy2 {
 	status =3D "okay";
 };
--=20
2.47.3


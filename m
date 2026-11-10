Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296843;
	b=tKCdgSTa+QySNQgcw1HInqTxJuWYjbU/2Ys5k+5OEaAPw+BSBYbxWGUQLwPeqy33pgrA
	 6AuiIRjmzDPPJjl3RA8XHYe8NceRB3SGR4t8AQwzlFrWzNsR+pbWBULs4sHQ+IABnvOHo
	 4xZYurnkpuQWpX8i9ABvVWKWUxJYQ+EFc2uIImK6YMx/tF4vwEg9JrJyT2Pum37FaG3SP
	 QNT8IH3DNhnmVnxDs/arClxV0MM/LLjO7/deCFC/deQYyZ5G6E2qziuJEleKQFyIancL7
	 yukSnhTZ9Ucriff+UqYhm5/MhI03/FHsBxi4U30rFShtec77yhJHfujBKPbRtCHmtcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296843;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fNjwcRc0c7K0kuYsP00sMd8rDcxP9awGrVpi2PrAeZ8=;
	b=C5GVIIw1y8PR4HQEHlu1eUlrox3wtDG7ZuQ9eABWLvVCuLIv3LFktIZZwuR2D69yX2uD
	 fwilsgFlezLHGDgG0axyXmNy+crh0VvkhHvbotOP/E9cHFPQZ/wWkNcE3mNtq1r5SewRd
	 UW+g3AvSc2zaQPeawtNFsTRdfgOVnaumVdOk3lLf06giTC55y9P44akwHeKpIDJFZsfoJ
	 W3Mc9TSqT9Ajfb6915FJKpdgzY/phrUOCgXuRgxug/djIN1erXKGcKeowGtl3mwx167O7
	 HR6j1kdDgoREWvzk/YdCDJYY42BF3DPcI1I1KaFsbk0Y8+Au1T4BzlY7VL22bqSafCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=DFsUbzxp;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B92606A969;
	Tue, 10 Nov 2026 07:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05B92606A969
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=DFsUbzxp
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id 240EF20D4CAD;
	Tue, 10 Nov 2026 08:47:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id 0151420DB5DB;
	Tue, 10 Nov 2026 08:47:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 0151420DB5DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1794296840;
	bh=fNjwcRc0c7K0kuYsP00sMd8rDcxP9awGrVpi2PrAeZ8=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=DFsUbzxpxrZA/nv5eV6lqXYNzSYWT/6fvJ1DRQvL07nMNckxwsNyvD3jRPLClFCL5
	 LKx3YTToHkHBdyDjLTwtF5gb4AfleHGlbq+Otoh5NaLNyk5R6Vb948bpq2u25VQ8e6
	 QtjA1iAZqbSJyGwyPHpBzZESAZvO4nl8+YEYER5mpahFHWHio97im6yP4JCrQLXJSr
	 cfQGzurLptBRuCS3kprx++ppRmkUolZz52tDYzl/LDcnjmQzRPmDUrrm/Nyz/Fynzy
	 y+dXrQwZIjqVnR7cKGBjSbxNjUZEfMLPizSKCi6Ram+Bjt4MlDZu1SRs8Tzmu90wk5
	 cz7xI74oQOGIA==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id WAM_3Wb2AiA5; Tue, 10 Nov 2026 08:47:19 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id 04DD820D4CAD;
	Tue, 10 Nov 2026 08:47:18 +0100 (CET)
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
Subject: [PATCH 2/2] riscv: dts: spacemit: enable Bluetooth on BPI-F3
Date: Tue, 10 Nov 2026 08:46:07 +0100
Message-ID: <20261110074607.363918-3-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110074607.363918-1-frederic.mahe@cirad.fr>
References: <20261110074607.363918-1-frederic.mahe@cirad.fr>
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
clock from the 48 MHz slow_uart2 clock.

Tested with a laptop: scan, pairing, and l2ping in both directions,
including incoming connections while the UART is runtime suspended.
An 8-hour soak (an HCI command every 20 s) showed no errors.

This patch was prepared with the help of an AI assistant (Claude),
which also ran the tests.

Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv=
/boot/dts/spacemit/k1-bananapi-f3.dts
index 58035d886..280adc9dc 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -383,6 +383,21 @@ &uart0 {
 	status =3D "okay";
 };
=20
+&uart2 {
+	assigned-clocks =3D <&syscon_apbc CLK_UART2>;
+	assigned-clock-parents =3D <&syscon_mpmu CLK_SLOW_UART2>;
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


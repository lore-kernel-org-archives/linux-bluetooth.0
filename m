Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390406;
	b=JO3Mz+8wRyZmZ7/vfrZl1Eq+OSsExh4SQLYmrP+KmOYD+919O4nZDaT8xMMeUCKIf+h6
	 nKqz1BcvMIMMXAhocLE+A/mLcJtjkuQNWS+aI9NecEeOLOFkTz72WQXHxRpUMrC/E1xAv
	 0JE1bHlQHi+JxaR2HFGFXijUycEuaHxhtoUbeW2CsrKDJyxvbPkyGt+NiCAMpbDo7WAFS
	 YWLAomJq/O0GrWrTtsIK+hDEAwHLYedLPSohpySd1tceRrYWxzVUxB0yiQXQmqS+4SHMC
	 Rc9U0L3lsA72UBBzLXlJzenojI81NRiINsBDw4xeotlzFYdZz5yTyNvuFl1OHPKalkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390406;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xWAz9s1Zm6tCb+0l11xtLj2KpMSfrXcF+F2246xyAys=;
	b=hQPyvJqVMb7KZsBL2oUJFlDaBQOMbhyjAttJn6vRK1h5pdK0JThjXPvtEsBRX6BlbFGN
	 1VOHo6rcAWy1KyiuLsTvx+rBcbqgxrPFJytFbGEIWMc+QyiBJ2hFoJBtFFjg1FZ6164X4
	 6wcivQZx1d7+KroYFYHxy5Ylx3xgFU7iTQ0pgwYtjl8GEFLhipNeBkUqfN5ieH4a+CDe3
	 TXI5iSBV+r3cK8W2fXAx2gFkmb8zuvedB/Nb270l1t0LXuHmKQLcMIgf3hao9+FKYEXE5
	 +cuuee2E3/gvrCI+fq/vFQ5nSvhnCiqavpyGtc9Imi8gCl4oHNVUlApoj0XVCWAiXVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=Z+lDbcjR;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA0F60A260E;
	Wed, 11 Nov 2026 09:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA0F60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=Z+lDbcjR
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id 721C620D7CF3;
	Wed, 11 Nov 2026 10:46:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id 50F8F20D7CF6;
	Wed, 11 Nov 2026 10:46:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 50F8F20D7CF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1794390398;
	bh=xWAz9s1Zm6tCb+0l11xtLj2KpMSfrXcF+F2246xyAys=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=Z+lDbcjRD69GiySc9U/dW+NBvMPgz2aCkliPgzrg9mwYu5Rael+voMxXNr1G8MbTa
	 D+yi5dSbdWVpwc0uyetpsor8C9qvTHG/v/f3ycFRMp1frKSPlbDF3H7t3zYTflSH/y
	 5Wr4OzOQlXwnFyDgOcUw2YUDnTDDYHMsPjezMX6Qb0IgiHmefYpnLf0fZk8U7+T5B4
	 gSJwJfeTcBA+th32HWaC2WaQdpjtkPMAf+364nbWjITMEjsWTCU8rPhefqjEFuZHul
	 aRTv+UEl4YbocCbNc33SSn7QAEa9TcNQ9GM7q6h4ELerbPK2tkJXaHOAPonI0OVHdX
	 6W1Jw40c7Lv3w==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 9-U8xQJ7NFFF; Wed, 11 Nov 2026 10:46:38 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id 5D2F220D7CF3;
	Wed, 11 Nov 2026 10:46:37 +0100 (CET)
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
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: net: bluetooth: realtek: Add RTL8852BS
Date: Wed, 11 Nov 2026 10:45:56 +0100
Message-ID: <20261111094557.443481-2-frederic.mahe@cirad.fr>
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

The RTL8852BS is a Wi-Fi 6 + Bluetooth 5.2 chip with Wi-Fi on SDIO
and Bluetooth on UART (H5). Its Bluetooth part works with the
RTL8822CS driver data, so use realtek,rtl8822cs-bt as fallback.

This patch was prepared with the help of an AI assistant (Claude),
which also ran the tests.

Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Alistair Francis <alistair@alistair23.me>
---
 .../bindings/net/bluetooth/realtek,bluetooth.yaml     | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/realtek,blue=
tooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/realtek,blue=
tooth.yaml
index 7d567122b..ffdf13b05 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/realtek,bluetooth.y=
aml
+++ b/Documentation/devicetree/bindings/net/bluetooth/realtek,bluetooth.y=
aml
@@ -4,16 +4,16 @@
 $id: http://devicetree.org/schemas/net/bluetooth/realtek,bluetooth.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS Bluetooth
+title: RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS/RTL8852BS Bluetooth
=20
 maintainers:
   - Vasily Khoruzhick <anarsoul@gmail.com>
   - Alistair Francis <alistair@alistair23.me>
=20
 description:
-  RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS is a WiFi + BT chip. WiFi part
-  is connected over SDIO, while BT is connected over serial. It speaks
-  H5 protocol with few extra commands to upload firmware and change
+  RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS/RTL8852BS is a WiFi + BT chip.
+  WiFi part is connected over SDIO, while BT is connected over serial. I=
t
+  speaks H5 protocol with few extra commands to upload firmware and chan=
ge
   module speed.
=20
 properties:
@@ -28,6 +28,9 @@ properties:
           - enum:
               - realtek,rtl8821cs-bt
           - const: realtek,rtl8723bs-bt
+      - items:
+          - const: realtek,rtl8852bs-bt
+          - const: realtek,rtl8822cs-bt
=20
   device-wake-gpios:
     maxItems: 1
--=20
2.47.3


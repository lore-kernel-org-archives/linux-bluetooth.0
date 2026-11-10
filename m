Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296839;
	b=Swb0vtF3Cl/ldnWNo3QeJMOtuZQ5FMs+PdSMMBEwQIg0gFKtYV9ukXOQqArXaJqAWpNf
	 MDyuZV05fULn0FgGAaX3280/PONg3iXloscRsXlyF91n11rN8DaFuF6blVcPvSbPo2OAi
	 XR0HnYUFJZRkBkvsNka9zgQTYLp5mEMjx2Ez2wXQBcutIEjw1ZwNC7G0XbcfCMYRBL2oX
	 3LbuflOkYjpjU0VxV4W2KxWCmINASQaOV9qWsG7HHTBMHMaEDxL3VkAFoAeTErtudBAi5
	 YNU1i/fTkg1Y3312DzPnGfvtyz4COWFzLMIHf+X0+XUCVl876jHllaqNdD7nMlUliSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296839;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1baqYX7J86dweMCkPQfESiLRzdTWwZDtqPYe1PsN2XM=;
	b=5X5bV4I+hHazMq0vJZQKIabqOstXCjX1IW6pO9U/gL7mxzgwdifDE8hmfI2OIH6auCSE
	 zU1ExkPC/AukGgyTUrc1EXM5+NRz7HlVo4bFd0/GjiwA3mnrB32K3j4C9wNhhN3CwV9Rv
	 zz7NtHoUt2xSgY6yAbmp/n0AOe9sgaBYYMwSGtlwQPHtDB6xC3SQn36PcPXBPOUwN1DL1
	 FDYVM5pqQ+9MaxhL8T+bnKPuzRtogcdOSdD5TaFyml9MaM+2a4bgakozdgUcD0GRhaWkO
	 wMEE4tngK4gYj9REIJ1w/PKIi/7qYRAdb75EQLu2OCsr75qfXCydEaRVphxlivQD1Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=BA+bFgOL;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F6606A331;
	Tue, 10 Nov 2026 07:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A98F6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=BA+bFgOL
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id 2431620D4CA9;
	Tue, 10 Nov 2026 08:47:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id 00D2320D4CB1;
	Tue, 10 Nov 2026 08:47:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 00D2320D4CB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1794296837;
	bh=1baqYX7J86dweMCkPQfESiLRzdTWwZDtqPYe1PsN2XM=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=BA+bFgOL5chCN83DvWwCtjB8Z/AMp/wJolkNGrtjSp1z2whP/uU++tMBmDXuEBLMN
	 ZyQsQbooCG7bDpGwD1c/vV3ifVnw0/7F2B7oAIzUd75Zwg9GvVwyYYpxcn8R0GCU24
	 kQ2gnKIi/lAIkb+e6viQUw1/g801FLVpiEllrrjaStvqkVkHBqlLTm3VGEQpq9VU04
	 4+dFqejklQanlpnsfjZtDFEPwlBUIgIOtDw0mb1x6qIj7rGWzirkV7G8CetzYukF6n
	 M2QS8C40UoO0LKYHiVuR94I3PW2iDjJaMRrdFlLi9RXWHp0t6h7uh/gw99yk3iGpmR
	 Aqmk4ayc8cetQ==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id m0-m20SpvJkb; Tue, 10 Nov 2026 08:47:16 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id 045BD20D7CF7;
	Tue, 10 Nov 2026 08:47:15 +0100 (CET)
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
Subject: [PATCH 1/2] dt-bindings: net: bluetooth: realtek: Add RTL8852BS
Date: Tue, 10 Nov 2026 08:46:06 +0100
Message-ID: <20261110074607.363918-2-frederic.mahe@cirad.fr>
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

The RTL8852BS is a Wi-Fi 6 + Bluetooth 5.2 chip with Wi-Fi on SDIO
and Bluetooth on UART (H5). Its Bluetooth part works with the
RTL8822CS driver data, so use realtek,rtl8822cs-bt as fallback.

This patch was prepared with the help of an AI assistant (Claude),
which also ran the tests.

Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>
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


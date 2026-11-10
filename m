Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307531;
	b=0sPwdReqtpxOODD7y4PwLA3One2rOgH/OGuyPkqfxRAZtr/f0EEgA3dDQRlcP/Su5Gcj
	 JFGW98/b+nyv45R3HnHEyFlv9FlA0RC+jaiYYMNyVTxh3B4dzvRP27nCi0byXNUDqkvnn
	 5oMM8N3KCB7jMVtPYnGJz+WqhS8UAlCcF3F7Apd323g1VSPzFapXr0hohqA4fBn0AO7ny
	 DPK4M3k0ZYa9yb7za8VSyTCLzip8Hce1dttfhaBvQFeO77UgVXQZKrthOks4Wc+12YKD1
	 5e7GyTRurdGWPSVtBzpwecuT6qpT/zB9I8AOh8m8q+kBDxuZBLrssONk25x3o84ahFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307531;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=WIxvLAR79v0V/SQkC0OO2SBckOatgfJxUVAHQnclIqw=;
	b=Q2niqB9GUvDKYu0zQWrbZe08fG21eW54RhGEbJNSSvs+jBNxW1xw9p2D6GEScZNzFEok
	 lubfltcL9hDz+/zwo8Ojfa4G3FTnKpNtQhm9OzIr5De4o71LH32NJQIDPLIFPn0vjhwBu
	 a057dM8u2ORMWHjEdACErW6z432QkLsF8OPa53cbHmPWRRhcn1KdLaejfGPLhE7LPCkbQ
	 3q8aDbGOqMZJZnpsn+046PX46FEjjzhMLWKUAMwmSWz+Oh01XxptsasJEEXwky+k7yWwz
	 JFITZlapjMzn4Z9RS9+rtrVbOlbPlu0gPruGpBgK1epEKGnjtTidpoXQ9DXZPovqRaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FI5cy5xM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B4606A32A;
	Tue, 10 Nov 2026 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FI5cy5xM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6C11F008A1;
	Tue, 10 Nov 2026 10:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794307531;
	bh=WIxvLAR79v0V/SQkC0OO2SBckOatgfJxUVAHQnclIqw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FI5cy5xM/P273ywbT5zF+DAL8MbAynJnFiOBrf1BVeu3AN+VCBdMvB+NkIVinoDpj
	 Nf8QYuY5z+jABhZMkHHoEm7RSHs7TfoMjxJwhEehCiFsO//WSdv98ZfASRRo8qLaVo
	 rSJvgVrFzrloHMElujD/aGBvIEdKp4/mfHFf34tg2t1OSVCBheNY6hVTiOjRFQjVHn
	 jo3M60vAmg9+BE5E6FKVRb+5fSDFH57SGgaY6HgRytgTxYJ1pf8LFxpm49vwWALGp4
	 POpMhHwUJGHq/vxe0RStfDEXYFuTs5gu8KFi06ExAlcjiSZikG3gEBZt/jxYiE4JkK
	 OQWBaLJ3wrLZg==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 11:45:26 +0100
Subject: [PATCH 1/2] dt-bindings: bluetooth: brcm: Allow a platform BD
 address
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-brcm-bcmbt-mac-v1-1-c68003a06f64@kernel.org>
References: <20261110-brcm-bcmbt-mac-v1-0-c68003a06f64@kernel.org>
In-Reply-To: <20261110-brcm-bcmbt-mac-v1-0-c68003a06f64@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0

The bootloader can recover the device-specific Bluetooth address from
persistent storage on Samsung phones using BCM4334B0, and pass it in
the Bluetooth node. The Broadcom UART binding currently rejects the
standard local-bd-address property.

Reference the common Bluetooth controller binding to accept the optional
six-byte, little-endian address, and illustrate it in the example.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
index 612d21123aaa..5c44d8459166 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
@@ -127,6 +127,7 @@ dependencies:
   brcm,requires-autobaud-mode: [ shutdown-gpios ]
 
 allOf:
+  - $ref: bluetooth-controller.yaml#
   - $ref: /schemas/serial/serial-peripheral-props.yaml#
   - if:
       not:
@@ -153,6 +154,7 @@ examples:
 
         bluetooth {
             compatible = "brcm,bcm4330-bt";
+            local-bd-address = [55 44 33 22 11 00];
             max-speed = <921600>;
             brcm,bt-pcm-int-params = [01 02 00 01 01];
             shutdown-gpios = <&gpio 30 GPIO_ACTIVE_HIGH>;

-- 
2.56.0


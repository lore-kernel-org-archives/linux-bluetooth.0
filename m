Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956239;
	b=Sw1JVY7sj1vNTxZ7xw/Od58kw3y/yyI/YFXnbNjynAnfs7q3DuI69VGxrR7YhpfQife/
	 Vfxv1p0feCQJmB6L25632hTj06SI76JIUDx/kuRBkfvU/T8HK1Tfj3jCfGGjzc7tk5UjC
	 zVQQwxoGFCX2930M+yrG6a/TVPzafP7aQ4RI31lvE6YGIvCQZpPQE5c0B590eoglRPWvE
	 izycYyxLMTTnkkO87yxH5ieiTUHAehV9cM1CteojPkLl/4mcPKdVG1rgCdTonUElSjJ0N
	 mPBgR4PewzCvgfaFMu0HiASTAK8XjI9Z33KOMUyCiOwb7QzHXHd+4kqkyhJ9QgKkHUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956239;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=GX5pDWnikwJnRJW5LQ9M/aMBLK+wDKvoVAvxERPFeHI=;
	b=n9S/3seabLy4dFFXcVbWUsmiOiiLxev9q5aMEMIMUw01B8KJ3GwIWGxFRCuBCInqods+
	 H6YkeHQzRaRyTTq5qSP4/5iI7LqDRu2L8eArY+VDnyEUBQe6W8J1/mtRr3HP0iwwttybg
	 PJNARV2cRbJU1MPSIRZHf9goaiHfrGNbG6Xv9uoLi+7DK+AoP3SVln3igX15BWyivdcf0
	 zAvq15nAgJratjxcQ+jLXIcKtgIt26OIusFuNgbbaaW4IM3wJWJ6Q93nHh/FH9YBu+dEt
	 JWU74L+0Ow9NdQcLBFdFkArqH/V/WU4OVLpOO/4U6dH770krI7c995XsgoyIuPp8cVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=gdphZRlY;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E160A2602;
	Sun, 25 Oct 2026 19:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 186E160A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=gdphZRlY
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJNdOx518064
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:23:48 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJNdOx518064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956228;
	bh=GX5pDWnikwJnRJW5LQ9M/aMBLK+wDKvoVAvxERPFeHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gdphZRlYAKETvEzLAIQAF/BiGTjXd3s6IT8JUNgaQ+Uaus1O1Q9HO3COr5tx+6pp9
	 gLTiwtm7gAGPkm/nL/yiEa66LBEEpil66zSnWoZ/OA4mIj1C5EcRT9OLo30hAWJ/xx
	 vZ621Tkhn7YXhSa9TUJsqGH69hBN5ayjUPMgXbEc=
From: christian.koever-draxl@student.uibk.ac.at
To: yang.li@amlogic.com, marcel@holtmann.org, luiz.dentz@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 4/7] dt-bindings: net: bluetooth: amlogic,w155s2-bt: allow local-bd-address
Date: Sun, 25 Oct 2026 20:23:35 +0100
Message-ID: <20261025192338.209574-5-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
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
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -14.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

These controllers report a fixed default address and keep nothing
across a power cycle, so a board needs a way to give them a stable one.
Reference the common Bluetooth controller schema and allow
local-bd-address.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 .../devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
index 6fd7557039d2..50291a438ce2 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
@@ -15,6 +15,9 @@ description:
 maintainers:
   - Yang Li <yang.li@amlogic.com>
 
+allOf:
+  - $ref: /schemas/net/bluetooth/bluetooth-controller.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -41,6 +44,8 @@ properties:
     maxItems: 1
     description: specify the path of firmware bin to load
 
+  local-bd-address: true
+
 required:
   - compatible
   - clocks
-- 
2.56.0


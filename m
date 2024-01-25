Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170D1C6BD
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176378; cv=none; b=nJ+n5Y7RkqCxC5MB/SiqMHsERQdX+y+oGcv3uhSh4HnZdW01O1ToOH99cm05ovS3I7xEb8IwUNlT4r7VewDULVIWfbai6Y3xjJRjACBdzsaGlIk+WPggQSQDwlj+/lnwHfqImuQYis2vsbav5Mxs+KdnfA2YnB4lrqPOBiShLw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176378; c=relaxed/simple;
	bh=PefNmkCfcSVC4S0CUVrYlmPMrAYPLQBq6k2kvGzezPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBkwH/EChgobI3zF+bChHor8zWS4sQlVmwo0Yj3FqQKdeKvb0kwSAIpUyYdUvBQ7Izcro8ExipaUJQh6Hnw8+SWnxbQfrLljAjbWtmhp3u06BvDeT9q5HKWUPUvsNE61wR0HtSliXK7NOHlwdubDpgqA/9roqsXpVVrdz37A2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xcld3nvy; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xcld3nvy"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ddc0c02593so888446b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 01:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706176376; x=1706781176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7JPZ3FlmXtrPMvqbv7p+KV2yBKsdrHhwCB9rIMVdmU=;
        b=Xcld3nvy05xIEOxmLcZwG44XywG9RpZIZslznb+iXcOevlHPHtEi0E7WJ/LOdUET5v
         LdjD5j2iaXLb4YwQG8bEad3h3pqvzkbExz3lo41ewIM5d6fkE70LotfKLhJcJM1dnLFS
         5MLmD03kRt6jRX9xrHnUHpjBn26f+rahYwG8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176376; x=1706781176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7JPZ3FlmXtrPMvqbv7p+KV2yBKsdrHhwCB9rIMVdmU=;
        b=lgFMRfuwd0n1Vi9pYI+ft1U2x22VIVZruSR3JcfT1nG6EqfRzENNLOoB92xPlYHqWF
         LQYKg06CK45SpX/lhZfX0EHvfHhyuYSAcwEsi/S2E0NAGI3Ntbq0/r/eNZ/Qufpj3kw5
         YFgZ15hlSONvEy+qBEARW52zUrpS5IfMdwVOWHa9ZmVwwxM7IhPFcOemAdXedKNZ7Cok
         h4T+fa+emsARywfHz32CbGaM1BbMJuhtd/e0QwjSvRZGz+uood7XH3Q0BroNQkGoA38Y
         NdwBij4qbrVTAHSYtz6szBtRP/bFRdP14a/AaT6wMtMRwEq6azN85pw7jtC0tdeTGbSN
         GnHA==
X-Gm-Message-State: AOJu0YxQ+Ceof28WPfTOzvcoEF7iB2jdmJp2QBUwCvidrUauN6560nj1
	KNUeiEATzZIF520aMcgnCDpEGUXLkh1eYuBTCakLsnPClhP3bnLsxqnILUAE+g==
X-Google-Smtp-Source: AGHT+IEetX9gohXpDSKXt8dCp+m9IbL4e2u1dfNizaAo86YunKve6EwV6wkGQJbqZzkz7JS3K+JigQ==
X-Received: by 2002:a62:c702:0:b0:6db:d17a:e3ca with SMTP id w2-20020a62c702000000b006dbd17ae3camr283889pfg.63.1706176376292;
        Thu, 25 Jan 2024 01:52:56 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7fb6:ed02:1c59:9f9c])
        by smtp.gmail.com with ESMTPSA id gu15-20020a056a004e4f00b006dd8a4bbbc7sm3228275pfb.101.2024.01.25.01.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:52:55 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S SDIO Bluetooth
Date: Thu, 25 Jan 2024 17:52:37 +0800
Message-ID: <20240125095240.2308340-2-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125095240.2308340-1-wenst@chromium.org>
References: <20240125095240.2308340-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
SDIO. While the Bluetooth function is fully discoverable, the chip
has a pin that can reset just the Bluetooth side, as opposed to the
full chip. This needs to be described in the device tree.

Add a device tree binding for MT7921S Bluetooth over SDIO specifically
ot document the reset line.

Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 49 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
new file mode 100644
index 000000000000..bbe240e7cc40
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7921s-bluetooth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7921S Bluetooth
+
+description:
+  This binding describes the Bluetooth side of the SDIO-attached MT7921S
+  WiFi+Bluetooth combo chips. These chips are dual-radio chips supporting
+  WiFi and Bluetooth. Bluetooth works over SDIO just like WiFi. Bluetooth
+  has its own reset line, separate from WiFi, which can be used to reset
+  the Bluetooth core.
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt7921s-bluetooth
+  reg:
+    const: 2
+
+  reset-gpios:
+    maxItems: 1
+    description: A GPIO line connected to the Bluetooth subsystem reset line.
+      Typically the W_DISABLE2# pin on M.2 E-key modules. If present this
+      shall be flagged as active low.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    mmc {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bluetooth@2 {
+            compatible = "mediatek,mt7921s-bluetooth";
+            reg = <2>;
+            reset-gpios = <&pio 8 GPIO_ACTIVE_LOW>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b64a64ca7916..662957146852 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13657,6 +13657,7 @@ M:	Sean Wang <sean.wang@mediatek.com>
 L:	linux-bluetooth@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
 F:	Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
 F:	drivers/bluetooth/btmtkuart.c
 
-- 
2.43.0.429.g432eaa2c6b-goog


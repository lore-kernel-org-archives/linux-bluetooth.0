Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646BE1D559
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250912; cv=none; b=hrL1NC+Hjm0U8tElLWnm39bpKkoYmRKmCXabGVVFTX7UtLx58v73XoA0jCFg5EQ7TSW+vA587g1xdMvjmiVxoQoID0kUq1mMZf8nR/9UojUKwKqVgKEILRtloTJWVHaO6GFISaW/2hvlhhvm3ODeC/naXcscz70/9gBbPA8b4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250912; c=relaxed/simple;
	bh=5GcKspq0sMdDxo+UcPZnccatMORdMIGaN6teLn0eoa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHzxzf3KtdYEmA7JcvAjLKa2BFlChmcMqcnVfaiFrQiEUnis64S+TvnMyXMCg7RKda6vLbVTHE08qmV/m4MyOWb7+IIw40QXDtu3R8ZmYWeyPT+HrGICqWApmoYgp5ZxSXO4rNyjIeitMtx1CFLBrnmb+UDCP1PXLid1I7B9hwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JwPEojnr; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JwPEojnr"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bde3403a59so224694b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 22:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706250908; x=1706855708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDsngDFt0eFkFTP4ef0B62TIJS7yfiBrPs76zEjZeSM=;
        b=JwPEojnr3HIN7q3xXNGIPqLMH3CcKTdX3CQFnggugoe9QdPyV3GTtsHFfyVm9uNNAE
         58FUc+2D/6uGqfZOHVi/WbZUcT4Fdz0XvPmcf7nvL3jg3arMfhUWbW9wQ60+o9GUlvxs
         NpPBqCP91fS1Vv6P20VZevkHkPPLsdYy9LBsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706250908; x=1706855708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDsngDFt0eFkFTP4ef0B62TIJS7yfiBrPs76zEjZeSM=;
        b=wuU75blsSfeP2LnvrXV9Yd6at1nOoEET3j4rgXmhpp13GcxCe2SncG/+wOd57s9i02
         BOVJKmFYAuvFao/P6wmfOjIPQjaQtwq24TZSzY0cTaBrYiyFyfBDK7dqnb5LTToCA8CN
         63V4OVKI5v+GYthyCA5x3+gi+Edxl7+uhEDT02AyR/xVi7kyBV0OFB/ijY8XEydG3utV
         p1R4DijWKANQTqWFP6VJxIFaAzONPU5oHB6G94O0/VnXY1fHa4doQXhQK7TQZ/EMt3Pu
         6OQN60zJuZ3AYiiP0zrNPnC3yM78dLUlEi3kWY1WiF6H1j77vqO2G9pGIEMOrSLIkPsC
         p6eQ==
X-Gm-Message-State: AOJu0YxW064plm1B4mfm2AwogmoYyoXELNWDLc5rulpgSBPTq0ez0Q3m
	SiJbUq+5gJ3A6m3r+MK648cAE91OGp2C6IO38uxNQ4hfLd2la6lEAHSuyPD9og==
X-Google-Smtp-Source: AGHT+IGQ0RrYFrE/G7ixXxOx0VLO+jMdzh2GLdyIi33vbvVB62vyH+LC0DkBdAKj+7A2YXACQFZ1bw==
X-Received: by 2002:a05:6808:320b:b0:3bd:df12:e966 with SMTP id cb11-20020a056808320b00b003bddf12e966mr1498123oib.90.1706250908541;
        Thu, 25 Jan 2024 22:35:08 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2614:bbbd:8db2:1f54])
        by smtp.gmail.com with ESMTPSA id ka3-20020a056a00938300b006db13a02921sm488735pfb.183.2024.01.25.22.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 22:35:08 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S SDIO Bluetooth
Date: Fri, 26 Jan 2024 14:34:57 +0800
Message-ID: <20240126063500.2684087-2-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126063500.2684087-1-wenst@chromium.org>
References: <20240126063500.2684087-1-wenst@chromium.org>
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
Changes since v1:
- Reworded descriptions
- Moved binding maintainer section before description
- Added missing reference to bluetooth-controller.yaml
- Added missing GPIO header to example

 .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 53 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
new file mode 100644
index 000000000000..ff11c95c816c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7921s-bluetooth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7921S Bluetooth
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+
+description:
+  MT7921S is an SDIO-attached dual-radio WiFi+Bluetooth Combo chip; each
+  function is its own SDIO function on a shared SDIO interface. The chip
+  has two dedicated reset lines, one for each function core.
+  This binding only covers the Bluetooth part of the chip.
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
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
+    description:
+      An active-low reset line for the Bluetooth core; on typical M.2
+      key E modules this is the W_DISABLE2# pin.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
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


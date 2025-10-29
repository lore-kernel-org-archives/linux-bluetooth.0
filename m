Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947D3126A7
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723861; cv=none; b=T9d0FDD4455mbDpNJeN0NA0ABecz/JPMlaQVQzSz3VPeQxhwFJfMPNtPDX/mh6zCcweqdmqmv7y+rf5ymA3YiaRljSRUhap9iVoXzFgX8NjtE7CF423JhemcA0+13gxHZNQgTV3TtTIDv38CZJwuwM3PoxUHcYxLa8//R79STRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723861; c=relaxed/simple;
	bh=LqA6uMqruY93gqaEo7sHxG58d/m7WjYdsDZDQiN4wCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XgdfHJcxgeuNr2Xp3Dl1i14EN7yNNcDDzJgTYKbcgcLLDqw2SALpzTL6NjJH6zMfA+8dq3CkYSRknVCS2p/7jpO/CLSoYpJrZE/i21vxft/z+dpHTjv9cNspjMQlvDSHXDwiicgfq4Y1s/lrLAAJxcBM3veUz1lvCry55QtKG1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NAwnj6Me; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NAwnj6Me"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429a8a27db6so202117f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 00:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761723857; x=1762328657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXoO6JFu6PFRG9ZjBC/NKjZXam02fA7IvjSxlXAqMXk=;
        b=NAwnj6MeAMATmPO2o8RtRveatc6bTE+wqNgFdurGhAEJNOjAMNBfHLMZSnCib+/90p
         Rxq7PeC3dg5nmD/pskZzWIptKs26O2pv825W+Ab8ERMG33zb5pqsCG+qdHjtUJoBk6ZK
         sFKmjpJVP+12fWsAnTrpXdnt9g/rEOGFzyMzoxquF/SnCFmBujvKm9ZvEP63Zlkh38dn
         jRkjmfNjJuBBDw9MDkjtffOQ3E2k6WXa50QgxwLpfcBav2551qPbL0HAZE90op+D7p4i
         00WiuOnui0kS/b8FDqNgJjRNP1rRcrLt40vZTySUVadA+Cg1YOFex6ju+3m0CZOzUBJJ
         AoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723857; x=1762328657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXoO6JFu6PFRG9ZjBC/NKjZXam02fA7IvjSxlXAqMXk=;
        b=MgA4qHackoQaZBmBOORz5xJ+1ce8QRvbyCM1y76oBoFqKKu3Y1b5N5YEhmeU6d2fkI
         JsVZ8fXxjW2RjNWwwXVla5O3wLbEKaRYdfhv4rkxC0PzdsbLbdcMDS/pMOtfgJf1QJGj
         N4WJavAdVPUP2ZlFpnob9jsPrMd0rn0KcrGuEyJ/zdDhpJn8QdC7aEt14DZQsQTuXzxx
         P9BS+E+EdC063HNkltUmM13JjqbckiBzR92pdfA2lzUa6bjKoJQDD4R2XhXH7P7cmcDz
         HEbsrp/zT01Wjl/VBMCI5Htvrfi+6wbNl2HUJoLaQvCulY9deRttWAA6+KifxXMjlQQB
         6R/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4G4aUr7UZ2B1SFUTZTZ2HZCp8wacm9AnlsUZycnEhESUS+0mtiB07B2CyrMsk0+3Xa6nvkQ+vAK5iQot17Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjujFN7C0lfMW71JCB023L1mt0QjYWn1e9ofLISk15TiI7ptEO
	Vlb/O+L3UsrjZiRH+kgjynWHH1Wgzk2GGO7jqjXWbcQuBm8gk9ATz+ZX/tubVQHYE2w=
X-Gm-Gg: ASbGncuvTkrAbtvRu3Ts+uEqOf4hfpGoU0hm6XJ5PVbx0C3Vige5GaxKjlAlzvwnLFw
	4ZO/sa8PxFz+5LWz79o9CFiJiVXrN7G/45nbOZpRcitgJZIb1D6HnSn8Yr3qluY85Ox2fsuKwNH
	bpsrl2H0dwNI1CmiSlq8U/c4/RuWjC5203OO+LMByv4vDbI4tccAmMYM0WOAcZBmFFU9lDdI/Uk
	KV/C8VzYzsw3sbSFHjMcqBh1Sn8DejvHlY4fwocKh8ymDTMJLAfBGo0KQG9gvKzkDL1WLmg2GwA
	Onk1trW+V41GQ8K7sxtg48uElquD7tdHY2yD3Nq7VO0xoSfZv4Z2J5SsLkOh+qUXq1pVt2cRX1d
	x7lKFNyL4kYXylBom2FYaYTpzTvvuy1CV+SiQxPEsXKGNh8a8HTq6Z/3d3Y7OjMcT4YaTE02JEI
	mfFqPa5qZdspjLj9u2
X-Google-Smtp-Source: AGHT+IFtm/W30m4UPSxs1CUdrQ9Pyvb20Tqr6XUfGejw1SOgsIWVpQvgP0VX34renPLAcRaliu0orQ==
X-Received: by 2002:a05:6000:186e:b0:426:c349:eb1d with SMTP id ffacd0b85a97d-429aed36c07mr732821f8f.0.1761723857477;
        Wed, 29 Oct 2025 00:44:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5c9dsm25861146f8f.26.2025.10.29.00.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:44:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 08:43:54 +0100
Subject: [PATCH v2 04/11] dt-bindings: bluetooth: qcom,wcn3950-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-qcom-bluetooth-v2-4-dd8709501ea1@linaro.org>
References: <20251029-dt-bindings-qcom-bluetooth-v2-0-dd8709501ea1@linaro.org>
In-Reply-To: <20251029-dt-bindings-qcom-bluetooth-v2-0-dd8709501ea1@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3331;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=LqA6uMqruY93gqaEo7sHxG58d/m7WjYdsDZDQiN4wCs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAcXDpceFJ4UWTTJW6H+L6eLRlBpRXzhWT7XG2
 PigYAgF88aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQHFwwAKCRDBN2bmhouD
 13KCEACA8xAp/5e78El7+LGOpI37CQuHFgBe9+cJysvBjDCiPXpZJ3/utnbu6U0OudKdF/FDKQO
 OFMsjB3cEFMVi06hwdUk29lanQ39Z+b9MzI43cTmKM/CglE4jtqS0wBm0P5mw1Xd8ugfUY0iu4Q
 r1CwVs11C5kXiSPYt0IukB3gGCudFA54JufX7rLb7CbK6EF5gyfooRxHsla/FlaOD6DgSZuimGC
 RpaIEPi3XI08d/SItoEv8XPJEN6thyHAd40DEqzSB329ju8FGP+5BPwqWZ/Z4WjU71f3BdDedCS
 jShzZB0JSvr/pE5dQHTiIYGD5WZV5osk2B3OFv1TpOJGKvGXnWMnj1kwNSr0QAbNFl14/Q2ZETu
 SANW7Ce4w2bYhQj0arke8PO/xRodzBa94i8TuhC/M+d0R9GxujD5q/HFD+DDKWMFzJQWxEzJ9gR
 57+7C14bCabWLrctEUysRVRrLJ/+j/ynyKev1vNUyURIuqfoV7Zt3YjjGoJkVQn9lNsevFEMDdX
 hReoh24Ud/x8LwK832peE+t41+UXx3MPY1BwXqKk6iUBmPZDvKS5AwizSV7FK+eNZst7qCG1D7J
 /es8PrxmobELsqcM3NBe2PZp4n77lEKD5mH8bzRGB8+BBd81vXZzdDI3R2Fj67niGSbYpfTbYfb
 FuM3Ym8vKJ/4Kjg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,wcn3950-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/bluetooth/qcom,wcn3950-bt.yaml    | 67 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  4 --
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn3950-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn3950-bt.yaml
new file mode 100644
index 000000000000..83382f3c9049
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn3950-bt.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,wcn3950-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCN3950/WCN3988 Bluetooth
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,wcn3950-bt
+      - qcom,wcn3988-bt
+
+  enable-gpios:
+    maxItems: 1
+
+  swctrl-gpios:
+    maxItems: 1
+    description: gpio specifier is used to find status
+                 of clock supply to SoC
+
+  vddch0-supply:
+    description: VDD_CH0 supply regulator handle
+
+  vddio-supply:
+    description: VDD_IO supply regulator handle
+
+  vddrf-supply:
+    description: VDD_RF supply regulator handle
+
+  vddxo-supply:
+    description: VDD_XO supply regulator handle
+
+required:
+  - compatible
+  - vddch0-supply
+  - vddio-supply
+  - vddrf-supply
+  - vddxo-supply
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+  - $ref: qcom,bluetooth-common.yaml
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    serial {
+        bluetooth {
+            compatible = "qcom,wcn3950-bt";
+            enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+            max-speed = <3200000>;
+            vddch0-supply = <&pm4125_l22>;
+            vddio-supply = <&pm4125_l15>;
+            vddrf-supply = <&pm4125_l10>;
+            vddxo-supply = <&pm4125_l13>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index ac58d6598091..82cce508e295 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -16,8 +16,6 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,wcn3950-bt
-      - qcom,wcn3988-bt
       - qcom,wcn3990-bt
       - qcom,wcn3991-bt
       - qcom,wcn3998-bt
@@ -124,8 +122,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,wcn3950-bt
-              - qcom,wcn3988-bt
               - qcom,wcn3990-bt
               - qcom,wcn3991-bt
               - qcom,wcn3998-bt

-- 
2.48.1


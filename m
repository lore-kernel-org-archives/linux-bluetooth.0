Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6EB345CB3
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665548; cv=none; b=qNwjFcI0IXfo6jrEoD2JcAQbVrYD5o1Ndc/tLl+j1w59DLJ+ln7IqSs7eI79q809y2dXnvuybbIxCtlHaczFO8kwYgmTbFxrQXrfBcYEt1uRkB6yju8nxCwxISq5w6ZHZpR55IU86cqHOggX90X8Y5e92aEGDO6FDE0tgVK1Kk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665548; c=relaxed/simple;
	bh=YgQDLq+1nOL6n6+e4lSBPghY2mQNsqIvPf3xLra7UBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iuSf8WO6P590LCqxkv6qAILwIdFvf9An4r/bA479Y4o2mEa99gMrt0oNoIvBrCzB+Z3sm2v4ro7418WrWqnIIUXIbLT78UHp+guc6C+r3cz/pmzEBcyzBQs1p7d78dU6GOldKrAzsMmPpve8lbjxUn8AJiu0WF31FSY+BJtMHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVzkkrS7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVzkkrS7"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429a8a27db6so106526f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665544; x=1762270344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pvnl+2vrU/cihcGSbVbOAtyDAoe0NEWTlAR9xmlQbY=;
        b=oVzkkrS74ENJux+W0GpydaKNVPk/k47yxUp7emS4lGT0vWhxfYP7Bg0jOJ3CHXGaIg
         tad+Yqh5i1uL4uMf9h686Xr6M5JdMwi6AJzQDD54KEgdZK7Z5p0z3BYnSnmiiqMlizvg
         e0xoYzg5aAnAiNvJ7FE6mp/sFBs3wVWXE3/k+s0VnQdCWULCH97GocX2C/u05ug7cfO0
         0qPrm4rrD91hPCec8BdN+s/DS+lslWXQYWdEcH2ulaU8s2GMcqtFy4XAVvR3xnNpeg8m
         /pR3ehDy9rYRzPdx04j/BQgn4mwlMSCVGc/LESnEdigVOYM+fO85Cugz0CCm6w7b224E
         r0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665544; x=1762270344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pvnl+2vrU/cihcGSbVbOAtyDAoe0NEWTlAR9xmlQbY=;
        b=wpd6H0zG3y7GK8yBPDZH1qC+2wfOo43FG3yDpPXUy7v8Uchsf+I6GHGA97tDltlMpi
         nPWTzqCWPrVFrhP2Nmt4rfb8gcUnhF1aMz4yCn848z3eoQVXvl9up821duJ+xykcTVjM
         oxBNGbI9tlzAF2u/WFj4pDgsRqpeftgtyhuIyYKNWqho80mXepU0UAU65lclME8Su7F1
         CDy2p3/rU5ECBuHpF5OSXxKNTfQiY2NR1l79EyeSBqIh9dCZi7swv++Vf/j5S6TkbwLw
         VpA5Xuizgodxndn5L5p+KW1b37i80H4LwSRFnK5HUsNA/NVG9oAAeAW7FzvY1/gFD5hA
         1lyA==
X-Forwarded-Encrypted: i=1; AJvYcCXV5TSSdutpyri6YLYfZv4d5Ax3M6OOEC+92yLdKHPkw5Kf37AwY1DPT1kCa82YMNCDxkybVbHrxZDu7aE0Cgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNwZ3WrlrxahV3vdUSC7OmTFbRr1ju56Z31F/6+jBTM+TFx1wB
	y6TzzaQWmql7Yelod3gZnvjOp4SVsX1Sqgh84RIROeZwdiHhzpDrQtS60TBJTNQnAWU=
X-Gm-Gg: ASbGncvsO5EecZ0dqmOhg7xl/iDaBPC87Vz8hiA/wdmVfAgb2+2qCQyNWGIctY8BLSN
	qpDBvJTOTwx3yEjIpQlSNl82Hvnv/PmdtcPLwUCUlzjV823Np1s7hMddVWPhISO4oGUPcjpNKpW
	/zCCybr2OZmmiW9BlEQeFVsbqTQh6JfhMDlhQfdTm5/vZUmhQyPW022RCppF99AksgFwQnHW0YM
	JuxbHRY7uVYCFsiyt1SVTEwem+H9tdd8zlNDns88KCIB6Xleor+8zsewTGKk3zgQw5+9Ut6ZhWf
	h0/z3JPplZ0Ue9gkzudiQtT6iaTsePx0ACASBchbxQdqKGbjfVA1U2x1qCxjYe3Dq0GMCTmh2G/
	CGDYwqbhgPTcvrAUR3bHsxLkzj9m1j4hfbrEabSz8UGJu6BEqtBcVEj66MjYDrsS3TKm+FsVU1J
	AMNi1qXkoR5EmEEQOX
X-Google-Smtp-Source: AGHT+IGhARsnLHIkkgLv5LOo+7nRPTe+tHleQbp7mgXMyLxxF1a7mHxsNiZjjko7iE38ay0MIRp8Hw==
X-Received: by 2002:a05:6000:2382:b0:425:86cf:43bb with SMTP id ffacd0b85a97d-429a7e7212fmr1932655f8f.5.1761665543928;
        Tue, 28 Oct 2025 08:32:23 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm20844417f8f.28.2025.10.28.08.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:32:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 28 Oct 2025 16:31:56 +0100
Subject: [PATCH 07/12] dt-bindings: bluetooth: qcom,wcn6750-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-bindings-qcom-bluetooth-v1-7-524a978e3cda@linaro.org>
References: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org>
In-Reply-To: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5447;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YgQDLq+1nOL6n6+e4lSBPghY2mQNsqIvPf3xLra7UBY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAOH2AZwbqtwjYhpOREGgP6ZMJ3WN/OrUuuX32
 m7ARv25I7aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQDh9gAKCRDBN2bmhouD
 1+8UD/sF3dtk5eVFvbjoSTmOBoKtBAHywwiZUbvyGoMu+8AwHefBjiiV1SRZ1neUNgYD9eo1bWm
 tSJ3zkMzvEcqNKsyv6/cUygz4f3Mxmc4kY7dnBCTX7h3SWbsv3n5bFqknEGrakaZsOLWG/Dahwi
 VB7R4QXcBowg9UWBRPgDj1mBmGUAPStuYb/F5IE8BW6JzyH3fikaCkri9nHVlDQne/fRNKvnq71
 fgPVpHKI+LvR4JjnbXOPlo31JxBKwMWnHZRgszb0ihBNugjXiIYsIsobdYHKINkezLFx3UblyzS
 zOmCFO48Bfk4hRuUtfrSqq7P1LmPh+deBHPDiPRgNpjy11ssDXtXkGCzKAHrPOUfuV2scsdtImU
 cHK+gcXxLk6vW9EDMCLls8bXVcBxrU6LdnB3VxvEG5cQAtFUJKpY1+kh7z39yjDzokf6DYoVsCt
 tTv7HIsWwEzF6jAotqE6wMgIH48iK4kb+irX18UoG0EmfxWMUIWieV28CeZwKMZ4ouspe56EXbQ
 WcV0NBEpzM9a/YjMGeBdKuglLfscM0UOF/ilugDJg8XNHlsfeYiJID01eTb6jJ5n0Vgm5WzXPNE
 l/mUaTCnHEUfSi4yf7tkAWVGuY/JuolJ7RPCcnBqfwTGeX75UFtJA3o/ZIqkkxTXXR0XNYZIbDe
 dOXXdzjgySbbvaA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,wcn6750-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/bluetooth/qcom,wcn6750-bt.yaml    | 88 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 44 -----------
 2 files changed, 88 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
new file mode 100644
index 000000000000..d26ee82993d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,wcn6750-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCN6750 Bluetooth
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,wcn6750-bt
+
+  enable-gpios:
+    maxItems: 1
+
+  swctrl-gpios:
+    maxItems: 1
+    description: gpio specifier is used to find status
+                 of clock supply to SoC
+
+  vddaon-supply:
+    description: VDD_AON supply regulator handle
+
+  vddasd-supply:
+    description: VDD_ASD supply regulator handle
+
+  vddbtcmx-supply:
+    description: VDD_BT_CMX supply regulator handle
+
+  vddbtcxmx-supply:
+    description: VDD_BT_CXMX supply regulator handle
+
+  vddio-supply:
+    description: VDD_IO supply regulator handle
+
+  vddrfa0p8-supply:
+    description: VDD_RFA_0P8 supply regulator handle
+
+  vddrfa1p2-supply:
+    description: VDD_RFA_1P2 supply regulator handle
+
+  vddrfa1p7-supply:
+    description: VDD_RFA_1P7 supply regulator handle
+
+  vddrfa2p2-supply:
+    description: VDD_RFA_2P2 supply regulator handle
+
+  vddrfacmn-supply:
+    description: VDD_RFA_CMN supply regulator handle
+
+required:
+  - compatible
+  - vddaon-supply
+  - vddrfa0p8-supply
+  - vddrfa1p2-supply
+  - vddrfa1p7-supply
+  - vddrfacmn-supply
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
+            compatible = "qcom,wcn6750-bt";
+
+            firmware-name = "msnv11.bin";
+            max-speed = <3200000>;
+            vddaon-supply = <&vreg_pmu_aon_0p59>;
+            vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+            vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+            vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+            vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
+            vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 93b5e0e38c37..2ee6579aa02a 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -16,7 +16,6 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,wcn6750-bt
       - qcom,wcn6855-bt
       - qcom,wcn7850-bt
 
@@ -69,12 +68,6 @@ properties:
   vddrfa1p9-supply:
     description: VDD_RFA_1P9 supply regulator handle
 
-  vddrfa2p2-supply:
-    description: VDD_RFA_2P2 supply regulator handle
-
-  vddasd-supply:
-    description: VDD_ASD supply regulator handle
-
   vddwlcx-supply:
     description: VDD_WLCX supply regulator handle
 
@@ -105,19 +98,6 @@ allOf:
   - $ref: bluetooth-controller.yaml#
   - $ref: /schemas/serial/serial-peripheral-props.yaml#
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,wcn6750-bt
-    then:
-      required:
-        - vddaon-supply
-        - vddrfacmn-supply
-        - vddrfa0p8-supply
-        - vddrfa1p7-supply
-        - vddrfa1p2-supply
   - if:
       properties:
         compatible:
@@ -149,27 +129,3 @@ allOf:
         - vddrfa0p8-supply
         - vddrfa1p2-supply
         - vddrfa1p8-supply
-
-examples:
-  - |
-    serial {
-
-        bluetooth {
-            compatible = "qcom,wcn6750-bt";
-            pinctrl-names = "default";
-            pinctrl-0 = <&bt_en_default>;
-            enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
-            swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
-            vddio-supply = <&vreg_l19b_1p8>;
-            vddaon-supply = <&vreg_s7b_0p9>;
-            vddbtcxmx-supply = <&vreg_s7b_0p9>;
-            vddrfacmn-supply = <&vreg_s7b_0p9>;
-            vddrfa0p8-supply = <&vreg_s7b_0p9>;
-            vddrfa1p7-supply = <&vreg_s1b_1p8>;
-            vddrfa1p2-supply = <&vreg_s8b_1p2>;
-            vddrfa2p2-supply = <&vreg_s1c_2p2>;
-            vddasd-supply = <&vreg_l11c_2p8>;
-            max-speed = <3200000>;
-            firmware-name = "msnv11.bin";
-        };
-    };

-- 
2.48.1


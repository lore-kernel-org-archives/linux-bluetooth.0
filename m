Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E30D346A0D
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665550; cv=none; b=HWOh2u1EaagWNhNT1VsOJsFJESZbtQJ+QZWYqm7BcupLRDyDuKIRB1WMo3RWlzacL+kTibAODtYmq+/QaXQEa03jsVENRX+Pr40Zx/RF+iNTvuJUgLKG3vry/+MkB9PahcrdGPk7SGT5ioHFsxzx0g0Qrnk7tKfVa3eugv9D1xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665550; c=relaxed/simple;
	bh=+H2VE42VODmiM/EFuz7vS4TQ7Ft2ZHEBfZtt66rOpZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZQnbcCuy+sQcK/xAHW32By1WDd4836jKc3sI/+sYqS1vvdwAVfKNe5Whj3hItyExjhB3qgvktqtXO4JVVW4hq6jK32rt2tI1gHbGqz2mtXwuAp9SDYP0sqLyIi+hHJ+IxviGCofQFlqd9FY6vkMPxbCTxH3/7Tuh2PEaqbPdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qX6swmym; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qX6swmym"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-40d0c517f90so499754f8f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665547; x=1762270347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WtD1sb2KfvqdOU5mWhq+kpLjX1rGG7JVl5sVtw6qD0=;
        b=qX6swmymf+RNUSpxlPNdH22ml2G8VosuGFV9RQFPYulDuSWMkxhdGkX/1yJctKN1bH
         6Lrul+7oy9b53NIVIF9acvYwDjQeSxFsf5ai1NrQ6cBMBXNM3o9e/OlKlP99Sd6PQX8y
         uu+6LX4qnRm+4C2ZDJQvG2mThhaSlRTuHjUPfUAnmjo/gGLYXN1wQsOTYA/yo6ruYVcr
         42CaH/+OJb4NDnofRKio4FTPD0bpH3qZd3w8bFQyH+R1IBRtIOvd0s5IqMf3+nBz/o1p
         VTJZX53qABphZPE+Nh6Yn9xgTSA+EpACVrGgk9FyKKbXGbIN3R73cu0BvROK14fWhFhI
         mq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665547; x=1762270347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WtD1sb2KfvqdOU5mWhq+kpLjX1rGG7JVl5sVtw6qD0=;
        b=FklJspRTQabc284DiTsSymHXVyoGPf1Ao7aF6jt2wmWAaYsKAk43LvTYQCs8DoAzbR
         Ik3i57BTlnCmBbdpXSd8kAQuuoNNz2c1JWlZ3+PD7dXuouXRSmFcb/9R4R5yxgLEb7ea
         NPZjo/yhoXlKrLVH2CQLhzYe0WW9H62ZvT0ag8UJPawsfQfPfaxzu+8lrfjk/cCIoghc
         3bYkBQf7p9rxmdjt6A99nnzuqpNG5eh4oCSf8XCAdyiOT1JT6WwrAUmJnooBa7eIKnyP
         R5YbgfLAw5XlESJfya8p6H+2loDn3hEOTLcnwDYYZ494N+N7CgxTZdwAy05KiR/3trsb
         14lw==
X-Forwarded-Encrypted: i=1; AJvYcCUHi+p1JM9LqfriAFkeQApqhX513UsLb/yvgX0PNrcsqRTZ2oCJs1n/1HNHPuwfHkr282JugozoF4R1sJUz6v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR45/PXWcPS7f/eH3hjRi6XR5QPvMpO/Qt1/DmF2Qu1jMsuD3z
	kWCR5h0RZe8pKkuonF1pStVjqS870arTXDFOPzXZYWvYgLEpRKI0E+anU9ExAvaOPSo=
X-Gm-Gg: ASbGncsYCQnxGOTBGEaVZ/oyGE6bQuczwtgWKU3Ijl/xDDmhHYdq6lQSq5A9YrsHAjd
	Zs/lUMWu7zpOe/HU4icdQ8YxBqIcfG/+W4GGUFM6etaCMgvcui8xGFzR1whY5lFjg0DEQBXoxCo
	V9mZ2njUzjCj33b60xEBFCCrvm9eG5byHXaWB+eZnfDZczVL12vwM4uzXVNRYRfBFwLg562wt4q
	WIkrDFisRuJfKkIBgzdmXGsCNnTLj/YbwfjJa0g4xBj8nlbWLQ62oZY30jT6SSBk2UZ/LMF2PmE
	cWOkGIF/wQlYvoiAQNMqhIv8VDBnH8sNfa4XVG1+wkBC+wTsoi45g2DDFc0R8iamzZOnfVCoOuo
	xIXu3xKHTAA9EEgKBbFrQWQR2GR3rHx67mnnle5ITBWr/uUYxUypfgSrlnlkP3BVFlMPmthvoaV
	pcWD8DRdvD39sGsE5U
X-Google-Smtp-Source: AGHT+IGoT9UNlTxCEY9TLGJWBlT3OLe3n50lUaeK8zYU5NqE1P/LpbDF+VDmQRLumFLDZeelADygFw==
X-Received: by 2002:a05:6000:26c8:b0:429:8b52:828b with SMTP id ffacd0b85a97d-429a7ec333bmr1556776f8f.9.1761665546676;
        Tue, 28 Oct 2025 08:32:26 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm20844417f8f.28.2025.10.28.08.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:32:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 28 Oct 2025 16:31:58 +0100
Subject: [PATCH 09/12] dt-bindings: bluetooth: qcom,wcn6855-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-bindings-qcom-bluetooth-v1-9-524a978e3cda@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5653;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+H2VE42VODmiM/EFuz7vS4TQ7Ft2ZHEBfZtt66rOpZg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAOH4D4wd+4UYJ9IUhaHCnk1Wvu0RUOeLz7H6g
 rg2kwXb7nOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQDh+AAKCRDBN2bmhouD
 1/1KD/0aGocagrlIzLuwwsaEUIpFL/SQ9gZUrSyECNaLOpR7Te1zprcskW3+6dL2eMgzwp1fsAa
 Y2oKVH5CFATlExAvbklU47gEamJF/ObucsT4MuIUtA/LRtcri72CpD2NVANqxdYsdHR0lGrwhwe
 U1SJ4pOS4mCyHg9qy8ZHaOCAMNrOcjw433sPmRMNnaDra6hOtf5i3kghTDqlG3jjWD8on1DYXZ9
 oV58g06sFhmYZtlpHUofzO5ULx1S4wR3itPrhRS8kEyxNy3dLq5cCFispqPXX7p2fi9oVIe1HA5
 pQsaLDe2nnGE2OsjVDz2HugvYJsoh7H9L2f6xZ34M10hdoW6yG4Gn5gmx8eLvArTltiE8SnltWw
 74RTdd207nTNA+/IR8Yt90hI0ZTAYxAjeuhYkUHpr9S4XGbhumCAOEgCNsOngbeOLDTvwDjG2xr
 wXoD12o1Vovn61xFKeeKDlARwp06nmmyKpyJlEIVoP7fYCRwNDlC1G5ZmzvepdUrFGacKtnPoI6
 hQYbdDkRz6OhDqij2ZYvU/fjqXHM9AcLbtwZJzqbayAEfR46eg6pzOz02bkORvo0oqjv5JEsoap
 /tuamdn/OCfIgd+irCIVL8v1pXD4YX1pxwuG7fitxnOW8gDnGxr8mL8hxY9ZyOJKucts40FF4mB
 TzN9PHO/U3xia7w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,wcn6855-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Expected existing warnings for:
qcs9100-ride-r3.dtb, qcs9100-ride.dtb, sa8775p-ride.dtb,
sa8775p-ride-r3.dtb, sc8280xp-microsoft-arcata*.dtb e.g.:

sc8280xp-microsoft-arcata.dtb: bluetooth (qcom,wcn6855-bt): 'vddaon-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
sc8280xp-microsoft-arcata.dtb: bluetooth (qcom,wcn6855-bt): 'vddwlcx-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
sc8280xp-microsoft-arcata.dtb: bluetooth (qcom,wcn6855-bt): 'vddwlmx-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
sc8280xp-microsoft-arcata.dtb: bluetooth (qcom,wcn6855-bt): 'vddbtcmx-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
sc8280xp-microsoft-arcata.dtb: bluetooth (qcom,wcn6855-bt): 'vddrfa1p8-supply' is a required property
---
 .../bindings/net/bluetooth/qcom,wcn6855-bt.yaml    | 93 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 20 -----
 2 files changed, 93 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
new file mode 100644
index 000000000000..fcc1df4b8364
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,wcn6855-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCN6855 Bluetooth
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,wcn6855-bt
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
+  vddrfa1p8-supply:
+    description: VDD_RFA_1P8 supply regulator handle
+
+  vddrfacmn-supply:
+    description: VDD_RFA_CMN supply regulator handle
+
+  vddwlcx-supply:
+    description: VDD_WLCX supply regulator handle
+
+  vddwlmx-supply:
+    description: VDD_WLMX supply regulator handle
+
+required:
+  - compatible
+  - vddaon-supply
+  - vddbtcmx-supply
+  - vddrfa0p8-supply
+  - vddrfa1p2-supply
+  - vddrfa1p8-supply
+  - vddrfacmn-supply
+  - vddwlcx-supply
+  - vddwlmx-supply
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
+    serial {
+        bluetooth {
+            compatible = "qcom,wcn6855-bt";
+
+            max-speed = <3000000>;
+            vddaon-supply = <&vreg_pmu_aon_0p8>;
+            vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
+            vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+            vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+            vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+            vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+            vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+            vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 2ee6579aa02a..ff301798b50c 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -16,7 +16,6 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,wcn6855-bt
       - qcom,wcn7850-bt
 
   enable-gpios:
@@ -47,9 +46,6 @@ properties:
   vddbtcmx-supply:
     description: VDD_BT_CMX supply regulator handle
 
-  vddbtcxmx-supply:
-    description: VDD_BT_CXMX supply regulator handle
-
   vddrfacmn-supply:
     description: VDD_RFA_CMN supply regulator handle
 
@@ -98,22 +94,6 @@ allOf:
   - $ref: bluetooth-controller.yaml#
   - $ref: /schemas/serial/serial-peripheral-props.yaml#
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,wcn6855-bt
-    then:
-      required:
-        - vddrfacmn-supply
-        - vddaon-supply
-        - vddwlcx-supply
-        - vddwlmx-supply
-        - vddbtcmx-supply
-        - vddrfa0p8-supply
-        - vddrfa1p2-supply
-        - vddrfa1p8-supply
   - if:
       properties:
         compatible:

-- 
2.48.1


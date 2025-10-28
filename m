Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63563431F2
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665544; cv=none; b=YCY6/xgB/D9BXmlNxZDgBI32fYG+5aUnx+/TDTUXGAzOZekKsKGAkgGNSFXuzpyU1uusqIgQnfDpnsbiu/NYM0Z9ict00n2UzFbBjgClgE+iaYbd1jXwHBNRREPRVtu0035trExRYdT54CA8+JFWfXJkCd/Xj7WSGS5DYD3272c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665544; c=relaxed/simple;
	bh=iAHEpl7TIckciVRIeHNOOt8t99EJt2/ACKCCR4yCb+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jbLZ5iWqJD6nde5uvXu37wJQNWMlNSTIQ4Hxg7xyNTZs0xX+w46e2h7eGcS3WZMJRuspskaboHtCIX2LuKNh97bPg9qRgh0gk6xT7EdopCj9I3fvXuIQxb7YtkZ0TupZcL7tLjm3+2ejOtrrvg1noStm5eAN1VuiYLzthfRh1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yxroj0xd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yxroj0xd"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42992e68ea3so332924f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665541; x=1762270341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mtyiiz55pw2vkWQMXmpBUp1gFPFtYPKnxSIFSPKnPE4=;
        b=yxroj0xd+EBmBVdx90KjEEvER7rQVDfCX3A9OfDkjv9dPzo8zvLaxFS8Zb5bzSf22s
         E11YVznKAUUpRnsQdbXbVFhxpiPm1QWiDWdJ9MM0F6fHtqcJlVf86BRaUoQgxezEs4hV
         7kdJ5AjLLp5/5ZJ8Q7aZz2mUr59mPEWFZFaTJbXkduIkr2MkdoEF50btArrAbAKDiEWv
         kjciGNxxRAK648BxuftErWrrCUv/FNm1IT3fJto5AzzOuu4RUEj8w901RLu4HZPNooyq
         ig4aE+E/ovCvtIeZHceirmeEwg5cg8IuC1J/WVfWOACG9kwwcuBevf3nGMV2iqGaVYqa
         4C0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665541; x=1762270341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mtyiiz55pw2vkWQMXmpBUp1gFPFtYPKnxSIFSPKnPE4=;
        b=gWCmFHu8nDc84+sixS1JxOjGVzK3cviqHrTaY74kvm8+VcsnCi4UTi1UJchyYRCuYv
         2aPS4T1LY7Olpc3h2LYo3dLS7DDIKiYVRxe1NG4FQMBSzGzy7hNbUHWmdy4SG3GcmQos
         3BAFRu3hxzPVoapPqXIyW2OZ1LVhxwG22dNreQ9HEX/COhB+7EZUcR85V6GZ01jNxFzW
         ZYYjE4KVRS/3YxIE4JdLIPGUA3jq+Y0heZ7oKgOPaoWdMOUQ0Xf/laTn0OIdTmK4S+9f
         oZR77FRvtu7YlPoKCmRLOGbYCJlhuix76IxevbLQR4FPbKgCAp1ZnXbynsROx+CttgaN
         C2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVaWl9ya/StQtTELzsii60ZFnz5RPluhOmo67A7jFyXY31MO8UDyyRxEDMcBUwUkQSoJEMIiE7AtqRBOHOCoAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8HZffjw4luBCKHRM6iSiHkTmZp7WHoui2saL6TZuL/vPNpU4X
	dv2eC+/D7yYu+Zf9LzT1J5Rah9nmGe/gQtTg5w8XIvRmBFKT1wQhfgj0tg5IZZJcfio=
X-Gm-Gg: ASbGnctpsJ6s/6zU/+1D7wQeZ6FLV8i46Mrk6vZrTchiyqYb0YzQlP4COcVdLb1hvsZ
	WVkZwzk+/4LbJnP6eIZq+Qc2ezMH2TTsAx25I9OIKj4cYvzZYiheCfRoIa7uThW88PuOpuvwo6E
	7/js6Vo9EKty/SuITrgKygET79wTjGp9p3huFoB+lIXWv/Ns4I9++yj+LgYl6Xgisb0L/+8Q9fu
	DxHYz/pWjoOcXC2YZSd5BkjPlliLFQyareVhtrObg4ot2sEmLpnNAgKm0Hzow/8IkQPUkAXS8sb
	NxyeFxFynTj747LA3bai8/S5MsXBfwsy+a+gJRv+z5hrIK14O8KYRxEgGSXpM4/khLIDM3UQZE3
	vj4xuYAh2M1/L6/tGszzbJnN8J99jttIPONqfZNrdywyyKVoLv0eJfh5nXxmVNnXqPwi9GdNEmn
	L3Z12WDj+3nmKIRAWUHIYuNAp0zvY=
X-Google-Smtp-Source: AGHT+IEnZ81AP4LAoCrzKsO/T0ICwKG1SaI+rHF9nv5897TY1eIloyLY/7zZe7UaPnue3tAljqHJkg==
X-Received: by 2002:a05:6000:310d:b0:3ee:1125:fb68 with SMTP id ffacd0b85a97d-429a7e6fa23mr1933408f8f.2.1761665541057;
        Tue, 28 Oct 2025 08:32:21 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm20844417f8f.28.2025.10.28.08.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:32:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 28 Oct 2025 16:31:54 +0100
Subject: [PATCH 05/12] dt-bindings: bluetooth: qcom,wcn3950-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-bindings-qcom-bluetooth-v1-5-524a978e3cda@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3331;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=iAHEpl7TIckciVRIeHNOOt8t99EJt2/ACKCCR4yCb+I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAOH1HTrTwMzd3+pZHBefbDXhFNA4rKxD4Di+H
 m/BaVlhSwiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQDh9QAKCRDBN2bmhouD
 18cqD/0W5ZUMUIg2a93qeTsG66JLp5/VL1o5XGoFl+nkMB7T/ARMMYMlHOQO+qIh9TbDam2hGU+
 Qa8qw7zsYLiFkEbZOWyckugHKkKF4Mf84O4StM1lyBVMfuKvpugv3+NW5CEojmi3oyqCTBDy4Im
 S9WqhMBtlZKR0xOL14fVp5SZc2Gbdp5mpe5NWFZccqFuWrXdd8TYnebiXzgj76Fp5nvc+6e+mgN
 hocoV2USekW9QS4bCsRwwyMayKIk8WX9z98ctmK/7Utw8XA2oa64CI05lPZeNFgCybLkQt3yxFG
 +l7yvBwfplUk+MdowGJSRIwThq6Yz/sFuPcOuBguMTcHbQsbhJmOw7KssUENlmT0ZSwzi/i4FKU
 KpJtJ/13H5Iu6h7VSGZ/eBZ2ZLVBgAymakiQ8f1iRNNy0qJnZ+k833Wp/w6NFj3eQoiZMKsiIM/
 s2+2/oo1IEPrOZF5ztXdwNAhWM4tkC84vjv3sZl9iCFiqhvszaH4DOKj2u9OYqfqzUslPjlfz44
 NbloTzfCYh5pb6Fi6qXEAYjF5rTPeeTOdfZKf3wsa5snGn/xb7XK+DFjoel5NsNad7w3zPnyCfj
 cNVSB0F4mw9IX7HHZ7XwrQ/J7nsgZCAomRejJ5GlIRjdW4+CNdKQUBiniX8YWH1NH8JCU5bWoM7
 boSvtR/aNr/4oLg==
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
index e04ff0a8a45a..0a532144f92e 100644
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


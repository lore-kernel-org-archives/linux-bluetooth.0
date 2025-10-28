Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D233F8B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665540; cv=none; b=iRe7Drwt5DmWuAYHWjRinE7BDm+5Muhp2pSFMknwLzveNfVohMX1jkwVjgBKe+guzWfKBQLrl5pi0piEEEuOuqwu1i/ZtkY9bEFRmkans7KBr1rVxIr+ypLqlxT/4mS6xd1vvuhVjTh7FCFvGe4Ct5aFcbRGFbgDchG4rsv5FaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665540; c=relaxed/simple;
	bh=bq0/AuBRe/Atd6ilL0O18VXPhLf+lkVoUl4gltp9IAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cph+xlcO8izGI8/Iw+1sfXqIwXsaJFwK33Evq2tb2k1h8dYpHg6LtvoiM6C2bsNc5a/NaH3FRKZ6dA0B5e8djEFHXSmQ2EwBYlY8VBaXCw0sEJEqJ8mt7eHgJmf4HjTkG4UkKiQfqCFm+oVWaTYpM16dMbvIHtUeqhr3aZybsUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ziptBQmz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ziptBQmz"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3fffd2bbcbdso415006f8f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761665537; x=1762270337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FjOns32ozZ86ZCE/qpPk7ZFAl0N+FBFxsMJbgK6odk=;
        b=ziptBQmzuP2Wn6v2bkIXT+BdI1ADKW9IvoNp38uc5gT2U24tsmryRBMrH7mGbiFSa+
         OIdQKGZPDLWOAzipQlMOlNu1TB1Kn3gNyYcVp6Erlk+kbG40YfEkhlxdGoSpKhVyWNmY
         4w+HcLgw0WnnhUb5+4xhgpkFfJ9cBIw/YFOtaLDmWvXrJ+Oo8B+EKIkTrEKBnCaRu7Ft
         5SCEABhsrEdh2/YkZn/mN/8FjGZ2KpBhpPSYoQKeynroLlLY9ZOz2ZCCs52O67mf852i
         H9Yh9mzE7co8pt9VlgYa8v0LHyHuqT4QqsyGGIHeKCaK03a/ZKvtyoZN/NJZh73R9WYZ
         iSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665537; x=1762270337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FjOns32ozZ86ZCE/qpPk7ZFAl0N+FBFxsMJbgK6odk=;
        b=CEnvz9RRgN2/lKF81aHJeH+J7CBCALGD3+lWkK05BPD1JDV7X33Rz13htdvqgZGheI
         m21/JTYTG0BjY4AlblRFZAqDDM4Rv6sQKC1rfWUtUY+zdyp22fZX9ayiy2GLzRqep8V9
         N/NeyDCGDg7FsjknXqZLeRxgw0z4Mwu3M7hxk2YJDHmFU2P0tru58BOju5tdUuv4TyB9
         SY4v5RVhJ3Mu3w05BKy39w2pdG4h1IkcRQpyHbxTgHclXB4DH7orUv9ON4foR3Is8hY6
         uGHoqtba/m1g5BARWI8/LOSTsHxWqMgn1g6Golr8HW/WFPqAG1n/aLQW+fOGCXdw7InC
         hp3A==
X-Forwarded-Encrypted: i=1; AJvYcCU31UmI6Qd5P/f51GM+br00rKpVUWtH4VoNKg7JehE66VU/lr+m6m+ZLXRa/WX/0rjUbycrRS03jVEMs5UCMOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnXetGtgNs+ofUJXE4T9d/Gk7x/cZB2a0+KKdXN0FxM919jr/o
	NjhhqpvjwxEVcVJTqNt2f1RcI041okZE7Ihn/PBgdV6yUHXYT04slMeG5AuHHG2VsPo=
X-Gm-Gg: ASbGncsz3/om/QBkUvugjdS7jitBTDqY8mKVMa/CpvoJU1uBIwtTowzCkkJ1JGC5O3a
	zWipVavS4su01qya1Nd3AZ6UOwBxg1GeyuyMfR5/JOimDh4BmyDPiRhzXXGGvvfCO/Z3Db89um+
	uApQbDqD7ijJwJcMQXV2Ele+v2D5vdGK8kBp3BYClXBDUotPFWqc7LPj8TVYMv8mAPI7dpawL8p
	Y3dtPiQVV65vAK3CRA2j20GGGjdmbCr7FMKCRY++WDg2TH8Bzw9xBfmOgGIKPNS1Amm1MJ8Fayn
	DKfVpWsKL26MC3zprfzcwArK+qmWmcCRxp6XCtYnNzo2IWa7C+s7FEe8X24jbVcve1hHIVuAbvN
	ZYKABMFdM1NCSBwTiivZAdyacrBFxB4CS3E6PK79vIRqKzxgVeshBVflpMOT7IEKNKFcIaXIURA
	8nlfqAP7DcO8VJkL7B
X-Google-Smtp-Source: AGHT+IFfCe2WoDs7U2zmbXcweBOW9erwA5t7r1uofR9tmnpVUC8T4L1LFZQ8lspkeWdcDo4YWkGHtA==
X-Received: by 2002:a05:6000:2008:b0:425:6794:77fd with SMTP id ffacd0b85a97d-429a7e6f854mr2075596f8f.1.1761665536816;
        Tue, 28 Oct 2025 08:32:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm20844417f8f.28.2025.10.28.08.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:32:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 28 Oct 2025 16:31:51 +0100
Subject: [PATCH 02/12] dt-bindings: bluetooth: qcom,qca2066-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-bindings-qcom-bluetooth-v1-2-524a978e3cda@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5484;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=bq0/AuBRe/Atd6ilL0O18VXPhLf+lkVoUl4gltp9IAo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAOHy47ueH6KoNK8qYnQhLLRyiX19E+C5ACR3j
 9mKRtgq5D6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQDh8gAKCRDBN2bmhouD
 13QlD/9nPCH8vaMFYjU/50yEr/Nrp7bAKZrgLVGQn04jwrKikED2RbjguRhjDkmQk6c153a05Of
 Tq5Mm52DLd+q2Mbv/hB+6DzD7i3Ybui7E+8tdytvQCMb5VIF83tdi+h4gWdLLcPgvztUmXw/gLT
 XafcCvz7O2Hd+vnRKUAz95dnaWPRI30wcDt6Fr3ej9D8lm6Ffhobownq4dwNzziLT4UHup5Xafx
 rrPr8np5yjEEx3VY9PyO1MHoaz7LM9EAKw6FJJorglFK6RLCeBLLaIW7sTXRVeeEoSXivXzHnt2
 BRQv2L1wmG9OFT0QvRQ9w6dEY9RUNr+Ox+xozIuXkXNgzPSeWVoCADx/g5U1yWxDSMHDHmOtQ3g
 slErLgxOcZqWjPGD2rwiIN8VMvUcXLwcrfoddyZz/xFrQ9uWgR2Nq64IMIrobDa+LxRFK0EEW1h
 ivUoI2sb1RLwXWblzayTrQn3r+uCDXoqLn56U4/9o1TaKsd/xCIscvNmTT7nCR4PA+pWJfaauX/
 B7luuZt4Kw3cc4jRZkz+gcdh3UwJ+u1Ry0pwf+Zm6b0y06ICl0uRDkLKTt3UWcgdt7s9yDSNxk2
 +Vy/n4R533L2+f+xudi/TYdwpS5aeQdnVqiFV8qHJMzGloOGWV+u05YWumlzl2NPimp5TCXIWuP
 FFv8NFFo1u97xKA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split common part and
qcom,qca2066-bt to separate bindings, so each schema will be easier to
read/maintain and list only relevant properties.

The existing bindings do not mention interrupts, but
am335x-sancloud-bbe-extended-wifi.dts already defines such.  This issue
is not being fixed here.

Existing binding also did not mention any supplies (which do exist as
confirmed in datasheet) and Linux driver does not ask for any, thus keep
this state unchanged.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Expected warnings:
arch/arm/boot/dts/ti/omap/am335x-sancloud-bbe-extended-wifi.dts
---
 .../net/bluetooth/qcom,bluetooth-common.yaml       | 25 +++++++++++
 .../bindings/net/bluetooth/qcom,qca2066-bt.yaml    | 49 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 24 -----------
 MAINTAINERS                                        |  1 +
 4 files changed, 75 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
new file mode 100644
index 000000000000..c8e9c55c1afb
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,bluetooth-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Bluetooth Common Properties
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+properties:
+  firmware-name:
+    minItems: 1
+    items:
+      - description: specify the name of nvm firmware to load
+      - description: specify the name of rampatch firmware to load
+
+  qcom,local-bd-address-broken:
+    type: boolean
+    description:
+      boot firmware is incorrectly passing the address in big-endian order
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,qca2066-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,qca2066-bt.yaml
new file mode 100644
index 000000000000..d4f167c9b7e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,qca2066-bt.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,qca2066-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCA2006 Bluetooth
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,qca2066-bt
+      - qcom,qca6174-bt
+
+  clocks:
+    items:
+      - description: External low-power 32.768 kHz clock input
+
+  enable-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - enable-gpios
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
+            compatible = "qcom,qca6174-bt";
+            clocks = <&divclk4>;
+            enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
+            firmware-name = "nvm_00440302.bin";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 6353a336f382..0e67abfc8528 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -16,8 +16,6 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,qca2066-bt
-      - qcom,qca6174-bt
       - qcom,qca9377-bt
       - qcom,wcn3950-bt
       - qcom,wcn3988-bt
@@ -122,17 +120,6 @@ additionalProperties: false
 allOf:
   - $ref: bluetooth-controller.yaml#
   - $ref: /schemas/serial/serial-peripheral-props.yaml#
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,qca2066-bt
-              - qcom,qca6174-bt
-    then:
-      required:
-        - enable-gpios
-        - clocks
 
   - if:
       properties:
@@ -211,17 +198,6 @@ allOf:
         - vddrfa1p7-supply
 
 examples:
-  - |
-    #include <dt-bindings/gpio/gpio.h>
-    serial {
-
-        bluetooth {
-            compatible = "qcom,qca6174-bt";
-            enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
-            clocks = <&divclk4>;
-            firmware-name = "nvm_00440302.bin";
-        };
-    };
   - |
     serial {
 
diff --git a/MAINTAINERS b/MAINTAINERS
index be637b9dc7c0..66e9c1f86363 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21147,6 +21147,7 @@ F:	drivers/net/wwan/qcom_bam_dmux.c
 QUALCOMM BLUETOOTH DRIVER
 L:	linux-arm-msm@vger.kernel.org
 S:	Orphan
+F:	Documentation/devicetree/bindings/net/bluetooth/qcom,*
 F:	drivers/bluetooth/btqca.[ch]
 F:	drivers/bluetooth/btqcomsmd.c
 F:	drivers/bluetooth/hci_qca.c

-- 
2.48.1


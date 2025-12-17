Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB36342C9E
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987034; cv=none; b=oHLod1vKqPD8YACHoNfiVZpdYNC6KzbBc+KCSdtr2Ws9d/PZTncxB0AJ34FIS8cpHZ6uoP9loqxPnUsVx+bpMHCOlXUydMl/snI8nMQMXrs7sVOl4oz5SsfiecTudflWBK1qmUaY5aNRf74rPDBgu5mVfSqJ4CzX3et+NiJRNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987034; c=relaxed/simple;
	bh=H3Abm/5qhqqJ7XDAAllxWqCY0GnGn1zpTPFL/41UigM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TTtcJBkmub6Pcv58+neHqfsKli42G9v8LTY6eNAGFJiLZZeO2bj4FKHgmKIAs8zQCvzYCRCjhAJYYqen6RvaSDIc9ZyFf1HHVgNwyw8klMKufQr5NKr0oCliE7dhEgR1e4cvT0abP6Oq8lPdbdAFSq3fiMUBrEcDWEO519kk+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Aplmg/L5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wk0mSP1F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aplmg/L5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wk0mSP1F"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCKoq72465110
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8C0FNRGdYXJJ+V18Mg3H4pJ7DyDS6SIScnFMbejUkcw=; b=Aplmg/L5SkN2JG8z
	EVdp0W91hasHDo8tLO2jA/A1CZqJFEtn3T6rxZV8KMfLJlgM6d53g5YGwxcarDLE
	OrCCkH2ddfWhvzNct5Qgz2kQZV1Gli7ykK/ZDvnJ4DeHKCeJQBcGWOhfx8GMQvGm
	p2+/fo1OfRhG4Y2+xezobPRtGBcrIcUQ+HxSGwqYWwoiq90L3CEh+B13UBX9KvtQ
	wN4ezaOROja2U2Ht7dZf0PylaUFi6DLALo/tBj5SNOs3y2rVff3c1LhORKS6C6XV
	sQNFc4KsxptmtiQEt2kvVqCpTyjZp18qHEQG24a9k5vno0xN/yaDOALxfWXHXMId
	tjdVRA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3fe2b32b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee3dfe072dso151760591cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 07:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765987018; x=1766591818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8C0FNRGdYXJJ+V18Mg3H4pJ7DyDS6SIScnFMbejUkcw=;
        b=Wk0mSP1F1hfF5JsWjrIMZDEIok+i+ypCvqXe2hBuQR6kwt7oAJqRZdyWdrbgJeGsjO
         9PcVekjdkuAsIf3vMSXt5x2OOGo5/fUvtEvI23T7Qil57tsoHaSlcE42z7zsZLab25yp
         o33itGaD5LpbB+0oTYcfLQVejubKzYqMV2SEt2Z5RsGFndotuu0YAVtH8skD9IAVnAm+
         hzIPkXZyxwQm3N7GLnGFnD2biJAI1f2k75iLiyVVGAiQDmTRgVcAHwIT+H7AFvHYq5EA
         mZARm6DktLKN9+8Pb7xbOCEqddnzZf2QopBnQfUjA505srVG+GYnJDXHDhmdEaz/T1Ut
         Jc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765987018; x=1766591818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8C0FNRGdYXJJ+V18Mg3H4pJ7DyDS6SIScnFMbejUkcw=;
        b=qSdxT6f4ZyL/FIUaEKEm/T6Uw+O+a52f8BugcUS6rR0mGdhv51bZR9RNhkEW5Hv5vS
         4FY7HscYDUV2H5AeVl7FMYKknxYMB5tdQQYQW5Ihnp3HhXaFKUMWBv1HYR09re6scGrA
         4X5L4yi6bFDXFJUhfaktewfaYWcxyPV+mC/k1ZwwLN1oGc6x8K3XxOV7/pRKJp6olNy4
         Ki263V+lZox5PVqjKdHIldDa4iT6IUjtxhAXe5JI66qWBXGOI7O9MQ20T8DR1o3IzEWQ
         8XHaK1V8oocWT8Cl+3eJEwYWehwugkRg41sYfNKjNjFfiBfCOscWGOWg6AdYdSb1UYc/
         PJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCWUvz618fejCIvIy407tkNyd1GV/NYGtCb7PYH2N/2iVQb3JXxxgPX4VTgkJT5HtVGoTPA5G/stbOAIFyfxlR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNo8jjqhUTHFa9/cZNNI71w7qTWJsSqRHJ8ANTQwpF8BCjX5ro
	4dY9drk7+HTx4SysDXYMomr/wL6zCBjWevEkmenGSISpZgmGfO3chhN0KwcESiiv/DrSKZVYrwH
	GVLxyxwwMpxdsenX2JNjChjO8rb0AAS9REzY2WGBMOJwXQjVQhGxjLd0SW0git627exd+Dco=
X-Gm-Gg: AY/fxX5VxjCPBTfe5wDVGlQjeaRNihNRoH9p06+y+BoQ01YkMwYWxunlQ3kRGsdFUlB
	9o6X+G6wEawbnOnbc6NrHWtiPc/ntDU8TNWDJ777Wzq5cPd9te+URB9Ah8Ehyz9A/Jh73roUPiG
	0BWWmbRWgUoFLWreACqDngmz0T2fDoIKqBa9FA1OuO7mniqWWNQWL8bx5O/xFb+QX2KFSyJu+Ea
	a0ZCWIBxCkqGaH7DNrdEGEXYclwAP9Rx4I1fHaTm8yWI0ir9jRFTPg7KIHvHvqmUWdDfxiDIw7i
	R9v1zcy5MvoZsqVxPL8pgJEbcuHydwmGawG2OexQ0Vf92mey6yRlJ538ItRauCh704hX1pZarSA
	k0i6tfkIKw7emx0nfsTKw+kfCFKTTgm4j
X-Received: by 2002:a05:622a:2ca:b0:4f1:adf6:5b77 with SMTP id d75a77b69052e-4f1d0629f65mr241852821cf.59.1765987018065;
        Wed, 17 Dec 2025 07:56:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu+VJ+6saLUD54tE8Lw0z9ZukbBdtlmO1hYoN/LclJZ+hkTflcaIjbYIQuJ9CMjMpDGRHZDQ==
X-Received: by 2002:a05:622a:2ca:b0:4f1:adf6:5b77 with SMTP id d75a77b69052e-4f1d0629f65mr241852421cf.59.1765987017503;
        Wed, 17 Dec 2025 07:56:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeeef6sm5439800f8f.32.2025.12.17.07.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 07:56:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 16:56:28 +0100
Subject: [PATCH v3 10/11] dt-bindings: bluetooth: qcom,wcn7850-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-dt-bindings-qcom-bluetooth-v3-10-ced8c85f5e21@oss.qualcomm.com>
References: <20251217-dt-bindings-qcom-bluetooth-v3-0-ced8c85f5e21@oss.qualcomm.com>
In-Reply-To: <20251217-dt-bindings-qcom-bluetooth-v3-0-ced8c85f5e21@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5142;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=H3Abm/5qhqqJ7XDAAllxWqCY0GnGn1zpTPFL/41UigM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpQtK1a7sk3/HkiUEPLPe7H4LbZ8kVqwRAJVZmv
 iqXg9u8GoqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaULStQAKCRDBN2bmhouD
 1zBHD/0Y+TW6eHDiErvVVoRp8s+ddRxGku+bNFXc0g3WDVh2KI+uqPZ1RgDtPs6J017dwRgeNej
 wJP7A4cdVkAlUwe0nduuen3u3lE4GUwImM6XowGJTVPF5NNyZ7i24RXV8RkUWSuAxPxFKJVxDkO
 tTMra5f1sSPYqm5VEe4yIwmbuwNTuJjBEfxXVmlNTHBLBk8TFNzwRyBlwR0IFwRbWj8IGHKfWyQ
 p3IIh8GS8iYaurhtVoWb1TgHFJ9Jx0UbaI+vCwi/wK+FOHIXju9iR0nntg//LDffoBXhDaEzmZW
 vt/OQblAv/A3IsLrirtZwxLJZ7dqMSq4MQVdwANDyKkQhf9WkYltclnEQjlbyZo7HMMIkVk9vLM
 5wVLPMjFOEwJJCVyByTda3Wg/KcA2npwNIR5VfuC7qRz0wlf/mtPpn15RO2fM+P82n8YX2Duk18
 S9kthRpGKgDEjR14yLRHq64+yKHfzqTN7BRouE7azBeldwU1+0QQ905q6Z0o2H56J9rMM/hYxL/
 /enJg0VVEUqwxLvdPSY1hJvlgSUdftA11u0ScBCdzVIJ2g5wqYO+ST0JHArgiz23tdW1MB2rXGV
 zh+yDu3ylyBwoBVquPlS3kAU4ZrRvTujDcbJ0QlbKT2p1chQvEoV4oLV2a0izNtLQ2zirSFM8wj
 +HVCuAXddXoy/kA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 3onluwyXleh5gIJMy8CI9sdaqhUSXAom
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyNiBTYWx0ZWRfX9ARUfHTVe9sV
 pNiWl+D5Ui+rZhjbX9KB5SyNx1Ez+Fp02+ZC9fAZH6amKroS+MLEOuQ8NtBjbB8nLfoPCSDW0hD
 Dlhgn7+dQPkTY4yfujETWMLrVVAPCPp+yB862iAhfhtfTu2ErpRWMSdU0oJabpI0zoYO/pMy/Lr
 HCE5XzI4DH9o5JnYtp0TSUgI23lwn1xrB/tMwynYStOhqBCUss6BsDklfwEQPBlTf+iPZjfochQ
 ipsblNEDmXzHiRUvMQv73LG3BgSqMVxmbJ2dGb6U4msihU3PWNyDAc7TtzopiqT9GGfDRwXhIBM
 y4YxQoR0Lo++mHW5j9nKnHsf3pL/ZMzL6wWRxXXbXtY/jyvLM824yLvrgsENMDw3E2qdtwExSDl
 TO9Zd15Eu43nJczDCSrv0/u+XQWNIQ==
X-Proofpoint-ORIG-GUID: 3onluwyXleh5gIJMy8CI9sdaqhUSXAom
X-Authority-Analysis: v=2.4 cv=HpN72kTS c=1 sm=1 tr=0 ts=6942d2cb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=hmARNUlj3OVxZ3RlbIsQyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=qDj0VXvLrl1oAwiVHv8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170126

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,wcn7850-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.  Re-shuffle few properties to alphabetical order
while moving them and drop redundant enable-gpios description.

This makes the source qualcomm-bluetooth.yaml binding empty, thus drop
it making entire change a variant of file rename.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---

Changes in v2:
1. Add also Bartosz as maintainer because he was working with this
   device in the past.
---
 ...ualcomm-bluetooth.yaml => qcom,wcn7850-bt.yaml} | 83 ++++++++++------------
 1 file changed, 37 insertions(+), 46 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
similarity index 57%
rename from Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
rename to Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
index 62d7cdb67a3a..bd628e48b4e1 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
@@ -1,18 +1,16 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,wcn7850-bt.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Bluetooth Chips
+title: Qualcomm WCN7850 Bluetooth
 
 maintainers:
+  - Bartosz Golaszewski <brgl@bgdev.pl>
   - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
   - Rocky Liao <quic_rjliao@quicinc.com>
 
-description:
-  This binding describes Qualcomm UART-attached bluetooth chips.
-
 properties:
   compatible:
     enum:
@@ -20,79 +18,72 @@ properties:
 
   enable-gpios:
     maxItems: 1
-    description: gpio specifier used to enable chip
 
   swctrl-gpios:
     maxItems: 1
     description: gpio specifier is used to find status
                  of clock supply to SoC
 
-  vddio-supply:
-    description: VDD_IO supply regulator handle
-
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
   vdddig-supply:
     description: VDD_DIG supply regulator handle
 
-  vddrfacmn-supply:
-    description: VDD_RFA_CMN supply regulator handle
+  vddio-supply:
+    description: VDD_IO supply regulator handle
 
   vddrfa0p8-supply:
     description: VDD_RFA_0P8 supply regulator handle
 
-  vddrfa1p8-supply:
-    description: VDD_RFA_1P8 supply regulator handle
-
   vddrfa1p2-supply:
     description: VDD_RFA_1P2 supply regulator handle
 
+  vddrfa1p8-supply:
+    description: VDD_RFA_1P8 supply regulator handle
+
   vddrfa1p9-supply:
     description: VDD_RFA_1P9 supply regulator handle
 
+  vddrfacmn-supply:
+    description: VDD_RFA_CMN supply regulator handle
+
   vddwlcx-supply:
     description: VDD_WLCX supply regulator handle
 
   vddwlmx-supply:
     description: VDD_WLMX supply regulator handle
 
-  max-speed: true
-
-  firmware-name:
-    minItems: 1
-    items:
-      - description: specify the name of nvm firmware to load
-      - description: specify the name of rampatch firmware to load
-
-  local-bd-address: true
-
-  qcom,local-bd-address-broken:
-    type: boolean
-    description:
-      boot firmware is incorrectly passing the address in big-endian order
-
 required:
   - compatible
-
-additionalProperties: false
+  - vddrfacmn-supply
+  - vddaon-supply
+  - vddwlcx-supply
+  - vddwlmx-supply
+  - vddrfa0p8-supply
+  - vddrfa1p2-supply
+  - vddrfa1p8-supply
 
 allOf:
   - $ref: bluetooth-controller.yaml#
+  - $ref: qcom,bluetooth-common.yaml
   - $ref: /schemas/serial/serial-peripheral-props.yaml#
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,wcn7850-bt
-    then:
-      required:
-        - vddrfacmn-supply
-        - vddaon-supply
-        - vddwlcx-supply
-        - vddwlmx-supply
-        - vddrfa0p8-supply
-        - vddrfa1p2-supply
-        - vddrfa1p8-supply
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial {
+        bluetooth {
+            compatible = "qcom,wcn7850-bt";
+
+            max-speed = <3200000>;
+            vddaon-supply = <&vreg_pmu_aon_0p59>;
+            vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+            vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+            vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+            vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+            vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+            vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+        };
+    };

-- 
2.51.0


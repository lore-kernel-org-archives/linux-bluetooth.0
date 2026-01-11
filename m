Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59AE34C811
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768146574; cv=none; b=dKRfuqUwqcNn1FXH3wJnFN06/5kzVgy7KOnmbVf8dItftK14UKEn0uJP84b05XqGFoKTYeELX9VIMfD8Loh4uTata5x+aLJPCSpyMcF+eegyR/ZyTT8YNNd6ktHC/9/OTnpJPw/vqyJ24EgNEvS1MpjlcHGm8bZeXFdNzhHwAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768146574; c=relaxed/simple;
	bh=Kg3E6w8AvmBMhPePVxwuQA+Op3lrUafQfbcxbLq3D8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5yXQCy0lJ94PnEOtUCg+0f+nr7l5F014NzXfr+ko5dYkkh0GqOHKGKXVJEftCGM8Bbb9Ig53cNWScASRReupaZwLqa8yjhhrdicqeCIpPYI6YHjGgQyLpkEust4ah25LmJ+KmbVJCWvCxg5+EmbDA2bly/cfoRjF1OXT0HOAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UD6sCSv1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WicwzuOZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UD6sCSv1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WicwzuOZ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BCQeoO2379680
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e99JVBAjx6d45Z0AC8ohH6dmyo5PU4YPKSv8XsG/wdU=; b=UD6sCSv1+99hd2yq
	royFH6kYDZjJ52WxpGPXVozW0GJtZU3odbgWbvHHVeR133SvfTrJ+pq86kLOM3CV
	AeMNlA4Xe6P2BFZETnRwY9yE2mbw1z0NMQSUiHxQt1rD2D/SiTL9xPUX5Sjx8+dn
	B2/LEW2CeJbgii3UJxXj8igewfDt33Uimvq/Ei5pVDy5yPHFTCEZRDxfE6uz6DLd
	RaFHmnC1ZLbDlbbGrN5MvJ4KFkvVPTlcz03RjxxiQ/p7XPzGj8CeNhnDHsAqIP/c
	jwxUDpRauUbuA9pSbfdcGY9beGsy/OmMhaW1t/Spq3oZiO8OnP6EN6eUeQj/3yZF
	2sBQ3A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkjvxt2mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b234bae2a7so1619910385a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 07:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768146565; x=1768751365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e99JVBAjx6d45Z0AC8ohH6dmyo5PU4YPKSv8XsG/wdU=;
        b=WicwzuOZDokpXh/Xe+zPtPR1iWAHL6920g19hTYQM0KeQQE6dd3ofLEz+xXeCslnNV
         mMOfLWNUTy0Ptq+p0Lh+mr/aaOVvXvqdqFdyroOm9Q00H3DoemBjcEfYm1sS3YMtYTyr
         BPGheeJFNEgZqp2DWZ3tTiKzCriZbRLqu9Nasu0U7DQeVMMoVjrJuKRPUlGvaWheB5dJ
         2y+dVm4DYIgJPQ2g4ER2fpO43wVp773lAaLEaJjYf/dMQzJxnTshYjP/VexCjd6fFnud
         pxK87SgD0MDYHxRZUMcqF7yP/RrZuOX5tSNjO3fsALQq9/2fg173oltkfVimCwBu3l8t
         tVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768146565; x=1768751365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e99JVBAjx6d45Z0AC8ohH6dmyo5PU4YPKSv8XsG/wdU=;
        b=kKjqaPmoZdbmyRT1zIEot2rnICBbz+IALSMqeMAEXcOSU3R9YPJdmz+qqovdTrnNM1
         zbWN5PrzbVBWq/momtc73jq46kbYXWduM15dpUtgoUVIyQ5XA3l3jC7oagSbeE/JeXhU
         s9k6CKHj6ejU83UPUlwowSi5PXg59k1QXf3D6svWpQkqEf/N7ABD3TDCy4xXUcAkNyl4
         igTVv69ERFxO5nqqV4eq8kjL5d/bg9sTp6ziBVGwPawlC6p+ESVLP3Yt20wn1DIrReMS
         Vejc6n2KoAvNDmMgvjQV9U9UpyYQPhMpaPFFF66kPqIIgx2PeI0klqOMDexVBEnjQDWN
         +FvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqoF05bsDEdwwud5etRXsM4Ow7JeOlqAI+hrcrjDMpWpnE/1OPF+vASRUmgbtBQRgKPbRwFchZtAvc5ZMb1CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK56sAF0g+JbK2FOeoWqriW9xUJFTlBo5I7H0aIrqvqzRTGI0A
	pLGAiOLGL250WEtMV/C4ZMfmSzAlMpY43o4PqpLXpc8TwZZPB8S4pPN75hVNgEXdbol5b7izVQb
	d1ZeAKyyjEJloWIF3sCobGLFrRTJmPGZCCEfGEdRRyT1Ufk8lrPWcr0l0a+TkWrdw+xL+uaI=
X-Gm-Gg: AY/fxX5w3IpAhEpBcWvsFYgHuVxS4mdt4sff55UDt0w7usviCwHdNmIuJWgaXtgyYOt
	VtReabGsA9/5bpbnuHH+qf9GXUy1Yg9aaWCMW4ZFDKhYyWTvyXXFJtqU7/CfNHgJOiFN4iauLGr
	To+eGKk2Ier/DRSMdUuAY5ZVGYDDuzyQSVEVy0D3jPSjBcgzn1sSSzcEoosdJNJwOW5q4s0+R2h
	kNIbV9F5pguA0Hy7CQK0M5Aki1LkEgt3PFytE/bpTUoO3RYTw/U4QQOdDW7+53BqOgrhTVZ6j7Y
	1jnEpgncKeLjvJkmcPNGu15K42e/CmAW3u6q3OMYJKqKGQHMb5FT7YMp4oG0M5gW6RBg7ik5/vy
	/6NGRcl4+h9lCiPaBLy4GO27IUDnNiXQAgA==
X-Received: by 2002:a05:620a:370d:b0:8b5:222d:ce3b with SMTP id af79cd13be357-8c3893ef6ffmr2333082485a.52.1768146565499;
        Sun, 11 Jan 2026 07:49:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqrfsmvekRYPQdGxOqKti3EKucJQdry3/ICFNHwEAlACKInSYRMevFttHORCtWZRPzeo9OzA==
X-Received: by 2002:a05:620a:370d:b0:8b5:222d:ce3b with SMTP id af79cd13be357-8c3893ef6ffmr2333080285a.52.1768146565010;
        Sun, 11 Jan 2026 07:49:25 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a5180bdsm1637163166b.57.2026.01.11.07.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 07:49:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 11 Jan 2026 16:49:01 +0100
Subject: [PATCH RESEND v3 04/11] dt-bindings: bluetooth: qcom,wcn3950-bt:
 Split to separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260111-dt-bindings-qcom-bluetooth-v3-4-95e286de1da1@oss.qualcomm.com>
References: <20260111-dt-bindings-qcom-bluetooth-v3-0-95e286de1da1@oss.qualcomm.com>
In-Reply-To: <20260111-dt-bindings-qcom-bluetooth-v3-0-95e286de1da1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3507;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Kg3E6w8AvmBMhPePVxwuQA+Op3lrUafQfbcxbLq3D8I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpY8Z2jsHD4bRnyxT6kzC0O6FBl66kwLfVM3n34
 ju5LLzeb86JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWPGdgAKCRDBN2bmhouD
 16cWD/sFp3yQABQKXLWg9zsShETQNl3ED8jWSa/DyOzMr4VMi3YhtHvtQAQfM+CuC53aBX3Fczr
 uOtzb17RuwlCYVKVGnmmLlqWBUF4Ba0XO6a23N2GSV8jDf6oerfkqCLt6eakMz2+mEJF7zIwTX3
 rdCZZ4C0kM2CX5nDwt1u7josL7gI0C21ak4VM6scH8mmv5oPIIb/sWBLm8H8p71C9DaKDSueBHS
 5lLgCoxHpiWqiJBNTx3GJ906i2lYY2fQ7o7f1QL51Z88w6MU1ipndhMA+kMzwyHDazGnkasVMbu
 PtwFj4a3w8UtcwN3FIec66UY26nvDTVnC0XxAC7VdPjfZe0gol+SOLuUlRgEo23VwSRWJA6bvqU
 q5cKizcmMGh+agPwPhdf/NhPPUzYMWjXA1RxTV01qtvxiholAld4AokFacBZEVKo6fxr4eMAwXq
 UGAbklO7aN1+1ecDL0/4emJvKxGwZzv4/Aslji70clbylWuS1Vj4oIaRoxxalDtLSwz0AD5t2G/
 97apEVgUxA+nJEujYwATBEqEGryHmEyhsqbxWy4C83baw6oidiH5IKj5mWrHaYZ8xONwX4XZRg3
 CZokGMVXYs5wqhBrWsPCAqdbjO3W2akKQXo96BoRJIEhSOAZzBZbJNRq8X3TfGxVzEHSEDYw7dC
 d4zMox+8Gd8xpKw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=Wrsm8Nfv c=1 sm=1 tr=0 ts=6963c686 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=FgqxZbEHGC4e9CjquwUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: -SKdrVs9hoME3g44g-fW9JXF-oRMKb0w
X-Proofpoint-ORIG-GUID: -SKdrVs9hoME3g44g-fW9JXF-oRMKb0w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTExMDE0NiBTYWx0ZWRfX+5anfXX5wOvY
 f1ra1tq56r9s0St3LrgWkuR0MTw6h/wQGbctNEDR5gLUBcR1jVGkMUHzvTsfp6xlii6OKljgedF
 SDwK1gWoSDLw8mDvl7TdhGvZ/nG/0W7OXo0oVAkEC/vvS1npgmgxmUCNe94aRA9aYWNCKwdA9/u
 lv+eskk6/vPtJFpZ7iqK/OdBuUBxgnfKa2bWrP2gY3zkVTITY+kUX9IHDP7HjRUZseSf2R6bUs7
 7xWxhV/i5Cp3lhGAev0aznNLRyvN6zXH4E9Tgm70MyQM2Xwnicm5Xfr8xw8d8Jjthlfa8rg0RYT
 B6tm3O52SXTGyAasy7WFhXRRzY+dyLw75Pe6I2alGWZGf1EFnqqod50gcUbo4hfG90yR5XYiFxh
 T8TZhjNeRyOTmdnHAZuojA8DWacr/469N44qq8GtlpxF6dihP3t/IeUGhd+SaBQIcqFeJ5dxgOJ
 ZjLKb7snRP2TtRlvXyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-11_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601110146

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,wcn3950-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
2.51.0


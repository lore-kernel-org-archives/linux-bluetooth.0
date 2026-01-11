Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1434B19A
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768146573; cv=none; b=SieFB6pqBAbmS1pcule+I38c9l0Uy7y/oVJ5uDlkE95QZsgGFkd0rw15vtl3GSHlwUaSVBuVwrErtSkSv7zM1vgzXftbR+qxLkA3BT+KwevlkRtYYATY9vMlW7d7c9e9MLVpCmH+7yLRUrzfsj/htj32aFvF667qj0hpA4fdkTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768146573; c=relaxed/simple;
	bh=JIDJccGK6VCXUI5GwQl1csj/I7WBbeD2m5Vc289HB7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lo44rpFcE3FyvIvSWjm1Relr/mp89fL53vdYgd/9QxsfEL59rubqagVH0zX3lhufS3WSQQCvOIS4zd3vjQzAtk1dLwWiAQ+qvFeCd2I5HGI9k7tsi97D+z4b38o4sROzPhUevECMw7Z+s/RLktcRVrHjtCgTwMM3K/hCpMgpjCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R1QnqXQk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bTpoXT/A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R1QnqXQk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bTpoXT/A"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60B8nES03826312
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q1kYYrCUUghjJloQmbk2m2RGCwULA9YSBVRKtbqC1nc=; b=R1QnqXQkTzRhjCts
	8u6NE1oPVSrcHA8ok3BM6UV+c0etqmLJZQZqnfJ3E+PCI+rgQ8bObVDkh5j7CzgO
	xgCsePW6hjMLlz4MCtUEuNHZ9tMyADfBUt5guF7w2jlo6U9/GcDUKQXmQUn2PQAg
	dMpTb6CMlNEnhQpj3B/XehmXYO0rG3d2x1QTyiR48XwamESVqx69QyWd5ue0NUzU
	Ec+NA5pDQr/qbhtah91e83Fx5vCkloEBtmX13Sb1+14rEzOMla9u5NNIZMaqWEng
	dGX9tDKBT1w7vjSsvLB8bbAzt4+Nja4cgmYmVkmDR95J3CAlzyxCGMJGo8iKJIuW
	Hl7RsQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkfxftb6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8bbe16e0a34so1372889485a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 07:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768146567; x=1768751367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1kYYrCUUghjJloQmbk2m2RGCwULA9YSBVRKtbqC1nc=;
        b=bTpoXT/A+U0fOo5NjRkd9YJUgIPi3yUWCXYDrc0fwmjrb/zNNPGnKGvOjLRC09ESNV
         A9+FQXWGdjIjIWTdmZ9kxUPlALN1sT6fxfGFAntct5uVMcPKzyAC2uk52hkfEBVrvABs
         xcemaUNWm8TwpHdrFdMCx9A/LeGuS30q5MlIGro3Vdd2l99FtICtjWXb6FOoUwGCqpMz
         xzyBAXY1l4408RAHhNlkqIWVaq1I+IIqyLn3my8HSGcZVbGHMUSRBNc41TLYcCqedl+1
         7MfSHm6l7uP5RSCJ2yflVbS9H+sScgL0MKTLUH+zbUtXS9B7VbvkqfFCkmbTmsAGm0Ti
         I0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768146567; x=1768751367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q1kYYrCUUghjJloQmbk2m2RGCwULA9YSBVRKtbqC1nc=;
        b=pIMh8CZbKwz2VzGV0oXFXvEm+8d1MhocbckfXKGpYsBe4roCnuTxqd0zh3Rzh9YHka
         Pp/7AhURYxKoLzdgS+9udsou+t0CxDFM6rpRUq4B2tXuLSo+VtPcWn8nW9/xCCHH6qK+
         76hx3uSrS0s/7GooexgumUfMBZ37q351Qi1uBxrXO4qHOUMFJ/1iDj7zH//aEZdzDk5d
         Ut+mB26+4VKxUj7mTKemlU2pPVwdx5JFDVLFOMxFfwnp1pjuf/OSb5b2ADSNpRV6nn+i
         rnZL/Tpf02mLd/Iv3Bry3FqHlNfwJsJaKPQ8G5nrVGbieDVqGEc7yQxbWs0oe3N3TRuc
         T8rg==
X-Forwarded-Encrypted: i=1; AJvYcCWeG7K90vUK/5uCNFrmPDtkTvw1z5wx1O/SAKUpGbU4MJctOSejeqKwuTWcnleQEudXa/+kCeEYCNTl+ZWPQrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh5p4sCZqmjdqUEQDMG64JwpXY7NYgbc0o7Nuktd9dox5jKflw
	0ARhVBbkbDPgA/o1WWW5yUCND04e24N24sY5c5wXFKQ5wYI1i3S7cR2CDlI2oXOd8DHh1C+O3y1
	VN6iDAlB4SG3snUayOS8p0B5E8mPMZP5q+XwWHB4mSoyMACplFt1yZEhO4am5c2d7QcDkzf8=
X-Gm-Gg: AY/fxX5pui8O00gDCF3F9B/fCjnWnPt5YAEjIRvX2CgeQJW8NATTZjLfs6tI/0Z5ZdB
	EE2e/w5Fw76viJ6R+f+6wpQsv7UR79lmy40dYJ4jSY1y1wsSCnu2KmRMlx9AYxzShX55jIEPnlN
	u1sOwwLF7XcE0smtZ5f+MmRJQC7UnKJ4m4buR2ebZYfT4AuoXpw710NpcpthF5nE2+lUsPelDvt
	XGnXrfUscy50I6Gv7nypjfT60HCFzeRClEFUPcMaPg3PkMugllTVAarmF+YyrUl8kLYxa9qmidE
	MAjjbhozCaMwL/HHBNYVW9g132pWfOPqytVmDWyQ24ju+m9k90HXCEhB1Hct5hI/WqjMV6xa5UE
	5JiIM6e0/zvLBwPZwc4RqqaZ8VRxS3x0W7A==
X-Received: by 2002:a05:620a:700d:b0:891:8c16:283b with SMTP id af79cd13be357-8c37f4c2b68mr2726975385a.9.1768146566960;
        Sun, 11 Jan 2026 07:49:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzq8ZGzt2rNPXkPrZtoXzEJSxDqHFRUmnm65uLI7N5xGOXTQyLaaW/jPA669AxROOGZSrf0w==
X-Received: by 2002:a05:620a:700d:b0:891:8c16:283b with SMTP id af79cd13be357-8c37f4c2b68mr2726972585a.9.1768146566516;
        Sun, 11 Jan 2026 07:49:26 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a5180bdsm1637163166b.57.2026.01.11.07.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 07:49:26 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 11 Jan 2026 16:49:02 +0100
Subject: [PATCH RESEND v3 05/11] dt-bindings: bluetooth: qcom,wcn3990-bt:
 Split to separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260111-dt-bindings-qcom-bluetooth-v3-5-95e286de1da1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5226;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JIDJccGK6VCXUI5GwQl1csj/I7WBbeD2m5Vc289HB7I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpY8Z3fbgOmqhVJhXJHbHWh+GpSF6cw30/Kvqon
 lD/z3CbouKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWPGdwAKCRDBN2bmhouD
 18sRD/9NbyfiSNsBYdFncL15gQTgihmHSHOG0zC6GFLa4vsQGbWwO53z1ggQASPWpHOu3T/I9vD
 ev6GRcA/bgl6NTpg11g3SE+ICXzbuVhQIzZ0E2D5jQCgIhU2Eufn+F+3TTFVtIstw3z8tYP6ms8
 BhB4kWRDVrHhoP4qUTbkIC87lt0q1wDOrHKLLbO3fgTbLVVWi49KubbHv8gCi14uwrkKfN2Jx+n
 sCBF68Ug4iUFY/LFvpOGfueZO3kiKom2gmsG/OpU9CClgJObB40r7LCOxEjLf9ASrDSIVCgrJH3
 qiBXZ5+O2vZcKHZGR+q0s2fYe5p95BWXXPL8JMC9kszsQ+G28x/qlFjyEVdVZQqGBWQAKtYv4K5
 lZsJUqmEyKhbUwK8zW3V6yChbD0bD+ai2YBSvux3jYGJAhZAdCdKBmH6Bq3uq/Xxlh2+oVU0DPI
 KiZxxUH8L9A1Y57CmfnlHvOFOE00S2G07qnsI5GVHylnABP2F4FX7aQuni6nh5xvls4Vp89g823
 LHfUtui7VE59zVWg/9ThKN6ApCFLDUH2J8XVCRkozvGK32wTtFNBH4MmlB4UHlH5Y5v0AVZSCau
 tqCnSiddT/lfgQqqYKAohNrCF/FGWIuO8rn+XxWvfLG6Sx8ixwJessV+UGL4R7/+IQ8Mg754A+r
 msJpBNu6KY7Ih/A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: aHypWaKUMHuClw6pFtCHAthMpiXziCZp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTExMDE0NiBTYWx0ZWRfXw8Zeb3VP298E
 ZAkHg9D0VZvZlaHn3+Q52zDPDkjrfICnGzv08dIILN3N1pgw9dYArjXN/CLidj4wdzhtHzNIGuC
 YBjErGc2VjY8in+4QA6oNDTQgBM8h/zeJym8JtyvOMZI2XBV6rLavpqWSaxNBvwhZQaDRt5rcB7
 NiNDGej38e5aV3CGc3kw3o08liyH1x609ZG7LPovH4hK+dup6PNjcjRH/lWl+b0iDlI9QAkxlC2
 pXGlJ5m7Qs1BeF43tvJ1sRO3AuhUtBXBjcEJ4LFJn9I+ikxLaqoKeVVEJFvb95ni7lh0MKrkffI
 4bZGaxfWypuGN29njdKdd8mBQZFkfJol8XLCzLILFpzs0thX6xOw8Vak9RAvBi4B/z4kt9AAv0T
 7NkC1lQ9gL3n6SnOMSYr7Uo1KbjsAwysUY8eLJ6EMfjVoKrgq/nTGy5I7KbNMzRjXJ0SY20Bvwu
 w8vFoOR/teDyNPkKDnA==
X-Authority-Analysis: v=2.4 cv=c7WmgB9l c=1 sm=1 tr=0 ts=6963c688 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=TJdhL1X_YdA7ouKO9xEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: aHypWaKUMHuClw6pFtCHAthMpiXziCZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-11_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601110146

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,wcn3990-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

This binding is very similar to qcom,wcn3950-bt, however devices have
additional VDD_CH1 supply.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---

Changes in v2:
1. Drop few supplies from qualcomm-bluetooth.yaml which are not used by
   devices left there.
---
 .../bindings/net/bluetooth/qcom,wcn3990-bt.yaml    | 66 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 47 ---------------
 2 files changed, 66 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn3990-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn3990-bt.yaml
new file mode 100644
index 000000000000..89ceb1f7def0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn3990-bt.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,wcn3990-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCN3990/WCN3991/WCN3998 Bluetooth
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,wcn3990-bt
+      - qcom,wcn3991-bt
+      - qcom,wcn3998-bt
+
+  clocks:
+    items:
+      - description: External low-power 32.768 kHz clock input
+
+  vddch0-supply:
+    description: VDD_CH0 supply regulator handle
+
+  vddch1-supply:
+    description: VDD_CH1 supply regulator handle
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
+    serial {
+        bluetooth {
+            compatible = "qcom,wcn3990-bt";
+            firmware-name = "crnv21.bin";
+            max-speed = <3200000>;
+            vddio-supply = <&vreg_s4a_1p8>;
+            vddch0-supply = <&vreg_l25a_3p3>;
+            vddch1-supply = <&vreg_l23a_3p3>;
+            vddrf-supply = <&vreg_l17a_1p3>;
+            vddxo-supply = <&vreg_l7a_1p8>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 82cce508e295..5581e810f08e 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -16,9 +16,6 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,wcn3990-bt
-      - qcom,wcn3991-bt
-      - qcom,wcn3998-bt
       - qcom,wcn6750-bt
       - qcom,wcn6855-bt
       - qcom,wcn7850-bt
@@ -32,25 +29,9 @@ properties:
     description: gpio specifier is used to find status
                  of clock supply to SoC
 
-  clocks:
-    maxItems: 1
-    description: clock provided to the controller (SUSCLK_32KHZ)
-
   vddio-supply:
     description: VDD_IO supply regulator handle
 
-  vddxo-supply:
-    description: VDD_XO supply regulator handle
-
-  vddrf-supply:
-    description: VDD_RF supply regulator handle
-
-  vddch0-supply:
-    description: VDD_CH0 supply regulator handle
-
-  vddch1-supply:
-    description: VDD_CH1 supply regulator handle
-
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
@@ -117,21 +98,6 @@ allOf:
   - $ref: bluetooth-controller.yaml#
   - $ref: /schemas/serial/serial-peripheral-props.yaml#
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,wcn3990-bt
-              - qcom,wcn3991-bt
-              - qcom,wcn3998-bt
-    then:
-      required:
-        - vddio-supply
-        - vddxo-supply
-        - vddrf-supply
-        - vddch0-supply
-
   - if:
       properties:
         compatible:
@@ -178,19 +144,6 @@ allOf:
         - vddrfa1p8-supply
 
 examples:
-  - |
-    serial {
-
-        bluetooth {
-            compatible = "qcom,wcn3990-bt";
-            vddio-supply = <&vreg_s4a_1p8>;
-            vddxo-supply = <&vreg_l7a_1p8>;
-            vddrf-supply = <&vreg_l17a_1p3>;
-            vddch0-supply = <&vreg_l25a_3p3>;
-            max-speed = <3200000>;
-            firmware-name = "crnv21.bin";
-        };
-    };
   - |
     #include <dt-bindings/gpio/gpio.h>
     serial {

-- 
2.51.0


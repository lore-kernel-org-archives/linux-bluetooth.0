Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E5534C991
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768146574; cv=none; b=bkuVTWZwGFja2FAJkT3PGJJum4rcpLBNbQpq7DCPMQbORmtLjjPjPTHWOPBDRUaXOViznAOwzt35vGDzOiPJsHRFckq+Zq8rQKyAlTOeN3JCU/tFq54GEnyayNtzmX8zfpU8WQmko18C9jQCy7mmUFOhxxuGNac8L6CzXWfYDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768146574; c=relaxed/simple;
	bh=1L81Yz/WcQ/S3liNFCbUtyvsNkHRQcRm/2kVgwLwzsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YVLDymyYEX1JMRFDL20BDleajZ5vuStqGNaXxtVPqTXdiBkE6NphX+EqN+0hnpZG3sR5Xvv8jSOFkYskgT3ZDbZOYyONP0DWG65ARuZy1lOl9JAAEsVXwZpLCmUTHxMa0M/VIn53BisTrmMnj6h/MyZTCCAX26llkz6iH8Rd00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OmkTdMU+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ib4gwXVm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OmkTdMU+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ib4gwXVm"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BDLhrF1915539
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mqfhJyaQiIaIFVr6HGGzaCwXhsDjzwHSW/nArmX07eA=; b=OmkTdMU+e3xB4exz
	lbDCLSD8MdT68n6XlUEINLX+wG+6a5N+YZP7J4vwL6mtut8GfBr3oQ1HS5p9uPTk
	DSGVflOSFoU7ja6Jd4HWtpmhMeV/YxLvCEfShplkzpHJtjR7yiTudlp5z+RpML+S
	qU77pApzZReIxrBbb9fbqwvWt6C2HE4qlGZxTg19KECFqZy469ZkYB3AU21c8Bz8
	JOKi0Rh7+YsKlaFkKBIiMStKOEdJ0G6ShvvzGri9/oy9AF2YXr4XPgrhcAzHaW53
	5EBjYIDuiqX7pVDxerdKB/aqMEVvHEY5vuPdxs/JcjV14jT6AXvo6jMpVu7Vikar
	Pw1Q7A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkmem1vvb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b24a25cff5so1828685785a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 07:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768146569; x=1768751369; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqfhJyaQiIaIFVr6HGGzaCwXhsDjzwHSW/nArmX07eA=;
        b=Ib4gwXVm/0Xa6WIaBC7vAZXwhiaOGXvcdpshUd0+8/6LwFGXYGE1QSKIc0T+i1vuCc
         hH+xY/jrJf8dtzKH79JP1hl5YrO+Hy/sc5mfkbHWmhcxi7aJt+gMkkBKyl1+Dl/YSVC4
         kFVoh0Tq0sFtvzGwYk03qgFa09KN7vNAHXBVBko1fkSV5Mm5eGyuV8caB2yf9sw/qN0k
         3SDoeBAbU9cZ1CqLrEcNmWHRJK0b7WF41k8t2aLRa7P4ilL5Fmvz1ucka0e/TaEE4GaY
         kruQ9PBqQiYtW2aOQs0K8r67g/BTFuCrskZZ7rDWnCALJVEX2iU0jLbZ1GP4TKfd3RP9
         2DVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768146569; x=1768751369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqfhJyaQiIaIFVr6HGGzaCwXhsDjzwHSW/nArmX07eA=;
        b=YGtZHRhmN8MxDqsh7LrtXghdcL2QDQkbFmgtpGAtYjBTLibSp/WXo5MrUkyQjU7MFS
         TGjUXJRyyeoLGBEJ2td1YJYhYlkFNOON6Qu7gTUflg4ggnmy9hRJdetoTDyL80D92O+3
         x04tkxUiTqOqadP/4p0C5RDBHJ6EubIzZF12nLY509ppkC0epLjSIGsA/JDrK+hGAWlb
         8hXSmdfPUsvypY3znMaWPUsv4iLUdzSSdstIAHpRsHqjs9/dUOUexzEFLLhkdq1MXAAL
         t2Oci0Ok7XwsDEnLaHmzvuYtjWjdplkzr9jaYNC8QRGjoOUOyxN2nfbig36cXXA3sjiT
         2GIw==
X-Forwarded-Encrypted: i=1; AJvYcCW9/GQlUWtRHd1mNkIefEscEWB7Ru0NYmWXbxjvSlywn1Fn9xL73L5UEPtgNVD9kESpC3A/eaahWvMIxYxRgWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ocsHhZ1m40tFcQFE6j0btc/5UMpwFLgWvtfBYWwh7rIRhp+H
	mtxMCMLh9wZhddPTQCjdWFlWDnUqGgNqYxT4DCZmtZ4/cOyRmJYb21CFeNmnQCNyvKJpQik1Nqc
	LHzzEz3SBeIBZlesKaddJ/sEkBUk8KaKAf2btLH6XyZ02Syi9IwUp6wNUegvhHWEfTVRc5ECsZe
	5KHZQ=
X-Gm-Gg: AY/fxX5LcsZf4UgdyUi/z4opYiydRynSYSM8P/RAYbR4TalkdkySfM1nB20PWpdtpmQ
	mM0E20e8knRXSnBIWtR5ZnyYikBvp1Qw++AzqpWi5DUx/TlboFjEAynE/gbro6zlh9At9wGLdTf
	P6duwAJnFcs22xx85nW1G/cbCarFSBrBf6MaZC5V8Df6y9dCf3kS7YnUJMnAPllWnOlj1Deu+JJ
	PlLx96E0JN/y8TQ/PUUjaVOChgWQCF0wLwGed3uPOtOVFRNWjHwR7LkUZS4dTY2MBRa8yrffwo/
	EAH1GU76x19Y1f8fYlQddApoejU6LiWya0CHc5u0qv2G+CaYEHmcAin+OZ3E2CIZV9rqJEfzsoB
	AJcrp9xZMhXgTi0gEkQkbtLeboj3Dbr1fvQ==
X-Received: by 2002:a05:620a:290d:b0:89a:2f9b:10d3 with SMTP id af79cd13be357-8c38938eb7cmr2004433685a.30.1768146568716;
        Sun, 11 Jan 2026 07:49:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZs04PlGTciexmOhSmEy0l3mgw+QCvImeatndIbdxn9xIdrk2m+n8OqOC24JoKoih3NF1CxA==
X-Received: by 2002:a05:620a:290d:b0:89a:2f9b:10d3 with SMTP id af79cd13be357-8c38938eb7cmr2004431985a.30.1768146568125;
        Sun, 11 Jan 2026 07:49:28 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a5180bdsm1637163166b.57.2026.01.11.07.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 07:49:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 11 Jan 2026 16:49:03 +0100
Subject: [PATCH RESEND v3 06/11] dt-bindings: bluetooth: qcom,wcn6750-bt:
 Split to separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260111-dt-bindings-qcom-bluetooth-v3-6-95e286de1da1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5619;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1L81Yz/WcQ/S3liNFCbUtyvsNkHRQcRm/2kVgwLwzsc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpY8Z4WVcwXif3d1vjZWYaXrqTQ2tjVD3fxyTmT
 m9CUAfV2F6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWPGeAAKCRDBN2bmhouD
 1+5XD/4q4jEe5WpbV7XOaAtGrcdmOUqEedRJ3/SQaEDKhZYuGmemW9gzsdy1hIn6nlpfiHkXCqJ
 vqd9/mt0dcZhDojhjJviBR0eFHvN4H+BUX4tW8qKq+SVN0TvZtIYhJxCe9nNVPvA5/W61kjJTCA
 ewZSWUkO7WO+pebJ7aHdrKxBDEItL35YxokrtAnLQ7nTEE1B1H6MMM0uyPww+jLe+2Zxj0E9s5E
 bk2d+MsolUFNlJNVfBT3NqYEq/lAht3DUhdO9Wu0HK8HjCJYroKzFwAfhuDQbwppplv07SOHUAt
 76I3mynb9Ehep5UPDXtJeIIbZV5YCi7H6leVs0yRHRdJFMMSth3CjU+0HdIrNGMieASpcSWrB74
 QgaPFs7GvnAgCZfMYP/JLcmkI6wuiD1Mnj4k+DTXfpyweF1ds97VAMZXobVPPNOn/1mCWMMklss
 RsMpeR4FS3sDmV9/74/uwWy0X4EyDSDRP4FS8GT7jSa/fYyWZW9BgjWilX490/3NhrLJVrMtjYg
 mjhVUW/vhnOMdeaJLcJ64+Y8PUOUNnnxc8q+T0KhgfW989BuRlHLZ8F7imIODSmb3pFgZ34RsCg
 rXUXuAznrhS5IsagatodbfWkBfrkbT9kMaoKTNztGRH9YWbV+nEUo80mKTidSUjn3Dnx2C8HWC/
 GLqlOV6aJ6Mghtg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: XoYksZG5V2oC82MLXCULSL8RHR6Glwxw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTExMDE0NiBTYWx0ZWRfXyXcqozgdyUVp
 roUGjCWfWu6cFlBC+Pz9pLVeQJdDnRhmXTFkBPLPqjwSKPRFn8g+MFzfkNTe8gDgggEeIKj5/2W
 fw+jxQmB5LwuiyHuSdV6rXUxfQ4zFsG2VpXK/FYLBfxf0k/ysoXqhOu3Mr0c2RE4R4km7u4mY6e
 AzWuYxWRZlqACtzm3Lbixc0dLG+GHA7UFJLMF7zlK3gihvGgZ0X0HJSqn7GQRxCiyTRL/V9gYYw
 BBGG3uMYRk2W9oKwH1X7tdHeqRCTe25IWgxoyBEldcre9AAIwiVawnVZBznCYdgC6MavnXeGZ6Y
 3Gz8TkTxGrOc1QQ6QPxdjaB341GtturLgKgWbcSbONd0kHDX5Z0xPuRxY7nLLqNNQ/PqzQTCLVm
 hWWVU7SeU196Fa0mAb1sbgnANBlsopwHgLLOlxgAqYTaQI2dWfihzaTl6179rMjnS5GXx3u0XK1
 Lk1zNfLXGcckO7iBHqw==
X-Authority-Analysis: v=2.4 cv=Z7zh3XRA c=1 sm=1 tr=0 ts=6963c689 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=HiCyOsSRabS3u2SmTBgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: XoYksZG5V2oC82MLXCULSL8RHR6Glwxw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-11_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601110146

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,wcn6750-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/net/bluetooth/qcom,wcn6750-bt.yaml    | 86 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 45 -----------
 2 files changed, 86 insertions(+), 45 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
new file mode 100644
index 000000000000..f11d12c205fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
@@ -0,0 +1,86 @@
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
index 5581e810f08e..1ee97089e1d5 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -16,7 +16,6 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,wcn6750-bt
       - qcom,wcn6855-bt
       - qcom,wcn7850-bt
 
@@ -62,12 +61,6 @@ properties:
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
 
@@ -98,19 +91,6 @@ allOf:
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
@@ -142,28 +122,3 @@ allOf:
         - vddrfa0p8-supply
         - vddrfa1p2-supply
         - vddrfa1p8-supply
-
-examples:
-  - |
-    #include <dt-bindings/gpio/gpio.h>
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
2.51.0


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E1346A02
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987028; cv=none; b=hB8zFhzcpLX2zTziL0sJ9S8fqFLL6sKeyXZt0Sf2emqBrB4eoTkTGy1UGdIuW17V5qJFNYhECbkkeqiiwNhQ0M/2C+KH1IrSJPP1u79t2CtgkRJApPQn0h1WfoLDFiSzPwXtJzdxktOmznwvI8kD9Yo4Nn4dAZgCMLlY7PBxVH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987028; c=relaxed/simple;
	bh=IRPUyaWVtt81ELN8RFPfSay6jrmlbrMj1DFklO6mS/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifgOEVFzOZ5S66BsvbKgpQL+yCQ7ZfqT0KxIJtyj423jyOkPEQjaVTfqmF4vSyQzUSQpZaks54HYaKka5UeCGdDQMIbR4KXptwcFyfxrptENb9QqnHeWv3QTFD2UFK4YSvx53R8G2ADR8M9qRtmJ4fi6Rrg4NOeIbSEFnAE46TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PtgUSilB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ghPv09F8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PtgUSilB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ghPv09F8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCKxNd2042763
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m4WuYH2vpOkIakvEa/nSVG8WF7NjL89kvyWGM2cYExo=; b=PtgUSilB/rFVz5I6
	jqcXeN5ybcbcUW2TYVZH3m6jeakCdKk92f97EGC369QbQQohPmjSmbLezv1EZJR6
	Die6MLUKuqYr5NEcRjkTvIjCR5Ss6RkXZG546PcPFd2E2BoHCh6DhXDVR/UMJQHs
	uVLKlQH+kC4oXf4D85v78ryR32RB5Jy2ad7BRIHfOyn5WWnJXdrOvJ/C/XVVic1c
	wxnKTPjQ2mhy94Xo/16UBN/VI5VvtDO+u+zmINAhsgjROSZnz2Erc66sf056GYnM
	40myVB9z+nnBewNWEH7RS7F13SDWXjhH0eTE6zYz1tM0wqs6ocYk+t+cqhihT1cf
	3v9Zrg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3fj1u34g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:55 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a3822c06bso87091316d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 07:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765987015; x=1766591815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4WuYH2vpOkIakvEa/nSVG8WF7NjL89kvyWGM2cYExo=;
        b=ghPv09F8HzOhwR95nixIhrjjGgJVAXOJzn47P2f8B0CSsJC+HvAhOUz2KIyTi3pTPE
         suHI0idQluIuUCLIMYcoYEUWQvQoxbU7mTzjtMd66NTFkfMXQuwg9mYYJ1M2ySSME7lP
         SN6XGFWmhHwwww51LDL6QShfv6W3jwprGEXChrw7BM98bh/BP3uN79EF36Rf542aYTO9
         pGav1XgqBXZvFlG8BJsszvsgZRMlRVvkDfKmklIDhejBgDAWUZLSHMc0dMsZ4ZUBtiLy
         fZxgPKEs8KJhJRHdp/IDtE+KonNKiWtNhw68BWviTN++2LPEf0yUSCQ04vqT2r6Kv7a3
         vBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765987015; x=1766591815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m4WuYH2vpOkIakvEa/nSVG8WF7NjL89kvyWGM2cYExo=;
        b=sGpWeztdbVhmmxeLeCLQ0ygf5Ws7OhrkRbDSoeZQPCBPPdRwD/wiUEUaWCg4Jm8dJG
         Xc8HMVKEQyQqGVXkBP0buqZEaEhMzg63shSwaZwDkSGIuV8d5wTRoEZ1gmF/M9p24Nck
         eKLvHakiB4Reux/O2yN0BJnQrcn5KeOcHHOtk14NzWXyUP/pDR1CHmJg32cvAhFp5k0J
         FYVPYAIZ9AZLB0VD5leIwoEjYRS77rLHdnMwDwAfk2+CSZV80KnTGBcz3BRr2a04Xi0v
         1iV2owu4wmRW6HNXkur0eVh40xaXYYhY4v0JeDn9cZ0rkaGE8HQiCwDBrIOVdv3Qlc8j
         SXyw==
X-Forwarded-Encrypted: i=1; AJvYcCUehAL0dvNIX+laFxbE5ZGBcp6p/wI/MurURP4rknKgpglXv82MKeseH9Ed368KQlpyiBSJaE65QldeGIhJNSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzETkivGc/JAH+qQRn/rD0/v9XpX7/n2Tnpqs5uYmjv2t4bUckL
	m1sylhckGzKenbYzp73xEpQ7e21+eLWAzApvvhO/73MG1tFf/W/79PDQwDm8PlEBK8n4lm9kNz1
	7HGD55cLKvYWkHesaHkQGXBuTZMO6gMfUaiJDCVXbyudr9tnBlAPd0vs3/9WuKwrusU3VplE=
X-Gm-Gg: AY/fxX4wJClVRLmnNCjV90UexAMnR1y9N8+tQZgdyT9xuXDK2JAGkUwubMmiY3m2YB5
	pBDpMWF0HK4ygOofdhzyELl6+yW7nQrQbNRsXocwxwFWDgYoBiOvgFXte0jpWgdleyad+r+48B+
	7bfhkAhf8yg4HF7U+t3vplCqRAhJuuuUagRoMvUBCDuWhzYPPmNWwFbWWKTLIu9skSck6RhQo3/
	JKPRUQbkiulkH7QiISj4Rd+BfeiO1yYkHaK2xARFkTG42JN82AT3NvCGhDwBq1dofoGkOVTXv/c
	J+2bb+m8c0yh+AuejL2XcMMUkBUY21t3TW3oE+UfXmeETO1rgTYV7Od8uji2gqw1GVPqgCoHP4t
	vjPaI9o1eYNTWJaxNCqeSeof7cmBRZei+
X-Received: by 2002:a05:622a:2448:b0:4f1:ca7d:b4eb with SMTP id d75a77b69052e-4f1d05af39cmr260530151cf.49.1765987014689;
        Wed, 17 Dec 2025 07:56:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVEKfMmTmGDlWefdZ2FfDAQZAZn+u3/nSYWz/m1t0sHztkRO+wEWlxCXbi5a0sXIOPxJUtJQ==
X-Received: by 2002:a05:622a:2448:b0:4f1:ca7d:b4eb with SMTP id d75a77b69052e-4f1d05af39cmr260529661cf.49.1765987014178;
        Wed, 17 Dec 2025 07:56:54 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeeef6sm5439800f8f.32.2025.12.17.07.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 07:56:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 16:56:26 +0100
Subject: [PATCH v3 08/11] dt-bindings: bluetooth: qcom,wcn6855-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-dt-bindings-qcom-bluetooth-v3-8-ced8c85f5e21@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6392;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=IRPUyaWVtt81ELN8RFPfSay6jrmlbrMj1DFklO6mS/A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpQtKzVlDWSHpFe7nZUBvcnTkYO6vNJMPEpaOG6
 xbMKAF/H0GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaULSswAKCRDBN2bmhouD
 1++qD/43HeDzKjhgl71ZsBFTIj35YBw/Y+YGmA6NBV1p/O0LsLov+esobuZhkRTLYMIq/iegFQt
 DOo5funFtVy2jr1wobq9AWZZfoc3897//ibyQhQU15PFLf3q01Uodc5w1WNDtzSACCkZtioY3/L
 2oKTMV1W52R1Ap2nDeQxy7dnXV1pqEPlb8CB/k/hNcQ10X5ChV203ZobkEKoRv+YsDyzkRHGYw2
 h9TykE3g9tuShiIVJ+ZWDGBsYdspklnMF32oBT0D1NHaj2YUyuR186JHDy7Qj8krrxusTSYoUIG
 VNsbsSgg8djgbKQ+7OlLOFimP5Za3a5mcf4cmdC/e98MOgBBsDxWLkemNB+34Tb2O7PWS+JXK1b
 +eyxjvG/PCS1r7Umf83ldfWkPNkZ5K1CeBdVEmQ1XsWdxwU9/mh8la7p/a17PusQNlN6wExspFx
 bPt25LEmm9yjKgqszZBfia1CPgusVaUQPyGz/G4nfpG0siEEFCi8AUmewhnDl8Gkl2DGe+3orAn
 AgiyUNhn+SiRFFYcEEGGy5WDuSduJ7z8pix6VdluGuYmmUswfr1o3H6CCODena2PHyQlJkZJph/
 3w6V47d4DK1j5unWOOVqwdmNxzKKObwNQwvqIrLZocEUmTkDXCwVBq/h8Zf7bOQnZQgUXuy+TEe
 ygpwwFfTYNKbj4g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyNiBTYWx0ZWRfX884eD+5a3Xro
 Pgcf1OYndiAIZdkmX8xrjAFQPe4EzuIwgk4Aq1eGYAybq/OQjIl5MdTK78DukeGT2zO98Wo4gI6
 ZKiRlNU9s0Yda+nYwcs/SfEP+Hgn7cBiFUG90TvsW9TaXs5ae1Ml1i5Z46TjrkGTb1XI0Ql0vJL
 jjlRwDRhre9URI+BM9xNpeQULuFCk/dQq/N0sH85qLO8vExMW/q//xOlGQY8n5Hqpe9u3qNeLYV
 JAUW1wFEyjFUgCaLRKcAnfvbY9fe/+GvF5yIR7nOePxz+ohoo9Sj3r+N6ehVIxM62y/ok3hWCN3
 QLl3WGJZ/NVydK/cv6Q0pM4X7sQ+bBQivJ4mnjRQl7SVNU8QZkMAxZ/UD0lkn04XGjpOYGfbYvI
 idURcn5Ts+/AQq2rJj1QKS3f4XDU+g==
X-Proofpoint-ORIG-GUID: XDFHNn_MrJCplXL8DejVYnnPU5K3lhgM
X-Proofpoint-GUID: XDFHNn_MrJCplXL8DejVYnnPU5K3lhgM
X-Authority-Analysis: v=2.4 cv=edgwvrEH c=1 sm=1 tr=0 ts=6942d2c7 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=hmARNUlj3OVxZ3RlbIsQyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=TihS8u2qB4LoSCkHJ9EA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170126

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,wcn6855-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---

Changes in v2:
1. Drop few supplies from qualcomm-bluetooth.yaml which are not used by
   devices left there.
2. Add also Bartosz as maintainer because he was working with this
   device in the past.

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
 .../bindings/net/bluetooth/qcom,wcn6855-bt.yaml    | 94 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 26 ------
 2 files changed, 94 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
new file mode 100644
index 000000000000..a4a887a4dde1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,wcn6855-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCN6855 Bluetooth
+
+maintainers:
+  - Bartosz Golaszewski <brgl@bgdev.pl>
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
index 1ee97089e1d5..62d7cdb67a3a 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -16,7 +16,6 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,wcn6855-bt
       - qcom,wcn7850-bt
 
   enable-gpios:
@@ -37,21 +36,12 @@ properties:
   vdddig-supply:
     description: VDD_DIG supply regulator handle
 
-  vddbtcmx-supply:
-    description: VDD_BT_CMX supply regulator handle
-
-  vddbtcxmx-supply:
-    description: VDD_BT_CXMX supply regulator handle
-
   vddrfacmn-supply:
     description: VDD_RFA_CMN supply regulator handle
 
   vddrfa0p8-supply:
     description: VDD_RFA_0P8 supply regulator handle
 
-  vddrfa1p7-supply:
-    description: VDD_RFA_1P7 supply regulator handle
-
   vddrfa1p8-supply:
     description: VDD_RFA_1P8 supply regulator handle
 
@@ -91,22 +81,6 @@ allOf:
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
2.51.0


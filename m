Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6933C527
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987012; cv=none; b=dStK8AJMv9JU4K3oKNeOLv04Nv0LAhY+U9+ZKOgbUVNDlF2uPqu57FCpKsY0SNfsSvmYNEfcZu0tHG9ybQNjx0wMusRIMS93L4urugbYnTeEWEUg4a31ZMd5qNjQBryJXQHoKNJeF8HoOuwICq2ASY2wAALCNqTkVsO7KJGCvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987012; c=relaxed/simple;
	bh=mHst1xBgwj9bMH/OqbKZWAP/xstAnsimC+MNikWEiXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrPIkjvNx8BK9LlsvRuWY9AnGpFrwj7xmMZPoOgrWrre97Airm7oWICYqsyJ8bi4I+818NpQHUwcYCfx2Xog6e5pAIXIv48d9fzzXCwcnRIR1XLtbyGwv0mQSV4a2J4LdZhQlFsrRVW/jefB4SUwUBiYwQXRFdA7HYIhdtfTcsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UyRM4917; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=giHLQiwR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UyRM4917";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="giHLQiwR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCKopv2465110
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zMBABCfjZZdy8kTHYUiqUA1B/gN5Te+ej1QV+yVBeC0=; b=UyRM4917Jbtsxh6x
	4VJ/f1fEo5imIOhhwlYGkgGUKTIf1EJXZbWyppnkFAwdUF7Vj4rC4Q5HvvWAToU5
	th8vNGw1TMCnSZ9uDTMWtiwzb8hiAGacqnOkLzn49RpyewlzfcpRu3A5jpWQGozj
	O0Rt8BPSJjtNRUj+po6D6yOSyjQHmXgW4xPWslzGJ0C0SRBHzGgcvPsceYr4c2PG
	RZ79ZkAlPfh9sY1t7uuLN6UBhz10P1GkH36AINWSnre4+5qu0T2Bb8GP8GuVnHFj
	P//Da9RglbOnSZZbsWmPMS6gL5zCpmiC9WQ196xe0CsSkHS+2EzaxZ9B0wm8qorf
	K/8xpQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3fe2b318-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f183e4cc7bso113104451cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 07:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765987005; x=1766591805; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMBABCfjZZdy8kTHYUiqUA1B/gN5Te+ej1QV+yVBeC0=;
        b=giHLQiwRjXYdY25zdjCdhST2W5I4LYAbER67AfhFrHKNXma6IhRnnEAwey65CFZmTm
         7nfuNV5FeXhaVyUTrz255whzhmnc4IyZ0U16/8RLNjeBw1omNTczYaxyv4SdMzLP0U85
         vkdbiejvYRhmobxlf+6yin4zXZq7s5tDBv/+QLVkhjb/+A+CwAya2rkrqsrli6r9rC+B
         kQjIxYVBBlqHAT0DNnv7jlR7u+an/vkKqJU+EmAlXygOHuN7BIpuH3X3TF6L1dEsxtte
         O4MeWavcKck3knUYzrWgiCu1SjVquaa2JtixfwaYb9VNcpP/qBGDGL9nkaYreG49qvqV
         9gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765987005; x=1766591805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zMBABCfjZZdy8kTHYUiqUA1B/gN5Te+ej1QV+yVBeC0=;
        b=u9KZbqNGfqz5CAgJKvyN6R5dAj6qO00KPyAebTRv+SgoDqdrBkHpT6IZZUT52uRVEq
         Przyku4SKrEjpPhT/wUaXUcN48JWg5RuGpaCLA2JZgu2aKKZlWxfDxRSI1Oa+c09U1G8
         IPjjsIFgFJLtfIj5er+tr7a83eSPRqSj5ynMYXUgAtxH4bzKFGTJlhrTwWNXF/ucYZSk
         5Ot7JOnOEG5Be3azu2cqXHmKlT2Oj3Yj8UYasgGCSA2NIogzmla/jPgjJMMxXwJbM/t2
         6jFMD5Vk9POxlp5ylCZUMbB1GSQgxc0hlGpXPqWKA3rA7FHuXRUm1LX0krLIRBL43VK/
         Km1g==
X-Forwarded-Encrypted: i=1; AJvYcCVM0OVbVHtg0WhYyV7naqj4j0kqPIwGq1bo/a0Y2iEGxN7YSV/+D+Wl9g9ElJn/Jg59/zmod2WH2aGjOx6G784=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFWGDnYd8Yh5T/I3BEJsJhhM0a7DUoHmt8wL9mMjseCovd1nLu
	LXXm33i5GJjGnleFV3AcLy+WGJz3TD3bad+hD4Q5qaM0M01A6g8oljAwl42iPNnXnFxYmbwd3xV
	uMWQtqjNGDhg+4NPzmokCeWZiBVVcMartRP/ed00WHT/PHJ/0neyyAKio4m2CM6PT+gCfbKc=
X-Gm-Gg: AY/fxX6wCTm5Qwb6Pc9KmCRyqE+o8S/oC6i+LQN0JPGi8XJOwphWPGhbIxgBuYZzGH/
	RcAbGJYOF8dKJf5j8X8KjOalNWZCZfaZccXEvLfYRWEodjO2Y9bkJ1Xe/9UERI/DbwiNTe8FHXg
	PcVbeRQEiJ5GEkM2mKAxnOWM1b3tSE7CwS/tysTgM4QrqWW+eaKgIUi2kbbSJluwl/8Tan93sjF
	CeGH5UGwzA5DnevNkc273WzOVOdUqVjW9s9PQ61sdtpCCKylKjeZCbp5Tm2pXrFzFnT7fXyJlUN
	ns4tGSskNh0BUpg28EkK2zSeIsSFB4omQNIyn3BBoruPnVBfZP+V/u1TG78IaSlyogaA+XUzBGJ
	V7CcsI337IX3FM98mcBQbpv9pOGuKTYM+
X-Received: by 2002:ac8:5705:0:b0:4f1:b9e8:1d34 with SMTP id d75a77b69052e-4f1d0622c8dmr240083381cf.61.1765987004580;
        Wed, 17 Dec 2025 07:56:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAOFg5xuo2wEMlgjaSsVubevoYVRp5fu+jg4tbrEK3WP1LCRuuBTvFH3/Jd0CteSRDAij1lA==
X-Received: by 2002:ac8:5705:0:b0:4f1:b9e8:1d34 with SMTP id d75a77b69052e-4f1d0622c8dmr240083151cf.61.1765987004123;
        Wed, 17 Dec 2025 07:56:44 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeeef6sm5439800f8f.32.2025.12.17.07.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 07:56:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 16:56:20 +0100
Subject: [PATCH v3 02/11] dt-bindings: bluetooth: qcom,qca9377-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-dt-bindings-qcom-bluetooth-v3-2-ced8c85f5e21@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3138;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=mHst1xBgwj9bMH/OqbKZWAP/xstAnsimC+MNikWEiXw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpQtKu9RD/1kcN5cK2ECWzWj5NtqLsO9fteg5bv
 hqJXFTLsnKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaULSrgAKCRDBN2bmhouD
 10pzD/0QzlVMW6pndzQd8lUzum4m6AsIA+Fj/yuq8KDFKGIYaAFll6DLryzmUrIwupYoK5bcci4
 0kKaGm9SIXKFwaM7JZKz3n1zUOSrVLIqq1YtfTTqmQJoflnHo9jJersUslG+F6dNoWqWiMlzi2q
 uiUcuges1q3gyaYwdLwL4L15dI+DMqC4uhXksTE4NVQY/tnc0b7s4pMaUtfVyIKpNymT7tvz3lC
 U4Wq2k1X2iXsJ8Mr9So3PQ/49dEyDloGkrEA/urEZtzgas/J2PmzF+EnXc3QrxZTuaJHNMkShfz
 JNSYG6E5QO5hAUGa7WYbmZyJEWx/SpEFfa0SnIbvEshFbL4eqQjW8m/j4lMn9Ch4+sMcn5asQ+4
 dFnfzhy/g7IY79cig/qxx+cDeYwdVjZp+coiaOxddecdW6wRNLrE68KSQrPz5sg3tocunq0vsCx
 RT4HJ9O+KfX/jYhIPOdN4MnC4onyJ4wQbvHtgMp/w7GDy0HCQ71/LTgdjmkTk4pwxdeqcyxbECB
 hB85Xgy7ERSP9TtokjdwCMkv3RIokSp3b0yTDWv4M+dqRPF2OetJCfph+9i4tDrDuIkQGXeegcq
 GWM5D7yQCKCE6fo9zHT2yQVlxMKEc0HMy+fudBYvQdwn+ZLDKA3dsxjVoAK+GfSTwwWQddJE09z
 fXB0SEA6zcWRn7g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 9g0sXoDlY2OuDxXAKKyYfzdyCaDhOt_i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyNiBTYWx0ZWRfX4c7y40sOi3Mm
 zmSQC3UijUYYv+o+19wWNSTdQtk75/B85y4CLonSmuKDTyKnftLybFn4zjhhEL0yUbJcnrGsVXQ
 sYhtex8gv+Gz/bK/cFcyGSxMmAdaDBYa3dLjyLta7f4XmViXUbOR0c4H2/+UCaQz1uBXnjFCUQm
 xrgC17sKzB39hgdV2kdvyycDAdaVcI3NB9fwet6a/lMYBb9v589tcVi8Dhwwuf3YOZFiOc4MLRz
 tL1WawInMlD1k88JsXd0zzbw4DeU+yg4+bV4RUFoMyBki4nm9Uf9GIohBd/XXYatfFThECLMx0p
 q3cOXLQgyRjRZGB2nPqAPD8PGah+Qjh0X/ZM3ED3J/82IQ6sSpQiweu7uFaXpaA5+lY2smaSwa+
 rwiQkjrb7xVPJUwskL96uYYEGKv+8A==
X-Proofpoint-ORIG-GUID: 9g0sXoDlY2OuDxXAKKyYfzdyCaDhOt_i
X-Authority-Analysis: v=2.4 cv=HpN72kTS c=1 sm=1 tr=0 ts=6942d2bd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=hmARNUlj3OVxZ3RlbIsQyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=NmeI-4ZN_4R3alAclVcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
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
possible properties (19 supplies).  Split qcom,qca9377-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

Existing binding has incomplete and incorrect list of supplies (e.g.
there is no VDD_XO) and Linux driver does not ask for any, thus keep
this state unchanged.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/net/bluetooth/qcom,qca9377-bt.yaml    | 58 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  1 -
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,qca9377-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,qca9377-bt.yaml
new file mode 100644
index 000000000000..3fe9476c1d74
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,qca9377-bt.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,qca9377-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCA9377 Bluetooth
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,qca9377-bt
+
+  clocks:
+    items:
+      - description: External low-power 32.768 kHz clock input
+
+  enable-gpios:
+    maxItems: 1
+
+  vddio-supply:
+    description: VDD_IO supply regulator handle
+
+  vddxo-supply:
+    description: VDD_XO supply regulator handle
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
+            compatible = "qcom,qca9377-bt";
+            clocks = <&rk809 1>;
+            enable-gpios = <&gpio3 5 GPIO_ACTIVE_HIGH>;
+            max-speed = <2000000>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&bt_enable>;
+            vddio-supply = <&vcc_1v8>;
+            vddxo-supply = <&vcc3v3_sys>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 85d10d94700f..dba867ef3d06 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -16,7 +16,6 @@ description:
 properties:
   compatible:
     enum:
-      - qcom,qca9377-bt
       - qcom,wcn3950-bt
       - qcom,wcn3988-bt
       - qcom,wcn3990-bt

-- 
2.51.0


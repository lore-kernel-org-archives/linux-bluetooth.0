Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB33346772
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987017; cv=none; b=dNSlDj/IPlgX0sYX5nSpqfrgovZqKk0PSuiVnXlpB5LWNbDSCN0arImzK9sbE7BjRE0tUk2J/fEKC91T5SYtkb31p0KApnx8YBplm5a+Ag6ibUugwoK7h7go60c9pPWupcJceeSfkIN5/gnLwWd/WG58sA4vxQ+0SHb0K/Hm0xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987017; c=relaxed/simple;
	bh=Kg3E6w8AvmBMhPePVxwuQA+Op3lrUafQfbcxbLq3D8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kf9JsVYOyc2l63Nnl1u+wKo7N/XacLFbJY3QT0ZW92qd2BdZAWJLxQvl0hMOnQ9CexhNw1SCprPcEGlw4z4mHv8VQMdsUIeiABPf4YbDgFgk9rmvHJN8g+6OyByZM8uEeLXnoIBZgBi6Hxkum4SeQvLfwv+NZOtAdrztt1Z+m80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ihqJaBbj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f4jiS/+h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ihqJaBbj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f4jiS/+h"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCL9rx2675128
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e99JVBAjx6d45Z0AC8ohH6dmyo5PU4YPKSv8XsG/wdU=; b=ihqJaBbjHGspKqZ5
	p/w4NS7LpojGkSWvpTPgVAA8R/dNmqFbHm4gkeDl+Iqoz4WXpn7jFASuhUF1tiDb
	IQx3ybeGF1eEuW6pjmuUUEI5p6fn3B7bJXXxUQmsHEPvMDdg507+j9KY0GFtFB2c
	UhWTp1SKW8b6VbcW12IAkV9b2K3kLEfkxT3X11Rw9IpbOh2FYfiYgVh1YMkrtyO9
	NOgx75lHYA5KoAbZdKjdmA3zyNL41NfTGbRvZe238tblbYuix4CFaxAIlpjMAXFl
	mLt4mmQiQYWk43Bu7+hC4AYbhEEzyBLMnZB8V/6f0L2tWJ+SzgF90+bvbxgm5Sv8
	3aVFDA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3myj296x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee04f4c632so106684951cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 07:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765987008; x=1766591808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e99JVBAjx6d45Z0AC8ohH6dmyo5PU4YPKSv8XsG/wdU=;
        b=f4jiS/+hUraDWAz0V1NM+WpAUCtrgNn7G7J1m+8lba1zAuQRYzwwBZEY6DBd6GHoRK
         Er9Zwpv8jfx+e8lPvDNH1i+dHz8jWmhdZYzFhTEz9v4qM5rPtE0D8+a+7wrhmokLOmQy
         MO049S/zcJVgAWD2/xbCowtOZnHjVHt9i3sDd0CEK+gKMwQZIqgp57yNBS6oDqoredpf
         +YkDgtKPiXrpCEjO424T+6/gmM6becRzMhMwLQpLmROHJOxkShWt/LFlWAUuSVdmsxQK
         OnI7Mt0pXtkuMp3klEEy91/NuKhh+1obeSxig2OWLUFFw3K6FWIAE7TC1SNoL8ZffC1+
         Ijug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765987008; x=1766591808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e99JVBAjx6d45Z0AC8ohH6dmyo5PU4YPKSv8XsG/wdU=;
        b=BKqVhdRiuskcC5P6BuaELcWtU7USsvqGrmBbxErzrU5JPNLZ7IWd0bDto855ufj92T
         eAgWXdo4eM6PqpHeBMrRuXCI2r6Ph7s9a2+dO6Hd/K2OPCUPgFDzB9zJaA/+V8S63iWl
         8LgldO5KUo5o5nx0H62zE6AgiROgr31eVxH23F9J4Cz4cqf7DblKwa9s3e2Hk1YSNTIG
         jk+qLCMwHgXRUmym87dRQZDSRtk6PJTnsufeYf0TvB2HwumGBiNYxnNn45+EOBHFxmDm
         vBaDhru+djz18YE72vURP993J8N3qIWRQYXj+mp05vcXQe0sSkkxNUrrBdySUdPU7QtU
         4+ng==
X-Forwarded-Encrypted: i=1; AJvYcCWvhtru/bK9X15ONXpMg4DyZFTpOMbT40aP8TCLk1NQ5WJFIMiHHTQn0EkRZ6wd10NIiKaCuBCEYrRP0PvCL8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRDB2Fv64bCButH4l3kZ/yAwwdvBpWArLMlpq8EuLzMPHihm5
	208TixZN6RLYEuEaHVlO4wJVSum/xtRggPXGGXpR73JBoGXszDKs6SrWtrUOnbCodJxfnbWBVa9
	aGfiKOSXIcE6L7ZZmq46qJdUF+kiQKS0XU2SCtxywRNoSLEV5Xll5Y3FLL1jvjXDqwjzgRWI=
X-Gm-Gg: AY/fxX4txZwBWnzEqds7opLH2gKYrtf5cfU13i8Ylu6IB7/LmE7PtzqqUszxWDAneco
	xdUCZXUHnQKD3wwsZtbLMgbKO8vDgZRonru3iCUgP80n4eK6fEGs9/cFJcH7yaHUmBlsGRP/qyc
	MnEYFexKAsdc1aRAph/syeJwlH63pj1/EsjhPOqMwe8UqPp4WKE+wmEdPikldfVMPDCZC+ucBCf
	Y/dLXRJjgSgB7jzgUS+bV8FrjBtIi116DmQiHZpdAcZ/IBsQRUoc51irr4UiXkaDUkFbWj5hWpN
	MjW2AlnvTdZsj34h/bPHGSl15hyNI2bIr8oXM//zBVkvRAT3LoJWLjF5WDH+7k3c6ujEZ2WAw+H
	LWDVo6C+P9CR+6CDttVh+4TZVge71hl0s
X-Received: by 2002:a05:622a:1b27:b0:4ee:1879:e473 with SMTP id d75a77b69052e-4f1d05054fcmr239283001cf.32.1765987007944;
        Wed, 17 Dec 2025 07:56:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvJVc47yg5MLAAyokQM8LDOUzMeJKfs5sD42iQIWhxXcg8uy4QYMnkWePz7QV2EdLKwx/g0A==
X-Received: by 2002:a05:622a:1b27:b0:4ee:1879:e473 with SMTP id d75a77b69052e-4f1d05054fcmr239282651cf.32.1765987007494;
        Wed, 17 Dec 2025 07:56:47 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeeef6sm5439800f8f.32.2025.12.17.07.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 07:56:46 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 16:56:22 +0100
Subject: [PATCH v3 04/11] dt-bindings: bluetooth: qcom,wcn3950-bt: Split to
 separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-dt-bindings-qcom-bluetooth-v3-4-ced8c85f5e21@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3507;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Kg3E6w8AvmBMhPePVxwuQA+Op3lrUafQfbcxbLq3D8I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpQtKwQv5fZUDCMRR6aFD6LWaSvcEbGdVt9odE5
 gQLBTbwDCuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaULSsAAKCRDBN2bmhouD
 14qeD/9tEOIqByL3fvM6HOSZYjqxphf6adZASmxBSrWO/QRAwo21SDqPTkR0np+JPDIUvFn72iP
 E5RZjyTFD1BMD0uprKvWN5uJofXi+kvOimvTMMjstcWEsvdij552X5uGSM7f9nDs3X93sCeAe7c
 QwSMe5nHG7E2RfS4ep6TLORTCjsQ4Mnzf2jIsEzaPEVjlX3JWeANHpkb/sP1usxhpX0HgCkT/eu
 GgoeNZTM5xmX77S0UhkqUrPpaRVQHt+J2wKbJCqBHL0ympQT2Wc2e4AXcw038Vw/AMSqy2ovD4K
 mU1tS5/MU58e1amiGEHO0xU/v4xBdTPrR8SCiCSm6bI8d/nph0e+j1czMZZa0WbYNdsG1tg5Od2
 gU4Uj/H4nPjlk6OkWV7/CZ6QA0Q7PDZmrqXjhb6nmWdA4C4mQalltFk3keBDHkjkQIuX4FeDXYW
 b36eMcpwsrOMZTMVdKYpIYBl7y69uA0yapXj/Glz/lVupHoxuT9eVEuskI0hvdP04GKqpOiQhmU
 5rzSshKezKvDbiB3yZYU/nLSCsETTq8v/wwgfDQ+9ZV2LPfCzpVvo8ArntTM1IxviqYIdKHUPrB
 pLTelF8yRE/+gfuL2ytqhJvmCu+2MMsHgcvdHLjXCoBe2Xo7NZC2+8KuYETmg6ehqH8zmij1c9k
 DyUASD0vrZxeTxA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyNiBTYWx0ZWRfXzA+zBU1JTy0I
 dEtAoVIBZMFUOo+6fya1hHBIsBaEU9cW2f59VmWU79sN+No6Ci2+dFWJ602mQ4VcLXVj1sdMy+p
 R1GWbGt/0QHROp3eZXBlr15dYxrL1T/m+polOhEEYPxEqEqCRIyuSJhWViWFOlvjAUK7wdnjOtP
 eKJvcLy/DKvu4E14uyZeh4lYetT46XyYgpqaMr8/O+m7teC6LKKYpgLRCnyyY6aFGRfaYOsHA89
 Wz2N7xFU9d9sgHxlGkZwaKV/6Bpk6w8GfqHiKaYtSw5vU7wC3udXiS2S9K3K+lU+58RSUlxoBY5
 S81cvRS0bKz1222q3QmjBB15KLOuK9MBVPZxwsupK7ctLPwBT3uIJ3AjrL5Gsnfy/MgnZS4O1X3
 M2jgqLhsGFMzXAeajYninW+kNJagwQ==
X-Proofpoint-ORIG-GUID: QTNiB-PPYH_Z-Lz6vuG6VJOyhvxnC7T7
X-Authority-Analysis: v=2.4 cv=CtOys34D c=1 sm=1 tr=0 ts=6942d2c1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=hmARNUlj3OVxZ3RlbIsQyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=FgqxZbEHGC4e9CjquwUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: QTNiB-PPYH_Z-Lz6vuG6VJOyhvxnC7T7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170126

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


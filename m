Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70296348898
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768146564; cv=none; b=eVvIsr+WY8pVYEVoFzhbFAjqFq3mHUo4jdfMMM3eicRngqzevCStzyTqQCNp4HmO9/iSnPKNCM5Jgf1+wq0rTgcNgVVpJblr3BKZF7r5N4qDiJlsAtCLpAWnRJDbcC3g5q7dsjA3PjcCZbIMhDvt/AIYFrpEmN/EnazlzOjGNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768146564; c=relaxed/simple;
	bh=p9n+8spvnmDLscLz7Z+TiQJ+KER3vsC5z50GD8VPSz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nkqgyztyFnJmzQLrFaNrPJeZOkPO6KJl2BtJ6+WYRpO23n2mv4mvYK+9wfKAeRDfxVYV+WWrllCQKzu97D2STucGjIuZ0Ft0D2GMMJdLLiATCdmxJN5XxKSac+wr/pmB4B7IhyfGEsgzdLIcs8km8rDAmg+0zQUbGzk9i0692IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k/A4IUYG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gxkvqRWn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k/A4IUYG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gxkvqRWn"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BCb3nA2945117
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OZI/1fpkr71yAuCxMQSjluFUp6Yw2T2ObelvTri5KSs=; b=k/A4IUYGgnlZbFCP
	GEStf8w4sWnOkACflSeCn9gOKTwSMBSAzK2lt9H/0V+xPAWKjLFqpyUDOUfi9qzv
	TUmnkCcRzoWJSdfK88nfl+/8yTQ5HuU3gEhgN6Gbcwgw9tFwu9qB5r5Uke9sqZoM
	867mRYRDcRVHO+mdyRT/1Z50jZbwhsEnE+nV9Lsug5eM2TXGmOo7mU/qX6mpAzKt
	s8tsYa5LSqmOAmnlRjJORJ0t3XM+1EdQNw7ZD25QN7JOyslC3T7xyd5YgrUn4B0P
	Uh2vREoQGNaKRe4eLqamJna8mlG/vTuz8Z1Naxiz7lZ6VJQ02tt8L4xqioDgE1E8
	QSpD6A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkebu2ea3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8bb3a245d0cso1457139885a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 07:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768146561; x=1768751361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZI/1fpkr71yAuCxMQSjluFUp6Yw2T2ObelvTri5KSs=;
        b=gxkvqRWn4ZMCTgUpnTZEbI2vuRBXhyaSgFNY1aMH7yztLZRjCdNH/e48qc3QRR9jXf
         E9/bDdBqle/6EIA0feyDLpgcAyoCbZHTHDvPrGQO8MCZH2NIMMC8+KI9bSJ60MxviFA/
         994TFbmzd6OHKzkf0+mkUrJmiWdx3qeiU7K642gxtWBgFI2kCmESfVoQWN+3+aqHkc5j
         S+uMCbJoBnwEPysFSKI5xmzhoqzuYoaNLwZP+UoblRe3a5XFakV2g7ksYpKaZULazSKp
         l8ctRio9Qk/V59HU/anFSo9H3PHZLS1C1BLJpAVbRy0edU3pwdJIzE+R8vWm2B745Pdu
         M1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768146561; x=1768751361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OZI/1fpkr71yAuCxMQSjluFUp6Yw2T2ObelvTri5KSs=;
        b=bF831tIS+qQm1Ks6V6Qma+eMseHgv/uZ8VNZVC7hgdA1M6hqvh8+/H1IVgCxp/gcGW
         SwATN6z2+3AdlqS9YY7Ox/DbQxfUZNLE7zulQEOJ2M2odx4z0ooykU3OfTfk3zArfkvE
         jdiMuoPa8Rf7a56QW3vb15u9H9Cu1SGEtwL7b7C9zoIyr2ADdp1Os2GU3h0D0Ct67ZRa
         kzvPEvaq0xxmZa1D6AJgTtDqbWWRrZQFo7Q+GkG+BBceiA5w+z101PKJUvoiiqxlWdn0
         IiMzg5rIoOjlHywd4lCZqtiaEFL9zlgIrz60cffbVW1q4HjL0IHYumjCSw+w07/n9N9y
         2b+g==
X-Forwarded-Encrypted: i=1; AJvYcCWOgDOuxUFw5OzFgYV0aLwHUmktzBUKpVgPTsktXiIZfXmSCumab/gbFQsEcqYEajynfGvsENh+NrWe8ZE2ie8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzIGyPTvMGrpS0+eByMvNKzBLYyljo8+h59JyRs4QEK07bELQ9
	3OrG4ARmqss/ouXpcHc7r1LvpgKuksLMI2YH8v93Do0/UgczMLGla3b++6AmQp2ggzYNjLelQra
	FqJ35xcEVNgDFUN6kfTeBCKIO1uO+pZfcGoG5+7/NY/cHJjM5k1ivUCdrM7cEjEDwDZ2B5ps=
X-Gm-Gg: AY/fxX6f6KLgzhATwirbh8Vg8Ii682G0FciBgQe81Fffkwlht2IYMRadZZNBoStCbuk
	cEnuEoMh2XRJPsM1zDy7avB+1bm05xA6GlA3X1DT2coKUR95x5kXjDjIQU1VAeDOhkLaqocQq3s
	F8cTHpcPirua4k1yMYDPUTZAb8M7vnwTzn/LZT2pvDxmOdXibPAfxZUmov/idCshmo+1uzLpTNW
	QYV6lnPwYvLagbMjbejaVpNsalOUzkueXgTupcnrtALIhgBEpR4NdEC445lB4MX5iA4FJ/+RmFv
	vPv+5STb3xF8K1x6TMlXXoV2MMQbaqY86Aue4SIPv5r3mss20qMjddtt6JxBewennyQGnEo7Ryg
	xGJnNmGetD3FcljpnLDAUgGO5rva8+WzYgQ==
X-Received: by 2002:a05:620a:2545:b0:8b2:6538:6b4a with SMTP id af79cd13be357-8c3893a22f4mr2182026685a.20.1768146560725;
        Sun, 11 Jan 2026 07:49:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2lGJI6vnCrx+7b2KqIVLAj+HX+R/hgNybgeZWDJsefSpfPWz35WLrFedEWwKYcRhAwtRXXg==
X-Received: by 2002:a05:620a:2545:b0:8b2:6538:6b4a with SMTP id af79cd13be357-8c3893a22f4mr2182023785a.20.1768146560280;
        Sun, 11 Jan 2026 07:49:20 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a5180bdsm1637163166b.57.2026.01.11.07.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 07:49:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 11 Jan 2026 16:48:58 +0100
Subject: [PATCH RESEND v3 01/11] dt-bindings: bluetooth: qcom,qca2066-bt:
 Split to separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260111-dt-bindings-qcom-bluetooth-v3-1-95e286de1da1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5907;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=p9n+8spvnmDLscLz7Z+TiQJ+KER3vsC5z50GD8VPSz0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpY8Zzf0n7HvVm1TmD3I7BlWgJFS60RI9WmvWrs
 NCidOg9B76JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWPGcwAKCRDBN2bmhouD
 1221D/9FzCNMHmEyopYK+6qUTkR+QWi4dkUEh5t3kS/ZTvvMhDe5KD+9qUcy7LpcwO9F4V+SiJZ
 WR83NiGHUv7OyOsApo7Hh5q30lRp6re9xbDP3C3NWQsQYWJFsHU3W4wenWiVOKJYMtHPrY+vrSn
 bmDT6lZz8joC+J8kN3AYgbwFOCsapoerdgEwcHvM9DNY7qenIMjyw7cih3z573K97tTXSQhD3Ep
 hqDZQUHb6hw/n1BO40uu5dIQzNav78+eWgPda1uLolbsYlH71hhDh7W7VM5HLc0A7Eg55E5b8bX
 RUY8lfflsIhEbPv7+49iJYwlzBpvFTiK5qOLs12kGi+J/lXC/9LA0EeTM2CSBevfJmdItJ6NSUR
 Gb5Rgd5alp9QvLpzwCzGyYSoMNkunwkK0ImkgQO6/Vg7qRdKZl0QlymDx3aPTsVsC0EB/YSsuqc
 S4M52XV/4ODjqMEWGBTvuTC0pQQsr4rrpxpvDf2qzvPvmJ8/PCj5N9cNnoqNhQBtrVf4g3h1gOM
 5ryD4GuUthRXSxL+CyapdiEaRTkBaE0Tg9hZLihOKMjjT6feJmEkMhYeTWzSudaObxRO7qJTMHU
 cwR0KZZpQwJp6Q4kQHQEURcE0CvOaPpX9xp8NYzJBKsIYsfgL8FmgvL6mcJ2F/fwT5kB8aSPdKR
 Gm5XwpmyQUmTYjw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: GWBJu5COfl2QggMGBfyLt95os1MvRdWV
X-Proofpoint-ORIG-GUID: GWBJu5COfl2QggMGBfyLt95os1MvRdWV
X-Authority-Analysis: v=2.4 cv=LeYxKzfi c=1 sm=1 tr=0 ts=6963c681 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=HeiVX4xZO4SkypZjF6sA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTExMDE0NiBTYWx0ZWRfXzURy2PYDRB3R
 J99RTShuYSxW2szObbaPoE+/FSNaOCiO1SGdHdHuH27Fngg6wP7ZZSH1sfsvJNk7In/GOgrMKDt
 Uym3de5lCyeuVTaeJwMmRGZW23ZAOjMcMmuYERxoV0irQ/fGWyh42j0X4E6hES+eEAdi9iY+bs+
 PJiG8swYVsi6GKD/75DTlwGA8Qv7qWKOj8Wi5tc03APmpzqrMKZgw4GclK4L+yNVNCm1vz0Rzj5
 eU7dtuwMl7/QEZYxgL+vEMcrwQmr0XJ5OHVEzwFnRFPN9SOdUGZYyLhRGoN8Sdq4Ap4qoIUmbAm
 zCnqxT9FNNEItFEjmaPUhbY00SqNItP1a/a9rkcgg8AhRd7i0rM6rp34P02RHxjIotDbnWJ35b/
 Mb0X0ZLfum9272zbR1KggshKfiKT64E3ErMTX4IChTazmpv9qtFJg1Nm8K7gToKl8PM+eOlTfg5
 rGrGyH8xAWktv/oEXtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-11_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601110146

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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---

Expected warnings:
arch/arm/boot/dts/ti/omap/am335x-sancloud-bbe-extended-wifi.dts

Changes in v2:
1. Keep gpio.h header include for rest of the examples (fix build
   failure)
---
 .../net/bluetooth/qcom,bluetooth-common.yaml       | 25 +++++++++++
 .../bindings/net/bluetooth/qcom,qca2066-bt.yaml    | 49 ++++++++++++++++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 25 +----------
 MAINTAINERS                                        |  1 +
 4 files changed, 76 insertions(+), 24 deletions(-)

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
index 6353a336f382..85d10d94700f 100644
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
 
@@ -236,6 +212,7 @@ examples:
         };
     };
   - |
+    #include <dt-bindings/gpio/gpio.h>
     serial {
 
         bluetooth {
diff --git a/MAINTAINERS b/MAINTAINERS
index ecae8a5e33cc..b4d8d1245ef7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21443,6 +21443,7 @@ QUALCOMM BLUETOOTH DRIVER
 M:	Bartosz Golaszewski <brgl@kernel.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/bluetooth/qcom,*
 F:	drivers/bluetooth/btqca.[ch]
 F:	drivers/bluetooth/btqcomsmd.c
 F:	drivers/bluetooth/hci_qca.c

-- 
2.51.0


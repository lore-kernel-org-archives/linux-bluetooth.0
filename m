Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019C34C9A3
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768146572; cv=none; b=glKIStYmokH8wRXThq73Zmz2huTSgbM412zNty/PBjOwevN6sHXnhxzTPDFCthN3HRhKWKL8EMJXwN1vzgB+fK6Il8rqzSGCtzZ/AGUjPL4P9wx2DB87EYt9wBlYtUbq85CWLZr/lrc8lmNe4o2kaOe1rt6NbMuvRYfmsdUm2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768146572; c=relaxed/simple;
	bh=mHst1xBgwj9bMH/OqbKZWAP/xstAnsimC+MNikWEiXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYlCYXLUqQO7vy7T/5ma0V5dGyp9yTZ4yyDLx4KjYssFYUmnINWOeICaoXfgmZ7TaVtOLpZdtJWdykmj8iu+C9P+rw0hzTHHFOEJ3Ro5aI3h1BcthOfGAECoghdnxJjNkmZGg6gbMxkdXEmIZWzFeC1lZ60j6Fu0Jp4ESK/J1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OYYkOcFH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hwt8H/2S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OYYkOcFH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hwt8H/2S"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BD5nUs2555818
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zMBABCfjZZdy8kTHYUiqUA1B/gN5Te+ej1QV+yVBeC0=; b=OYYkOcFHY3QRASjF
	fzYeTdVUVpPvsNVsKUMQOGWZvzxauJx587aeYGvjFHUyVldVs4ABijXr0LYYYhvg
	BJKByPTaC1qPEKvp3yoLffbUo9PqMWyOktvMxw+6dfYdZTaiISYEhntEGVNCzpsa
	K5vLw001WfwvHESGRx4rusxON1/srJbHmshKX17punltHIUUbfqrfwrBAs/FK7OK
	s+4GDIYSOnL2Aa92wzmn0DgVOjXeBaBGSwvxWhQI1hKrDHg5vqz6nvdC4UFclDSD
	/pi8rhHCELIWU3z5Cnk7ICcmOgGfPfBHrtz7ZtgkT6y3FhQ93kA7N+6LUFBUTcnQ
	PsWRRw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bks259j9v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 15:49:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b2f0be2cf0so1527383585a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 07:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768146562; x=1768751362; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMBABCfjZZdy8kTHYUiqUA1B/gN5Te+ej1QV+yVBeC0=;
        b=Hwt8H/2SrlkfPPYN/NGvSTbUoGAswxVDzA2Awau282RKx4dn0EHijNl91cy8hUj/+H
         fhl581aLWnS8cuJkysEV+PwvMFu/jXT1IBkeRVUwKSQHTTKRSagf98Bf5sKX/vZf6+F8
         0Xb7re6aOFf5KpNaeCGv9lTwMwNuKRnYxrV8rD9EfJVF2wM+0VYkrSmgb48UcvfOHStY
         EufuxkedPmWXsT71RZv8dLpJrTIrhyUS5gGVtgnvTuy8wIwzwvPNrolw+QuryhP04BTF
         CFpuzgpGz4z5IYn0YH/hTbJYvTs+Hclh5ODUFTV5INbVvjFavo3ul6RiGDwLNTMt3CXq
         yWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768146562; x=1768751362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zMBABCfjZZdy8kTHYUiqUA1B/gN5Te+ej1QV+yVBeC0=;
        b=r7l9TMRvTnNVKEC4WbDrN7SXEcgsXJeznXWayGCSUv5tyebbUJAm7CC0drVO/8kjNw
         w/SoydS6yuU3df9XsyrAq6TpX/E4Vy8XEDIsoh4J0IfOfNRY2xHLl1/oWs46lP7tw6lZ
         fEU7iuehNKAju8AzdAVNqhvwlK+FIBVQMxvoj/hYr3DDq08P9dJtkOx4z6TWMswfw8mt
         6hB1CXg2Gjj++IiTNAFcKfTIuqqp0pXoyD3GDREJTHe1cwmsBy1X2Uk1o+pkM3OUkLOa
         GGxqpwEROs9oDPAHx4c+y7SZfcJOBylY5PLh9ncaO757ATi6GOjGucNS1tMMHoYnmEqB
         v2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVdY0XL8AsASPX6UAui3fgW+O6PDSvYo7lJMR2V7suosHFzTHg2sUWPL+RXGJNbxDEYHM/yzX7kfZEC7H//Agw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8amizb4s2+4sGcrtgyoXCQlh3HJbjUWIvxSboQJSOvs2u7XQ/
	4JSFqtufQg8zVV7yAZxPaqgd/pFrGD+aIh52CmVgf7J0vJgFvBLOJybxMUSGHOxMUdL/BwLNPS2
	bTQjU22xL6ItNCXKK+qNVtxANKMIWssObLAzVfNuQstYLE0GtaQ6P9P18kyFltyjaruQ29Mw=
X-Gm-Gg: AY/fxX7+FOQgHb8F8z8LWL9Ygujhr7TVwxxL6b86Uxh+mJw/LvphuAPVD+D1DdW3PLs
	+2m17TJOnNQduOmDjn4ZzIB4AQBeRogJ7qCh1co7fnLuMqU+v7EwUNMHfFAdNWknTT2isxM7K/Q
	O/YB74XUulAaJ+OJneqp3ooaFUOC3RHeKHNJLyaUgeGQPhbttDDsZ0jFHsuOhUIIfauiSOXM56a
	NnQKkRyirjGTABqYJ4ZJEBCiwd4kR7S8o52z7nud17/9nqAjIRucfHDfh38NOVMvgDmEaedu7EC
	iOOM+XVEERTBBAHjCuSJwAD9syxnhfkdEqXkPgK75N9OzF+r0lnCsmrE2YGeuBK5XnTsegGHF6F
	BA7wJVG8h+WGQVdhb69ap2s/RxoIreucXgA==
X-Received: by 2002:a05:620a:2550:b0:8b2:e565:50b5 with SMTP id af79cd13be357-8c3894033ecmr1921803485a.60.1768146562287;
        Sun, 11 Jan 2026 07:49:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB0QTEGjUOoFQ3RUopmUys2jM8NWc1FQpoDTWIqEEuTv0offj8qGT/Axae+4hZ6kSsT9vl6g==
X-Received: by 2002:a05:620a:2550:b0:8b2:e565:50b5 with SMTP id af79cd13be357-8c3894033ecmr1921801385a.60.1768146561822;
        Sun, 11 Jan 2026 07:49:21 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a5180bdsm1637163166b.57.2026.01.11.07.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 07:49:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 11 Jan 2026 16:48:59 +0100
Subject: [PATCH RESEND v3 02/11] dt-bindings: bluetooth: qcom,qca9377-bt:
 Split to separate schema
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260111-dt-bindings-qcom-bluetooth-v3-2-95e286de1da1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3138;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=mHst1xBgwj9bMH/OqbKZWAP/xstAnsimC+MNikWEiXw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpY8Z07wWXCgZjK1hRpGpd8hmAyToJnRhp78WeU
 43p5ZdOBEmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWPGdAAKCRDBN2bmhouD
 14ybD/9CF0XC7PfoV5i8CTLzUiO+ajCDQ8I4vVBsLLelZXdh2Jodyn/k5qZ28x2PzyEn5YlHVMS
 w0ylLyNGm22gvwag0K/+Zla2N6GkALrCM1d+2tHsq3VfWnjb1JDGJJz0ADoTJHQhLAMr7bq4/CZ
 xVsMdsi6FeCsQvU44IRKsSBmxuPgLbStth+JC05soJdGHvXA1KiFTBDTmx6a0FMOadu2RGadQLj
 hy5u32Kw/glfPxIc16/fQiJrbAYACQ2U90iUcJbbtzqiBoEYuc61fXyCF1B3ct8HP8c4aVjqELH
 a7vXnKg0TA/xPE7uyll/9Runuz/v6OfvQeBCQTmp6P3nG3ldp/4EfCWRt1SU2HiXEqEA5p9OKGh
 VdXdSrwU2B9U5F3FvH03W8EPlJP9ao2wA2gF9mdUxlfruGG6ZrRt17B8aiFzlaJKmW42j9PIyHA
 /4gh+/h8/SAa1Py0MBXiQwC2245R3EzMYFaezj5rfhjELWeeZl79uSfk1XDgiIeNHDw5mOpVbHe
 wBYzxr64huch9BYcesbsEEWUekdKbNgdKWDYmLLKQ6XYaL2P/RsJPbN6foHjHa48qFWD9d3xxdu
 xwLdWkbqNrnYxauj/R7XTf/2tZIr3Iu+txiA43VVtj0R4tFhvX59JGLNoFGO6AhVuUWf4OdzVpJ
 5I5NjHZQ7emDv8w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTExMDE0NiBTYWx0ZWRfX3fSeay9n3L7e
 mk7jrvTon2ZLzbYz0r1ywNdqd2CgRreXkvtq6m0TwsbCODIDahEvIkUN3zdMQY9QQYI4tftyHVl
 copvhqQZdTkGROWqAvGYVv2NWDfQV/35yIH0l9kPS06a1jDpf5JNCc+QcQhPgFliZtqE8QIr3xr
 mQBvdtG6hJ4Xn9fNvJiI8F7Jt5/e33Ti+qoSc5vYR5yGwensG2cnzjabhY7/rDLOu4parYT94Oj
 Yomz6V4inM7UP/jMUOhJxAgkdPoY1RRcf9D8JV1AfDKTbQChzcYLRnv1iFMuTv066a+6TvX4vDZ
 NaFuqFN1CboOvUyGbgiAv14Qk+ARNp3bO/ifS183RPiANA+3K7BMlxdqQ7ODZ+3qPQq9zn60wlN
 KL+skbMYH9jiGM3rPBJN1VC9v3JEN6AwgwAJs26l5IkrSSSj17kDutA6BfUoxGRgCdpblgKkVMd
 gTP9KzXl8r30gFCIFfA==
X-Proofpoint-GUID: ZBg6ON-ktZoa69Jh5GpkCORZnp3g3gRt
X-Proofpoint-ORIG-GUID: ZBg6ON-ktZoa69Jh5GpkCORZnp3g3gRt
X-Authority-Analysis: v=2.4 cv=EMELElZC c=1 sm=1 tr=0 ts=6963c683 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=NmeI-4ZN_4R3alAclVcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-11_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601110146

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


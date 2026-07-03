Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6E93D9551
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086328; cv=none; b=bQP718Kyw8TFIfY1y1Nww8VN2Amgs5db+xPlojpQoBSdZzZldIKwS18p7XnApwcvLSRq4hAiEoElPKRLAsKoKnxPYRZgn77XQIZasU+dfXELIhHKv9gDM6R2aPuHVkrvG8ZrrcfGBG++3D9BXOYkjYJ+Ei1fNkDhvlkFqI7Nf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086328; c=relaxed/simple;
	bh=GWTkfYePYPEGTpO3+RiqLPCaGCSmezUWdnppwKHAMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Khfr8oTS3c2klDKgvHbTAyNArbpE6ijoPjLvGW6knka8Tj7rjbkt9GCQl0Fb0OkQAWv7o9EVgJ/aov/GXQr/wxNSNBZ7RpntKv7YeE8vEV18rfOHQUif78R79QwCMrtW37B0D8utDPIshhQNNkEIpmpo7RAs4X+VEEiKonVfMHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HamYwJft; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iIE09BZk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HamYwJft";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iIE09BZk"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BOMvQ3109544
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Jul 2026 13:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=; b=HamYwJftlF2U+0WQ
	8ZeaDZbNjDDayS3W7TsIqcAxTETXucyC0z4G1o4d/+ETQoYa39mqeUblscuz+VgR
	jV636xWSmpXDuBzmtz9fqW9RN4/gtV260m05QH7R9RGwWPQfHI+oTq9QGyxm0cgY
	LC082MkM1T+aqMGRjJcPF9fUgQRAqFopLYt3/ItSHHp0N6R+Jvp7d7H0mhds/5pZ
	dVLN/Kte205KojmTDX/q7hKwfEO9JR+7k8rJWbq7km3eB9DUIF6jMHouqfWuCBOv
	GPHfGAXTrZBlTlZLeWp5RHSaWg8JpTkgjaPniRYdTUQyd/FkcvETtxlI+R8DbV9w
	vigc9Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eyba49-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 13:45:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92d1cae5939so64701085a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086324; x=1783691124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=iIE09BZk+iJKB3zE/G/Sn88RndPO5kbqb8jjrWdXA6pBqNt7Gr9mAu5rN/83PeFj/M
         4wan/dj8vzC8pkpeV8M8NC/g1a9ixdiOSorTUat08w9Kb9npHVjqamHmpZaLUHX643nj
         E/9tf9taWm1Klg7C04Dnfo3xv0MB4+t/lz4VLoK25W1Rnzf/sVr5yMsT3sFP2XlVdqfk
         3hJpMeU9dNV0bF76BPlTqqW+G17HHln4E4ZvkqqW8AkdOjECZ57sFae+UJzHfzIwOfOd
         ZQRpYL08c387iGY01zlnGZO793S7k7+cxIzHj7WU72LAjJUo4OBEndRYNxMvcfxC9AjA
         QhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086324; x=1783691124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=BnaSDnDtxqr0UbEmhx/ol11zPRdkGboNEvP2el8kzRx148wL1Xn6w5Q1yLCD2LxOhL
         ca0EpiC/xr4JX7loiX2JfC/UISzj+sCtvOLz46y1QtDnWVmdn68ery++05Q4BikJUM/+
         kSVqVgyyqpKMg3AEicmGjvOg1nsZ9FyA1tIJ3szcQprwvObFFtfgR2GlwUgK0eLlc2aS
         VINIPmleu5+0st1QalQAUZcBfkQWkntp3rdPlRQyPtgeX6hz5pwYj0gTmq2MEuchG1uU
         RlXCe5q4Rt+BxtI3whDvGCb5UcrTnKKzsHu263ZOvB3kSLNAn2JuP1F4QtCWj2MtoaA3
         /ubQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dIobgAkwwPqpXDyu0+EMGZ4bBn/DiLE8t71+QsQ5l9YCVjR6qBOplel2+1vGftwncUZNQzwyk85V9XtmDxOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIDuwSitryJ9EbiSfk+fN/l0yDUVt09ckTlydLYyM4DuBUgfl
	6AiMnQ+UK9LMUvXTj0bMoOF70AZWnmJQTPL8SzNul8IPF35nlyUkb59pQZM2MnEVJuyJ3JpNIza
	ndZWOLNZSPc58b+hYe1JfAH1EGdm93T7CrFLPyJ1cqbAE/IoWuQbzB3jD0BIVjo5QLRCjGAo=
X-Gm-Gg: AfdE7clU9Jm6dE5ryYcFRj/B6cZZBIYHLoY8DqJUg/MdS2aVny9EP5EEVD5c1/K+1gR
	ei7jBmD1TAwcJ+mplOg1v0O/jxG8LJwiSN3m2jKIkvBI2uREGbwQY7Jw2ET1defIzykkB2pT2lS
	rGPHHxYqd6yjfdaPKgC6c4JsrbEIRwfTfiTtoIw8QCU6kWnybwmSvjJHhty702r4iPcQ9VqdbIV
	++3NC14twYXTZCxBK6sP5jqepXtFptTMV6SbLV28Pfhd4ZKJ2CZ4H/uf/HX2WSLmidQlVQXiT3/
	X+6jjv6+LvTemevFKDgYyN5h9vY2b/tQ+YjBqvrYj+lmnRcrBMRGKgAPxc++JTW7b1dB5iFcH8I
	vtwAhLAAT+nbSVLB+h73t3occ86T9zUPmHWY2VHS5nFwnEDXeQUHlv1cYi5fXVDUq6Ydbh9UYAa
	i5txdMgJ9nO2r/8zUoK46EcPqmBdg/JnlCPgPoJ6arccfvRoYiBNa0MFYpgSlnI4Q=
X-Received: by 2002:a05:620a:2b45:b0:92e:8405:7ae8 with SMTP id af79cd13be357-92e840591damr804132785a.4.1783086323963;
        Fri, 03 Jul 2026 06:45:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2b45:b0:92e:8405:7ae8 with SMTP id af79cd13be357-92e840591damr804120985a.4.1783086323235;
        Fri, 03 Jul 2026 06:45:23 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:22 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:15 +0200
Subject: [PATCH v8 2/9] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-2-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX3mrkQxVEF+hq
 98ULIF970JK2LY3aV2vyp8xQedB0V0hRJxjhWxZoUz7FONiArYWtJCpQBnsQhEGf0qX7+jTAIbi
 4yyJ9F/+S/PCIEb0W9Y1kBVdmhFnlG/uXLmAMNcWLKWgXd//8LzFGF+1rU+FoSEW012dNmIcBFn
 avDBfA+aFnYYDWFAnvksjAprsSN2neI5kn5i/pNpvfFSpCfSax5ukeu7iZoOFaIL6h7+KQF+EN8
 EAMDlqMbTxHa8wKAPrwwAJXBrD1MpL6TvI/uWTNCs4W3aix0UeVZV6D7eeX9WdmBgqcX1J7PdBl
 BSASfj8586dpPVlIczEPk2ygdBbMnJvKHInAcvDUcsCHUaPFpQKu3d/2A7QKhW0LEHJC/U3zc9P
 DCIS+vS9rEL+7vTQ4Sli9FAIDlOm6I/BhEBludj0Ywyhia8eyVFx8xu7DaRt9aOdE0LTe98NTB3
 n2/sZlrPTCr1xTcaqjw==
X-Proofpoint-GUID: 5LYIhyTAl26afET7lT4NvDPRdjRE0ssj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX7FvUwIpz23fQ
 ypnskfKh42WPqRoKDFpCB9NRGP0c6e+vy1qoHESfEkcm3yv+XeKwzNyCe/K91cfEdrrVAzeg1hS
 IPGEv4x8Xf+70fcViqNqxLzmOYCIkQU=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47bcf4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 5LYIhyTAl26afET7lT4NvDPRdjRE0ssj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Since such data may also originate from chipset OTP or be supplied
via other device tree structures. All of these cells are optional
and can be provided independently, in any combination.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..878c5d833a9cb073520c256c1b72d0f1489e7f4a 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description:
+      References to nvmem cells for MAC address and/or calibration data.
+      Supported cell names are mac-address, calibration, and pre-calibration.
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - mac-address
+        - calibration
+        - pre-calibration
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1


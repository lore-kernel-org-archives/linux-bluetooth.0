Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6DD3F58CC
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270472; cv=none; b=Ud1TsS/7DtmoP1Mgg7K4N/4sBvZ/B0v5Sg1w6uXl0AfU36ZozNjwyP++oeST0CsFgtvRUAaZJsqom+9aAFeoRDhlUutexfZxMMn0Gvl7p4i+szxNkLrV+Fm70WbqSeeARxGLhNoVzDeOK6NjEA0TaDeCym5nlL93G6LHRPam5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270472; c=relaxed/simple;
	bh=GWTkfYePYPEGTpO3+RiqLPCaGCSmezUWdnppwKHAMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhAL59ynYfCb+XT+ZP+6gD1l15Egl5f3si+eJKVLw41dEXJmvIqMUznyd7+y3ZKYnugwiWus7ZZPqdEp0kVKMtrOp2UErQ1ZGvj1KeKp6v2L4ChKnMic2KLoDbGrxgD4PyLgekUwkp7mfWBb+SReUsTQlUL/91OpB44z9LDNRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nrzk1bMa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GuWfXPXf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nrzk1bMa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GuWfXPXf"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCj4Vg3733341
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=; b=nrzk1bMa0A1H8jjP
	R71lHkiApB3IbtsXXD6BWzg4CBdLkhL2ePAs7944vvFj5cjExAWYRUYA59Bh9NlH
	HyyX3XclHJv52sf0k3NAq8dcC42z1lryIT0xNC++cxmPXdKkjbONft7WN2nhWvam
	4z4OJ0WJUh6IgkRRjqHYUy7cm6bwBE1Wb2iCNd2foaUMzSCTHOt4iVWF2XcUEBG6
	NeF1Zc4+BPoZwM4xD2ILoSrgowEuGgpOx9u9bTI0/qTalm/g6VivBEV/cmUZeiUD
	79ygZwqnZ0Jf0NNJageQqMlD27bss2GOzAf+PHic7+O7VubQV0emhlu92FPFKCea
	h5oHzA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r72xj3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:21:09 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6c4335eef08so1009959137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270469; x=1781875269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=GuWfXPXfs0NqiSLbxS+I+rRjaWT9lwLu59rhQbyERKtJGToL28RYY0KKz9coQt1ZQY
         fLyf4sK9UMs7Rz7yjUMTxCbZi0cXR/txSpVRBQKOHtSr2lQMv02JNNgEJJ94ED6mJFYW
         OOH+L6WU+jOM2mJc0akSNVPY5cplsYWTSOusBeZoEaCGeu7bqmIne6F60uJ8pyRBwEUI
         JP1ZwK3sFsQeD7yLDp4ZgtLBm50diOy7L8F//kjGz62Yr0uvz8AhSRum1PwG/m+VvQiJ
         mvIoyRn1mXVGq4LR3CLQXf1UWHNhJdUDV/vjp1JR/h5/DYZabPPaH7loOQuqsiLfqnk7
         OaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270469; x=1781875269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=Gv56AduUBljV4+mrwApQnz9JqJGKLqIo13APoa4qd9gsi73quyty3rXZHae+2bv3lj
         RctzeZP/8KUt4h1+PPG7BxUcFI99OAr/pszqskUQrYdzzuYd1ZukLnFMLS4TuzEqxV8u
         w5S5eqDRu7mwU/TtM0UtRdFBE4HUWvyfr5+MzkPdRC91ozwUVl3dIuvvAI6am5pykihE
         Q1VL3tSdze7Y08UuzcUInpbPOc2VPmdHIhQW72Lkupv8pcXspGVsEQuDWyoUAwZn5Svb
         SiRjLcr6Os0W0Wo2Eg4tdgCIIqQp3sjPHuPW6oBvVbCXVr2WuLJgofGBL5UHrzWu6uqO
         orNg==
X-Forwarded-Encrypted: i=1; AFNElJ/3xxO+NiAN4N6mYfh6TGLwgwE1gKgA5RrKiVbdZ5+J/jqo7YqLwZcfDq9rxXagRWg8fgWy6/uOQ3npDW/brkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM2eEnemnnOLNHxBMhkgDex/tCWfF8j++IHMJ60E1ozbmfXzQC
	3jF9q1qkZnw2Ri2QVcs0voqysTP7ag16U10NgWxKMKJK+GaykS75zdE3VS4v2Ah97eSJ/cxVcHb
	ALS/MMjMdOlTZFs11EpXW1Y8OYIJHUfLZuJYk11yQ8mgrLdfRexkDg3Ut3kB7OjTlsb/4Nlc=
X-Gm-Gg: Acq92OF2bQ3h9X7luXNl22kCYUGPKx/cwXmPtL0uDI/jxuYjlawRIZgzqDYRChariTt
	AI/b3nMALZSkDTohAH/s3Eh24QjIGbC9Doua33iRmZbu8EUy4bVuUnRyKuhGlTwf2xGW5s67BmY
	vQ3dRfkCV59AIcphQT1cd2/jvp/r8kMj+QFxIBLwdH55lHzPOTN+NMYG3V+dKLbGE3lFr/Ll5pd
	GZxc2YaTS3b3spAianOETaByfFAQV4AwfS2RDZjlwqFO7O07Szy84Dqoz/RU9jqRBfUFhtUCmsf
	/fiJhn8Pk+hMmPoF3RNjwwlSyy78AhUVFk3xmKjfXcZBoQnPyqmoLjhXCLYIARZjQEIJmIO0FHX
	QvP60aKrycphmamQ4aebjxrd8RMGJyvfUy1O6/VZCAatZHj/cbQTl9ItRWqxmvoUMrMZ7snRmys
	pDXT85KibecJ7PQK9k4wNXcFFLbXSsEwda6Qp/Bmf7Wxb/tHK+26vq/z4Ntov9Ij7i1drvNcRa
X-Received: by 2002:a05:6102:5087:b0:631:37cb:1e64 with SMTP id ada2fe7eead31-71e88aeb96cmr1414561137.4.1781270468718;
        Fri, 12 Jun 2026 06:21:08 -0700 (PDT)
X-Received: by 2002:a05:6102:5087:b0:631:37cb:1e64 with SMTP id ada2fe7eead31-71e88aeb96cmr1414519137.4.1781270468317;
        Fri, 12 Jun 2026 06:21:08 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:07 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:55 +0200
Subject: [PATCH v5 3/9] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-3-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: RFkVpfd63JCNGq3E13cDiq8kr9RF21UL
X-Authority-Analysis: v=2.4 cv=RJGD2Yi+ c=1 sm=1 tr=0 ts=6a2c07c5 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: RFkVpfd63JCNGq3E13cDiq8kr9RF21UL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfXw2jVlaXGojcW
 sS01voyhuTpTyWmb+Pxz+z/B6msuunmvfPI13JzFCTIcYHQiDxYV6b0Ara0qabBjdEBww9XTEw/
 4+v7cPSBT6Z5iV0M8LLax+vALDUHH1FM6hp8fxEhA/T9m4oPftbpf2pISOkVzSpUiL+C8cbWbKo
 sWnlgxAiCTsawXHurxT64m5vaRRGaudArwIWP+W5R4H88TUGkua4YA88kIcmAofl6n79ruvSIWB
 0gv1LPbSbFKhSxMuia/rFJVWVD53SID5QMshol+l7QVOcCGTPo6fsNMwLOntb+y/JlHJUEOe4Mp
 ckWlLhkAOoIhqQIJaeshLK6pZEphTJVSVBBk0VoKPecJq5gOcM+tSrQy0/zkcZ65FS/YnETN91b
 ySe8wm7c3Cu6icJfMT4kFZJFTXPvVERTB7nvMIRtn44TvcORsYKQTJNSgajji4kV2/HCuqQIwY9
 ItkLf0Pz+9xEFut7zUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX/P4mdShcwJoH
 tLuDUcAAM154dW2uQhZQ2ZzzUx+9d/JpHQU+neOMNMbsjYqL1IQ3ARdp0/XvP5prcCgvAdE8w1Z
 M2i4HxFABg8wEcPEgEeCtj6Rz+vZVbA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120122

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


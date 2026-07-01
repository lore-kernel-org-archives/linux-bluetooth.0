Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A24BC00F
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921666; cv=none; b=SAWN58qz4VxTyvuwVnjsrlGDy16BDzbvTLk884jzDVwCkjsTGsmSvQMgfgt7N6kWxfCWxQ5w66etiGmlBrK7djY/4buvwKzL+HMRdyQLB2oxWjaoaXJtvY8D6TZZzip0rEhuvF4AZFjFbWZbJNezgRJ67b270fZhXMuaDuMR6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921666; c=relaxed/simple;
	bh=GWTkfYePYPEGTpO3+RiqLPCaGCSmezUWdnppwKHAMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WeBImkg1RhCuzlcdqGP70IaBVTD2m5JfCzJEL62296Y4J2ujz/K0dtVS1LXO9oPZds5gW3JYJrhesXB/KMZ3Yac+NZ3LOFLm4iQfA4NorhPPpyQojVrNhKHBh8qUGBMLGWt1C638gMix2dwscoJkirPc0gmytd9MgVyd3nbfPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRY1uaTe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=alhe9P4Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HRY1uaTe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="alhe9P4Q"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoBb41468698
	for <linux-bluetooth@vger.kernel.org>; Wed, 1 Jul 2026 16:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=; b=HRY1uaTeGIIRXKEL
	6wsaDKZf2cVplnvu8A7vouedWY/oJZ9OBdObNQEd5NXv59+E12gXEZG2Pue3jodZ
	Bf9nuB74OOOyxq3OY8Jnt8//r1cOb5bzbB87nvHHzfO+zPeP+gIGxBWsXvnSGkOB
	2sC5Leun+VnKFM05qXn0uwb/uc/49eaUxgwfH6B6lFtaXTBwCCWPZQsULNVLy1It
	7+iLF/bWx4bxIcjYIzCL94f3uW4Vsgk9mMqVs2JtjJHf9HuhdLux2WDTPsfCyZ6u
	1cNFycmRWxPCwad87+4Sxcdt48EMG54PciKP0BCWCVCgOYX4Zt3uVLYeRRwTEMPg
	qjISzQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3sn163-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 16:00:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e663c29f2so101962385a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921638; x=1783526438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=alhe9P4Q4tCe33hu4R2/Ad33TZpZRpsVNsQGI2bv1xnNdGeXADKd3cJ/KvgldAUm4l
         oJMZXqWy62vYZVdGBLe0MZaQ2lqWclVX1EVZl8v41Fs9EugRJ8MGWFc8XYDiLkAAuxZR
         2VMPPfxA3uNYl59ghAnvfa2Cc3Cd9aoBvLWEpc9aEus2IL0upwJqKmVxlp++1xJ2hSlN
         urSvESYa4sCsHkokJDzsY2JM37UV3EPwhP3hHbC7keWibOlcXFpLfGWjMbKp+ddCUB7e
         mlkN7LvzPCmlGWHqCCfAyoxCE5IPUlzw8sU2DwOcihGwbAMPaNX3xBPx+r09CvrLV7R0
         Eqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921638; x=1783526438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=A4uR4TPGE6G2GJxONGGwiQV5WwI2pmqkEcjSZRR73ewx03Esll+lMKGw1PZj8X6u1o
         h1KrNTIl6h26rbmCXnqHAqQxBT2/m3NciCycfipgUeCM7x8a+4nSBi+SBxUAh6cM8g8s
         jWFf6WgO7wqQ9bD5mp+oJbEwG4iEbG+oHIp3e2AfovSk77xs/FOwQKEqvHCx06X0Zqm1
         nv6CdgyEw8x2FoqYKECkOQ07pHo5/yPR+C4kMtu8O8pdVmoqkxaDZv2ZxeBaTykGU8CV
         ZtqNd6GmW049mXLOn85OHn6BHDLHAX0Px7Ji9+kIGd2a/6vTivYTlwL3VsvvC/qKdyV7
         YGAw==
X-Forwarded-Encrypted: i=1; AFNElJ/GHmrJROqR6DbOvxYwC1H/WDyHr3ke9UjeLYqEqhiZMR58L1ychOqL+Vo6iHZv0qZm1Mi0UMco0tbXNuXMKIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzu5YlvAuNkA57G+jqtgbrsvjGOkV8Hv0hCGrMnjLwQ61WqIx
	gKTvjvQM+P7OZIYoWJoWi+utkVe2nU2HA1A9H8+YNg48gyzVHE+caSKc2dQeHoRlbsbcIij2ELu
	qTCRKSFAVWFdH5w7RPfKZKaHltULm/baOldohV8I6X3sk7ohiftnbOg465VsAC6CNtl/AHzY=
X-Gm-Gg: AfdE7ck+R/pocnhCvs22nq+bWDVR569qPF+Xc0zQanEVFAEocTqTuXPeUm6UnI4eZwq
	C9qJeZKTSw90E1qJKKKPQzFkOG3oCaGMIVVHdB7SYCnjAE85kePy0tperQiOJjCnPvkGDAwCSJY
	+lP/JG168Q99LA7EAiDzoSk/qmrgHf5gC7flF+K5f++H7wP2znpW8wEaVgauZEpr6xgMa35LM4k
	rt9ufwD65tXiMGbY3w+dR0031uoPl/SaadNymfdc5/K30uZ2CLgxtPNIfmnm8yAqomPDV7S0dwM
	AwEWSsJQiTj7sQ5Kp0SL86Gd2dSd71L0N8bUxd8vAjLHc9J3Y9exFLdLzzsZm7kiN38ItJZ0cYl
	UYo+W0LEkJ2ckxYtnsiqAqh9ruV9P7b2GG1OizjYvnbawyimwpMBI2K4rwpbbwQE8OKGapxx/e7
	XhqfnPGYRTxB8H4pRLtQcBUBgb4etobLCtvx9OA0Cl7SUdXmNbQCcLDmv+gDjMNec=
X-Received: by 2002:a05:620a:4096:b0:915:6ce1:3576 with SMTP id af79cd13be357-92e697c6671mr914774885a.20.1782921638211;
        Wed, 01 Jul 2026 09:00:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4096:b0:915:6ce1:3576 with SMTP id af79cd13be357-92e697c6671mr914758385a.20.1782921637397;
        Wed, 01 Jul 2026 09:00:37 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:36 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:26 +0200
Subject: [PATCH v7 2/9] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-2-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
X-Proofpoint-GUID: RLqyVcU9nG462ysI0vYbiUq0muckgjrT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX4FmoA3breFZT
 Q2cttc7dqxGZmHTFqHBu6NS9lNc40q/iSNbYfYHfkSYAQAMEL2i8DTj9DOyCtORPxRyclwu4bQR
 5AaZbYUZlFCR7Ma5W0x3FYVxIHUURwFlC9CUY4nFpo3FQN3tNCArLcE6y0ye717gxIOWlsWVjq8
 L/RhNmsYkl9O9cDayD/kInioKSWdLhYe5yNPPddRHJNuWAX7n9IP+J2ryn2tE7R4cyiQiOBgj8U
 gG/wA3DqerUeNVHNRwJseMzmQO9/7qR8zBv5xKmrst3elD9i5GqKbYkgXtwfBVRmWotvOnz1r3Y
 Pg9J35jFGaGLUZfA7J1XVMQPuDudUF2iQ845dk1pmc0R31RUGgXkcwcNEZ7xAgto3qKhvVnJ5RD
 HowesL8VLS/VK06KagEZQMHoZ7rxdLGLcsOZJI/K+1cbjeX2QUN0vSsvD6JHb6Sdbl2Xcgb+QNB
 qXHhz9liGpSxg3jZrng==
X-Proofpoint-ORIG-GUID: RLqyVcU9nG462ysI0vYbiUq0muckgjrT
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a4539a7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXxJstN7lRl/ey
 KAPnxtZgkmxPIO8PlavI6BE3t3V/vuCXxTCnHS0lftYdw5T4euu2KCfLnOQkzwgjQiFiF+iuJ/a
 5b16K/ey5fTMUcUG5Gxe9pUNK6Pmdjw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

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


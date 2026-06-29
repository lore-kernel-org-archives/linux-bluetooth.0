Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154923F8705
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723337; cv=none; b=gvPUsiGw2LMy2SQPIy1ay0w9kwBofEZCv1uzngiuXgW6EBaiLi8lZpB2AFHdhFnZWOwNro47EbT8mmL5rBepaY+EW2eYkYW8mGfBYvLKQSuo7MQjXfxjPs8jtuR04Y4fhY3OT1gWKucvPeIpPAOiVl7x8tp02Zu77mfWQE/Az0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723337; c=relaxed/simple;
	bh=GWTkfYePYPEGTpO3+RiqLPCaGCSmezUWdnppwKHAMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EiiEmqVbAm+Cpk1I3vzcHEE0X9cbOc8qG76Z0/eZVTBQmz7V6C45CkpzNjNE2MNsAihvk2L1gX2qzhhGIyy06lSkM/jvuaIJq4tUKiVpRroXblLJavT42fsuTaZDQATgNnM9VWxY9vxQGmFpKzwpd38EMbWmcqjxFBj2hCAICSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e13Tz6kI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QbgZUo2i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e13Tz6kI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QbgZUo2i"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6qwau2076271
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=; b=e13Tz6kIkamhMoyB
	AqyCH6LK7ijdeJzi8mw9q6lz57F/Ow9TLcusNIY3p57SGWT2u+O3U6K7e4UB7J2G
	ogjrH0OPfQFELQeerI3VUViYoM8y8m4USavzVNaAoYuLsxluNpSG/txMgDsf/w3j
	soMFqHdivw0sh4npujkwEjn4ywL0M2WOINtCmvuMk+3RN8roI3Q/p1jcob0NXBi1
	jlzY74NPlvYVX651DVAZ8MHYeUjX/IBFWNzBBSssuaeQe3d/kTe/iIJH7tLotVma
	oEtxlmnY5BRC2FXJSh76izJsOkfO17fGp4LnUdj3HMwytP4srQVIf55hWj4iikQi
	CkCOnA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7ggyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:55:34 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-966d40aca0eso3122499241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 01:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723333; x=1783328133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=QbgZUo2iHoKCTWS3QVajj3KNlBjmakUYbuiUb6Xk6Cs/K0Ql2+HvKY50C+6S7nbI45
         2ASG3EUtvNGFl04QDD3jUxzIpIytcpYE0Cpp5qyNrV3KOgrHUFZV59AKhqadDX8ku9p/
         hFQNH6mJzqm3r9ANjLvJYUgUznMgp2F6DP3BadMVJHPOYe19kJ9YZ7audU95PM6+dAU1
         kZxN+E6D1AJmPjJzd0+BZNQM23RZgujBzkxqGE5VmqhI5gvRFK/tLW6C3N47MRd/mbip
         c36P3sG4YO0vpnWImfmtaKgmoMacWZ5EYw9jhDo4goFGy28UeoOzO2zMUJJYJ6UHCKR9
         uPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723333; x=1783328133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=fA6Ls77qPug+zje3+IdoLrBnudWBHs71FPd97/T/FLqGz4nXKKDgVQ8VH9YOPQmtZE
         CWf7sMZ4IRcCDXV9FVKU2R9onQTFtq/EBqyJ9GaQsyGcnqVzV+EP0psNtF9Okushruei
         /TYxXlFYAePkFp5v+8LccrkubG2vAoGM4XXWlfOxv4KjWM7bRWwWmOcFJ6Bd2SuuUFxg
         UvpV9yZ3HngmccIx68owCxv030Q/j8ZDJSZ67cpwR+v113LElxiW7GtRapBnaQ9kRz8a
         gurKvXeO1qeaQu7OSk3lF4VLuRpoo2NUK6dlYy/6uKwzTywU6RnZ1SlFiuEUyKvAjOw9
         SLeg==
X-Forwarded-Encrypted: i=1; AHgh+RqFYn/K0AP7tUCJxx1B6cLVZt/1iLq3u+vP1mgzUGLNw9IdTcKCdW2kr6YTbhXAs9PrPAY4ltNrytUByzxVhJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtst6UBL7g623HplA7iQZ0d65hOcGlsM1xRw85JKoY3HAI1myR
	nxY5dRizRTLF94Q2w9U02wnDocaFdVweLQRtvnqIBqyycKJw4tPOYdmejmjchuPAGZJ6tRFAlEk
	tebe3hdm+E6gyA+/fH3/97N8plVq3GidwlssOmIY0YC0FMkXRlNYmhlA2jYMXQiJy0IkuagI=
X-Gm-Gg: AfdE7cm3NbH4XfnK7ShJnLGZzkQWXk/iOPe0VWviNdcF3VBZayEFa79IJg+RIGVFjjL
	4hkaL3z/JmcelD6+iUbvkAgJdAHuuzjq66fd2yzo/jE3HTzyQtaJ6PuawhMaKireSwZ5iMhboep
	1wvujkRPV+MT3H2hDSflw1qiu48EvfP7L4rqD2GdTtaCYOfVH4f+d+IcQzxAocc4O1hZ9O1Mp4M
	B34SyZyL11+72T9eIqBtmkwW5tlVLMLFdhd5mhPUsx3xGa2ciSv3C1ncIgTrE0yzqdRgGLBfxnm
	ewtBojj5mafXkFDZeoNnxAH4iCs8oVIXtNdXuIaehH2JdZlMg0YvdO6CbhflrJzXOSiWaYofVkr
	l+dFGpYT5YEqFr1Aj5AP6m08gnMC1DyP1Eb10/vxD5id8jYp8+x+l8nMUeYT/GYJag8DQrne3T/
	dAsjcsXAHn+vQsJ4Zx0S45VzA+V+Aexksg7oz7LDRWnqDOh7E7D5xrZvYh9Nqj/bq7kByI5lDLt
	AInPRLT5EnhIXMp0j0o
X-Received: by 2002:a05:6102:80a5:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-73435d8a3b2mr7432143137.17.1782723333433;
        Mon, 29 Jun 2026 01:55:33 -0700 (PDT)
X-Received: by 2002:a05:6102:80a5:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-73435d8a3b2mr7432116137.17.1782723333025;
        Mon, 29 Jun 2026 01:55:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:22 +0200
Subject: [PATCH v6 3/9] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-3-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX6BmyX353BSaI
 AWXTr+za/otDkawyvw5T0gPIwno58+KCYExlf0lonTYGEAKmwFpCiD/gOq9jytO5mKn7cUULuhR
 t0B6I3ugcy/riK8Uk0P44TqmfNGUgr0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfXzlE3u2ULCt0Z
 Kbhy6loROI1od/Q+lUUxn3gx5Jxki7sulYLMcYHOTZvTdc1HPThuF+AoeIBFcQH3dbEuxVmFPnC
 fTY+LCAMQMGQxLoNy2N7TJZLOexrvprW6xzkuoXY2NRrdZyJUreSc4ffHnmwNslx7hr0TyUSYoF
 nvOgzOAKOahsPz1fMRYsIPErYK7UD6JK24mxz5FWOugxtOmndtmsE1njI1zwMA7koe1Jjq/M7UB
 8a6iKadMq8b560p+OHLkYqKEN9uGPim2OKHnvuny7JIvmG/IHtJSw4MOGBKw/L38BFwz0cuDYoc
 ZVMfEVIsPmDE6YA9kZ9AreRNI1O5KRzZ2fLDF4eUWHN3Lnyi1ACc+IxdS7D6pGLnwQn8Fy5TJ0l
 jmeAqaE9liL1uAmAZpTVW8A4gTicG7/rXVv7S4orIw+b/c/ainUoa4CRjiis6vAsJvXCovhWnRm
 D2glUYyFQ+ntxv7vxzA==
X-Proofpoint-ORIG-GUID: ap4j7ZORz8KFXNuwIGjlKeO-hbJfXfue
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a423306 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: ap4j7ZORz8KFXNuwIGjlKeO-hbJfXfue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071

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


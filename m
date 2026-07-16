Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0437C0F3
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218740; cv=none; b=HY6b48yqDq0Xw/1v+wg4JQQhWfxrN4X/Egv6B/ttCqCtgEejVnht3QR6eoold6wW0RhXGMmtDCb7Pf6oZv1Aryq2i0Xeti2L9UuQJUw9aS37tbzswZ6aYPlXFlCH6YrzjdlP8oofj8jnnGHOtm9D+ysstWaROi3aCBpPkPQvUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218740; c=relaxed/simple;
	bh=AKJ2rYuq3UXtw84o9Wv2rgBoSN8Fv9N585Y291G3LZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMWEtkX7/rsYjbAj9hYAVHgyTx7ZWegPKnZ9Z/yBVgW1RGOoWWpTb374SEBEHcv1BpBD6Auwg9mW+H8eC8mYj85CfHQgm88FY2+8R0cTDfDLp38Eeejixtve/kVUFI5FRu5HqiW1ooWV62ZKprOwkZXVnucDmxkqbYENgAYi4as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iASYWyQi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=USWxPA0d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iASYWyQi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="USWxPA0d"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDKHdp2959787
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lSQgtm9Gy/goYjkRUPvH4fsLeTRSZbUNnPPwbkXFunA=; b=iASYWyQiOGz5VgA/
	XTn0KGINXOl7iwun+L+oaK4UAkSppUti72AQRZkNnhLuR7vlGMy9mYHpJZTlL1AS
	UCOFvEyNexd/9B8cYqhNYm874EsqBHlM2inRvqdW77kI96fLNTftVFb/lYiKLtsG
	izL6/2U1hmISKnZKom+b04CJLrwYK/woloqfhSEsBa29akkHZBX4MrQzNyd+LEbG
	YONpu/dlF9TLwyHAXLY1UknVarwA3a50abYjFz/NLt7GhRneucqbDGu+n6johAq5
	POp/1A0LGxxHL8eQfEhXIKFoL1sxcvK77aXu5LiRBgZT/jAy/9+35RjtxI8XPFoE
	ub5I5Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym19067-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c075c1e25so86530441cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218728; x=1784823528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lSQgtm9Gy/goYjkRUPvH4fsLeTRSZbUNnPPwbkXFunA=;
        b=USWxPA0dquVSQCqvRP/vyS8ZY0IzO7Jnh0OHbV+D/3D4RPjH7zGsTYDLljjG4kU9QU
         0IV4wBID7q2wPFNRuUmYo99CUraiqK2SvWuyp14RKFcZKGiD52es1696Rp9oe2KaRyu0
         bzL3pveUsKO1jOFvwSlftMq1LiscsWRo6IyeDK7Kiyt/Mqft+r2KzF4f29qZR1iWiqYW
         RU2CzbBWDEUDgDB0dJFOIh7gvyCuRaVhAvIGNk+lep2tRFgvFJzqwW+Cdnvkapf0uTZp
         xgD8b1DOobcKRlYN/Zd7JCjzopJUTx6YutGEIzJTx9o+jzjzvMjtjpuBtcEdo1SmogWg
         ln8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218728; x=1784823528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lSQgtm9Gy/goYjkRUPvH4fsLeTRSZbUNnPPwbkXFunA=;
        b=G21PEJ4C22DCNtTGLyBwxSJuDR40C4YHM5S2sv0itqzSPMueOaiGFz9EOaXs8KGo3S
         5m/Y6tKkh0oLk3oBHbZIN+0+nXRZHVl3Em1LYCTQgH9dru2UjpChb49niwM3BilWHOKR
         U6+2tuB2SxVEWud3/OZDSPN9NQ8b+Tl2LXfz6ooNnXcooh0CGW9M2eGN3ZStG4jP1utn
         NsvEQbLZH8vW0y5X9VuiRVQVi6dDtOgG/Pfa0qYRdrEYm49R0R7HFBR6QhgF+jAagNmF
         cw+zWb8R7BDK3wAfwSOPPMJVlPF0t85JBW8HLnxUZryUB0h/NfKbhMjtm0q4odG+GH5i
         Jiyw==
X-Forwarded-Encrypted: i=1; AHgh+RrwTnt6CSgGdwcznoEsNMyMNzCRg87PQ7lGFIVW5YNFIqzcr6xw1u0nf9FWAQUFrJ58vUq0omjPy7VN80adUfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxIDj6yUQvjmOwS24j31DVwhxC8yN0XKOe5qdVdoJV1a/xotFw
	zs/Oxi4NGUgnbnbbUn5SbaVVesbsO9FU4yZxO7oG4TvZyD/EZzRqIRAp9Dv/NbsTPUrkiwF4f1n
	5ALf5h51BMajzm1U6hANiUyqoESH9yKiWooXE6ZeprpT+IcJ5XAkmQ9uiuO80SMY2CqK7Wlc=
X-Gm-Gg: AfdE7cm9SVBwipVhxk0m430DTiyHI2FX9+HWL28A3ki/THxwFRfjSWNSzmwCg3IoTDg
	78QkXkB5Ji+j5uJIbKfnsfZO/ur2ytXY3fhjnO2BfQPrssofKZ1FW4Cs4nuMDQE0hrLrmo5Ek3M
	DKi3L5Y1cICsyE2tUbovb36IeKAZPklWODaViHQa3hJxfMNlEDbXuWycpqW3+7SD+vqnTv7/6Yv
	wZ+RQK4U12l76M3yT4W245CKT01pK+8Q9o/CCrVYw3wDliShi2/X5iKs6sqrrXRfyV6wfBD5kPb
	Loojv+8l6iMFAV0UyOi+fJAiSAoIxhOS8HuZ5ZqY7PR5lZhaYaWCUJcxjAxVg26rU1inpIgNi0C
	M1LNTT/0GJNiAsEuxScGvgc9Pj3VlQkXCYExoqcWENV4U4bU9zVMBL0QVz72ydW1ss9YlInQOpn
	53LQPyIu5bI/iM4KbSvznn4drqUmug0fosnFBxNah5rRWjUFTnZDQ=
X-Received: by 2002:ac8:7f92:0:b0:51a:8c9c:7f3e with SMTP id d75a77b69052e-51e424dc615mr122134611cf.65.1784218727535;
        Thu, 16 Jul 2026 09:18:47 -0700 (PDT)
X-Received: by 2002:ac8:7f92:0:b0:51a:8c9c:7f3e with SMTP id d75a77b69052e-51e424dc615mr122134121cf.65.1784218726995;
        Thu, 16 Jul 2026 09:18:46 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:26 +0200
Subject: [PATCH v4 09/11] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-9-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a590468 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX/2UdclZunGyU
 7rlZdqjHC4L0s0CzOdLttkZnjrwsVoOE+pwazQlHeWQQWO5BNt/+Fdr257a8065SXpbNQa4ZJLI
 7wMVz02ecKpmuTXhGjIJTZ+yIUcj3YQSNAPgM2iAoih4cTAR2oakzQp0m5FmfSxp1VdRGln+EkP
 loBGaaaT3BSnFNfzESCKrI7rq/XnuyMfQdn8FgTE2MTGpddQ1I6bf/y+mHzj+y57NsRGOiYYJxV
 IBtAH0najjJhcU2NXcKuxtDqeB7VV0C+FGlhQKA8cQtVERd9TUyCF/FGiLlzTLwiWcHDjgU7z0A
 5STtAFlozxVnO+olSp5XRBMkuhyS/pNU9oGGPB1g2eX6afMfslYdZ3fgSOJkFlEpw6xgIN4Ifzp
 6rZKr/i2qkQMpNskPHeqXOQO+RRVuyYFr2ZsgraGBxZW0iwKscA5oFw8Nu1LCSvYkPm6JcloMYe
 isv4/1B3+2AzM9G9ouA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX/TPd91Y45R0T
 4Ng0vCqEFlI7FguSV0L8Ual4vFNsshODXTsRG428YpiAhdOrNx78hXcRqR4ZxPZCMJG6liYPPUq
 xCIN7J5jG0V9nT+7P+SNwsNR5xZ2Leo=
X-Proofpoint-GUID: IOfnjNK3sr45B6CsKD3aEEsgK3IPz6BL
X-Proofpoint-ORIG-GUID: IOfnjNK3sr45B6CsKD3aEEsgK3IPz6BL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160166

Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
Key E interface signals but are physically soldered as an LGA package
rather than plugged into a real M.2 Key E connector socket. Such designs
are not actual M.2 Key E connectors, so describe them with a dedicated
vendor-specific compatible while keeping "pcie-m2-e-connector" as a
fallback for the shared signal semantics.

Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 found on
Arduino Ventuno Q (Monaco Monza).

Add "qcom,pcie-m2-1620-lga-connector" for the M.2 LGA 1620 found on
The Lenovo Thinkpad T14s.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml        | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index f7859aa9b63469cb43919c0b5719c18694c5364d..ce6173a0ec41cfe8ab4a5780940999c18674ab7e 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -17,7 +17,13 @@ description:
 
 properties:
   compatible:
-    const: pcie-m2-e-connector
+    oneOf:
+      - const: pcie-m2-e-connector
+      - items:
+          - enum:
+              - qcom,pcie-m2-1418-lga-connector
+              - qcom,pcie-m2-1620-lga-connector
+          - const: pcie-m2-e-connector
 
   vpcie3v3-supply:
     description: A phandle to the regulator for 3.3v supply.

-- 
2.34.1


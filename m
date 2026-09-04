Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3FD501F30
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536572; cv=none; b=NM7QD11jwdV1+e8K77+qKT/Q6vpctrl782s0ioX0PchiygP6dcP/lJMLm0qSiozGAgq0ayMjnygUxXNQMPxPfH8p4SABnRgTda0yaW7T36TT3rpe8Vk1Dt5+tDDc9LaRJj5loWvF13dGGzHY2PuwO+eHvljVE2lOLEDUr7VcoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536572; c=relaxed/simple;
	bh=xbR26F+2IK0SwAaQUmAO2+Xe1VwKVtt+NKXks4bobiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJ/hWSpMcmXtfLqKhKr/P1h1SkGTXmMST/KXyXgfdBkcwioEKZC7NV9DBuXtArMhdRO5UQzfp97mn8WjEkZ4wS/P4rQbs9yFBuucYsevhp7iQ18SeGQHTHsLRV7IhlpV6+9aS7/8WmZayS02ZhHElyTIf7eDKPxaEbeP9tQD6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BmEHQOFp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C78XCQ05; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BmEHQOFp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C78XCQ05"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684EiK8V2669647
	for <linux-bluetooth@vger.kernel.org>; Fri, 4 Sep 2026 15:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=BmEHQOFpvXB48fJ4
	P1WQHuWfNgNBcd48t263ya3ZJ3FjhhfBm4wN2SuGwdL1U261fXC64ttaIDYxEqmW
	1oUwVFtMAx5KKiJ63MSHVAfIIC5dNLddFLwAAKvvd7/dM68VDCUGOYJvbrMoCPtQ
	VQvXNTvIcP+CALYLBm6YOhSrWbzs3krdf8wFvIfz5KzB+yKtvZVgwDLF6Lqqc6jB
	7yPUDMc1gl7psTUCFJW1mOXNw9irpd9wH5OpCx7l5LMO1rWtb/G9mTnVB3ZdH3Ce
	+wqdtKMygx87w72zbuR2KGWYJ/2ngYaqJXH7WKzPcKQadp8lYbhcppfN+yytyocL
	s1D+og==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg00yr8h7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 15:42:42 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97e9e2deaa4so934858241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536561; x=1789141361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=C78XCQ051C/5zkLm85zxYNCBpzTL6jT/I7Cfftz4GuGn6Uuudg/0AMGWPdXIhRgATv
         FDYluS66mNea4TfdCjsfxSejf2xE/nJ6nH14oIvTRmtiD93fAnA9TNKS1Hxh4O5UC3KB
         VDryFl1e1PuEGC4ZO1ATwQoU8tdMuDyRcCAT4FUcmHJCK2/Wm7sVmHMvPmnW7J9D/3F0
         N4WRujgQ6q4fd+Du26J8oqxF3XRVTJtvhQ8gvgy/oivbfbe5HeAYX/+xejPFsxSb96ta
         Wcy1ZvCY5RRJg0p1I4QQPTLVzAPSmNwqQ9NyfNXW64h+vE+zlS50ztbTZqueXsu/EXUX
         QYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536561; x=1789141361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=ifCKIZUXYg9sLMDxpo6VNaJBVZfkq3G+ZYjdYinKOUj/jlEEimRUBIcUIeLxglZUc8
         w6BCky4YEHg4aE3r2Mei0OZM2kx9WIvs9QzC0WXKq6OlQu7uFwiZhhF/5gzZ+B1Wi9u8
         YfKIyzLwwOT6ie56dRTgzTHrYXH7pGK9y5eTQy2XfzvxzHqdUIRZRNUOOXFKQNMY0eJ3
         OOfEfvLRTI7P9itORYqUIlrQEFck3+GlvI4cLILDeUqxw+ZoYB0b5pfS1CX2eDZMjb9H
         9FzI6zdSaMzFsmp8xcqterw5oqTzEsI6SMHMP47/qEuQkbtySRxdQ6yEZQc5e1jAuRZz
         rtHA==
X-Forwarded-Encrypted: i=1; AKwUvBw2ft0DV0Zxx71CUXn7GfJvp9gu5B1gyW0VExIBL2S566GF1JNvxRk9KFiD9zlm5X3uvu+S87Cau/O0wOQDVYA=@vger.kernel.org
X-Gm-Message-State: AFuF++l3YUxrSQ1yzvPFv4J3K2isHB6eeQ5zaUASqJfw6P57FGBEfi6t
	JZMcvumwOvDRmBUiMF/uWrmV7jkbJVilEvbmJlE2xf+Ewa+FfJlUgwTikfqojcl9vWMlzqdWUsg
	WblOmDVCYScr8Vexcq9ai7QuMqjaxOsA9akGOkVBom4Z6TsAXq6A15FX0851uoFjioTUs8ao=
X-Gm-Gg: AYBFou3GpKnGCo2p3+d+tsfAXK61Sx7ZcCiO/1P3X8sjhxQD9RpYmuD8oaoBbmtfbx9
	IR1b/xnMMAtuJcT/w9tp4tyU/NgO5ZOJham2djqswudaMOMIyXuPZHmn6ejnSCYhD9yDNE0NQ+b
	dlVoFTQWHBHl2wG30voInv+EEnGflIrIFDVBZwrjhPvGwTgotOmVobtHKlT6MCfTdZ9zdFvIFgb
	DzgmkXwbgUWZIteLTqurZleCinXyaHmIv6DvqqATS2Lpw/jRHYcrpPD+MQ3xDypHFLrnLD096Zi
	Lno7sZkH/ZSIzYglMbP5Z0Xu58C1r6O7g7FVTkYdM1+w5mL882ir0vENDy73mI7QGd5TYr85MOi
	tp8P9lEpRHf7ETTg8c5I6a0/qr5px4lAVBFjJFunzYDDQRWgJ+Ez5E7/xWZvOu0bCC14ZeqXP1/
	n0uzdas8zpNWzNR5B2h4GPfw0xMEC/R2D8z8YOWZmRLwicpdiXpBE=
X-Received: by 2002:a05:6102:570f:b0:785:e444:15de with SMTP id ada2fe7eead31-78a4a8b86c6mr2764699137.6.1788536561250;
        Fri, 04 Sep 2026 08:42:41 -0700 (PDT)
X-Received: by 2002:a05:6102:570f:b0:785:e444:15de with SMTP id ada2fe7eead31-78a4a8b86c6mr2764676137.6.1788536560793;
        Fri, 04 Sep 2026 08:42:40 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:25 +0200
Subject: [PATCH v6 10/11] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-10-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
In-Reply-To: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfXwbO5XWH0iESD
 VxK+jsXfp3Pi5TI5uQxofjgovG/sDVeO/NWWQ20JV90vd1QUrEwjoYdJV7PLl3wuKf0Mhzq/BMv
 jaaFV/OahA7IPD5xLOq0tEXM4e/ZCjc=
X-Authority-Analysis: v=2.4 cv=TP11jVla c=1 sm=1 tr=0 ts=6a9ae6f2 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: _ZmGfPCCF0Rz2He9yVH-KDhmBOBZcYlX
X-Proofpoint-GUID: _ZmGfPCCF0Rz2He9yVH-KDhmBOBZcYlX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX3CLNl3UlC3sR
 EyqGA6dX6E1StDgr2P65BwQWRNOk70pvgaOQyLYofrq2QTQ+WP07ZiAXLhOXIZrL9K8IFyQO4Js
 DvEZ2DUvbMKjHPpmMOfyts/xrgat5izGYZwvm5SSLxevvdM4nLMd1B22xovQ2aTsQ+gX4oq34QZ
 JvPyAGEuqgs0oR2E+dGJ1EGQ7GM7ITVy4DYhacaWZkQr9NV+T12FPjSogM+JMNiuYt+NcDbDA09
 W6tHr0H3xOJPQjePBIF0b2YtaBHfG8xX5wyCpuW8xWEFsU15UYZbVjDb5k4OkyQ6nE/KaCBMJvq
 kJY+D6GH9ZrDzcBFe5+v8I7EEa7BYhkrsgsQT7oKdrbBjRkHegM+wEXLIw+fyg4mjzscfQavyjl
 q5j7vYH2R+Jf9qelJF42PXAgsvQ8KdYwvQGkeSojh2ynRL61bWwS4xYVqJJna2Umr1aZfDI7vL9
 Wvfwcu4/2pIm6mjIyRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040143

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
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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


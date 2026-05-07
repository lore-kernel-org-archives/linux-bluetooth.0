Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C55244A725
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167491; cv=none; b=GRPhCqp2NlZ6FFR5cQFOrcg9guz7r80wGI6xBAR88XYidHxBWdclztIVoY3mKcB1iDc85/oANQvY5Sx2FUNmEhFhVinStq8ymuXIKX8tLARMtyeakZDqgMU98ePEvjWujF96IkM4SOTV1iOlM88K87HTgLsmCxnuSTlVhZBvA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167491; c=relaxed/simple;
	bh=Yq9eZWlTIDpBT1jqRXA1YcQ7jewB4Li4nESrsfqdqxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aeba4KmNKjHOTeyIHJnhCpkTSTSAHzmth4WEJNO00GDfmw2zMwKNVGO2XguKiIabxIUYV9mmlIXKopXcH4ajjtSvBXNOXfD2wz63MjFdckDQd6qgLjpLtr2xBs76owE2BUyenqzC75bhDTPCTIxUPgJQX0qsdWobsNLtLCmvx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PHIaw8lj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UqyYzGxt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PHIaw8lj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UqyYzGxt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BxaH62734203
	for <linux-bluetooth@vger.kernel.org>; Thu, 7 May 2026 15:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z8YhFkwRRG7HQCuWlp0zuKi3fIa5ZkmTd/FI4268HU0=; b=PHIaw8ljGKMKOyXW
	JOMO0FrKk7092/z3zBfZ51Z0eshaRXz/CQjQi3MqCNsDNbb1qyI6e1z8L6NOHnkr
	a1T9wEdg+HlOXoTK3j8BvpPkfYpIYnQpUUdIHv3nEYEtQ6QuuHUsOFBNOYnw/w5k
	G2dlYAXt7ffweosKr94E6p9uMOyUBDLi6BeLLgIrCIfN6eB3m4+vWiIyvLUwJqUL
	IeNMZtKS/iDJbuF36Egxpn6xYoL4qBCCYwivxpddkuSgwv+10CSYj8MbKhHJIe0U
	Vg0yh/yatuoRZzZWNG2qQ3C7Gm1F+6hc4NFRkzcjcFx6rUa0Rh0SVRfIm84CrLFu
	IbJ5LA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tbqrt3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 15:24:48 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-62f5497f0b0so684936137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167488; x=1778772288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8YhFkwRRG7HQCuWlp0zuKi3fIa5ZkmTd/FI4268HU0=;
        b=UqyYzGxtw4RaQzs+Lh7p3NAX+TfIazBHUHl3Tt9PoIe22UEUWSag0zGZPWXj6nFdoa
         US9Pn74G3mNcsuuFo+X/XgxXikIOYw7eFIBrj8S9FZfN+nS2vLJ6YvI4fHxY5uJlQVUp
         crYdIPHBbNbwuzxZ1im8QrBxY/KxQg0B/eULb9Wh+WUNMUboYLovphyOOjUL9Zw3fI9r
         vcvXH6fmR6WE094U3VU8efcdFEL3jwtRYslld5EKDupMG10t5Xvd7TP3Fyb4+9XJ8Fd2
         GIdUdFy1918mpYnHZwwBLB/0/YJNh/IJD552BSffi8RHc4Swpis0f4CYLisf+w/SU+S8
         SFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167488; x=1778772288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z8YhFkwRRG7HQCuWlp0zuKi3fIa5ZkmTd/FI4268HU0=;
        b=jw7Eug4z9ZUYOoMPUv30ad+iCbff0qly0Fwg7rLt/dCs5vfz6rVLeFoBRdOWe6Dvma
         2TzgiG3GrORgGYiTqKi5k9qn3kQe61dGzzm5Oqut8r1apn4AuK4wbYRDbp7ddpHI9zE6
         chZBWkkEiPNfiYy+IxyACWrINKuilLlElYr4GjurXmj0o51NZmkoRwICyzK5tSVvv9NU
         BZwYCgQexm3GxHa1OEMCF6YZHdXp76KFkr2OO1d9ZdYmwuFYZNySqnxzuMLtugiLiy+A
         U1e/DBQFLpMPswCTgjuudHvJ7eqsuz/WdmvF40TUAqLY6m+AQrtCraRuwPlXZelY97y5
         n+zQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Zvht/87WuXAPCTE5HpYeBX/AXocJD6Pw3JWbRfoIRPohfBKFBMQu5MOECHSX6z29HX+IMGujMMwF0QmJ8RSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgEFLF7iAdOCAJB5pBEaGav6A5dOFiDkE9LWbQOhQPrTrhHG5s
	kjGaOmsRj8koaPm2gwUwq3wZnK/btojurFy3tv1l2hZ+1RB3X7KEfVHVBi8xjzpNyJbBCjMAtlQ
	YxPyGBoIrSyevToGhpi0lxGAFgdC3gcETiagZw1wHT46uWck/Vp3O8iV+k7lH71HE0cCQZ7k=
X-Gm-Gg: AeBDiev3ijsWeH7K8lZA419FqbHMGV3J50eWgzaOHyt2XQH2wRzcjCqI8dkkcRINfX+
	LLkI8KmjnaW72gEE6LRk6ycy7xWcOSyylDKBpl0kOaHMkv+rUSt8GPg0zgiYd9dRjHX0l5oapNf
	jdJGZbAF5nRcKNfeob/mG5LDe4dG8vyKwSDixmmzJMqIh+DLJXxGc+oODZfeREuhNy2jbDuBxXI
	nlOgxua+P01ckrBSg+bzF4ln4d04Tu8m7kLIr3GBB8dY5rW273jgvkIutcWS54wG8MhM21qowuc
	UmFg2+zgwdYX5Z/QNq3/9umaAhUiH1b/5/X1Gu5v7tql831g7bVAVhliviXxt5CuTnJqS54QPcK
	5cT4wxpbIp0+mneN88ktGDx7LoYI0l1BKCqr3xhYmNQXq6s00g8P+J1FyMTXcVGJF7XXNRBo69S
	Rh8u/CwXdX/bjorx+ns8E52ULExZk=
X-Received: by 2002:a05:6102:1614:b0:62f:c97f:aec4 with SMTP id ada2fe7eead31-630f927f4fbmr3735554137.27.1778167487868;
        Thu, 07 May 2026 08:24:47 -0700 (PDT)
X-Received: by 2002:a05:6102:1614:b0:62f:c97f:aec4 with SMTP id ada2fe7eead31-630f927f4fbmr3735537137.27.1778167487442;
        Thu, 07 May 2026 08:24:47 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:46 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:36 +0200
Subject: [PATCH v2 1/8] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-1-bf17edd5134e@oss.qualcomm.com>
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
In-Reply-To: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: Hkc1YiUFBy6ltiEic35lyNJZes2aJoHF
X-Authority-Analysis: v=2.4 cv=SJVykuvH c=1 sm=1 tr=0 ts=69fcaec0 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=hFPe-bIbDLvfECHHD4sA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: Hkc1YiUFBy6ltiEic35lyNJZes2aJoHF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfXxrp0x+G5LNxV
 FUcfjUi1dGbiJVrhUFvBaaAkU2b1TomDE46WRGbnOR017mX+EX+atdt2csPMkg2TeWdlvuYQJPS
 H7MPcaRn/vCCyJGK/rLToDmth4cJtjLijTJQePtLsuuoy7NC0fOq4WVitUeCCLg0+oRqd7Tlriu
 cPIwCBP4nsLeyyi1EBkAhIH4kzN1ca9g8QfhYLtfCgcQHrmQEzzTq+ypyRC2Nk1jUePWZHzH83N
 Q3VsGWagXcsqNHK05iOUcweK+UE/foCxufgURvV7x2LZGwIQKDmjGbkQOHD1+7J1XXMnaIqRpgr
 CusQku51P89iji5SK/c3e8YfTvQOIOgykP/JG8+9ysJFS7kXefLj0nod0tjhTxGlZaR4NmuAA9M
 zmxQW9n8rXC3P4A0J6F8wXOO6xu/VC08X1XJmaxYpMIGY22Yg6fE41M12qJBXa0nzTIbTWBimYx
 DdKcS7tTA1WuZXBT8DA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070154

Add support for an nvmem-layout subnode under an eMMC hardware
partition. This allows the partition to be exposed as an NVMEM
provider and its internal layout to be described. For example,
an eMMC boot partition can be used to store device-specific
information such as a WiFi MAC address.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..b21426a49cf1d9aae5b4e8e447b5be11b08c96bf 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -40,6 +40,9 @@ patternProperties:
         contains:
           const: fixed-partitions
 
+      nvmem-layout:
+        $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+
 required:
   - compatible
   - reg
@@ -86,6 +89,27 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                nvmem-layout {
+                    compatible = "fixed-layout";
+
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    mac-addr@4400 {
+                        compatible = "mac-base";
+                        reg = <0x4400 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+
+                    bd-addr@5400 {
+                        compatible = "mac-base";
+                        reg = <0x5400 0x6>;
+                        #nvmem-cell-cells = <1>;
+                    };
+                };
+            };
         };
     };
 

-- 
2.34.1


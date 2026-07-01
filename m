Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFD84949F2
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921647; cv=none; b=MvnyaPwSIL/Cne3zDiYsxfgmBdNcty+AtsxQwLL6Q9LsY+w9H1HsJAVfnEfLdRu/5XFqtWnIY2cWv64x3vIycR2jqa142O5imA3PCoXRgiZFHjEPwW+gbC4Ph/b+m7rvpKFDPZeFkLxaoOBipplLqnlLahOLvuuyJdnemSbUnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921647; c=relaxed/simple;
	bh=g/kZEO26OX4smC+wgpc8bkbcZi84SL0SycYp6R1V6Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MIUNn4Z5vTE54QBhKwGqPhVplIZUgdRXWBNhzKEvcDQp5xCpuDLZB2PSn9wzGbPMaagnbL0K7kHt0LSNnk0BrxoorP+gMSr82nVhrd0qecJMZK3AJrHOp3zoxBxCLoyniWjr02AuTINWQWqtWobLFaQ+v4RSIeD3tm9zTWQJG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYgaxU/5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WBVFoOHM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYgaxU/5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WBVFoOHM"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Fo8OF1428920
	for <linux-bluetooth@vger.kernel.org>; Wed, 1 Jul 2026 16:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=; b=RYgaxU/5XUemkleJ
	+rGnL5+wvDRn3jX+6HhlJkaAfVY+AZvzcQXBWB4qc1A05Oz36348cY8xMTbV4J6n
	JLqnk+nD1Q34IFDibZp0WwG5205v1LtKlJtv/2Fk8XjVYR7e9Acw7hFPrSFGxPT8
	rjfGdLGJMMhP9QFUdk/CIxmQuESLSAwZhrETYVqDodpraqRtS12dzEEvLh00MwUG
	4nEj88OiIxNp4nt9yl0YqBzukogbPHUP9ZdfWnv2wzhc4wA5GsgwqtKGg5/0Ah6k
	SlnJUuDDe0qqPs5NziuQNYsdKov2JzdJLN+0gIrDakdbISMtCviZ233f9L39FB4Q
	I3KTCA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f53q08n4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 16:00:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e63df032bso284379685a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921637; x=1783526437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=WBVFoOHMd8wLGJdUvVpq2yxu7hTsoelaMNa2IAZPmLKoj/LRgAK8FyPiyOo/gqot+A
         HXkmxLyKRyjaldPQiLORwdbzj3csVSg0TxRENPGRvQZDdwmYl7svpsRmZpEJkDa9g1DH
         MN+gcRTgHL9Ycfr+2by2E+lZJlm1s1xsk/KeVIpbE6uMO6kvGX+W+uE7q31q90wSsXck
         YSAOpeCuBu3s7EnQkCxo7fAhoMaT9dn7B9oHzlsdaVFH2mMdQEdICdzTF4owNYRKRbhq
         H6H6VSUbvF0+RAnxYBlVLhtbEzhPoB65Ek8ZtsP5DLy2byU8qrUJiqyQ/iEWpgEfMbOV
         YTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921637; x=1783526437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=qvy/YV9ShdIhShydtCvzQi4OE6YdVUb1Ea7ZHkzCvExux/mSww4BehaoluKKt5hjUA
         PJE0hJg0gwV8hSfJ9yYvJUnDNfNif3tzXNvR2ftY75XbiFE8d9WlYgBrLK1g8fLWCHep
         HqQbkDQ0WSnDLJfK/t8HCrQTTKfv8bXvYlEZJ5MTBAOx9nG5IpZA4L1KkhG5TUFsps6v
         r9h9XlOQ2xBSldzF/89zBIvtLPmnXDhNyB4nYst5shRMGUnhQp9JtEe9fLw99fVK9Qdw
         6DOSonChZFOjLro/O0D5rIS7OEAAFn2uZfGtWd/KqfeQ/P5LdRNyMMspyjMICTKrRN8n
         VgTg==
X-Forwarded-Encrypted: i=1; AFNElJ/wIC2Ad4GMBudEyRZ9mUSTwANY8Kql2VbnMXCmBax+ELB3KNVhrMac9knv8isS1iLEcDC/QfWGJeprKN5cObI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2wxIdrgrtnNKX5bQDo1NIrKnSxDr3eHsOMgmuU0ELlNkwtV2L
	64wFGDCV+OckvApWPzMWTFSDZAgEn1cTC7IVW8qixtNgmLQNKnjtIHBn1i/Px/VdsgtqL2zpBPC
	pIm2OrXVLYa6fMbCojzyl5+rP+AnibcwoADn5Ip0qVLPGYttn/Va6rhWsQ+wFu2h0vACkA9U=
X-Gm-Gg: AfdE7cllh+xnaFmwAkkMWCm7Hhy7rPHPFHwDnCLZWrxZLs+X23WKORJBkP5MCSDhoUt
	3gPpvetPnwrkfp9y47MAp7lH6cCKh9XknJgAHn+36YjLl4ixWwtBoj+sV1p1KCY8v2+VnOPE+t2
	kC6RbcN1XybiHoMnOdK3/9mZcqD37cogmO69tFCjFr1IEA61WvmkiMmIzeJ3lRZPcT19wmstj7l
	t6Mjxu/TAHcaUhI6SJn9hw8zQ3C1AVZCBYfICvBGd7AeTAfx66MEkR9svDuTp/6BzTiVJTK04Hg
	rqhxbT+qFnlyMwpaxS30GBecSveir/4gz+GRO7QcMrBoopgm45xq6L+dBq8KYQsUC1RK0Y8K/cl
	YGs9oJTtaFnxCWTs6ovyf5f4AUxo5YxPJGZdZ7tCLBjwSqtEddS7/3Z3dSwDwA9HlXs1NgX0WbB
	yA2RL0XubnIFZYWhcoViYQ1gX/oNtFAUJZ4focHLjD35xoOt6qKM9IkJR58CTDqzE=
X-Received: by 2002:a05:620a:4381:b0:915:29cd:306c with SMTP id af79cd13be357-92e696ad1f6mr886596685a.9.1782921635971;
        Wed, 01 Jul 2026 09:00:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4381:b0:915:29cd:306c with SMTP id af79cd13be357-92e696ad1f6mr886542085a.9.1782921633251;
        Wed, 01 Jul 2026 09:00:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:25 +0200
Subject: [PATCH v7 1/9] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-1-3fe8205ef0a8@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=dtnrzVg4 c=1 sm=1 tr=0 ts=6a4539a5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: ciDhD2tPJ2X9bqpXUapneTVNpLIyIX_l
X-Proofpoint-GUID: ciDhD2tPJ2X9bqpXUapneTVNpLIyIX_l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXzDPOgw/CQvtC
 OWrySQNEtiPcUWBkku6zxJk1wzvLfum7STGQ9yhs6H5cksEZP/MFUy25onVXk3I8DM1CXMbRLSq
 MO4jIFf6hTamp/AOETPoypmM4OMq7guFb9akckrntFo+t5jE4y3Z1xMxHxmfkDzlCM1BmX+eXIC
 14OLwznKs/LnXIjGJ+3ryDiHfOLa/z/kaAJ+mxufg7Znw31TjAUQ8QoIX1iJzhYUtinW1fdDmq4
 cQV2QtqoQoufJNCzKhpOYQ1Im8KFzuD74GiXLWRUR2LftVDu5yFSGztTx4pQWEG7lgVKY4lN136
 cW0sKV8RjtUAkLj3LBVpM2PAOXdL9lluWTmFtO1a2M/mV+ExCvxCDJLbAPUVkCJ4YZs7FQs9ATU
 /QOD3/ztWbT5o/T+beWbHv3Jx/hv3EJzF9BOfVt2MgUhJmZ0twMtTGfIP2xdzuTfgvxV1cXi6uO
 Eds1vevn/ToDKwnQ/VA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXyHXNknlad69U
 tCVjZK62WF2RGjQOjiAGk3m2Q2Ngnswyo81u20uBcfjF9KBdICiyrjVr39alfR6t/oU6sYLqBOX
 7hpI26OjwRKnf4zXOQOV44HICP4IwGc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

Allow an eMMC hardware partition node to describe an NVMEM layout so the
partition can be exposed as an NVMEM provider. This lets a partition
(e.g. an eMMC boot partition) store device-specific information such as a
WiFi MAC address or a Bluetooth BD address and reference it through NVMEM
cells.

Accept "fixed-layout" as the partition node compatible, in addition to
"fixed-partitions", so the layout can be described directly on the
partition node.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..0422894508478c8d0ca68292b58a5fdbee218358 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
@@ -38,7 +38,9 @@ patternProperties:
     properties:
       compatible:
         contains:
-          const: fixed-partitions
+          enum:
+            - fixed-partitions
+            - fixed-layout
 
 required:
   - compatible
@@ -86,6 +88,25 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                compatible = "fixed-layout";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                mac-addr@4400 {
+                    compatible = "mac-base";
+                    reg = <0x4400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+
+                bd-addr@5400 {
+                    compatible = "mac-base";
+                    reg = <0x5400 0x6>;
+                    #nvmem-cell-cells = <1>;
+                };
+            };
         };
     };
 

-- 
2.34.1


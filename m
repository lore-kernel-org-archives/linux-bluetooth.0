Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B753E7BB0
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991599; cv=none; b=XhgzZfrl580W3XBrWwc5cgbpQDG5prd7kp+B6b8gNXlyoo+PDFd8h3mTnLKXsHKt5RG9hNrB8srElmi4GEdDeQzr6zmc5Mo3nRSogtOMD9kI2N1sWJyyJ09EfI7UE7lTpbtbEdk0mXp6yNyWZ5vl3pPluMk2RjFNSbsTm+6AgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991599; c=relaxed/simple;
	bh=X0Ai0achBf+ZwxyXQCLBkT4mksbIzc1fznSydl00GqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fAK2VCECVAy+QRyHqYgESSZUmKW2zs/sAw7/zzIpwWTFja6nVDG7lnUmT8J5s5U18GrFeKhe+/oEcMkrehJbIw0VdpMpDuqEdOWT782piSXCXR6ZJ0gsE39rY8J2cMOyZmHxSgy/l+wvTNWWWtgtVPiAwRe9P2pk3fV0hAtIGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SqtE24s7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ty8fvoxX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqtE24s7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ty8fvoxX"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597jDBY1566757
	for <linux-bluetooth@vger.kernel.org>; Tue, 9 Jun 2026 07:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=; b=SqtE24s7100dyZVA
	kTClwnOzW+aY/y+IrQvA5ZuVMmk1ZOt1sngQs7WnSevZ3aqCRg5Cihoa/loxIg+u
	t3Ru/iPPVx61+14JjwffwlWZ+cKt5bOzhddi9aByGOfrSA0sc0Ie9aB3VDpvhKaF
	AiDEm4eplPJ+c0qRUnpRGz7DnmIl7lhYgv1Z7+QcMGgR0aJIlUINw7yrp+76RSlN
	4zeRYaz0U+6sWsAMDijaGiT5YVm8P30VNOGvyfJN6I+uHpugUFRyJSsROI6vKP6h
	qWd4kKHfEXmpsaq18yY1I0kyTytX5hjNTIlTvzqqQhk/0DASXo4/pgwokj0YDOKn
	7WZBDQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgg14v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 07:53:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5175a1e32e3so147106881cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991596; x=1781596396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=Ty8fvoxX3z9+aGVH7nrS5wdzT/sN4UXtzTsyATMGtOik0OSqGOAJibNhzJwWtdqUWK
         HL1FHKzInEaiIJzbjLJICVCb2x9BiPUmINBFHma/p+XfbLH54XUbC5sJP7K3FJxafVNq
         VNA7jU7jsxRcyiKAeuSVCwuBWcU5ONC+fuGN62nf67r4XHhjkXQ4Ty64K97X0Tjraic9
         NGTNjfnaAhTwAw2bbbD5Ph0e7H1VvEHkDKiTen6IXXP8GHekK3XbVX7m3qK1VMfLBPXq
         YKuvIsBq96gHmC2hqDxym83+E8A1qJ3MvyYE0w5kOVj0BleecEszd5XsN624lmJTbSQ+
         YZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991596; x=1781596396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=sl0H/fdYHo566c4KSa9XmkZOyudaufuUYFZ5anTE/HQc5ke+nFII3jEoWFggPL6jhB
         dJ0mL7t7QzOcGlDwe+hJhspMJxAHG3ydk0NIK6MoYBCJN3XsEGKcY608w3w8PcuzQDRw
         1g6I/SMbIgqC6Irim/XZfexfgiX1pxB3PMpJF6p0Sxas+tgVtbGhYE3KkbXH1qor5U4P
         Ls0oa4W5S6mbtGa4xRF0cHVWoZTsANRQU9YWfoycfP9cOZv98cuYD5X2JOr6DxXsbhAG
         LK5lKyr/1Jvf1DQTH8Nnn8McQArbS9bDKKsTeqGz5Vivkd64YoHamWX+CsImWDaAVSM0
         IiAw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ia2pOixmRnlD1dcB9wgrSyXcqmw6IXkHQdTtmkowt00AjERxk8zKDc2So1aCC98VVV4OIbiTY+3Fpj6/zd5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNHrQnmt01UH34wD3sL6+DvwRdaCRc5YkruA1r9Ym3uZ8Hx08
	kAhqFbB7joeOsCUbCqpmPI+78FmPqhXjorRUp7bzXTDkWiBHpu5kSs/hY3gRoIeZGKgfcmPHXeL
	1EtTNmrgU+HJnUgzFYZbDdLKbZcOtjS+dpASNzqvp9AUmxJf/gwJqOZCA+ZMMlQlLky5j0AI=
X-Gm-Gg: Acq92OGh+1TI8lbaPGuzowWwuJx3jGFRQcUsDh/ZkK5z8zx2P8Xp+u4D/cuoSWy/GVu
	w5rQyH6p95idGu3MKAUuURSIscu6ep5eQZIJ+g1J15k6z0Obje7D/IevS7GmwhT9hrrHT3zgiu+
	rjzTEEUr+az+7M13/Y4wKn7OxzaY7qmFTgGMR9wwY1OfK9Mb8cqsI9DTDLEndRNNFKgXP+2xpgn
	PQN7ujQIE741bZD1Fa4hpJLl6AdwnSrdoFgisZQCXQlNbqT9ZtXnq8hnr1QX/GJmaIw03wRxpq/
	cpt/Q4SSf8MdlskB9CQlOx91JFfwu2AyINGwVrwefix0B1ZQ+PYMdg+MwNFRQ7IiX3t7NTkEIYO
	Ya7fe47JA9Xh2/sn05C5kUkIapcIV9nWLP93AIt6YMVQY+aDwub1V62LVrTRQBdLYlBYvjq6Dts
	66CQfsFsAOkf6QnugTLPxphepL0zg2WFDfb7P/jAWhaOOkDxHcYXiRkJjxO3FSNo/nMHj1frKkC
	yZpgvP27nCN
X-Received: by 2002:ac8:5852:0:b0:517:599d:ce19 with SMTP id d75a77b69052e-51795cb7901mr276093791cf.48.1780991596119;
        Tue, 09 Jun 2026 00:53:16 -0700 (PDT)
X-Received: by 2002:ac8:5852:0:b0:517:599d:ce19 with SMTP id d75a77b69052e-51795cb7901mr276093471cf.48.1780991595695;
        Tue, 09 Jun 2026 00:53:15 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:14 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:26 +0200
Subject: [PATCH v4 1/8] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-1-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
In-Reply-To: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NCBTYWx0ZWRfX64hEZYKrWKNm
 JDHwY8jQ+ZXzktQI0C5ECYBxKM6pUAAepB6HTLbSLipAq0Rjp7ASnfliRjDOKL/yGDzisAg2A9z
 zaQmOwU4CQdQjqfQsQkqWlO2rkfAXn1Mbjf4sBdWMw/6HTJDHLk5OvymE/orVt9HpYWwptusFK1
 So64fZejfzFsQ1DuparAEaQ/YJBmt4CYLk3WsvrxzA93z4G2MAKkuplAQgwkXJd25zJN2xRArWn
 1xTk9FJghXLAvWqR8dfNdCsQlnftd1qmwZQu0wC0+JjwDEpx4KRhziPIA6Ng3jmHaM9L7xMOdrX
 8kv1ANOatM167j+5dgKi7r77G9TkiwoDMT0+zlY/hP7dSotLL0mK7XGEJ/oMK9WngBM8N0T4TW2
 R1ITiMFJK0aH3bqNtRENHzUcB0mCZCRbCP4PBUplD2sO3FVQKazDvKE75NaxRcXZp3QF+AQJtVg
 1hjIbxeoVX0482OHmug==
X-Proofpoint-ORIG-GUID: klYfiy51N59K6FntkV7e41EXqhzJRXTj
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a27c66d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9i5gzfhGLSn5NVSMExYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: klYfiy51N59K6FntkV7e41EXqhzJRXTj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090074

Add support for an nvmem-layout subnode under an eMMC hardware
partition. This allows the partition to be exposed as an NVMEM
provider and its internal layout to be described. For example,
an eMMC boot partition can be used to store device-specific
information such as a WiFi MAC address.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-card.yaml          | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..ca907ad73095925b234b119948f94ae81e698c86 100644
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
@@ -86,6 +89,32 @@ examples:
                     read-only;
                 };
             };
+
+            partitions-boot2 {
+                compatible = "fixed-partitions";
+
+                #address-cells = <1>;
+                #size-cells = <1>;
+
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


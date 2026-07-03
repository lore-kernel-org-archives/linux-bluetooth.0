Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE23D9DB1
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086325; cv=none; b=EBnR5awpOasXFIhLxPjtUuCINv//GtIKWEoz1Ac6wAnnCHTQfczWAQFSLzftDhTHSgiztkvtaOVOee0l31BOgv2Ac8+K1mcCm8QVAqiymB6l5fzvh65ZmaHnOGcVQZ5IqbEtxq59lS3iXGwpFbf3MOw9VVQjYMj/4nXTP8r7xfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086325; c=relaxed/simple;
	bh=g/kZEO26OX4smC+wgpc8bkbcZi84SL0SycYp6R1V6Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HEKiJvgWq1KUGj8xvpDaJSs+17lzuVw5AFNsIpuRnvODmoU7q7PjuQ9q+6CqTts4i/bCfwrdCIruLgCWBxAS7GwWGlqPQ098M23aeY0uaOvWki25Wahq42j8nr6zeBhgFP0yFaH/x72KvmGtqX7UGuSvlwQv9XW4fFS1XhhNYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hQrtxPOD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TOKtYeMr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hQrtxPOD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TOKtYeMr"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663D1Bpp053996
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Jul 2026 13:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=; b=hQrtxPODMLsXzsMY
	Ky5XzFZLaa3/GdOLddqzgIsN/xncfImwxbfBYVyirfLaRanQ7XhsJPPXlbI+INlN
	tIDpj0PFEJTAwEnsgD8ry+vvE1MsWu/JQlvFKtOOFdjREWPhWKp6uc7ZrS9utKIS
	7fn7sgSTRM2nIzTbg7YN29v8K+NEHXAR5FoZL9HUF6CJeU09thBjQ0lONiFfmqJz
	blcbppHE9CUzXBTG9v9d/fCpNnbQIjj2NYW2W96h3qHVRRi9xqb2BixqfPpbHKy1
	SL4hS6mK1tnDjr6FwfQV1/cUBhOQScj8Ym1n8gI5fDPIbpCo4QQQCvpgIOZX3CTD
	3jcTJg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkg4mp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 13:45:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92d1cae5939so64695985a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086322; x=1783691122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=TOKtYeMr5Ig6yhlGAE8TelGEDNL/Q+zYAbzjVFVhO2h7zIiG81Wvkd5psLgjklAOKa
         yYA14KtUGQ9r36jFOfdlDulaMh472LHcfqzmyGfMox2KA2n/SLiRSerg4g9BiY5pyZ4g
         KdAHXJTeO7Zb5t0L8+rP7PbhYSysjLxcqvQJMENNi1dGyKdJRHxC5i3M20P9W1ywRcne
         qR/RF11HTRIynDKfUAgTcaqRPYUWacfzzSK/vYJI8VVW7em9GYjVkxfnQUiFNa5WZQAN
         53LhvZUm9okUpaGMukm3vBqylpNyfX3MT5/DuO9lxXVbVZFY8S0LV+jzzBbp/yUYX7p2
         beIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086322; x=1783691122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1aaxhulcUS260xJYhdZ1yKDQBOfTkI9rxmodcghc7/I=;
        b=l8OFUaZZtdxrPMZAJWev1OHfvD9lR2/Wf74gdUXRZbszFSXI8D0ZU5CFwJ/O4wm4XG
         ifh7GjLoU4kahHilz8IKmsj3KPMkSWBzSuioWTVza8pNE/y9tNdF/hffoVjW7FTYNIst
         +mhThgQxPctWtgmoybQB9+lOOfzwwFo0Oukr+SQy4ZB3Do/JW9oNC6PNcXKnkV/y4MCp
         ZyyzIpKfP5kBlC/rTQ6jxGPU22vJcR/FvQQmblXsmreK08GDnmQOlLtbQKTRqhWDy2GX
         93XE2yOotLft97jlVpymg+kLWHqiVxOn9mJK5Am+xwl0ry/QzPtpZJ4/+bDh57gR2vJg
         ndwg==
X-Forwarded-Encrypted: i=1; AFNElJ+U/1IbCkV64cVSFOyIvemAYXIcWdgotUksG+cfbAMFNIEdUETrgUWXCSyi30s1q2xKyNHjJXNosO3nOrZx7vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjV7WOGVgApsDqgty9KlwsXUnmgO3UFjMHZy92pe/P6482ZKeY
	JIevzhcIg+PEbgG0K1O1NrmqFK8nJBxJz+nToN9NNhjfl4k7NZuhLSSxGdn2eo8PiRLPomDuk1S
	oOI4rad459ugFOWJrPwwD7d15tXZhmBywihzNrmOOCZgdS/UdNAuTP8f8vsZgOYUQzOw06X0=
X-Gm-Gg: AfdE7cnZrxDzMDKbLCCENokLgV45T4QXhPoW1trI1fRZ+6Y7Mpt2f89Ggik+5GJ1r1S
	XSQtdhh26ozESL70lB2ZoQXdvO6POFW1/J5fvGDwkoEfZuGAyXgUHLPOvzV22CNo6eUtpbb0+gZ
	WJLb8bPtGNWNIxy5ikLN/oO9wtkwmvqqOxnCvkamKlCjy+C9bzyhLXeMPR/Da01AMNxlihIUwS9
	FMESVuPZhTVxOuRk5ixcq6/K+gWssV+fw6iTDINILpFpkRyvZ1hbb9p0AW/XvIHVNseZGuIKYy+
	Xsy6iFt51See0WsIhzEVarGGXxgZ9VJJJlsDJTHVc60Aafh80F559Tu1JKQ8WhdYRG6WnwLdTr9
	3wPzDgcamEJWATWwRGGSucWQsncn0Cn+dCdnxEQGiLqkuiFcFaZxWMGb5VLksmGC9PhQUjW3J73
	oNHBafM7zE7ziFufQLUlNeI2uvl/Gm7rEOCmutQ1Q6eEE8g4GX9uovXLmlJqv9mQw=
X-Received: by 2002:a05:620a:370c:b0:92a:c203:471e with SMTP id af79cd13be357-92e781dd674mr1486707285a.9.1783086321457;
        Fri, 03 Jul 2026 06:45:21 -0700 (PDT)
X-Received: by 2002:a05:620a:370c:b0:92a:c203:471e with SMTP id af79cd13be357-92e781dd674mr1486692485a.9.1783086320737;
        Fri, 03 Jul 2026 06:45:20 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:19 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:14 +0200
Subject: [PATCH v8 1/9] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-1-98ae32bfc49a@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX2xoOX2CZWcCC
 d5M+hVBPfBTcnYzvWG/JY8m6gItOywNGBEUdyj7T7IkW/m+QmypFBR85VilrDjUtBpj4Z6teNxc
 PB9zj0znW41gAJI5DjnyXsrunZvZjhgqHbNQi3EsmjHePGlK1do3bIZhh90Hzmk6tWBxBWTSszi
 LcUOVsUxiAGARftB3gP6os9LxDn/TekXx2Q19qxQ3kyi535fv1j+VCqr+zGrI/QfP/PLV11rj6Y
 szalWn6cmBb1LesubYZMA/XeaQ3Vsdohb7800G18u24+5YNR0p0VHgdz/od+DTsNhNPSNBTUTQ4
 FKnhMTMRgyjbxMeidw4CvM4MkpGSwAxHyAScBECwT3gu8relyPkIWW4FCxCd/ZlWp3YGorZvHti
 HmeCmdY2xqrBat9DOxmLsjs8JtHbAA6f4eqkSMlSNbwr60yqHm836GgE2supI7x6ajP/3aYdbKL
 mHsz0z10ttO27Fz8Izw==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a47bcf2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: d-MuTtZJ9NeaPw7Nz1JQUGcAwpCg1Nhv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX4QFt+S4xDEdB
 IBSeSypZykKwl2MVeIokG9z9ONzzlZtM359PGYP2wppT+BsVSVCnXy4/RI5S5PM50GUcfd2MSiK
 P81QFuKPuF96WseSVLQ4gF3uPJ0lXSo=
X-Proofpoint-GUID: d-MuTtZJ9NeaPw7Nz1JQUGcAwpCg1Nhv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

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


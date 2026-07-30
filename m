Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D584446E9
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427248; cv=none; b=O90cCeMnbqsR/9fPgxShZeSdKH9w9kIL8xco6pSQdZ+WeQrygfVwYBQ0F5HRWvPNJGNsLelJFBqLMvHMCVUlsErQBjbVqXsYq1RomGpgdZGmC+vzDNI/ImORL6+1MahAB0chFsrSIe08jyj0Z/vS4rFDHOtO4W5PXoSDY+Rw8zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427248; c=relaxed/simple;
	bh=k3X2tgRd1gwg/uwGuGSAVWLEEcjC1WSvGA4Lio2zQzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOoDTciGHNUky9Vk3tFE4eljCFnlDAHaJQ+qqUEIPBMUgWhwss9EBPY6waJposy87UE89BFcLAGWRUmIDIIQ8hQ41c54S8PtRqna7Xr89uahmfv03WvD+sEG0PSa33ZYNKMrdUO7HgCxsml9LIhXgACR5VgG/ePu7TLKVqmq75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aQ/naMfJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EwzjeMq6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aQ/naMfJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EwzjeMq6"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQrZj1475048
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hE5vnyYn1cQDkxfnxwPBASs1NDxIF0ypO5EEm3REHf4=; b=aQ/naMfJL/eXOSkY
	sW4u1BsAtcWL4xBVIXWzOT4Y5OjCS+pcvEQoAayCe4obG9b+yJDKdV8HcIuPeyL8
	g0moUS6y0529FrLk4p2d7OYpHyAT6CZiRoNJHQL/odMCeNjb8kZu1MEXEANETa3W
	QXJc98GHfx6AL/F/8cOsjtJQUD32au1niPzUo2HT3GUsr8EOYJS9dlEgIm4MRfwb
	e8O33IUym52qZ48RHx4dBRj4mlVCQz/LzhYUTN1LD4+4B+ryFTwzPZF6wRHv4HVW
	qhcHL7Sh7mlakv7rTdEbKii9Es5IPyOvUTZLgYG0rWm08ZPiMUJv6hk+AbWNOH9q
	OQkJKA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr7q3gqb9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:00:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d30035dso19400691cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427244; x=1786032044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hE5vnyYn1cQDkxfnxwPBASs1NDxIF0ypO5EEm3REHf4=;
        b=EwzjeMq6cmUUmGqh9bhdgdUu00wcQNKosBwFYuhNLr06CDJYFSI2OFeMsnYeDUVSsy
         NZOpxhHKYC1N5xdi87X+6Z1vey6yB5s0/k4kfkzOq4S8xtfYHMOBRIbMcU+YbcMQrpaS
         +vC5NWJHvxBLcvCe4uJvfjMP7rW+y/3fxt4L0oj7U+UFU8L5AX01vqCeZgfXxik6mejq
         uazsEa6x1G0bDojk5SIlZDpANfC0/EbE/mY4x/DzsGvMOUm8GMfbAord/0jP9N3huIhE
         0YjiStfw5KoHlnvWqQIX2XMi3SqQhdHVY3sRBVWtGAHt8VVjocSRw0kweUWS7ngc2ykX
         emng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427244; x=1786032044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hE5vnyYn1cQDkxfnxwPBASs1NDxIF0ypO5EEm3REHf4=;
        b=LOyPGWZ+TZoJppw3QgBcAgRd5XdiskRlzF/oKf1ThBIXhWUyRPVmofb90tv2kSgP1X
         FQ7EmjfktVkoZmquonSlW19UgUjasE5lXUHGakli5hVc5UOUaROiYIBtM+/s/kgTmV61
         +vsZ3VeNmTYUy1jzN/T9geanv27oZ04lwtGOeUdVK4q2bLIFRWUyUMyDknOcFszUZ8D2
         b+wSHBgRVOOBHGoV389bPkf0spaoz9Uuuqcn5Xa05lW4I4xMGtI2lVxetnhXYiU9Lzcd
         rTHPhc1WDUQUpL2tT4A5e20JvuNfpVkXdfWplHwj1lOmqz8ad9B6xi2ZWq0yVIqSQemC
         Dn2g==
X-Forwarded-Encrypted: i=1; AHgh+Rpe55dNeEE0F6GhXICTcw6r6EEyj9do7GctnwtgwPZPHyX91kRlUj7+KG+oU0l/vUwQuexnMQdFJD4j55joVu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLYSzt0PXVjSc8h9dIhsBTpul+QEfCRLWwYSmpK6JP7A9CqeCK
	VXuQG6UXPeNcGP4QfhKMB/TfGS+6Yy+iyTfXM7fsbH5yoQVnLVh/q1V7sYH9IxOgW/MFHwe4JRo
	EWL6soqRR+qjxJ/9iMfmJM7l7XU5S6eoLnC5j80OFXcxq4ewIGo9hr7U+luDFC3GLQKiRLKg=
X-Gm-Gg: AR+sD114pgUm00URl0OXVURQth5zxEwudzu0K4X1LvxZQVrCayNQYYyosEVRX8puYGn
	L1ivNv7zzaxnVAGewjejfejDvTtJW128SLPWo44unD2YA7SAwIp3s+r7kh3NO3aHt/wogHWBwc+
	SoRqqLftFW2fWg3ZhCH1JYqRrDd7VsBdUGJPVI818mgLU7yncjQBsKtT7MgU7GwnbEfpNkOaq6F
	uQJYMsd+55J/IQKYF1XfEyb5JNIGFvR2WvduSwn3YcgkqzkhFIAy7j8t8EEt1HfoJeHNQFEHNR3
	x6oTPIGXeTWIhYFSlIWtccUw86qY0Z5sHvnlB67uxBrixr6fm9uZ0eecZSK8pldZ5BvHOBvBRhX
	2AvN8Outrw6goqSUvEriNKjWVODEh+q+PTUgK+7E3kguiyVJnu92ab4LAvmkO8r9wLt6glQT0Mr
	O+B0aim7ueZELVf7t5tsnfqpMFUIJobS1XTGht4B70dt8S39TgCDBY
X-Received: by 2002:a05:622a:58c5:b0:519:efea:cf41 with SMTP id d75a77b69052e-52b384abc72mr32749601cf.28.1785427243112;
        Thu, 30 Jul 2026 09:00:43 -0700 (PDT)
X-Received: by 2002:a05:622a:58c5:b0:519:efea:cf41 with SMTP id d75a77b69052e-52b384abc72mr32741231cf.28.1785427237652;
        Thu, 30 Jul 2026 09:00:37 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:36 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:31 +0200
Subject: [PATCH v9 01/10] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-1-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX/zyLadbx4h/O
 h8ygJ0gC4cA6msSPtg2V0TqG1LkGEL40b0a0tBB61p4N8drYdazce8rWN9LiC4flEZdAzeFsGf9
 T//+Lo2iFb0HMWD5tHx5yAwnbWfjKCDEdZKEnoh1rWE39su0gKL1Fb9w/aTfGE0zZfJcbV1OF+H
 YI4SeLoZ9fnA5AbSSrl1Es3jcrbt63Wbv0ab94VEA2+GgQuDlu1HU/iBYoBPUoKVQBu1VK8FbB+
 hM5dIuIRZyYudLBGf6CrfKYKHAu3HaQIkW2LcSrI2BJCwWNIePAbaiP//Hikl+uYnEn0JWggmYD
 lZR5s+yzvEyozW58wMK5qcNKb5WCFk1b/fA7Rp8V+VQ9W7OZ9OQsKK2UU7mppqI0BtM8NvJgBI1
 mnUS8wYOYPL80jJDXAjp5tvIY8Wv3qaOJZuPigIqIoDVV4DQCOHwl1A4BxGqRRBqz7i2Y626scz
 ABcwYIDqT2nHyNI20qg==
X-Proofpoint-GUID: 1XChNlUPfx8SFLpbDs0_8KjuLn17ktYV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX5AAvNeKBbosv
 QdV08w/s8qeN40r+bPhIjnApIMD4i6LykUoVS8QbwFCgJlJDJVXN9FO52L5hxdky3ybp183JNsO
 emY0DSNG/fBbmwbMNnGzNrIkP8aAqeA=
X-Proofpoint-ORIG-GUID: 1XChNlUPfx8SFLpbDs0_8KjuLn17ktYV
X-Authority-Analysis: v=2.4 cv=WuQb99fv c=1 sm=1 tr=0 ts=6a6b752d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

Allow an eMMC hardware partition node to describe an NVMEM layout so the
partition can be exposed as an NVMEM provider. This lets a partition
(e.g. an eMMC boot partition) store device-specific information such as a
WiFi MAC address or a Bluetooth BD address and reference it through NVMEM
cells.

Accept "fixed-layout" as the partition node compatible, in addition to
"fixed-partitions", so the layout can be described directly on the
partition node.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


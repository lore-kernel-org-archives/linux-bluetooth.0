Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBE33F926F
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723333; cv=none; b=NK32+MddctRv0jJbwm/Y0YCivk0ebrScRBUTTFre75EQOWzWWHdPjxpGgTPfELYMOFYpJ/AyYC6YS6mk2sA4z2O6jWJiagIEIeJWg9cST/ijkzDWqYkHD0Owh9bXI8FwtVjfeXFtH0x64jGt8NwG6qkN5CuGavWTsEOi8HA7VTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723333; c=relaxed/simple;
	bh=X0Ai0achBf+ZwxyXQCLBkT4mksbIzc1fznSydl00GqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wb3044WzkEXml30NL/4MqeyyfLoG6CUrW9ETPpa6tHCQ2NuMqCsLsMxyHxhXGKZNOyHmlSAEhrReAb5N2z3B/2G6Kfj/2Y53HPotjYbJ8EprMaHQRtvEoby+UvNQ/si1j4IrNmy0lGbc/T6nc7Mn+jv9MuYmzBcFIKhIY3ByS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BrG4Ljmj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HpNdqjNL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BrG4Ljmj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HpNdqjNL"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rGBU2134622
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=; b=BrG4LjmjGlraKZJg
	7YKOa0KPU+pIo/CUftVNyjvA96wuJtSToedDs5k0ML4/LgiRf5bzfPoIbWoG+ttL
	tKPkDMJxtZkpphNjlpCtYZ+aBtw0f0cbysEv5RTaOAEnmEd8USGoF+cwHwuu7yT1
	W4cCy0PIl6XRB+8XT7U7HMV8HAq4A8DoQb1G1msThkkDHOuLY32DGXbhX+w4o80w
	KTOGCZCHr6KcbK3i2NdQDSpcdblbUaAgu7g1DImozCazwvJ7LXeKhLi8vWpMyMHq
	S6f0XFSK9TdHYUCEH2K3h6SSwE3fvyyCcfz533343tjR052P1NxwkiGXASXSWpjv
	HGpZGg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f270a5mn7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:55:31 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-969289fca9dso671270241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723330; x=1783328130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=HpNdqjNLTTSixap7i45I7gMoPy1jFNr74jBZp/Q88EMcbR18fqrselDfHoX7UMkAM4
         1yhTZHqOa1y7mY4mD7PlSxgAKcy2KOaUGp7132GIz3dAbHQgGmwXmyEC26vHOS4B64ce
         K8MIOScj6gHZuAkuudivEapkJvLONgaUi9VJDBZXvJDt0fcH5iXeADn1A0DkPWjSQWSw
         r0QCAJylTbxKQokQ3leVFC8gVCWNx//jFTBN335+c8nbsPLRXcV9ilgp66un4i2fFPe6
         eXUTwdy90yZxoddlKT2x8cG4xTPhP1aCNFT8OQ4a66/TcrYBdNWyHrLF7gziKA4ZX6Zd
         XESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723330; x=1783328130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/uyx06x8K5ep74cMiQuw/AWSjV6qe5TglOy6xBBnhww=;
        b=AsnaIf8ly7THmcjulk49rvwq2CQ5MH+j72N4X57KAsqjXo4I2r+7f/2nh8KOE5Lxxa
         vKfkSKTsX912r7/cKywWDjjp+osyXKLnATtRPZmUYjHBrgQd8tom7h8Ov/yBrZvcd5Jl
         /vWcvx+cGJ9edUD1YiikABl485nfVkmHVCLBkgfkFcJEEkWksttyqKhzy/OA4lzjk9s8
         4Z1Ek3xH44ZDf6/i6+tPA2tTJJO937Yecl+0YvZkKJZxuZyrxBAM6475yvynWZHJ0DiK
         xk7J5/fXw8WOqlT3ldEoYo4BAND3qIdwP5EW58BxEgfZXI1gByjczKyPSkiPgumQj2Qh
         TQLQ==
X-Forwarded-Encrypted: i=1; AHgh+RrkdHO1X+QEUyZ5zXwNcD4IBFQwnirZH6QLDRmgckmVC6Rdi8FwR/w82Z7vnxHB2pIzj3ZooY1vaS50Hv8FZQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSzLIb9utEJXmZpYFllVqy/805UBN0Vmwo6mycb6aOp7YfyeJf
	BqKk/EdOshP3zbP8RVmr/suUb4NvIHO0gZk03iR1AiJuIvNeliajgdB87RaqUJ7zpgKHLsxcF+Y
	qmubdIp7t5byynhXOon6RdZ/em5OTu6E/947d7b8b6Yi5nEoL4sLXxPd6Lo89iKqJUOVBFkE=
X-Gm-Gg: AfdE7cm0m9xVpNevcR9fdZBzuqnYGDgWkvHaHwR3sHGeFUPiEabRDvyM9t/y2f8EZzF
	XJbjcEzQL9qpKwvomyOxxrY/3WiT7xzrggDxFkvEBI89cxRrRk+uBRoBO8ZBaSrPBmoyAmycAW6
	GlRZZqOt53N90/2iSmg4PFFg8Q54fa7eW+VJXB1bcNVi5zsa8Jh3gQsb0y7y5yGR+WaqT/uKpcy
	ligX81cmf65R3SK2eOqiJXoHCMM/UcAkTNh5ISa4QODCXYAthAZo8cTQd0qU9o6lom6x7j9LzRM
	WrQMxXhm7CZlC1d2Ks77LuC0+EONf0rQS+uWerSqwGaY39sv5vBGtgRoEzQiR9b5VjzcdO8XcLo
	E9CWaeK5VCrUcfPY8O3wMMAimNFnuuVIOLU1Rz/gNLuUxKRu0MQpbLy5GcrHy4cNo56yC9M3oXs
	c/O0KO84AK4whIXO/319+w2KdUnxAtYzhUUJthxEPAGK0JeE0iE7aTav/uhlhjXxbbazssFKuVt
	lBMdyNYExEJ6r/KrRSV
X-Received: by 2002:a05:6122:d09:b0:5bd:a7e6:10d0 with SMTP id 71dfb90a1353d-5bda7e616b7mr934625e0c.2.1782723330399;
        Mon, 29 Jun 2026 01:55:30 -0700 (PDT)
X-Received: by 2002:a05:6122:d09:b0:5bd:a7e6:10d0 with SMTP id 71dfb90a1353d-5bda7e616b7mr934595e0c.2.1782723329904;
        Mon, 29 Jun 2026 01:55:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:21 +0200
Subject: [PATCH v6 2/9] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-2-f02513dcd46d@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX8LopwNk23kZ0
 IyvMxachyLYSKvQ86FslMCu+K5/WGFkGokgbGLjg7VfGFeRbA0fa0a/4B6qw3KDXSXqXIdeX31a
 X4YCjloOLN58S3nAuXltQAvp0HtQG0juqeNDcpYmaMWZE5F1szaXypYmvCMDyY8SKkVSIYhHbR1
 xWfSNC8SMZgYSxtBQjAl7KZkgoArTpyCS07zfjtFj9QlT/xC8qNF16vUJshTKpKzFkfSgq5w/wW
 79j4AZFMLtURtxZaBrVaOS71yxyJRdMP4t60p9BQA+SIGMdI38ZlKSKlbXJXLZZNUmKu6NjubWn
 M62Qzh4ns8g6+bH2pkZDoC7fgOwC0k8lVbs/4YYc2IhxTreWSibjsQscfMXdo+1F0OhdIEGPOjG
 wLObOvGg1tMnkN7ZfCOkBTD/PTioClwl6TV22o8BDjxJNZziTlqqUpydiX8yl4t8MdZMO8nayBW
 iEjGdnwqCFH1b3G++GA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX5OUytI/YxmkB
 2svP0/vqjMjeaFSBrdPZ5qUJ2HoMz7zahK9V0TopaNbrQ7jkxHiKDMixiSReRkW0/F5voEKRGXg
 n1OWMSlnfzffFShNcpS6wfXngsRCYps=
X-Proofpoint-GUID: sktqqv2QaqMtqtr5MRNcz_z4ySEJoNsm
X-Proofpoint-ORIG-GUID: sktqqv2QaqMtqtr5MRNcz_z4ySEJoNsm
X-Authority-Analysis: v=2.4 cv=Fe4HAp+6 c=1 sm=1 tr=0 ts=6a423303 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9i5gzfhGLSn5NVSMExYA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071

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


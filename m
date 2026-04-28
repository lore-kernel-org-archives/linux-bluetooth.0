Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E043E49B
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386197; cv=none; b=LglswpHn3iauJhWeObzabmuBLnFEd7QO9wG6HSzJYXo5B5mzurBjuocSAeQ/6MfPFpRxNQ26H1O/jo/CSjapdrnkePooOtyiUz3T1/zXvPNqnbzjg9Q7gLajNMFs2CdgqhaCCO7QN3xmr/bodGvQOglzKIH1yqLHfJR5zCCrirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386197; c=relaxed/simple;
	bh=HbSuGEQLc59Sraj4LOcdwW5GSnwxN+lPZ5bkvzKitxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RnxMqDEHNQnZuFJi25PTk+4uwZuET6lRFIBKzVdpiNDDXJwWUXHD2IkBQGz9AORtQy0a+0MUDV8dgeEiyhf78HMleHtaRzvlBVFC2PF6/dI5En+KoXiVCiraTSH5I8aRiU/7nzOVVGd2Shnrfd350aZNM+WJw4okCQlvej1LsBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b9/Glt7C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j5Hay+V+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b9/Glt7C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j5Hay+V+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S9uiMD1329554
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2wf6P+dIy3swdOfFQ6eaG3P+EchYwJG+lt6mzyhgaNE=; b=b9/Glt7CpnTksk6T
	JGcQezNXo9AYJwE+b5mnK5BrfZG7lJBvUp/8nVtf1RGaGlCsbmGdR6JreCi0WCxo
	vRt4PILMYInu1zP/3mtX5lO2ousrHul6pzCPMiO2njRYYFUP6dJn1wUKUOQrr3+5
	aq0lEqW0hhN5k2tjlcmBkLPJmVJfQeXMN7EM8uz9+Eyl8pqV56LPqmHFPoOvYv5S
	tJRwF0UNC0phdM+4Cu8Nrt2EfD9lFLmLCXQ4ktIgZycxL0RlP/tn0jMjhE4JZlUS
	uVhHNa94P9G+ICy1K6vWHqD7qZnCOd7Oeowdi2oUXSXwybgLW9mQ0ueNBUHeZrN9
	aSE4fg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtnhaja0c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:14 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56ee7e84f9eso7830081e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386194; x=1777990994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wf6P+dIy3swdOfFQ6eaG3P+EchYwJG+lt6mzyhgaNE=;
        b=j5Hay+V+FWUXzNPx2hzopkIBH0Pq/ZOBmt5gLzbd1+u0jpynOTED2DqNPkXxipHUk0
         L5qoZFQr297oDj4nccyS9/bQ7cgj6HWBlu97+hXsAFkTSlnjqgpO+PKcg+z55Sz3vINz
         VmCSDE4LKxRuiUaHHsqi6li6Sn7arpOtgEbDj3ZAdg2E/NsKTFfRB31/y4rVEURkBE7X
         aG2bVUuWCD9HLKPje900+xH40sOv/CZhwgo/zaWd/oAD3LXpj9hKEHj6ATraAyZgWFkS
         /o7IpvJCNLY/ysl9IISuT5TXt0PD+xiVQfdj7S1W55IDcLflDP4tbZSFRk6mHUZFxTiA
         ONuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386194; x=1777990994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2wf6P+dIy3swdOfFQ6eaG3P+EchYwJG+lt6mzyhgaNE=;
        b=XGQNOd4LJYghw8feDMiBnWAl3GmwvIwfnNdk/269L8UzkJim9fAvNDjUNqvsiM6WcZ
         vEqWazCqOAw0D5njvuGeQbxpfJWbjfGhB5ZnXr+eX3gs0x38gDhvsznOe/3JvcPreRvh
         kktsU1kAmwDcsCQVoUS2xhDsUHFmhJvzyG0L5Gva5bj5UErRNixEdzzoEDzLQQETJsXm
         nNCrNG67oXQfXKxowqeAYyXRdJkAm0Dhrtz54dvj9BkZ6M0SMz8HkYhxo2RIQXY8SnLH
         4BSLkqzcqfquUh4KOK2ncBTgo7Zf9AG5Wl0fjEl6H54QOmz4Ro9OT20yUmc00YES6J8T
         jOYw==
X-Forwarded-Encrypted: i=1; AFNElJ8E2dSXwfotEsri24Gik7hVdW0ggbXsMJKmdxEOj70iPYdGN/32eoOv+sIJvC24DVmRgwIrejQGJax7UVoUx6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8a25X1k8wSFvBPkVykXKCHGcNvodSNbFMe/k2ouS5tWucOxso
	uoSpNi+WeallYVHrEvVbZ4YgKHn+znTg0r/9F9pnemCSA+DxnVHLZS4CHoHoKxtQEeA0f7uVpCm
	Q1CdE9KHZJNg514VKOYF+CnSEOM0rY+/NSpcPOhCN5jUrtPNdkx9L4xGXBjTtlgnomrhPT28=
X-Gm-Gg: AeBDietLbCSUgmHvAF5/nqUgZJdGHsXq6wS1osPuENlHdrafJcsS416RoMsH6bEuSoE
	9taP/y9mRyXdlgzd8Heaqx0Opz9shJrh9kY2sIxix4p8mFn38BeU4Px68huiCAKLpaFXko6MuJw
	is/RYh5vzaWRsUx96qPiVxJN0x36yGFQ+EFXrHJQNWjbnDsdmqBMwjrBCxZ/QS2Rh1XKfWh3iN7
	KNQoB9SFGO8wdPzCZIjdRhv1LnIT2Y0Bunndlpey3yNWFt5xU4KeDKUZrT9TZcQO+kMR/hqBzoo
	mgGZXPvEsxgP6lum/kx1DYsPUVNL3ZL7wy9zfdfdWJfpfrstSAk88MzlZLJ7BCVw1a/iJju2FyJ
	u4LrHwDYLcvwQmXv4uY0FrqfjaLUD6pBn1FEr/S4vJMPHr95PMwRT3QKO36H4sQC23d9W5gGlgd
	IjU+3lXSSV0IP+vV6D3Om2jxlO9u4=
X-Received: by 2002:a05:6122:490b:b0:56f:694e:1f10 with SMTP id 71dfb90a1353d-573a55825a5mr1339752e0c.5.1777386193467;
        Tue, 28 Apr 2026 07:23:13 -0700 (PDT)
X-Received: by 2002:a05:6122:490b:b0:56f:694e:1f10 with SMTP id 71dfb90a1353d-573a55825a5mr1339667e0c.5.1777386192845;
        Tue, 28 Apr 2026 07:23:12 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:12 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:06 +0200
Subject: [PATCH 1/9] dt-bindings: mmc: Document support for nvmem-layout
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-1-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
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
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfXyFLjroDfl84x
 RAgirEQ5rPAw4QGCFViFIG/JKjWGrVPlFeQGQssEYQO52a1/ri2neW+NOTvnaEvQyVQXeKCmHhd
 zgSyiO/ZcxBREQc15IJ8t3MKpvUVMcFUjU8t7mLMBCEQs/PDZFN51sUEwZtbIb9jUSgt5jCtcIo
 kJ2CHfuaGlX76KEqJE+4YG3IdlDm8FPJtKAW0SfnO5oFyo+QlrMTnE/h2iqqR2+5c2NorcIIytm
 oFc1atPLuK6W0ykW8IlbQsIJTyIWGAKPr4mRAPKbVdhyZftCA26JPbAX5KRTGvL2UUgtLtQ4JmT
 tAFfS89rzFlgNyYhZCZOlZgou74op6A+kizSQ+P7LIMh71wPWf4bBIZOeVtSQ78tmL2+3hm7xpR
 QfMO7O9VlY6VoniKN7fbpsWjOJU+XZ18dm9I5UWycW8f0d8g1VPnRpbjzE+g2ZJ2pQ4G+1HEqC/
 2zK8D43JIRmtiFr3T9Q==
X-Authority-Analysis: v=2.4 cv=JoDBas4C c=1 sm=1 tr=0 ts=69f0c2d2 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=hFPe-bIbDLvfECHHD4sA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: qNNMl7dXSWB5pxzwI7xpt8WiK3Y3X2Ww
X-Proofpoint-ORIG-GUID: qNNMl7dXSWB5pxzwI7xpt8WiK3Y3X2Ww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280136

Add support for an nvmem-layout subnode under an eMMC hardware
partition. This allows the partition to be exposed as an NVMEM
provider and its internal layout to be described. For example,
an eMMC boot partition can be used to store device-specific
information such as a WiFi MAC address.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/mmc-card.yaml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
index a61d6c96df759102f9c1fbfd548b026a77921cae..e01fc82ab8520a31196475b18acb5e839e1bf71f 100644
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
@@ -86,6 +89,23 @@ examples:
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
+                        reg = <0x4400 0x6>;
+                    };
+
+                    bd-addr@5400 {
+                        reg = <0x5400 0x6>;
+                    };
+                };
+            };
         };
     };
 

-- 
2.34.1


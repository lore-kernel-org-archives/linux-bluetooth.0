Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A23E5EC3
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086347; cv=none; b=PWS1Zz3NGPtdcxABjKicqgNeGr1KKLbehazsuVBU5DFNjBXAV99oHTZQcmL54P1ufouQA+wthLXw8S+AtOP20udgdEEA2QY9Yy2EZIvK5U8rlYvSGt+mLEPKSYEmToPJsUrtiAVr5lmaaBs6A88nRTqxD8WK65uu5Ryxrmh+enY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086347; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxwnjWbWRcCR0Sbvc5TeqDzDP9X2hDDRfbb8Q5DY6ra+XNt1GwZAwN6Dyl0RSdVo8jAvdljMVdx8nIe0QCuNq0J0Q07Q4z/CqDqIkyGYwiuk7AbkDkgCQHFDecdtvxJx8lnpv5Cy/m8daaHnIhoAHivioyzDnMCXQivcFrhEd30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BjEwQ7KX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H9HW25Mb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BjEwQ7KX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H9HW25Mb"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BPj3Q3108955
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Jul 2026 13:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=BjEwQ7KXV91y6w5K
	VaQIfEuSxIf16eWd1haiwUtC/PYzRYiVxl1j5dXjqMoCiigcwbu0X+8vL/TExdy4
	ZgaYvX3s/VjRfFmnLJ2HAxVpoT2At/uvdsGENm8WOfnOSljYzXiflbVP57mea2FX
	KnQYVBSaRc+RTVmHc1S5LvgQFioMJfP0+CNEuyaeFSePaW2SyzXcOQyNvMVcGtyj
	FwwWkbyB25zHbrgMA13dzHUKe6tPQz9z0YNucycudgyRDEQ2qG4QyzaE1Utrt5uS
	gNyLrQaSn/7xmzjyveth3rLNCkQC+OEimnMLDr3jt7aY1uQdm/4UCnx8933DfJ1O
	dXR6hw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eybaax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 13:45:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e632390d2so104356885a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086342; x=1783691142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=H9HW25Mb5w4bzpnA8/TdBbTr55d47alBBT2NFDv5GxxOqL2sxUtAhKg5p+5RoGS3Lw
         7DKeZz19g28LAcVhJ3zIp9b9gRzYv4E6CadRmZKC7wtrVQrSHnHPIwDXDjvQEzgrBOOK
         up3mgIXCr/nMXbh7FcPswAUY3UBuEmdD/5HI4R+aSpCA9YoOyUBDCTLp4kPpsrRCaRll
         iNF+6YqfXOItXzrOPcW5WGTIZJVDRHE1piQE+ADMH/G1AdUSR6CTNSxUIc07i41wuu8H
         5DRcUraomGGcwCGvVIdfDM2UFAtDCnOzVrU7v9Bh5ltY0ZDCb6S4PURQaNrh/P2W2dBN
         Beow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086342; x=1783691142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=KUUTCK7+lt2Xg5qiZYHfaod6sWuu/srPP7N9ccDGjI4xMglw22BrDQ5oii3msU0fgm
         Lyh6cwsyEsfhxw9fljwrh4FbryJ5xgIDmPsr8TSqSv71eEFN4/YEc205fncFuH/IygAW
         YgWO4heoZnDHV2qg9j5+rgd4iG6jDi3DeqZTfmePh6JJEBdT8zLZJLyNp0YI5gRsXttB
         jtHW/+bH/BsaXz2V72WoPX2aRnTQdy35CVsoxznc/sdLCVW0mFGFB/JE1BNR6ib6csYN
         BkfF7UlWh5pke0UoJRwKVitf8Q6lwok8BiCfU1xWIbxWRqLDQ9MXJiJ5MipmpuwHliPo
         IXmA==
X-Forwarded-Encrypted: i=1; AFNElJ9hLLE8Ev4z17wkKC6N9NlxA85+CoVyJBf+Al/CWKFaey4fRl9o3Ztev93SXG4WksJ3FLTWmkEp4pKOpqdYrzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi9Ex+fHenNDcGWrXKTXT7Pntq6Pqfs2elWXj5bNUMZpnkrN/x
	giO+JL6Z5Rd+t619sUu5x5EgM/fcrA9n+A6Fr9zlOzdg9Kg47xIV9c8bgkjzrsPXOAIa58JUY6B
	D4JEFkX8VpJnU1Z1iQWXHm8RX4ay6isMnq3bBuQD65dYzdvgqYnq+V7XdOl/OuRmJiWI7vxE=
X-Gm-Gg: AfdE7ck4H3zb3hiS0xetdioA9Q1G2MLkRcK8PN8+2OvVlEBvFaakieN7Toa1X0P+mxa
	pqbVIaS9/V6q/52HugoBj5iXKpXJJ6C+f+rOrYKckmD+SadaATZx5hJI2QvmmBivTeB6wS+JgQY
	JutTwILNNq5aVeax5hHcYuO9sLMyX2eePdhTtyYCMCRmiCEENldFbW8qlpOZ3Y6MqgxzCqCDvCG
	o5hqurQfeDNxBcmSukjWjxQW0AK2P3J0Itn16/0hvlWKJQzG390AOB+zlAXnYPySvFi0XFsxar0
	fF1GJ9TiSA1RTUoGOdQbdoaOcS3oAT64k8Dp+iOpo9LFl5XpmPc3vXTuSFH3Fr/9U8efZrS50SN
	QCdSGnhycOX509ExlbPYvSgvAHCV2Bvf218pmiHxxGqO7os+K+sp9NXhZn7adNeBIwy/Hh4zSvb
	lvJvOCf6yJaQPWZy0HqxxL82C0QL22ZMQdJ8BV7yibjkTwJMPipy21jdahLLW0t+E=
X-Received: by 2002:a05:620a:2725:b0:92e:6a8d:38ba with SMTP id af79cd13be357-92e7b3dec02mr1223916385a.56.1783086332563;
        Fri, 03 Jul 2026 06:45:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2725:b0:92e:6a8d:38ba with SMTP id af79cd13be357-92e7b3dec02mr1223818485a.56.1783086327285;
        Fri, 03 Jul 2026 06:45:27 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:16 +0200
Subject: [PATCH v8 3/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-3-98ae32bfc49a@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfXyjB5ZWTT3X9S
 q1I7m0uxdbrGE1PvCed4K0YFvShUcI3g1qrBOhFAPcAshf2kWbkRqO4QBQus9EE0/eem5mhLh+k
 3Rdl47OnVa5fkQ1eZIX45lskGOeYQv+shULX3e0xLOy6bGO7pMll7SYWuDDQE+oEERspW2jN3SK
 sWdOgd7k5yCUxJ4xfz6AYcrIDK1PlqonhkVzH6IJ9+kRMUZIukGrl716c2u7x+FisnZ30fgySso
 XU1cttMN1CGW1vFTjTbmU+r0BXRWQQErjV3gqPHxK8UEiUA04WaGih2gLgAXKqBd8wre/sf1tJj
 hwF9pG86l2QgbJLoHQZ6bg8Pzaib1POXFvnpNjCu8Mb7M8IHDXi0LgVtH8C/lEBmaehQxN2beaH
 7/Y5qbVoZyNf+N2b0L6nxJK782fMW5LFhieW2QiSQX95V11sjd/ipnqCQqmd87YfmNRd7VJmaco
 cxCwiPmEQ81z0hVNhuA==
X-Proofpoint-GUID: WsUVDPu-Z8FsIEt88FLef55qO1ioJb-B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX95etlG1Du8az
 2dihzaFdHtX7zplPBe77SW0xd4jtSetNmzFYe/X0l8V/eyBnh0kVFEnWZH1ohr6YWkEtl4MwARH
 2dNPYUYBvPR91dUqPZ3cDKgMSj/vntA=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47bd06 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: WsUVDPu-Z8FsIEt88FLef55qO1ioJb-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,13 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1


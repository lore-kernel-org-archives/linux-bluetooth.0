Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E34508FD
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386210; cv=none; b=o0p6O+kELSzJ6/CZet4NRjW8LrWA0NHgRtoBFDpaFVJn6czyQKLAF55eLf3qwrHjUfTmVRnCSHPMFNwIlNDUEYNEpp1FI5P8Ukhb37LwInqEusxcx1oM1JuNyyUFL9eExEgziM0svSGsx8g10pFzKHojAEkiV67zIhmVg1eCGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386210; c=relaxed/simple;
	bh=iY/VfJm1uaSOqwTnG+ysQb3Ah4zUvNYZa5ApjLpBAeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ggYViD2A7YdTDsnG4CGq7IGw+wUPUbTKZeD9xvUHYWgethyjkJ/0vxmrG6wBd9wpLlcIVZJCjdtd0dgyADqklsuRL4hI1F/gAZzE58QLb5M0MOdZFx7yAnXAV8Dtm6D8Ge0BxSUT31MCUfylizzuDcXM4WNBdYuvRgUAZyDBhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBY9ODjK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RBAMh3nr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBY9ODjK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RBAMh3nr"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SC86i41624769
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S6j1qnAdZyoQGgOKRaS8VSM6ZBf82wgE0IlMn6k4pLM=; b=pBY9ODjKd57VJ7fQ
	8wU/+JYQXlY52h6b7nn6uMPFeERqAXOixtsF5OYvZ74ld3CJoOYU2kPGd7y7VQ+M
	jJNjX9Trr3O9rvHejYSwkFdrhuAIVUTI3/HKqJE6irsxU/2muTFYon2sJLuQufuB
	xzXXwihPXe4EqPnW/R940HTBX97jdm8/0Gz0up51kSOncR3Lk1BOOq/iR5mY0/PG
	4GWrSof4ZxgaFXS0UGC3ZBKpMKz0NW+ARMW51icCCqtzdqdPJzB1Wn9iRtqzh9mU
	8Flb8meUeZH6O2LQWgvl5uJJ0OXiPrjj4tNzmwJHJlT5Rx8CVCsXv7c8/vTQD3LK
	p+pGsA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtgmsbexy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:26 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56f6c90b142so18108550e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386205; x=1777991005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6j1qnAdZyoQGgOKRaS8VSM6ZBf82wgE0IlMn6k4pLM=;
        b=RBAMh3nrSai8dP3NQGVkoo04mZ+mDslcKH3eOkfwqzA8RPTMDQMagmrZRDjvhVpTGN
         GNA+rm1h5X/f8K9opiTJL5WgtaqejGW+/3143OsmAUk5s6F0GsP2N5QcaLSobQgTD05o
         JOW49CauDMCgSli8trsnXu5GIyEUunFWWpzFWIqB3Uz6pISDFigohzX6nTDlaJvTGkrS
         A6BGT5S3AyX4OeuofqsifhmXd/cqru2PNqovo9m42G1OkkFOkKD4irTURcDzs6u1wX54
         kFXsjiD+/McG1+4hGf/7AdCHN1Hz4+F+jF28Le6qPMEgfVBgBWaxZ7u67d40GbPjgfmv
         eEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386205; x=1777991005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S6j1qnAdZyoQGgOKRaS8VSM6ZBf82wgE0IlMn6k4pLM=;
        b=A0pVVSd27WYsn5MNu13JvUUHTen/l8ljKgvFPLazynOLG3e1A5rvz5wSypsLhOh8jQ
         usAK1jH7AfY0TJr0adMcby4t0UQBw84j7333JdCrStPz8M7sy/IaoH8eAIBxHsgZjaW8
         FalX3og1CQczBLDdBwu0b8vZJx2fNcH9RGHyj+IaM8glUtbjjJBxO54xHZbVhRgLWWMp
         jAoG9FpuYnDsbPKC/xgY6QAAh6imcQqB/QsirvYW4qCCJxaXmTGTAScBy3i8YQoZv1bk
         QWjF7pMEkqYcrPjJMYlCD9SN+s0EqU8XulUk6oOXFjtFLO6Q6TQj8xhmzl5DUAZHtVCp
         +R0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/f8gx3SKwy0UJogXSIs6C4+2jdtXUhWqNsAd4wOUefLB44GiZfcxrzX1LTUirIqHakCp4SO4qvSYSchm5kr9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5xMNLs0v9lIF1nXtug0+s8eLfKiHF44tznJI6kIpMOVfo/oy
	CGQw4bOYipKSEEEwIwK+QVAKPhIm2STdejqHziUv2VE7tWzo6fRTr/vczO2tvgIfJIeC+uYE33S
	29raorZIqATzpH2W+F/cd04Zm3H3wqP13173iSt1Tn7U2k2pFovB6b4kzTMUZ0cbbonLwR24=
X-Gm-Gg: AeBDiesqlag7Q3+MLGviMOxkNvu5+EKrFXyFgCSEw5toqzGVbOxSgV4yI9Rt8hc4nzr
	NNALCjNYoqjyyqQEFPWx45Cvm/FJuN9eDQCN4pcEAghJqQtATTFsNMGnj2CsT7urOYCd8yrGuRH
	CJ3qKitjC/nvBhwC5lyUTaqS/1Kzz9AvOTQjoOGTv3iTWos5PHPAqF9NRMPEY0RxWYu4xEEDcub
	X12wj+1EBE6yZwDZOp6Hq9aDB/kt63Ca8x9i1kJrtcx15OQMMRtOwXp8z3KFxk5g4UFDsuI+50o
	JVl37KU/lfSEnM+6g/PkxpJZEVTtWUaRKBEPT62ycXGRZw/SeFIZ6GFIAWNigLoNWj/wpPh/MLK
	cWdkYgTf3PLg30A6DUMks2ndJ0f3PjKLPAVswiA/zBeR1O0qbK1ttLqZ3zebl/37s9CfmZhD6BA
	/xZgt/KYlgwM2hINVXrj7aXVVGYpA=
X-Received: by 2002:a05:6122:1d4c:b0:56f:8f5:b135 with SMTP id 71dfb90a1353d-573a56fd202mr1557369e0c.14.1777386204979;
        Tue, 28 Apr 2026 07:23:24 -0700 (PDT)
X-Received: by 2002:a05:6122:1d4c:b0:56f:8f5:b135 with SMTP id 71dfb90a1353d-573a56fd202mr1557313e0c.14.1777386204513;
        Tue, 28 Apr 2026 07:23:24 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:23 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:10 +0200
Subject: [PATCH 5/9] arm64: dts: qcom: arduino-imola: Get WiFi MAC from
 NVMEM
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-5-6ad23e75190a@oss.qualcomm.com>
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
X-Proofpoint-GUID: HKzzJgF0qaAaKiNh1Cqh41OjiKK30AvG
X-Authority-Analysis: v=2.4 cv=R4gz39RX c=1 sm=1 tr=0 ts=69f0c2de cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=w5cLSrw8bnM9wMX07V0A:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX+mHwedexLN9F
 0Kd92JN4AHeXv/vX4KhJtAagLWnltFPyHtovRggNFE45T7u8tg3kuffoQWuEq1Ex6sL/i9F/JkF
 QC4en7pyox+KzCTEnhTdLzzD+gsQG1I7DfI22BrkZWxXfd1BU+DsCXNUU1PLRAwIIR3vMwPCqxu
 CVouvoOMKe2vFdDFYghFEJdcHVie1fB3dIjp8mhzWJtjlVd+7M8FzxO6tHBTngy01G0z6FECuLX
 vzMXTCarM362KIOAVd3uVuaDL/qEPnaVloN0lyNSwsmdiFWT9OmOS2w35dF8KfoH7HeJJfj7r0u
 Peu1U/b5HVOzZSxuN3qom1+gA6ulJTSio5rGD4YbfSeQUYUDtLr76e5+6oIyFiQ5x1f0OY98ACN
 2HdHr/oflJwPhFBI1XzbvncTU4Hhm/NjoZy1CUvnenarykeZ0qNzk5tK8A/leUChEDbfVsmvwQP
 B4U6F+c4mjB4vkw2E6g==
X-Proofpoint-ORIG-GUID: HKzzJgF0qaAaKiNh1Cqh41OjiKK30AvG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136

On Arduino Uno-Q, the WiFi MAC address is stored in the eMMC
boot1 partition. Point to the appropriate NVMEM cell to
retrieve it.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index dc85cf94f71cac8666cab30ccf37cc2d2f8fd941..35a30cd6f47d6d2e018f6841a05fe929fec15738 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -581,6 +581,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080933F5AB
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 10:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915852; cv=none; b=kHgVJTUOGyeqVzwdS/XlSZsoObNKYp9wFcoMZw6BlgchZ7xOyxXRu4pl81aBTqNXOrHfqMBdRVZaHMyqYNmFf5fepDYXjCpsX/u0eVidxbYzwfXKtUnOjY7xecZRe8RxeriOJOx/IDPyeKpmlgvms7nTQWaEUh54uOBSjcRTjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915852; c=relaxed/simple;
	bh=RjAXLDtyeqYajrszhA7+nXfORAO+2o+t2+Lsa/IoOi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lmvnkyEqeXQC65VjrVUc2Xi9xulcZvbdyC1dS2fr4SKK3e9zXTrUeAcHJ0flPjIWZ6s/ZyaOLI8cRG8Rk3x9Igrz9+2KMRpVrQxuWJhsxURzOY60oAcGqq8ezva+UdlLYzopY4sxK3Z03iZVxI9DSSyVfsOjcPLNumFBLzqavXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aJ+fkT9R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MPfVJOjJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aJ+fkT9R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MPfVJOjJ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OrVV2274512
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Jun 2026 10:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=; b=aJ+fkT9RztRhmNf0
	Hs5tso3nBk7AfTBl5tX3u0dCwDsl9/+VUa5mSGG9+pqG3on1RpVlRxxHdc8wJFb3
	zY+XWpCb3vdIvPtr7thAx0jSUCumKMwLb+NuB2JkSon19TshTB5qEr60Z+VQQOl2
	0Ftfi7HVQyOgZMxV/XpVVoNhemQSEOBdCAFpNHFm9yBqoLJLHhK9CZPsCWUWx0Z2
	EkIaWR36t/KgMuA+GOQILSaEaeGK9mxr1nbCC05CbkC0gXgp8gzhB6eomjuEVy7h
	7GlHDYTYulnr540njGieZEuBxy6pxRkvl1rQ4DX4aQRU/dAuigSm+YvefB+ODJgX
	lTiN0A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgy5js-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 10:50:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51768072950so56950271cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 03:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915849; x=1781520649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=;
        b=MPfVJOjJGFLlBO78o8TFHqNS+NOAOXZq0SaULctyHQfIT9TvLOuCfw+Zrk0sLHpRrI
         eXkCxoONPQhHpAEVmD7PZB1EZmauY+8K3iqD6IyNRqwHpeq8WAMZa4w9BUieosMwKgkl
         qF9p1MFchlxtbnfdVcxiiPCBx2NT88D9F1rBs/tu3nStirmRtD8HG2XvbQuDxjJ0BMXx
         CHgJ8MvsZrhk8ZAE6iR+YK7VrD/aeOASlVr8ZPb5J8KMpknRDE/2rCd8rLlBb1oMkO36
         JAhQ92KzYMEcac1+VF5X7IaeRq6DdUfxzex6EXZyeO1Fikc2SfSJiSBox2HtDS7wfjnV
         jZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915849; x=1781520649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=;
        b=QFhiCfNF639qlWYuEGGCvNU3/gv1aZ7wUNtx9L/gE8PaFejWzvR1yfv96jBabcJvDO
         HBKjM2ANV5zHblMLLBUQ8O7fGfPNamDt+y+Abbzorc+eL5ttSap5TOQbZHBKTPczGJDP
         tJ69TvoIyvP/oFSm9BkBqbsdA4PPgOhhfuJ6HEzH/98szTXrQcLj1WDkrTe6QDyV4JXw
         Pym2VIFm2IwOjPnf5AY4AVtvRswlRh2kfJ3zQVNZ91tNzNl82UW6MEGCRvdtJg0lj7I+
         BWkevT03QE78Bn8fjGb1S+N/c4L/+zhCSnRWRN1yzk4dauXhSH6767UqihGQP0XhX9mf
         OEcQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tYXHRONvyr5Ugfm94p74HtkTXWBCqwAv9TovK1CVFrx6oSZsP+fF+nFxJHfXi3+3c7+ddw4sP3FpRPwrzFR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyciSyZFoJN8YCZNp40fxSsqi8mmbEAdexhhMbjfESvnjKNatvg
	tARYMjjoDwlcQ1Hlz98Aq7q3azqz31lElK2voLQ8v2Dvb9CYKGOvwvP/Pg0fJ4xxxr3L5SjOgYB
	WYRiNZLuPYFzkWcAocFNBIcuQziAXIdCZV4nwPGbLxlzu2navIUlR8aRHnazj+4597zOqoCk=
X-Gm-Gg: Acq92OEpTU9G/Z27f8gpm+iH/tNWD0DAR0T5QMqYabqO6Grig0OINCbyzBTv7ufo9PB
	LdA7hx5pw5dmVhXNUgC+0LyvUUPsyhQU7Btc/xR8MdGdsACAnuWM5SgmKv7/+4E6XNQGuYMBOWS
	DlwAXXHEiPM1z6zDqI2nYj4zbWHv6BOP5NNP6HpCKVwJSXnEArW6U8oSPS0DK1e1NcHw3x8JM9f
	HegmL6uakR32x/6/mARUZCyM1g6Cx2zI+tAbEi8wcGeEvGmj2xrpVV621Zi/m7RTnHvXYDRxMKy
	A0jPvNhXbWl3urzwNcSVTzg3vXme2/vUut0G6rv/nQQa5XTDTjxU79syM6je1NR8Ynf58tQp2BO
	Sxcqi4xsDjxzrrkscqfTvvNOumUvxOkn6t8NQy6pXTAmRmYU1/AYHfXPlGyNSJ38WJ4aHgT87Nj
	k/ya9R43cGJbR9PFs/ynMhQSGSavyaIiebpXuPJ0HTABx/HKV4WTNi5YoKSBNO/a27ds8JgXu/j
	i4Qbl2vZFSW
X-Received: by 2002:a05:622a:1a9b:b0:517:9157:ecf0 with SMTP id d75a77b69052e-51795be13abmr201563551cf.29.1780915849284;
        Mon, 08 Jun 2026 03:50:49 -0700 (PDT)
X-Received: by 2002:a05:622a:1a9b:b0:517:9157:ecf0 with SMTP id d75a77b69052e-51795be13abmr201563041cf.29.1780915848772;
        Mon, 08 Jun 2026 03:50:48 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:47 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:40 +0200
Subject: [PATCH v3 3/7] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-3-82681f50aa35@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
In-Reply-To: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a269e8a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: GkvLVReI6JqIruHEYRckCvAhQEpX0dVY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfX6vIZAv5Q+/0a
 5Wbz9IQGracFN8YQPPHjr/RKpkY05aJyp7zy3kiWprFsDJLImS3jv97r/FmGifiSTnQDqu+IKv3
 3GPAUyH0nTme01PE4FyWgCV9e+1hDhxdzd9lQ7QtUKQhF6/+2ETk0B2/fPAk2LUA+P/z1ypAXZx
 40p20qNft06Y+qZyFfd8N6FlsxpsOkiGFHVRj/Mthzo/Oa7HLpxeNCtIz5otchTT1UNvwLltK90
 gYd+tC2IAe/Ut2q9n5KzqF7ZOTdtDeqNr+jz5RWe74JHU2gQQBkCssVOaGVQBm9rP+X8Nnmu8aT
 tjklBxEzSF6o+ACS6s8ANI4X0Xi3TqXLfbvrtaociP0lTx26NL+TMrLUvgA1xPAFR/xnQ/4i7Qa
 94tANT+HL6u9Y9NTDbd82hJvfp/s4INj6kk3iXfhkzdL7DiOvPdBn2K3cAj7HCEllYz/NWjQcXl
 zkDFkBAKxUbQQQdbi1g==
X-Proofpoint-ORIG-GUID: GkvLVReI6JqIruHEYRckCvAhQEpX0dVY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080101

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93DE44105E
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386212; cv=none; b=hP+7JQjXpIBK58vTRQX/Rogetx4Y62JQ5yYyUOJyzawUTiHRWYJsuixKh5+Ww54xNy6/+o9uhK0msw2wnBVZdmBXTH4X0tBRGgOcybb3L01eIz4uM6hUCpyCN66IQkI3GjMa5HgpcgNJBVEfTHqTsoeperXPpxZknZEEYeZRXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386212; c=relaxed/simple;
	bh=8aNLvyuCs0cA/dQVyyMYQTpbdYd3gLaJzFwxfD7t/3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbNg1yWbzkLBVP37KVrmvpiSqA0dAUAOqPalBvJHO+aTAfpQtl7YsKv82HgAFTRZerH9ke5Hs8yaY94NTTOCFD/EonLWHOXivQ2fYF2OR2Od/ld7TCF2IjXGaqkshlH1S0+XDZcnBGPAJaFdLkSMk+YbDLxD9CUnnKDG/pnP94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DtAn6knq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BhiMwWGK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DtAn6knq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BhiMwWGK"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SAO2Rw1329580
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jm6l6UTLyr0NGskSQ/0c9LsflcrnDGa1NCLAOOsHjZM=; b=DtAn6knqeUmwx9Kt
	yl5DkawW+RQTgBprHQ4phVtcWPE7jBsnsjJgw/ee0YFczkz+EmS6GxaLa9qefrjy
	285x9ymwBvfViyaLyksWqIX8SLt243kvbWvUMVwKepOIXt/q/qaJ9msPNOIZ6r1v
	tUjKo1nOMMERMOKRjwq7/qWcfvsbLG4Upaacz7THphct2lW2FasJqtwVaLUNj3v6
	7k127p/VB1RiM0iltEkZUuyAKIAExZi2r7wUx48Nbv2PHdyeRxglifKabRP+lQif
	bnhT4R13shiAIqp2BYCpbPUNEvt7SFXSCSwyE7K2rxi3OJcPKm3bv/v3T13HXrIt
	JkSH4Q==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtnhaja1y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:27 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-463ee33f9b2so5873644b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386207; x=1777991007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jm6l6UTLyr0NGskSQ/0c9LsflcrnDGa1NCLAOOsHjZM=;
        b=BhiMwWGKSC1alLhVU2T2QFBceIihX5bW/wNaAehaBlGFj5wqyA0+Ik3C5lSW/KkdJH
         5M9EWVj5RjWkbe9+ijA1Y2li3E0sRERTWb0WNVf4EChKXLqoqoykaWqoOeObs/w5DJ/C
         evI66CNGwDhewDv78D8ZG+Yt6HhnYyVL/K3kMXpLFLqeFaRNkSk9v+7FZfTBRnLJOabn
         uGgcXVDTnuevrsv2LwhyhVqAMHBuqbqED7ocUIt397U+tFIWrlgch/2sYY+iIZuCsCCE
         mGSudBuRVPhFtkLLVk10nkr7yk/Waekd3Cuu74V6JcWALp6K16TprLLAWaGiQXTsxOTJ
         wOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386207; x=1777991007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jm6l6UTLyr0NGskSQ/0c9LsflcrnDGa1NCLAOOsHjZM=;
        b=CY3gDFwogX+eo50APKYcyWkzsdIwEzLRVx+tv8k6arLonAZel3ML/I6Hf4Q7pYpeJo
         6/kLeS8qpEH0QFDKSsDbVAWWDqBFfr+5L/DYZkwNe144S6a2M9Flq3mimHYrmY+deHT9
         tWzC97iFcBxrwxG8etxD5XxI1SHLXGqCzREgEafzn35syTQHKTzwAT9BKo5/jZx1SC7H
         trBHhFgtxhwGQ2UySOn2UUKBEyJAU4Y9+MRg5NL8E9uHiZ7cdAekWOj19RAS1kP0tJdU
         ZHngCpq647vBgJbz8pOLzhau2j1PPibiRpks1SBiJ9TXrN8FHdG2YHOuLyGXUhO9Cd2f
         2Ulw==
X-Forwarded-Encrypted: i=1; AFNElJ8SMNKq7MjJSdrMke1bzqqo1miAIAsDjpWzKGp6Nk742wBRlbb9Lq/UXTnXu9Z8Kagq1MXaAfWm2AAyqKrGbYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy01bOyCcNQ2qFF043D/7ztzF8NWpeh37n3FmIF5Y5rLZgUReRW
	2Vxo5ZYlYnWYHl9y3MzAE+ROgBWCG095DyDTlskCN2iTB777A2RFkPP9H76AWaIWVv/siZ+127V
	G72iflgLWT1TfHC+eb6ISohmJ2TRJVH6c+mRQ/9tK+XcTBQh/oFp8Der6fIBh6RpW1sKaz9M=
X-Gm-Gg: AeBDievJ7R+v2LiVOUX1cXCHwB40gv/mcJaHqBMgIxEVXCyRnmSjTTzkWeHQcjijEOd
	aofP5fKc2bxtkuT547ZV4HL/mO7+dohFGb7GlkHiN08B1qXT/Rjma5En+B8RFDGXkKuKrn+q9jO
	vm2G0zr0g4h0sm2FofuIk/fWrgLNORNdztij19QbvK6S/BkVTUZf4/kVpLXdnYK6beBnlEorrRC
	srFZDbKLSw5p9uu7dEe94oeD5EF28MxnbziNStb/jdPpdu6ZTMvQmlPjmGuZxmh+4u8478+NZom
	cTgoXdyM0B97czq3vXkY57P4UavFsfLrwHqH3feUNAvTSblvkGOJ92myCp268UpqhR1UBaNwcos
	Fr6ozB5e8A7JYavmfIDSiioqoloTQU7eO/8JCbdfSzNdq/tnnbARg0hOPb3tqDB+ZZI4JT0LLzr
	WL+mQLcs7O1DTji/RjRXJDgIlfI/8=
X-Received: by 2002:a05:6820:2d0c:b0:694:a362:e3ba with SMTP id 006d021491bc7-6965cb93af6mr1550299eaf.48.1777386207443;
        Tue, 28 Apr 2026 07:23:27 -0700 (PDT)
X-Received: by 2002:a05:6820:2d0c:b0:694:a362:e3ba with SMTP id 006d021491bc7-6965cb93af6mr1550261eaf.48.1777386206866;
        Tue, 28 Apr 2026 07:23:26 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:11 +0200
Subject: [PATCH 6/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-6-6ad23e75190a@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX5WrCgarky8qj
 1L70TIO5YWC+qLr9DmddiJsNbXIshCb3lMkIBcMkfmUJOoOxBzWAm3SPMt75XE6Jo4Fwz22SMQE
 gQ5e/t1V29Kjgqo6+V3GOx4DnH4aFAKmPPG0ebr56B0iGU+Hq3v+claPXuxNElFqu5zIOuyx8gd
 rNsP9F5KxQt4h7mO2O5hJc/Q88/tMWkp+S9AhewEpH7CCf/wwFcVv5ivacih2onPpRPnew1DKaY
 T9+iTg2yV2PcQFliyvibT84aok97Ok/zRd8coY4zNJyPTQooJ+VVAU/7W5X4fhvY0usNYMNOjwX
 2qs3FEq27N9yviZeYoF0cCb4PrXWnBlBditepOQZiyqOXrMRNv9NuD6bwuasYvcwy3OId5FvQx1
 8rtWxfGlEoF4rob94Iyd9BLrgwiWYfMHxTnnm6EywCAlJmg75lfYhQfsxeHDu3Q1GwI06Qg10oO
 VBRz5+UGcLDZbQwmTbQ==
X-Authority-Analysis: v=2.4 cv=JoDBas4C c=1 sm=1 tr=0 ts=69f0c2df cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: iBD7E0O-OAQVN8QBuOye9QZakw1FSSpR
X-Proofpoint-ORIG-GUID: iBD7E0O-OAQVN8QBuOye9QZakw1FSSpR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280136

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../bindings/net/bluetooth/qcom,bluetooth-common.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..ecb3de65506f7f0f1fc1d0b9bbd316163b7c26e8 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,14 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    items:
+      - const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1


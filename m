Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A9A3F927B
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723339; cv=none; b=VPqKUY0SXVFKlEEVQNHQjv87V73ddOoE+rwjCJHEZNsPQNVFy8ZHgmrcVyT8CNOUb1Fh0d2gSYMW5uM+Q6f2eXIuT1QbzGs0AC1mzTw/nYC3nFiBsOo3HDB2mC9AFiXy25Qnen3+/ZImPCxV5vIxRZfS01rqHAsKEq/SQ5Y8z+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723339; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eD+0dRqX+QUYVLjQx55kx85UL5Sd+JxLyn7ls29SXftmlQsA47hBMDCGClimgcZNIwR96NEa+c6UXbBXtqnvHc4eughJNTgHts0NRz2l4fAuQQhluh5izZal3yyR9oiamPc008S7w0NaJZuuYtyyxAQKu96AxtcB5yzd44sLLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F1Fcs9z1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AOBEQBjK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1Fcs9z1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AOBEQBjK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8OC652348499
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=F1Fcs9z1Aw6XRZTs
	Um7fEWGgX5KMk8DW9SYSLWVtVnGWMJoda5P8TBu5fBZ3dVMgwzv6NR9VP+2jTMO9
	F9h+ZjaDO9PlssYceWEKHXRrKeR2KStUYV7d4vpowsopRKjKBUAzdLPtVtLtWLbY
	fDxJri626kkWHDHjJmKmv+ksfmW5/EqibfVeuYrF/4mLCNM4Ot4/R1kY5GmT0knZ
	E8//UYQO8q/RRHP/sc38FkSY62FIrSbjWcgouKPze7dsixwql/LsXLDVr0HdN0Fd
	qeQ/zpD0gUl6oTpQwEdeGYE4Ew8MW6Hsq1+kAIhSwnMR5g7MaLJRA0WXT+K+2U/K
	0tmChg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s04n6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:55:37 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5ab02fb3054so2539396e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723336; x=1783328136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=AOBEQBjKIgTnXwJxyvX7rCT6xzjLuyp80J8/Vs3oqHsJBHrG2y0KRGA2YEtOpOS8vt
         JKrtwBT+mhW1wkE15eEQ+mAcCo1Q55vq/npwcu2Fr8qUMzkSvW4Uc1cTfVxbSwsc6pKV
         ceVvKjgUGZjr+k4I9USXnZ8GYs0G5NJioLGrvM4apFa+4lcwFDIzSFUf1oU0sANNeIaj
         DGDi63ucVzCqndpqirmAtu3S6tTrBFiOS/sGM+IHFz5IfWvoUty8zOuP0Qvam0MozNcY
         4o/o8ImtsDLLcyOijuP3I+TlQ2iRO+lG2AlTvA3x758nGQWkk3t4A+sAigeXxqU0HGEA
         5uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723336; x=1783328136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=Xc5R+zMmuWanK7JynczLa2q4D8HgGKNkkeDmWsb/skkT8tfE5seL8Xkk+BaYxl3mCm
         mCW79cz1AuTVHeUXxzRDbeA5iUkijWyQoi68ynTVgZWjIEe5NkYlwFl7T8ox9IClQ54P
         6DNrRgWFxwCYPQ3guFzqw5PLXF/aJOROpvL2m73Abts9XN6u5KYgPW85ejsn9icPWeTp
         a6pAmjp4M/51sYnnTyuheOSgruyIlBRQNPUDfK3UjhGFZE1cN+9AWxzB4JftUUaw9hr9
         cd69LnPWoy9V5dKCjIy1AaQII6MyF4Blg6sXdLyhu5ZibuxhbH4CoXHX/KDbfIpTbL7X
         iPRw==
X-Forwarded-Encrypted: i=1; AHgh+RrJHkytJTLmWJjZjylmVeMOL0gCiVssPflP+QhcwrLJflssUU6T/cCKD/iJ8lpF8Ec+SuydsxooUrH1we2xu08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/bKcH9Y9h2o/JJkhqtEcS3undqswEi1fIrXTsGlrGGmF1FKB
	XrFp4C2qg0cuYz0po0t011ZB8XCweN213AfmQl56+fZbCRWa6Uun6Qi5lUYxmrsPINmLUqtBsqP
	zyTr72JosIUEeAVbLn1J4QZMB0KDHVP4wz1qLQt/QeL9BxhAZkM+LdLe7kGUpJ2Bvhhy+hsU=
X-Gm-Gg: AfdE7cnjzw6xS1Q9/6WZu8wUc7b+sF5w/1nxmu+gP7AeBsPEi+FnwhLU+o7KPL5r0ZA
	5T6hi++x3n1wsqGkPQJdhlxjBzXfqMHjrIfeSjZYc36r/2RkBD9Eb1uMuJ8KdNJ0Yd3cEnGmRYz
	CtP/jAjEux2tk26SSjtqoZfMiJZtiAXggk9Pia7rW0s+q3oYynB0TGFVPcRh3HW907lNMrPo/8z
	/B6EsyAtVoP3JP0+QnVY4GNb26VR1RyUwTEI4NW8lMg8IpzPAAIVZJHWhxGbH2YWQP25xz1L4yB
	jg+eskSjznKWnkR8lhZC4gQKPu+n0P3A1co7U58ydm8on1Ijd0ekyheVgHY8ifr60RX2ZfcpHz4
	6Y1YdawNT6S7CFlJb5g3stojQgJzbUXO3Uv3BQ+W571NQ1D38zJw0T0TIVhKDDlbnyIF1Kbu0FC
	c6IEBNd5mby5Qa9oX8dsBknNZGGghlhlBBPognKpfMaMjHBbGr71Sz58HIYAxyTzZHsUHABTBzq
	ojr8Yem82mL06yZ0E1X
X-Received: by 2002:a05:6122:3123:b0:5a4:6680:64f0 with SMTP id 71dfb90a1353d-5bd69cc1bf6mr6342984e0c.4.1782723336515;
        Mon, 29 Jun 2026 01:55:36 -0700 (PDT)
X-Received: by 2002:a05:6122:3123:b0:5a4:6680:64f0 with SMTP id 71dfb90a1353d-5bd69cc1bf6mr6342973e0c.4.1782723336048;
        Mon, 29 Jun 2026 01:55:36 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:35 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:23 +0200
Subject: [PATCH v6 4/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-4-f02513dcd46d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfXyKo0bw/sR1Z4
 EE4yIaOAJxxfBpkxzvjEfsYCT3GHNQv1lFO6u4OuFO7TbcLb6Rsa4UMXctWSKOqMkQI8nKTpJ6x
 CBrx7SGw5MtVpSsFmxjgZfhtb9lDRy8=
X-Proofpoint-ORIG-GUID: e0XRrk3FKXVmjadfWvPZhQhuNaEA1kWH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX0EwDczRVxZir
 iyc1sP1l7Ep3uSuc+iqdJCOs9SP+DomUKbKNbIOGLJtkA1115F61kyzE5T5Uxy3ec6TAKWLqc+z
 TNbepVco1nBEUU2T3QiQlYiyYWCoCXgb5h5tkzyZ1y08P0wjUAvjKSop3OEoLQwdQeTzfVlgxzs
 0ET3Rzj/ODr8est0wRSkrELCA1evB/EaMyFm0b7ZBjU46taP/FDeRFTSIDKjaF3rcvOfFanFS2q
 nILgHcyVAONjhacWOTbHINznLBUeFC8opYQs7c6H0LCS4qVNFOazRmDrqs+qO8uLrs2WKJHn1PK
 YwlFCZj8MfKoCtZkFLLuxTuerVh/YOcHU24sPIrGhZfE9bUvOMp+6kbICFvGRqDezXN9DhwCzoL
 pCEsK9CURVTZYPuurE7y34842wLalAmlCdOnn18KB5R1VpHUFFKHBdXMpDGILoLCUGWct5NK7Mm
 HbdWZm+CppK408l6ONQ==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a423309 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: e0XRrk3FKXVmjadfWvPZhQhuNaEA1kWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290071

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


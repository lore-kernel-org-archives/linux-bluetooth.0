Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5095335BB
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074383; cv=none; b=b58pDGsIFZUqS1bR/A/RlGOPPtn0qJknqVWmQyuzFOATP5ptHUw8OX7fzmbUi5UzEwHsOR4+3x4Dq+/4yNyZNZyZlfCXJlukv+nYJ1D+UytfSwG1bAuZgyJa6VMriJqfa1nwFLlsZ6347aMwopjb6jhvuiZKBeCzNE7Xq8QvEKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074383; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8URsxnxl6rBJj06OYta5+55WfIK9Yfh13CRXUyantdmdY7uKkqm6cHaZEG/UFjKLt+37HrTF8zUIJ6mf1dXewkfRl2lY6BEGW1sd0W/pZqX6fuVeXPkhSBaTzdvBUWex4JZ1IG1mJbWFNHGKVngleJpoN4Nh1X3wR4AXburxHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DOuhrj7t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M8BWdqYd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DOuhrj7t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M8BWdqYd"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jq4Q3408923
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 14:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=DOuhrj7tQmzO4se0
	B6M0VuzNCKu4xPUlNYRkUVEipt1H4GDlQTqSqasCCFEfdXEOCTAvOHwmeBt7xSny
	IBDXPVOSQAnY5mZtoH8GNx4LJ+MvpH36fTfhY58bWk6ac9WP5TIR5RxMjqWVAHJk
	/x1I3CCjKd/DuPET7nv8ZfOTOba1zWBrgYhPw6ISNbuYfUfk6EiNk593eU6l1WEQ
	8G3HM3tTmc86SOgFP9HJ+HRRcwL7vGgSTIxhFKae1Soxq4C606Xq62uTF+No20Oq
	Q09M/QTl6S0WxXyxRPjBn4KlDBvlHdfZPrZOC4r7S++kunKvuFyIV8mZiX8g+yeC
	5rDfNA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn36gm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 14:26:17 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9806756ea40so1197833241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792074377; x=1792679177; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=M8BWdqYdGnAH9S9NQkbKu3ciH8vBFTtO4N0mqEwNcwetBw5oPSSiQY/dhbdmLksM/e
         /XYtbzpu21Yk3c+IHP+hjUjq5w42I8qjyUFfrza3wezWqcN3hsbbbSVSE3Mos+azVkST
         8wwottc+jUT8m9P6DYAm6FwV3/uFHNr3JDRkXl+19tTQLnWsFrOSgwJQD7NRY8MOjOZ3
         5g3+UoqyNJ4gpvucOwxAvjUbaRx5Z6u+0AbmHkcV2+wxc+2PNIffuWv1vgx3C2mK30OD
         YR4b8CcOERa5dIw4bhEAxhFyvzoP0vszFFscpKbbgaPIbwQFXiciCHJllDbyC8xbBaW8
         0gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074377; x=1792679177;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=AueTo7btrg689mKuxqMGAB6N4/RtlwCll6aulgQOwzCUVJp+i2IVXB54U/y9O7Y3e4
         SpOz5Q89Egx04tKmwEdBRUvXAdYQkkw5V8TBdxdf9240H5EPsc/hJeuVT7qcMIrsG+tM
         fMDLUwzFgSDMFbjqPuXGHH3+giVRLAC8DdBulmfFIqSucx16OvfuB8cSICOw2Tv2ONWp
         Dg1wVMfmuGYQE7+W2k2NNyeehYNtg4chdioY1/Gik4neNhzaPcRuasutb4lkq350CLDG
         yvEL1HsU0xGnmkODVMYCu3KCYAuE4pCiWJ1txNuYZopX9+A398zDFqwfnO5WACULlbHk
         vgDA==
X-Forwarded-Encrypted: i=1; AKwUvBxxO/y6+joM+dteqqLqqrkSBB9ig2PQFCowPonswU11BeggN22ZR3HnK/sOznVHtK2YkBqGQ0yM5a38I/uPqpA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXDCO/98n29qOqPngt+QBYyYMb5FRpai/h3aqwDHGpBHUmcYub
	JD1159D6ImY3iHFTzVD4wguRMd+rlmpz1BNiUiyKyzG2PNr8yZm1X3BNvaapt6fBP8n0TUQSoAZ
	7xgPz5TY0b7tL3kWOxJ+syZW++xykoKexJC2c3bk0WTcg3nvSzWWd08g5ga0kffoaL8mGysE=
X-Gm-Gg: AYBFou0oq96vGwOasiaNBoLHW7mbssiEZVmCR6BU3uwLKSkJZ/fMx6UENHEt7YoPlWy
	t0HlxSDotGT/MUEkAhHXb3eQvOQ7BgBcvG4M5b9vVHXlAc2lMLYGYwOOVUdK1Te/aiw/UrnJ9uo
	4gcETYu24ELlgv2um/hNqmX2JbHKgBUGuK+qsu43DMUzGWRSiYBpAomB6jR1ymSKcgrh0lUzMDB
	wKf0bioI9UWqQX5l+XZw/wkATqvz8DYrB4GGrgYVbjwvOhAytrBxb39b0P29jKebNq0iggcmwsq
	LeXoT7L55EY2bFCEEZXY+3GGTKPkJurOuVDrkwQANHdEE0Z28fMzgbQK2ysavNFY9qqs/2y99K3
	+sHsqQpwJmpCb90rqhAiYeDz6T8+qwjEWJjPHN+Kb/0AJqLJJ1AKoxL8gjQ55JQX0cav3n+5CUD
	cce2GRte7qPnXrmznetTk/t6B8+8dBcKVAEvP/m8GRq5ZdNX4hZJ4=
X-Received: by 2002:a05:6122:46aa:b0:5c9:a60b:e5b8 with SMTP id 71dfb90a1353d-5e91f4dcdc7mr6746924e0c.17.1792074376573;
        Thu, 15 Oct 2026 07:26:16 -0700 (PDT)
X-Received: by 2002:a05:6122:46aa:b0:5c9:a60b:e5b8 with SMTP id 71dfb90a1353d-5e91f4dcdc7mr6746873e0c.17.1792074375948;
        Thu, 15 Oct 2026 07:26:15 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5402:5e0b:9ef0:9b5b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd6428b3sm69083145e9.1.2026.10.15.07.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:26:14 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:26:00 +0200
Subject: [PATCH v11 1/7] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-block-as-nvmem-v11-1-f890ac74f87d@oss.qualcomm.com>
References: <20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com>
In-Reply-To: <20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com>
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
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfXzloZvNKPVY8+
 LxQNS6Anjdd86Gw6DylEJIPqItuBSeB6NVVeOde63gR1IiF/aa63iT7J10gpA0MubT3VaQAkDY4
 CUAReC77NWWZdMHLUT5wA9UkuvoNYynmNCpslhb0m2MeCWb3Gw0Hxl+b/WzqjiCHtSQJExNK6Kj
 /4CKakFGCILktDA7gMEVOB+6jghkdC9fIsF38wz0TV0Ii9nJsXFl1AAuQ7HotTrrL4ISIIFLfkl
 XhdGF2taPnSwKHLSEqM2vfWj+PX+3gGzYypD8CT15K7q/SM/f/e5ydPhNn4csagxfDZZwkcWVaL
 2DKtHus5C1TupsX/GGA3c2MOLP2nOEBrmYyEp3XKMCteG0M2yDlNQJGzLRHAIX0HW55HBZDb23I
 /TEps2juHYkgsEepvt65W+j27vokkM4JzH7o/QGDUwLdUR1q28V0fxqPGuLO+Y2MUn9q3ayKA5j
 8eLc6GctVefzMCpGbtw==
X-Proofpoint-GUID: BxTNWzHiQc5FNGpWtvFKQY2-AyGIG_L6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfX9Ey3BXZdfuf+
 xtPNSEOzEpG4HXoGaRHwDTTSr3QWL/E4vPBl6frvF+E+ZlfPQodMgRAbP10O503K9tYDZ/a0JDG
 MI+vDFhnvAutgY8mFWuYHywE1BBAGmc=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad0e289 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: BxTNWzHiQc5FNGpWtvFKQY2-AyGIG_L6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150057

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


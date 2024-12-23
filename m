Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08171B2188;
	Mon, 23 Dec 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734962253; cv=none; b=iFQo0tnjNcRbjqk+BH7Un+P4V994zRO8ubI8K59ZE9+HeMZuVs2lBmcTIXfpPIUbgqr/Vun1qGsN1OsjCzZw91hKIBPOxz1LK4BpbHG0tnaQGyazodMW5kHdtQqAhFx2ywrnaGsBEl074HbbpRdlpT+em6Q01okkIUx9crILLpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734962253; c=relaxed/simple;
	bh=of8K/NeFo4K+wxuluETdKEeIrgu+FKMyw6QFjVP95Ps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETVqVqgrlFM5gUzfyX+UNa+rugVE/Ut8dwhfDiOnP9eh8DHVzGLX/2pmX8gIbMiINA/jVqaTxXCKohoBgzdc0wecp23/cPPupDnGoILeNoga0IbOq9asQ3iV0JzfoVkxMBRQURr3C2NR3CYz+qn53X40WUU4QKdb4YItW3BrfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m3ksTU44; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m3ksTU44"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNBgeGV025279;
	Mon, 23 Dec 2024 13:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tu5sdnP9LuBb+I5dSohwl0wQ
	V7+h818+YBGdkgFv4Ik=; b=m3ksTU44fJJYN2ju6LG4kWVoc3bDGqvCLId5QR3B
	lyryV779kZtsEuBCr5cBzrtyzLMQzMDumE9OL54YUS4KaFbEhN8TXmlFXwQ61aTn
	7O75yTw8nH1rs3Nq1DsVD6gviohQjkADHmJhc1f/vSRrDdhMh+dfBFrt0srJdsiT
	55kUNGhzeIcDOFC6EdDDPnag6cYqL0hs8cVZe7ETPsTemSf2sNTnoJJcli82NXid
	Dws+mRytn9Dv182GC6NnWxWfFcXLudqtJGIHqFwQaRWnAQ8XaoVkhCZe9hmHIgAd
	h7JFfAPtgfyK//V+xnARQ1cYr4o+usBg1z0huRrWPxA8Eg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q77rg9py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 13:57:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BNDvP7e020256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 13:57:25 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 23 Dec 2024 05:57:21 -0800
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Balakrishna
 Godavarthi" <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/1] dt-bindings: bluetooth: update the wcn6750 required properties
Date: Mon, 23 Dec 2024 19:27:00 +0530
Message-ID: <20241223135700.22660-2-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241223135700.22660-1-quic_janathot@quicinc.com>
References: <20241223135700.22660-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qb3OQJzS-ploXGlVoBoNirXOCz8eBsXH
X-Proofpoint-ORIG-GUID: qb3OQJzS-ploXGlVoBoNirXOCz8eBsXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 mlxlogscore=888 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230125

Drop the inputs from the host and instead expect the Bluetooth node to
consume the outputs of the internal PMU.

Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
---
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml           | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 7bb68311c609..6906e1742d6c 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -154,16 +154,11 @@ allOf:
               - qcom,wcn6750-bt
     then:
       required:
-        - enable-gpios
-        - swctrl-gpios
-        - vddio-supply
         - vddaon-supply
-        - vddbtcxmx-supply
         - vddrfacmn-supply
         - vddrfa0p8-supply
         - vddrfa1p7-supply
         - vddrfa1p2-supply
-        - vddasd-supply
   - if:
       properties:
         compatible:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


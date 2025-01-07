Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6266F1F03EC;
	Tue,  7 Jan 2025 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257352; cv=none; b=ZDnQHZpVZebHXcDdUD92/me1eh6CMTPZzxOkEZUCn3Al6d6qyX+siv6EjMOC+m1wYnU2wVYGNnmpVPfCAXaJi5iqFvgLLI3oBWObwpjz/2H79or6j5UYa/KlBAJOxT0gQ7UaN8Ie2JYNgFkj9LeJCy2UOwbJZDrn9mzErXmvEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257352; c=relaxed/simple;
	bh=DxBCBG3KHLbNWZya8dTZl+4N8KLDj6TlqP3KG2ooCWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mg4aizTDJxXoAYMcP7Q7cvfgzl/Q/jEmsvMkY3A1PZ8YVyHkMimIgqhc//pqthBnBE/bGplvISJqjw64yhi66nMkrpSaRmq77/axhdCzGs0RFuMMKltfOzI5MQmzNx41/VX/avsOfqkB/ARgT1Rj1wLdk9dzlT3Xrux4Nfa1kds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e1o7maD7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e1o7maD7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507Ah80c028463;
	Tue, 7 Jan 2025 13:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QaeC6FcQb3CQQaHW/YVddDakWjrKK8InYEjT/kI0u+g=; b=e1o7maD7IQXOVwAt
	BOjpMZKw+MkA6k4C5KVC+Bt0sSOQpo0Kmv7AE6BPl75eu9RHsxym5E89LQggfmP7
	0Sz5vgWzRoayuMYub0DYarOauxryqTbByC0Gl45KAu2MzVE4xOzVeNnyktjz3Tbj
	LSlmoShvQhPIrBqBlbF4qlGsW3AvVWeodUVAYOuR50SnOHtkKQPpNhIanBKXeUTn
	0P2LDOgXPNY96iIKX5G5aFggZ444wZNCNzOL2ZJ4k4ogv5fDtOxAQlqdQhomAPm9
	Q6fUVyAYN77aP7ghiNaitrolqGfrzF3Nd1NgZ8KbhzOJA51PTUGh5KVnUTj46kjp
	NhEvqg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4412r78dw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 13:42:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507DgLHU025013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 13:42:21 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 05:42:17 -0800
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
Subject: [PATCH v7 1/1] dt-bindings: bluetooth: Utilize PMU abstraction for WCN6750
Date: Tue, 7 Jan 2025 19:11:57 +0530
Message-ID: <20250107134157.211702-2-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107134157.211702-1-quic_janathot@quicinc.com>
References: <20250107134157.211702-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gOwSANQoEyrXjoMXLUv0QlWhAttSYLtk
X-Proofpoint-ORIG-GUID: gOwSANQoEyrXjoMXLUv0QlWhAttSYLtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=862 malwarescore=0 mlxscore=0 clxscore=1015 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070115

We are now using the on-chip PMU node for power sequencing to manage the
enable/disable functionality of Bluetooth. Consequently, the inputs
previously marked as required under the Bluetooth node can be removed.

For instance, the enable GPIO is now managed by the PMU node with the
property bt-enable-gpios.

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


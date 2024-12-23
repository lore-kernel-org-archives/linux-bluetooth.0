Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6BE199FA4;
	Mon, 23 Dec 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734962249; cv=none; b=aAWkaHWSjdrLCvMpacCkCC43rev8dMrKFLTtBTZ+wNLQmOKP1N8+nL/1CfTmdOQrVUexMR+CmVwWWbxb4gE+bBlZ1ljQ4ToJutXQcJCoeWADjMwCqJAaJUzM4PEIpHdT23bmk/OMGw+gQmT9kRWXcAmMGQ7A/sAx8Z1VzKXkzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734962249; c=relaxed/simple;
	bh=XjPXfgpZwy2t3R3e/bgSgPsumN0w/OyGGt2d+Ttj0e4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EJ/mzec7HK+V/y9O1yt7k611ojh71LCG8S7Jb+mkGU13gI//YfCFI3OCck4irq9bIdTMn/7oXTz78zMnjaLH9sw4DlsMU9hfyUxixOmtDqPg8HQsUlyvBB55n3PnaOSc5TJRS4J1UcZkshCriv6iJPziFLcAZBHR+hL3aVRC0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d8MkGd7D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d8MkGd7D"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN9moHw031210;
	Mon, 23 Dec 2024 13:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=3POV5CaBYMGV+XchA910OBvWcPevo7zbEdr43qreOh4=; b=d8
	MkGd7DuCeS7CzXoMQVrbBSPiLU2kcadJ/WPUy2mtLAbN481jwE+iQxh+9FJfZgp4
	U7vqVHOyy2N1WXDfUmvXbcA7NuKnQXXHBzoFXmv7WrWJC7zOsxXe/1mT4Ax8/TnX
	2ySIGQzYisUYuHoEPUFmnxxj+Y3ZvmdaA+aHDd7awX4yBUE2830aHu3B2WH1oZBx
	PQOIdKX48URqhdS1GBmrC1RZ0gNNhNnfilj6ckH92f+9/3ITQL9MaJDDbfmaLs7D
	o//7Hzvgh/aMyzVU8hFaBlMoLpnnQiaitTg6wNSXv+qEftiXjNOSA5CM8dc/mRLm
	xybv1rjJVUjGgqYqIRBQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q5jb8gmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 13:57:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BNDvLtA011044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 13:57:21 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 23 Dec 2024 05:57:17 -0800
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
Subject: [PATCH v6 0/1] Enable Bluetooth on qcs6490-rb3gen2 board
Date: Mon, 23 Dec 2024 19:26:59 +0530
Message-ID: <20241223135700.22660-1-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
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
X-Proofpoint-GUID: 4JYP0fY4j1i_M5LkDtSPgUIJFR_x1h0M
X-Proofpoint-ORIG-GUID: 4JYP0fY4j1i_M5LkDtSPgUIJFR_x1h0M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=810
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412230125

- Patch 1/1 Update the wcn6750 required properties in bindings.

----
Changes from v5:
* Update the wcn6750 required properties in bindings.
* Link to v5: https://lore.kernel.org/linux-arm-msm/20241209103455.9675-1-quic_janathot@quicinc.com/

Changes from v4:
* Added reviewed tag by Krzysztof in p1
* Updated the p2 commit message with sw_ctrl and wifi-enable are
  handled in wifi FW.
* Added blank line between the nodes in p2
* Placed the structures in proper order in p4
* Link to v4: https://lore.kernel.org/all/20241204131706.20791-1-quic_janathot@quicinc.com/

Changes from v3:
* Defined the PMU node and used the its output to power up BT
* Used power sequencer for wcn wcn6750 module
* Split the patch to multiple as per subtree
* Add description of the PMU of the WCN6750 module
* Include separate UART state node for sleep pin configuarion
* Link to v3: https://lore.kernel.org/linux-arm-msm/20241022104600.3228-1-quic_janathot@quicinc.com/

Changes from v2:
* Sorted nodes alphabetically
* Link to v2: https://lore.kernel.org/linux-arm-msm/20241010105107.30118-1-quic_janathot@quicinc.com/

Changes from v1:
* Corrected the board name in subject
* Link to v1: https://lore.kernel.org/linux-arm-msm/20241009111436.23473-1-quic_janathot@quicinc.com/
Janaki Ramaiah Thota (1):
  dt-bindings: bluetooth: update the wcn6750 required properties

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml           | 5 -----
 1 file changed, 5 deletions(-)

-- 



Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159131E491C;
	Tue,  7 Jan 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257345; cv=none; b=MD6Oyj0jqaMgvcbFBZYqF83yihAZRvSJN5WpDt2gbldCzrhDpBOKhcDZZzhW7mcXXRnlZdJRU+uVXy7qmSOPOsGElLxJ6venCSQcluqkyQ4YbgW6/Ai8ncY0YsPLbvCPOaU1SSbsxURFfofUHVwDYPDVXhSlEsW4JgeFg8V+u7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257345; c=relaxed/simple;
	bh=uPoKlVZYDAkinjqoexFJhWfGtZOf00BaIn/eoke/VdE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FZH+3+wrHweqPA1ij+AiKlqvV7kLE9LCXz3YUYEPOMZrqOG2M60vwAl8iTutGlyE8QngMTNoEc14siWWMgoOM1yc7RApTJo4mikYkHO4FMYTVTTnM+bNUhYJpYXB2DUHPY/K2L99FtZ7d6IVsYpu0G4Vf9Hj+Cozq5U5ofwshmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z9fmv01q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z9fmv01q"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5073xbe7008686;
	Tue, 7 Jan 2025 13:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YU0qbJEoyX4rkk20rg1DAy
	6EOPXGEbBx6c4ZKDhGeso=; b=Z9fmv01qrGGUwMzByCPM74Z40WGY4GkOKRmQP5
	NB66PIqNVgUBHn8EqzN0p4zL6bfyIBJY7oqb1VrZd1VWD/ZMEjkrjgItzTpmltbG
	y/k3TJLPZug9iveh0JAvsac3CM9z/e0f8+306pVYgSnhVzMoCmwN40WtfOKGKJoh
	r/5j6O5sK6yd+odyA3Eo/MDrMEvkAcpQM6ALe6hECEoRu64fiHVbGebmo/eWd/Vt
	MwRoDXQXy9Gv1+St+0AAyXY5NcVKhEZsRvRUmgmehL0MUQQdfBygzVF0UBUV8UKD
	H6nE+3/CNHWOkaTE66dDRv23S33wb3qDS1toXxiDyAMWHgsA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440vuq9agn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 13:42:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507DgHol001185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 13:42:17 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 05:42:13 -0800
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
Subject: [PATCH v7 0/1] Enable Bluetooth on qcs6490-rb3gen2 board
Date: Tue, 7 Jan 2025 19:11:56 +0530
Message-ID: <20250107134157.211702-1-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: fJAnLQBOABaViP9xvp7altckSeaoZurn
X-Proofpoint-GUID: fJAnLQBOABaViP9xvp7altckSeaoZurn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=865 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070115

- Patch 1/1 Utilize the PMU abstraction for the WCN6750 and update the bindings accordingly.

----
Changes from v6:
* Elaborated the commit message with more information.
* Link to v6: https://lore.kernel.org/lkml/20241223135700.22660-1-quic_janathot@quicinc.com/

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
  dt-bindings: bluetooth: Utilize PMU abstraction for WCN6750

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml           | 5 -----
 1 file changed, 5 deletions(-)

-- 



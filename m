Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8A1F6686;
	Tue, 17 Dec 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445520; cv=none; b=FFl3bdpMsh3ptfZMQg0/0H8r/orz8x4ny2lyG7o2vURF5Oh0zZjiPrO/g9RQY0T16uurtcVVFSEYVhXc2nAcK09AEZukZ9AsqbCJZ/CnSdGB/I4Ev5BVsrJgs9uqSRu1O7di30xQSGVuKYbO7FV+pCd2tUjZGgVGPqXVEwvL0Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445520; c=relaxed/simple;
	bh=SVuO602L1GV2cWwqtewekQVghURjXfpYInc0NJInQCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDyYA+P4QTh+gwmFwGS2pjJE2ZtRbzRnGT3LOONCdc37/sPJbgPdOI8f8vvpBVy70y3itxWO1lkk44NlQoVehGRpz1Kg2AAkAYQHJDqoKmxXMFjeAODYhOFWRzng0EWssLkNq9n3RaVweoyw76DvX/P6nzEDko2V0ZUqnhJcA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cm9lShmP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cm9lShmP"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHB2Z6V003028;
	Tue, 17 Dec 2024 14:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nVAK+m4J45EwhLsH5EuEXRPeAHS+ZdO4Dl0dW/NZxgU=; b=cm9lShmP8h6aozAr
	LlyicaIrP4RISYHG6qqhUFuokAlVOpfaFCkNZzl/bKrkZPRai3h9gwNIABqvv7Tn
	+8YWNaJB1nYr//VYClrZNfXSVuajfrxcGuWUKiy1iKegmsLv5mlcTn30xI+Otf6x
	zBnkgaah5TyOtNsVKUNsbiA2+vnTnv8Zog6KLLQmBgg8CseY/KO96WvcP5FdsFLo
	Ws79C+O75zRZWj+4vJrLwAbA3717Q4P9WMZYNBnEdZ9cpdzmVoi2nwS/dA1wciCq
	bvCEWW0T6B6AE6UYxC8YbE0YtSJl/++rpw+44SE2QfuIXTHvhEXf2pW7KGkylz3s
	DpbnSA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43k8310gss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:25:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BHEPCLL025441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:25:12 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Dec 2024 06:25:08 -0800
From: Cheng Jiang <quic_chejiang@quicinc.com>
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
CC: <linux-bluetooth@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_chejiang@quicinc.com>,
        <quic_jiaymao@quicinc.com>, <quic_shuaz@quicinc.com>,
        <quic_zijuhu@quicinc.com>, <quic_mohamull@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/3] dt-bindings: net: bluetooth: qca: Expand firmware-name property
Date: Tue, 17 Dec 2024 22:24:52 +0800
Message-ID: <20241217142454.614551-2-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217142454.614551-1-quic_chejiang@quicinc.com>
References: <20241217142454.614551-1-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jafzUXBMnh0gk46ZT6YLbzD2-3UlnR7u
X-Proofpoint-ORIG-GUID: jafzUXBMnh0gk46ZT6YLbzD2-3UlnR7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170114

Expand the firmware-name property to specify the names of NVM and
rampatch firmware to load. This update will support loading specific
firmware (nvm and rampatch) for certain chips, like the QCA6698
Bluetooth chip, which shares the same IP core as the WCN6855 but has
different RF components and RAM sizes, requiring new firmware files.

We might use different connectivity boards on the same platform. For
example, QCA6698-based boards can support either a two-antenna or
three-antenna solution, both of which work on the sa8775p-ride platform.
Due to differences in connectivity boards and variations in RF
performance from different foundries, different NVM configurations are
used based on the board ID.

So In firmware-name, if the NVM file has an extension, the NVM file will
be used. Otherwise, the system will first try the .bNN (board ID) file,
and if that fails, it will fall back to the .bin file.

Possible configurations:
firmware-name = "QCA6698/hpnv21.bin", "QCA6698/hpbtfw21.tlv";
firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";
firmware-name = "QCA6698/hpnv21.bin";

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
---
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml           | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 7bb68311c..a6bc0b18b 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -101,7 +101,10 @@ properties:
   max-speed: true
 
   firmware-name:
-    description: specify the name of nvm firmware to load
+    minItems: 1
+    items:
+      - description: specify the name of nvm firmware to load
+      - description: specify the name of rampatch firmware to load
 
   local-bd-address: true
 
-- 
2.34.1


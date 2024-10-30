Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE47192D76;
	Wed, 30 Oct 2024 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281669; cv=none; b=AFWsOqVrtv7wMykbgpNAWu/DsVCyzlo8Cp1kViURVT8JyeTQABp/XZ2+TcXJbYH5d0GiCJjix+KEuxY48J9pespLvdcvAP+ob+r95jWpLmmyBiaMo/7m2aDjkgIiIlD1JVg8fyP0Lwg0/lP3cwQX9JlDK2AA0xdwWHfCSv1+n/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281669; c=relaxed/simple;
	bh=fgQ8HPJMOhDVDvtNZIRo1EcUE4/mp8/GcyyDZDCyufI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hFq2Cx5/r5kNGPRx3Azdzf4wu+IRng+ilfYC+78zV1mrPz/S/zwPCLiKYor1kSreEw6gBK0vgJY9tjW9TJrPZwcVchG25NNulustBRCyZi1cv4WPk9dTw+e15jOJJNxwKqq0EDKb9hW6XrOo8sSC5NIPPjplnavYNAQGvgjA2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J5n+9OhU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J5n+9OhU"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U0dLci008776;
	Wed, 30 Oct 2024 09:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Jnd7WRijSd4x0aizijKlG5
	KEkMdD2qcJ5Lpw78Ikn90=; b=J5n+9OhUbamgtcZrHHcEj/VPAlZ7BwnGlipmPY
	J1NUXhi6w90PqXr3jeA8exn9hcTbJhRZMJiufHExbtcouJ6IiVm3a2HDuRt/MOJZ
	F1akAspIV5Db9vw49n/shWav7LI+gKQoTl2GNIJhQLl/5tV7cFq4ZzyDdgyg9x4z
	1iYhJdBRSEn7KKnExzcZLPXw/s6Q9JiC1jx/WpAZA4ZeaH2wJZzh621Chm/dhy2Y
	6h70+xGVwYiaEG4YE9u1umEqCNEEdiJplHfjcDtUR9nariZjtwU5eiXJ+rSwRhZ/
	91Ko7OTlmwcpOrX9MXeK8XSO1LKsCvhfQXYDrhiI3xkjNbvQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42jxa8bawa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 09:47:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49U9lecw015241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 09:47:41 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 02:47:38 -0700
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
        <linux-kernel@vger.kernel.org>, <quic_chejiang@quicinc.com>
Subject: [PATCH v2] dt-bindings: bluetooth: Add qca6698 compatible string
Date: Wed, 30 Oct 2024 17:47:28 +0800
Message-ID: <20241030094728.1714034-1-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: BrMy4tjZDvYySx_r0m2wQ8QCIDtPm8sQ
X-Proofpoint-ORIG-GUID: BrMy4tjZDvYySx_r0m2wQ8QCIDtPm8sQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=945 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300075

Add QCA6698 qcom,qca6698-bt compatible strings.

Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
---
Changes in v2:
- Add the compatibility for qcom,qca6698-bt

---
 .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 7bb68311c609..f8eb5c09c1bf 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - qcom,qca2066-bt
       - qcom,qca6174-bt
+      - qcom,qca6698-bt
       - qcom,qca9377-bt
       - qcom,wcn3988-bt
       - qcom,wcn3990-bt
@@ -169,6 +170,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qca6698-bt
               - qcom,wcn6855-bt
     then:
       required:
-- 
2.25.1


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8615B0F7;
	Wed, 30 Oct 2024 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278660; cv=none; b=ArXJ8Ic9P/Y7cFE+UzQ63q9Dsk+TlK83YFQHdGivsKVbK/+Ab+oXLjAo58g+B/HgNgztgN4GGQwq4YEbBAVMp9OShc6OPKRu75z+GxHxDh1PlgZt1E/I/1A0MDj684xj6C2GH0omXzsLO/3U8/9REXUP/j5Kzr8vuJvo/yPHOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278660; c=relaxed/simple;
	bh=A9gGyIPOptUM9cqyU8nnJCycIpuhm1BRbY05dMApQcY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XrB5lvKAN3MyH5GlTag3IzUIF+qBFM8y6+4GQBedpsiCdet2VjgVC5lQy5nwkZvFyY4gh7wfTMZW0Lpqt4v/kT60UGnCj5XFJdfPWmnngRce756dJ27bshewImzWCNxHDPFlUC0/KEavdqozNEBXiWOUKFLsVeULCBiW3K4v3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UNYkzHLd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UNYkzHLd"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U5QLfh027500;
	Wed, 30 Oct 2024 08:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QOaIU9mHLZnIwSmndmYtgl
	Tgm552NDslIVfUmss4qTE=; b=UNYkzHLdZbY9AU1Oh91Gtk9UZ8mjwAZiBgsn4Q
	7iDZa2DnG8E7/BnTHF9/txp9Sfl53QmwjgHGUZ6NEC7gJlVuFUjdIFNG171doIM1
	3Mizhp7YDp5OXdgxh4bLVjrrCgXpEbVNqLw7CXSm18MmTcqSUoGCvqVJ0aGGCXHP
	pWYW0VOfV8oIHLmac7XFb5GCzGTwnM/s+oE5ZLO+WYcKb3ewbVaz8Mv4rodYxjLS
	R/cYoUA+oYzmEE0FhF/5mDV4jUCBRWxugSqx0iG2II6ZJMXLaYxfc3snq+zQMU77
	7sL66GXuC5O4GL4swooP47qGhWGAIotb1E+UCs1bKCUSkDZA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42k1p32nh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 08:57:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49U8vWm3016313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 08:57:32 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 01:57:29 -0700
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
Subject: [PATCH v1] dt-bindings: bluetooth: Add qca6698 compatible string
Date: Wed, 30 Oct 2024 16:57:14 +0800
Message-ID: <20241030085714.1712454-1-quic_chejiang@quicinc.com>
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
X-Proofpoint-GUID: 9n9lGArXtDZWwCORaHr4Bq3B3Io-AMd_
X-Proofpoint-ORIG-GUID: 9n9lGArXtDZWwCORaHr4Bq3B3Io-AMd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1011 impostorscore=0 mlxlogscore=971 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300069

Add QCA6698 qcom,qca6698-bt compatible strings.

Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
---
 .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 7bb68311c609..8ae1827e6a70 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -24,6 +24,7 @@ properties:
       - qcom,wcn3991-bt
       - qcom,wcn3998-bt
       - qcom,qca6390-bt
+      - qcom,qca6698-bt
       - qcom,wcn6750-bt
       - qcom,wcn6855-bt
       - qcom,wcn7850-bt
-- 
2.25.1


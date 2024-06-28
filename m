Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C60013DDC9
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559456; cv=none; b=sJr0ESnUjMl/ZPskF9ts9X9AhF9pChOokQkImkHdCaIL7kaVkrXYXT/TDd2KBX10EPfsfyZb7O4hOp4dzMI5siVUtOZVYaU4aAJ1cZkRiv5TMqvJM2zSKLhyshvb/Mn+x/RnIpE7EZIRexZPozBb+NNZMbwFJH87MO3wWQB7XLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559456; c=relaxed/simple;
	bh=nkapJ87y0CPOaFwC3JdAX0Xkt2UUA85Gh+FZukzfnN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CAWjaYZBR4Zu11i0TAoFzJTjSmO6z3tHp3mMh5/mP0aedupBEok7Q7VD2agfrobpgIW+ahH5AJwGoUE5Vbm9sCRj0UGFBxcBjltoeq56exqhHUb6dSbmNskreMZsbbPCx+rAYpnyuNa/G0AmoKZh3Z+Boh1YB+CtDkcwtWvcYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mlMBXhvf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mlMBXhvf"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S4wEm8031934;
	Fri, 28 Jun 2024 07:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7iDJytP4QfdX4g6oFMIYf5
	i8JhryGkjonj7yFENxq1I=; b=mlMBXhvfnuTMJFenCj2JVgiODIhRYLSteNHBUb
	O14oWeg/EwvU1U4W77zNd/K9ytF7V4u7ecBX5tJvk249efYKIAEmnQ29kLMz7d8I
	3DsktQWgNsc3auk2mU6lN55HQ36hBf3rMcVHlL/fVDZHjo23qbo+g9i/K3dUAubX
	3xyCjZU7/I71m03/dsEGglX68HnOzCBZOZVXun4Hgzr73fYkH5ySQCQbCoVp8lBU
	UpmXUbWfQf63rHRcauQ/xcvZRwAF5MYKggoGU85cKU69yeW+xhwoRi8i0+0qPQcJ
	+X8M4tytFs8o3zOfxeOaWmDaN2TOO1LfjWbMdhQYPrv5euuQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 401pm589w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 07:24:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45S7OBj9007714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 07:24:11 GMT
Received: from hu-prathm-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 00:24:08 -0700
From: <quic_prathm@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>, <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] Added BREDR not supported bit in AD Flag when discoverable is off
Date: Fri, 28 Jun 2024 12:53:42 +0530
Message-ID: <20240628072342.2256-1-quic_prathm@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YWlrbfq1blN8PqWOUKn-kDMDYkix89Nb
X-Proofpoint-ORIG-GUID: YWlrbfq1blN8PqWOUKn-kDMDYkix89Nb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_03,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280053

From: Prathibha Madugonde <quic_prathm@quicinc.com>

Fix for GAP/DISC/NONM/BV-02-C
As per GAP.TS.p44 test spec
IUT does not contain General Discoverable mode and Limited Discoverable
mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
case, thus added BR/EDR not supported bit in the AD Type Flag when
discoverable is off.

Signed-off-by: Prathibha Madugonde <quic_prathm@quicinc.com>
---
 src/advertising.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 5d373e088..9857ceceb 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1444,6 +1444,7 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 {
 	struct adv_parser *parser;
 	int err;
+	uint8_t flags;
 
 	for (parser = parsers; parser && parser->name; parser++) {
 		DBusMessageIter iter;
@@ -1499,6 +1500,21 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		goto fail;
 	}
 
+	if (!btd_adapter_get_discoverable(client->manager->adapter)) {
+		/* GAP.TS.p44 Test Spec GAP/DISC/NONM/BV-02-C
+		 * page 158:
+		 * IUT does not contain
+		 * ‘LE General Discoverable Mode’ flag or the
+		 * ‘LE Limited Discoverable Mode’ flag in the Flags AD Type
+		 * But AD Flag Type should be there for the test case to
+		 * PASS. Thus BR/EDR Not Supported BIT shall be included
+		 * in the AD Type flag.
+		 */
+		flags = bt_ad_get_flags(client->data);
+		flags |= BT_AD_FLAG_NO_BREDR;
+		bt_ad_add_flags(client->data, &flags, 1);
+	}
+
 	err = refresh_advertisement(client, add_adv_callback);
 
 	if (!err)
-- 
2.17.1


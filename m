Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2560E33D5
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990181; cv=none; b=H+qDZvXZ/aStyd0ECkn8QxmcIU5XrBsZY4hcBo451VP4yJA8Gtbc0aSvEpA1f42ps4KT8yqTfyj9LURQkzeEysm2B8YbNNdouZ8qoqp3bacF959i1h+hHLZwvMTNee4gm4G4Pj4uTzQ7gwGONhQB32EDuPRz50QMaQ404kzc7ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990181; c=relaxed/simple;
	bh=FMzvn/q0q3mCZtN3aje7jkKszHTIkxqHsXOltw+K4Kc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dc6hQSr0I155ghJlAQ67sXj7ZC6/aQPFUt0Tw6n+v20Qj/PUxEeZXPNKZyoXqpCZf0AZA2SvOZ7K3hP2r5hp+vrIWncJUY44tD0jir4TPMEseFEPwWXKKCETPZs0bPlFRg1dYbfEXbK+bhUK/MimsWplinwWZamcuh9fdab1LWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=baE3Qujb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="baE3Qujb"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4634MZnA026763;
	Wed, 3 Jul 2024 07:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5FrHL9MsB9wcnbzyFLL9wL
	xPzF4LnXoc419zRRywZls=; b=baE3QujbgPBqxJXsHwEzreEnfjpkjuiUNaw8zV
	4C/qSL655sNHG8/nuuiygCSKuO9uTtGLDOKMvzJX584O1FQf7w67mS/vlhEjosCF
	mtFQo++jFcOnnMwsvSyPYvcNK5K5cHbE40rHBcUSUnMy+YBnz2jzG/jXf8FLqNM8
	M0PRJG+P3oyuqofGEHCBxqP26zG/anIYgt6pRs0ZwJ54XWjZzo2aE9zKZPPuncGJ
	6c1N3XgBq08OdOwPoIeiScs3z/5ioazKKFHLJ/McgYgheiFTyeyrn3HT8ImC4Nek
	Og+knjsDgLYkY1wKkVE/wcUTOSU0ZKkZaYQDjfIDa7Tq6VMg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404yjhr9t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 07:02:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46372vC1030021
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 07:02:57 GMT
Received: from hu-prathm-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Jul 2024 00:02:55 -0700
From: <quic_prathm@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>, <quic_anubhavg@quicinc.com>
Subject: [PATCH v2] Added BREDR not supported bit in AD Flag when discoverable is off
Date: Wed, 3 Jul 2024 12:32:20 +0530
Message-ID: <20240703070220.15246-1-quic_prathm@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QroqhwSSks98pPWmPKmt8vmDUzXMMSbx
X-Proofpoint-ORIG-GUID: QroqhwSSks98pPWmPKmt8vmDUzXMMSbx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_03,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030050

From: Prathibha Madugonde <quic_prathm@quicinc.com>

Fix for GAP/DISC/NONM/BV-02-C
As per GAP.TS.p44 test spec
IUT does not contain General Discoverable mode and Limited Discoverable
mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
case, thus added BR/EDR not supported bit in the AD Type Flag when
discoverable is off.

Signed-off-by: Prathibha Madugonde <quic_prathm@quicinc.com>
---
 src/advertising.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 5d373e088..cfb239585 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -734,8 +734,7 @@ static bool set_flags(struct btd_adv_client *client, uint8_t flags)
 	/* Set BR/EDR Not Supported if adapter is not discoverable but the
 	 * instance is.
 	 */
-	if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
-			!btd_adapter_get_discoverable(client->manager->adapter))
+	if (!btd_adapter_get_discoverable(client->manager->adapter))
 		flags |= BT_AD_FLAG_NO_BREDR;
 
 	if (!bt_ad_add_flags(client->data, &flags, 1))
@@ -1499,6 +1498,17 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		goto fail;
 	}
 
+	/* GAP.TS.p44 Test Spec GAP/DISC/NONM/BV-02-C
+	 * page 158:
+	 * IUT does not contain
+	 * ‘LE General Discoverable Mode’ flag or the
+	 * ‘LE Limited Discoverable Mode’ flag in the Flags AD Type
+	 * But AD Flag Type should be there for the test case to
+	 * PASS. Thus BR/EDR Not Supported BIT shall be included
+	 * in the AD Type flag.
+	 */
+	set_flags(client, bt_ad_get_flags(client->data));
+
 	err = refresh_advertisement(client, add_adv_callback);
 
 	if (!err)
-- 
2.17.1


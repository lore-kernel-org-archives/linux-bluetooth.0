Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCAB31A89
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992266; cv=none; b=vFQWXynxJgb66GLz0z1G4+yUf4PgqWiEQf5dmPoWIHLVfq6rC+LuH0DhHiakfd1XSCwlD2xr+s4e6FTgW9G2uEtvtCUkxdXONielYsKX47ynGqTU/I9itMTR/wIKSIqZgYuAWhMwxoS8P/DDp4qfb7lljlMZVzGdlwwarvJOw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992266; c=relaxed/simple;
	bh=Ozweiy9X2dQRVzZkNtxWdK/B55awqyIx0kPi1gM9ctg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FasS2fblaNCL6A/extzbcwoLOllR0fG/+qKkOc6y/9PM7IU9ry26YqcaNg6Ojj6RP777CSfURWDfcXK8kV/tYU1VofT4afm82QAk8ZD9scA9nqU0Fdvd06oWg/+S3TV2OCkcNg44lE7/7S7UiybLF7pGH7vCb1yVa7oGwnr3hYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ThLewk02; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ThLewk02"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4634Yl7l010608;
	Wed, 3 Jul 2024 07:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=nDp/uLGCqjbcbY8xYziMaraRyA8y5LBlSe9GKWfjw8M=; b=Th
	Lewk021YFduNK9gs505tTcYMojCN2M87bQDTD4/jHzuxfK+pppCJDFGAyqUglSke
	rJbKnwTEPKI73+KrDkF6pGXG+FChR1UIcMWFLErf0ss5XWvOB4mgEsy63JWocYv2
	eTOVWLFxt+EBTHTaxg83VxjVZqrbyz9oUWplhtodOG592nFS6Fxh/rU+XDm0i5QI
	aST03Birdj9MSdYBwLk2XPB1iLpXzMlPQXDOgaRpzWdmr2zveWEZ4y3aAiYSt6FO
	t4BSyNdh5D4kwZwnwrEoWNjEuwV1FQmEwm/dgzHcMksQxTr5t++5vCB1W297/++5
	LwmltRDMT5YxYwQpBKeg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404yr98bmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 07:37:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4637bVVt030898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 07:37:31 GMT
Received: from hu-prathm-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Jul 2024 00:37:29 -0700
From: <quic_prathm@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <pmenzel@molgen.mpg.de>, <luiz.dentz@gmail.com>,
        <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v3] Set BREDR not supported bit in AD Flag when discoverable is off
Date: Wed, 3 Jul 2024 13:07:12 +0530
Message-ID: <20240703073712.32149-1-quic_prathm@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cfi7J4BcpeVFZuRoNXA2MKMgAx7BB4EK
X-Proofpoint-ORIG-GUID: cfi7J4BcpeVFZuRoNXA2MKMgAx7BB4EK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_04,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030054

From: Prathibha Madugonde <quic_prathm@quicinc.com>

Fix for GAP/DISC/NONM/BV-02-C
As per GAP.TS.p44 test spec
IUT does not contain General Discoverable mode and Limited Discoverable
mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
case, thus set BR/EDR not supported bit in the AD Type Flag when
discoverable is off.

Test steps:
From DUT, bluetoothctl go to menu advertise
set discoverable to off and then advertise on.
In AD Flags BR/EDR not supported BIT shall be set.

---
 src/advertising.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 5d373e088..e73191c2c 100644
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
@@ -1499,6 +1498,12 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		goto fail;
 	}
 
+	/* GAP.TS.p44 Test Spec GAP/DISC/NONM/BV-02-C
+	 * BR/EDR Not Supported BIT shall be included
+	 * in the AD Type flag.
+	 */
+	set_flags(client, bt_ad_get_flags(client->data));
+
 	err = refresh_advertisement(client, add_adv_callback);
 
 	if (!err)
-- 
2.17.1


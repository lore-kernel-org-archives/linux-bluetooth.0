Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB97145B2D
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165068; cv=none; b=IDCue36Rc9dCGx4E5f+it6Wnh6ECDFS8aBWSspEvBp5caLBttrhXdDgl5Ko9vaigP333yLI//5sKrqPhgqSShoMDLW67yDVXisnD4y1BnBan4g1l4JiL4lH5a0oO9M4Qus3vZs6Tw7tVKxeC7aC3iIXNgOnYLux4qU/+D/cAQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165068; c=relaxed/simple;
	bh=RwZ6xwNRZvSW8JuCNcZduQmksgq9RibVKujkKLfUw7s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M94+C97uh+OPfUFvvmtmYvF6kxM/Sc859m6tD0cx3pJsVwrjMBk8pOCwaKQsKuscNg8yp+nwLqklRU3WCamPGu3psFgcw/g8VMzDd5KWn13E1oC/TaoE9d2x1630OU7ZROv677BPikhiQI+PgXHpr/RLRfys/JGJ0OJf8VckyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pc9R9lvk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pc9R9lvk"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4650gGq2024865;
	Fri, 5 Jul 2024 07:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=HanxEEMa/GOOOAOH+yx2Tq1lF34WV6VTARSOC2s3f3U=; b=Pc
	9R9lvktXXw7FfmMefM9pcKZXKN/qdu2pPyPzk1HOx3AKM1kOph1XDN5sVDQmMCgo
	oWTGrpxe/TpkGSwwI0jiUQzxaRI/gAMda0aqwAcGPGLFd0Wp3HiwzGGNBJUWHQo6
	y2BO6b5WoZAswK7pIKfeb2xXqiCrXH6i9qiHw1ooAkcIcD7hUSQRE27w0PqAnxQN
	wQxXq5DIl37g0kFngm1DAoacuwy7A3PmK2RDvypE+seERxejSTMggLXmbixrBORk
	GZ/QIyv7llhYiarcaBDtvQFXz4AHxb6opmcnFBwvkRW/mCdnMEOW/FEg9pOwCW/N
	WIMWAzo3spRuc8gqiP3Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404yr9djeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 07:37:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4657bWR4013895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jul 2024 07:37:32 GMT
Received: from hu-prathm-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 5 Jul 2024 00:37:30 -0700
From: <quic_prathm@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <pmenzel@molgen.mpg.de>, <luiz.dentz@gmail.com>,
        <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ] Set BREDR not supported bit in AD Flag when discoverable is off
Date: Fri, 5 Jul 2024 13:07:20 +0530
Message-ID: <20240705073720.13504-1-quic_prathm@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uD01CogRnj9ZMc3eQJsdxLIcbmBxq4FR
X-Proofpoint-ORIG-GUID: uD01CogRnj9ZMc3eQJsdxLIcbmBxq4FR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_04,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407050055

From: Prathibha Madugonde <quic_prathm@quicinc.com>

Fix for GAP/DISC/NONM/BV-02-C
As per GAP.TS.p44 test spec
IUT does not contain General Discoverable mode and Limited Discoverable
mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
case, thus set BR/EDR not supported bit in the AD Type Flag when
discoverable is off.

client/advertising.c:
Allowing discoverable property to list in the parsing
function when discoverable is off.

Test steps:
From DUT, bluetoothctl go to menu advertise
set discoverable to off and then advertise on.
In AD Flags BR/EDR not supported BIT shall be set.

---
 client/advertising.c | 8 +-------
 src/advertising.c    | 3 +--
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index a9b865a65..4a98121a4 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -416,12 +416,6 @@ static gboolean get_data(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean discoverable_exists(const GDBusPropertyTable *property,
-							void *data)
-{
-	return ad.discoverable;
-}
-
 static gboolean get_discoverable(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -498,7 +492,7 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
 						manufacturer_data_exists },
 	{ "Data", "a{yv}", get_data, NULL, data_exists },
-	{ "Discoverable", "b", get_discoverable, NULL, discoverable_exists },
+	{ "Discoverable", "b", get_discoverable, NULL, NULL },
 	{ "DiscoverableTimeout", "q", get_discoverable_timeout, NULL,
 						discoverable_timeout_exists },
 	{ "Includes", "as", get_includes, NULL, includes_exists },
diff --git a/src/advertising.c b/src/advertising.c
index 5d373e088..af3ed2b93 100644
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
-- 
2.17.1


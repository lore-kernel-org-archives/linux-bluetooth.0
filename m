Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A0713B5AD
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997580; cv=none; b=UeEK/osNIbUUvbiHHc3d4Y/sLhQp0Cn0JIHYlU1VnezEmlEzHESNCIws4caNJi4w8QzXY/8tqKlXeQQ3hKaS89WUjLCC7t2rIW3ymX+jNaOwuInHI88MrcTeW38uh61ZipSHvOg6TrBdXD0egUw5yFRRVNSS6MWcfSEu1sxIQmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997580; c=relaxed/simple;
	bh=Ozweiy9X2dQRVzZkNtxWdK/B55awqyIx0kPi1gM9ctg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q/iG3R3yuEd4+QS3weEnxVVHtM0U1SVm+dWZ1FoE5mUv+PTEbOUh9tNZujqKPFg2rnOAdXg1dTzGQxp9hW25Y4ktCEXlY/BCpD60G28unDV/AseaMeVoCkZ+C1ZpIddW7kdE98XEK7R2uzQPc6jdCOLz2eFfjSgL+l63LtGvagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k0/QGbVB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k0/QGbVB"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4637rjE1003062;
	Wed, 3 Jul 2024 09:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=nDp/uLGCqjbcbY8xYziMaraRyA8y5LBlSe9GKWfjw8M=; b=k0
	/QGbVBd75iP1ZS6X3ZtdLS96alddDH7c1UaEhzhnXxw6rqBNqoRXRcZvLwrSAGpn
	EjkSiX2/d4xLH7Ir+j/MQQLXQaG2Y7Oz2S6YhjXDDU5hBbV9Q8TS955nMxRpY32t
	wxZMgNyl2tTK+2wH56qsteNOCkycb4abin/mFMtSMtjogMlwOvvgscwV5OYLM370
	MxsG0D6/pVphnUju62TpDUVFiBMrN5PUKrARawlX7KRE74Y3lHzJpVVcz+HXJ6ax
	uU3rfOzCIC1nkUaV04EeFGy/a5LjAbU3jEC0G1gmvmAVwlVjz70w75vd3L/sm02/
	jDcAANcxPK8YrvDdvQKw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029uxg9fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 09:06:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 463967cL007211
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 09:06:07 GMT
Received: from hu-prathm-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Jul 2024 02:06:04 -0700
From: <quic_prathm@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <pmenzel@molgen.mpg.de>, <luiz.dentz@gmail.com>,
        <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ] Set BREDR not supported bit in AD Flag when discoverable is off
Date: Wed, 3 Jul 2024 14:35:49 +0530
Message-ID: <20240703090549.6702-1-quic_prathm@quicinc.com>
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
X-Proofpoint-GUID: wE74rUvCgKI68eey4hCPt5mxW2RdXzeZ
X-Proofpoint-ORIG-GUID: wE74rUvCgKI68eey4hCPt5mxW2RdXzeZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_05,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030067

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


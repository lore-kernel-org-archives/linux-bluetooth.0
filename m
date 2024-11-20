Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D31C82F3
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114177; cv=none; b=EyUDwp/AxSXe9MbA6PUb/bB3ay6P82R6L7EP2Ai7sJu700iEVbrnJWIG6OOc/WYuYlLKoP8obDQCm6LkyvLN98uhWtVRFGZe1iNTCspeeJsk43MTAs14vVBDrrdzes1fuXc4LpsmWJ1couH3NvMWHsB0Qs4E+cejGDzWeRPndYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114177; c=relaxed/simple;
	bh=z5oD9wU0rcMRGryzXaBp7X4sZ3RFZQg3VKWFsJ6d6SI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RffLjGW8da2QOdrQ6SQBy35lKaLOtFZzD4MKF6kdkDgJcr6TcnmCmoVhDqaz+my+UBV/TpTF7iNbf9JbEjCL1MgtZeg+5vdjTCV4kNxPAP3TyH/1zn8dtY0cWrTDrofKsgIGY8I4B2w5w6LjsgcHqQy+6rcJY0fZAB3B5jPbAyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hrd5k8KO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hrd5k8KO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK9FRHb010571
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 14:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=CJTBiRLB/9PQmB2uh7zrNawjuWhh3TYopCjbkE7mrTE=; b=Hr
	d5k8KOnBDAaqqCJnpL5POF8SKDaW1ybaOCnc1acnErvGc9ykqTfY0RzVmOcGuc80
	o109HcFr8MJweLYEg8/CrfLGOlW0Qjou60jDUH2u3o2V0SXPibcJ783fToJt1SMX
	Mb+qEnvbyNvlw51ZdGKjtpovyP+RBKVWmQWPjddk+ZyFehehjc6GmVByjPkn3+43
	mmfsDyYnY+b+9xrSRsfMr0221/Gx7dIoVzkwnOt2mSsLE7gxwN5ybtGmfkw4UKps
	vJhO3mldEH1bK2SPeoGHFpeJn5hzg92HM/50QkRSCXj7TGl19lpntWOP4s73y69l
	LCG1QryuE3pnMwTEo1nw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43091me5g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 14:49:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AKEnXcS008307
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 14:49:33 GMT
Received: from hu-prathm-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 06:49:31 -0800
From: <quic_prathm@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ] Fix for broadcast mode, not to add any AD flags in advertise Data
Date: Wed, 20 Nov 2024 20:19:18 +0530
Message-ID: <20241120144918.11991-1-quic_prathm@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ULz_0Zcr4Sze9ibRmnI3ixl42BJ1LG_0
X-Proofpoint-GUID: ULz_0Zcr4Sze9ibRmnI3ixl42BJ1LG_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 mlxlogscore=627 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200098

From: Prathibha Madugonde <quic_prathm@quicinc.com>

src/advertising.c
Include check for broadcast mode:
Need not set flags in AD flags of Advertise Data

Test steps:
From DUT, bluetoothctl go to menu advertise
secondary 1M/2M
name on
back
advertise broadcast

---
 src/advertising.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index bd121e525..2fc6f917d 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -759,10 +759,15 @@ static bool parse_discoverable(DBusMessageIter *iter,
 
 	dbus_message_iter_get_basic(iter, &discoverable);
 
+	/* For broadcast mode, need not add any flags
+	 * just return true without adding flags.
+	 */
 	if (discoverable)
 		flags = BT_AD_FLAG_GENERAL;
-	else
+	else if (client->type != AD_TYPE_BROADCAST)
 		flags = 0x00;
+	else
+		return true;
 
 	if (!set_flags(client , flags))
 		goto fail;
-- 
2.17.1


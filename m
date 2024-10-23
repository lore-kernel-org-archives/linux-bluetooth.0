Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CDD15278E
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667710; cv=none; b=J3OsNCP7VYHawGeGsrkS6Sps9ja1aHp96E2kD9KCYhvRe+bALoiwuVJBMqau0m+zma1BmHXuZObtFMzBqvK5q4vFl1n+fbIliR5TR8b+w27DGjNL2/1rB//EdXApTvdD1PfwbIpvsRkoa+qhwZnCqo1/iSExdj/As/aqSOfYWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667710; c=relaxed/simple;
	bh=fh4Ry0zen4MSQUpJrRoV+7QbgBY7mctCHQoPyGq88zA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=niszg5hsoGW2JmaoGuVmAmb/Ee/2KEoxmM3ISOM5Eid0ST5gMBJimg2n50P2mJavtA0EjcgI0g6a4X3c8XbJCqT9Ootj1LjkWs4oesxwHUuHZymVcpeEr+zuQosg+eQaiLSe+TdgeE58JlDQfaKpCf1gHBgc4uDiU8ziki28c4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ieB3r7W+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ieB3r7W+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLbIO1029582
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 07:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KW7AyA0HGRA6NGcGh+d1Xm
	tRAJf1+dyCO/bEHyTBGac=; b=ieB3r7W+0UuYgP29blrsPSm4rGrr1oRq/Cvbjr
	iAkbXKiWDdQzMLRTHSHC7wQEichGIXmNj5MWOkS3Lzc3zLo0Zk977vIzOZxB5nk3
	MqukV5jPRjrOHa/APa28BUp78S4V4b6D5yojprgBNHsBBKv2UBbITVQ5ik49iC3U
	xojbMDCA+4yQLcnxcx/WvHOXMRa+1ylwTZaA3ihQ4qI55IBT+CzA1/KYcuXIh8Vz
	QGTktM8TCK+DQeLjN81Nj37Jdzj/RoWSidFlWJVMsGoUaUHLPcqgZ7t4bBfZibJC
	z+YzlMbsnjA2hWz3gaaP8f7nnIpvRDG+fkWxj76FkO44v3CQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em41s6tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 07:15:07 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N7F6sk010314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 07:15:06 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 23 Oct 2024 00:15:04 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v3] obex: Resolve SRM issue for PTS testcases
Date: Wed, 23 Oct 2024 12:44:48 +0530
Message-ID: <20241023071448.1017724-1-quic_amisjain@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zUkl0F9dvqbmQNRtYk5wrbjqDNfI377I
X-Proofpoint-ORIG-GUID: zUkl0F9dvqbmQNRtYk5wrbjqDNfI377I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=967 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230044

Add check for unknown/undefined srm value.

This fix is required to pass the below the PTS testcases :
1. OPP/SR/GOEP/SRM/BI-02-C
2. FTP/SR/GOEP/SRM/BI-02-C
3. PBAP/PSE/GOEP/SRM/BI-05-C

Description - Verify that the Server ignores a SRM header with an
invalid value in the PUT/GET request and carries on with the
PUT/GET operation with SRM disabled.

Current Behaviour - Server is sending SRM enable in the response even
though receiving the unknown SRM value.

To fix this, I have added the check to verify the valid SRM values
before continuing with SRM enable.

---
 gobex/gobex.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 40d6b8129..07e46627a 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -317,6 +317,15 @@ static void set_srm(GObex *obex, guint8 op, guint8 srm)
 	struct srm_config *config = obex->srm;
 	gboolean enable;
 
+	switch (srm) {
+	case G_OBEX_SRM_ENABLE:
+	case G_OBEX_SRM_DISABLE:
+	case G_OBEX_SRM_INDICATE:
+		break;
+	default:
+		return;
+	}
+
 	if (config == NULL) {
 		if (srm == G_OBEX_SRM_DISABLE)
 			return;
-- 
2.34.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1114D703
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912950; cv=none; b=dtV1EX/mOgybhBvYGYd0LeDpqKQ35tFW2rZq4RgFNxqRYG6nJuH8iwTD46Q3gdq+a0yneDIVCBXLScsGaK9dA4AD+LqAWTxaU+gRhAANWYMyA5CeiXPr1f2DgaSubiK7Qk48Q8hbGdJD/LU0H2lMqwSMqFTmBxthAZD3Y3PdkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912950; c=relaxed/simple;
	bh=TfeygqpfV9gcIgOV9aTqSpdjwORKMHd1IivGtWTPRww=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Aiwj2VmGH1AHLPZ0obs05HUOfIK86z8ZpNaifFowCbQqeejyXACxRgtZ3HnW0nykOd0Q5/NpIWsJ0uMUSIhUAbHVgKNExauu1n24RWbN5ZmWT6qZa+aRwXeWXZVvLPrMNjj18cVoXJS1RHOV/LnM7OPzoCSe1qBMQTEt+T4vsBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nsCA6Xel; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nsCA6Xel"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4628nYng010897
	for <linux-bluetooth@vger.kernel.org>; Tue, 2 Jul 2024 09:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=9rBaxdoDcWLEhSA8bc51i3khqasm0fRDmX0K7XlO5MY=; b=ns
	CA6XeleUMBwYJp70zCvSWcMCRaOMYxzyNZ9kfj9YvMG1mjt8dfn9JDOGppEMbJQW
	oEUr7+rycjLS5uMdmyMWDvngPWuUJfKGUvWN/vqMZDyPo2YLqRVdC188THusV0ri
	nFo6Dvazhgkdv+bheOumE6F7vvMj00+JB79X5I9LhgRJLvKlQ/nkG7LQLJPWO3tG
	RgR4LmxS9LKzSxTjZh2a7bO517+lBwdKssNbtNB+zAzEOykLkFO+cI3g2Qff3mil
	qIdMjZFY3q1YNr/TpRGE9zJyEa57oiGGTSRaNf6dki5ZE6Q0bSR56jMqlnAtxoCZ
	OQndAcX/owLtIssb0n9g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 403kj8v61u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 09:35:48 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4629ZlGP003228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 2 Jul 2024 09:35:47 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 2 Jul 2024 02:35:45 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH BlueZ v4] obex: Move size emit signal to plugins instead of obex.c
Date: Tue, 2 Jul 2024 15:05:23 +0530
Message-ID: <20240702093523.12158-1-quic_amisjain@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pZORwO-UdhUqdrsVcYsoKYpe0gjmsSez
X-Proofpoint-ORIG-GUID: pZORwO-UdhUqdrsVcYsoKYpe0gjmsSez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=937 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020072

Instead of emitting the property "Size" from obex_put_stream_start(),
Call the function manager_emit_transfer_property() from plugins/*.c
wherever plugin has transfer object present.
Remove the code from obex.c which is generic for all profiles.

This change resolves the type mismatch issue when calling the
manager_emit_transfer_property from obex.c. We are passing
'os->service_data' of plugin session type but the
manager_emit_transfer_property() expects the 'obex_transfer'
type, therefore size is not set properly and might cause
crash/disconnection.

---
 obexd/plugins/ftp.c | 3 +++
 obexd/plugins/opp.c | 3 +++
 obexd/src/obex.c    | 3 ---
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
index 874fe2b8b..9e52e397d 100644
--- a/obexd/plugins/ftp.c
+++ b/obexd/plugins/ftp.c
@@ -175,6 +175,9 @@ int ftp_chkput(struct obex_session *os, void *user_data)
 
 	ret = obex_put_stream_start(os, path);
 
+	if (obex_get_size(os) != OBJECT_SIZE_DELETE && obex_get_size(os) != OBJECT_SIZE_UNKNOWN)
+		manager_emit_transfer_property(ftp->transfer, "Size");
+
 	if (ret == 0)
 		manager_emit_transfer_started(ftp->transfer);
 
diff --git a/obexd/plugins/opp.c b/obexd/plugins/opp.c
index 777f5f8ed..4b621373c 100644
--- a/obexd/plugins/opp.c
+++ b/obexd/plugins/opp.c
@@ -87,6 +87,9 @@ skip_auth:
 
 	err = obex_put_stream_start(os, path);
 
+	if (obex_get_size(os) != OBJECT_SIZE_DELETE && obex_get_size(os) != OBJECT_SIZE_UNKNOWN)
+		manager_emit_transfer_property(user_data, "Size");
+
 	g_free(path);
 
 	if (err < 0)
diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index 98d6245a4..370bfac9e 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -716,9 +716,6 @@ int obex_put_stream_start(struct obex_session *os, const char *filename)
 		return err;
 	}
 
-	if (os->size != OBJECT_SIZE_DELETE && os->size != OBJECT_SIZE_UNKNOWN)
-		manager_emit_transfer_property(os->service_data, "Size");
-
 	os->path = g_strdup(filename);
 
 	return 0;
-- 
2.17.1


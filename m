Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B903BBEA
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719211012; cv=none; b=OStvWIcZUISAWOXhGkr0IgLVQ/EW3EawUnINg7/jucoGxXK+Y6mECiRFOBUS0DTm+dadcU/T9zSnj0K8NcNPeGJeG6vfG1VzchGG+I1gZVqXg39IRn9U0+v3nageqfC/BTdsYk7vdPWR1QZRua6QBD2GBVP7ldnel3DdXFENH+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719211012; c=relaxed/simple;
	bh=oijnihKwuJT3tr30MBmubxxP3bLVeP31JcDdPJqsIZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DMVcBZ7W+XbnWN6MP8TSdO0GIcbZwEsezvh2xKN79tDpWzNNMQREnouCW8BOg6H1WQVOikEjSjrwqGf7+JTB2otRmABYNNRrLnfaCbNwmUOpXEBfTYYW2pcJmgtRQO7C8BGDW24CIuVVsoEF9r4nTSVpQaT/mhnNI2e/CcBRBVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UwIox/rH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UwIox/rH"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NLwlq2018992
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 06:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=xyXJwTJ4a8hmn5nsi6AbA8FMRE4l/nAWPW6odwsHTJk=; b=Uw
	Iox/rHr8pAm/RlylnbQgH63eU7PTEvrI+3GctODJ9OBulabrl4YPu5uMZOqRkl9j
	qbZNSnGuixMaxNhOWfLjqSP/po6AkyIf79SVzjgEbRDbBmq5AJGTVgWCcl4bfiPZ
	Y3fR3tXWvyib9xd1NEH918QJKchgNahtOsetp9r6Jp5rGokjR4HEtyLz2O//SS8T
	F2MCroU9sVALqIMgbVh9ySSCXca/gMiC4Frj25kvYnPfq+JwO5sWkX1X4mBwZYV5
	ELeJs5Ig3wZAEJxsVYpdDyPyEyyEFYsXIcaCrRX9KXJ0nQ6JUQOlyqQJmoNo+vFn
	VxRCAhF1+hHSHSK7YD1w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywmaeu20n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 06:36:50 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O6an59030036
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 06:36:49 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Jun 2024 23:36:47 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] Bluetooth : Update the mas session structure
Date: Mon, 24 Jun 2024 12:06:27 +0530
Message-ID: <20240624063627.22705-1-quic_amisjain@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _d_QS0bO87in1CO1i6jRXVQ_3XfQh4tx
X-Proofpoint-GUID: _d_QS0bO87in1CO1i6jRXVQ_3XfQh4tx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_06,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240052

Update the 'mas_session' structure such that manager_emit_transfer_property(os->service_data, "Size")
will get the proper structure in arguments as expected like structure 'obex_transfer' and transfer->path
won't be populated with inappropriate value.

As there is no new tranfer registered during mas connect, hence setting the path to NULL
to avoid invoking the g_dbus_emit_property_changed() property.

Signed-off-by: Amisha Jain <quic_amisjain@quicinc.com>
---
 obexd/plugins/mas.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
index 10b972d65..71bf12ad3 100644
--- a/obexd/plugins/mas.c
+++ b/obexd/plugins/mas.c
@@ -51,6 +51,8 @@
 #define ML_BODY_END "</MAP-msg-listing>"
 
 struct mas_session {
+	uint8_t notification_status;
+	char *path;
 	struct mas_request *request;
 	void *backend_data;
 	gboolean finished;
@@ -59,7 +61,6 @@ struct mas_session {
 	GObexApparam *inparams;
 	GObexApparam *outparams;
 	gboolean ap_sent;
-	uint8_t notification_status;
 };
 
 static const uint8_t MAS_TARGET[TARGET_SIZE] = {
@@ -125,6 +126,7 @@ static void *mas_connect(struct obex_session *os, int *err)
 		goto failed;
 
 	manager_register_session(os);
+	mas->path = NULL;
 
 	return mas;
 
-- 
2.17.1


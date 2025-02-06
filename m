Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4DC226555
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Feb 2025 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835189; cv=none; b=P+hQ62p4AkyNiC70ZqBTGvR7JFkBJIiTN1A69Sq9BS4RjUfatpEadygLf3swWHY1uIf009lMy8IWRO/btVnwEhE8nZHzM5Q6BrfP6wC8PgzG107zQu4I2DtsI0sGjurTONavqykFhO5+XAkIh/yoFrCslE1wuMQKetWQ2gd4WB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835189; c=relaxed/simple;
	bh=pG7aXjV4oM6kd0nE7GkMdWeIpj/Sadbq3vRYz0h412A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KSl68P/Rgv1y4a4LFdhfBf0pO8WNcBYwfsbCBetskisO/Yh3Bl1s7tx7R75hmzL6R87rcMsS2AildALM82sfHDLikMxskvHJfKlIpakoFkjhRTRFF02d7LmgI09U/l+U4LAottSSN8Hj2lTvvM+QIHzseAK9dcoVwfOzeTqdZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aiRZOl06; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aiRZOl06"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5168bSh8014547
	for <linux-bluetooth@vger.kernel.org>; Thu, 6 Feb 2025 09:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zYONKpFdnF2B9OoKrPjx8r
	g1F1ndid4Y62nJg2HN3Jg=; b=aiRZOl06JIbQq8dcEVusjhUsNi+44Vekh4f8m/
	csg4+F/mw25y0RgYw/yxxlUf7hAc+9F48qv0QTjqC+Rk0m01nr4vGVil3cVlm2EZ
	73gcjEAt54L7TtJOzMRRp0igASiwP8jL1f0HpBOcYkYEDzOKG1E8aT09flwb/1IQ
	IAwz12fTgpMhzK5YZNDDc+mXGUrwDf1pt/g9DdWnmC9rE9vRSNBWMvWXwS1BrsiH
	l5x72Lx716fR0nPNCu9ChaGxSzeFRfeZiZTGccEzGXUYzJuSvS/xF25ronE6R5Xp
	m35Sub0VFzLh4/miaBVHzlLOszmZzftsciuOld4EYLhVrIsg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44msr10618-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2025 09:46:26 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5169kQSw003589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 6 Feb 2025 09:46:26 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 6 Feb 2025 01:46:24 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Add messages_get_message() implementation for MAP plugin
Date: Thu, 6 Feb 2025 15:16:02 +0530
Message-ID: <20250206094602.1847003-1-quic_amisjain@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AHCxzNkWIVJyp1qV6Ajy8R1E93gJZJvY
X-Proofpoint-GUID: AHCxzNkWIVJyp1qV6Ajy8R1E93gJZJvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_02,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=822 clxscore=1015
 mlxscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502060080

GET Message() operation should be supported for passing below PTS
testcases -
1.MAP/MSE/MMB/BV-12-C
Verify that the MSE can return an email message to the MCE.
2.MAP/MSE/MMB/BV-13-C
Verify that the MSE can return a SMS message in native format to the MCE.
3.MAP/MSE/MMB/BV-14-C
Verify that the MSE can return a SMS message with text trans-coded to UTF-8
to the MCE.

---
 obexd/plugins/mas.c            |  4 ++--
 obexd/plugins/messages-dummy.c | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
index 10b972d65..f63fcf6c6 100644
--- a/obexd/plugins/mas.c
+++ b/obexd/plugins/mas.c
@@ -612,11 +612,11 @@ static void *message_open(const char *name, int oflag, mode_t mode,
 		return NULL;
 	}
 
+	mas->buffer = g_string_new("");
+
 	*err = messages_get_message(mas->backend_data, name, 0,
 			get_message_cb, mas);
 
-	mas->buffer = g_string_new("");
-
 	if (*err < 0)
 		return NULL;
 	else
diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
index e313c6163..8922b641d 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -516,7 +516,37 @@ int messages_get_message(void *session, const char *handle,
 					messages_get_message_cb callback,
 					void *user_data)
 {
-	return -ENOSYS;
+	struct session *s =  session;
+	FILE *fp;
+	char *path;
+	char buffer[1024];
+
+	DBG(" ");
+	path = g_build_filename(s->cwd_absolute, handle, NULL);
+	fp = fopen(path, "r");
+	if (fp == NULL)
+	{
+		DBG("fopen() failed");
+		return -EBADR;
+	}
+
+	/* 1024 is the maximum size of the line which is calculated to be more
+	 * sufficient*/
+	while (fgets(buffer, 1024, fp)) {
+		if (callback)
+		{
+			callback(session, 0, 0, &buffer, user_data);
+		}
+	}
+
+	if (callback)
+	{
+		callback(session, 0, 0, NULL, user_data);
+	}
+
+	g_free(path);
+	fclose(fp);
+	return 0;
 }
 
 int messages_update_inbox(void *session, messages_status_cb callback,
-- 
2.34.1


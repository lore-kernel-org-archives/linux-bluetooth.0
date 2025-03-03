Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B3218AB0
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026260; cv=none; b=CwLjvJ+dkpUYnqTteKA23x2xxhQYeRk7GZ1WQH/LIYXEJgzmtsN85IQfhGThlj7bR1DbniKnmcmA9ELYi8FVW0tdd8U1+7cHMrmf6znqUGKkvDThpeYw35/J8kwbmn2cWAOUXC0Fr2VEdH3mw3gYqpNrTG3e7MWJBckRYRmat7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026260; c=relaxed/simple;
	bh=38+ZPQd8fXpvw5CmVcnRw6HAFcdNY+6Xa5Hmn/FQ3Y4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W8zyv6ZIq1QOENPiq3jVVvwEeyTJxrf1WPlPiPbSTu+5cl71VgNGb113TsBelCsYGJ0YhIGiS9d37YpuPsZ2xbH6ZSBSjzDezpTBHKkr5gG5HFM4d8iE7BxzdJ9u/d6ewzAXSMQv1IfKO7qnc4AmCkSCDn9IquvrgnXHKgZ6eNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pgXiprzN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pgXiprzN"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523B75BE007314
	for <linux-bluetooth@vger.kernel.org>; Mon, 3 Mar 2025 18:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zqnKOu7G9fs4VY/Y6oFsf0
	EAZeQYJPqRtyDksidzDtc=; b=pgXiprzNPOkE6lAbdkdsgETOfBH8oImkwvGVp2
	XnkOJ2tAyT7nmDPyVXIfDbUJOjaStVc23bXofOg7oZmS855YQgohYVz0hz4lSpCz
	fVLe7iayGoOtEenhiJC+R14svfnDirvUeVwVrIbRbuiZ0B73slF8cGSkKHurAmkM
	TEx9Jmy1k5AMfWQDJRPp8oX8TfanOR5i4jTi+8V2jw/GvYRNR7/1JeaeWNgcUb/u
	tHqL+RFJyJExmDV2HNNJc/8SrK2MDl5D0PnOX6CHWxOFqjPyefnzNCm8rprE88d7
	rt+C3EQG/69mM6O28RI4/r9YjZsDGyiIoPxeu8nO2kLGv3Uw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453uh75grw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 18:24:17 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 523IOH1s002440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 3 Mar 2025 18:24:17 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Mar 2025 10:24:15 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v4] obex: Add messages_get_message() implementation for MAP plugin
Date: Mon, 3 Mar 2025 23:53:59 +0530
Message-ID: <20250303182359.4081049-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-GUID: YV4EvRfeXy2zX_o4VwGSdxRvyZGeL7G3
X-Proofpoint-ORIG-GUID: YV4EvRfeXy2zX_o4VwGSdxRvyZGeL7G3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_09,2025-03-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030140

GET Message() operation should be supported for passing below PTS
testcases -

1.MAP/MSE/MMB/BV-12-C
  Verify that the MSE can return an email message to the MCE.
2.MAP/MSE/MMB/BV-13-C
  Verify that the MSE can return a a*n* SMS message in native format
  to the MCE.
3.MAP/MSE/MMB/BV-14-C
  Verify that the MSE can return a SMS message with text trans-coded
  to UTF-8 to the MCE.

Currently get message operation is not implemented, hence above
testcases are failing.
Added code to send the complete bmessage in response to the get() request
for the requested message handle.

As per suggested in previous patch, mmap() is being used
for reading file.

---
 obexd/plugins/mas.c            |  5 ++--
 obexd/plugins/messages-dummy.c | 47 +++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
index 10b972d65..bf8d689ad 100644
--- a/obexd/plugins/mas.c
+++ b/obexd/plugins/mas.c
@@ -408,6 +408,7 @@ static void get_message_cb(void *session, int err, gboolean fmore,
 	}
 
 	g_string_append(mas->buffer, chunk);
+	mas->finished = TRUE;
 
 proceed:
 	if (err != -EAGAIN)
@@ -612,11 +613,11 @@ static void *message_open(const char *name, int oflag, mode_t mode,
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
index e313c6163..bb6431069 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -18,6 +18,8 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
 
 #include "obexd/src/log.h"
 
@@ -516,7 +518,50 @@ int messages_get_message(void *session, const char *handle,
 					messages_get_message_cb callback,
 					void *user_data)
 {
-	return -ENOSYS;
+	struct session *s =  session;
+	FILE *fp;
+	char *path;
+	char *msg;
+	int file_size;
+	struct stat file_info;
+
+	DBG(" ");
+	path = g_build_filename(s->cwd_absolute, handle, NULL);
+	fp = fopen(path, "r");
+	if (fp == NULL) {
+		DBG("fopen() failed");
+		return -EBADR;
+	}
+
+	if (fstat (fileno(fp), &file_info) == -1) {
+		DBG("Error getting file size");
+		fclose(fp);
+		return -EBADR;
+	}
+
+	file_size = file_info.st_size;
+	char buff[file_size+1];
+
+	msg = (char *) mmap(0, file_size, PROT_READ, MAP_PRIVATE, fileno(fp), 0);
+	if (msg == MAP_FAILED) {
+		DBG("Error mapping file");
+		fclose(fp);
+		return -EBADR;
+	}
+
+	fclose(fp);
+	strcpy(buff, msg);
+
+	if (callback)
+		callback(session, 0, 0, (const char*)buff, user_data);
+
+	if (munmap(msg, file_size) == -1) {
+		DBG("Error unmapping");
+		return -EBADR;
+	}
+
+	g_free(path);
+	return 0;
 }
 
 int messages_update_inbox(void *session, messages_status_cb callback,
-- 
2.34.1


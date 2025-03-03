Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FC2139C6
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014270; cv=none; b=hBC0eLA3SVwOUY3Q9al3xPHU4vBusQRjq7uXwIGPmU3k4hPzkhSw/jm25bb1X30CFWrfHI2luxqoBD+umuFkA5J4f13MudDM42O+ZpCtYh30v/JMdCWSrc2QK6oxSKFAD+4My4Gj8ghS/os+KHgNlM0hbCmm6hSFHNRyZIgablo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014270; c=relaxed/simple;
	bh=mj6G+kupzvx5j8cNP1rSKX3LPBsyWoWcQrBxOYBd+Mk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FHZZkH3OkWpSI5LEP7svJG/G8rE2U6OGrfN/bvaFFmhgRzsqtRwLQddYDJadzJR7md8jBogrNgfw2zpStVXALpRwjctwtXRVFJoy5MEVGHKEKWWEnSzEQt7pGCWD0nY0E8F3j7P12qAG6ZLwPsHa1A+EahrZKfbDlNnCPBN8/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QtkyYflZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QtkyYflZ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523AmNWI011628
	for <linux-bluetooth@vger.kernel.org>; Mon, 3 Mar 2025 15:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=i9Nr5U34mZkZdQIAvsOBk9
	2lVnYOQsIHomuncg5nv38=; b=QtkyYflZfLADeMekBVumyRhCs0MKg020K+XOzD
	ySzuOqo1iDfkHAySMaIu/yzkZ7t06gLQjnOlSTniMYVrdnBQ2VIFIklDfUXF/BkE
	pnnIncnu7QfGUhMd+sfbYMIpb9aD+1R8Jnfm+1i6G6s5RElM6uZRCE07GM7l73hf
	wUBCmDC0+aomGmYfle6oL9Zx3H3Af8n8WM5HuwXbI01aHUFp2+uO8pcnry9louuv
	p3oNCffKrZgUKPDss+bzU2CbueVWiaMAMQfI2KRgcts5zg5voWGk66V/axkA+Oer
	3ZwgRhM1C/Ol2/bmVkw15BWk8hSSoRuQaFVcNLhc8qH0K0Uw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tm5n98j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 15:04:27 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 523F4QGb026923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 3 Mar 2025 15:04:26 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Mar 2025 07:04:24 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v3] obex: Add messages_get_message() implementation for MAP plugin
Date: Mon, 3 Mar 2025 20:34:09 +0530
Message-ID: <20250303150409.3850394-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Q95ScVt53fwFhWnPYd9lxOruA-9ORJsY
X-Proofpoint-GUID: Q95ScVt53fwFhWnPYd9lxOruA-9ORJsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030115

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
index e313c6163..68fa578a8 100644
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
+	unsigned char *msg;
+
+	DBG(" ");
+	path = g_build_filename(s->cwd_absolute, handle, NULL);
+	fp = fopen(path, "r");
+	if (fp == NULL) {
+		DBG("fopen() failed");
+		return -EBADR;
+	}
+
+	int fd = fileno(fp);
+	struct stat file_info;
+	if (fstat (fd, &file_info) == -1) {
+		DBG("Error getting file size");
+		fclose(fp);
+		return -EBADR;
+	}
+
+	int file_size = file_info.st_size;
+	char buff[file_size+1];
+
+	msg = (char *) mmap(0, file_size, PROT_READ, MAP_PRIVATE, fd, 0);
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


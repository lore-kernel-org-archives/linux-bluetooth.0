Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1484F1F150D
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089556; cv=none; b=eKI87UGdBsUIV5z3YnPcATrmolDGE10bQ3bc5yTC+2OCsOAj+dKGWyDRCJC9hbD6GxtZ3ftAdRqzBgaLdJst+85t0o7HrUJRuRM0x2LQrS8aUSso4bvruGtjb23FrNrOfzDcDEGYBlNkMnIuewdtbbY73FtBTq35v6WKP4izj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089556; c=relaxed/simple;
	bh=d9elx+CxZCKY8KbWeycMxGIzVfox84TT+npwdU0LXJM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LGhUoTjNNbvk4i4hgkdtVVkXt04Fy+XupPPxN3N0dh5uvc8CA13CntuSCBJ/95+5Z3gLJyNl36Pm4dSbpWjkNnvod0LCDh0EtUW825zhd+FM65bNJlR4xpAOwSsK8Jb8cp2WuA54KCP9J+pNq71Z9v66mzGhtPa0+8dU49SQXjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=av8pnWqm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="av8pnWqm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524AB2gn019820
	for <linux-bluetooth@vger.kernel.org>; Tue, 4 Mar 2025 11:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eDYMMkZ29womuhofnnHXUK
	+ewzfxxgDZcGI66RSCmOk=; b=av8pnWqme+fFcESnFMY55uxDYBZiq69g3lr8dD
	iIWyWBMuCBo7s5ySstKZZgOu3izmaxWRQzaUJQ2FeN1/5HBIBFzzkXkCKKABYOVJ
	IPw9Lcq1nNllGWFJAA0048OxwwvaMKfXCSMPP4dKLiqgYNHQUkIV37FQVf0Y78hr
	CCTFDmj7bmmpGRVmgLuqDBciaGKlrk+VKyCTKUDceGC3X/gCNulb2sUjUotSiXmM
	H2LcFkLVzlqq3DqLyhjP2Xdcvg3dYp3IhZ6UdzANApWSwfVkfwtziCHRAjMYTNDM
	AGZ2JyYEknNQQMGrIjEh5bj5OHExsBICDxXlvM1a7M5HNnRQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t1rf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 04 Mar 2025 11:59:13 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 524BxCZW032085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 4 Mar 2025 11:59:12 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Mar 2025 03:59:10 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v5] obex: Add messages_get_message() implementation for MAP plugin
Date: Tue, 4 Mar 2025 17:28:56 +0530
Message-ID: <20250304115856.1511495-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-GUID: ekdgn2v0SkpFi01V3MQQ0VxgYTkt10u7
X-Authority-Analysis: v=2.4 cv=KfMosRYD c=1 sm=1 tr=0 ts=67c6eb11 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=oSRza-aUkO-rDw8YJewA:9
X-Proofpoint-ORIG-GUID: ekdgn2v0SkpFi01V3MQQ0VxgYTkt10u7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040099

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
 obexd/plugins/messages-dummy.c | 53 +++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 3 deletions(-)

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
index e313c6163..491203a97 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -18,6 +18,8 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
 
 #include "obexd/src/log.h"
 
@@ -516,7 +518,56 @@ int messages_get_message(void *session, const char *handle,
 					messages_get_message_cb callback,
 					void *user_data)
 {
-	return -ENOSYS;
+	struct session *s =  session;
+	FILE *fp;
+	char *path;
+	char *msg, *buffer;
+	int file_size, err = 0;
+	struct stat file_info;
+
+	DBG(" ");
+	path = g_build_filename(s->cwd_absolute, handle, NULL);
+	fp = fopen(path, "r");
+	if (fp == NULL) {
+		DBG("fopen() failed");
+		err = -EBADR;
+		goto file_open_err;
+	}
+
+	if (fstat (fileno(fp), &file_info) == -1) {
+		DBG("Error getting file size");
+		err = -EBADR;
+		goto mmap_err;
+	}
+
+	file_size = file_info.st_size;
+
+	msg = (char *) mmap(0, file_size, PROT_READ, MAP_PRIVATE, fileno(fp), 0);
+	if (msg == MAP_FAILED) {
+		DBG("Error mapping file");
+		err = -EBADR;
+		goto mmap_err;
+	}
+
+	buffer = (char *) malloc(file_size * sizeof(char));
+	strcpy(buffer, msg);
+
+	if (callback)
+		callback(session, 0, 0, buffer, user_data);
+
+	if (munmap(msg, file_size) == -1) {
+		DBG("Error unmapping");
+		err = -EBADR;
+		goto munmap_err;
+	}
+
+munmap_err:
+	free(buffer);
+mmap_err:
+	fclose(fp);
+file_open_err:
+	g_free(path);
+	return err;
 }
 
 int messages_update_inbox(void *session, messages_status_cb callback,
-- 
2.34.1


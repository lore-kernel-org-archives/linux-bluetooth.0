Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A81EC00F
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041050; cv=none; b=dYLCIlJZv9KhdVx9krNxck0nb/15ixSJhcrrDJ19oTVoPavlj7VRoF3kruPBteCChZo1rgCnaEqBhX56CrrGbhyf53YDo7eWsmRVgJMqNSLIiwAXBD162/dbjk0Zt32tCSYx7DXTxSWKLgqvVPXTcQ+10HZiIfXEc5P4kIvh8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041050; c=relaxed/simple;
	bh=/GkaB8yWqRWHcyJMrmESw+hukVF82TRyFKnjj6xh2gM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C2f3BDUDN+G/sV+VJKE2JfYSBAGOGOLA0/xnvNHvUTnBkK4tenb24chLnQTf7xBG4jfz06E+f+gyO2B6H2Z7ToAzCl7g+Ft85LIuIOZyhSu5pYnARdQsk0FP8tp5rRX91XMnRcE8UVYCdE4fatWL2vSsoA5zleX1an6nu2CwF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fJD6cKu3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fJD6cKu3"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6i06n001826
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OJoBV+NqdQeEJVT0aSIx2g
	NfMi5/rnE5XEt4Sv8D6uY=; b=fJD6cKu3tzIRbCLX9BYYhi1ECSKCVywWGWfRej
	8/BIpD1Pp8rPcDtOfCvWH4T+eOVtPslucJKnK0b6mDPjt0aZIGoyJnoFKMuLn/H0
	7zgs/okAvMAF9XVbFdmGwDO721hr01xcKgoFVQX78sOk/WResLY7ItTl6KmroDnD
	bAh8w5hWcpk2QyikLryTPoqkSpekWndo95vmMjOjrL52CZ63deP4IWHWITnDAklN
	rTYmVb6qOtLew95QglkxjsySEpaTfFpZxAroYID6lcDAs+K0Yb52/QW4mX0zlqQz
	3MNHnXYnoWzd5sEnOR4Uk/5DkSqxeNLV0xKiCKQ6vXj4JUfQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy2dg5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:44:07 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K8i6FO004234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:44:06 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Feb 2025 00:44:05 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v2] obex: Add messages_get_message() implementation for MAP plugin
Date: Thu, 20 Feb 2025 14:13:49 +0530
Message-ID: <20250220084349.466770-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ouvzdx472maFsHhiCP7cMHo0jeAl0O7X
X-Proofpoint-GUID: ouvzdx472maFsHhiCP7cMHo0jeAl0O7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=940
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200063

GET Message() operation should be supported for passing below PTS
testcases -

1.MAP/MSE/MMB/BV-12-C
Verify that the MSE can return an email message to the MCE.
2.MAP/MSE/MMB/BV-13-C
Verify that the MSE can return a SMS message in native format to the MCE.
3.MAP/MSE/MMB/BV-14-C
Verify that the MSE can return a SMS message with text trans-coded to UTF-8
to the MCE.

Currently get message operation is not implemented, hence above
testcases are failing.
Added code to send the complete bmessage in response
to the get request for the requested message handle.

---
 obexd/plugins/mas.c            |  4 ++--
 obexd/plugins/messages-dummy.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 3 deletions(-)

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
index e313c6163..665face3f 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -516,7 +516,32 @@ int messages_get_message(void *session, const char *handle,
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
+	if (fp == NULL) {
+		DBG("fopen() failed");
+		return -EBADR;
+	}
+
+	/* 1024 is the maximum size of the line which is calculated to be more
+	 * sufficient*/
+	while (fgets(buffer, 1024, fp)) {
+		if (callback)
+			callback(session, 0, 0, (const char*)buffer, user_data);
+	}
+
+	if (callback)
+		callback(session, 0, 0, NULL, user_data);
+
+	g_free(path);
+	fclose(fp);
+	return 0;
 }
 
 int messages_update_inbox(void *session, messages_status_cb callback,
-- 
2.34.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8B28F3
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504710; cv=none; b=FMIQrCxHmD8uycCyVa1yb+Z77sBRlkcD+bzY95+yfayXSCtbK0a8SOS5LDeR4+VesOs0hYHpOuMdjUoUy5difmX9/8C3QTotVAykUipd8AH52E85lZDfKv5gEeoHZQyPUvEF9BGhrVccSCNet6cs/vNRF6j+Gk2V934sFfjUuKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504710; c=relaxed/simple;
	bh=kjrFp4tfVaPwEla1S3FT/++0eAIdUlLj8I4cqiOKyDc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Aww0GkPv5Fbnf+YRwExqwrBSPlmJHcUF1whcYuvr4kXBpGLe7Ti8cBJqBVjz8VZc2B7UFyC7EDX7w4o54UOf/uAqhBuUZhRF9EIbM6lLUST49tgfFZ2114LUcuphD8jA0pLMDlv0l8Eyp1aeUJOB0UtwNFIx/UEA9XMKwomtthk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oLSmEaxr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oLSmEaxr"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4712t3K6029975;
	Thu, 1 Aug 2024 09:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=CyFJrwhUL0tFNvg8PQyTWA/CZweN8iRVLnrNb2rvkXw=; b=oL
	SmEaxrVQy1qD5cQDy+G0P5k91aUBCcGH74n05/lnKXrkmRk3m3b67Or2DpJurn43
	oyInIkXMhHAqhddK7zUlNCae2McAGdbygtaSnAwYY0koh1WWB7GEUmwZ7foUoR0d
	4npti9nkkcFN4XDH7cB90OEu2yDhnt+/wREIvclzOeN/sT+FordgE3dxdgOXdpc4
	4xEKhxoUnR4q9SaxqiJ1CzI8xRw3+QACgp7CROGLotOFJ7r42jCsvmw2jWWR0Nu0
	Hir8vMTftkMZU3YycFP1qNBqJ1gnFQ1Ap6xo4o+JPRvSpb+qqj86MTtd8OYjHXyh
	giiqPmzh449YNX4HvqIA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40pq528m6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 09:31:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4719VaYR023119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 09:31:36 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 1 Aug 2024 02:31:33 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>, <pmenzel@molgen.mpg.de>,
        <luiz.dentz@gmail.com>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v7] obex: Move size emit signal to plugins instead of obex.c
Date: Thu, 1 Aug 2024 15:01:19 +0530
Message-ID: <20240801093119.25832-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-GUID: VBJPyRZ0Z75Gh6cQGaJLmwZQ1EFY6uxA
X-Proofpoint-ORIG-GUID: VBJPyRZ0Z75Gh6cQGaJLmwZQ1EFY6uxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_06,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010058

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
 obexd/plugins/ftp.c | 5 +++++
 obexd/plugins/opp.c | 5 +++++
 obexd/src/obex.c    | 3 ---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
index 874fe2b8b..6c841d207 100644
--- a/obexd/plugins/ftp.c
+++ b/obexd/plugins/ftp.c
@@ -175,6 +175,11 @@ int ftp_chkput(struct obex_session *os, void *user_data)
 
 	ret = obex_put_stream_start(os, path);
 
+	if (ret == 0 && obex_get_size(os) != OBJECT_SIZE_DELETE &&
+				obex_get_size(os) != OBJECT_SIZE_UNKNOWN) {
+		manager_emit_transfer_property(ftp->transfer, "Size");
+	}
+
 	if (ret == 0)
 		manager_emit_transfer_started(ftp->transfer);
 
diff --git a/obexd/plugins/opp.c b/obexd/plugins/opp.c
index 777f5f8ed..2220efd49 100644
--- a/obexd/plugins/opp.c
+++ b/obexd/plugins/opp.c
@@ -87,6 +87,11 @@ skip_auth:
 
 	err = obex_put_stream_start(os, path);
 
+	if (err == 0 && obex_get_size(os) != OBJECT_SIZE_DELETE &&
+				obex_get_size(os) != OBJECT_SIZE_UNKNOWN) {
+		manager_emit_transfer_property(user_data, "Size");
+	}
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


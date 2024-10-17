Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3E91791ED
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145641; cv=none; b=KgFRYy2m06qmv1PQBj6XQwomEBaz9puAH954qJdTlFTpUXPIQxguf4vm6hp15k3vLpVssndjrzoKL9ins9ISNmgdGdRrWkuI02oX2f6pY/U63wQUwpHl2ABpLdx3XURP0BrRV799+XlL/FJ6XBW27SNcTDcB4uW4FrYERGhQDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145641; c=relaxed/simple;
	bh=78tnzJMXAgtS8Og81n1LdtNdhMA+EuI7IKi7HFhmYZw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uoRCueDStxWoGrbFaPZiO+63dYVxjV3YOPTmcoZupSIXD/P5mYSKs9gDJXwfx+ivRa6jVLfK6LUUwtfmInWxIxSf4goiidjgALinDWKIkYk3viOwj2MSTrl5TEbGC7FvMepLr+sSqC8ZQ41PJzJh9VXreX0sfjrNQMgMd4zjKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MVZTPZ5h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MVZTPZ5h"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GLAPDQ011275
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 06:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RXNL6cBS3tWGiUZ6FONTfM
	YbSuM9BfXmeqIOmbzMtnw=; b=MVZTPZ5hzul8GpVQAzAYoN42OX3JNuqNgg3Qbg
	UWVyXeoewDh+1TB3O3yRkgF8SoPS2xMyX8Q8jLJqP9uSr3iHglK2EwpXnbcayGnx
	rB7bz7ubsMO79Peaf6xgIT+gtlZw60/hT7hk9AdJOHruHrhwyhBC7LLEFuXjId1g
	NIXoCGwprZkBvwSG/scI0R/bNSnV1G/uA/PwjonYB26dg5fKZUCRgIO+DIw4P2Tz
	GFNMaFLD3j7wDd1/Xy/Sc+xVdN0CdzZOJYpW8WJ829GtkzNjZAPXU0V+sJu1Ue9C
	m2Clhn0f5xUm5Z3AxJGMtv0IvtP7EzkgnINYuoYvBPQ4s0Lg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42abm5jxkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 06:13:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49H6DvNO025721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 06:13:57 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Oct 2024 23:13:56 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Move size emit signal to plugins instead of obex.c
Date: Thu, 17 Oct 2024 11:43:31 +0530
Message-ID: <20241017061331.2097436-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: kl-mmO5eFb0hVnfoisMnP_E9l3A2L0AD
X-Proofpoint-GUID: kl-mmO5eFb0hVnfoisMnP_E9l3A2L0AD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=945 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170040

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
2.34.1


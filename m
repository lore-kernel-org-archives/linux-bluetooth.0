Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF0482877
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234432; cv=none; b=O7qEL6ggQfjNxVun36bXwhrmx3kQ3InUNQcPEKSX0Pk4yvBfBe7AZx75QA8zWQAdmBQnruxnP5YoAu260jKLcHMyGNQB4tnOsD2/g3gzysS4GjkqBgFH/z1L3OV6+AJBPkVt31H3Kj7c8iE3dzUK3A7OX+X2XVd8AZI14fbMatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234432; c=relaxed/simple;
	bh=kjrFp4tfVaPwEla1S3FT/++0eAIdUlLj8I4cqiOKyDc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R8/i3H22NZ4vuRBuYRG6Vr6WOHfm+lgx1CMzqJKm57thlNYfKKGk4HWDlnpVwYa8e9NqVVmM8GKBZfojoUJXJESeCb8rY2iSA3Lkbkoz4Sz7lDJs87pQ9W3NbqJ8XVw7Vrdgbreg//LHedWiQFKeh90ahqwUCUZUsWW3gfL8s54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DbxHA2gI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DbxHA2gI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46SM0U7K011943;
	Mon, 29 Jul 2024 06:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=CyFJrwhUL0tFNvg8PQyTWA/CZweN8iRVLnrNb2rvkXw=; b=Db
	xHA2gInYIwBx2HnQZh23nUA2NcFfr1eN6cRLh9ObfN8h7q+ZdjUmruZtxqbaZxTP
	Yc4mYI+bXpywO3+Igy/J6ymUbRenBumpls1Jn6gu94yidOVPp9AtSx9urfuAOY0t
	fmQFfrKbwOpTNNoduSRNnjdYcq0HXQv5PfNIFA8K8A+oIwKb+CcwAGe6VOBAETFn
	WhFhUXrF1lGx0ukhi87o9rfn0ulsFFGz22m5+pqSUKrjyoUgkgAdY3QozLnu3sfT
	8+fdkLRv1TgP5D0o+mDiCz+ETcLuicCSulfhablVhmYXuFIOXcLUeDXFXMPIbH3Z
	hU+SHzbCfgnSwnnHCDeA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mrytu549-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 06:26:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46T6QvfC011188
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 06:26:57 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 28 Jul 2024 23:26:55 -0700
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>, <pmenzel@molgen.mpg.de>,
        <luiz.dentz@gmail.com>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v7] obex: Move size emit signal to plugins instead of obex.c
Date: Mon, 29 Jul 2024 11:56:38 +0530
Message-ID: <20240729062638.8796-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: N3fHB4Exvq1JB7KHJyex2WFSd_pMYfCq
X-Proofpoint-GUID: N3fHB4Exvq1JB7KHJyex2WFSd_pMYfCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_04,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290043

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


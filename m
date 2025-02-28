Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733423DE
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740723973; cv=none; b=WvfmECq0bH6GNgE5KLBHvNEkvtMjvwvOYmDrfAHWN+7P1tWFLCtGjCpLYKSFVvU0W2AbmTT3mDYAjOmAm/C88O5/lDVcoakawgMkXHKiE1pg3wdkhdFgsmKPqgBcpk8yHIUHrfxUaMz8D2isgfia2jp2bGP9keNosx1MIWyyycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740723973; c=relaxed/simple;
	bh=D/1SQpG5TY5+BqgO5IowVlsusthU+8havffDtylaIRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oIsBm+ji8Q5c3KZA5eh+wIICkMvoubjFY5RB7xIrZniG7Rj0a9Pcj/j8Kwjr3L7mmve5RHsnK9eXyasiHaOkap5xkSH7iycaGH9VmikySmU9HxsFrRv5V2l80eewOewyG7ifyESiu0+d3r/0TBroTvrejVYpYSU0T02/rOBuZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UzLayxC8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UzLayxC8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RIk9M9000780
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 06:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1MlCLwKzm5wO1WYuZS1vUF
	whLaI/W24EUz+kUShaGyg=; b=UzLayxC8CD7zfpzD/rrExG0RrDijmE1mYdc3AO
	fIz0YeMWYVrqx0Ya9rUkm6s4EWZf6QdPAq2ZHo5qQsYT6Y3kwqXGZto8JULHlvT8
	1MJ1E5fz3V9UR81hBUxh6wCmIkuy4JJsM/e+6QbiyiPK3ZmEv/IGUzJRGbWl4hKi
	dqdkKdTvyt+N1Hl82Y+O2McKBkD+WYNbo6A91TUGai98b34lLkzAEz1ij7mj0Yu/
	D44rhlzMPUy47NgTUJT6GPmXF490CFUE5AYdmFd3xcOfcbtj9HDwwNMg7mlvVb+i
	yafaEsbsxgA1vFQrX5rLG693O4YmYwutHjGB/LHYjCcDMiRw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451pu9gb5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 06:26:10 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51S6Q9iI018915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 06:26:09 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 22:26:07 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v1] obex: Add null check for data pointer for PCE
Date: Fri, 28 Feb 2025 11:55:54 +0530
Message-ID: <20250228062554.3102800-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-GUID: BmqNacvcJVGl6R4R7xSNIf_t8ExPW-9V
X-Proofpoint-ORIG-GUID: BmqNacvcJVGl6R4R7xSNIf_t8ExPW-9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_01,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=856 malwarescore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280044

Incase of legacy server, when the 'supported fetures bit' attribute
is NULL, Add the check to avoid any invalid memory access.

---
 obexd/client/pbap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 09d3fd425..48a2de650 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -1235,6 +1235,9 @@ static void *pbap_supported_features(struct obc_session *session)
 	data = obc_session_get_attribute(session,
 					SDP_ATTR_PBAP_SUPPORTED_FEATURES);
 
+	if (!data)
+		return NULL;
+
 	features = *(uint32_t *) data;
 	if (!features)
 		return NULL;
-- 
2.34.1


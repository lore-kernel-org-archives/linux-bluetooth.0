Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3023B6FC5
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712005; cv=none; b=LKd+eBd6FhPYhLfEHdqFqtVw0bPZcWuSaEzoVwo0//cUbLlwMkSV3ZKKCcNxhB/9Pv1Dx9qY6KCf3lyPJb6wzX68/5obVGI9zY+j82OV4zcxdR+ydrvZY3DbDtTG5WJZMf2aknntJR6LBKvyQNuotfe9WOEo4yoRAFCeyq/z8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712005; c=relaxed/simple;
	bh=/1+Q9z7wJk4zqzAewUctfsmNxjGY4d6FS1Ddb0+dM68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z4DVnk7CKKwsHM8Mk/mcwbH6x2bhrFidgXV/kKaEh4ZOBJXJbWmCfqlJKFE8+cVLwMqRwtHKkmgPOA9r4cU0qihH87nK82jahpG+fC0hhPkJT+2HXqvB1AvsVdheucIQfU4BQXyaxD88k4KSz02L216mv8djBRldntOmndhHj0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eiOs2p/F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eiOs2p/F"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3Nr3Sd012806
	for <linux-bluetooth@vger.kernel.org>; Mon, 4 Nov 2024 09:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jObyCYAioBLsXxNUnzJDF5
	mVOZlbLhaIMs38Cwede9U=; b=eiOs2p/F2/c6W8xwtX6rWi+hPmGpSlCKH2yORt
	UXnYUUxBl3ZLh1UlFTPMxt6NKRRzjbfLemHsTFLK+X4jwmHtWL+xKnxRaLOKwE5Y
	DkFpKuILKamXm47P/hPSJO9H1AoKxr7YTvpINVEEGFJtNFP79mZWN5qMA1BVi/X0
	CkhsN2QuIBodB5sSFqCVsLHXdlXzp7hCCjXBPgyk0sVYuZrxghvDwne/MIKsbi8i
	QvXp70+N5lWqhkA10fQ1PbpM//oUaFWvk9ceD0HnihF5LUnBW4uarRn0NXMHxiUj
	l0LQW3HRli1BMB1XljX0/g28FYEmzBudh/vAkb+kkws7OWPQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ndc6uk4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 04 Nov 2024 09:20:03 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A49K2rx031693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 4 Nov 2024 09:20:02 GMT
Received: from hu-amisjain-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 4 Nov 2024 01:20:00 -0800
From: Amisha Jain <quic_amisjain@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>
Subject: [PATCH v5] obex: Fix PBAP GET request in PTS testing
Date: Mon, 4 Nov 2024 14:49:44 +0530
Message-ID: <20241104091944.411353-1-quic_amisjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: qkEinLSdizJ9OpnSwiPyTjoyI07Brvgd
X-Proofpoint-GUID: qkEinLSdizJ9OpnSwiPyTjoyI07Brvgd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 mlxscore=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040082

This change is required for passing below PTS testcases:
1. PBAP/PSE/PBD/BV-02-C
2. PBAP/PSE/PBD/BV-03-C
3. PBAP/PSE/PBD/BI-01-C
4. PBAP/PSE/PBD/BV-13-C
5. PBAP/PSE/PBD/BV-14-C
6. PBAP/PSE/PBD/BV-17-C

PTS sends all the GET phonebook requests without extra params.
Therefore, the PBAP server is rejecting the requests with a
'Bad Request' response.
So append few default params in GET request to avoid
testcase failure.
These params are already added for Vcardlisting and Vcardentry
operations.

---
 obexd/plugins/pbap.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 4175f9de8..fb5b6b696 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -511,7 +511,23 @@ static int pbap_get(struct obex_session *os, void *user_data)
 		rsize = 0;
 	}
 
-	/* Workaround for PTS client not sending mandatory apparams */
+	/*
+	 * Workaround for PTS client not sending mandatory apparams
+	 *
+	 * Add MaxListCount attribute, description as per PBAP spec
+	 *
+	 * 5.1.4.3 MaxListCount :
+	 * This header is used to indicate the maximum number of
+	 * entries of the <x-bt/phonebook> object that the PCE
+	 * can handle. The value 65535 means that the number of
+	 * entries is not restricted. The maximum number of entries
+	 * shall be 65,535 if this header is not specified.
+	 *
+	 * 0x04 - Tag id
+	 * 0x02 - length
+	 * next 2 bytes are value - 0xffff
+	 */
+
 	if (!rsize && g_ascii_strcasecmp(type, VCARDLISTING_TYPE) == 0) {
 		static const uint8_t default_apparams[] = {
 			0x04, 0x02, 0xff, 0xff
@@ -524,6 +540,12 @@ static int pbap_get(struct obex_session *os, void *user_data)
 		};
 		buffer = default_apparams;
 		rsize = sizeof(default_apparams);
+	} else if (!rsize && g_ascii_strcasecmp(type, PHONEBOOK_TYPE) == 0) {
+		static const uint8_t default_apparams[] = {
+			0x04, 0x02, 0xff, 0xff
+		};
+		buffer = default_apparams;
+		rsize = sizeof(default_apparams);
 	}
 
 	params = parse_aparam(buffer, rsize);
-- 
2.34.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33C1E507
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736492093; cv=none; b=NhpoNOGR38Uh6qE3NenDsZ7920uOfw/qhMzN6uUOcMfwW/aLaHooT/1UWuPgb4i8mc36RPus10CHLQBNBP7ZjRhh30G3AIFlvZuJD/xhJCydjE63wskfhrlKIY39/uUCIuJ86nyOB4nt/BGW7qHKe/chOytbVH+A2yv4EjlPNnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736492093; c=relaxed/simple;
	bh=+mR9PqnR4JalrXACEzMNXj+jGs5ccon2ffMEfWnkKHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SvipkKQr+CZwhr5m84uMl+79DqGouwNJ7tjv2mLnjbRvnwe8Yv/2mVQbTZSjLtW42lO8fh8SfzQOvBEFGWbpU42i+pCtF5P3g4UxCHGg7AQ0HXTFpRVOlqyjszUitsOBXW/bIbSbo3TdEkl7Px68n6JOIv0BPYFkjJ7iJ6PmDlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XO6b54Z3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XO6b54Z3"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A1Va70023070
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 06:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/U8+DP9qP/wjxxlo9MjxDs1JmrYUWTT1Ec0
	jSy8z1n8=; b=XO6b54Z3EQeB9YqylqV79v26u8oFFy753mKFdZKAJ9qsD2Dodrt
	0MMNJNQFbXpbCe8oaHXIHAzb6cWX62G2m3jb9Ymmlvqf/5YV5E4d8XqLwGH5VM0Z
	bHtTcImKj/LDjPymgOmg8eTMwFoUgXWao8DJizMaONdlKYzwtyI124neypyCvV2+
	VrmwZWXgjf62pnJyuvGU4cSbQktQgavAQrqMl2hfLs9u/RvE6s2H8rU6/7HYzQEL
	Tgu+RJzvf9vm8eiV3pOFjKA0W8Ad44nXznPxBV+3s77bxowdObdMq0CtS/CSfcRP
	6O7Y8Ehw+XTVh3Hc2jvpyUmh/5BFvzeC4BQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442syc0n9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 06:54:50 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 50A6slwr015325
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 06:54:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 43xx2m2mbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 06:54:47 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50A6slGx015320
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 06:54:47 GMT
Received: from bt-iot-sh01-lnx.qualcomm.com ([10.253.136.182])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 50A6sluS015317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 06:54:47 +0000
Received: by bt-iot-sh01-lnx.qualcomm.com (Postfix, from userid 4467449)
	id 4A19A245F2; Fri, 10 Jan 2025 14:54:46 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: linux-bluetooth@vger.kernel.org
Cc: quic_shuaz@quicinc.com, quic_chejiang@quicinc.com,
        quic_jiaymao@quicinc.com, quic_zijuhu@quicinc.com,
        quic_mohamull@quicinc.com
Subject: [PATCH v1] BNEP: Fix the BNEP Unknown Control Message in PTS testing:
Date: Fri, 10 Jan 2025 14:54:44 +0800
Message-Id: <20250110065444.3192525-1-quic_shuaz@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ok47NWZttlcS-AX7BpcukomNxg6dBQ_V
X-Proofpoint-ORIG-GUID: Ok47NWZttlcS-AX7BpcukomNxg6dBQ_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=262
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501100055

This change is required for passing below PTS testcase:
1. BNEP/CTRL/BV-01-C

Fix the flag judgment issue, it should check type
instead of ctrl.

Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 profiles/network/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 36a1136f6..ad2cd55bd 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -336,7 +336,7 @@ static gboolean bnep_setup(GIOChannel *chan,
 		 * This packet reply to any control message received,
 		 * which contains an unknown BNEP control type value.
 		 */
-		if (req->ctrl == BNEP_CONTROL)
+		if (req->type == BNEP_CONTROL)
 			bnep_send_unkown_rsp(sk, req->ctrl);
 
 		error("To few setup connection request data received");
-- 
2.25.1


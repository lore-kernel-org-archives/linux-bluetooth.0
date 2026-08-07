Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA94448CEC
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083213; cv=none; b=UzsRM3Ip4lZV1fdvPadYEc/FhkRhXELIBhRgfxkr1lbvI2iBEZLTi7UaUk1isjSrG38R/SAFrBVLB5+7GaCktWTEzas7oKwi5GHQzH++fyWSI5/r7ylfvQgtbgZqkFpqynrrSc2ArAUbWBpoonIur2j9NIF6yNQvehfSIm7ZaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083213; c=relaxed/simple;
	bh=ziFcKOZWVuCvSf93ZGDIlIXnVkjgJMbHYykKQTdYxxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sJDjvCQY/LcrcgtSPgkFWBmjvE7GyAqVSx/c69d1JnJwPxko2fX3+q8QrkHJ/+DxCDL45nkn71EoKgvnHnZBLTjwlHfngie9Da/4lNx5lToP9H8KTJRgXAEeETolx3MzF77vWXsfma4zehG+huuh1JSoBer/EJVJiN3MV4guBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QqHjBe0L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QqHjBe0L"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770GsEB3822188
	for <linux-bluetooth@vger.kernel.org>; Fri, 7 Aug 2026 06:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=J9av/uEFvl5YU8d8fh7wR/6jVV0l9MxPF4R
	qmvQm8kc=; b=QqHjBe0L3ER0z5VMozVXnG0IuvQXku9nwMwzSpLcD/loVUk6JG+
	IpSygOq6xhxPsFBPqSgP5pRfnw++niXndk2OlwyVmCskFNPOZe09BYhNHjp87rb4
	V7i5Kp40edStKl1UFYMUevHipR3srZuLPx8dw1lhRtRw3c/sMXKM3Vsi509RwmAc
	dK32vbDIeDlH6X3AtmivfB7/347nXWfYS1rtr9OqoSuRHgg2FRU8S50jgyTrYUj0
	wAzxRY2IqhwPVJTiFdRZS0/Za9793V2f64nVJ3zw3XdATXS2QjTQaa9f4oSI3+EW
	BhpujlQ5g9f4aqvztKRvUYOYDJpteBX6ciw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gthte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 06:13:29 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6776DQ2x027970;
	Fri, 7 Aug 2026 06:13:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fs9vkqnqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 06:13:26 +0000 (GMT)
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6776DP8X027966;
	Fri, 7 Aug 2026 06:13:26 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6776DPql027965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 06:13:25 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id B0C662161B; Fri,  7 Aug 2026 14:13:24 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1] client/btpclient: Fix missing errno.h include
Date: Fri,  7 Aug 2026 14:13:16 +0800
Message-Id: <20260807061316.1647216-1-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a757789 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=rfIcpyy1f7hbhnCKICkA:9
X-Proofpoint-ORIG-GUID: lW815KkXFSuujcpSLOE0SzG_K94WQOJP
X-Proofpoint-GUID: lW815KkXFSuujcpSLOE0SzG_K94WQOJP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA0NCBTYWx0ZWRfX4ddug50jHF2h
 YZVw1vGGtg/ZRwU5kwCMYvYlWh43ulaU/UiyqvmloYYrck7FI8rcsIHWjdu859npUigKIWx/C9v
 3SnQ2WTZScsBPaT4JI9K3m19E3jyvAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA0NCBTYWx0ZWRfX4J75rpPfpc/6
 kZd6957zXQj4SmvuaA3Fujn4ngF4utT5yQ7+q+19DstTzaZPC2caHkEzuB+StYPEN8MPINSfdeR
 Q+mYxn8Ttg2KrVY+8qx7srupLqArp3kCZLYGXm1P3Ks8XWAtdWkbapiJ9HqNSao3xNvKDoPET3f
 qsl6lbHVvRPKHwGlydwfcHQcf2z9wvjO39yUfA1FzgZfIAcbDKkM6tEf06cM6aTfUzSnQWgpKgI
 dhjaAC6dp5xmtuu/GQAY2WolzjjqYwL99vKG1cyuecyfVmMPRDg8GxEq+FoiQk7J0CG0WEnKjHg
 h2U4JJBwOoLDperJCnPF93kw0Mqhlk3c+5oMbxYDuYVnk+qFOBTUpkCDIuNJwn7TprBKLfiQqiz
 Av0aqXseWaoiGIWVybx1XeFfbPPX4zhdJqNhkZLq5lSbFlmPldXYMPMveBbfTp3H0T/5FxbnQG5
 baT9Du8IGTF6h59YjBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070044

EINVAL is used in create_uuid() but errno.h was not included,
causing a build failure.

Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
---
 client/btpclient/gatt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/btpclient/gatt.c b/client/btpclient/gatt.c
index d384b9c74..867bb6cf1 100644
--- a/client/btpclient/gatt.c
+++ b/client/btpclient/gatt.c
@@ -11,6 +11,7 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
 #include <stdlib.h>
 
 #include <ell/ell.h>
-- 
2.34.1


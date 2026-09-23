Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8E237DAB3
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 03:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134255; cv=none; b=p1nwtOwFGxLJbMwtCIds1XKL/7bxR5T2mqw5n/RiK74F5eeK9WpLbTyiOYTe4YigiaE/I1gD9qovAKkEQTSvo0xSJj85I/BD4JAsaQcsQsB4BhmKtcBUYDsUnDx2SEnl5eghKyCeaZLBsH0vQlv9n/6YDyzmwR/dJjOLceEHZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134255; c=relaxed/simple;
	bh=IXr6pxx+x6y/csArRJXH5NrisKPjwLIRKI6u+UNyGps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NizXoTKKooypCqMMiBe/K2lJy4QnIJyLOZl8JJYx0doBUkAVQkfHmdlZTQ+f0k0KSrygU98kCP0jbAPUd0bn36j8fteNM4vCRwd4YOOoFBRiNAFMV0X3sSAWI8r6eVs7a2x7AIVjwhCcW2j7LTbqwNQ79u5tNO+ZzoylHSYo2Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dKtdZmZf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dKtdZmZf"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3U1oa2340525
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 03:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=g34nj1Rg7lGpi2lme52qWHtD/vGbWP4+nrR
	ARkblUxE=; b=dKtdZmZfHLMYJXiWI53ZObWPFPXdVgnkFzXhQB/Ih2X9Tg6+7d7
	mVnd6Yof/v2iCCYdvBmc06iaUF4/6ljCMqiUIEdOBQeip2o5FVZv1kG2h71g4o5r
	Xuhw34MrRbjfn0di35aECLP/7C02+ksVEAgcArnr7LUGUnaCZDaax/ovmuy//Z/w
	KzAIGsACg9jcwPV1YthEAUrmiSn+qbBx9HhfDwezXmJfUuDONFWbaRn2p+vT3JSQ
	ivMQTNpCd+yh/iJWKdCDHUKn/giSqzoTGzFXol/V4osGMbfsSd7rFAKzb5ZXC/Hz
	zrfvvAFgCT0PXJFxpEgvetLnODuJqIk4aug==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guvw7ju26-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 03:30:53 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3Uo2Y304476;
	Wed, 23 Sep 2026 03:30:50 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 68N3Uoep304470
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 03:30:50 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 0F5C1227EA; Wed, 23 Sep 2026 11:30:49 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1] obexd/pbap: Fix u128_to_string skipping data[4]
Date: Wed, 23 Sep 2026 11:29:57 +0800
Message-Id: <20260923032957.4133667-1-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxMyBTYWx0ZWRfX13eSZ3aJHwr9
 luLm53SIgap+5ePj8tZYZFDHWlboY7G3I2zTvSYl6wySoR/zU/viNisqQ6rO3XdwraFawBBFGkz
 L0a+P4kaJiUCbVTH7Dqp/KlVnYvxgV4=
X-Authority-Analysis: v=2.4 cv=ZYqIpcVA c=1 sm=1 tr=0 ts=6ab347ed cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=Rs-4s8aRUGZehh3-7AAA:9
X-Proofpoint-ORIG-GUID: EBzZl650QrgWPH7uHe9w58fi5ESQoAKQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxMyBTYWx0ZWRfX+uxzEtu1pmIo
 V94YNnIxMOX+cvKt+f1CZbwAUOyrRB/lJLE0lscsb6xVo3QSuB5DW5WSnHWKtX7NxrrkiNHhs17
 BOaEVUtjIi2xCT7EuM45ymGobfsKYQD90GcOCxvF+fD2g7dhmjRcqs5j2YRUARUKwjrC64srH1H
 UDdVidXpZ8radp9273L6gnNp2APRHsnesy5anEAQeRZvaKiKRKiYZUAqtQXUDWjfqpQwvAEYTRf
 IEpYFrUfDX9pjX7iIfytFHA1lEDxyl8lwQCkJHZ0FrBXOv1snrz+CWJXKVoqbRmUl/oj5ZRcmFf
 2xAqZqfaF6SaPbxlFvAsfxRXy7w20c5NBgeo7SwQLsAroRjDHqxFXuwzwtgflnboPREsnKLsT9Q
 tOHOvJO/prVhQtyOK3whk+sXTcqIPyJ2jZOt2s+8XICKvwF0jnwLbyspkzAZt8mq4q3DzBMNtzo
 8P3gGeRCU8ZhK6NJQ2g==
X-Proofpoint-GUID: EBzZl650QrgWPH7uHe9w58fi5ESQoAKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230013

u128_to_string uses data[3] twice causing data[4] to be skipped and
DatabaseIdentifier, PrimaryCounter and SecondaryCounter properties to
be printed with wrong values.

Fixes: 5ee26d43c65c ("obexd/client: Add DatabaseIdentifier property")
Assisted-by: opencode:claude-sonnet-5
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
---
 obexd/client/pbap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index ce5e6cd5d..1970d3357 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -1099,7 +1099,7 @@ static int u128_to_string(uint8_t *data, char *str, size_t len)
 	return snprintf(str, len, "%02X%02X%02X%02X%02X%02X%02X%02X"
 					"%02X%02X%02X%02X%02X%02X%02X%02X",
 					data[0], data[1], data[2], data[3],
-					data[3], data[5], data[6], data[7],
+					data[4], data[5], data[6], data[7],
 					data[8], data[9], data[10], data[11],
 					data[12], data[13], data[14], data[15]);
 }
-- 
2.34.1


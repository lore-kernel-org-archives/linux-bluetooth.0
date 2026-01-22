Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB247AF53
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769063810; cv=none; b=poJ4a7fNryNuyv5FW2Qqv56SCR297W/YTmdB0nomSXwUDaMNJpV1j7FQE07eREXzwtRH7bhXBj2wChYCGBAZLMeJkvfd0ZjGvWOznaCBOPO8I8pSehzPFTiEIa2dSv7lJJIP8t+z78OYHe4RjkeSq0Wxp++hFv1W0GjffOp+1wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769063810; c=relaxed/simple;
	bh=CUmC27ounfp2PecJFcrXztAv+VPj/qxmVDbMrJpkTqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dX0W+49EufBC391LqNYP0knCHaFQ2vbYJ/K//2SqTFBg+dp+smP59pzVYHQ7hayoRU2RwzId036Yxp0Top8QEbWENY4WzyeCuYGuYT8g31pAoXhn6fEpPpiQbvsKDpDVPQ6Lv1F7bw+Oz/SV4zrBexmonCnGvyg+d3osb7CZb9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XqrlXCTz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XqrlXCTz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LMAqwr3867427
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 06:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=f3it1KuDs/n+VWyS8OPQ10ngObC8fZMzivk
	Gtyli8+U=; b=XqrlXCTzo4g5xen5KjVm+r3ElS47BjhywST5TunbKPu4YEds/iv
	0rwnSVc5HEd7qEwk80ZknQlIMWGRL71QpVvAtLENRMZKlmsb9FH+en7ZLL8eTV6Q
	EonvHlEGFIm3rbOVAwPufcVIc9Z6p+5Hbk9QD8TYvjk1RSx0l4jGLmFaYZcJFLM6
	nFT7n9X/7rVfj9P3qQIvZ6HwFNwNMBoqQEPRDHn+Tx/RBh982j4GGd1+ch94thQw
	J1n3wtSGZQoShKtimqRgoTNYVkTnlqz731PXITeRU7EzVYl4YyRS+Jyc6rhWWMTx
	v1caospEvbL897xnlybCMW6vAnJjZ9Utplw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btyrpjx10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 06:36:46 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60M6aii9020440
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 06:36:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4br3gn0b54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 06:36:44 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60M6aiQP020437
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 06:36:44 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 60M6ahco020436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 06:36:44 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id E518C23A8D; Thu, 22 Jan 2026 14:36:41 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
Subject: [PATCH v1] device: Initialize device volume with a valid value
Date: Thu, 22 Jan 2026 14:36:40 +0800
Message-Id: <20260122063640.310090-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uD80ufa3W2OD5Jt4i7x1puygG_POkIcp
X-Proofpoint-GUID: uD80ufa3W2OD5Jt4i7x1puygG_POkIcp
X-Authority-Analysis: v=2.4 cv=KpdAGGWN c=1 sm=1 tr=0 ts=6971c57e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=e2j7mj0DrkRRvc0VsM0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA0MSBTYWx0ZWRfX4mts6JfdzwLz
 l7vh65SunB/ck5idV0Ub7OFaYID6po5zqlkO0Sni5J5R4QY4sLvJwQqn66YIr3YPJZ0EP6g6mfu
 hudHdXa1ga8iw5FOIwnu+f8D3a/QrQ/B0kGtR4RS+ZvShdtxrLc6W6kyh1isL1n4FaOPefzlEPF
 2Z9feVVETGwBS8HeaQSkUTDaico4CK+RchWw2hUwNsUia9KAq8zLPV1n3raS8NbANP21ayew9is
 KoHJqCMNC74yXDP/2aTq+RdnXamY1paeMLzQYRm50PL3IHk0+2ixsqd81mA9CfzH4QjXfanKfKV
 08Wv83pQBKMWp0xetkkk095gSPzP2izOPJI0TSdwK2yNoO/9BP16XGGIXnXAi3XXTGJ8FdkfZLd
 iYeCdSkBppzPDdDEUivWZUd7X/2FSGevPQJcGCruBJNJ5TDHmrgfJChuIs0agN11SDKNTtBJzxP
 KmyxodvTOHdXuk4aM5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220041

When AVRCP is connected earlier than AVDTP, this invalid device volume
causes the A2DP sink to reject the peer's registration for the
EVENT_VOLUME_CHANGED notification. As a result, subsequent attempts to
set the volume fail.

Fixes: fa7828bddd21 ("transport: Fix not being able to initialize volume properly")
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index af8df5f29..cd0b8802e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4948,7 +4948,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 		return NULL;
 
 	device->tx_power = 127;
-	device->volume = -1;
+	device->volume = 127;
 	device->wake_id = -1U;
 
 	device->db = gatt_db_new();
-- 
2.34.1


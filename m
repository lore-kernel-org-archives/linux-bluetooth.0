Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6596249F9
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744080425; cv=none; b=gmCpNtW+6FEsKzjhw7fRReZlyAUp4yBYaQT5YhzWeLC57FVyjPSGPHTHIc7ZrxZVrWTdGSZC+KCZIgk2qQbJ/K9ZW6kAni0xHlyP5Q9/H4mOrvUppgg7Rx8k4g250idpc46+3dLNtNAEgZ7fCfH2d1gv4HwY+ZrBraSk+Uqk/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744080425; c=relaxed/simple;
	bh=18avCFQvci1RQZI1U25gqALJC5KJJAMBJEUg/sBfLc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hBknNsJJ5ZU4byn3qLGTkx27Lc5em5zUoT3JgjD7DTircDesmiaQuADG/ivTlb8RItbennm141Un7MMR7V9IMBtc2BGgzKcanZkT+YWSWZWDSpxvDeZEPExelOWyo73rI+38nXRBu/eZO4RlDwJ1d2xix8ZbHPqjkBrfvzElCIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=blGHK0o3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="blGHK0o3"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GL3r000841
	for <linux-bluetooth@vger.kernel.org>; Tue, 8 Apr 2025 02:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QDSfTFq9cIHlFkdbhuRMv4DMBvxPITBj4zJ
	5dg/qhOM=; b=blGHK0o3500FKWOaiDQZCjv1ge3T1oJnDNOQVXCTwYRb+sxUR76
	Kv+zrBaK72h7yZKox4CRLS8RVZWED9vQi7NO1NVHdfq/TY3JbHK0XH+9Uat+gnOB
	2TTKxND00gkgi9IDbNibjearbciR3LB5+C3MmSvjk0dr65OUCAtfuBe0lSm4oAOj
	FhIBvqW5an4qEsGnuQYDaQVatbUlgcn4T1NF80mq2PATDQiA1QBRVRunW50Hdw++
	QoWA/ED31B43YTrluleWGyvRFEzQhRxbpgZUtZ2Wh6co6zkTK9gYsfuEU83Xz5jj
	r33fql2Rcm3CL6D7rQck80mD1Vy25E93rKQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbe6992-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 08 Apr 2025 02:47:02 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5382l0kR011936
	for <linux-bluetooth@vger.kernel.org>; Tue, 8 Apr 2025 02:47:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 45uek4g2nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 08 Apr 2025 02:47:00 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5382l0vv011929
	for <linux-bluetooth@vger.kernel.org>; Tue, 8 Apr 2025 02:47:00 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5382l0f5011927
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 02:47:00 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id D85C72249A; Tue,  8 Apr 2025 10:46:58 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: linux-bluetooth@vger.kernel.org
Cc: quic_shuaz@quicinc.com, quic_chejiang@quicinc.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com,
        quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
Subject: [PATCH v1] Bluetooth: hci_sync: Establishing ACL links is prohibited when power off
Date: Tue,  8 Apr 2025 10:46:46 +0800
Message-Id: <20250408024646.1784057-1-quic_shuaz@quicinc.com>
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
X-Proofpoint-GUID: 6_HxIkBqvA5i94Ygk3XPdmddnEl6Zpqs
X-Authority-Analysis: v=2.4 cv=T7OMT+KQ c=1 sm=1 tr=0 ts=67f48e26 cx=c_pps a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=c4EYleMi8gmWdK4YUeIA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 6_HxIkBqvA5i94Ygk3XPdmddnEl6Zpqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_01,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=960 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080019

If turning off BT during pairing, "hci_acl_create_conn_sync" has chances
to be left in cmd_sync_work_list. Then the driver will try to send
the HCI command of creating connection but failed.

When establishing ACL link, add judgment for BT power off.

Change-Id: I9844a1ce1f207453e4fadeded3da1738eb4660c9
Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index aeeadb45e..fdd57132e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6761,7 +6761,7 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	struct hci_cp_create_conn cp;
 	int err;

-	if (!hci_conn_valid(hdev, conn))
+	if (!hci_conn_valid(hdev, conn) || !test_bit(HCI_UP, &hdev->flags))
 		return -ECANCELED;

 	/* Many controllers disallow HCI Create Connection while it is doing
--
2.34.1


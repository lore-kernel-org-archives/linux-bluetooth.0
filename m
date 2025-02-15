Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59152AE8B
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739584566; cv=none; b=H9XhBu4h+HmU5d6ojjvDY4TSZN6TQRgu9+yKITcks4vOn9OMnSTgvRzAdQJhhy74qyzxvRtuTJriBdJ+/wjgeLknjTBxGqSsAPMqII6uHKsAK72/I9w7D9caqiRtW9265ukYiLiOMcnAr5C+LBHCgQJXQuENUFHsmcPaHM1/MSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739584566; c=relaxed/simple;
	bh=0bgpF7SKC6qoXBJpDShLy3XnSCul1Hs8FTB37mBigTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kbodTHEJcnOIzyOcFXE3j1rhSy/66LpyQ9MA2ObBaHtRZFDEIOt+EWu6a6+lMZgJKU8aogeW8xjVXJ+IZ/xVQmcGO97t2ES80etZxG6sAkSp3bnSJIYpxvu0BXp+ZpUXWC3//DiUQZNHy2HGmt9FSPO1tk06zK1XmYbhVDK/bQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K1N9uGoT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K1N9uGoT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EGJkif008242
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 01:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UHE35P/DFW42ljq9NaZoeI
	DvpLY0RKVkKeOwszBVVwQ=; b=K1N9uGoTdPBF8nK8WmC1P9Mjju4Mg1g3Drk4hS
	OBvSBUGh3bWy3jSap25w9NmhLbyBodzvLg9MVGab8geCWKfeGQGKAVMUFSznMc5y
	u8Ynx/3uQLxdtfCzZXFszE9r9juymLMBVtQqxJ0oebrvee1cTVYTH6/lkr6HDMi2
	eLB5fouJIG4doR7Z3q7R4+dPEMyRG2yckeXbfcG8/E70arZMUZl1hWWhnYrlI2Nj
	lYQPXKzkvUhlT9RyKffR9mbyl5RhIvYPEkYpjYpDVE3v9/FwT+y86iiMdrRMJuxQ
	hztDb2S3mfo/4uH/2OC4WyGlgGv/0qZiu2tbU0dYa6Fr1GPQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qewhfq33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 01:56:03 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 51F1u17I000624
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 01:56:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 44p0bm71x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 01:56:01 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51F1u0sn000618
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 01:56:00 GMT
Received: from bt-iot-sh01-lnx.qualcomm.com ([10.253.136.182])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 51F1u0rR000617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Feb 2025 01:56:00 +0000
Received: by bt-iot-sh01-lnx.qualcomm.com (Postfix, from userid 4467449)
	id AA9EC21D29; Sat, 15 Feb 2025 09:55:59 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: linux-bluetooth@vger.kernel.org
Cc: quic_shuaz@quicinc.com, quic_chejiang@quicinc.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com,
        quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
Subject: [PATCH v1] Bluetooth: hci_qca: fix SSR unable to wake up bug
Date: Sat, 15 Feb 2025 09:55:58 +0800
Message-Id: <20250215015558.1043074-1-quic_shuaz@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yv-BQHzm1nCYh4i63RS3Arq_GAt8e_xk
X-Proofpoint-GUID: yv-BQHzm1nCYh4i63RS3Arq_GAt8e_xk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_10,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=697 phishscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502150015

1、During SSR data collection period, the processing of hw_error events
must wait until SSR data Collected or the timeout before it can proceed.
The wake_up_bit function has been added to address the issue
where hw_error events could only be processed after the timeout.
2、The timeout unit has been changed from jiffies to milliseconds (ms).

Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 0ac2168f1..7d63886b9 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1104,6 +1104,7 @@ static void qca_controller_memdump(struct work_struct *work)
 				cancel_delayed_work(&qca->ctrl_memdump_timeout);
 				clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 				clear_bit(QCA_IBS_DISABLED, &qca->flags);
+				wake_up_bit(&qca->flags, QCA_MEMDUMP_COLLECTION);
 				mutex_unlock(&qca->hci_memdump_lock);
 				return;
 			}
@@ -1181,6 +1182,7 @@ static void qca_controller_memdump(struct work_struct *work)
 			qca->qca_memdump = NULL;
 			qca->memdump_state = QCA_MEMDUMP_COLLECTED;
 			clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+			wake_up_bit(&qca->flags, QCA_MEMDUMP_COLLECTION);
 		}
 
 		mutex_unlock(&qca->hci_memdump_lock);
@@ -1596,7 +1598,7 @@ static void qca_wait_for_dump_collection(struct hci_dev *hdev)
 	struct qca_data *qca = hu->priv;
 
 	wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
-			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
+			    TASK_UNINTERRUPTIBLE, msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
 
 	clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 }
-- 
2.25.1


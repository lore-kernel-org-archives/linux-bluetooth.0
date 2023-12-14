Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oEQ++XgT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E5C116
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 06:36:51 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BECMAKg030938;
	Thu, 14 Dec 2023 14:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Nlelb2y9H3cIvChzvUI6PEGZViCUJdZB0fK+EaZ+T4M=; b=oE
	Q++XgTgqKmdOoFSQCZ+n9SNDqriOuCYYN/kdPrtuBlA0zju32aZUW/V5g2EJRt/3
	SH1/tn2qCS1BXkwT8+kzdFQypfi5Az7p1Ay2ddZu4o8OAI2oOpJcXChlrURFA+fk
	slFfaLF1gJKSP1KylWerAFmZR1cGCvZC+f44iqAdikbsrAsWbtvR/Z0SHr0VpL+l
	P+sHPRmkdimcDHRMSBjS3lfyKsVjv0ZuAZsdFz9S68bRV77EWcxixBxdLHTaS7xP
	X84ROgnGO+REhW8/OsZMQobHuk2TEu4q5DIGkH1sQJCsXgK/TqYoWn6FPLyI0jjf
	QyNpXsqvAkXj3PYWaMEg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynja9q4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 14:36:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BEEakAj014509
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 14:36:46 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 06:36:44 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <jaikumar@google.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 1/1] Bluetooth: hci_event: Fix power save marking logic
Date: Thu, 14 Dec 2023 22:36:38 +0800
Message-ID: <1702564598-3034-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YYd70lJQV8jaywHRc08iTm5I-p71E5DN
X-Proofpoint-ORIG-GUID: YYd70lJQV8jaywHRc08iTm5I-p71E5DN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 mlxlogscore=964 mlxscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312140102

Flag HCI_CONN_POWER_SAVE stands for sniff mode, but hci_mode_change_evt()
wrongly set the flag for active mode and clear for sniff mode, it is fixed
by reversing power save marking logic.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/bluetooth/hci_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ef8c3bed7361..74a14f2e0eaa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4601,9 +4601,9 @@ static void hci_mode_change_evt(struct hci_dev *hdev, void *data,
 		if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND,
 					&conn->flags)) {
 			if (conn->mode == HCI_CM_ACTIVE)
-				set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
-			else
 				clear_bit(HCI_CONN_POWER_SAVE, &conn->flags);
+			else
+				set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 		}
 
 		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags))
-- 
The Qualcomm Innovation Center


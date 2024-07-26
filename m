Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781EF219EA;
	Fri, 26 Jul 2024 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987935; cv=none; b=OkR12ohLslmQN6NlG1LTyMqDZiIE1YwVYQvE1MwjJXWJUN+MuGC2L4YNWMjs/crrudsjLSEbjTApaW9SFns3PCNaU5Eoqu5kA1TGX4vkfcpH6zy+OJ852hLcJhTmjaVDGROwZ6QNryoLifnBHG73YxZtk9G9tuqIX18RkitA6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987935; c=relaxed/simple;
	bh=vg1PntK5Lod8y2cnuGY39Zcfd0NNF11adISfpZOYRnI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HEYTHZJmQETNzRD4iSLWpwQbcASbkDJKMfqCu/I9cXFsHZ0sJpdNqJ8PQ0C2Uu+OoAXrqelGJ/MYMm20QMXkWhlgiGI7CUQNmU0hhT3oDmvRF3+Hn4zHoNKK996VcyVRMiY9RGqhlup0v7DRhARVVnZgJlztOf5vmcEaK6SiNBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LR7UVo3x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LR7UVo3x"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q17xCd029060;
	Fri, 26 Jul 2024 09:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zuSPGiZp1o6HTCgJWF23Xe
	CNBluhDf6cqAI6WZ2/42M=; b=LR7UVo3xMG+xstVkO0n8QDRup9nqaja7c8gNbc
	A2zBl3BoRv3AI0yJDE6FKxVasfICbhd8g86xTtZ+OnDHiwGZtvV87jDCwdSmZbs1
	zy55nQ/eN+ALESMgU2bU/7DbGIJr545/xlMa3L7wbSSKXt7g4j6nPUqPLyvfRV5G
	OUi+Fpn53Am/knDQ/OELcIl87QB0v6xx4BLu5loyehpHDHTCSSUyYeZ/b863QwzG
	ktPvS3wBVREG25OdZj2hzY4Aevxur5h3f3d/OIUmE97HIrHr5Wi+QE8Ayg3XtM/O
	6eN64EvmboAq5rSF3rmbIhB/awO38O/VK+AIr8uMbWKNFZvg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40m1v192eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 09:58:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46Q9wmZv002557
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 09:58:48 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 26 Jul 2024 02:58:47 -0700
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Drop unused event during BT on
Date: Fri, 26 Jul 2024 17:58:28 +0800
Message-ID: <20240726095828.2707111-1-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r-qx43OTYXFLTOrBxb8P8CEqSaHoF34p
X-Proofpoint-GUID: r-qx43OTYXFLTOrBxb8P8CEqSaHoF34p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_08,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407260065

For the WCN6750/WCN6855/WCN7850, the vendor command for a baudrate
change is not sent as synchronous HCI command, controller sends the
corresponding vendor event with the new baudrate. It needs to be
dropped, otherwise it may be misinterpreted as response to a later
command.

Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ca6466676902..f497d601e035 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1206,7 +1206,15 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 		 * vendor command).
 		 */
 
-		if (hdr->evt == HCI_EV_VENDOR)
+		/* For the WCN6750/WCN6855/WCN7850, like the WCN3990, the
+		 * vendor command for a baudrate change command isn't sent as
+		 * synchronous HCI command, the controller sends the corresponding
+		 * command complete event with the new baudrate. The event is
+		 * received and properly decoded after changing the baudrate of
+		 * the host port. It needs to be dropped.
+		 */
+
+		if (hdr->evt == HCI_EV_VENDOR || hdr->evt == HCI_EV_CMD_COMPLETE)
 			complete(&qca->drop_ev_comp);
 
 		kfree_skb(skb);
@@ -1497,6 +1505,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 
 		switch (soc_type) {
 		case QCA_WCN3990:
+		case QCA_WCN6750:
+		case QCA_WCN6855:
+		case QCA_WCN7850:
 			reinit_completion(&qca->drop_ev_comp);
 			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
 			break;
@@ -1531,6 +1542,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 
 		switch (soc_type) {
 		case QCA_WCN3990:
+		case QCA_WCN6750:
+		case QCA_WCN6855:
+		case QCA_WCN7850:
 			/* Wait for the controller to send the vendor event
 			 * for the baudrate change command.
 			 */
-- 
2.25.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F741CC160;
	Wed, 21 Aug 2024 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231668; cv=none; b=HlIPzIXDwHVk5/bnp9qB9F2P/SeDWbZOq8kCH7d8/5iV4VYQEewz9izFj03FitJ3qn0whA1BYTnwEmrqGLr/mN0c5/xTHXyT6k0lGY3u4Rr4AVobybQfxDgUWeavYxyGiOsWk+2XmS8nyibyrQpeya5LGGfSEy0BiRPhXnVS9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231668; c=relaxed/simple;
	bh=STTb97XVBz3WjzVy6MSRqy7ftFl5sqfmRKl6jqsdREA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gxBPMzoyUPY7SHfPH58AYgl9zY3RgfrDBnE5lS2cJi02lTSMQ3oUzuR6F7fcDhVMUvp1Il1AlW/RC/hLc71i0uiCctvHNUXwldi/pRIedJZTWSgOugzvudDb5kFANbfVyHV0jJv1UdHVCQTWTOcPpDFPDU/1DxKppdqr0zO4IhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XS3oO0K4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XS3oO0K4"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L79tZi018964;
	Wed, 21 Aug 2024 09:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=v3C0hKwf6U5koWi3YHL8Ch
	lv9pfgBpLCqynad2rPYq0=; b=XS3oO0K4W/XOgXc92ePrmgsJ5rSToxJCgWoI9X
	6HG44dIxoSzTKsei0MH+vh44AXxgitZvMCgrOBMw3RpR1rvoUqAIkOIRCUnevCy2
	wOU7QYcTWXmw1ldQZWdStsB2+DKaE/cn7XykIIj6thh8QbAiyfqr2FWLjleAKic4
	U9krCFheyMxTRJA6CCQR838UJHWbiL74fMgNFlsRNNJ4Z3zZotA4mI/McL01OIIh
	wXNpLm4u71PAKTiOmvjka/Ca50W/1N59AQw0sMdVVwIw+3WARqQWWR6y3vtreFs2
	PTrVqTB6T+K+fpzA43+0rOydrmkyuNC3nHH3bTovc54Z1VXA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 415bkw8gd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 09:14:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47L9E0bx008690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 09:14:00 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 21 Aug 2024 02:13:59 -0700
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] Bluetooth: hci_qca: Drop unused event during BT on
Date: Wed, 21 Aug 2024 17:13:40 +0800
Message-ID: <20240821091340.424248-1-quic_chejiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: N7a39AYMGz7ssiMFPz5wJNEdWTNk6q15
X-Proofpoint-GUID: N7a39AYMGz7ssiMFPz5wJNEdWTNk6q15
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210066

For the WCN6750/WCN6855/WCN7850, the vendor command for a baudrate
change is not sent as synchronous HCI command, controller sends the
corresponding vendor event with the new baudrate. It needs to be
dropped, otherwise it may be misinterpreted as response to a later
command.

According to
80-WL520-14_REV_F_Bluetooth_HCI_Vendor_Specific_Commands_Application_Note.pdf
event for set baudrate HCI command is sent with event code
HCI_EV_CMD_COMPLETE(0x0e), add related handle in qca_recv_event when
sending set baudrate HCI command.

Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ca6466676902..8dacf6dcf248 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1206,7 +1206,14 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
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
+		if (hdr->evt == HCI_EV_VENDOR || hdr->evt == HCI_EV_CMD_COMPLETE)
 			complete(&qca->drop_ev_comp);
 
 		kfree_skb(skb);
@@ -1497,6 +1504,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 
 		switch (soc_type) {
 		case QCA_WCN3990:
+		case QCA_WCN6750:
+		case QCA_WCN6855:
+		case QCA_WCN7850:
 			reinit_completion(&qca->drop_ev_comp);
 			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
 			break;
@@ -1531,6 +1541,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 
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


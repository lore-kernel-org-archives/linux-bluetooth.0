Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J6+INRGt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8F910F0
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 00:07:46 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT5n1f4027378;
	Wed, 29 Nov 2023 08:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4ibW5TqnvxPA2v0dts9LvKAtf7SpwgPyclgfqSCb0oc=;
 b=J6+INRGt7pK3aNgAfjPA0OKeAndD1J12SXeDufvM9RA6yWWxRJ1xbOxZoU82dzMsufkK
 vtIPnEaBPGdfrOzeUy3Y5ayLqGrjj1QXNsUBNEaL0ZVB+Dcea8rENlvS7cKK4gMQtfsC
 cTSt6b6FSjI0/00r1hBX8RCDud/Axl95BwLqvXUwlkYbjfO4eS85xJEnEsCcYwPbxpQl
 P1oXRrjTZbbJItH8ssioHtZ7TNw5H1DTXCguY9e54x6CkcjQbbC6FkwPi11w+4pX4TOE
 WRFZA4zcptWi8i0ndRFNuXzcXvmTCkvRp84EY8oa1YlmT5OlRgusN1oG04OwOc/Wb/wi Uw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unnpesm25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 08:07:43 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT87g31028758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 08:07:42 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 00:07:38 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>,
        Zijun Hu
	<zijuhu@qti.qualcomm.com>
Subject: [PATCH v2 0/2] Bluetooth: Support SCO offload for QCA2066
Date: Wed, 29 Nov 2023 16:07:33 +0800
Message-ID: <1701245255-12409-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1699251565-28759-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1699251565-28759-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: BRmSRI22xzFwhiZsRvrRyMOfbtDEZCoX
X-Proofpoint-ORIG-GUID: BRmSRI22xzFwhiZsRvrRyMOfbtDEZCoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_04,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=444 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290059

From: Zijun Hu <zijuhu@qti.qualcomm.com>

This patch series are to support SCO offload for QCA2066, ALL BTHOST
needs to do is specifying both Input_Data_Path and Output_Data_Path
as 0x01 for HCI_Enhanced_Setup_Synchronous_Connection, does NOT need
to configure data path by HCI_Configure_Data_Path at all.

Changes form V1->V2:
- Bluetooth: qca:
- - Add and correct inline comments 

Zijun Hu (2):
  Bluetooth: hci_conn: Check non NULL before calling
    hdev->get_codec_config_data()
  Bluetooth: qca: Support SCO offload for QCA2066

 drivers/bluetooth/hci_qca.c | 19 +++++++++++++++++++
 net/bluetooth/hci_conn.c    |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center


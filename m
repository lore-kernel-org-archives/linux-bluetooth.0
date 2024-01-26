Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31275579B
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259657; cv=none; b=fx3zyIgmZdY1wbUWzRQTCsnD733VdcvhFfwYq7FaFAB9FBHpqn2oXPXk++Ua8szzclVX/+LnGgme8H9HzVAcI7wKuulWUtY/aRxIElHnuRtiCwJPdfUmrXR6jrOg+DLV1akMdDIeqe805zdl7aINkfWdPonqX2y8/U1pkzJz3pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259657; c=relaxed/simple;
	bh=LfxsHEyFIqcJCBenDpuiLEW4WgeyR25DIBqxNnB2f9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=izT1Efc7vIFZclYsCAteXpc8Dsmue2ODd3jCrHgOcwKbikJSxfx1izJckg/HnZZ/NaLFgitJ/p31rs8NzKxH2DK5n1SU6mh/Z0gm/4es77q4uihbA3C+RRpU8XlOdTMDn2zU2MRUWV0yNl4h6iK9XD3A+IMlUTYBJhH6mcbJaRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hSJotDoC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hSJotDoC"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40Q7ZnHu011008;
	Fri, 26 Jan 2024 09:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Yabe2tqyDBNl8oCzo3vSM19degE87lfvtFbklLGTMaY=; b=hS
	JotDoClTf27r/chDouQURoAnQ6w7zGaIiK+8/RuuyKzMOFo4Kyr9c4+3FXF3I8Wz
	hhb5d379gDkf/9a40yfRoq4IgbRrbhpK5perItGa5p2fkAzvjNPV4c96U1Edd2Ef
	kaJOs777yRlq16G5HZfH75zzwu4xEzVvMAFhW6qkOdyK/tcahFyGGuS3iEN7xMGT
	eoX589SuEdn8v5L22Mhh/WOcpzl2/zwSRRyPY5dMHH7b/FHdwb9R1RCWa96YtjRZ
	riCI8sdIAwRYTCdwLvnFNDA3/fp4xfSZY9FFOPFvHtf5L8t7fmb5FBvKMNoN0TAJ
	YOHrn2YNh5g5minfadXA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv101935b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 09:00:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40Q90i53021701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 09:00:44 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 01:00:42 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <mmandlik@google.com>, <quic_saluvala@quicinc.com>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v1] Bluetooth: qca: Fix triggering coredump implementation
Date: Fri, 26 Jan 2024 17:00:24 +0800
Message-ID: <1706259624-12518-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ew2HOGmfvGtMuvC2CY3wL1U8eM1LY3fh
X-Proofpoint-GUID: ew2HOGmfvGtMuvC2CY3wL1U8eM1LY3fh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1011 phishscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260064

hci_coredump_qca() uses __hci_cmd_sync() to send a vendor-specific command
to trigger firmware coredump, but the command does not have any event as
its sync response, so it is not suitable to use __hci_cmd_sync(), fixed by
using __hci_cmd_send().

Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 94b8c406f0c0..f989c05f8177 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1806,13 +1806,12 @@ static int qca_power_on(struct hci_dev *hdev)
 
 static void hci_coredump_qca(struct hci_dev *hdev)
 {
+	int err;
 	static const u8 param[] = { 0x26 };
-	struct sk_buff *skb;
 
-	skb = __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb))
-		bt_dev_err(hdev, "%s: trigger crash failed (%ld)", __func__, PTR_ERR(skb));
-	kfree_skb(skb);
+	err = __hci_cmd_send(hdev, 0xfc0c, 1, param);
+	if (err < 0)
+		bt_dev_err(hdev, "%s: trigger crash failed (%d)", __func__, err);
 }
 
 static int qca_get_data_path_id(struct hci_dev *hdev, __u8 *data_path_id)
-- 
2.7.4


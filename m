Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C5EE86Ii"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E76D40
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 00:08:01 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT4vZqp003395;
	Wed, 29 Nov 2023 08:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=13+4W0mP2syXnotM3JGgG55WjDNmDtDoFjjtXNYIuNk=;
 b=C5EE86IiydAkA79vdM38z2czzI8WRD5HxKWYrr7YJf29qWRnDre0mTn9pRT0ELUGCGbd
 Kzg34TSaxoeUeHLdB8u4FJagVH7T7igscE07KzH+m1J99fufl9yVMkk0MlFxWVNCkoFJ
 aS0douljTGVCoJhkiaqofs6p2iTWMb1sqAIKNaO/CHb0QH7hFrJrPEGaY1X9wjCFTqFm
 dKjLUTAODSi50dDVD5mhMPQpIjauHs3pJkngB8KO3iQ7sDzZYmB6QR3ckBNdLQbO2gkf
 HpggfDUEbxE+7YZAx+wiuPj3YryMYEy8w77lzTalvNFrMR7wv36AzPN7F0nB+LNEJmN8 OQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ungruancv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 08:07:48 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT87l3r020867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 08:07:47 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 00:07:45 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>,
        Zijun Hu
	<zijuhu@qti.qualcomm.com>
Subject: [PATCH v2 2/2] Bluetooth: qca: Support SCO offload for QCA2066
Date: Wed, 29 Nov 2023 16:07:35 +0800
Message-ID: <1701245255-12409-3-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701245255-12409-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1699251565-28759-1-git-send-email-quic_zijuhu@quicinc.com>
 <1701245255-12409-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: PWpdvbSZlD4fWlYIqFYr2m0CUoLroi9m
X-Proofpoint-ORIG-GUID: PWpdvbSZlD4fWlYIqFYr2m0CUoLroi9m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_05,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=906 spamscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290059

In order to support SCO offload for QCA2066, ALL BTHOST needs to do
is specifying both Input_Data_Path and Output_Data_Path as 0x01 for
HCI_Enhanced_Setup_Synchronous_Connection, and it is implemented by
this change.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 35f74f209d1f..68347b2a204a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1815,6 +1815,21 @@ static void hci_coredump_qca(struct hci_dev *hdev)
 	kfree_skb(skb);
 }
 
+static int qca_get_data_path_id(struct hci_dev *hdev, __u8 *data_path_id)
+{
+	/* QCA uses 1 as data path id for SCO offload */
+	*data_path_id = 1;
+	return 0;
+}
+
+static int qca_configure_sco_offload(struct hci_dev *hdev)
+{
+	bt_dev_info(hdev, "SCO offload is supported");
+	hdev->get_data_path_id = qca_get_data_path_id;
+	hdev->get_codec_config_data = NULL;
+	return 0;
+}
+
 static int qca_setup(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -1969,6 +1984,10 @@ static int qca_setup(struct hci_uart *hu)
 		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
 	else
 		hu->hdev->set_bdaddr = qca_set_bdaddr;
+
+	if (soc_type == QCA_QCA2066)
+		qca_configure_sco_offload(hdev);
+
 	qca->fw_version = le16_to_cpu(ver.patch_ver);
 	qca->controller_id = le16_to_cpu(ver.rom_ver);
 	hci_devcd_register(hdev, hci_coredump_qca, qca_dmp_hdr, NULL);
-- 
The Qualcomm Innovation Center


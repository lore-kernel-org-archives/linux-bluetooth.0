Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y88558sv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89E61BDD
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 17:53:19 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7FvMvW024632;
	Fri, 8 Dec 2023 01:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7t8GwHUUeRPaUwK0WnhHUKVY/nygcJJS4NxSi26jJyw=;
 b=Y88558sv9ywz36GnvJQwa+zS0Qbl7Uzg43DlbcezAgw8uB2gryGmwOrcSTU3CvFnqeNZ
 k9dOw/IneaRIunxant0jR6i3MoGzLrGlTb60Qmx6D6wqiKre+fxAQ50tW0LTuaZSBt6E
 czg2sPp+MAU+rbUylbhch6pL91FJ90M4qayZVIWxAhGiEBoSdSfD2VttS3JZAUfDSy9F
 VL03YAKc3fr8EXSSRhkNQkm9rka41sfOodnzP6dE6dvxBtumlFXqoQODepllfIvm6XAZ
 FUYdKrK5Dm7E1yEUT85GjKdH19LCgXjuySDw+R5K6jQCmstEmKONfbS24VABEnrGrUqm vw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu6qr2xxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Dec 2023 01:53:15 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B81rFOh017033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Dec 2023 01:53:15 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 17:53:12 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v4 2/2] Bluetooth: qca: Support HFP offload for QCA2066
Date: Fri, 8 Dec 2023 09:51:27 +0800
Message-ID: <1702000287-22538-3-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702000287-22538-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1701246570-3564-1-git-send-email-quic_zijuhu@quicinc.com>
 <1702000287-22538-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: RMJ73w0g_OG3lta0LDtD_PCGspea-q1L
X-Proofpoint-ORIG-GUID: RMJ73w0g_OG3lta0LDtD_PCGspea-q1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_19,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080014

For QCA2066 HFP offload, HCI_Configure_Data_Path is not required since
present HCI_Enhanced_Setup_Synchronous_Connection is enough to configure
non-HCI data transport path when set both Input_Data_Path and
Output_Data_Path parameters as 0x01, as is implemented by this change.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 35f74f209d1f..94b8c406f0c0 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1815,6 +1815,24 @@ static void hci_coredump_qca(struct hci_dev *hdev)
 	kfree_skb(skb);
 }
 
+static int qca_get_data_path_id(struct hci_dev *hdev, __u8 *data_path_id)
+{
+	/* QCA uses 1 as non-HCI data path id for HFP */
+	*data_path_id = 1;
+	return 0;
+}
+
+static int qca_configure_hfp_offload(struct hci_dev *hdev)
+{
+	bt_dev_info(hdev, "HFP non-HCI data transport is supported");
+	hdev->get_data_path_id = qca_get_data_path_id;
+	/* Do not need to send HCI_Configure_Data_Path to configure non-HCI
+	 * data transport path for QCA controllers, so set below field as NULL.
+	 */
+	hdev->get_codec_config_data = NULL;
+	return 0;
+}
+
 static int qca_setup(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -1969,6 +1987,10 @@ static int qca_setup(struct hci_uart *hu)
 		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
 	else
 		hu->hdev->set_bdaddr = qca_set_bdaddr;
+
+	if (soc_type == QCA_QCA2066)
+		qca_configure_hfp_offload(hdev);
+
 	qca->fw_version = le16_to_cpu(ver.patch_ver);
 	qca->controller_id = le16_to_cpu(ver.rom_ver);
 	hci_devcd_register(hdev, hci_coredump_qca, qca_dmp_hdr, NULL);
-- 
The Qualcomm Innovation Center


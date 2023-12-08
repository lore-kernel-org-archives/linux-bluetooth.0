Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VuYT4fJB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7EC10F8
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 09:17:26 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8GikEO010703;
	Fri, 8 Dec 2023 17:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=FRkzBWbsrgB6T/si1igAXNIYPaIomWSnuX0TYm3WwMo=;
 b=VuYT4fJBe/u1s7Dm3XmWEZX66RgTkyjC7sz6zCjqkXwDeFl2JbybnBZjThDitXWsA7zB
 4KUTAzS6iogmfNqF7lk0crkVd6O7EvbORQAR3N8YpsKCLAGypr9QHp15HYtytMq1NlGd
 UnAxIQC56JSRQJTTDFbWTAYfairNy5qsfvQ3/9cBlNx5n33ep3hYPUoUUqTtIS33XGa0
 jbBKOJp0yw2OEzi2Matp7SCbPHnWoCvs5u6FYdrXYiWbnIHfA4b5pXA4yzR71imeWoYs
 p8thNz8vw1CpoQkFRbwaX5IMzB1YZ58c4fZk23WCAFiEkY9wMGYoGo7JMo+1jrShpwPz Lg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uv5wpg8wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Dec 2023 17:17:22 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B8HHLOl001037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Dec 2023 17:17:22 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Dec 2023 09:17:20 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v1] Bluetooth: hci_conn: Remove a redundant check for HFP offload
Date: Sat, 9 Dec 2023 01:17:14 +0800
Message-ID: <1702055834-18008-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hB3bI-LokqVT0L09Q--dTkUXOwe0uzSa
X-Proofpoint-ORIG-GUID: hB3bI-LokqVT0L09Q--dTkUXOwe0uzSa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_11,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=827 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080143

Remove a redundant check !hdev->get_codec_config_data.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/bluetooth/hci_conn.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a41d2693f4d8..a4c96bd202fd 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -300,13 +300,13 @@ static int configure_datapath_sync(struct hci_dev *hdev, struct bt_codec *codec)
 	__u8 vnd_len, *vnd_data = NULL;
 	struct hci_op_configure_data_path *cmd = NULL;
 
+	/* Do not take below 2 checks as error since the 1st means user do not
+	 * want to use HFP offload mode and the 2nd means the vendor controller
+	 * do not need to send below HCI command for offload mode.
+	 */
 	if (!codec->data_path || !hdev->get_codec_config_data)
 		return 0;
 
-	/* Do not take me as error */
-	if (!hdev->get_codec_config_data)
-		return 0;
-
 	err = hdev->get_codec_config_data(hdev, ESCO_LINK, codec, &vnd_len,
 					  &vnd_data);
 	if (err < 0)
-- 
The Qualcomm Innovation Center


Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gjstbkZS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B749A199A
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 17:53:08 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B81iPwW002097;
	Fri, 8 Dec 2023 01:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=s3VOeOM0sH9J27r3Ie6EF6nJL+3UXoV1W2G/60foAxY=;
 b=gjstbkZSYctV6YpWDCOAa7UDV8gjn78Xdb/HjoAHkueuG7HyfsTqnEYyK4qgXELobLRC
 GkKfiQhtQ/Ijri+EnImikhQsLFzRGO/AJQapf7kIF1D+/z+pRTMS7iNwux72tIc0FSzR
 PjF8aa8Y0MiX4e0aYMlKM44V/GRZToEUXGf+yCEw+r4ILotIGUdAHbGxlcOj9w+xd1Ly
 jwLZi4S66Lv6qSnj8zt54zK+Fdh7NXBpWGjSbG/WoQgiMbgX5pOD1uw+RtacNVyS9kms
 +DDPMKe7L9AGSwX6DaFf9HoHQj8vKmDl4ZKwMa3E6LOe4opIf6Oa8z3XO3EjN7OFiedh yQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu6qr2xxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Dec 2023 01:53:04 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B81r3hQ024656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Dec 2023 01:53:03 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 17:53:01 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v4 1/2] Bluetooth: hci_conn: Check non NULL function before calling for HFP offload
Date: Fri, 8 Dec 2023 09:51:26 +0800
Message-ID: <1702000287-22538-2-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: 1QUr7naCmYMyc3bO_H6Fpkyoi75d20DL
X-Proofpoint-ORIG-GUID: 1QUr7naCmYMyc3bO_H6Fpkyoi75d20DL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_19,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080014

For some controllers such as QCA2066, it does not need to send
HCI_Configure_Data_Path to configure non-HCI data transport path to support
HFP offload, their device drivers may set hdev->get_codec_config_data as
NULL, so Explicitly add this non NULL checking before calling the function.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/bluetooth/hci_conn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a09071059214..0b757c3a7331 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -300,6 +300,10 @@ static int configure_datapath_sync(struct hci_dev *hdev, struct bt_codec *codec)
 	__u8 vnd_len, *vnd_data = NULL;
 	struct hci_op_configure_data_path *cmd = NULL;
 
+	/* Do not take me as error */
+	if (!hdev->get_codec_config_data)
+		return 0;
+
 	err = hdev->get_codec_config_data(hdev, ESCO_LINK, codec, &vnd_len,
 					  &vnd_data);
 	if (err < 0)
-- 
The Qualcomm Innovation Center


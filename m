Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LBpOhikD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348A810F0
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 00:18:40 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT3FmY3028475;
	Wed, 29 Nov 2023 08:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=UdXxIm20CMp25OlGrffrUgJTYDUDbBe+vI4+30bSar8=;
 b=LBpOhikDszB7dB97wxU4nVRcD3txkYJ2ryWZkl5wX/SRadg8P66QJNeWdtkR2ndJf9qF
 e8heLqC9WuHSGQ5SM4LW+7JHwi1ClLDhGf0P8CI4x5h+AVKaU2PHyyP5oyrggT8HHluZ
 6yzyioaFDIjvWjShGye9pfiwMS10hYgM8lI4tA5ipibzUHvrrAJGfg3m2ItaU4av7rn5
 9VFm85ArOwHnCNTx8uDrIQHC64hZafpWk9GxG82cuwgwdbO2OCo98Cb/ot4cVzJBfr2N
 wkYvHBE1D9oDNAABbSfWg3kSW0195RKEux0fXweOKNeZNim+QpNxTEIfE6HfmV9dyDij HA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unnpesmrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 08:18:37 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT8Iano012648
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 08:18:36 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 00:18:34 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>,
        Zijun Hu
	<zijuhu@qti.qualcomm.com>
Subject: [PATCH v2 1/2] Bluetooth: hci_conn: Check non NULL before calling hdev->get_codec_config_data()
Date: Wed, 29 Nov 2023 16:18:25 +0800
Message-ID: <1701245906-10660-2-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701245906-10660-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1699251565-28759-1-git-send-email-quic_zijuhu@quicinc.com>
 <1701245906-10660-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: 4AQ6C3kY7R-vospzkHucJLUVeW94jWSX
X-Proofpoint-ORIG-GUID: 4AQ6C3kY7R-vospzkHucJLUVeW94jWSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_04,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290060

Explicitly add non NULL checking before calling
hdev->get_codec_config_data().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a09071059214..21b59d674717 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -346,7 +346,7 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	/* for offload use case, codec needs to configured before opening SCO */
-	if (conn->codec.data_path)
+	if (conn->codec.data_path && hdev->get_codec_config_data)
 		configure_datapath_sync(hdev, &conn->codec);
 
 	conn->state = BT_CONNECT;
-- 
The Qualcomm Innovation Center


Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pfg54nUq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE6A211C
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 00:29:39 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT6URHs031218;
	Wed, 29 Nov 2023 08:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=IC/mhpo7YyfKXF9jaGQsU9RHUJn7bpdp2CxQy+2gOww=;
 b=pfg54nUqYkZQR3jhtgKQa4CUzDcif7sdn+mtWKryxDTIszA1YhC13+LkgEpQ9bH5n6Xk
 6U4QHxxh/MXoVO4hG0TT7p4I5v3KcNZEV4+seQXnS3Rft1B1VwXjSMFAlggGxLLgJRSJ
 6D5ur8vm9cuWK3CQJJNWiVLtN59EkEehR1vcxjkcVqMyba774CbAj5k5hB8i9f1TR2e0
 1BzBB+mu4hYPXQBWOhqDTC27LwLjxqyIVrZKBJ+MdR7KkXHTxTSxQHBc7ElHOwXSkYlr
 JFQ1zJEVbHzHTU8TAkBC/1nnZDX2tDHxtrp9LSuRqv0eRbsZz64U2HPAXB5zHM0CKxCX 6Q== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up02xra3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 08:29:36 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT8TZUl028627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 08:29:35 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 29 Nov 2023 00:29:33 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>,
        Zijun Hu
	<zijuhu@qti.qualcomm.com>
Subject: [PATCH v3 0/2] Bluetooth: Support SCO offload for QCA2066
Date: Wed, 29 Nov 2023 16:29:28 +0800
Message-ID: <1701246570-3564-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701245906-10660-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1701245906-10660-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: U_gRvJGP8Xhtt01JOHH4RCqMwZ4HVZ73
X-Proofpoint-GUID: U_gRvJGP8Xhtt01JOHH4RCqMwZ4HVZ73
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_06,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=505 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290062

From: Zijun Hu <zijuhu@qti.qualcomm.com>

This patch series are to support SCO offload for QCA2066, ALL BTHOST
needs to do is specifying both Input_Data_Path and Output_Data_Path
as 0x01 for HCI_Enhanced_Setup_Synchronous_Connection, does NOT need
to configure data path by HCI_Configure_Data_Path at all.

Changes form V2->V3:
- Bluetooth: qca:
- - Add and correct inline comments 

Changes form V1->V2:
- No changes, sent by mistake

Zijun Hu (2):
  Bluetooth: hci_conn: Check non NULL before calling
    hdev->get_codec_config_data()
  Bluetooth: qca: Support SCO offload for QCA2066

 drivers/bluetooth/hci_qca.c | 24 ++++++++++++++++++++++++
 net/bluetooth/hci_conn.c    |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center


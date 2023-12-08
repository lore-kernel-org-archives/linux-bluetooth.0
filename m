Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f9DXODL0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D223171E
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 17:52:37 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B811ewl028731;
	Fri, 8 Dec 2023 01:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fFeFl2Qu5Y6AiPGZvLEK05jRC/tBxuMbcYYStxbRw5U=;
 b=f9DXODL0ad/LFmoTEsuWXJCL93w7mNfCnsfXVJQO6VdfPzSbwdtZ779fxkMdu077Q34l
 RsPPbPuNp0/5qFtwn9Q8Ros5GRLvw1od1nIj+T7KxjR2NoPjHfk/i0Y4UEfnwCMsNaI8
 NasXlFaa1wpzvM8eSdrwzmTnE6PE84mfZeBKTAzGOhtPXYmj3/n4S9WV7ftIBhQ91fC7
 PfhVPFzoqoVrScJZxa1CUeJwpuZ8vNYofXmusrWeLRNEewieisY9FVTHaeKQM4hUIz6P
 uaVaemryZCKaw21AwiheiAHENBL0Po2zblBfec+Ueg86KZqbwydzMbKOVyPP9HD9E5Xp 2w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu2trk956-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Dec 2023 01:52:33 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B81qWZc005182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Dec 2023 01:52:32 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 17:52:30 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v4 0/2] Bluetooth: Support SCO offload for QCA2066
Date: Fri, 8 Dec 2023 09:51:25 +0800
Message-ID: <1702000287-22538-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701246570-3564-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1701246570-3564-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: ejfCDJU8XrcMXVskHPTdIUm-If_dX3yW
X-Proofpoint-ORIG-GUID: ejfCDJU8XrcMXVskHPTdIUm-If_dX3yW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_19,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=466
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080014

This patch series are to support HFP offload for QCA2066.

Changes form V3->V4:
- Bluetooth: hci_conn:
- - Move non NULL checking into configure_datapath_sync()
- Bluetooth: qca:
- - Optimize commmit messages and comments and function names

Changes form V2->V3:
- Bluetooth: qca:
- - Add and correct inline comments

Changes form V1->V2:
- No changes, sent by mistake

Zijun Hu (2):
  Bluetooth: hci_conn: Check non NULL function before calling for HFP
    offload
  Bluetooth: qca: Support HFP offload for QCA2066

 drivers/bluetooth/hci_qca.c | 22 ++++++++++++++++++++++
 net/bluetooth/hci_conn.c    |  4 ++++
 2 files changed, 26 insertions(+)

-- 
The Qualcomm Innovation Center


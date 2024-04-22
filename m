Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6C1E49F
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797523; cv=none; b=V0mCaZEcRTjbNLAIEK9xmvop1whUNBc0luBShKXa2uUbAtItwWdCpENPLisztPGU/VMMTIHVcFkuaoxxMKwFh3vKe/+Mci2OFYNmQYtg5ONCaM4NGAdz2GsVthMc4GODN23Qy8DkPVl015Pu1b4BBPZC70nKKLDd8e258xkuAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797523; c=relaxed/simple;
	bh=anLiT6AX+MT+IFXFuu19pvkyVV0nthLVgBGMW5cVxcM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZyl4dGZLS4GETMjNF6qHK/7See4hqp6TVPiTqcQb+g/TgljPN6e6VCSfNUELnyog45NuIK1JHieOVBgfCKdLbuqrQMI/rpXga3ehIxClhaPdzGgb5Vpyn4/rk/bo17X2ykplfeavPolhTdqFCoWx3yawJENQGkvVZ5G2o7hNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TPES2F+i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TPES2F+i"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MCYjcv015310;
	Mon, 22 Apr 2024 14:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=S0Z1nYV2CUsVBceVnzRC
	Av/jLCjReS0wQU/v5SUQaJE=; b=TPES2F+iOSqpz6HsjYla2tuwiRHU8oGcW2DW
	WjOmT1CwZZlgud9BKRzC5ANwFEmh7tuJdEqwByKbGs8mSr9vqHEYHDdZEHxMW969
	dbtmg60qwC5ZF7TdSxxzRTDw1NTszETf//xv5W5vfHHLMAt3kxnF8xWVIY6TRdkK
	o3fBQJwXKQIN9aG6jouYRp4/bctKM544SJAz2f8ktWEJt/RYk0tQbYoGmK8PNFm4
	TFRcFLqyxxX7eEfxJG68LCLaJjKKrBz9AZty4q26sskEkRHAvO0DGcmnlQ/whuZv
	/Dbs98s2/7yqqkfwuRKXOYz6Hv2byYb9dvgUwVu5qDnQPWm6fg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnne28rd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:51:57 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MEpun2000526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:51:56 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 07:51:54 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1 RESEND] Bluetooth: Remove 3 repeated macro definitions
Date: Mon, 22 Apr 2024 22:51:50 +0800
Message-ID: <1713797510-24495-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1704805724-8050-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1704805724-8050-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: SGj_MYiCOz--TtHsjZ-Dz12dgmT0yk11
X-Proofpoint-ORIG-GUID: SGj_MYiCOz--TtHsjZ-Dz12dgmT0yk11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220064

Macros HCI_REQ_DONE, HCI_REQ_PEND and HCI_REQ_CANCELED are repeatedly
defined twice with hci_request.h, so remove a copy of definition.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/bluetooth/hci_request.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 0be75cf0efed..c91f2838f542 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -24,20 +24,16 @@
 
 #define HCI_REQ_DONE	  0
 #define HCI_REQ_PEND	  1
 #define HCI_REQ_CANCELED  2
 
 #define hci_req_sync_lock(hdev)   mutex_lock(&hdev->req_lock)
 #define hci_req_sync_unlock(hdev) mutex_unlock(&hdev->req_lock)
 
-#define HCI_REQ_DONE	  0
-#define HCI_REQ_PEND	  1
-#define HCI_REQ_CANCELED  2
-
 struct hci_request {
 	struct hci_dev		*hdev;
 	struct sk_buff_head	cmd_q;
 
 	/* If something goes wrong when building the HCI request, the error
 	 * value is stored in this field.
 	 */
 	int			err;
-- 
2.7.4


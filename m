Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741D7FBDA
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563378; cv=none; b=oAsk9E5/EQLLhBtrRlSGpauqhEyzUVpPitpkMTxobxWnwdO5S19kmXC2nx9yzzInSEocOTOPkpX5ENaXek2hF4GQXKi9opSeRPIDYfhWVf3Iy0J0ZB8YQMDw+FhEh2qH4eHfgM2hXsehiD7SeI89L37hnuJcv6GFs5WCUpZniNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563378; c=relaxed/simple;
	bh=jp6fCbYsQLMHFHDcSLprKtDEyfs6nA2M5l8PgzaI8Qs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUJ8yd+svfEDjc2TM3+NSSaQNHpHNdLBdyHBbSPt1GYNon2emh6vUkg/ZSTEnqIF42GQNzDYm7tHZOzyUGc6rFkGz48ZV6otD/H0W1B11dqSZoluNhoYlzQYU1vNRMZKlarPZ/S5TRZlVFfoZos2BE7g7+TKSjOL80x/+Rznlhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nF3kubi4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nF3kubi4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JGdTc9024699;
	Fri, 19 Apr 2024 21:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=Q71AAIMpmqFARbo5CZiU
	RBFiamP0y4yfBDEyD/p/0K0=; b=nF3kubi4y9FRXOV9hvYUfN6F4AVqx93+W5vA
	Rj+MSgV1+J7+FIqa6Y+zs43wMAjd//lyR7N6wF/lC4zFZmNX2xHffPFXq78qMffG
	7qxsegkZ0P28Cp8md8gc7CNG7qUUuIjLfUibwV7HZrMJXBclG1J3V0upW4GlZvHs
	UpWshiIAXF7IEqgw5xk/npTB0XE0irzqh2kB2iqqGB6r/f2TVBYntQx2gbeHJFo6
	oTdazBxoq0Gln5+tf6L2PpRHojxLFhfoibVX3rEoO4rCwBg8saPFlmVZZgBjCOc1
	zu6QiFiGN/Po5YZuDG4iLHACDkStlmSBAtbJSGxEBBzsflmfvg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xkgrea1hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 21:49:30 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43JLmuwB018493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 21:48:57 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 19 Apr 2024 14:48:55 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>
Subject: [PATCH v2 1/2] Bluetooth: MGMT: Fix failing to MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID
Date: Sat, 20 Apr 2024 05:48:46 +0800
Message-ID: <1713563327-19694-2-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713563327-19694-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713563327-19694-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: EMtjf2AVbpyYP6EAVFwjo4ouOxozFqun
X-Proofpoint-GUID: EMtjf2AVbpyYP6EAVFwjo4ouOxozFqun
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_15,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404190170

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These commands don't require the adapter to be up and running so don't
use hci_cmd_sync_queue which would check that flag, instead use
hci_cmd_sync_submit which would ensure mgmt_class_complete is set
properly regardless if any command was actually run or not.

Link: https://github.com/bluez/bluez/issues/809
Fixes: d883a4669a1d ("Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7129e70a0253..68deec968405 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2623,7 +2623,11 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto failed;
 	}
 
-	err = hci_cmd_sync_queue(hdev, add_uuid_sync, cmd, mgmt_class_complete);
+	/* MGMT_OP_ADD_UUID don't require adapter the UP/Running so use
+	 * hci_cmd_sync_submit instead of hci_cmd_sync_queue.
+	 */
+	err = hci_cmd_sync_submit(hdev, add_uuid_sync, cmd,
+				  mgmt_class_complete);
 	if (err < 0) {
 		mgmt_pending_free(cmd);
 		goto failed;
@@ -2717,8 +2721,11 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	err = hci_cmd_sync_queue(hdev, remove_uuid_sync, cmd,
-				 mgmt_class_complete);
+	/* MGMT_OP_REMOVE_UUID don't require adapter the UP/Running so use
+	 * hci_cmd_sync_submit instead of hci_cmd_sync_queue.
+	 */
+	err = hci_cmd_sync_submit(hdev, remove_uuid_sync, cmd,
+				  mgmt_class_complete);
 	if (err < 0)
 		mgmt_pending_free(cmd);
 
@@ -2784,8 +2791,11 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	err = hci_cmd_sync_queue(hdev, set_class_sync, cmd,
-				 mgmt_class_complete);
+	/* MGMT_OP_SET_DEV_CLASS don't require adapter the UP/Running so use
+	 * hci_cmd_sync_submit instead of hci_cmd_sync_queue.
+	 */
+	err = hci_cmd_sync_submit(hdev, set_class_sync, cmd,
+				  mgmt_class_complete);
 	if (err < 0)
 		mgmt_pending_free(cmd);
 
-- 
2.7.4


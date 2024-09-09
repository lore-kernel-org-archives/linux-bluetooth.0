Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F4B4C81;
	Mon,  9 Sep 2024 03:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725851379; cv=none; b=E2ONXfOHRFl5hF+xoG3Wdd5+WaMbatmv/cTOvUKN5oakjt5rwNsKD6uS5syPBl48ME0Fobwvm/eaqKec8cbH2bOnoMQYTsx63I3FHlnjA3xZ0wh8dEh3S3kNoSie3royG+byA7ZB4K/lQFqnROJWxXyIlM1vjVHoHbmYGGecBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725851379; c=relaxed/simple;
	bh=Qn1xwmbieFJo2P3HZjsMlyrGYEfUrw7eYRCJ9Cvtkgc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U0yXc/F9fMc3FCo1tJzI7Xg0RStShrj2Fsw6dGWC9dNDAL0fyBph/cFrwui09eRXebDQpIsBGjkY6eSqcWUmkbYSNJY/qGFRpAL70GmSMCgyBVK60bhpwGSsWQppNw4incKavAsUxwCUEytcvtEpIBr22uUvk9tINX4yYVpB1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a2j8b43m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a2j8b43m"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 488NWEhJ018316;
	Mon, 9 Sep 2024 03:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=A0mZDBa1peMp6ysKu0Owbb
	dmW7yzG9XZzXBo4iYrJXI=; b=a2j8b43mc2aEYxNGPOWnqdxLKgZo9V8f1Q7Stx
	30vrQ7aGe+osbKbHcRSdcgDHurIxSvKBwSa8PQLTW0GPDWXych+RP0SuWVa931cs
	l9pNcUs5CfRTo/rYsSLmi/1JnGEQoGkrJVg6JZN6wTvyQhwVaiWwiBcUg6xOhHN9
	134C7UcpQEG/kKa7uchPybPV2cCpYvrnYsj6E/Rygwrg7h9LPWcXn1xAMaG2Eqvd
	lCsPBXOd0Cqo626Ie5txmRbJnXnIWRAlKr1gU62n3DyqPaO6Wy7wrXR0VyOThZaz
	ZyAqsKERkEqzagVWxWHgFVcur/TfVZvjdcmfG8oKldQ1Z0Aw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy6shhcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 03:09:28 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48939S6e009707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 03:09:28 GMT
Received: from jiaymao-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 8 Sep 2024 20:09:26 -0700
From: Jiayang Mao <quic_jiaymao@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg
	<johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] Bluetooth: mgmt: Verify cmd pending status before removing it
Date: Mon, 9 Sep 2024 11:09:06 +0800
Message-ID: <20240909030906.26375-1-quic_jiaymao@quicinc.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9nkBzS1_BC_8i9d2NyzykCA4_i2Il0zA
X-Proofpoint-ORIG-GUID: 9nkBzS1_BC_8i9d2NyzykCA4_i2Il0zA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090025

From: jiaymao <quic_jiaymao@quicinc.com>

Add a verification step to ensure that a command is still in the pending
list before attempting to remove it. A crash may occur during the boot
process when Bluetooth is enabled and then immediately disabled. In a
race condition, mgmt_index_removed() might free the pending command
before mgmt_add_adv_patterns_monitor_complete() is called, leading to a
double free scenario.

Part of the crash call trace:
0x0000053D: __list_del_entry_valid_or_report+0x98/0xdc
0x0000053D: mgmt_pending_remove+0x18/0x58 [bluetooth]
0x0000053E: mgmt_remove_adv_monitor_complete+0x80/0x108 [bluetooth]
0x0000053E: hci_cmd_sync_work+0xbc/0x164 [bluetooth]

Signed-off-by: jiaymao <quic_jiaymao@quicinc.com>
---
 net/bluetooth/mgmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 25979f4283a6..9d019db92043 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5428,6 +5428,9 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
+	if (cmd != pending_find(MGMT_OP_REMOVE_ADV_MONITOR, hdev))
+		goto done;
+
 	rp.monitor_handle = cp->monitor_handle;
 
 	if (!status)
@@ -5437,6 +5440,7 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 			  mgmt_status(status), &rp, sizeof(rp));
 	mgmt_pending_remove(cmd);
 
+done:
 	hci_dev_unlock(hdev);
 	bt_dev_dbg(hdev, "remove monitor %d complete, status %d",
 		   rp.monitor_handle, status);
-- 
2.46.0


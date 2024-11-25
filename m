Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513541C92;
	Mon, 25 Nov 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557093; cv=none; b=gHbz32dNdxq7Wv35LfsSCVlC7kwVzPHyls2OnmnoRYpg7yzTZuBwJcu3+qI97/pOUQWP2KRxGONLwaWwJQlK5krN+SHj1te5+i26yB6B9nNHecRiXT1WdWH0YKUwQX//IHBazO7NccvHY1PkuR5jVXEhfHm/medvuGZmx1bDnuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557093; c=relaxed/simple;
	bh=lR3jSeY6/Aj1MICcZ//Z56OGkK0iYRaFnBMSFJZXgek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L8QGKCkzOm+dPGI+tS9itrAA5fPOjgDuH+QU8cWv63YT/dVqdenM1mSoXJn+aIvZW6Qep3GxSVXBOvrVNqUzOi4LDD3tZjLOFjxWycB6t//AP5r+C2NU5NVhvS4PTYUgKRNov1jteTjCSb/OVP6CGOk5RgdLV1KIRVa3dYaapkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MlU5z0nZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MlU5z0nZ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APBDkij007724;
	Mon, 25 Nov 2024 17:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oN4EWAUKm0pFB57IHsr3MB
	r4a/p3Cp7Zp4mWAEIQMgk=; b=MlU5z0nZeDb23hd1n9z++c6NA2mw8cUZxL8GcF
	2m77u1G3clAyWz1PUWjvZGs8L6kvnoOCd0ueGF92IDmHgCXRpq8zau/Gx0vrVhVj
	3dT6NM2r+TmYMgqouCsjGr77KsroyQzOQRYMG5LxgwafZpZTEqu+DYlisXqaiNWL
	4j3IZwbdjaq/EMmIBH4tL6L66cb3f3ePut7qB1fZR1cOMe/8FIn1weDDlZgjqHEM
	MCgExsM3Mvs9DtnzdoB/YgcDj8S0bs4xeQq24kZmLHWTNGmQR2A4RwfzEEjba0gn
	wW4GtwEXuVnbVluvsoo6g26TLDGsEGPJRTav5Cdh1IkTWqEw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 433626dn1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 17:51:28 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4APHpRJo032177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 17:51:27 GMT
Received: from jiaymao-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 25 Nov 2024 09:51:25 -0800
From: Jiayang Mao <quic_jiaymao@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg
	<johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_chejiang@quicinc.com>, <quic_jiaymao@quicinc.com>
Subject: [PATCH v1] Bluetooth: hci_sync: clear cmd_sync_work_list when power off
Date: Tue, 26 Nov 2024 01:51:11 +0800
Message-ID: <20241125175111.8598-1-quic_jiaymao@quicinc.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iykKNNxI1sxT_-MxZluZ08aLeUMGAa6v
X-Proofpoint-ORIG-GUID: iykKNNxI1sxT_-MxZluZ08aLeUMGAa6v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250148

Clear the remaining command in cmd_sync_work_list when BT is
performing power off. In some cases, this list is not empty after
power off. BT host will try to send more HCI commands.
This can cause unexpected results.

Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
---
 net/bluetooth/hci_sync.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c86f4e42e..bc622d074 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5139,6 +5139,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 {
 	bool auto_off;
 	int err = 0;
+	struct hci_cmd_sync_work_entry *entry, *tmp;
 
 	bt_dev_dbg(hdev, "");
 
@@ -5258,6 +5259,11 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	clear_bit(HCI_RUNNING, &hdev->flags);
 	hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
 
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
+		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+
 	/* After this point our queues are empty and no tasks are scheduled. */
 	hdev->close(hdev);
 
-- 
2.25.1


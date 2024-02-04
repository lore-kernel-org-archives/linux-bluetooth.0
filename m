Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A1A6FB9
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Feb 2024 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707023700; cv=none; b=QOeyLz+2MWdGNcNqnbmSVY3jQsJF/Ct9lV5FgmLzP9+btMHHjm5QQPnIIf+XwpTa5igNzRrboAX827slXNvFyAacnvtmI0dJPR340nzOWSdQi36/TSEMzIVtJIM1a703ZBynDlDwHc6T9nEtRHcIVU2den6nXR9Eqb0toVid9y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707023700; c=relaxed/simple;
	bh=atdLh6bKe2QDCxRtcu7RWfOZQgsLFz34yBttkQaHa1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HDbE6BltC2fiTS3xvHFjLwANMrHzuluJjO/i9SUbxJV7WZXt8D9fGOo7dFCxc5oGv6LYx422gA7Ny391wQaDme8H6G+x1BPQFXOOY9iOVx4nQctw9Jc59EYYxbZROEZ64gqGaAZHP4yjkJAng6OjgV6h7ZHKqmt5dNoXRE2pWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PPCSSSVJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PPCSSSVJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4144cc0Y013461;
	Sun, 4 Feb 2024 05:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=y7ibFK+NzAWTuwBb//RAoqmpf+lJdlSGGs4VvVIZo7c=; b=PP
	CSSSVJbW4gu1CdqvkA2CnwFrfI2GlQgCcWsUx01MHPF5nrE3gZ0edKt5IcB19YCR
	koOiuU6acT0ert2oV5ih13V3LKjhkEcUwONJBv/AAH22cbzX+YktSxzNicYjmDja
	6sPtCIRS2YD+A3o+xCyQV1YFLOyA0zgQz7b6ap+pGG1flRomh8UMOLHjXEysR2W9
	t3ZyqrbbciCysEgIz2yJeUej1kQDM7uoPrnjG3ZPDNVoy3zxvTW+HToM/kbx8eB8
	MQeDogPBXmhPeOclDXTbdXbDOE+/cwFHQmXqC8bI/xR9s8ZRpCd3uPGHM+2HAcUc
	hmr6kcc6z81cofAn+TsQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1f1rsaf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Feb 2024 05:14:55 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4145Esqa017828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 4 Feb 2024 05:14:54 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 21:14:52 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v1] Bluetooth: btusb: Fix triggering coredump implementation for QCA
Date: Sun, 4 Feb 2024 13:14:19 +0800
Message-ID: <1707023659-4189-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: NhR1YTr6O_0bm6HXRVP1JYF6Fg5DAlYF
X-Proofpoint-ORIG-GUID: NhR1YTr6O_0bm6HXRVP1JYF6Fg5DAlYF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-04_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402040037

btusb_coredump_qca() uses __hci_cmd_sync() to send a vendor-specific
command to trigger firmware coredump, but the command does not have event
HCI_Command_Status or HCI_Command_Complete as its response, actually, it
does not have any sync response event at all, so it is not suitable to
use __hci_cmd_sync(), fixed by using __hci_cmd_send().

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/btusb.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index edfb49bbaa28..ff282cc25710 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3469,13 +3469,12 @@ static void btusb_dump_hdr_qca(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void btusb_coredump_qca(struct hci_dev *hdev)
 {
+	int err;
 	static const u8 param[] = { 0x26 };
-	struct sk_buff *skb;
 
-	skb = __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb))
-		bt_dev_err(hdev, "%s: triggle crash failed (%ld)", __func__, PTR_ERR(skb));
-	kfree_skb(skb);
+	err = __hci_cmd_send(hdev, 0xfc0c, 1, param);
+	if (err < 0)
+		bt_dev_err(hdev, "%s: triggle crash failed (%d)", __func__, err);
 }
 
 /*
-- 
2.7.4


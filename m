Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3C63A5
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657556; cv=none; b=MqOgkCWJnQy6+3xmeaGH7+2jKzs/fhJaPKXA8DP85gZMt53wF6SuzsbGinfVSVfAxqRM73sdDiYbl6/s1WTnq4bM325PoWLf+FddUtr/gOlnO7rPF0g3DIjFL+LdRtRNKv9590MdXnu2t6HI+9iNPmNjh3b65l2ZcVbIpy5lo+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657556; c=relaxed/simple;
	bh=/K+zXuuAVxECbCrYpAZuG+5NrVJ4GK03Baq1Z+fUc5M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kj3nR1uZSR6Va4zbm2x00owQQt7plkLpOiVWzUBJytqhhIYDpd6msjDpVar5Mk7ZvXHh2RaYF/dKGiIgOoWTdoKQ2KZrNym8J0pfTqU5t38nz/6q/VDWMZP7NdC2nJI9NxAZWbCWNZj0S8gRGBvLYiW+iz/dNI6Bh2zQunc/IYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O9jnTkeh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O9jnTkeh"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J8LBTl013637;
	Fri, 19 Jan 2024 09:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=iMClsZn2abVttD2vFLYhjyT065JnN9oD7CRM02upB78=; b=O9
	jnTkehMSRAQOpkALT6hl7hBJIMsZ6UwSoSOvVok3K/42BknSgkMe0AkmY3mTVJpN
	WshA+d8HazHlOd+/Zb71dBFL7zOeEPP48xyE/3GkcdY+FmdA5sqs9DX2Jtv5dYmQ
	WAGJUfb5SRkfQjSxrnO47jjJGurRSKh+jpPqFoo6ipvpMUEcRinn360Y14SNWU5c
	L2pF86WkowL2rV/awmmiyYPE6w6M50ilH8BjKDl1cogl+XfOEUCasLDHAaDeMVeS
	vb+n0HhvSbqR5nTgOV8j0+ckyAP5GBTCONsnVVTn71btBFKCSCDIvwLZ8wY8mhYi
	pQdPdEouJpIA080GAPfA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqng884w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 09:45:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40J9jo62023912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 09:45:50 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 01:45:48 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <quic_saluvala@quicinc.com>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v1] Bluetooth: qca: Fix wrong event type for patch config command
Date: Fri, 19 Jan 2024 17:45:30 +0800
Message-ID: <1705657530-17975-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Lou67XwXpDm_bicIzAqc5vUE9A9Nor7_
X-Proofpoint-GUID: Lou67XwXpDm_bicIzAqc5vUE9A9Nor7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190041

Vendor-specific command patch config has HCI_Command_Complete event as
response, but qca_send_patch_config_cmd() wrongly expects vendor-specific
event for the command, fixed by using right event type.

Btmon log for the vendor-specific command are shown below:
< HCI Command: Vendor (0x3f|0x0000) plen 5
        28 01 00 00 00
> HCI Event: Command Complete (0x0e) plen 5
      Vendor (0x3f|0x0000) ncmd 1
        Status: Success (0x00)
        28

Fixes: 4fac8a7ac80b ("Bluetooth: btqca: sequential validation")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/btqca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index fdb0fae88d1c..b40b32fa7f1c 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -152,7 +152,7 @@ static int qca_send_patch_config_cmd(struct hci_dev *hdev)
 	bt_dev_dbg(hdev, "QCA Patch config");
 
 	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, sizeof(cmd),
-				cmd, HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
+				cmd, 0, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		bt_dev_err(hdev, "Sending QCA Patch config failed (%d)", err);
-- 
2.7.4


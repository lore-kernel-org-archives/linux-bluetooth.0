Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCECBA5F
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708656440; cv=none; b=ENR6NHAoSqH9lTVfMrnQxHIYIxJ+49xXH0veid2rzdI33uAt8JIFBobGOX6IyRQk78pxyaHj/WJd4nG8cGfqaa+siuJQ3sxg7/A9hiTTPr759YUDds3hdfbh6kXsckRsiVuyVS5hgiBCN4+ML5Ifil5AbpjswGLXxi4OBV93zy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708656440; c=relaxed/simple;
	bh=N1PlpBeb9p0ZNMC/g+rcDApl0dSEb/JPGs8QJauNkAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXJc/OdKlfBft9sr3sO+fa0Kb9Xi9fYkf0bJiLi92dg3VSlzoLyaie+ZWsebF739ROyYioBJdCV6NSrv8zYqOEy1NSpWefi3qS8lvz8a83+uGoAHygVcXAimIYT9PXfjNOYvIF3ZdyB5gLHfYWr34SFLLClZz07KhAQCuwI+GQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ka3wbHJ2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ka3wbHJ2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N1JWtk011899;
	Fri, 23 Feb 2024 02:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=t46jsw53gYaMNtTjqCW6
	k9yinF/+RjccQj70uH0zH+Q=; b=Ka3wbHJ28JYQ0lnK1I5R4d+MjyIKhSLkMzOK
	qGzIhsI+wzk42RWcNj+WzGByY/byeUlF4ZUhSAc2DuVzJPSTj8eN8crxCKEoGnfB
	A4daTRSFcBBnV8otIiOVrj/O0qiRoTzj4GlPxXRiQzYqgJKQSLD3d6Ol9XWX5E9w
	oFdtHRfmYJgXzPOsEAMxaFJRIuS8LQBw4woHwG4Tso/9qwpQBDzcXyqC/UFSAvp2
	ejeULkthoc06LncPQZkL75vtEMCfNXDfPJ8MAMmUFO1OhwhLuWHmjOKn+1WuoXxL
	NTOYPhO2mt0tNOnoXE5ls0jFNa+uZwvGgG2vKSoeEA//a08e+g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weg88r9tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 02:47:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41N2ksjg032007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 02:46:54 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 18:46:53 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v2] Bluetooth: btusb: Fix triggering coredump implementation for QCA
Date: Fri, 23 Feb 2024 10:46:45 +0800
Message-ID: <1708656405-28017-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1707023659-4189-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1707023659-4189-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 8eBjaOysMspHF7Gy1UnK1A9NzFOEuVPK
X-Proofpoint-GUID: 8eBjaOysMspHF7Gy1UnK1A9NzFOEuVPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1011 adultscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230018

btusb_coredump_qca() uses __hci_cmd_sync() to send a vendor-specific
command to trigger firmware coredump, but the command does not
have any event as its sync response, so it is not suitable to use
__hci_cmd_sync(), fixed by using __hci_cmd_send().

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes since v1:
 - Correct commit message

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


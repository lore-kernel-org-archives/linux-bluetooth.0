Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292584D31
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354339; cv=none; b=dZfTFXyqStaU1sN/5wJB5zaYN5st5tigENwaeh/sP/HvAb2aNjekxnZ36iMzrVrXk0Kl0D/5zwbhjEA1xzuQ7JP3urHBZis8ffv9OgQlpzvTYImfkU+d2YStsFArzF8svFTffv9y0kQaklZgbRMrRFy3E/nGbSocHPHjGQSZFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354339; c=relaxed/simple;
	bh=vFDI24isPeRvRRA6vdmR1ucMlvFJg/CmhTJBlQgK8n8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AB8Nh/or69SLOXufSM3q2h4ig6O7Xc76bwxNnP09OgpC3Rp1JhKdLOo/Yp5IvmwnJC1JCBHGaXZ5SPaqARn+wUOtVEElQvc4N1urc49YGldfDEySx1X37bV+BdEWBOT/8xpT2V3t0mFa2wsVnFmuwwB/7IOGZxlYgFxRMgWhfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sm6aZRc+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sm6aZRc+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P6DNLd004422;
	Mon, 25 Mar 2024 08:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=0rwkD8aYr30APL3p8xzI
	j6h47CUuz3pZAi0pG+ayEho=; b=Sm6aZRc+XEz7JEVac1cUOyJxw4txibrr8BTl
	adWfaI9i8HwqHYxHOShm1yjlbnPFQJhzi0nk7L1gEDJiy0zlzaOK6wqHUFRyYt4w
	AlDVqEZJvnmI1hN86qYtfDCf9rrIsBp2xlYUB+IOpM11TrsrdsrwadySel9Zqq3L
	E3OhAb82iLg3ZoutrSXdyF9laUFa8TQK3XqpueE6sv7XiXV7AOqOt4hTDFmBxvZ9
	rcdnJcVxVu8KbfeCJhmCMHPzKE+/omaCV68ze8/u0XfKB+cFQScVacNQniT+4LaW
	hfr/QUPNLaojOnU5siXMfsDQ5iYVjk0/VxDkrYil06DqXXwC+A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x319j8eyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 08:12:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42P8CBRr025798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 08:12:11 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 01:12:09 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v2 RESEND] Bluetooth: btusb: Fix triggering coredump implementation for QCA
Date: Mon, 25 Mar 2024 16:11:49 +0800
Message-ID: <1711354309-27605-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1708656405-28017-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1708656405-28017-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: qKDzmZvrH86nhvO3aN-YRx_MvgJogT7o
X-Proofpoint-GUID: qKDzmZvrH86nhvO3aN-YRx_MvgJogT7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403250043

btusb_coredump_qca() uses __hci_cmd_sync() to send a vendor-specific
command to trigger firmware coredump, but the command does not
have any event as its sync response, so it is not suitable to use
__hci_cmd_sync(), fixed by using __hci_cmd_send().

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
V1 -> V2: Correct commit message

 drivers/bluetooth/btusb.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c391e612b83b..9e9b9fc84211 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3485,13 +3485,12 @@ static void btusb_dump_hdr_qca(struct hci_dev *hdev, struct sk_buff *skb)
 
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


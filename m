Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD5413D604
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358388; cv=none; b=h4ALdfACw8PLY928PbmrtTzZK4oVIEO5Dge/+Q/MH+y1HgdJV5Z+GYnuNPE+kL2HjU8/LSR9bSfv4KRxfq8914PFNVOz2WXl4M4YiBTEnWh9xc2D5SYhYAZ8JmsuXVBp3ozMY0jDXBwY0QkpfR4URnVmU3WBzhUSlxYKvsl+nDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358388; c=relaxed/simple;
	bh=tYJC0z5lLAPDL3fXx7ztNMwoUb9dT7/1uhvWP35guts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poWVDk65UPxLQebohDomUP7BJLkmq1reV3PATR0Oc/B+uxI25jpRTHc4h69IMafoLK1q+HRKpkrSTqOw3lqAbQdFJGkusLTyMn/AXUx3CXfYIzOmUtjRDOA9hmWydtbjk05XjBIg71mABWPVjZE+rhMrKEE+SZZmjW4dnTZBF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R0E3LSld; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R0E3LSld"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HBg04G010985;
	Wed, 17 Apr 2024 12:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=hxefyahrEimpvRETeUm3
	RwFTW3aXTuLMKHiUL2P7lUM=; b=R0E3LSldkSNKWaOuSmCUaJIGicxO84Ps8TUr
	fRC/a8tyuGK5ipb3Dbl+y/8B0T0z71Tu3sZxVaub3dg141+0g6ZUqChKKUX3vDBk
	M+VadtRu600m921f509LNSDBUzkokuu7JEdlfW8+aEzcN+WAKdBrK4CEHFS39U4O
	JGhm8aoursOwE8KPKo6X8xnowHTDcf9V17cxhC2CM/uajxm4RYUpcsDKW26LNRgi
	XLv3+0VeDP80Mg/73VkQC662nnIe5giLMsj94msjY2AzD8BzhsfF9n5KdC8mmouK
	A/AMJm53+4HJZxzocQf+67Tw04HyfDo6DkFWyJ0H5aDKGqGYnw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj9w58raa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:53:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HCr1pC032153
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:53:01 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 05:53:00 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v2 2/4] Bluetooth: qca: Fix nullptr dereference for non-serdev devices
Date: Wed, 17 Apr 2024 20:52:14 +0800
Message-ID: <1713358336-29619-3-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: RpgJ9m63UQbAsC-Uiw5Kqo4AMY8EaljS
X-Proofpoint-GUID: RpgJ9m63UQbAsC-Uiw5Kqo4AMY8EaljS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=965 priorityscore=1501
 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170087

hu->serdev is nullptr and will cause nullptr dereference if qca_setup()
is called by non-serdev device, fixed by null check before access.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index fdaf83d817af..c04b97332bca 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1905,10 +1905,11 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		qcadev = serdev_device_get_drvdata(hu->serdev);
-		if (qcadev->bdaddr_property_broken)
-			set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
-
+		if (hu->serdev) {
+			qcadev = serdev_device_get_drvdata(hu->serdev);
+			if (qcadev->bdaddr_property_broken)
+				set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
+		}
 		hci_set_aosp_capable(hdev);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
-- 
2.7.4


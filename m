Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7B10976
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 03:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713325846; cv=none; b=IjXKrolYSqH9Y4sSYVsHRhReXVw3OGkGAoK77q8poE0hwggQ1ajFxRW64q1zxxnwXTjq39bYgffj7wIn26595L4eBt90tYtlZMTgrS/9tPGHLolmuLbLHlg+X41ypur7rKUJw4uavkCMKO5rShiLXQKuJlf+NdZEPUZCTdMqqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713325846; c=relaxed/simple;
	bh=oz4k/ArvhaAP3HSgrcBp+pEByepWCEEjHrlSXagnEqg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vC2X4SWo19Zg29fXoNh23iocg/uaG5UynXz7F2lNTDXB/sjSXflk3rswSDshrjLpdtU6kjifpLOacVW+x6I8jH7ENQGtmZhsmqWxmSxrXyJYWWgjz9TSsgDrMp2cI1fY/XveYoitK9MstlgrPfp1JeM+4QrkC4VFwD6mnAjO6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ze6XtZ0x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ze6XtZ0x"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H2bAGh025243;
	Wed, 17 Apr 2024 03:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=eLyKDXz9FfO1FOa6Rhm2bCRPirWUmKUjM2DBp0TgkqI=; b=Ze
	6XtZ0x12EqFkwjmcSmLrSO1YSy5nxV0Wd0fkn7k/jRwNFl5AIWaSAN5oWYVE1JXG
	zX1CUJsZ014Z8SbgXQRIqq6tmkVMxajdoJuIEgUhLYhhod1t9ctMGDILE9k0uRPY
	xHCn3YhUjRNKxZmqs+gFq3woN4vTwS1FqbUG8CopwqLP55KK5w5jFWwO5ytfT2hu
	AKsvH5SUdI1lB6k4AMmqrpl9XSVZdK3H3VQKs3FtlIK5wAbDC0c/M3XYf7gPOpJf
	LGrySQfavLpupCBQg1qhlOkTTHWC+lJu/QEhQ5Rarcvoick0uMd5aLE4S2mJaA+H
	0sbzqKosN3P7BmU5SSvQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhqyytm0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 03:50:32 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43H3oW4V017052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 03:50:32 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 16 Apr 2024 20:50:30 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <johan+linaro@kernel.org>
Subject: [PATCH] Bluetooth: qca: Fix nullptr dereference for non-serdev devices
Date: Wed, 17 Apr 2024 11:49:52 +0800
Message-ID: <1713325792-17181-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: 2IQPeO_XLTSd5Ub8LyhgPSq77MS6wJAb
X-Proofpoint-ORIG-GUID: 2IQPeO_XLTSd5Ub8LyhgPSq77MS6wJAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_03,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=971 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1011 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170024

hu->serdev is nullptr and will cause nullptr dereference if qca_setup()
is called by non-serdev device, fixed by null check before access.

Fixes: 77f45cca8bc5 ("Bluetooth: qca: fix device-address endianness")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 92fa20f5ac7d..9c6573c727e1 100644
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


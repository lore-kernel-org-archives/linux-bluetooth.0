Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1977213C685
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358395; cv=none; b=mbdYOHLqIEVs7OkJf+pt3rXeH9ngo4nx1N/faErhfUbRgtQpBs2GS065o07xEfBafEEkdOjNxxkIjFXPvZ6CeYAqGPkKg0RH0HuspF0OCHWQNmpvWTsjG9X5UN+2Iq+U4qDGoDpTElObbkAXGh5hj9nYw6CiCYX9G1HIFlBwcBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358395; c=relaxed/simple;
	bh=5A0rZQo2upNCYelDQTTRkv8bDBl9IzhYlWyJmSMZRpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILLtwk8LLxpfkHqqtijwEZtrpw6HWY5UM/hXA5HeJ5zy0rmfUoQvwDJTnG4MBfgstWfUUymLHGA+nQQhE3gze1IfQ31XL+Qd4llNoyVIwmrj8rwaJ8sCxdj8epjacEsqG835iap3trlQJRlrS+IdJ6M0Yqac4BlyKuFXw3s+LT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EnMe5/Bn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EnMe5/Bn"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HACrWi024119;
	Wed, 17 Apr 2024 12:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=ALF3LUL2yYb2zHY8ugcv
	ky+QYOVJVuvtlOnkWjNplbE=; b=EnMe5/BnNKFnZaea5ayEZFqvHQsd61Idc5Xz
	lN6HYYG24v/nMaJHh6uYWEjVfU+L3h6qe3usqwVtq9hAoLJsAMqgDttIvmg6uI15
	TFlYvAbapuL8KQ/fdIH0SRh9cBeS4j2O63gVqzpDl+j9vX9wU58IxHjunE32vnxE
	6iq+Ww/Gf/KcCGpAuhFw9MmmN88sbkdj2ul0zSrVd4CC3I9hUeYKwgf4Yek5yQUC
	mjWYOat0foxj4Fr7Z8jmYOK0Xwf7GEkTqfSzXQz2lWAuB2KHhC1GLJ5OsSaqs4NF
	iujg9bG38wnTGY9XYu24aDimzUM/lDuX344ytnc+SYKm3SI/NQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjceh0bpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:53:10 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HCr9bF024491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:53:09 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 05:53:07 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v2 4/4] Bluetooth: qca: Fix wrong soc type returned for tool btattach
Date: Wed, 17 Apr 2024 20:52:16 +0800
Message-ID: <1713358336-29619-5-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: GegivuuISc8_73_OTgKnQtxM9hKx4mou
X-Proofpoint-ORIG-GUID: GegivuuISc8_73_OTgKnQtxM9hKx4mou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170087

qca_soc_type() returns wrong soc type QCA_ROME when use tool btattach
for any other soc type such as QCA_QCA2066, and wrong soc type will
cause later initialization failure, fixed by using user specified
soc type for hci_uart derived from tool btattach.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/btqca.h   | 1 +
 drivers/bluetooth/hci_qca.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index dc31984f71dc..a148d4c4e1bd 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -153,6 +153,7 @@ enum qca_btsoc_type {
 	QCA_WCN6750,
 	QCA_WCN6855,
 	QCA_WCN7850,
+	QCA_MAX,
 };
 
 #if IS_ENABLED(CONFIG_BT_QCA)
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c04b97332bca..7c3577a4887c 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -238,12 +238,17 @@ static void qca_dmp_hdr(struct hci_dev *hdev, struct sk_buff *skb);
 
 static enum qca_btsoc_type qca_soc_type(struct hci_uart *hu)
 {
+	/* For Non-serdev device, hu->proto_data records soc type
+	 * set by ioctl HCIUARTSETPROTODATA.
+	 */
+	int proto_data = (int)hu->proto_data;
 	enum qca_btsoc_type soc_type;
 
 	if (hu->serdev) {
 		struct qca_serdev *qsd = serdev_device_get_drvdata(hu->serdev);
-
 		soc_type = qsd->btsoc_type;
+	} else if ((proto_data > 0) && (proto_data < QCA_MAX)) {
+		soc_type = (enum qca_btsoc_type)proto_data;
 	} else {
 		soc_type = QCA_ROME;
 	}
@@ -2281,6 +2286,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		return -ENOMEM;
 
 	qcadev->serdev_hu.serdev = serdev;
+	qcadev->serdev_hu.proto_data = 0;
 	data = device_get_match_data(&serdev->dev);
 	serdev_device_set_drvdata(serdev, qcadev);
 	device_property_read_string(&serdev->dev, "firmware-name",
-- 
2.7.4


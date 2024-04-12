Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471FF149C47
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939283; cv=none; b=g8/hV7rtKLlwd4WP2JX+g06dNU2OH+yVqjqlVKkwAGn9/GlsSoHuMgs8scmbqu0fgL4WBNpFXZOJkvx9Du3xcAljZzqWVtnw7o/scsba6yugL9hNnGvPnDzhDOS5CPORXZZMfNcmnJqDYTX5hfMEmSlrDQb2YyhT2yVeHcxT1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939283; c=relaxed/simple;
	bh=/mQxQei5S8DGDbQTym3MirU43sJ+hVOd0AHd9LyHssE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwro0p5Ji3oQ/5TcrkZVm8LM5WowlQUG2IknVZOZZrP4VBEK7Yfj+UrboGUvJqjUBA5t7ZvMZYvBQ3erYSIvoxrlhiHLD/fMKvFL85o1mCXkuOOZ8RRUNhLOToNYz4FzAOZ2PQnSQyE6ymu1nExncK5q3WvNVx62+TxS7Pql9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N7Oqr8f1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N7Oqr8f1"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CFQfcx023491;
	Fri, 12 Apr 2024 16:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=/UujFdBqvZi7UUC+pmmH
	O9gH/U3K+XXrW8QPkPws4/w=; b=N7Oqr8f1uVj1ZGAosz41fQPfb3ZfZCPWC6R6
	mUNCOmeeXnRloD5jo489hyKwbY2zFNyOHLJEuGT3tUMTNsGc+3zjApNfCY8/fpGM
	kuDZg+i7k8RLbuWLtUvmiLRM8yTmEur4d10pnSIRTs3iyA2p/PrRrExhqYeiZadA
	yBFN+nfKBMXAHFhz6AENfYOgSUrPmR4aYSmsk195r6UtSgXrbuin/c9xOr4lUm/u
	Y9QJ0tpEjMXMYha1CoXdel1CRs8mHJ5hBjzQGPf8ZvOIW7zkoJ7IUqPYowMArt9h
	NpQqtrWpbztabFYQAgRtFzxfgIafePvMcRVxlDIwCO1q3IRtXg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xeyev962u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 16:27:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CGRuaS032663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 16:27:56 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 12 Apr 2024 09:27:54 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <jiangzp@google.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 3/3] Bluetooth: qca: Fix wrong soc type returned for tool btattach
Date: Sat, 13 Apr 2024 00:26:27 +0800
Message-ID: <1712939188-25529-4-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712939188-25529-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
 <1712939188-25529-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4JgYrZi7fAM0cq8oXP9rG48jKo4xQzpU
X-Proofpoint-GUID: 4JgYrZi7fAM0cq8oXP9rG48jKo4xQzpU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120120

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
index 158567774cec..45492456f4f2 100644
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
@@ -2282,6 +2287,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		return -ENOMEM;
 
 	qcadev->serdev_hu.serdev = serdev;
+	qcadev->serdev_hu.proto_data = 0;
 	data = device_get_match_data(&serdev->dev);
 	serdev_device_set_drvdata(serdev, qcadev);
 	device_property_read_string(&serdev->dev, "firmware-name",
-- 
2.7.4


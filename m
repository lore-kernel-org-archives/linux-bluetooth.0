Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2191D52F7D
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713409937; cv=none; b=BOt0cEysLg++xOs7W8bKLyOxljMdIzm/7fmJZuAvzsoZVC0aRT8iTfw0c3+FtII40rOAzGUcbcVFyNMv6FY5lQhtTG+9qwU1z8CkFOc98kOp4uHn76DL5G8shUkebdrfNOPPov3zIytzxdQ0hnINGcGeXLVlw7BGtAl/4EJv430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713409937; c=relaxed/simple;
	bh=jvdviXRTEYKOwSh9B+7MQhVwK2YaJeko9Uxqkbfnxng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aONioHyvor0b7EERa0zViFqOYisgi7SRM7k3SJL/9mk1tIOtZiYQUPMvHvVj1p0z3KEzavQR8lsJrdn12T9s+F5dIoKhR06M71Rpg4Jd/JMCynhPMF/pvNeEk1PlIImn6M8QuAdFPhjfn6P7bqBLKVh1TjJYfW008vu3EbcWZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D3Z0xJzk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D3Z0xJzk"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HMbtGO013268;
	Thu, 18 Apr 2024 03:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=IeGdeT0OgTSlhFkGrdHH
	x2BXOgKvrIZZ2TLuZbaW/tw=; b=D3Z0xJzkbB4sHXiagtasuOiOie7PlmCuoGsx
	SInNDkNtghOMVLqYTCqZPeNXj+3duuWveTnsDfdrTCGapSQoq1ILiwQgopP6So7c
	f2970k1zTjbCfHp317tsKp6yFSDcoacysD6U16Y9RMR8WCh8Qpk/6DntU+SHnADO
	k2rNJqzrbY9kox356mRyRc9VRt9+UMv0jnyNeDZTSwme2+64G8lcIK9ntu1aqQFD
	6XoW0AmEoMG8jjaC6U3IsvKIEzvefBxpLOwBsW9NegY+ixg5dJdCjdy+qKC8n0Qv
	035aeK/ce6T8u0F6Pvu0nD6aza8YrfdLt0GIobgb2gYRRblU9g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjqcurn2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 03:12:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I3CBda026665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 03:12:11 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 20:12:09 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v3 4/4] Bluetooth: qca: Support more soc types for non-serdev devices
Date: Thu, 18 Apr 2024 11:11:53 +0800
Message-ID: <1713409913-13042-5-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713409913-13042-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713409913-13042-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: B4_VAFVQuMJMQBWRy9jnm5XvT7nhIN5Y
X-Proofpoint-ORIG-GUID: B4_VAFVQuMJMQBWRy9jnm5XvT7nhIN5Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_02,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180021

For non-serdev devices which are derived from tool btattach, only
default soc type QCA_ROME is supported currently since there are no
way to get soc type from DT or ACPI, this change supports more soc
types by using user specified soc type for non-serdev devices.

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


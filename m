Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA96148FE6
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939280; cv=none; b=D3xZjFsvBzu8b+GTYG8GGUEvLxOD5bp/TJPEnJ7p+wQM/WlpG9zYoSXctRPhWN1XMCqyfY5Ukp78ETjwJj53YJ9egTkHIpUrtLhTLdrvAVOY2nyFfCGAEdca/ROg+6D1siPZuFRt5eXdSuisRkJ6nKJhn2fOc7JeA8k0gXaGOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939280; c=relaxed/simple;
	bh=zjjNUY5zEgxlr+XaqfhTEQ/BTaSPRRcX+Dpu77cqKKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2ISJ/GofQoCS3k+Dec8nLQMUIp9dPokghKF67b0yAnSYyuWBo/oRZqZw/pwTw2SAuUSJZ0zmfuxtKyXWxfzvfBWgQQMaOQpqkcsicsv+8Nh4UI4TN9iLYYY+7sA7viOm0Xn66fpzjQEffspl9qzreMYUGnu2Quj2Aqb6z4E9ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SPt2OXjj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SPt2OXjj"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CDNUuQ010007;
	Fri, 12 Apr 2024 16:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=RFq5ecCEP3q85c1BN2iF
	zK8JqwCVOInWfClSJc0Wp54=; b=SPt2OXjjn2BmC5I2og5oNbnwgveZyboYpzG5
	quH6AKRta7/kSSrRDaLqxvkKcBknivgZFgZALlOknwFy991wuCHLxkVj3X55NHst
	SQW68R+/LruxOtO9s1nV/FrjJ97ktE0e1nuiXS9oOq4aImB6mgfitEcp59tcOGun
	E1csiGG9HnCRpjoDgKrR/vOtUxzEG0XWhQzFGRRMLB5Zb9alkAgurkRVFRz4l5iN
	B5aZIB/isHWxZ1ZKnjJCTZ44LKC91d6Cp5F29PZq7luLHnmLx1XeVB08Si0TIkIc
	/UyAonqRYG0v2Y/8BOGmHGyWjpCI8fusl+nRH8AsWZEcL4ZddQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xewr39dsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 16:27:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CGRrLR014023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 16:27:53 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 12 Apr 2024 09:27:51 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <marcel@holtmann.org>, <jiangzp@google.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 2/3] Bluetooth: hci_ldisc: Add a ioctl HCIUARTSETPROTODATA
Date: Sat, 13 Apr 2024 00:26:26 +0800
Message-ID: <1712939188-25529-3-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: PWz41h0tFFHS7YerwhaiHPY-BjTcA5oI
X-Proofpoint-GUID: PWz41h0tFFHS7YerwhaiHPY-BjTcA5oI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120120

HCIUARTSETPROTODATA is introduced to specify protocol specific settings
prior to HCIUARTSETPROTO, for protocal QCA, it is used by tool btattch
to specify soc type.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bluetooth/hci_ldisc.c | 10 ++++++++++
 drivers/bluetooth/hci_uart.h  |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index a26367e9fb19..4be09c61bae5 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -506,6 +506,7 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	/* disable alignment support by default */
 	hu->alignment = 1;
 	hu->padding = 0;
+	hu->proto_data = 0;
 
 	INIT_WORK(&hu->init_ready, hci_uart_init_work);
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
@@ -795,6 +796,15 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 		err = hu->hdev_flags;
 		break;
 
+	case HCIUARTSETPROTODATA:
+		if (test_bit(HCI_UART_PROTO_SET, &hu->flags)) {
+			err = -EBUSY;
+		} else {
+			hu->proto_data = arg;
+			BT_DBG("HCIUARTSETPROTODATA %lu okay.", arg);
+		}
+		break;
+
 	default:
 		err = n_tty_ioctl_helper(tty, cmd, arg);
 		break;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 68c8c7e95d64..fc35e9bd4398 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -18,6 +18,8 @@
 #define HCIUARTGETDEVICE	_IOR('U', 202, int)
 #define HCIUARTSETFLAGS		_IOW('U', 203, int)
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
+/* Used prior to HCIUARTSETPROTO */
+#define HCIUARTSETPROTODATA	_IOW('U', 205, unsigned long)
 
 /* UART protocols */
 #define HCI_UART_MAX_PROTO	12
@@ -71,6 +73,7 @@ struct hci_uart {
 	struct work_struct	init_ready;
 	struct work_struct	write_work;
 
+	unsigned long proto_data;
 	const struct hci_uart_proto *proto;
 	struct percpu_rw_semaphore proto_lock;	/* Stop work for proto close */
 	void			*priv;
-- 
2.7.4


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90544F1E4
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713409935; cv=none; b=JaphFLziWa26fbjo+W1iG/LMU4RnLHVLExL569VMLNcOnXMTBDfuVgl+0w2mT7XElc0qtk0xENXodjZKDUYkeUeh7sntbUQFv7jGuoXVyLU4tS5g91dVQsGoy3LJy2Zo4ZCDJmrO1zA9UGn8Obg2ai+/0Vxs+BML+BuYgnsaLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713409935; c=relaxed/simple;
	bh=zjjNUY5zEgxlr+XaqfhTEQ/BTaSPRRcX+Dpu77cqKKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YL0UNq+5gFSJ+aXM9qWUjfACDQ+XZtBNdwpvN5cPi3mIWlbbfexrypYSQNJkw2PVxKhDkrPepLK50ra285e4zBztQ+VA36VyC9ijoS3M6Gpt/h3R4RZjXZ6XQaMRPJtDUSV/JXyYfrYsBdMVd5Jx33QmQQP+7NLsWdy9+z4/v1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZYksuvRO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZYksuvRO"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I1aamZ028691;
	Thu, 18 Apr 2024 03:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=RFq5ecCEP3q85c1BN2iF
	zK8JqwCVOInWfClSJc0Wp54=; b=ZYksuvRO7Wa3LY0MR+XIXy8n9HRtf5pGebVS
	+h0KnYflThpNT28wJDdKVs8nbz73Kpt8VEjMcrwVvDfoinWos8FnRh9GWpqyZJyG
	K5jnD5y2+Fdl9qSyE5owucMHtZanmqjr8vVWeIDwnu9XUgV+u74Fh9SE5U+OZRF9
	0XJNhoPTj/h6q3VnRcsn3A5P56qDUacppAelxOHeFy0e5OoYFk5pqk6PBs6Gm1b/
	cgvU+vehwQ9OEHeJB2KyLi8KDGYkxe798gL1zeqNdKtsUtZJjp59Q+EJleQDYnJE
	Uzf5XIS1qX3nvLoe4KSG46GX4b4417CWy8EELMumyiNP9DAymg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjrdbghpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 03:12:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43I3C8Pc026643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 03:12:08 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 20:12:06 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <quic_zijuhu@quicinc.com>
Subject: [PATCH v3 3/4] Bluetooth: hci_ldisc: Add a ioctl HCIUARTSETPROTODATA
Date: Thu, 18 Apr 2024 11:11:52 +0800
Message-ID: <1713409913-13042-4-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: aSpYFXjr-ibA2VobBJqpYyUVK8ya6Nwr
X-Proofpoint-ORIG-GUID: aSpYFXjr-ibA2VobBJqpYyUVK8ya6Nwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_02,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404180021

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


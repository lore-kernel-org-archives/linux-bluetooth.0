Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117F156222
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727255401; cv=none; b=FkRPy0Bb8eFp7TwTFyDcvQuE7wYbUhK3dxLqWgikpWWoZe5ykQhisRJGBg0L626w+haIQejTT5c27XCIGPghASh2av8T4LkUmJQ5D3UWgFQLr3cwpWyIoF2jQg4pIF4jUKVTe03XpaZktl0s19TIhC6GRBfKn2HgiYt4diNZn/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727255401; c=relaxed/simple;
	bh=iOM9g7XxrwHfICmY3EC2MZaDUgYgvAmBOdtwR+vEY8c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T2l+5ZZVwZp3hOiDkKnbBDSOhQxNehkCjdrTgeznfbhzrS9nHhOr3eOEu0O7bpleA7a9LPzWehd89sW5ufN7GTbRsIYAv2DbJF06j7kjw2hyKhQ9kptml919tTRA3Sr962iw9TFBK+ShHUiyycJN4jT9TSU4hBTAw8dBAJYu7oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YoWXNYaM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YoWXNYaM"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P6xrvk032191
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 09:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zf6k4+xOqTYAnhlxa2/GYF
	Ab/784V3YAqkhWYNL5kBs=; b=YoWXNYaMQL17XNbOaW6Wpoh28Mysc29SrcD7cW
	ppUz3mK/tl4iqCOHd6klDKNizv0f7WgFccjrUTMtDIDRknlMZO6jOs3b8JzGpzmn
	ULnw/KRRuouNXco3TbGJL+63r9Zk/g99c8hJEWnTgvik+mis8HNODZbnTaBl1nCs
	YqqCCqcw38LNLFKBgiQyO03dAN2vVY47JcbPgK9DaFQJ9xGg14lfCRLnhP8YQJdc
	lbgC29rbzI8hG3LwCzjGLMmeb35ELpGyg8RK61UaQi1+OfPVvbYmSBJ6JVG/5xLm
	3gC0Fl23+ecxCBVRCZSXv0L8QsysuG7grnBCEO9xcpEhrrjg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41spweu8ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 09:09:59 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P99wwX017924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 09:09:58 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 25 Sep 2024 02:09:57 -0700
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_jiaymao@quicinc.com>
Subject: [PATCH v3] device: Remove device after all bearers are disconnected
Date: Wed, 25 Sep 2024 17:09:48 +0800
Message-ID: <20240925090948.1540589-1-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QQBUs0-O9yYRhmbQbMvxNb2Vr1igKJnn
X-Proofpoint-ORIG-GUID: QQBUs0-O9yYRhmbQbMvxNb2Vr1igKJnn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 mlxscore=0 mlxlogscore=661 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250065

For a combo mode remote, both BR/EDR and BLE may be connected.
RemoveDevice should be handled after all bearers are dropped,
otherwise, remove device is not performed in adapter_remove_connection.
---
 src/device.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index f8f61e643..c25bf6b60 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3492,8 +3492,18 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 		DBusMessage *msg = device->disconnects->data;
 
 		if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
-								"RemoveDevice"))
+							"RemoveDevice")) {
+
+			/* Don't handle the RemoveDevice msg if device is
+			 * connected. For a dual mode remote, both BR/EDR
+			 * and BLE may be connected, RemoveDevice should
+			 * be handled after all bearers are disconnects.
+			 */
+			if (device->bredr_state.connected ||
+					device->le_state.connected)
+				break;
 			remove_device = true;
+		}
 
 		g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
 		device->disconnects = g_slist_remove(device->disconnects, msg);
-- 
2.25.1


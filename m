Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE768158203
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 02:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727404748; cv=none; b=Wa77PvVYRWRayZ4v3jwfZgUW0YE+yzoI6X6yBjCifazpTQCe0HG4cm3Obm79sP/WR8BOLagJS/zDOFFnspW+R6caxsqQWPdiBPVOIAC+7VCEqLDbeXK0RvSLnIRM4dsBWecsP2Sm6vTcqk7wV7i2cPV9PwC/iH+0i7Y7/tSk3p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727404748; c=relaxed/simple;
	bh=tG+KxxrgN/By610WOiOIbOnRJjyGrFJPnRbCv576T2I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rClVrURd4QTFNmLX5fcumtLO/PDLO2ZyVJKYuxDqyICZtxnTY3yYN0fceiIvSZJ/0i4Xbso20zRUTWR4P9PkGGK1UGAs//oZSykMBAGmWg4KKZnan9hYbItfLhulEThQFX+ybrcylkz/MD8sJocCHTLabdUsDd5Q2FoITAgxZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hl7xeuWx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hl7xeuWx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QG9eCx001876
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 02:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0XBzbI1nev+hFuq89x6Z7i
	zRVoRKsTSAlrUb58u4IZU=; b=Hl7xeuWxfj4Pumb3IrnOdOJ2PJ7IOsQiTpPi8u
	HTQMRwSAsK54jOcPhxFtZDhQpLGz1NQKIKmS9JN6FiaJleTuMDYcRriDawpgccZj
	3GNfRSSZpYkthk13NstVicUPS5wK90l++9KHr5nGLphlLQNELo6kPevMpRSB6eEq
	LKv3Je3QnSj3qjE5HtAI5DEJmRl2kdtctFnvDfz8YBh+2GKcJ1ZW7UQipkdbcESM
	ZJg8id1HDv5tsuamy8aubNYX3+c/acEhq/YuJiUWhWStrD2E+KVl6lkPLkd6ESt0
	hVpLALzAeGDgQ5BnY3EYm180LlWnYKWQNIj7zH+EPhxrRlJQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skgnhwqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 02:39:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48R2d44I005322
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 02:39:04 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 26 Sep 2024 19:39:03 -0700
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_jiaymao@quicinc.com>
Subject: [PATCH v4] device: Remove device after all bearers are disconnected
Date: Fri, 27 Sep 2024 10:38:54 +0800
Message-ID: <20240927023854.2447283-1-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: h7qsfKQf37gsVtYrgvY2ak5YiTN5E6pk
X-Proofpoint-GUID: h7qsfKQf37gsVtYrgvY2ak5YiTN5E6pk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=3
 mlxlogscore=735 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=3
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270016

For a combo mode remote, both BR/EDR and BLE may be connected.
RemoveDevice should be handled after all bearers are dropped,
otherwise, remove device is not performed in adapter_remove_connection.
---
 src/device.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index f8f61e643..4efd755a0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3492,8 +3492,27 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 		DBusMessage *msg = device->disconnects->data;
 
 		if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
-								"RemoveDevice"))
+							"RemoveDevice")) {
+
+			/* Don't handle the RemoveDevice msg if device is
+			 * connected. For a dual-mode remote, both BR/EDR
+			 * and BLE may be connected, RemoveDevice should
+			 * be handled after all bearers are disconnects.
+			 * Otherwise, if msg is removed, but not all
+			 * connection are dropped, this function returns
+			 * before *remove is updated, then after all
+			 * connections are dropped, but device->disconnects
+			 * is NULL, remove_device is not updated. Consequently
+			 * *remove is not set to true. The device is not removed
+			 * for adapter in adapter_remove_connection. Need
+			 * to wait for temporary device timeout to remove
+			 * the device.
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


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B971598E9
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252884; cv=none; b=b3bMn3T8Oox/8gioL/BbfrzmnkZvvohU0T96algs66LcYfi6x4BAq2qflBfvpco/9OuuAerMabqZAmsu3ouAc3eKYyif1/kCZDw0lj/OXcLXORxuy1y6bfFguDS08ej7KP4fWCVJKmrgNQBwXDUeuVk6pIxsgdJxsrdyB11RqGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252884; c=relaxed/simple;
	bh=Z49GQWrhzE8+4Sis7qS8JZVMMsSC644Ap8SsWSJtCOg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T/V75tX536lHWiRRekGwhibGfsqvjvCnViUDKk7SfYXJ0D0FDnKlwZrz8i3v/ggxQYSb+aN9R0atMmMztnQT/uCuHFOSBCPPE1WBBOAvurlifZKzffkznE2K6Qr0XZVqV29F0EPRIWL6Eue2656WgtJv6xyQaUrvdQ0cVivGKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e8VNZy6z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e8VNZy6z"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P6hbpl027146
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 08:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jM5TgqoEZ30YuKT65tO+sy
	uE5ib/pU09or9FxtEdV18=; b=e8VNZy6zL3fB05X4jvg6MJisLcILIoHfrIb/02
	Au10N+bnwQ0z6CJC3CL6jX2yhOTXfcrn54v2C7WheOsJg53iLnYeQbOINQp4T5ub
	KThONbbukFBaxeXlIrcB/7/HafPuP2Pza753X4hdLKr0UxqFIzY1WCMUu7YYn9J2
	FWbAqtOyjLWae9Vtk/c4857mRM+Ejhh5t+mu+aQRCZ1wjx0tUpjyc+q4SJIJwkmC
	mEIDU9M3yYSz241wh3/qzJCc7tigG1j4Jjij5rFxdCql1WK9KfmtOMWTNoi3rHBF
	KJpL6ZDSSvGLfPrz/NUhPsc4o+7Wc73GTQfl8NLie5tb7oQA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqe9b55p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 08:28:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P8S157019497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 08:28:01 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 25 Sep 2024 01:28:00 -0700
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_jiaymao@quicinc.com>
Subject: [PATCH v2] device: Remove device after all bearers are disconnected
Date: Wed, 25 Sep 2024 16:27:50 +0800
Message-ID: <20240925082750.1516282-1-quic_chejiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: adTDdGHrBwrX3Icrc5fek5ec-930inen
X-Proofpoint-GUID: adTDdGHrBwrX3Icrc5fek5ec-930inen
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=661 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250060

For a combo mode remote, both BR/EDR and BLE may be connected.
RemoveDevice should be handled after all bearers are dropped,
otherwise, remove device is not performed in adapter_remove_connection.
---
 src/device.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index f8f61e643..1c4713c3f 100644
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
+			*/
+			if (device->bredr_state.connected ||
+					device->le_state.connected)
+				break;
 			remove_device = true;
+		}
 
 		g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
 		device->disconnects = g_slist_remove(device->disconnects, msg);
-- 
2.25.1


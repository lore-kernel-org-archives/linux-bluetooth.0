Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F94566A
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727576592; cv=none; b=cE61Z2hYUrQGZayiJE7X0rnxM9I1YcTjm2vJpT526wmhdJjs9FAWfmdo0xIARdXW9hd1dv4meRscdFPC8ghB3VocbAJ5Picgka8s9D3V5SLfc1gfsHgsKGnaVOCg/A8hrYlnfSBIHBgTa5WBCFUpH+hduF8tjZfL5UwQlvmFPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727576592; c=relaxed/simple;
	bh=b86H+o+k10fDdoPbbS0Lb+Z4LUKUwr0XwTHHOgUc7h8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rUKCIJIk2elwhWOo2/CHwhSO+hmeWoTLJZuNEl2puIStHkJYHIUXNfUV41p4o3PN1cqxF0nN3/Xo/R4Ctlq1/dr1HsCHX3KENphR7aTFe3wD1qPk4jfnTo4l/MfxdyIYyFG7aSZv06wUKfZx5rpAoBSAaQxKPVAJzPGazIFqdBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SjJ6bNPl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SjJ6bNPl"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48T0E5ab027354
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 02:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8W9vsOIQAM5xGnlRrQgxzy
	ZwgmVFi0hUqCCujbyL3Jk=; b=SjJ6bNPlplJk37olJR9fU+ZUqdqY4HzH2ku3+/
	EAEibc5AOMJe/R87VAK3+nzMsgZHkKuKiTMtsOxT7cBH3YTG41+h3qQglLWrMFha
	3tJ8yOwo3p7vDeLZYehRsFzZO+mTTS8umapAkfm/C77o8gSFjUXWTDW0gRk307FO
	3KRBHp4rBwMOd24FLa78W7OvdaL4dsO+cOdYFi5PGupHsnqW+MbM07ufAGsdI6GQ
	ShUH5zYxvOB+aDcGcphViyeF3PmpoypSLzi+intAkUUFHkLYS8smT+4GBMwFVvwW
	DRZqm+Lt3flMr/I3oLBGEtha/rGqW3A2wSJ6nk2yDQPbD2+A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x9vu1h6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 02:23:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48T2N7Rl004387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 02:23:07 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 28 Sep 2024 19:23:05 -0700
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_jiaymao@quicinc.com>
Subject: [PATCH v5] device: Remove device after all bearers are disconnected
Date: Sun, 29 Sep 2024 10:22:56 +0800
Message-ID: <20240929022256.3271298-1-quic_chejiang@quicinc.com>
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
X-Proofpoint-GUID: fMJuHvRp8KVQR4fZ_uN5QqOIwuyhag24
X-Proofpoint-ORIG-GUID: fMJuHvRp8KVQR4fZ_uN5QqOIwuyhag24
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=44 mlxlogscore=728
 lowpriorityscore=44 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409290016

For a dual-mode remote, both BR/EDR and BLE may be connected,
RemoveDevice should be handled after all bearers are disconnects.
Otherwise, if msg is removed, but not all connection are dropped,
this function returns before *remove is updated, then after all
connections are dropped, but device->disconnects is NULL,
remove_device is not updated. Consequently *remove is not set to
true. Remove device is not performed in adapter_remove_connection.
---
 src/device.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/src/device.c b/src/device.c
index f8f61e643..7585184de 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3488,18 +3488,6 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 		device->connect = NULL;
 	}
 
-	while (device->disconnects) {
-		DBusMessage *msg = device->disconnects->data;
-
-		if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
-								"RemoveDevice"))
-			remove_device = true;
-
-		g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
-		device->disconnects = g_slist_remove(device->disconnects, msg);
-		dbus_message_unref(msg);
-	}
-
 	/* Check paired status of both bearers since it's possible to be
 	 * paired but not connected via link key to LTK conversion.
 	 */
@@ -3539,6 +3527,19 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Connected");
 
+	/* remove device only if both bearers are disconnected */
+	while (device->disconnects) {
+		DBusMessage *msg = device->disconnects->data;
+
+		if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
+								"RemoveDevice"))
+			remove_device = true;
+
+		g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
+		device->disconnects = g_slist_remove(device->disconnects, msg);
+		dbus_message_unref(msg);
+	}
+
 	if (remove_device)
 		*remove = remove_device;
 }
-- 
2.25.1


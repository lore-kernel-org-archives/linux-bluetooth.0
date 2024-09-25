Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D49132114
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249543; cv=none; b=GT53QL85TAGSgC7MuiDNwbaLxPLjkrYPix9i9Ie8ig27BIjVj2EG7mRdSGamOPLGezSYyu+A6h2EKt/EFizgQ6GR8T/CwknKHgdiKDii3CD/OivtZbcSVNJz6alLWMcEJ3aBx0DTPu3DjjcqA5kQW4ccFYLWZ8hwCA1q/oHgdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249543; c=relaxed/simple;
	bh=gDdfkprB8tcI4i9Dhgugm6zMnWWKr8h87FdQrphqr4A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rrgz9GRpYzZvTeZARdnxBs51E8TcIFMfkqjz7VbOQgPdCzBIIoipvQT9bYKjjARBrAVHRQ3zJGD/idUdu7bAr5YJAWr4qLjLANEet8cDIk+xboV4L4EsKtrl+lTdop9slGgFzUHTNBwqPf+VRyQ2FP+OoTUcJnoeOraG1ZjAAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GLh9xyaS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GLh9xyaS"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OI9k30010520
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 07:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pQIREVji0asLqMmkNVEect
	4h0dPx7t3/I0zCB9+DIps=; b=GLh9xyaSlYFFEYxqM8uniKsgdCYVbCLDqwVaHs
	nfN/PKpCbIeUXbfCveUMeM5+03MsiA5q9iVWBbXHXaUp1vgFOMNsuRjQEwqPKRDd
	VB7Hha2kwIjZYvV6LJMswQv+q1PBzOjuOBXgYDwR4TpDu9Shg5CrYohNieSnQcAy
	GyujtqtByiSYF9WFsvUN5yHrzERk3YYg4G6N0QsnutfN16imi22MWj6zqw5Q72+H
	h8vtpMdIl25JIzZvHF5NdNweIQNW/pkXfP6/CThg6uI5UUS/a8KjjBYI2hsb/HCW
	9ehlyFecrmfwiEhzdxydDunNdaEj0NinvOrSiqfFVH7mXbDg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41spc2u3ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 07:32:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P7WKlD003326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 07:32:20 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 25 Sep 2024 00:32:19 -0700
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <quic_jiaymao@quicinc.com>
Subject: [PATCH v1] device: Remove device after all bearers are disconnected
Date: Wed, 25 Sep 2024 15:32:04 +0800
Message-ID: <20240925073204.1499240-1-quic_chejiang@quicinc.com>
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
X-Proofpoint-GUID: TnQFrYEmdDL6dF_xtXF7_3A62v51Jsa9
X-Proofpoint-ORIG-GUID: TnQFrYEmdDL6dF_xtXF7_3A62v51Jsa9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=682
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250052

For a combo mode remote, both BR/EDR and BLE may be connected.
RemoveDevice should be handled after all bearers are droped,
otherwise, remove device is not performed in adapter_remove_connection.
---
 src/device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index f8f61e643..b440b6b51 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3492,8 +3492,16 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 		DBusMessage *msg = device->disconnects->data;
 
 		if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
-								"RemoveDevice"))
+								"RemoveDevice")) {
+
+			/* Don't handle the RemoveDevice msg if device is connected.
+			* For a dual mode remote, both BR/EDR and BLE may be connected,
+			* RemoveDevice should be handled after all bearers are
+			* disconnects. */
+			if (device->bredr_state.connected || device->le_state.connected)
+				break;
 			remove_device = true;
+		}
 
 		g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
 		device->disconnects = g_slist_remove(device->disconnects, msg);
-- 
2.25.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8A1DE3C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188724; cv=none; b=gUTO3JJ5zay0uGwCMnaIOTINRMBJGIi1MgW3kgX0ueVbarFo5TAU1CsPUq76ltD+t5i9394Wx2VJzyaXFbJPJj9UAokkhWNVPjicNPp9CmZOqDD9e+qAG/3ZFvjKSw+Op4cLD8BkTnR6GpaCS7ZTWmK8GVNRU1rHVUNXS+G3CM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188724; c=relaxed/simple;
	bh=xXdpRZcme9eDXWVGgkk6PCVcxBKvgbiVA2wRGTivsm8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DsnWA3bBLiGQqkFElvCVc6ut+K7Kav8dWpf2g+ZVwSXb60lZWYYHyr/y5Dkym+QvX2EuBvGz3FC0DLYM7SuT2IokdFNJqx9Ns11EV1ZY3NIwvv6ze7iTg7BL1F9iOR7JPQ3RVSTgExUrJJmGjDq0QWPQ+5RUqyH9ZLoMrtSGA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RzjqNX/9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RzjqNX/9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKGFSX006853
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 07:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=o3GWy5bI10oDZgl/h+Si2X
	KvDTCr+HkKEIeG3Dfu9Ok=; b=RzjqNX/9O63VKf949Y4FaevjYGUxygQNGLV7lk
	T5+z57/h9E8isLNw8x2rykBXoee1DGxdPUo9bonratoDNBDbpesWTGTZQfaqPcsx
	JRXPiTE+Mr9LJuOpZb7g8/br5n2yTX12dRe5nLhz2WSKAwBasF5kllnNaLya+bVs
	Ec4h/lcS2EJ6tCD67SBplcqC4VRtRgO3INajNzr5LveIJPqEXOICNY+nkRO1saxA
	6NQHSaQlLQZmPNkmLtrX0csxUYygvnzOPd1bUqSDeT3sZqpYCOKDNYwJdqlgLpou
	vi372SoF2+MgJGLYQEVa9sMMxRg9X+vvzVxA18OczNH52bkQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gp4dyuje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 07:58:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49T7weE1017744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 07:58:40 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 29 Oct 2024 00:58:39 -0700
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v2] device: only use the address type selection algorithm when remote device is a dual-mode device when pair device
Date: Tue, 29 Oct 2024 15:58:30 +0800
Message-ID: <20241029075830.1268747-1-quic_chejiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6Q3MM3psOVoPvky3PVm0_GDFkWWQ-gFZ
X-Proofpoint-GUID: 6Q3MM3psOVoPvky3PVm0_GDFkWWQ-gFZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290062

For a BLE-only device, if the device is already paired and the upper
layer attempts to pair it again, the bdaddr_type will be set to
BDADDR_BREDR since the LE connection is already bonded. This causes the
device to use the BR/EDR bearer, which stalls the pairing procedure and
requires waiting for the pairing timeout.

The bluetoothctl log below shows the error result:

[bluetooth]# pair ED:8E:0E:B3:85:C1
Attempting to pair with ED:8E:0E:B3:85:C1
Pairing successful
[RAPOO BleMouse]# disconnect ED:8E:0E:B3:85:C1
Attempting to disconnect from ED:8E:0E:B3:85:C1
[RAPOO BleMouse]#
[bluetooth]# devices Paired
Device ED:8E:0E:B3:85:C1 RAPOO BleMouse
[bluetooth]# scan le
SetDiscoveryFilter success
Discovery started
[CHG] Controller 8C:FD:F0:21:84:17 Discovering: yes
[CHG] Device ED:8E:0E:B3:85:C1 RSSI: -38
[bluetooth]# scan off
Discovery stopped
[bluetooth]# pair ED:8E:0E:B3:85:C1
Attempting to pair with ED:8E:0E:B3:85:C1
[bluetooth]#
Failed to pair: org.freedesktop.DBus.Error.NoReply
---
 src/device.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7585184de..2b3d19f55 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3077,12 +3077,25 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	if (device->bonding)
 		return btd_error_in_progress(msg);
 
-	if (device->bredr_state.bonded)
+	/* Only use this selection algorithms when device is combo
+	 * chip. Ohterwise, it will use the wrong bearer to establish
+	 * a connection if the device is already paired, which will
+	 * stall the pairing procedure. For example, for a BLE only
+	 * device, if the device is already paired, and upper layer
+	 * issue the pair device again, it will set bdaddr_type to
+	 * BDADDR_BREDR since LE is bonded, then it goes with BR/EDR
+	 * bearer.
+	 */
+	if (device->bredr && device->le) {
+		if (device->bredr_state.bonded)
+			bdaddr_type = device->bdaddr_type;
+		else if (device->le_state.bonded)
+			bdaddr_type = BDADDR_BREDR;
+		else
+			bdaddr_type = select_conn_bearer(device);
+	} else {
 		bdaddr_type = device->bdaddr_type;
-	else if (device->le_state.bonded)
-		bdaddr_type = BDADDR_BREDR;
-	else
-		bdaddr_type = select_conn_bearer(device);
+	}
 
 	state = get_state(device, bdaddr_type);
 
-- 
2.25.1


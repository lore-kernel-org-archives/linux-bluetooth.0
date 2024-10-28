Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797EC1D54CF
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115464; cv=none; b=nUINIsihp7eDGFeVyrA+b/E/dDZcejXTucgSVHI3ZXTp2K2uudGSY3GalwBP9nTullWXnL/N1iaKGwD8v0anDb/60yw19ZYsFq7fWzhwtBiPuvjVrGe85+zvems7bzmIHgGiZlMxUAUM9juXRJx2MFrI3rk1yIC4ANsJS/3MamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115464; c=relaxed/simple;
	bh=g3MZuJppuK9ortlaeple6c/PL28Dy7r9e+GfrvJyuXs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RXd8TmJzr89UJfexPFAMwqprPsD5mELsuRmASmYJD84VHm+YYisJ1sjJOxgKGbZP1nfajoi3zMOoKKHNjDswl5TjcFGK0Tl1m7xy1sbfI+OpMCCXIZfvlaa8t1HQQIElwX8mj43TxriieS+dYuyThub86YtxPuEI8lel1+m6AY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tth4+hb0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tth4+hb0"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBOixb008828
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 11:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=agdoyhhE6tQVli2TkG+M3R
	OhgIK2Pszv4gyYI7OUk7M=; b=Tth4+hb0ka3Ud78Tfc3fiKam1HKCRdcRZPS7wI
	KDg9PxXEMlcKmORaQvv85IScH23FRTTgsSrCc8yR1cDPBO6Ngzsa/WS2tvBk7KzL
	IKzS0O8mmD0LrILfAN+kcjlMke7FdPXPmTgf925tuOoFGfLFeBwIs51MF6k1L//a
	EHCDzXc5AcxKaCoq9yd5kv2qh+ZPqrOUHgl+4Bj5cqpG2WqjykWMUo0GQMyvbHrd
	xJPSzb506BgzIzsUHukkMetobRC45/tFbareNzFKMlu51+VEmLJHd1MUWbINqF+h
	dIeKukNZ3teH9cGCvIwI2e6DR3wfewoTTTmnehRXb75M9oNA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqe5vpu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 11:37:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49SBbeod019205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 11:37:40 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 28 Oct 2024 04:37:39 -0700
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1] device: only use the address type selection algorithm when remote device is a dual-mode device when pair device
Date: Mon, 28 Oct 2024 19:36:43 +0800
Message-ID: <20241028113643.1012491-1-quic_chejiang@quicinc.com>
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
X-Proofpoint-GUID: s9eBdepFWYJEoD9Rs6JqBbSbeg4XsxxK
X-Proofpoint-ORIG-GUID: s9eBdepFWYJEoD9Rs6JqBbSbeg4XsxxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280094

---
 src/device.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7585184de..71fdbb145 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3077,12 +3077,21 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	if (device->bonding)
 		return btd_error_in_progress(msg);
 
-	if (device->bredr_state.bonded)
+	/* Only use this selection algorithms when device is combo
+	 * chip. Ohterwise, it will use the wrong bearer to establish
+	 * a connection if the device is already paired. which will
+	 * stall the pairing procedure.
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


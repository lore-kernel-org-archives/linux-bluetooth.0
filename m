Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD215E5A6
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609223; cv=none; b=D1z/swzYs9kosNHW/smGUWwge2ReDECCUnDMNn5WCY2qdktZxjwdKM0m6FFSYAK5QCXbYF48qZ/Dv41c+SEk+n3lAXr1FMz5ABBnyHEegLMizIsXEUudKp+HiQR044RkA8ppKCFDho/A50gqGy7onXeVFaVL0c8RlV8zxzIvt4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609223; c=relaxed/simple;
	bh=TeUQcw4LnfXlLmDOKj9SY0LaAbyyz6oV5lnEGg30/FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bb0CfMH2bP0EhYh8bboRUv8aRgpWG9rmh+vEb74zQpwyNQVDedrDq7riBNd27/G7qLryIvpqfHW4TRD+yYf5ySycro1iWuI9zwwi/SWoq9IQwY+Rle/i6bOEn9yXRaiyhj6C0ZRsr0BKaJcaK8dUx9yglpZE5Kx66mlWdRp6zfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JxaI8HEZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JxaI8HEZ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APKChLc012339
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 08:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WGE18qfI0E9BYjGeM0QOLCD1PqqV5HcsUiC
	ZawEUyMY=; b=JxaI8HEZspU87aS3fE+7Zog3jAGxZVbvrdrSpgsL2nQQUAMh6vh
	YlwxOh+d0g1OThL2/kvZRCh4X2TGFg3AAwvh55rOTajoCJNT+oVtJdv/kKhbsxfG
	xCHpE/JWYJ9/JO+uZnVVTIr/RaeBEWNbqyTEYRamK6zq8oAH2Xyv3QEGPBKwneQa
	jlxuy+e/eeEIDrZS4hLiwiIKa3H7QbNEa0MSP64Uf9trg9UN3L1CGAxf2B49CuxR
	83orWfg73sFqIilw529WwuYsrGFrm4xAfLrKq/K54KhT82TFxfJokfGLULE0G+Ny
	0S7D1Qjp4zZ3kiK/WZkDzMoDrq6i2CmV9vA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4336cfqey2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 08:20:18 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ8KFMb022374
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 08:20:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 43384kfb02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 08:20:15 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AQ8KFGZ022371
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 08:20:15 GMT
Received: from bt-iot-sh01-lnx.qualcomm.com ([10.253.136.182])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4AQ8KF66022370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 08:20:15 +0000
Received: by bt-iot-sh01-lnx.qualcomm.com (Postfix, from userid 4467449)
	id 179BF255AC; Tue, 26 Nov 2024 16:20:09 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: linux-bluetooth@vger.kernel.org
Cc: quic_shuaz@quicinc.com, quic_chejiang@quicinc.com,
        quic_jiaymao@quicinc.com, quic_zijuhu@quicinc.com,
        quic_mohamull@quicinc.com
Subject: [PATCH v1] BNEP: Fix the BNEP Unknown Control Message in PTS testing
Date: Tue, 26 Nov 2024 16:20:03 +0800
Message-Id: <20241126082003.2178783-1-quic_shuaz@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _qCROQt8ju3LACkndTvRqZ1AhKE7Gi6e
X-Proofpoint-ORIG-GUID: _qCROQt8ju3LACkndTvRqZ1AhKE7Gi6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=593 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411260065

This change is required for passing below PTS testcase:
1. BNEP/CTRL/BV-01-C

PTS sends an Unknown Control Message with only two bytes,
which is considered incorrect data. Therefore, the handling of
the Unknown Control Message is added before validating the data.

Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 profiles/network/server.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 96738f26c..c1d96cd1c 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -325,6 +325,32 @@ static gboolean bnep_setup(GIOChannel *chan,
 		return FALSE;
 	}
 
+	/*
+	 * When benp_control_type is between 0x07 and 0xFF,
+	 * a reply is also required.
+	 * However, since the command size is only 2 bytes,
+	 * it needs to be processed before determining
+	 * if it is a valid command.
+	 */
+	if (req->type == BNEP_CONTROL &&
+		req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
+		error("bnep: cmd not understood");
+		int err;
+		struct bnep_ctrl_cmd_not_understood_cmd rsp;
+
+		rsp.type = BNEP_CONTROL;
+		rsp.ctrl = BNEP_CMD_NOT_UNDERSTOOD;
+		rsp.unkn_ctrl = (uint8_t) req->ctrl;
+
+		err = send(sk, &rsp, sizeof(rsp), 0);
+
+		if (err < 0)
+			error("send not understood ctrl rsp error: %s (%d)",
+				  strerror(errno), errno);
+
+		return FALSE;
+	}
+
 	/*
 	 * Initial received data packet is BNEP_SETUP_CONNECTION_REQUEST_MSG
 	 * minimal size of this frame is 3 octets: 1 byte of BNEP Type +
-- 
2.25.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A323136349
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732779971; cv=none; b=TEexHIeIMu94b4JKJgXsz//JcJPkMhbvlJUijhna7RZZ6n1YlyInlIzOMrRSsWzkbJho2NDX9jNWeIbjc+8A7qKMoVTf6vAvczbLmQPFNeA6gS5q3UilpnjOVBz7JTkQ01UffnwHe5+SnvQP88SIOZIsjciEGeUdeS9VCI7f3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732779971; c=relaxed/simple;
	bh=c3rathnnO0mx3TI2zjFO0dPGuaGy2/1ItWTrFbgsdtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MMVcy+O+sor1IiJAbM17lTLq0rsxUXQhkqZM3RYTGBn54V9N2/irJf/Y9XwQrjuqSi+vPvb9trVZXZ7Sq0VR7kZlQ5BYg30sKpIbm7//EAcDgZyMa7rO6BDCNaF69vhMQCorzeKuNEZyNsuljRKxBQZ0O1DklXFtZQ/AJZuDq8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F6IzHAHB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F6IzHAHB"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARGQVWv002493
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 07:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5wO/chCiN2fl9omr3iDPx92PyHBAcL61ZKl
	C+pKexTQ=; b=F6IzHAHBs8rMV6Fmm9L5UAXE6G384xOqjLbRx5ApYzTGPkTaHrd
	qPl5Q+j9QNCDXviEQarYutWVt7VxfNZiRCVNdzvgXu/uaYyyViV6W5VbxuM/IUoi
	IRzCh2Sa5Z6Zz8t/3ZJNl+DX8aKFGb/V+XabefNAlpXa2D/e6hkJT+VzyCRx3TjB
	y01Crg6mDZM4c/mCqJaWhFrfZH5oPvc/bIbJsBFBNH4CkK9Un0ySE0rI5Cz9ZZLB
	LmbtNG+3nnxpH1DFrgunICriLPgVwsf4K7L1aWuQDCOAUCOdqmKXzwOBi1Syel72
	1FXJJfnmJYeBdTcKO7Estgky4CiCot6ByYg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xw1r5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 07:46:07 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS7k5qn028797
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 07:46:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 43384krsea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 07:46:05 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AS7k5e1028794
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 07:46:05 GMT
Received: from bt-iot-sh01-lnx.qualcomm.com ([10.253.136.182])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4AS7k4md028792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 07:46:05 +0000
Received: by bt-iot-sh01-lnx.qualcomm.com (Postfix, from userid 4467449)
	id AADE32560E; Thu, 28 Nov 2024 15:46:03 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: linux-bluetooth@vger.kernel.org
Cc: quic_shuaz@quicinc.com, quic_chejiang@quicinc.com,
        quic_jiaymao@quicinc.com, quic_zijuhu@quicinc.com,
        quic_mohamull@quicinc.com
Subject: [PATCH v2] BNEP: Fix the BNEP Unknown Control Message in PTS testing
Date: Thu, 28 Nov 2024 15:45:58 +0800
Message-Id: <20241128074558.3195554-1-quic_shuaz@quicinc.com>
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
X-Proofpoint-GUID: Qx5BUHu8ueDNIWfW8hNfU-LAFRsTCJm1
X-Proofpoint-ORIG-GUID: Qx5BUHu8ueDNIWfW8hNfU-LAFRsTCJm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=707 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411280060

This change is required for passing below PTS testcase:
1. BNEP/CTRL/BV-01-C

PTS sends an Unknown Control Message with only two bytes,
which is considered incorrect data. Therefore, add
responses to error control commands.

Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 profiles/network/bnep.c   |  6 ++++++
 profiles/network/bnep.h   |  2 ++
 profiles/network/server.c | 11 +++++++++++
 3 files changed, 19 insertions(+)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 54b950058..8d4786d45 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -726,3 +726,9 @@ void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr)
 	bnep_if_down(iface);
 	bnep_conndel(addr);
 }
+
+int bnep_send_unkown_rsp(int sk, uint16_t resp)
+{
+	return bnep_send_ctrl_rsp(sk, BNEP_CMD_NOT_UNDERSTOOD,
+							  resp);
+}
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index 493a2b036..61971ae0b 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -27,3 +27,5 @@ void bnep_disconnect(struct bnep *session);
 int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
 						uint8_t *setup_data, int len);
 void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr);
+int bnep_send_unkown_rsp(int sk, uint16_t resp);
+
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 96738f26c..7d84b6a1a 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -331,6 +331,17 @@ static gboolean bnep_setup(GIOChannel *chan,
 	 * 1 byte of BNEP Control Type + 1 byte of BNEP services UUID size.
 	 */
 	if (n < 3) {
+
+		/* Added a response to the error control command
+		 * This packet reply to any control message received,
+		 * which contains an unknown BNEP control type value.
+		 */
+		if (req->ctrl == BNEP_CONTROL) {
+			if (bnep_send_unkown_rsp(sk, req->ctrl) < 0)
+				error("send not understood ctrl rsp error: %s (%d)",
+								strerror(errno), errno);
+		}
+
 		error("To few setup connection request data received");
 		return FALSE;
 	}
-- 
2.25.1


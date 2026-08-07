Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646E4364942
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096698; cv=none; b=b62BKM+OWRMAX4ofYyJmx0cjdOUZaPZs/SUIpd9P6INrbRLLLpVO00UFQFihwVzWPN+5XV1FMPlNWwp/HOoiMBDWcFx/vbM1hUtGLs3iRMmIZ8FH5VRdNfCTUyX4rdY4uidoYcF34WMTMgfX0diqOyQkcu/YwEqIV9/7ysuwdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096698; c=relaxed/simple;
	bh=d4het0QmKqn9r1Z7tw2s8pDaRH9e5xamqtqn+3kMAH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tv5hkqjY5O19WY+073ll+nrdi8TKj1J2MAVeUlFDZ+9hdgkTpn8vCpYUOrmNBZjubU7UmOmkWnyfyvvzoKVnzqGxPeCym9Ujuz4MxLiCO2gJLcMISKf1JB1NNbgi9JN9CAbjZ5IIHk1Qrx9IglXODEMdjG31/FaUB6ipU7VaaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SnkhUTbW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SnkhUTbW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6779WGkP564797
	for <linux-bluetooth@vger.kernel.org>; Fri, 7 Aug 2026 09:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=yaKHZ0cPLQcbGr0D+OMsNsCZT+FAAkmOOzO
	nsRFj1lw=; b=SnkhUTbWklcOBs6Fxj9ff2YStLuj0t+kz6PXk4CJkFZ1CLRlDGr
	i/pm476ZCIAsPMMagzEHrTxbMbnHkxyqvW9EnRUqfnVGLzrlDZcPGe4xMVEhBgXE
	eX9j7uzvNX4tu7bqiuLZ1d95NFbMqJIpUnyZape9fBPGFvKHsXasDvXHshgNdEij
	z81pxYP6ShYfND/4ViDUuHQhh241qVth3KQVZT73FioPcUlsh4dwEh7zmYnywiPD
	iNQQkeoYHt2KfadYD0m83eieDTdjPZ5697wLZcAnae/L0eRbTRgb19c4pICDLDdq
	bGlXQEUYnFV/FxB1AEdwOfDLXTI1zWChtLw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwctp831v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 09:58:15 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6779wD5g003625;
	Fri, 7 Aug 2026 09:58:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fs9vks3vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 09:58:12 +0000 (GMT)
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6779wC1s003622;
	Fri, 7 Aug 2026 09:58:12 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6779wCsn003621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:58:12 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id B7FB6235A6; Fri,  7 Aug 2026 17:58:11 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1] avdtp: Fix use-after-free in connection_lost
Date: Fri,  7 Aug 2026 17:58:09 +0800
Message-Id: <20260807095809.2584501-1-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=Fp01OWrq c=1 sm=1 tr=0 ts=6a75ac38 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=UmovLC3t0AQPfvzBjLEA:9
X-Proofpoint-GUID: 0VsYHAPdyxHH10U4MLixrYQdVAPbLgSu
X-Proofpoint-ORIG-GUID: 0VsYHAPdyxHH10U4MLixrYQdVAPbLgSu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3NSBTYWx0ZWRfX9Y9JwGQi1oPZ
 CIEfHyXI4K4YpGT8Vnihzx42lUCwdcPudgru0Rw/jEISO8AzA8dnYNjAP1S31RNwh41C4IyFwP4
 iSSh2rwaj6wCXTSNMXAQUtBdBdMZwaZsHYGfnV+/ulhIFIVXJ5uycCIisX/MFMPbArep0lp/dKp
 TVNzk7BXcZQ2tiQP6kzqi/9JAOkqzK/OukwXTIyNQlwPZXL7ThTkqwdbAnDgZC/7743zOY/2ZOC
 9NNpBZLapiTPGM1gnwM1kSN0k/HjXULyvqDQsslc0QB3+yRlg9fOfi14vCFTJ2OjTWxxIYO09v1
 70LbvI2yFsVzr9kLlBlECiBaPu/TXj8OBbE4c0tAUhcIfsrnYX6yF0vQa+K1azF4WqpnIh44CWt
 lyHLzPBiW340mf+4LTie7u1y1gez2TWvzWfFnO9wHHlQezBi6nfaEIu1B9wRJCepsS4dF+LkSYj
 3LbdD4K/4Q9oMOdpenA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3NSBTYWx0ZWRfX1pHq333wGJNE
 v1KYTm7PSJAbdkBQpJegNtNeaOCFy4kNCRZBvmEpBCPYY5aSXhzrPzX3DnVqU3ke4X2kJi4wz4d
 TAmRRr6MKdP4FXsGlDY+Oe0FVDbRvXc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070075

release_stream() may free the session's a2dp_setup through
abort_cfm(). Subsequently, finalize_discovery() passes the same
freed a2dp_setup to discover_cb(), resulting in a use-after-free.

Call finalize_discovery() before release_stream() instead.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
---
 profiles/audio/avdtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 56d27b973..b8d9b8e94 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1158,11 +1158,11 @@ static void connection_lost(struct avdtp *session, int err)
 	ba2str(device_get_address(session->device), address);
 	DBG("Disconnected from %s", address);
 
+	finalize_discovery(session, err);
+
 	g_slist_foreach(session->streams, (GFunc) release_stream, session);
 	session->streams = NULL;
 
-	finalize_discovery(session, err);
-
 	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
 
 	avdtp_unref(session);
-- 
2.34.1


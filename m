Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F43769E6
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134866; cv=none; b=vCyzGF/yNMXOxT7qY7R+OAjB6LB53yjcxcjF2gKIG+bvaAS5tv1iL/b3XOWeXRtIoXHsrj9jSaB8h6si4u8zwGkdv72LGDN4sQAnWHufOophM0bL2l/Si7heNCVAbZFdaKq4TT4gFb+jvdlAvaq/Nf2zfXrY3lilxyeO6jnLUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134866; c=relaxed/simple;
	bh=NK1kUV4BaxZVk6nssWk3LsCI+ydF/gbTbP/R7WtGhSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=genl/FDphUUZKM/TJ82F6Y4b2I3AaGCnm7z6IBrNXnIhEIAiFq+IZ8g6DS3e+Aw5D7oNFJi9ZRTTwDT1GF0+oPCDyTF6x8XD/Dq4Azfdru6ix/Ee2Er1s+KA73N8J9iOSqw//sDzyg2CoJuqGrQbqf+f93JmEF2mmz+H8JQve5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ij64Z5Tb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ij64Z5Tb"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G75rIR1635423;
	Fri, 16 Oct 2026 07:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ygaybLPLqMi+TP+L42EY0AijfRaWWPfewHJ
	ZZCsKcOk=; b=Ij64Z5TboM40ZbKOUt7ycuqw74zsA7RZEg0rIhS3+fFBj9irPJl
	0dd0fLzBnbQA00+hLgkI68IM1uXIvEQVmumfWb5jpqLHHLaoA7RN3rzDu2CSkUoR
	Cb0hcYrKqdtYPhqVzZ4QZRkDSlVCGZiYMAHMmptagB0n8jbir5yRqcZJOTlngjX5
	c3rr51r4TQSop9czH8zctRF8/ZgQmuNsZ9+5Lw2FgMkKH6VVDnRlkyeGwBdSE25w
	hHIH7dNCQMyLOvc0COnj16J7PGrxGz1Wp2c68OlZB7urlb474JAt6AXVaPX+XBt2
	emnHhQ4EJoYTmEIYSIAb0QOIGRRYnEczvAA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8r11cdb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 07:14:24 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69G7EM6u3029676;
	Fri, 16 Oct 2026 07:14:22 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 69G7EL6E3029667
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 07:14:22 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id D3CCF23A88; Fri, 16 Oct 2026 15:14:20 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v2] avdtp: Fix use-after-free in connection_lost
Date: Fri, 16 Oct 2026 15:14:08 +0800
Message-Id: <20261016071408.2961576-1-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: 3Yth_Bg2Qgg7jJxs0CO3IWduDEbE6Hiq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfXxSOLppKKDAlw
 LbRcM0drDklD/YOIEedXpnN7chUhc2OgH1kMAm+v4xg27iBBHFL91+FA8SvmNNt1wZjj7HoUBDh
 V/V06cJHjrKN7z4PiEs6sKXv+kibnW0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfXywSRkBd3U42H
 zmKkSoy3HDyB0faA8K5cSpzFfvq+X8a04R0c9YCUhx7/W95Jljc212XVtOuGCKkOy54eBPTFFDX
 hStZLuCJa/tWR4RJuEJegJqYLB3SX7Wmj//AMCIxW61MQdgtAUgg7+X/Xp+QoMRrUe2fxpgKoEU
 3N7PYNye8o2xp/kh6ndlBSkrnwezv6xcPoXnEsqu7/4Wtv3bMHdXbugIGsb3hM799CL9SH+Jh9F
 Gl/upZj1T2hI98nt8p9Th+hdTi8mreCUh7OTFqni9Zmedc1Fdd5zfOWk5uoVa/myqh1A3x0BSgW
 6HTjefmsE9w/tEFXLMaSVzGDUbT3pvH6DdAIQahNz/0GsUH+G/mp29q8DzE59vRwAxgi7KFr6oa
 nAK0LFM5RzV6+XvwtA0NgznMmwsyiMBbsKwKkeyh2bs+3Y97+iGiSr1bBct1sA9XZ0ppbV7N/i9
 0yKyCRyJsirrlr2Zp8g==
X-Proofpoint-GUID: 3Yth_Bg2Qgg7jJxs0CO3IWduDEbE6Hiq
X-Authority-Analysis: v=2.4 cv=L/CI0OT8 c=1 sm=1 tr=0 ts=6ad1ced0 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=UmovLC3t0AQPfvzBjLEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160028

release_stream() may free the session's a2dp_setup through
abort_cfm(). Subsequently, finalize_discovery() passes the same
freed a2dp_setup to discover_cb(), resulting in a use-after-free.

Call finalize_discovery() before release_stream() instead.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
---
Changes for V2
 - Rebased the patch.
 - V1 link
   https://lore.kernel.org/all/20260807095809.2584501-1-jinwang.li@oss.qualcomm.com/
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


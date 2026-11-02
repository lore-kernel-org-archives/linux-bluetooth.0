Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607569;
	b=x/qeyQpgQ0zIy7j3tqaVLI+T6k6l+fuzr2itmdjcZtFxeClUlLjuf+Gxt8ACq0Wtwvz/
	 LCs6HDJ62ujjXZNxwDWKO3f3utKNC9qCXvomsugvthiSHO7wedumzQESQKxap8qZ/0MBi
	 /MyA58Ek5rAsmyVTI2dH68PSASf3fPvlhR3PFIKzYimJwM45h+MBVxlzd8V1P1SzP3LnN
	 BZj1+u3WwP3W61dsCmDVH2MARMEuvEJ5GZ0mCv8YeoIUuAIIPAiZjkcgrS+OkVbSVFgbv
	 gVfkXgslBix3cBAuhbP3l2WBMIGabKOM26sdN26msytzETtsF2sXjLdH/NBQGY5vuXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607569;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ggRPWbDH7Re0P5RMrIi4J8y7urXy62c5PnX4+YhpoLk=;
	b=kXugfJW6tLjFmIphqWHUk9uzf7qmlZ7O6pyjLDBlI3Cpj+B8bjNzSjROPedNVunBHz0B
	 MOI3xB1IfNuA221Pz2TfufHp2H9FAETpl8gvBrmnAuzrp/AUD+EwYffpWgAX9CxcYA9tK
	 bo61UMF+APGHP+aHMxZq7Z194FRy2bzpX/cbktVnVZOH7KN+ldum3TY6UkKxMKd1RDxSL
	 nMcWNp5ZgkTnj8PYJO93oIrRHsFloIWOSeel8Kmrq+eROQGnBfnIGUU8xhllf0Gl8RaaI
	 UwgbzPzUQLj5pWJgPeZV+7CTaxwTTEfDAnuztGaUSmKc8YGsdCjJDjYVnJAGqnYfQkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FAEgmEuw;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9443606A327
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9443606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FAEgmEuw
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A24wBuO1262327
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ggRPWbDH7Re
	0P5RMrIi4J8y7urXy62c5PnX4+YhpoLk=; b=FAEgmEuwCv5mc9B77SsKU5lgKWP
	j7EIXwnoV18cMb1MpMNUCrFDkwrRPNRq6pF1YbMSHfzxDE1D2y7eqta4qRE1BMBh
	mIkofTfgCkzqjfYE5QLWxg3/BaWA5gcp+0lVIfxvY0xBtOyHpY6iRv96vNKqqG7J
	u80KIsE5wtKmsGSXXTXEkWOSGdPi6FMUs1EGRZNfJYbBFemXTnVqVBlSEMCggtZK
	7yndhFwEJCt567cjDfuHHKpyjy1ed/RuYFdJ+S5q+3Q75uIK0hilaFhppnuOk/XJ
	r/5q9SFKDxxNAOtQLLWscIkSBuK0w3nDwVEmH3eoO5kCCf/9V6RUk1ukaRQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4gp4m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:28 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JMfs3331103
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:26 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJgA3331043;
	Mon, 02 Nov 2026 08:19:26 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 15/15] shared/rap: Start the Real-time timeout when the procedure starts
Date: Mon,  2 Nov 2026 16:19:12 +0800
Message-ID: <20261102081913.1623864-16-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
References: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: WL0wJDnUJfiKu5erOCqkJrD7ahpwyy6f
X-Proofpoint-GUID: WL0wJDnUJfiKu5erOCqkJrD7ahpwyy6f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX18IdLwehSU5j
 MQzq4UhxbXPx2jE88O4mBQgNpD7CJtF0S4GVCQ+l3pqDrNaLN4MyRylbLXcRv0LWRu4zzJ8Bx9G
 W5sNrzH0VT5tTiXJ2aPd5j8cQMC8MW8=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae84790 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=ByxyVlv4YNXdeBsKHNQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfXxdRQEcmJyLAt
 EfYJmIPEv9Iniw3enwryjD5P5ow3Dmu07+uam8NxbyWDv3p+CVyHV8c2NpOGMtWhdQ/fWcmMd0e
 ke33Xk2JG3LbzvwG5Tp4JzIQXINS2SFGt/eXIXLnSloobxnBdkP85S3FOPKg0mdsS8AJv4ZGFFn
 Vx1Gt9l7SAOud34YWC+d31sqXjS++pD6Tr2ba+RLNhjIAfkPrSlAHX25dhg4EAZf4liyDEySbWD
 zgg46IYrYKwOZz67RWmSfB4dYBA/uK5bughRKHslJekcjBnKsT/zEjraTfBqzHpDJXUepyXCrcJ
 EcHW5K51oKlu1dvJ1Tanr4OiIjoVP7OJ/i88E/mA7HmHaQ5kcHGWPoVUkM0U1REsp4lEXg+AY13
 EUTZkNjdkLeJpcVEsoUSZrHkTA6Pry0+hy3wrH9SesTZ6mRpWghJjnyhaKhLWB7L377UZz9CjoD
 ldSzuVJ97oclaTSbzGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

RAP v1.0 4.4.1.1 requires the Requester to disable Real-time Ranging
Data if none arrives within 5 seconds after starting the CS procedure.
The timer was started when the CCCD was written instead, which can be
seconds before the procedure starts, since the CS configuration and
security setup come first. The CCCD could then be disabled before the
procedure had a chance to produce any data.

Start the timer from CS Procedure Enable Complete when the procedure
is enabled and Real-time Ranging Data is subscribed.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/rap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index 85cf8111f..cb44d73c9 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -413,6 +413,7 @@ struct ras_ccc_state {
 static void ras_ondemand_client_reset(struct ras *ras);
 static void ras_realtime_segments_clear(struct bt_rap *rap);
 static void ras_ondemand_cache_clear(struct bt_rap *rap);
+static void ras_realtime_arm_timeout(struct bt_rap *rap, unsigned int timeout);
 static bool ras_cp_write_op(struct bt_rap *rap, struct ras *ras,
 				uint8_t opcode, uint16_t counter);
 
@@ -3352,6 +3353,13 @@ void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
 
 	/* Store procedure enable config in the session-level template */
 	reqtracker->bcs_proc_data.proc_enable_config = *data;
+
+	/* RAP v1.0 4.4.1.1: the first Real-time Ranging Data is due within
+	 * 5 seconds after the CS procedure starts.
+	 */
+	if (data->state == 0x01 && rap->realtime_notify_id)
+		ras_realtime_arm_timeout(rap,
+					RAS_REALTIME_FIRST_SEGMENT_TIMEOUT);
 }
 
 void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
@@ -4643,9 +4651,6 @@ static bool rap_subscribe_ranging_data(struct bt_rap *rap,
 		rap->realtime_notify_id = bt_rap_register_notify(rap,
 				value_handle, rap->realtime_ccc_value,
 				ras_segment_notify_cb, "real-time");
-		if (rap->realtime_notify_id)
-			ras_realtime_arm_timeout(rap,
-					RAS_REALTIME_FIRST_SEGMENT_TIMEOUT);
 		return rap->realtime_notify_id != 0;
 	}
 
-- 
2.43.0


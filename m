Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085075;
	b=pSpOAPmGnFV+F133V9Wzi9qqngtWPvJsdmqi/d3K1uFNcZxpSZ89FLwrUp/Lo3/5u08j
	 nKLOm4jQimp4kcpbtJYSBkf9QWLAptYXHUaGffudH1O9FZAUfqmZUBYVOT93bbKrsc/E+
	 +m0SFlTiHgTZmiwA94Rqqw7QCR/Btk9yMEAkzcPsm9k3fjTW4LCfvP2jac7zrLewpCKNi
	 I9ph9UqoGtWEN8BbPU5G3rCfd+1C+GSqZ+tP6bJAK5gvWzuKkUmZs2XBH5hlm42LncveC
	 j202FK1ZZ6H+M1UHvs8p/z7Tnpb7sdathY+2l3s6+M5mtCHIpRDZT22/BCkGI78p2MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085075;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Yl87UvALi1PiIAF49P9ysgognlyxFpT6RaPfupM1sS4=;
	b=wJuWhpiV6Ank56CubW9G6Wl5BM8Yjheq02qWxZyZajYmkBiBW7qpH8O2yOJlOkILYoRF
	 24XMg41KW2LbJv0QvCGFlpCjsYeUk5iM3rmBGggoYyX0YwSTPPS+OyQZIXqo7ZJ02D0wq
	 dFF/ST+Tg8OJTGRtZmCe18B9fRKRrVxbb+kiqdPN0DdimDTAwU04Nx0bIDo3rvPIvuIDo
	 SvjK4ZztlG1O9X7MZtg0Z//1XgpqCHBr66hRRlpsxIEBidJQ7h1JK4MNXSo0cD9WMk5R2
	 luHVPYzPQlN+2pI2NlqU7ANbpN8TG/vv5LfrjbCCyMW+TKQwRHtmO7HUDO3gO/oyEgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Oxn8H/5d";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DE6606A327
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 07:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44DE6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Oxn8H/5d
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5Yr5K2336755
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 07:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Yl87UvALi1P
	iIAF49P9ysgognlyxFpT6RaPfupM1sS4=; b=Oxn8H/5di8jaFWuoigMrXCaY5d9
	caoYr8AOZg5zf+G58fuRlpIf1O2t65o/FEuH3HnK5a6PJrhg3lkGEL0cXLV0iS1Q
	DhDfk7plPukhiQWGFRhzMLWcGNKWZQ5+SQn3IrB+8V6KZH4x4VmVI2H/TjWgAVwd
	VXnBM2G4F3MtLmhho+yByV/8g9G9i4Ni3Ig6Hk0F+1ZnHcZ8OcbhER3k7EP4fRMu
	47kh/suhb/4guDEWQhRsVqsPlQnnoc7yE1XTbdXk7Z15NNsWLmAEgJSY7S2dpwpu
	38HljLo7NG7k4nZbhkdfNVS/gmDG37pZ8mnXnVWysldVD7Bb1Efr/3wnnDg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hje3d9tr0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 07:11:14 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69R7BCaw1201244;
	Tue, 27 Oct 2026 07:11:12 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 69R7BCCU1201237
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 07:11:12 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 45A1227965; Tue, 27 Oct 2026 15:11:11 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v2 1/2] obexd/pbap: Fix NewMissedCalls parameter size
Date: Tue, 27 Oct 2026 15:10:45 +0800
Message-Id: <20261027071046.2272116-2-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027071046.2272116-1-jinwang.li@oss.qualcomm.com>
References: <20261027071046.2272116-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyOCBTYWx0ZWRfXyMCBKWwVSUIP
 fBXgFUMbp8QH8rf6lJo/Q6OACz1Cv09A32rZnPHCZ+E1Qo/AocZeA7catylWHPRmtiEq6kFaHTf
 6R4rH6UktwsBzL29Pk0FaEWbeCtmwlQ=
X-Proofpoint-GUID: 7fz7_oJyuERQJAISmfktmL8gugeredlo
X-Proofpoint-ORIG-GUID: 7fz7_oJyuERQJAISmfktmL8gugeredlo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyOCBTYWx0ZWRfX7ExvGC1dxkOL
 T1noIT6dQV5KaBsNo4UgDHDwbaAJTaJK7CVM/GnybeRJNWNWm14owKIwW/1lJ1G0xsF9e1QFT8s
 knbmnsKPZdVYnk7VVHVFrpF9y0OJpuRtihlLv390kwCnd0Y9Lg6SzZIoWTAW9yMH/94cgWP0WyG
 gtp9MgarRIOg0h8y3NnkPIwDfDmaxZopXHtGExnF21ctspXNbgmz+fsAJgDPrLrsFc/HaOyqBwe
 QCIakAGiURjViIDq6PlG9l8wI7UpuEPr5xiAWUZiAO8QfSWtS9LKMXsucIkUNO4AIR+EEwN786J
 x9cNsE32rH2ekVV/R6jUP42/p4qW0lDFBtDW7SjwZk2dzXG6tU62ei/6uThv6NLJtq2pmcM4F/x
 KWBezfdLS0H4OF3/kqClL6/Evavn1/+BcsqePoPlLbEg3v1ls3/IfCucuhTkPgUTveMSUIus0fi
 gxXbvb8+5JEhEtavylg==
X-Authority-Analysis: v=2.4 cv=SN/Xx+vH c=1 sm=1 tr=0 ts=6ae04e92 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=pI6-L2XfWP5WCY00hVYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270028

NewMissedCalls is a one-byte apparam, but was encoded with
g_obex_apparam_set_uint16(). Use uint8 instead, and update the
phonebook callback type to match.

Fixes: 398d3e23533a ("obexd: Make use of GObexApparam API")

Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
---
 obexd/plugins/irmc.c              | 4 ++--
 obexd/plugins/pbap.c              | 8 ++++----
 obexd/plugins/phonebook-tracker.c | 2 +-
 obexd/plugins/phonebook.h         | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/obexd/plugins/irmc.c b/obexd/plugins/irmc.c
index cfd8a45d4..b9888bbed 100644
--- a/obexd/plugins/irmc.c
+++ b/obexd/plugins/irmc.c
@@ -74,7 +74,7 @@ static const char *owner_vcard =
 		"END:VCARD\r\n";
 
 static void phonebook_size_result(const char *buffer, size_t bufsize,
-					int vcards, int missed,
+					int vcards, uint8_t missed,
 					gboolean lastpart, void *user_data)
 {
 	struct irmc_session *irmc = user_data;
@@ -90,7 +90,7 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 }
 
 static void query_result(const char *buffer, size_t bufsize, int vcards,
-				int missed, gboolean lastpart, void *user_data)
+			uint8_t missed, gboolean lastpart, void *user_data)
 {
 	struct irmc_session *irmc = user_data;
 	const char *s, *t;
diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 9f8684863..3ee54f1fe 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -159,7 +159,7 @@ static void cache_clear(struct cache *cache)
 }
 
 static void phonebook_size_result(const char *buffer, size_t bufsize,
-					int vcards, int missed,
+					int vcards, uint8_t missed,
 					gboolean lastpart, void *user_data)
 {
 	struct pbap_session *pbap = user_data;
@@ -186,7 +186,7 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 		DBG("missed %d", missed);
 	}
 
-	pbap->obj->apparam = g_obex_apparam_set_uint16(pbap->obj->apparam,
+	pbap->obj->apparam = g_obex_apparam_set_uint8(pbap->obj->apparam,
 							NEWMISSEDCALLS_TAG,
 							missed);
 
@@ -194,7 +194,7 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 }
 
 static void query_result(const char *buffer, size_t bufsize, int vcards,
-				int missed, gboolean lastpart, void *user_data)
+			uint8_t missed, gboolean lastpart, void *user_data)
 {
 	struct pbap_session *pbap = user_data;
 
@@ -224,7 +224,7 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 		pbap->obj->firstpacket = TRUE;
 	}
 
-	pbap->obj->apparam = g_obex_apparam_set_uint16(pbap->obj->apparam,
+	pbap->obj->apparam = g_obex_apparam_set_uint8(pbap->obj->apparam,
 							NEWMISSEDCALLS_TAG,
 							missed);
 
diff --git a/obexd/plugins/phonebook-tracker.c b/obexd/plugins/phonebook-tracker.c
index 36e73db77..ba0940c40 100644
--- a/obexd/plugins/phonebook-tracker.c
+++ b/obexd/plugins/phonebook-tracker.c
@@ -488,7 +488,7 @@ struct phonebook_data {
 	GSList *contacts;
 	phonebook_cache_ready_cb ready_cb;
 	phonebook_entry_cb entry_cb;
-	int newmissedcalls;
+	uint8_t newmissedcalls;
 	GCancellable *query_canc;
 	char *req_name;
 	int vcard_part_count;
diff --git a/obexd/plugins/phonebook.h b/obexd/plugins/phonebook.h
index b878b143d..7e99de6e7 100644
--- a/obexd/plugins/phonebook.h
+++ b/obexd/plugins/phonebook.h
@@ -61,7 +61,7 @@ struct apparam_field {
  * Contacts will be returned in the vcard format.
  */
 typedef void (*phonebook_cb) (const char *buffer, size_t bufsize,
-		int vcards, int missed, gboolean lastpart, void *user_data);
+		int vcards, uint8_t missed, gboolean lastpart, void *user_data);
 
 /*
  * Interface between the PBAP core and backends to
-- 
2.34.1


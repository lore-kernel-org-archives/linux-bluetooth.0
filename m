Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020519;
	b=hWMEM0oCcIEYqiiPB9zFDaD88azk3DSsIxgKtrkkbkFBpM1BVDuEhClRW+nMVchoiOaO
	 NxEyHuby3hhAz5habHcNTLzriE69r8R9+p3vFTk/jekoZ+zI6zRuBsigfQwEaiMoSB1C0
	 dti8KnFbjFe48dgJRxVp4UdZzu+UG5q6XC9vR3ZWa227Brtef0rk2LEOeV0w0iAupWYEV
	 nZ7TXL1VWHFooRtJ6mW1rL9DMhk/11+FpmwWZRjAJvJ3xpXhHw0Lqd+ymN/GUCBucz0Fs
	 gnmpiCPXahjQAqndeDwgrWGenfaBA639+RlemBwHUoNg0lC5eTuxQRSR8Hp0V/9y2+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020519;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RWuzpJVSpIluX8Jlx1vIZqAGlz3PKIamZNzsTjlThhU=;
	b=xcFyqRowHV0Nk025z5QydyevX3ryyWN/EqzcTL8HROF3wisLgYm1Z1pR5iW4xm4qp829
	 4bwsaZfx7CEubTu77RQ9RkD6zvdUQhQYWjwppE9ONBvfPmcTSh0JwLFVvCNXovdJ8GUdQ
	 aPRQOOj+u1WLnAa1AjuH9xTEFKQIfpEsRTCX8LnjKzUIQq/TYEAGhdjlwlP4/6NJOKbJV
	 eQBlVZlZgqyfG5sjaB4Bq42x01Lyqonab1azOGGzXUGnxcF09KvSUiD/PnQfNEKmWOEgT
	 Nu7RVRfvfhKFMlhBBRExSDSf0jLBqUnljhGUbqxejtJ27619lxm1Oa1DXIJu5l+I+8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dGjpoS6W;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A6606A322
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 13:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 706A6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dGjpoS6W
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAtW8S1547929
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 13:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RWuzpJVSpIl
	uX8Jlx1vIZqAGlz3PKIamZNzsTjlThhU=; b=dGjpoS6WrvPTc0HUV03yj9LqWTl
	42xy4nxuE0B6/+zJTgWjJCijDCQJMs3a91fMTON7PJUE8YEIDuctoQn3ruIe9UC5
	IAU2V477KgPYhtZZnCC3plvr4WE7OYlL0RG5dicdKdcPb1XJ9lUzmQU4zjT/A/h9
	xeSNQYaAyYuuOoybQvoR6QaymkFCwxZedbqA2pnm9vcFIcB2sW8kksKz0gI1RXzt
	i7quHUcZcFnRf7CVNHBakCpc+6ob/IHPX9eL5o1fUxPSD21ozHhMbjbISADu2iTN
	D71XAUD0uCPiVZprPrPWKFGkoLxZh6Ejncdi7KFxikt9eNVIZtyyuT92UpQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsgstk42-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 13:15:18 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QDFGCE4072115;
	Mon, 26 Oct 2026 13:15:16 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 69QDFGoo4072102
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 13:15:16 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 59ED624345; Mon, 26 Oct 2026 21:15:15 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 1/2] obexd/pbap: Fix NewMissedCalls parameter size
Date: Mon, 26 Oct 2026 21:15:03 +0800
Message-Id: <20261026131504.1016687-2-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026131504.1016687-1-jinwang.li@oss.qualcomm.com>
References: <20261026131504.1016687-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MiBTYWx0ZWRfXyz8VWgcDpxe7
 ts3ko6EMQTQyfxopf5trY1ZYvUUFmArxjGrblKp1GrMtlT5BZJ+oGr+DZ04m14Hrys/5fqZiVZ9
 E4+Aa0/g5lFW1nQ3Lzp4dYsu2jNK2Fs=
X-Proofpoint-GUID: GGN5b0k9strva_2jL-PimlydDudcJKBh
X-Authority-Analysis: v=2.4 cv=c+8+0h9l c=1 sm=1 tr=0 ts=6adf5266 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=pI6-L2XfWP5WCY00hVYA:9
X-Proofpoint-ORIG-GUID: GGN5b0k9strva_2jL-PimlydDudcJKBh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MiBTYWx0ZWRfX6J9zs9/TsDU0
 6BzUFupv2Ov+y435V1043kKAEFNT8ZTTyFyNAleRvy/vIDEyf5RM1VxPyx662cda8w3h6KMp3zE
 5KPcSQDmjL/FUTbTcFExhncPv526fzBj34SM9pt46/qjukreVZG2N3RwbF1c6jVzRigHczbCdE+
 9DThC88Oa5GYJjDczKCmmiqaoScN8B+RnJTbOYPyePln0gj2eJNbs3Xlhm7HBW+xtJ6PyiWuw/F
 XwqDaIFrME+JlAdgnwI+cs6T73hixQtkn/TCmr+4D8zUTGaH21hQY5ggKwL/MaMoxqsVSJwX5Hk
 QVFCAhQZnJi7pWsxhhH1l2SqABijFbgKqGyE+Jlew7plP9uudIcNtTXSsaFGEEASGGgfr6PsSei
 cXFOSj2iN6Zy3p/y9z/ZYoMphHgYeYpoIDVdRp7DDxFbOteAqjqvC2B/qgvqOTq5SNX/OC2xtE/
 IEghwxj1sE04K0r6FMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260052

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
index cfd8a45d4..e343fa1fa 100644
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
+				uint8_t missed, gboolean lastpart, void *user_data)
 {
 	struct irmc_session *irmc = user_data;
 	const char *s, *t;
diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 9f8684863..29b308cb7 100644
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
+				uint8_t missed, gboolean lastpart, void *user_data)
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


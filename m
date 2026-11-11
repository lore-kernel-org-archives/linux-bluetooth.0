Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390279;
	b=OsB5GS0FQbTYZmMsmIAdHQbXet717GHhcIUkwKkCPX2Spu+z1E3VaLzQt5Wnvcv8Aa94
	 s2VfBT9wZBAOUUm6LtWXBr2uCTB8JQ6GOgY291QgXzQP4gj30HDa4V1sPfqOsVoZ0vsqM
	 xx7Vy2Iqrjdvx6DmSWIA5KoZJPZKGiv9HZM4h8MrENylksgJhUoV62fflSEVBlHJ4eKtv
	 MsnUTKoVKaSDNINsESdty/U8vDHv+7IeAUl5keDctWCy2edqp+WBTGLQTxOxNkycuWa+s
	 jMIdML8qE2W2MWIYKvlgiDWfGV0iIDpF5mkF9bFuwitw6Gz+/eUKoJ1LmhvK3g7fdBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sa/nBZbLaVvfVdOspOPbxC74pQg9iBW59WbSpO/KrpM=;
	b=KgK3P60QggI8l4PvwsSVYC0rYsgU46j5QdIAx30tGTgACbqVcgSX2bYvHjigrpxf4ua7
	 sqX2K6JlB1hexpKG4w9xmwLFnYxAQfYOyjgbsM96t6XLv5CA3D5vIqdQdPF9l7r6+yW/z
	 +txxVrobNGAicEiqzEr76s7hVJdkJ6W8B+21vuHl6MlIDg0aoGOaaBTEqdZcOMdxKOJJr
	 mTHVdtX5LYl3DCn6d9+k2km1ywZS0q5ZQJqnc7N989G9peFQKrh2l+EqTMyrzCLdAGdIH
	 lZuwM5Lo+ThsB3KoyMs+xJvBpGJ+/ajzfZ0RJLXe/7qzlT8iZd7bJsSHkJcqUfII3+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KSBrF40v;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EDD606A330
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15EDD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KSBrF40v
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB8v6GP015461;
	Wed, 11 Nov 2026 09:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sa/nBZbLaVv
	fVdOspOPbxC74pQg9iBW59WbSpO/KrpM=; b=KSBrF40vLO27aKKSuizkoavbuhg
	9IlRP5nt0yqHZ1OTQLquHkVD/71eIcxecLDsebfb1JJ+37NN/gU+e8B7T8nQlXj9
	9hfKpsA+VlXwq1pEPN949HVpeqY/lyWW6wfbXFHT8rpUDhR6h3HyV/ZJt+3uLvBL
	AzdES/p83IdqcT37QlfhUMB063TSr+dWYGqMeLx9eESDvEI1Oam8gTkAAAYZuBas
	qXwNOArNQXA5k2mnwuBINLtPYBsFG8NaI4i1dichfj57di1TQ+deQPDFzWjkocdd
	x5nAm8EhV/qQtkdq6gMNzHRaGLyKE3nIFjLisdLzCjSBc619nkq8k7/n4dA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvna7875n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iZBj2424406;
	Wed, 11 Nov 2026 09:44:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AB9iZNa2424368
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 5EF52243D3; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 13/20] obexd/pbap: Parse PbapSupportedFeatures in connect request
Date: Wed, 11 Nov 2026 17:44:18 +0800
Message-Id: <20261111094425.1444893-14-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111094425.1444893-1-jinwang.li@oss.qualcomm.com>
References: <20261111094425.1444893-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Yh4i6fgkA-zEvIyPPduUwyZpfS1nen4r
X-Proofpoint-GUID: Yh4i6fgkA-zEvIyPPduUwyZpfS1nen4r
X-Authority-Analysis: v=2.4 cv=U7UHnuru c=1 sm=1 tr=0 ts=6af43905 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=_H_TX8z6i7KVAPa1vQQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX7uNhbd0i8uPC
 2ll7pBvlZ9ox/m5yeLvaMyQ+beZJEX7/EpaZ/8c3PjM21Bc2vrMlK/H6z4bdzp0oGbtpCU0J+W5
 aYknplaf6jslr0Epx2ZJDxw47/GedZ+kTg653GpGiM+j0s1JMfRY4GOUZVOjfipNc/T+5koUSfE
 7Ag5QJIKXl/Ner4K6z0pH2WuqlSIoMLMt8dg9r8HmbXOULTFTrY4DsHqlrk5rXwtbZNhP7DOSRp
 Q0n5kI3mbqsFbXfDWeJb3v0ZtnIPzibr9yUud59M90PlQJlVHFGoO/amwAYh6f5ZFAa5aG52ezv
 lehBgR/2BmmH/zm7qulIUWfHOfgtdrLMALzvKELYOsDgUU/KK8ImzjpHeTxMzOuG2UUqqIpqYe/
 kcxthJbbdhitcg1PmjtBq1dIZXW/cxGGHqRixpXiV8NokSc3ImiOxNQBANSLU7kjZ5vPGVT3ErT
 UiRCnNOliIJFKrEJJUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX3XS3J/DAGj3r
 Fhaz6Rk3onRBcQRZMuUE/ZD7zzz6SAlL8v55ZcgzjynRAlS8bma6NtpZGZhPzUmQxj6vwxCeOIQ
 DL9hbBJ8c8Iy+0AWHR0LhK4V+zkI40w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

Parse the PbapSupportedFeatures tag of the CONNECT request, combine it
with the features supported by the PSE and store the result in the
session.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c | 47 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 83256c98c..92794b968 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -42,15 +42,22 @@
 #define VCARDLISTING_TYPE	"x-bt/vcard-listing"
 #define VCARDENTRY_TYPE		"x-bt/vcard"
 
-#define ORDER_TAG		0x01
-#define SEARCHVALUE_TAG		0x02
-#define SEARCHATTRIB_TAG	0x03
-#define MAXLISTCOUNT_TAG	0x04
-#define LISTSTARTOFFSET_TAG	0x05
-#define FILTER_TAG		0x06
-#define FORMAT_TAG		0X07
-#define PHONEBOOKSIZE_TAG	0X08
-#define NEWMISSEDCALLS_TAG	0X09
+#define ORDER_TAG			0x01
+#define SEARCHVALUE_TAG			0x02
+#define SEARCHATTRIB_TAG		0x03
+#define MAXLISTCOUNT_TAG		0x04
+#define LISTSTARTOFFSET_TAG		0x05
+#define FILTER_TAG			0x06
+#define FORMAT_TAG			0x07
+#define PHONEBOOKSIZE_TAG		0x08
+#define NEWMISSEDCALLS_TAG		0x09
+#define SUPPORTED_FEATURES_TAG		0x10
+
+#define DOWNLOAD_FEATURE	0x00000001
+#define BROWSE_FEATURE		0x00000002
+
+#define PSE_SUPPORTED_FEATURES \
+	(DOWNLOAD_FEATURE | BROWSE_FEATURE)
 
 struct cache {
 	gboolean valid;
@@ -72,6 +79,7 @@ struct pbap_session {
 	uint32_t find_handle;
 	struct cache cache;
 	struct pbap_object *obj;
+	uint32_t negotiated_features;
 };
 
 struct pbap_object {
@@ -513,6 +521,10 @@ static struct apparam_field *parse_aparam(const uint8_t *buffer, uint32_t hlen)
 static void *pbap_connect(struct obex_session *os, int *err)
 {
 	struct pbap_session *pbap;
+	const uint8_t *buffer;
+	GObexApparam *apparam;
+	uint32_t pce_features;
+	ssize_t rsize;
 
 	manager_register_session(os);
 
@@ -520,6 +532,23 @@ static void *pbap_connect(struct obex_session *os, int *err)
 	pbap->folder = g_strdup("/");
 	pbap->find_handle = PHONEBOOK_INVALID_HANDLE;
 
+	rsize = obex_get_apparam(os, &buffer);
+	pce_features = DOWNLOAD_FEATURE | BROWSE_FEATURE;
+
+	if (rsize > 0) {
+		apparam = g_obex_apparam_decode(buffer, rsize);
+		if (apparam) {
+			g_obex_apparam_get_uint32(apparam,
+						SUPPORTED_FEATURES_TAG,
+						&pce_features);
+			g_obex_apparam_free(apparam);
+		}
+	}
+
+	pbap->negotiated_features = PSE_SUPPORTED_FEATURES & pce_features;
+
+	DBG("negotiated features 0x%08x", pbap->negotiated_features);
+
 	if (err)
 		*err = 0;
 
-- 
2.34.1


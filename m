Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781280;
	b=idGUFGb3jnOpPJmQpSS24fpkwaYZYhlyZSbhqPHm5WQdb4VPXThqfbUczyeFpKMCUYhn
	 IxJGNV46SWXIxdAoqMVFVRT/RqCuLZQgO4IRp/OkUx3ItE8Vg2iG0vWb7R2HLcRnBCTIM
	 xZWVA1PxIORVn9jYHDR3GZCx8PtUbdzrFXszNiCNjw97cllxtXMK3NUII+vyz3f001rPB
	 jMrTlsTFKFr7XqSBpZbfi31nOUVxl/upOfqSMLNSCj75H/G2hjbNTm2oeaiwyyh2//OL+
	 FMNb5VZDMzpwyTeS6ioVsS4L9C5Taqly+7a5ima58KdgWb7Se2fL6PEtVd5bgIEYXLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781280;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zEcdc5SuxwHzQVfMMay2QUtrqvbBfaqlxctdOZehfho=;
	b=rWa2otw3k1o67Qy3b1QFb1u1C3jcu3W2RwcPxmU77qx7VYjPyCwjQQz5IHFv4U9AFysm
	 qTzX/exGWif1OU5ON8FQ6kCwJH92L053hWzq8H1AqSZxL1BwNgFedpq7BGI0VRvOQylnp
	 tAPfoitTxedsVSn1X3uNbjljxoRmF1PPAN5nWk+fMy4fPDnZUjhL+IWyn5Z9Y8gkFyASO
	 EDNp1Vet6KJSm6drm0/CO6jzq6rMuzbozWaJq9+GVU9bhGVaWVrsn40GId/7Rvimj3LeV
	 dJ3WVkMvjrNMEGYVM+U2TNg8/eTMqg6NP8+la7vPrEKTYZfA99aljyVHfPDu2p3IeGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DMRbiKKt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFE606A339
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23EFE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DMRbiKKt
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48KgMZ175255
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zEcdc5SuxwH
	zQVfMMay2QUtrqvbBfaqlxctdOZehfho=; b=DMRbiKKtM5hWfMmaICiVY+6eMhc
	0yYgqOE4GjiMKEEgqEnNywGdNlGLBM2KHT9/o5drtRDq3XXfnB5axq5iWmOSXklz
	JhBHL5f+4mh1CqtdiwyJKISy7xPJNKgx49QCOWOZxAqCtP1nQsbDBsRjZb8wOMbc
	FKJQJIeEhF4C96zLQm+Lc3Uv6OlVGDnkLIum1tYXluOMDmu2vRi14PcEeFdBAb20
	18MmX42tM0m2Usfa/+aaXhcPFzQcoTMu1wXUy2BFmb6lnsXeWifDG9Gxm3aYLn1D
	viIEug37RJ5bDfnq8P/GRN7FuLMybP/yKLSwNiZJi9AUI9eigmmJ55wHP8Q==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqmjbu21p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YZTN2686404;
	Wed, 4 Nov 2026 08:34:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A48YZT62686389
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 59F18279B5; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 03/18] obexd/pbap: Include directly bound Tracker telephone numbers
Date: Wed,  4 Nov 2026 16:34:14 +0800
Message-Id: <20261104083429.4111632-4-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104083429.4111632-1-jinwang.li@oss.qualcomm.com>
References: <20261104083429.4111632-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-GUID: PewOVR7tE4mmbmkwBQ5yTfB7l5q4CxFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX5XzmB3HBoMPH
 BTHfqkmGolwW9IgZJ68Z9PDxS2W7Ar/1U2Mg8sQd55I6iQUddP0tOq2BTpX/K1xpVBDXixsXS8f
 D3VLXXxfq9XBpP0IMZR2o4wzJAMo49+/iF4/Y4G8N/bS90MIgb5kqHQPhXJDIcynrzE46R8fgW/
 R4vXCaLagFgkoAIBTOExgJH7A/VHtoCHEa59hnNVvBL7m6xThdh7BXM2oEbit/7rzNaXnKBHV7g
 8LWgeBTt6mKpRGUXsivtkEU/jV6UW/cgSV860L8MHe9BRrROCjFGxBPanKJ8GWcHeQOEU5ptG3j
 IP9OvOi4CHK0NeJnWOcJ3PvyiguFOLFv2H94D9c7XMbbP1fq+CRge2yhydrdIJ5Mda5SIFSdEcx
 GKbf1FsZ8yNyqFTiBXT2A7VHEHvKBWbv56Yp8Jwa+EuPG69yR7LWI/zaI9231LJiR/7qMddF4Wi
 UtyX6GY6GQvbs9IsAGw==
X-Proofpoint-ORIG-GUID: PewOVR7tE4mmbmkwBQ5yTfB7l5q4CxFK
X-Authority-Analysis: v=2.4 cv=NMhAaE6g c=1 sm=1 tr=0 ts=6aeaee1e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=6kwYN7l2Pbr54CibywkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX65ydD1cyxXAb
 +GX2DuInmwGUe6iUg7aEdhWCOBKy6RirCqTfBcUEE4MjZDjEZmRukYa8BRW900RIHPKesL3FK7v
 wThj+nHdP2kds/BsBogB6MqGduFN8U0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040033

Add the telephone numbers bound directly to a contact to the Tracker
contact queries, in addition to the ones bound to its affiliations.

Fixes: 41f45780b971 ("obexd: Fix for handling fax and cell phone numbers in PBAP")
Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/phonebook-tracker.c | 39 +++++++++++++++++--------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/obexd/plugins/phonebook-tracker.c b/obexd/plugins/phonebook-tracker.c
index 5adb52a11..326bf8892 100644
--- a/obexd/plugins/phonebook-tracker.c
+++ b/obexd/plugins/phonebook-tracker.c
@@ -76,11 +76,14 @@
 
 #define CONTACTS_QUERY_ALL						\
 "SELECT "								\
-"(SELECT GROUP_CONCAT(fn:concat(rdf:type(?aff_number),"			\
-"\"\31\", nco:phoneNumber(?aff_number)), \"\30\")"			\
-"WHERE {"								\
-"	?_role nco:hasPhoneNumber ?aff_number"				\
-"}) "									\
+"fn:concat(tracker:coalesce((SELECT GROUP_CONCAT("		\
+"fn:concat(rdf:type(?aff_number), \"\31\","			\
+"nco:phoneNumber(?aff_number), \"\31A\30\"), \"\") "		\
+"WHERE { ?_role nco:hasPhoneNumber ?aff_number }), \"\"), "	\
+"tracker:coalesce((SELECT GROUP_CONCAT("		\
+"fn:concat(rdf:type(?con_number), \"\31\","			\
+"nco:phoneNumber(?con_number), \"\31D\30\"), \"\") "		\
+"WHERE { ?_contact nco:hasPhoneNumber ?con_number }), \"\")) "	\
 "nco:fullname(?_contact) "						\
 "nco:nameFamily(?_contact) "						\
 "nco:nameGiven(?_contact) "						\
@@ -325,11 +328,14 @@ COMBINED_CONSTRAINT		\
 
 #define CONTACTS_QUERY_FROM_URI						\
 "SELECT "								\
-"(SELECT GROUP_CONCAT(fn:concat(rdf:type(?aff_number),"			\
-"\"\31\", nco:phoneNumber(?aff_number)), \"\30\")"			\
-"WHERE {"								\
-"	?_role nco:hasPhoneNumber ?aff_number"				\
-"}) "									\
+"fn:concat(tracker:coalesce((SELECT GROUP_CONCAT("		\
+"fn:concat(rdf:type(?aff_number), \"\31\","			\
+"nco:phoneNumber(?aff_number), \"\31A\30\"), \"\") "		\
+"WHERE { ?_role nco:hasPhoneNumber ?aff_number }), \"\"), "	\
+"tracker:coalesce((SELECT GROUP_CONCAT("		\
+"fn:concat(rdf:type(?con_number), \"\31\","			\
+"nco:phoneNumber(?con_number), \"\31D\30\"), \"\") "		\
+"WHERE { <%s> nco:hasPhoneNumber ?con_number }), \"\")) "	\
 "nco:fullname(<%s>) "							\
 "nco:nameFamily(<%s>) "							\
 "nco:nameGiven(<%s>) "							\
@@ -1063,10 +1069,8 @@ static void add_aff_number(struct phonebook_contact *contact,
 	char **num_parts;
 	char *type, *number;
 
-	/* For phone taken directly from contacts data, phone number string
-	 * is represented as number type and number string - those strings are
-	 * separated by SUB_DELIM string */
-	num_parts = g_strsplit(pnumber, SUB_DELIM, 2);
+	/* Type and number may be followed by A (affiliation) or D (direct). */
+	num_parts = g_strsplit(pnumber, SUB_DELIM, 3);
 
 	if (!num_parts)
 		return;
@@ -1085,10 +1089,9 @@ static void add_aff_number(struct phonebook_contact *contact,
 		add_phone_number(contact, number, TEL_TYPE_FAX);
 	else if (g_strrstr(type, MOBILE_NUM_TYPE))
 		add_phone_number(contact, number, TEL_TYPE_MOBILE);
+	else if (g_strcmp0(num_parts[2], "D") == 0)
+		add_phone_number(contact, number, TEL_TYPE_OTHER);
 	else
-		/* if this is no fax/mobile phone, then adding phone number
-		 * type based on type of the affiliation field
-		 */
 		add_phone_number(contact, number, get_phone_type(aff_type));
 
 failed:
@@ -1658,7 +1661,7 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	if (g_str_has_prefix(id, CONTACT_ID_PREFIX) == TRUE ||
 				g_strcmp0(id, TRACKER_DEFAULT_CONTACT_ME) == 0)
 		query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id,
-					id, id, id, id, id, id, id, id, id);
+					id, id, id, id, id, id, id, id, id, id);
 	else if (g_str_has_prefix(id, CALL_ID_PREFIX) == TRUE)
 		query = g_strdup_printf(CONTACT_FROM_CALL_QUERY, id);
 	else
-- 
2.34.1


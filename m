Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820019;
	b=rFCeSJn08em+VsSBjbEPMV5w8f8zk0MFpgHH0051mQkImk76jUv5BfuenJaMdgWBFI1Z
	 zaIYKcRy27h67AxXIgrX7AoYP6c2oMIov1+sWnQn1jt9Nv1gSVX+P/gxbTeUH/TaVElQX
	 evzj+upFoYJJi6mdg4mDk9eKfNMetGFc5iQVr3/hQ00CxDY8ErVGG+iCdZgpn2B9ELeHd
	 wQfDL5xKCE0msLV88R2WxqFj1hXvExFaHs0dQDW0ayc+w+6VnLwmGgX+BNII1OwNRKmVa
	 AHFw90vkpdE9hENvtvTAUvKf8On7JMNjZwfQgBA5tNyxAYHrYRoJ4B/8MDtFHW+PIPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820019;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zEcdc5SuxwHzQVfMMay2QUtrqvbBfaqlxctdOZehfho=;
	b=zb9HQQogyrnuaZ08wE5fwgyO6hn+ZDnRa4Y5Dd8sSlZl6LXja9LQ2lRHUYNPzqAqpbfU
	 BwnB/Ot7f2mH2krb0bQKKhgwm+VkTsiSbGa9Qsp+Pbq7bcZ+EpibEGLX4HroMgIC3n7Hd
	 E2fvztwPenr7x29+r/yWvUVgvdw/v/BqUwca/uujy4aPM1E7z15614oz8tx4TI0UfubN2
	 kRgKvZ0ebDwtXDz3DHJY5oq1VQEnzIJMgAeCLdRIWhCMOCC/QDFxBy/KxLFuWR0Ls4AGk
	 d9qZDBsRoyZqpeWrPBRJ8K/cQ5hG9LGsx+r/l/HMNgSD6TTgMCxP5htTeOrg3ZkDEag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZR01oZEL;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D0606A882
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 646D0606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZR01oZEL
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7fKLw3193113;
	Mon, 16 Nov 2026 09:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zEcdc5SuxwH
	zQVfMMay2QUtrqvbBfaqlxctdOZehfho=; b=ZR01oZELkwP+dUuJM7y4YlYpRmJ
	lC+RA5bNmZM67PENpxAs1/v8ukPr6KplNm30oBqxRXgky/A9jGXVmRrCR9DPlmo/
	jci3x5/i71MqrnV9myKJdqdGY5SBJibJWumdxPTFNwdzta/sb02i8GvvcMrhCtcS
	P0fsVAMVoIu12sldPh2Rac7+1opW99shUcWxT7iXyiblwmCHMJ0O339/4ctZTNDN
	Je3ZZWhIgrOKSz6wWy6aacB32vuVg/jsm8RY0xCcSvmp7CS002k/9T8AcSlqvdt2
	rpHmbw+tL+EW0EMfKrzDWVDuiZJpplXQ9yGRqee6Mn9N5G3rZBk+IvrjFzA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhj45qwd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:57 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96tAG2942876;
	Mon, 16 Nov 2026 09:06:55 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AG96t0s2942845
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:55 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 9290127A00; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 05/20] obexd/pbap: Include directly bound Tracker telephone numbers
Date: Mon, 16 Nov 2026 17:06:19 +0800
Message-Id: <20261116090634.1222593-6-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
References: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfXyOKVE4aQTqLZ
 AhKnziHxAT1KjnFdjGA4nGpzvIRvZ1NfqOd06plmJNAttZxdeWDSn+dhqtEY6eXchB0S1+TjcnX
 P2zHH7oSh3JZ5QVyXTqL8VHTjFHssDM8t5HP8xaWvXK7DgbeQaHiQapMBssjTi3LXYq1aMuhvvt
 7Is7OGNqhKq71mzQ2XKevTBhIwJYDl9oB9x90agLdAemeiQ8EgG4etBD8Ecp62zaHe8yp7fOgnM
 3wWozbc3sWCMdTlNGfSBQwI9Ta/O2rZQ7bGphYm5CaeK8ZD8/+HAnhS1UNu59qP5LxQzQAYDN5G
 1ngOvlPOuzY+iMrKBcrfCn17oT1IyeLkFKI+G3osc/jRky1q5nSovGvaOMpIuEWstoNIp5koS07
 mUK4Z+bvqbkdhhWMW8IUD/8hMnGsADIyWfWosslgjhJYe3QVau1qNM500eHhlhRcTiPtMxsYVLS
 CHunQjSQidQMz/uNp9Q==
X-Authority-Analysis: v=2.4 cv=av0nmiZV c=1 sm=1 tr=0 ts=6afac7b2 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=6kwYN7l2Pbr54CibywkA:9
X-Proofpoint-GUID: UUDcxHs9bfdaS8GzYV4v8asjrlt4mtkQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX3O9inpQk3nAw
 H2g+YJzeRwiaxEKTXPqSSFtwDhOzEebb+ZFlAEA7vgodnxnv7/0QmRi5h6ughMXVp25HvrVzTwF
 QnVTmrNOLn2Pd/xfUQE2seAnjYT5kNw=
X-Proofpoint-ORIG-GUID: UUDcxHs9bfdaS8GzYV4v8asjrlt4mtkQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

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


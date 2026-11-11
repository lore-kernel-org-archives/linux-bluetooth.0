Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390279;
	b=BVWc3WnguwiQk0LK+TkKcohk87TXRCurtdOqfjvPHRWrPMXjNxKITqrzul8KIYMGgHHG
	 XgK1eXXvVqPgeoz+IBYKanrWFoJ2eGfaeqjU2hVVKm73uossYzCLKT1RKYcib3mkI6cJf
	 7puxP/W15aZ/USTU0FganQS9rEcnc6uDaoJFoB7MOZr/+XGESEMR8AxAnlFou3TubPIm+
	 YJUdOUYIK2u9vWHQGAKtwLNblQ1+RR+QCkIhvBGSYjKC3AIs2I1i8/SF4uXsgpV5PUdS2
	 K8b7vmpCqFIANrkIriKD8+lyJ1RgcIMV0hRQK/ZfBa6ynohFw7PQoVgZTQkctvlhXLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zEcdc5SuxwHzQVfMMay2QUtrqvbBfaqlxctdOZehfho=;
	b=vgMFXY1ws3M5scu4h2laXOtkDUpua7mYbYaAi5I+6ECGzwn8lkJfkLGkP4yEsVnDEzw6
	 fihQX3PTD+xSeuBMXEPV1pINphXWzsTqDV3a5ip/NL0c2kwut9bPMMe4w72rHisbtFmBC
	 Bp4UMfwSGiO40r7EvdJg4Y26H+KLraJI72pkB7zHiqRB6F/5DTrbafkwbVWQGS4GGdN3W
	 g+dzq9co7EAcv4XEsyCwR1f31Hxg6Sj+E/Ob81yDkAI+JCkcr6o6S012ZY3lzoLLkf1ll
	 1tl8jAteTO8lipmVuHyqDkfd92XPa7Dgx89stW8YGgKr9/SCIUTBZDnnQYd8HhHxldA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jo0T76xA;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CA606A339
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F6CA606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jo0T76xA
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KJox1386372;
	Wed, 11 Nov 2026 09:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zEcdc5SuxwH
	zQVfMMay2QUtrqvbBfaqlxctdOZehfho=; b=Jo0T76xAoomDmcNz//n9zUSeATx
	f/4n+RJaSH9hgaTmlF38DX38crHLUQdGHRL3vSvgoPlqn26R7qSFNbLHd9rjQ30l
	gOZ0Q88/Fpp0OEYtbZZwIniiif/h9HsyN/wtko1bElObadBceDoMkX2XoxEvyvbn
	uZEvKM6kEfcjG9FIQfGaAAzGF6+QeTWw5rvlRIr911MhhkxuFieHZjfprCr7SyVv
	Q/NK+YRwFFPMQKHNfEQN8exJXvw5kyndYK/JHwdVk5Z08KTQk5+BM9tfte70PNaf
	yGO2PiIzgVDWIL1DojTiLsIH8GYTY64BnaY4LjX1lFNGbYIhPc+DdCB6cww==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnm9xe4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iZua2424217;
	Wed, 11 Nov 2026 09:44:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AB9iZCM2424172
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 3E474243C6; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 05/20] obexd/pbap: Include directly bound Tracker telephone numbers
Date: Wed, 11 Nov 2026 17:44:10 +0800
Message-Id: <20261111094425.1444893-6-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: ZB51Rs6YQVdwoiU84nRSjh-yvNrVCV1Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX/a2LqX5pRKuj
 fIPswChYw1aAzpj8cqWeNznyJcf2bEzvf1ffj5RHdQYVOZAecyQHv1YkLlMwBijhAIdUtrlWmdA
 2XvuYgRv1fgk2g7+8KMr0+QlwZLDQRY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX+YsLptJQUhsd
 8pFsaR9fH5nHj6iuQWhKlpUfv3ZtlsZs+Ckm9XXsyYzee1PNFhi3fSZrFKiQecVs3IPkXyec4eP
 hFBOnYFJE6yukYMbuH9VSnIbVWBlk+3Ns3I+ipwkpFwtG4njpi3wIgVP22p5LxJYk51FqvAFsXS
 wo0EJAF0ZqPobguI+WcghTpMfemQUyhhbSMOW/ItJzY9roVdFJX/N7zLfC+hoTKghK+Ojz4hmue
 4PC/zXUHELyzcGKGdroXdscQYoXeb4yXG9Q68ugmR1/lfZIBoxO5ebOomIOzmjT3R7uAYuBItby
 srSf9SNGN1M2tOzfTIwautN2cc4i4EVDFxbuV77PJqhiLUlNx/ptOMFFH6jLqmk5CSQhF8GvwDz
 5fQX/gSE6THe+k2fVFAqS2NDCr40aGzZTK9DNbrSc2pEp3TDcSVJ28QY4uR+nMUpoS32GfBbdwC
 MvutM5QhJNNpxngfskw==
X-Proofpoint-GUID: ZB51Rs6YQVdwoiU84nRSjh-yvNrVCV1Y
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af43906 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=6kwYN7l2Pbr54CibywkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

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


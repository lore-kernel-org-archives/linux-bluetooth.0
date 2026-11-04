Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781283;
	b=eLUZBueKW9mnFXJWur4S0MuKzfwJz6JOUXhOT2BZE//eTSCmcZzIAMjJ2Ntt1S6/ZWa/
	 U3IfvZAEUOQa1IwQzEve5d7hkp0iIoOzJeAmfFuy0ohZS27vPo9VvBVDknct2t37yxILk
	 YNyBUhi5ZCLj8nvLjmeusAUt89/LWcbaXIVnJHuVa0y+mTl0mQvRvd4VbrC56L5JxWYCV
	 LVi0kQHOFTZYQHz1TghW9KRRndGB7G/AOvpH0BXU7PKlx2lUTH5atwEz9WPaiDE0q6Xb9
	 WMrdpbpfxju+Kcp137oUMPOOkpuw/75KwOvJ4RX6QZc6KoiiUoKKQPqDwus8jIfVD3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781283;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NELoGcVFFV3OvaTNBgWbmJWk/oTkRYkBEwbkm3j51Ns=;
	b=Zd2kqaW+8J2nFbLSh8+7iqZayzAKOrXP/ufmmyWIqSLOIC00+UWpeqbMp9QTb8B9PsUn
	 LUu49VUWoFG0Yx1ynZpd1/y8a2PQ6EuO0nOkDk4m7NvVM7n/TXPtxZnvy3r0y3MZyiEsU
	 3YKpozpXOmYN3ZYbP0TcT/7cKuyoUIpn1qOIT37BGuSWfABrXdKLr7uO0nTxckapxx4zS
	 tvghPpwsdnoTWa5uB1tdVYORTjLXscDYYbIK1SLfQpa6fqv2zcqfNuRpTgT4HTDmS8uJ2
	 jCcMaC/qg5s6uoDmP2kVOcPUChP5PUyJQ4gN5V5zbJzAr3NjpcvtIWt8HK/4JOUJYIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pGywyAnB;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3A606D805
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEA3A606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pGywyAnB
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48L0EC1274963
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NELoGcVFFV3
	OvaTNBgWbmJWk/oTkRYkBEwbkm3j51Ns=; b=pGywyAnB/EsJq8tzp9dkhYiEDTN
	x/AeicM5CZ6iEjLuFPEMNcM+bH89ju3qDyUXIbzg/jcsDyh7xXg5Bq7WXSAltYi7
	m0m6OuraVXBnmVhKyAikoYSYEgcO6vTyjs9XfildEk2NiUbXEXBu+dSLtCdahZsq
	AJV0unh+SOCmojHyTNpmNXnWuJtFi9/kKKL8gcyt+tN34SnMSKDPrAGzU9RApVnJ
	TOOuef2as1R0vFeV9GurDvxSXAd85kHuQlSGUZ+c5R3uMISfbLcBQGCUH7gNWb/T
	FmqeVMrVxl4N0dzR/2HGCjUHUQJt25ybbJh3NiNl4M3FuOWJtVL3N7ddNMg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqhypm1ae-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YaJW2688034;
	Wed, 4 Nov 2026 08:34:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A48Yahs2688019
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 62816279B7; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 05/18] obexd/pbap: Fix unselected PHOTO in dummy responses
Date: Wed,  4 Nov 2026 16:34:16 +0800
Message-Id: <20261104083429.4111632-6-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX7tu89yB0MhOW
 k0sKF7Q/Ceqvy44UukreEAMO32GdryPzbMJghsGC8daeX/McgyPKEWljEXPkh2T6Loj/0+SEH8P
 bk0yUkmc58XtTa/SM+WCFjJvHgipC6M=
X-Proofpoint-ORIG-GUID: GUeVzcLwtVnSFuXj7V7R1ZhVhwua4_VD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX6LJQeniou6do
 +fyHRd5ZJ4cpTT3jVL33+oeaQHq3fryRnQDdxqdPFyrqCEayHV+9/vg/CQOlA5U7G1RMHDLcKlI
 jBXEiIa92VvWEJP47oko5VT2cCG07U2S6DeNkINY7c9+yiQMDb9CrztswTohjON/aB3avXmQD+4
 O5TxXI8DFMQRb6qscZAv6rXqIHQH4zfzJs1wXUP0iQNx+1Zz14CcsbnNjSPYbXWZdKnqk11hFYz
 73wtFIJVxYHU0rJydgUBZR3Mqf1NcAs3XokFIV04IGb1TSEdL+f7A31GQ7mnyu4XsczcX03UGlx
 R0jqcslVgi5OQ0+/8s6sSnkuKRpkLw4wdbsUOrFTRqd9S8V4cvvdzCORrcJUbq2JwRZ6H9a671x
 apyJXzcTQZGDLyljI7nNDod2ONGB4i6gHGWXBCU6BrDw0Is6A4wfZ6IhRDG3zF4Iyc2++fDHQqn
 l8oWEr+4dp0n8gfIgww==
X-Proofpoint-GUID: GUeVzcLwtVnSFuXj7V7R1ZhVhwua4_VD
X-Authority-Analysis: v=2.4 cv=T94Z3PKQ c=1 sm=1 tr=0 ts=6aeaee1e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=1ZKsQ-zRZL7qXSpE_4oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040033

Fix the dummy backend returning PHOTO when a nonzero PropertySelector
does not select it in PullPhoneBook and PullvCardEntry responses.

Fixes: f34bc5d924ec ("obexd: Add PBAP PullPhoneBook function for dummy back-end")
Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/phonebook-dummy.c | 84 ++++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 12 deletions(-)

diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 14075b502..7c11ac975 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -193,10 +193,64 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 	return 0;
 }
 
+struct concat_data {
+	GString *buffer;
+	const struct apparam_field *params;
+};
+
+static char *filter_vcard_photo(const char *buffer, size_t length,
+					const struct apparam_field *params,
+					size_t *filtered_length)
+{
+	GString *result;
+	char *copy;
+	char **lines;
+	gboolean include = TRUE;
+	unsigned int i;
+
+	/* PHOTO is bit 3 of the PropertySelector. */
+	if (!params->filter || (params->filter & (1ULL << 3))) {
+		*filtered_length = length;
+		return g_strndup(buffer, length);
+	}
+
+	copy = g_strndup(buffer, length);
+	lines = g_strsplit_set(copy, "\r\n", -1);
+	result = g_string_new(NULL);
+
+	for (i = 0; lines[i]; i++) {
+		const char *line = lines[i];
+		const char *end;
+		const char *name;
+
+		if (!line[0])
+			continue;
+
+		if (line[0] != ' ' && line[0] != '\t') {
+			end = strpbrk(line, ";:");
+			name = end ? memrchr(line, '.', end - line) : NULL;
+			name = name ? name + 1 : line;
+			include = !end || end - name != 5 ||
+				g_ascii_strncasecmp(name, "PHOTO", 5) != 0;
+		}
+
+		if (include)
+			g_string_append_printf(result, "%s\r\n", line);
+	}
+
+	g_strfreev(lines);
+	g_free(copy);
+
+	*filtered_length = result->len;
+	return g_string_free(result, FALSE);
+}
+
 static void entry_concat(const char *filename, VObject *v, void *user_data)
 {
-	GString *buffer = user_data;
+	struct concat_data *data = user_data;
+	char *filtered;
 	char tmp[1024];
+	size_t filtered_len;
 	int len;
 
 	/*
@@ -207,19 +261,22 @@ static void entry_concat(const char *filename, VObject *v, void *user_data)
 	memset(tmp, 0, len);
 
 	writeMemVObject(tmp, &len, v);
+	filtered = filter_vcard_photo(tmp, len, data->params,
+						&filtered_len);
 
-	/* FIXME: only the requested fields must be added */
-	g_string_append_len(buffer, tmp, len);
+	g_string_append_len(data->buffer, filtered, filtered_len);
+	g_free(filtered);
 }
 
 static gboolean read_dir(void *user_data)
 {
 	struct dummy_data *dummy = user_data;
-	GString *buffer;
+	struct concat_data data;
 	DIR *dp;
 	uint16_t count = 0, max, offset;
 
-	buffer = g_string_new("");
+	data.buffer = g_string_new("");
+	data.params = dummy->apparams;
 
 	dp = opendir(dummy->folder);
 	if (dp == NULL) {
@@ -242,15 +299,15 @@ static gboolean read_dir(void *user_data)
 		offset = dummy->apparams->liststartoffset;
 	}
 
-	foreach_vcard(dp, entry_concat, offset, max, buffer, &count);
+	foreach_vcard(dp, entry_concat, offset, max, &data, &count);
 
 	closedir(dp);
 done:
 	/* FIXME: Missing vCards fields filtering */
-	dummy->cb(buffer->str, buffer->len, count, dummy->newmissedcalls,
-							TRUE, dummy->user_data);
+	dummy->cb(data.buffer->str, data.buffer->len, count,
+			dummy->newmissedcalls, TRUE, dummy->user_data);
 
-	g_string_free(buffer, TRUE);
+	g_string_free(data.buffer, TRUE);
 
 	return FALSE;
 }
@@ -332,7 +389,9 @@ static gboolean create_cache(void *user_data)
 static gboolean read_entry(void *user_data)
 {
 	struct dummy_data *dummy = user_data;
+	char *filtered;
 	char buffer[1024];
+	size_t filtered_len;
 	ssize_t count;
 
 	memset(buffer, 0, sizeof(buffer));
@@ -344,9 +403,10 @@ static gboolean read_entry(void *user_data)
 		count = 0;
 	}
 
-	/* FIXME: Missing vCards fields filtering */
-
-	dummy->cb(buffer, count, 1, 0, TRUE, dummy->user_data);
+	filtered = filter_vcard_photo(buffer, count, dummy->apparams,
+							&filtered_len);
+	dummy->cb(filtered, filtered_len, 1, 0, TRUE, dummy->user_data);
+	g_free(filtered);
 
 	return FALSE;
 }
-- 
2.34.1


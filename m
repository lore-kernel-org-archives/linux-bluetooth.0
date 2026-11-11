Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390281;
	b=idVCPIK3tAEKiFj3Qcs2RsCQNsksaNb4niHjlE5qRpVnOQcZS2L//f6zBbDm4rKqOYgV
	 ggiAgz9502Nzn+lcDiTKIL7L/qxv1wllN66N4R+UbSM+943Zn7Wc4lPi4S6O9CR7KAvTu
	 dt39SPkR6Nwhss3PGwO+layiaqGDt5cBkfUY2wBXxU1mCzkPJUxbniPAKd+ZrmhjoyvMN
	 IROUAFNvQL7jrxVtzW5kPfvL6GzdPYm20XtA9cB5jrkcUP5ce4S1DkxQ3R34ITYZs6bYO
	 MJPPtBLYoP/MKB0MjAXvBaZj2l7h5SB0BxSWT3dae+kBo9GR1dPVDSQr07Kvbtcg8ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390281;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=T+Aa3KgRhv1BNUM+hntLkfL25jn7kYwylTrLquSZF9o=;
	b=AUgH/D39BSJRn7/HhCkx/9TH07uFb4yh4ZIvAJLfrNTZ5jToUVLYL57lpuryP+YiHNdv
	 WOJGDaceYghayZ7nzig9iduaekrcgTUWDfForBnPqaux3IgOZiMYzI1uvrzrA6LEBqt48
	 8pf7L5aqGKycPj38QIi06qm1F5orpO8DHuf3uGwI9gk6PPkpKxusknz/jQBQWva8mMB9k
	 QmoK1S2L2D9OPn2U3woGbmlYQewzkTEoh6TN7imQoZEl2EVn19BB/nsPtD+5+iBzEus0K
	 XTbnBe9DN5rFCXZN6SgHloZWGxKgZowa0aZwOMurNshZwaBwjLzrAUSXCTfuMvIjJnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WIFjsgB+;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9960A262D
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73B9960A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WIFjsgB+
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KPxV2017607;
	Wed, 11 Nov 2026 09:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=T+Aa3KgRhv1
	BNUM+hntLkfL25jn7kYwylTrLquSZF9o=; b=WIFjsgB+5BxAfD8mARLsfb669zx
	L7Cb4XjXjXDjdyoxbshyIFXlKPz5+6928Tq9ZZeHgspiH9MD5QsntUBaiCyEU/96
	sWfKi8/KKAOHjzoh5NZuo9raBhMEXW97jHUo+XQrkMcH9s3WkuZfkedTWDDx6yg4
	a4gF2ulJMvM7yAeZghbpLTcxf34TX3BI+tgUWdSddXt0Aqp8kViHbNUdodS1t/KT
	pMS4peNPvpfWf6BAoiDue0s/xmKxn1ShwQgz+9S2I9g/nKYj0l7Y8hqkbwo3brh8
	IXS4wuMmoI9xpiWIhbADYVWjkMQyHz/9RnIEWylumDZvT0vKXxglu7t+3Ig==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97cb3dg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iZFC2424412;
	Wed, 11 Nov 2026 09:44:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AB9iZ9Y2424366
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 469B4243C9; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 07/20] obexd/pbap: Fix unselected PHOTO in dummy responses
Date: Wed, 11 Nov 2026 17:44:12 +0800
Message-Id: <20261111094425.1444893-8-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX7uzen5C52tG8
 sXgmnl1zvDWdsLiK2v/iEKnLzweEShKucI/Zz+NzrI1JA6jUgvwmK96TMju3ZRkVuNIVhdPFVrp
 kJPmhAyiK6APFcBiOLawFnQykxE1hOp56408dryLQSI9xfNoTdV9OSztOW7D7+yGJgTkoEvIXTc
 Kt5OUvwK1Mi4+uleqvx4/rhVxl9PIuNPStdtblUGgmsHtRZ8BpjhAyoTS5i0cAx2xbCNk9fOVXQ
 ffUudf/R2OZin2X150f0kU/XZsEJw2yhGcsnW3Pf5SJIsFcjcOBlp8vJIx9Q23GS0jLR2Auv7fW
 l7UXPjr9GeEHSUg888O8NSWXBgR/AATODKZg4OswBuh2+70/m8ME6aLfsJF1Npg6kSvK2t5mAw7
 FO7ZsjpHDD+fpRh6cAa17Sq8wSiWSHK2cQKVxma/6Mq0bI37QcDUMvZgwwCWpZpg6dep9O/T1pI
 r61GTMzSrlfNmaBW6lA==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af43907 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=1ZKsQ-zRZL7qXSpE_4oA:9
X-Proofpoint-GUID: YQzSn1-wJo4QTIZR23TXtAW4QxeDxDUw
X-Proofpoint-ORIG-GUID: YQzSn1-wJo4QTIZR23TXtAW4QxeDxDUw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX9fJ6j9Z5R4eN
 8o122xdiex4UBZmflJtkZ4kCbfvp+8Dza4R3OjMnnK3onja64pJLcLPne0kZRWIq7DSdUodIqRV
 8Q8/4866CxXSn1d7L81ljgdsqHrkTOA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

Fix the dummy backend returning PHOTO when a nonzero PropertySelector
does not select it in PullPhoneBook and PullvCardEntry responses.

Fixes: f34bc5d924ec ("obexd: Add PBAP PullPhoneBook function for dummy back-end")
Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/phonebook-dummy.c | 105 ++++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 12 deletions(-)

diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 14075b502..6b91c199c 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -193,10 +193,85 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
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
+	lines = g_strsplit(copy, "\n", -1);
+	result = g_string_new(NULL);
+
+	for (i = 0; lines[i]; i++) {
+		char *line = lines[i];
+		const char *end;
+		const char *name;
+		size_t len = strlen(line);
+
+		if (len && line[len - 1] == '\r')
+			line[len - 1] = '\0';
+
+		/* Nothing follows the last line break. */
+		if (!lines[i + 1] && !line[0])
+			break;
+
+		if (!include) {
+			/*
+			 * Folded lines, and the unfolded BASE64 lines and the
+			 * terminating blank line of vCard 2.1, belong to the
+			 * PHOTO value.
+			 */
+			if (!line[0]) {
+				include = TRUE;
+				continue;
+			}
+
+			if (line[0] == ' ' || line[0] == '\t' ||
+						!strchr(line, ':'))
+				continue;
+		}
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
@@ -207,19 +282,22 @@ static void entry_concat(const char *filename, VObject *v, void *user_data)
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
@@ -242,15 +320,15 @@ static gboolean read_dir(void *user_data)
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
@@ -332,7 +410,9 @@ static gboolean create_cache(void *user_data)
 static gboolean read_entry(void *user_data)
 {
 	struct dummy_data *dummy = user_data;
+	char *filtered;
 	char buffer[1024];
+	size_t filtered_len;
 	ssize_t count;
 
 	memset(buffer, 0, sizeof(buffer));
@@ -344,9 +424,10 @@ static gboolean read_entry(void *user_data)
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


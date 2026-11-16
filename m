Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820019;
	b=OxlibtuVAitEJ4oxOTkUbAqlvuK9O2UQluECQVNew4WCO9jrGl95rZRyRZS6/UxVVrFb
	 klZOjNa06TpdeqYDS6pZBQjq+2108L/F3PUqSHV+34CaHnjxXZlwDRUIlk9kp7zKUooKK
	 fr1u5r7nNsuJOxU993B4pB0/2/CqMgnW7+0x19Upbw+9DmvfE3U3bsl2FVBJPV5mRLgn4
	 6dxBqI/0kutSPWWbSpZR7SjTDOHeRqaJcZkgIYRBl6mQLQEnuOkc9j4hU6ALSY6HcOtER
	 7mnb+yualz4M+tJmVPZy790kIYhWDLF+3wQ6CtLap5SLKI1ZcmQk4ZQEjoHj/AB0yEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820019;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mdjFQ9I8aoU9i0dSTF4ko7Pi2QnYmJ+nOemH8C1kRfc=;
	b=G/Ok4rx+oIWG0Zp6+MSC326OMPMT+4jkyAST8WILey8QaifuzayIOXM9p0Y7lWUUby2m
	 PrCNEBHTZND1PvqvtKZD8wvoSfmDNJg0CWrDzzJuMUYlu5LJJzdxpzdEcWMl2XKUs9bk5
	 63ygCutqxiD+TYR/dax/95o030quYuARJoJEa3hK1WbZVDocDqqlycXUZGe4whxv1G+mD
	 Jny6Abe0S3Gsf/gEgMfFjmK5tHtgtGazUWJS9Js6TYeoXxM7twiqZKHcdBc9nG8t5g5iq
	 HtrVGjAMb19kMzKEVotb6ogsGDyKpEZPNumckjo4P76deB2o/kFQXS87MCvME75RyHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RhUG3D8G;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA0606A881
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EEA0606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RhUG3D8G
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7eo4J1109795;
	Mon, 16 Nov 2026 09:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mdjFQ9I8aoU
	9i0dSTF4ko7Pi2QnYmJ+nOemH8C1kRfc=; b=RhUG3D8GPJQ/qDdDHsX+Y6FTF9S
	yQmtDqQ482Jy0iG0xf/t96KKD6Sz3ZfXGzqVEAeOsF8SSwTiy92U/U8yyBlds724
	oUvs2kHOXKwlmRdSWaL5mIq9Af89+mn3cMB62cXY7jR32KTewm7Q6kvC/K8xKNoa
	gIDdPOSGbaucUkdrXa/z5XLT2zDGObVjwYvX6qxK2wZxJGgJWtqwJPw0Oh5Kn/E8
	wdSaH5DwthO0Ro/VJkXrTwrrjFdNt3I5NQJVkGBxADcBVuIhZ/iIF973onU3k/TT
	qc8hfmO6MHGzR8ez8bUWN6tsRDi9UDJrE4FGA3ltlEuU5xaPImCLQyoFCQg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyrmc1d7r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:57 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96sXr2942823;
	Mon, 16 Nov 2026 09:06:56 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AG96tus2942844
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:55 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 9A93927A02; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 07/20] obexd/pbap: Fix unselected PHOTO in dummy responses
Date: Mon, 16 Nov 2026 17:06:21 +0800
Message-Id: <20261116090634.1222593-8-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX9xTkSPLUHb+R
 zkTcQg6/yAgm7geDUVxVsy4NMseQLVfhay+PZapdXjx5DM98YhKcOwCfbJfVUynnQbi6JwJk2iZ
 9IR20h8Rpq8eN9xcj4XRR70mUQ5D8aM=
X-Authority-Analysis: v=2.4 cv=C9N8WgP+ c=1 sm=1 tr=0 ts=6afac7b2 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=5TEQYPNMxTek6-QknBcA:9
X-Proofpoint-ORIG-GUID: fHvXWPne--MiZGTXMI0pGAclRYksvtW6
X-Proofpoint-GUID: fHvXWPne--MiZGTXMI0pGAclRYksvtW6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX+hbMuUMdkUJQ
 ZFvskVjg4W2PVG5Bn78Vhjo/vxev+fnbGMIagr8FqmanqMjDvdI/Ph9BMWKEkJrKlkcxz5gqS8U
 PxgKi2glf06O60DB8kP0OxwBzk1Z9u+daXQwcanlMYr9iuH8oxIuW9m9XEU6HDpys0i7GJcDZ13
 hFPgEclWjSuK6rBwEiiV6Q6E26i8baCQyT7LTn2uB9879fT51pVFQUOqnhmwQ7JqvcKKEbKY5/4
 qIaWRZ0WNbbm5tJYyG6DEAobFX6pFHXjVrzICt5ZvhMKIovApHrD3D30haIjDjUqYLZt40eZyRO
 LJ8KGYjG9gHgXWu6rRdWCQMQXRw9Mde+t5J7hJMTzdU5z1Odcuh0mjJOKCmnt+8PJH/rl51fYfD
 JDhoV5SKHxngjN8K4JKk+HMQRHijsGl51YhLBE7YkZadqtsBqhV9JfJuMtrvONverm8SLwC93eW
 hnplbhqJLOmCr3avVVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160036

Fix the dummy backend returning PHOTO when a nonzero PropertySelector
does not select it in PullPhoneBook and PullvCardEntry responses.

Preserve quoted-printable soft-line continuations when the ENCODING
parameter is folded across header lines.

Ignore colons and semicolons inside quoted parameter values when
detecting ENCODING so PHOTO filtering does not truncate quoted-printable
text.

Fixes: f34bc5d924ec ("obexd: Add PBAP PullPhoneBook function for dummy back-end")
Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/phonebook-dummy.c | 248 ++++++++++++++++++++++++++++++--
 1 file changed, 236 insertions(+), 12 deletions(-)

diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 14075b502..c4598fa10 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -193,10 +193,228 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 	return 0;
 }
 
+struct concat_data {
+	GString *buffer;
+	const struct apparam_field *params;
+};
+
+struct photo_filter {
+	GString *result;
+	GString *header;
+	gboolean include;
+	gboolean quoted_printable;
+	gboolean qp_continuation;
+};
+
+static const char *photo_filter_find_separator(const char *line, size_t length,
+							char separator)
+{
+	gboolean quoted = FALSE;
+	gboolean escaped = FALSE;
+	size_t i;
+
+	for (i = 0; i < length; i++) {
+		if (escaped) {
+			escaped = FALSE;
+			continue;
+		}
+
+		if (quoted && line[i] == '\\') {
+			escaped = TRUE;
+			continue;
+		}
+
+		if (line[i] == '"') {
+			quoted = !quoted;
+			continue;
+		}
+
+		if (!quoted && line[i] == separator)
+			return line + i;
+	}
+
+	return NULL;
+}
+
+static gboolean line_is_quoted_printable(const char *line)
+{
+	const char *colon;
+	const char *p;
+
+	colon = photo_filter_find_separator(line, strlen(line), ':');
+	if (!colon)
+		return FALSE;
+
+	p = line;
+	while (p < colon && (*p == ' ' || *p == '\t'))
+		p++;
+
+	if (colon - p == 25 && g_ascii_strncasecmp(p,
+				"ENCODING=QUOTED-PRINTABLE", 25) == 0)
+		return TRUE;
+
+	while ((p = photo_filter_find_separator(p, colon - p, ';'))) {
+		const char *next;
+		size_t len;
+
+		p++;
+		next = photo_filter_find_separator(p, colon - p, ';');
+		if (!next)
+			next = colon;
+
+		len = next - p;
+		if (len > 9 && g_ascii_strncasecmp(p, "ENCODING=", 9) == 0) {
+			p += 9;
+			len -= 9;
+		}
+
+		if (len == 16 && g_ascii_strncasecmp(p, "QUOTED-PRINTABLE",
+								16) == 0)
+			return TRUE;
+
+		p = next;
+	}
+
+	return FALSE;
+}
+
+static void photo_filter_append(struct photo_filter *filter, const char *line)
+{
+	if (filter->include)
+		g_string_append_printf(filter->result, "%s\r\n", line);
+}
+
+static void photo_filter_append_header(struct photo_filter *filter,
+						const char *line)
+{
+	if (photo_filter_find_separator(filter->header->str,
+						filter->header->len, ':'))
+		return;
+
+	while (*line == ' ' || *line == '\t')
+		line++;
+
+	g_string_append(filter->header, line);
+	filter->quoted_printable =
+				line_is_quoted_printable(filter->header->str);
+}
+
+static gboolean photo_filter_continuation(struct photo_filter *filter,
+						const char *line, size_t len)
+{
+	if (filter->qp_continuation) {
+		photo_filter_append(filter, line);
+		filter->qp_continuation = len && line[len - 1] == '=';
+		return TRUE;
+	}
+
+	if (line[0] != ' ' && line[0] != '\t')
+		return FALSE;
+
+	photo_filter_append(filter, line);
+	photo_filter_append_header(filter, line);
+
+	filter->qp_continuation = filter->quoted_printable && len &&
+						line[len - 1] == '=';
+
+	return TRUE;
+}
+
+static gboolean photo_filter_skip_value(struct photo_filter *filter,
+						const char *line)
+{
+	if (filter->include)
+		return FALSE;
+
+	/*
+	 * Folded lines, and the unfolded BASE64 lines and the terminating
+	 * blank line of vCard 2.1, belong to the PHOTO value.
+	 */
+	if (!line[0]) {
+		filter->include = TRUE;
+		return TRUE;
+	}
+
+	return !strchr(line, ':');
+}
+
+static void photo_filter_property(struct photo_filter *filter,
+						const char *line, size_t len)
+{
+	const char *end;
+	const char *name;
+
+	end = strpbrk(line, ";:");
+	name = end ? memrchr(line, '.', end - line) : NULL;
+	name = name ? name + 1 : line;
+	filter->include = !end || end - name != 5 ||
+				g_ascii_strncasecmp(name, "PHOTO", 5) != 0;
+
+	g_string_assign(filter->header, line);
+	filter->quoted_printable = line_is_quoted_printable(line);
+	filter->qp_continuation = filter->quoted_printable && len &&
+						line[len - 1] == '=';
+
+	photo_filter_append(filter, line);
+}
+
+static char *filter_vcard_photo(const char *buffer, size_t length,
+					const struct apparam_field *params,
+					size_t *filtered_length)
+{
+	struct photo_filter filter;
+	char *copy;
+	char **lines;
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
+	filter.result = g_string_new(NULL);
+	filter.header = g_string_new(NULL);
+	filter.include = TRUE;
+	filter.quoted_printable = FALSE;
+	filter.qp_continuation = FALSE;
+
+	for (i = 0; lines[i]; i++) {
+		char *line = lines[i];
+		size_t len = strlen(line);
+
+		if (len && line[len - 1] == '\r')
+			line[--len] = '\0';
+
+		/* Nothing follows the last line break. */
+		if (!lines[i + 1] && !line[0])
+			break;
+
+		if (photo_filter_continuation(&filter, line, len))
+			continue;
+
+		if (photo_filter_skip_value(&filter, line))
+			continue;
+
+		photo_filter_property(&filter, line, len);
+	}
+
+	g_strfreev(lines);
+	g_free(copy);
+	g_string_free(filter.header, TRUE);
+
+	*filtered_length = filter.result->len;
+	return g_string_free(filter.result, FALSE);
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
@@ -207,19 +425,22 @@ static void entry_concat(const char *filename, VObject *v, void *user_data)
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
@@ -242,15 +463,15 @@ static gboolean read_dir(void *user_data)
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
@@ -332,7 +553,9 @@ static gboolean create_cache(void *user_data)
 static gboolean read_entry(void *user_data)
 {
 	struct dummy_data *dummy = user_data;
+	char *filtered;
 	char buffer[1024];
+	size_t filtered_len;
 	ssize_t count;
 
 	memset(buffer, 0, sizeof(buffer));
@@ -344,9 +567,10 @@ static gboolean read_entry(void *user_data)
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


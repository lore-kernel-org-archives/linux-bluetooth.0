Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390281;
	b=idyTddLKC3gcu27Btk91OYlvxvjTTANp2cGIWqd8EvWPPL47JOSA8tlDeiiBD3sbqzm7
	 iyqW8auAxB+J1t3MDOMOhHu5N5y9RB/IOB862/Q5UyjRRkkgPqgaYSAAoXemv3lNQtcIj
	 4EbCZAX8IecxCGkcm+riBHASWgWl1DEzI4mVQd++Ego6yhTCUnIRxQqZ7n7rxLS7Mz73/
	 4Nb0X9eNU++zsVsqsimRHR/MeLbqxf5FiS1PbbBwaiSkanXEnkbhAH+tkQ0IECmbvZVDr
	 slqUVCHZD18Q2H+n/2yvUp4Zn6XIfN6NJMAzpGw337chJR8v7Lhn5dTzZEuTYO8tOxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390281;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JqjGq72MJcUEUnYNMzL5McxX0hS8wr7JDUam1fy/0QI=;
	b=1vsXgT+C37Cw8MyOdg1AjTaKgyqYIxbnftJfYizV1FVyHGSKODW8XywTA3Qg2VPmd39m
	 f9WZcIJU0aJ+MmjfD2B7RTkY+otdNExVT5NqbpVbmnVRYp88nWbaRbpEb1wVzOJ8jTrQB
	 1px28DmhUaHOhWsmOdn8m+ja+txCfO49QTdwc1oR9XtoN/hBJgXonspfbhHDFvxy633CB
	 3v6ZWsATgXUTk5v+ILyckG3emm5CwueggYX+hYoJvDYuIqZIM8MQuYPCKeT3Fts9q95g8
	 m7NFxa/yjZz/uo5KXaMv/KQB0SOsaRkG7py+zNbmSAsGi+950Wi/ZO/Ezs95eC7ieZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z8gMcQql;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EFF60A262E
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73EFF60A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z8gMcQql
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KKTQ1386397;
	Wed, 11 Nov 2026 09:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JqjGq72MJcU
	EUnYNMzL5McxX0hS8wr7JDUam1fy/0QI=; b=Z8gMcQqlZqKHlh+dM5MpJH1pmdb
	y9aeg0EspoQXkOQmq5/W88bVQ79W+D/jhoLKkMN2lfpqvLfPOMCdkH6Ag4dQfnA/
	IjPsHxBYKdq6eUA+KQpRuh6b4WDwoC45CU04lQ1+QkD/JtINj3r97PlqRK7AB0Tm
	E6aFrrVmDBoSe1j0cjEFGF+wVyaTjRKpMijUXdCIEta9njcP1gXYDhwYVoDQtdf5
	q0uvex9dR1ZxzkssKC5mCyMtphcwcn2N/iMhoKmWueXVvYVHrZk/m5Cw508nv9XW
	Nh3y7dPH1FUTiS4Sf5wIviPOB5rdzAF4pNpXkx0GVJZi+ZJL5qeo15/tsNw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnm9xe8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9ianE2424296;
	Wed, 11 Nov 2026 09:44:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AB9ia8h2424271
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 78C3924410; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 19/20] obexd/pbap: Support Contact Image Default Format
Date: Wed, 11 Nov 2026 17:44:24 +0800
Message-Id: <20261111094425.1444893-20-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: G2fNRFL5LpRdvcwvmRROd7DqFw_mufku
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfXzya4WbSj9AKq
 OAV7ECBOQnguG7G6vwhOfjJ7XpPMcAZPbSxG6Rie7jH01UfZgBC2TMm1pieayfIoFH6WiGcxRXT
 /T+R9vu8dHAXhIuLsUJ3x+5NS+PO8fE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfXxLKq1F5qu76W
 chzoCgrZ8GDj6iRyJWPW+tgSotY2EcOUuK8uF3WcVgnBOSMq+fhtzupl8GleXyhsKy0SXM5DceC
 5Zq7AXnMlk24sxOz9H5gY5GYMy8tspVBwhLnYV99mq8r31Z+1ZBwMVZpbOkQ/0owmcqufVQSAmD
 tee8RvTlpVBfuhzeXjNp2h2kMO9akQLwGwl82lEY5UuooteW+OG0Xm/OtcyG0hp7/C+0LgmolJ+
 mMsG6Z2uuhBcU2xYFcTZeZT+uYb5zPO3sQVyIKZEEG4hu9506XQOvNWwpb3/3hX6kttGGyoI/Sz
 v8TObWahv5mO/948IVCe2cfVbpQeljvOOssgNV2YDrjLvgcrvTX/EmVdTVhUyy4a6f+K7usLNE3
 d9jrgqbVaBANasUdexs/VTBsctDRXBHuMKCFWq69NS01UI+OXRbuvcT2801CHpLs230FO3M3+3b
 Y1AdzyRIw5+bc4atcMg==
X-Proofpoint-GUID: G2fNRFL5LpRdvcwvmRROd7DqFw_mufku
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af43907 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=0ZKHZBNsmlA_xytF21oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

Add DEFAULT_IMAGE_FEATURE to PSE_SUPPORTED_FEATURES. Only send PHOTO
properties that are BASE64 encoded JPEG images of at most 300x300
pixels and 50 KiB, as required by this feature.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c | 283 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 280 insertions(+), 3 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index dba05b038..b4e6e5eb7 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -63,11 +63,17 @@
 #define DATABASEID_FEATURE	0x00000004
 #define FOLDER_VERSION_FEATURE	0x00000008
 #define VCARD_SELECTING_FEATURE	0x00000010
+#define DEFAULT_IMAGE_FEATURE	0x00000200
+
+#define DEFAULT_IMAGE_MAX_SIZE		(50 * 1024)
+#define DEFAULT_IMAGE_MAX_DIMENSION	300
+/* Number of BASE64 characters encoding DEFAULT_IMAGE_MAX_SIZE bytes */
+#define DEFAULT_IMAGE_MAX_BASE64	((DEFAULT_IMAGE_MAX_SIZE + 2) / 3 * 4)
 
 #define PSE_SUPPORTED_FEATURES \
 	(DOWNLOAD_FEATURE | BROWSE_FEATURE | \
 	DATABASEID_FEATURE | FOLDER_VERSION_FEATURE | \
-	VCARD_SELECTING_FEATURE)
+	VCARD_SELECTING_FEATURE | DEFAULT_IMAGE_FEATURE)
 
 struct cache {
 	gboolean valid;
@@ -263,10 +269,278 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
 
+/* Returns whether a JPEG image is at most 300x300 pixels. */
+static gboolean jpeg_is_default_image(const uint8_t *image, size_t length)
+{
+	size_t offset = 2;
+
+	if (length < 2 || image[0] != 0xff || image[1] != 0xd8)
+		return FALSE;
+
+	while (offset + 4 <= length) {
+		uint16_t segment_length, height, width;
+		uint8_t marker;
+
+		if (image[offset] != 0xff)
+			return FALSE;
+
+		marker = image[offset + 1];
+
+		/* Fill byte */
+		if (marker == 0xff) {
+			offset++;
+			continue;
+		}
+
+		/* Start of scan or end of image before the frame header */
+		if (marker == 0xda || marker == 0xd9)
+			return FALSE;
+
+		segment_length = (image[offset + 2] << 8) | image[offset + 3];
+		if (segment_length < 2 || offset + 2 + segment_length > length)
+			return FALSE;
+
+		/* Start of frame markers, except DHT, JPG and DAC */
+		if (marker >= 0xc0 && marker <= 0xcf && marker != 0xc4 &&
+					marker != 0xc8 && marker != 0xcc) {
+			if (segment_length < 7)
+				return FALSE;
+
+			height = (image[offset + 5] << 8) | image[offset + 6];
+			width = (image[offset + 7] << 8) | image[offset + 8];
+
+			return height && width &&
+				height <= DEFAULT_IMAGE_MAX_DIMENSION &&
+				width <= DEFAULT_IMAGE_MAX_DIMENSION;
+		}
+
+		offset += 2 + segment_length;
+	}
+
+	return FALSE;
+}
+
+/* Returns whether a value is valid BASE64 with correct padding. */
+static gboolean base64_is_valid(const GString *value)
+{
+	gsize padding = 0;
+	gsize i;
+
+	if (!value->len || value->len % 4)
+		return FALSE;
+
+	for (i = 0; i < value->len; i++) {
+		char c = value->str[i];
+
+		if (c == '=') {
+			padding++;
+			continue;
+		}
+
+		/* Padding is only allowed at the end */
+		if (padding)
+			return FALSE;
+
+		if (!g_ascii_isalnum(c) && c != '+' && c != '/')
+			return FALSE;
+	}
+
+	return padding <= 2;
+}
+
+static gboolean photo_is_default_image(const GString *value)
+{
+	guchar *image;
+	gsize length;
+	gboolean valid;
+
+	/* Reject images that are too large without decoding them. */
+	if (value->len > DEFAULT_IMAGE_MAX_BASE64)
+		return FALSE;
+
+	if (!base64_is_valid(value))
+		return FALSE;
+
+	image = g_base64_decode(value->str, &length);
+	valid = length <= DEFAULT_IMAGE_MAX_SIZE &&
+				jpeg_is_default_image(image, length);
+	g_free(image);
+
+	return valid;
+}
+
+/* Returns whether the parameters declare the BASE64 encoding. */
+static gboolean params_are_base64(const char *params, const char *end)
+{
+	const char *p = params;
+
+	while (p < end) {
+		const char *next;
+		size_t len;
+
+		/* Skip the ';' separator */
+		p++;
+
+		next = memchr(p, ';', end - p);
+		if (!next)
+			next = end;
+
+		len = next - p;
+
+		/* Check the value of ENCODING=, or a vCard 2.1 bare value */
+		if (len > 9 && g_ascii_strncasecmp(p, "ENCODING=", 9) == 0) {
+			p += 9;
+			len -= 9;
+
+			/* vCard 3.0 ENCODING=b */
+			if (len == 1 && g_ascii_tolower(*p) == 'b')
+				return TRUE;
+		}
+
+		/* vCard 2.1 ENCODING=BASE64 or BASE64 */
+		if (len == 6 && g_ascii_strncasecmp(p, "BASE64", 6) == 0)
+			return TRUE;
+
+		p = next;
+	}
+
+	return FALSE;
+}
+
+/* Returns whether a line starts a PHOTO property. */
+static gboolean line_is_photo(const char *line, size_t length,
+				size_t *value_offset, gboolean *base64)
+{
+	const char *colon;
+	const char *end;
+	const char *name;
+	const char *p;
+
+	if (!length || line[0] == ' ' || line[0] == '\t')
+		return FALSE;
+
+	colon = memchr(line, ':', length);
+	if (!colon)
+		return FALSE;
+
+	end = memchr(line, ';', colon - line);
+	if (!end)
+		end = colon;
+
+	/* Skip the group prefix */
+	for (name = p = line; p < end; p++) {
+		if (*p == '.')
+			name = p + 1;
+	}
+
+	if (end - name != 5 || g_ascii_strncasecmp(name, "PHOTO", 5) != 0)
+		return FALSE;
+
+	*value_offset = colon - line + 1;
+	*base64 = params_are_base64(end, colon);
+
+	return TRUE;
+}
+
+/* Appends a part of a PHOTO value without any space or tab. */
+static void append_value(GString *value, const char *part, size_t length)
+{
+	size_t i;
+
+	for (i = 0; i < length; i++) {
+		/* Larger values are rejected without being kept. */
+		if (value->len > DEFAULT_IMAGE_MAX_BASE64)
+			return;
+
+		if (part[i] != ' ' && part[i] != '\t')
+			g_string_append_c(value, part[i]);
+	}
+}
+
+static void append_photo(GString *result, const char *start, const char *end,
+						GString *value, gboolean base64)
+{
+	if (base64 && photo_is_default_image(value))
+		g_string_append_len(result, start, end - start);
+
+	g_string_truncate(value, 0);
+}
+
+/*
+ * Drops PHOTO properties that are not BASE64 encoded JPEG images of at
+ * most 300x300 pixels and 50 KiB, as required by the Contact Image
+ * Default Format.
+ */
+static char *filter_default_images(const char *buffer, size_t length,
+						size_t *filtered_length)
+{
+	const char *photo = NULL;
+	const char *line;
+	const char *end;
+	gboolean base64 = FALSE;
+	GString *result;
+	GString *value;
+
+	if (!buffer || !length) {
+		*filtered_length = 0;
+		return g_strdup("");
+	}
+
+	end = buffer + length;
+	result = g_string_sized_new(length);
+	value = g_string_new(NULL);
+
+	for (line = buffer; line < end;) {
+		const char *next = memchr(line, '\n', end - line);
+		size_t len, offset;
+
+		next = next ? next + 1 : end;
+		len = next - line;
+
+		while (len && (line[len - 1] == '\n' || line[len - 1] == '\r'))
+			len--;
+
+		if (photo) {
+			/*
+			 * Folded lines, and the unfolded BASE64 lines and the
+			 * terminating blank line of vCard 2.1, belong to the
+			 * PHOTO value.
+			 */
+			if (!len || line[0] == ' ' || line[0] == '\t' ||
+						!memchr(line, ':', len)) {
+				append_value(value, line, len);
+				line = next;
+				continue;
+			}
+
+			append_photo(result, photo, line, value, base64);
+			photo = NULL;
+		}
+
+		if (line_is_photo(line, len, &offset, &base64)) {
+			photo = line;
+			append_value(value, line + offset, len - offset);
+		} else
+			g_string_append_len(result, line, next - line);
+
+		line = next;
+	}
+
+	if (photo)
+		append_photo(result, photo, end, value, base64);
+
+	g_string_free(value, TRUE);
+
+	*filtered_length = result->len;
+	return g_string_free(result, FALSE);
+}
+
 /* Returns -1 on error, otherwise whether this is the first packet. */
 static int vobject_append(struct pbap_session *pbap, const char *buffer,
 			size_t bufsize, int vcards, gboolean lastpart)
 {
+	char *filtered;
+	size_t filtered_length;
 	gboolean first;
 
 	if (pbap->obj->request && lastpart) {
@@ -282,12 +556,15 @@ static int vobject_append(struct pbap_session *pbap, const char *buffer,
 	}
 
 	first = !pbap->obj->buffer;
+	filtered = filter_default_images(buffer, bufsize, &filtered_length);
 
 	if (first)
-		pbap->obj->buffer = g_string_new_len(buffer, bufsize);
+		pbap->obj->buffer = g_string_new_len(filtered, filtered_length);
 	else
 		pbap->obj->buffer = g_string_append_len(pbap->obj->buffer,
-							buffer,	bufsize);
+						filtered, filtered_length);
+
+	g_free(filtered);
 
 	return first;
 }
-- 
2.34.1


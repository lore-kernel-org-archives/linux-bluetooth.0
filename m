Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820020;
	b=WqTM9WdFEHa7g+KQUsiDtOyv5ymo3frbVGYk/QJLR+weXSZjKPhER6yfvnDgzvKBbNL1
	 HgSStSMolHG8MyVhj00kpllBLwJgpV7WHxXp3MPlw0Plb3XPyFEEtHWkbENWHQiXv+ZTw
	 Gs76wvafusH4KCRM2UC3m2c4Zh5MBiuZgPKqZT7PcFmgkr2+faV942gW0G6dmTx8UkGyE
	 V1w0alZsLVfJws/X58zOBQC4g/omMDhDsrmi7BQhUMhmQuCuO7142OacUXIAn438ooE0m
	 O+4kV19aOswHwwnn44lba9CqvG/rHRkWbNCP9aFTcCAZFoQviNTj9R8WpHYRUcalsRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820020;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Cyf5qtZBalDvhokomKHn5w58Pwv1494o5QBWPqGN9NA=;
	b=n4sDp8xE7QugMQpeAC06pJT8GTT0gvxdD1X5g/MLZUAP/PHyeI/27+3Cz10Q9eWWsvQ+
	 D8DE8kFg/RdEfpnw6Anku8UCtPhpaTZauiHRROic7dSHJfWKLEwx/z2GSjJw4fgbu7yRQ
	 CKcefXgPDGTRNG/XLU/7fAdAvHWuMYScUvIPjILpD1jdemVZIA89a8BaoKypD+ZjA8RGk
	 qduNL0/wzMV3xQq9WKK9gxmsXxmP5W9u5yLBO+9Cc2pm15IN4HsGY2jGwKzVKk1qDxaX4
	 ChPUxv+zezMgpIfrGVdx2dyZK5vvNUAX2wIqYrd+y30uqVwquhpIXH0yTq2kM4TIv8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JIsIWUF8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493C606A893
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0493C606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JIsIWUF8
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7f0Vc424029;
	Mon, 16 Nov 2026 09:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Cyf5qtZBalD
	vhokomKHn5w58Pwv1494o5QBWPqGN9NA=; b=JIsIWUF8/iKs43M4wb70AtM67Hj
	iORnx8ieWjvGn9kDwBRS2kNLLk2P0C34HbcXd73xw5dEpt819XrayG7LhCNtuQ3o
	YX4237kPMeG6nVabJ7eiqRGLc3vBQ2AUXiSIxvyianMhRlxdp9mbr0K08k78r3Jg
	Oav3ni9ZknfxnpjDlYj8JSlzDqRj2VwPyk9W/ZNh6crKo1CScVHVO1BbF13AJ550
	mgjPiSQNWEtCXX1q2gQK5XeT5CKDbYZryjYEFpf+q3l1W0SCRijntRnxj53e3W1g
	a9/VAinMeNsTY5eFhMNKNBWKqxRuck5oKtOikyLrQOH3d88nsXKySY4o19w==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhkwdn50-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:58 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96t0L2942797;
	Mon, 16 Nov 2026 09:06:57 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AG96u5O2942841
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:56 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id CE6EE27A0E; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 19/20] obexd/pbap: Support Contact Image Default Format
Date: Mon, 16 Nov 2026 17:06:33 +0800
Message-Id: <20261116090634.1222593-20-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX5GFKhhJb5F1q
 6QtLEahRwnJRy48T7xn7kaBk+nHiIjQZafI/gPmfld5GQHs2JlAJKo5LEmyRlTRBlAE+fpMDn1o
 Yd1pEMtCQoQUpVxyDdBLNPJKDpJ2ubLgn2Hk41UcWyUgqSz7+2Cei0/GFC15Ds/8pwa/KflzsDF
 bJlVcu6N6whcCnBORUzkk0rh0pnPPDoxb2D8irNnsARWdheX6Q1YrrEd83G8jzqJaDlVnD9dy7o
 upgtMWYq5WCw8HwIB9fxGLMafa7TIJKK025PItDa5ZArsu5WpfC4YE9zKNF26HYwRMgu1yYcygT
 5kpZo6chPHCniSOWsHjz/MWmG1hfR2WAfcun8RA3TyjHr/nJt6Xf7OYbX5urIdvWbFdRVY94dVR
 DNBWsDmxgl4fUl16Ri+KRjcMRIR/cumA4A64LvZCq302VA8DaV9GmsWbbL4erSVHsaIFcnJRPJL
 K4ZCey7J6Z1HjwHkOBQ==
X-Authority-Analysis: v=2.4 cv=YPYKWhGx c=1 sm=1 tr=0 ts=6afac7b2 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=7-93DQ5bhRzzH-jloqoA:9
X-Proofpoint-GUID: sxdf63Y0W7QPCVDWh6NTGJ495KNheggQ
X-Proofpoint-ORIG-GUID: sxdf63Y0W7QPCVDWh6NTGJ495KNheggQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX5dgyXhkoIJod
 3+SHae+AuJTKPqz37kTDjRm66GlzGTA6NB+vVk48bshcrKRl5i9u2ZBrKcEc0wwae1hQQpKfWJO
 ryVCzSjgw1ZociP7AvzaRHHN3/YCMuU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

Add DEFAULT_IMAGE_FEATURE to PSE_SUPPORTED_FEATURES. Ensure returned
PHOTO properties are BASE64-encoded JPEG images no larger than 300x300
pixels and 50 KiB, as required by the PBAP contact image format.

Ignore colons and semicolons inside quoted parameter values when parsing
property headers so they do not change the detected encoding or cause
valid JPEG images to be dropped.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c | 496 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 493 insertions(+), 3 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index dba05b038..867f1004a 100644
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
@@ -263,10 +269,491 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
 
+static gboolean jpeg_has_start_of_image(const uint8_t *image, size_t length)
+{
+	return length >= 2 && image[0] == 0xff && image[1] == 0xd8;
+}
+
+static gboolean jpeg_marker_is_frame(uint8_t marker)
+{
+	const uint16_t excluded = (1 << 4) | (1 << 8) | (1 << 12);
+
+	if (marker < 0xc0 || marker > 0xcf)
+		return FALSE;
+
+	return !(excluded & (1 << (marker - 0xc0)));
+}
+
+static gboolean jpeg_segment_is_valid(size_t offset, uint16_t segment_length,
+							size_t length)
+{
+	if (segment_length < 2)
+		return FALSE;
+
+	return segment_length <= length - offset - 2;
+}
+
+static gboolean jpeg_dimensions_are_default(uint16_t height, uint16_t width)
+{
+	return height && width && height <= DEFAULT_IMAGE_MAX_DIMENSION &&
+				width <= DEFAULT_IMAGE_MAX_DIMENSION;
+}
+
+/* Returns whether a JPEG image is at most 300x300 pixels. */
+static gboolean jpeg_is_default_image(const uint8_t *image, size_t length)
+{
+	size_t offset = 2;
+
+	if (!jpeg_has_start_of_image(image, length))
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
+		if (!jpeg_segment_is_valid(offset, segment_length, length))
+			return FALSE;
+
+		/* Start of frame markers, except DHT, JPG and DAC */
+		if (jpeg_marker_is_frame(marker)) {
+			if (segment_length < 7)
+				return FALSE;
+
+			height = (image[offset + 5] << 8) | image[offset + 6];
+			width = (image[offset + 7] << 8) | image[offset + 8];
+
+			return jpeg_dimensions_are_default(height, width);
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
+enum vcard_encoding {
+	VCARD_ENCODING_NONE,
+	VCARD_ENCODING_BASE64,
+	VCARD_ENCODING_QUOTED_PRINTABLE,
+};
+
+struct default_image_filter {
+	const char *photo;
+	enum vcard_encoding encoding;
+	gboolean qp_continuation;
+	GString *header;
+	GString *result;
+	GString *value;
+};
+
+static const char *vcard_find_separator(const char *line, size_t length,
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
+static enum vcard_encoding params_get_encoding(const char *params,
+							const char *end)
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
+		next = vcard_find_separator(p, end - p, ';');
+		if (!next)
+			next = end;
+
+		len = next - p;
+
+		/* Check the value of ENCODING=, or a vCard 2.1 bare value. */
+		if (len > 9 && g_ascii_strncasecmp(p, "ENCODING=", 9) == 0) {
+			p += 9;
+			len -= 9;
+
+			/* vCard 3.0 ENCODING=b */
+			if (len == 1 && g_ascii_tolower(*p) == 'b')
+				return VCARD_ENCODING_BASE64;
+		}
+
+		/* vCard 2.1 ENCODING=BASE64 or BASE64 */
+		if (len == 6 && g_ascii_strncasecmp(p, "BASE64", 6) == 0)
+			return VCARD_ENCODING_BASE64;
+
+		if (len == 16 && g_ascii_strncasecmp(p, "QUOTED-PRINTABLE",
+								16) == 0)
+			return VCARD_ENCODING_QUOTED_PRINTABLE;
+
+		p = next;
+	}
+
+	return VCARD_ENCODING_NONE;
+}
+
+static enum vcard_encoding line_get_encoding(const char *line, size_t length)
+{
+	const char *colon;
+	const char *params;
+
+	colon = vcard_find_separator(line, length, ':');
+	if (!colon)
+		return VCARD_ENCODING_NONE;
+
+	params = memchr(line, ';', colon - line);
+	if (!params)
+		return VCARD_ENCODING_NONE;
+
+	return params_get_encoding(params, colon);
+}
+
+/* Appends a possibly folded property header and returns its raw end. */
+static const char *append_header(GString *header, const char *line,
+							const char *end)
+{
+	gboolean folded = FALSE;
+
+	while (line < end) {
+		const char *next = memchr(line, '\n', end - line);
+		size_t len, offset = 0;
+
+		next = next ? next + 1 : end;
+		len = next - line;
+
+		while (len && (line[len - 1] == '\n' || line[len - 1] == '\r'))
+			len--;
+
+		if (folded && len && (line[0] == ' ' || line[0] == '\t'))
+			offset = 1;
+
+		g_string_append_len(header, line + offset, len - offset);
+
+		if (vcard_find_separator(header->str, header->len, ':'))
+			return next;
+
+		if (next == end || (next[0] != ' ' && next[0] != '\t'))
+			return next;
+
+		line = next;
+		folded = TRUE;
+	}
+
+	return end;
+}
+
+static gboolean line_has_soft_break(const char *line, size_t length)
+{
+	return length && line[length - 1] == '=';
+}
+
+/* Returns whether a line starts a PHOTO property. */
+static gboolean line_is_photo(const char *line, size_t length,
+						size_t *value_offset)
+{
+	const char *colon;
+	const char *end;
+	const char *name;
+	const char *p;
+
+	if (!length || line[0] == ' ' || line[0] == '\t')
+		return FALSE;
+
+	colon = vcard_find_separator(line, length, ':');
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
+				GString *value, enum vcard_encoding encoding)
+{
+	if (encoding == VCARD_ENCODING_BASE64 &&
+						photo_is_default_image(value))
+		g_string_append_len(result, start, end - start);
+
+	g_string_truncate(value, 0);
+}
+
+static const char *vcard_line_end(const char *line, const char *end,
+							size_t *length)
+{
+	const char *next = memchr(line, '\n', end - line);
+
+	next = next ? next + 1 : end;
+	*length = next - line;
+
+	while (*length && (line[*length - 1] == '\n' ||
+						line[*length - 1] == '\r'))
+		(*length)--;
+
+	return next;
+}
+
+static void default_image_finish_photo(struct default_image_filter *filter,
+							const char *end)
+{
+	append_photo(filter->result, filter->photo, end, filter->value,
+						filter->encoding);
+	filter->photo = NULL;
+	filter->encoding = VCARD_ENCODING_NONE;
+	filter->qp_continuation = FALSE;
+}
+
+static gboolean default_image_photo_continuation(
+					struct default_image_filter *filter,
+					const char *line, size_t length)
+{
+	if (!filter->photo)
+		return FALSE;
+
+	/*
+	 * Folded lines, and the unfolded BASE64 lines and the terminating
+	 * blank line of vCard 2.1, belong to the PHOTO value.
+	 */
+	if (!filter->qp_continuation && length && line[0] != ' ' &&
+			line[0] != '\t' && memchr(line, ':', length)) {
+		default_image_finish_photo(filter, line);
+		return FALSE;
+	}
+
+	append_value(filter->value, line, length);
+	filter->qp_continuation =
+		filter->encoding == VCARD_ENCODING_QUOTED_PRINTABLE &&
+					line_has_soft_break(line, length);
+
+	return TRUE;
+}
+
+static gboolean default_image_property_continuation(
+					struct default_image_filter *filter,
+					const char *line, const char *next,
+							size_t length)
+{
+	if (filter->qp_continuation) {
+		g_string_append_len(filter->result, line, next - line);
+		filter->qp_continuation = line_has_soft_break(line, length);
+		return TRUE;
+	}
+
+	if (line[0] != ' ' && line[0] != '\t')
+		return FALSE;
+
+	g_string_append_len(filter->result, line, next - line);
+	filter->qp_continuation =
+		filter->encoding == VCARD_ENCODING_QUOTED_PRINTABLE &&
+					line_has_soft_break(line, length);
+
+	return TRUE;
+}
+
+static const char *default_image_property_start(
+					struct default_image_filter *filter,
+					const char *line, const char *end)
+{
+	const char *next;
+	size_t offset;
+
+	g_string_truncate(filter->header, 0);
+	next = append_header(filter->header, line, end);
+	filter->encoding = line_get_encoding(filter->header->str,
+						filter->header->len);
+
+	if (line_is_photo(filter->header->str, filter->header->len,
+							&offset)) {
+		filter->photo = line;
+		append_value(filter->value, filter->header->str + offset,
+					filter->header->len - offset);
+	} else
+		g_string_append_len(filter->result, line, next - line);
+
+	filter->qp_continuation =
+		filter->encoding == VCARD_ENCODING_QUOTED_PRINTABLE &&
+		line_has_soft_break(filter->header->str, filter->header->len);
+
+	return next;
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
+	struct default_image_filter filter;
+	const char *line;
+	const char *end;
+
+	if (!buffer || !length) {
+		*filtered_length = 0;
+		return g_strdup("");
+	}
+
+	end = buffer + length;
+	filter.photo = NULL;
+	filter.encoding = VCARD_ENCODING_NONE;
+	filter.qp_continuation = FALSE;
+	filter.header = g_string_new(NULL);
+	filter.result = g_string_sized_new(length);
+	filter.value = g_string_new(NULL);
+
+	for (line = buffer; line < end;) {
+		const char *next;
+		size_t line_length;
+
+		next = vcard_line_end(line, end, &line_length);
+
+		if (default_image_photo_continuation(&filter, line,
+							line_length) ||
+			default_image_property_continuation(&filter, line, next,
+							line_length)) {
+			line = next;
+			continue;
+		}
+
+		line = default_image_property_start(&filter, line, end);
+	}
+
+	if (filter.photo)
+		default_image_finish_photo(&filter, end);
+
+	g_string_free(filter.header, TRUE);
+	g_string_free(filter.value, TRUE);
+
+	*filtered_length = filter.result->len;
+	return g_string_free(filter.result, FALSE);
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
@@ -282,12 +769,15 @@ static int vobject_append(struct pbap_session *pbap, const char *buffer,
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


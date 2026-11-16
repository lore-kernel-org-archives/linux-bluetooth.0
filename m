Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820021;
	b=TBcJMIYGyUEba/ZBvES0OqWBGt8pSRFL24efgVuSccQ+5yP94Efqn1P37bS34kyqKZD/
	 xCvEWAKgXGN1Mci5p+Kd4O9m+izDeJlZu8uM8+CwMM5vUPyT9AsakJLSM4JX/kgms4l5D
	 1153tU1rvOtTlmE5E+WwE28u0y0w1td5B+XW0c6Yx3O6S6tkxd4wxbyMZM45ecQJdbIxQ
	 zBJSeQwCpLppqtZoLvpF99QG0U3qZv+ImDTj25gipiFiZc5dIqmGSa5gtW73vrAOdidoE
	 ReLQxUhYEnmx64nbJNuhglvjGaZe17Mxo9tb10xk5RZ5DTypEE5JXaHUkR5AEdFI+fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820021;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9Zy2fOW0PWk/NsOwqJ4cDEv0pzAFqUabfxTKwtW4KiI=;
	b=3xTC/AAr+Evsr5ncBCH0zOVTfy4cAV7smJCCamqeE0rPl2NHCuUCe4g15no9HfO5OBql
	 GXic/hWq/Qyh12876Cq3T/WjD5CGbRAn+cUcUpDl9Q+kTJP0rREm92OjTy7cfysI/eFMk
	 kcPHMq3y4RyjfArccZjIMcnemMmfwznOlQBne/H4qYWbOKQGfqXXPRaKuo6+hgCV1zA4P
	 9i/jw+8K9SYbUHei+EsWnV6w2L1vUdONqcNTN7fBtn0jYIoO3AcTTlDzQ/l6vjytx1VU4
	 NafuTBwtFLfCcX5psuzUfzIDLsA3sCPz6oyD1L/AcXZglI8cgiuNp+pw7f/LmsDMM7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YrOsfeIe;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9609606A883
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9609606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YrOsfeIe
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7sXB0664335;
	Mon, 16 Nov 2026 09:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9Zy2fOW0PWk
	/NsOwqJ4cDEv0pzAFqUabfxTKwtW4KiI=; b=YrOsfeIe8oBhP8D8M+Gk/kCpYqX
	oLLj0ZUPG4/WUQxRF4XDfMc2IyuckGPd9jSL+/RgXiWLIEBzpGwHVy84o91TXoN7
	9DP3Sz37+KqhZALPHrAl9ulFN/ykUFmOAZmNmUDRCSijszn3V31ecRMg1bjzCCoH
	9ebmeultdLCaNeEO+fybhQ1Cs/wnO55l1wEANXU46Ku7agKvpKwhQPQuxwJ/QVbE
	RTHYaVHV38KvtiDRf2WtPmE5jJN0CyEZ/5uUpqJT7Yw81JBRqUeTOwOQBPwTvu7t
	ZGY1LF6fORebSydnYYV/fFF8pPQUgzbWop9xy6DZjFvthfitKfnYF8xFS5g==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhnx5sxh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:59 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96swe2942824;
	Mon, 16 Nov 2026 09:06:57 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AG96uc02942915
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:56 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id C0D0327A0B; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 16/20] obexd/pbap: Add folder version counters
Date: Mon, 16 Nov 2026 17:06:30 +0800
Message-Id: <20261116090634.1222593-17-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfXwtbrgLjboh3r
 FJZAD+GXJPHRSbyxxzIZTw3xq4Ql4YT4nKtRgJG6NBrmwpvcasf2/yEaJB68sDsyqmGKmrBpIH+
 Y9+SAP8yuPLXjyfsdlYImEKlIqJk4FJtPYgi2sWqU6C8kCXBbCiqkFe9VwCUMJjjLWMlFcWC+5B
 CSgX0w9/nvBMmKT0dhXc9T5gf1WmKTS/IEg2BahPqtp9cZXY5n+7j6DqEKDEOD4jzlhuWeYaC+H
 Kj5+mXvHm7co1ZT4oDub/SVCH6XLanX2WadqtjgHyO4RvGIFlEkr5ntJ25Yl5Bx260IypJ7RjVT
 ffDCs/cBzhjzzuPZ2PnGinxJ4h8MnQw4SpbarsFx5ctkzgcSUNtjQWZnX62Pfh8MgDlcNnPhdq/
 B5PewRj4BcM0nGVyzWiDdhLRRqeqy3WEavxdd5Jb3b7uHPZDbathbt0cXR9hC1j+JYeWCEMK8pP
 0ZXXh+TKizmbLN89oeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX5NcTfVi0OG0k
 KxwwrPfWedQxP3IiV70dK5KCTAgLvs539ckffUhgCXoxse3LIxJyV4iFvMH0F2W/wTn7X/ZSgK2
 YzVj92OFDW42kNxRXUopI6R47y9elFw=
X-Proofpoint-ORIG-GUID: RzmmOaK1SDVY60ij_bdsXbotAfx2m305
X-Proofpoint-GUID: RzmmOaK1SDVY60ij_bdsXbotAfx2m305
X-Authority-Analysis: v=2.4 cv=Jr5kP84C c=1 sm=1 tr=0 ts=6afac7b3 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=zhhO3U2w9_FMqUMKV64A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

Add primary and secondary folder version counters to the dummy backend.
The counters are incremented when the content of a folder changes, and a
new Database Identifier is generated when they restart. The ebook and
tracker backends keep no counters and report a zero Database Identifier.

Discard incomplete folder scans so read or parsing failures do not
update the persisted digests and counters.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c               |   2 +-
 obexd/plugins/phonebook-dummy.c    | 302 ++++++++++++++++++++++++++++-
 obexd/plugins/phonebook-metadata.c |  56 +++++-
 obexd/plugins/phonebook-metadata.h |  11 +-
 obexd/plugins/phonebook.c          |   5 +-
 obexd/plugins/phonebook.h          |   5 +-
 6 files changed, 365 insertions(+), 16 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index f271547a3..1ba5f0b63 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -180,7 +180,7 @@ static void response_add_metadata(struct pbap_session *pbap)
 
 	memset(&metadata, 0, sizeof(metadata));
 
-	if (!phonebook_get_metadata(&metadata))
+	if (!phonebook_get_metadata(pbap->obj->folder, &metadata))
 		DBG("Metadata unavailable");
 
 	pbap->obj->apparam = g_obex_apparam_set_bytes(pbap->obj->apparam,
diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 67ac70cec..4efa56809 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -53,6 +53,13 @@ struct cache_query {
 	uint8_t newmissedcalls;
 };
 
+struct digest_data {
+	GChecksum *primary;
+	GChecksum *secondary;
+	char *path;
+	gboolean failed;
+};
+
 static char *root_folder = NULL;
 
 static void dummy_free(void *user_data)
@@ -76,9 +83,54 @@ static void query_free(void *user_data)
 	g_free(query);
 }
 
+static gboolean phonebook_compute_folder_digest(const char *folder,
+						uint8_t primary_digest[16],
+						uint8_t secondary_digest[16]);
+
+static const char * const version_folders[] = {
+	PB_CONTACTS_FOLDER,
+	PB_CALLS_COMBINED_FOLDER,
+	PB_CALLS_INCOMING_FOLDER,
+	PB_CALLS_MISSED_FOLDER,
+	PB_CALLS_OUTGOING_FOLDER,
+	PB_CALLS_SPEEDDIAL_FOLDER,
+	PB_CALLS_FAVORITE_FOLDER,
+	NULL,
+};
+
+static gboolean folder_has_version(const char *folder)
+{
+	unsigned int i;
+
+	for (i = 0; version_folders[i]; i++) {
+		if (g_str_equal(folder, version_folders[i]))
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
 static void dummy_metadata_init(void)
 {
+	static const uint8_t zeros[16] = {0};
+	uint8_t primary[16], secondary[16];
+	int i;
+
 	metadata_identifier_update();
+
+	for (i = 0; version_folders[i]; i++) {
+		const char *folder = version_folders[i];
+
+		if (phonebook_compute_folder_digest(folder, primary,
+					secondary)) {
+			metadata_set(folder, "primary_digest", primary);
+			metadata_set(folder, "secondary_digest", secondary);
+		}
+
+		metadata_set(folder, PRIMARY_COUNTER, zeros);
+		metadata_set(folder, SECONDARY_COUNTER, zeros);
+	}
+
 	metadata_save();
 }
 
@@ -130,6 +182,22 @@ static int handle_cmp(gconstpointer a, gconstpointer b)
 	return (i1 - i2);
 }
 
+static struct dirent *read_dir_entry(DIR *dp, int *err)
+{
+	struct dirent *entry;
+
+	errno = 0;
+	entry = readdir(dp);
+	if (!entry && errno)
+		*err = -errno;
+
+	return entry;
+}
+
+/*
+ * Keep processing valid vCards, but report errors so digest callers can
+ * reject incomplete scans.
+ */
 static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 			uint16_t maxlistcount, void *user_data, uint16_t *count)
 {
@@ -137,7 +205,7 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 	GSList *sorted = NULL, *l;
 	VObject *v;
 	FILE *fp;
-	int err, fd, folderfd;
+	int err, fd, folderfd, ret = 0;
 	uint16_t n = 0;
 
 	folderfd = dirfd(dp);
@@ -153,20 +221,19 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 	 * vcards handle only(handle is always a number). This sort function
 	 * doesn't address filename started by "0".
 	 */
-	while ((ep = readdir(dp))) {
+	while ((ep = read_dir_entry(dp, &ret))) {
 		char *filename;
 
 		if (ep->d_name[0] == '.')
 			continue;
 
+		if (!g_str_has_suffix(ep->d_name, ".vcf"))
+			continue;
+
 		filename = g_filename_to_utf8(ep->d_name, -1, NULL, NULL, NULL);
 		if (filename == NULL) {
 			error("g_filename_to_utf8: invalid filename");
-			continue;
-		}
-
-		if (!g_str_has_suffix(filename, ".vcf")) {
-			g_free(filename);
+			ret = -EILSEQ;
 			continue;
 		}
 
@@ -185,6 +252,7 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 		if (fd < 0) {
 			err = errno;
 			error("openat(%s): %s(%d)", filename, strerror(err), err);
+			ret = -err;
 			continue;
 		}
 
@@ -194,6 +262,7 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 			error("fdopen(%s): %s(%d)", filename, strerror(err),
 									err);
 			close(fd);
+			ret = -err;
 			continue;
 		}
 
@@ -204,9 +273,15 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 
 			deleteVObject(v);
 			n++;
+		} else {
+			ret = -EINVAL;
 		}
 
-		fclose(fp);
+		if (ferror(fp))
+			ret = -EIO;
+
+		if (fclose(fp) == EOF)
+			ret = -errno;
 	}
 
 	g_slist_free_full(sorted, g_free);
@@ -214,7 +289,207 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 	if (count)
 		*count = n;
 
-	return 0;
+	return ret;
+}
+
+static char *vobject_get_string(VObject *prop)
+{
+	switch (vObjectValueType(prop)) {
+	case VCVT_STRINGZ:
+		return g_strdup(vObjectStringZValue(prop));
+	case VCVT_USTRINGZ:
+		return fakeCString(vObjectUStringZValue(prop));
+	default:
+		return NULL;
+	}
+}
+
+static void digest_entry(const char *filename, VObject *v, void *user_data)
+{
+	struct digest_data *data = user_data;
+	VObjectIterator iterator, sub_iterator;
+	VObject *prop, *subprop;
+	char *entry;
+	char *contents;
+	char *str;
+	gsize len;
+
+	/* The primary digest covers the file name and the whole contents. */
+	g_checksum_update(data->primary, (const guchar *) filename,
+							strlen(filename));
+	g_checksum_update(data->primary, (const guchar *) "\0", 1);
+
+	entry = g_build_filename(data->path, filename, NULL);
+
+	if (!g_file_get_contents(entry, &contents, &len, NULL)) {
+		data->failed = TRUE;
+		g_free(entry);
+		return;
+	}
+
+	g_checksum_update(data->primary, (const guchar *) contents, len);
+	g_free(contents);
+	g_free(entry);
+
+	g_checksum_update(data->primary, (const guchar *) "\0", 1);
+
+	/*
+	 * The secondary digest covers the file name and the properties
+	 * tracked by the secondary counter.
+	 */
+	g_checksum_update(data->secondary, (const guchar *) filename,
+							strlen(filename));
+	g_checksum_update(data->secondary, (const guchar *) "\0", 1);
+
+	initPropIterator(&iterator, v);
+
+	while (moreIteration(&iterator)) {
+		prop = nextVObject(&iterator);
+
+		if (g_ascii_strcasecmp(vObjectName(prop), VCNameProp) &&
+				g_ascii_strcasecmp(vObjectName(prop),
+							VCFullNameProp) &&
+				g_ascii_strcasecmp(vObjectName(prop),
+							VCTelephoneProp) &&
+				g_ascii_strcasecmp(vObjectName(prop),
+							VCEmailAddressProp) &&
+				g_ascii_strcasecmp(vObjectName(prop),
+							VCMailerProp) &&
+				g_ascii_strcasecmp(vObjectName(prop),
+							VCAdrProp) &&
+				g_ascii_strcasecmp(vObjectName(prop),
+							"X-BT-UCI"))
+			continue;
+
+		g_checksum_update(data->secondary,
+					(const guchar *) vObjectName(prop),
+					strlen(vObjectName(prop)));
+		g_checksum_update(data->secondary, (const guchar *) "\0", 1);
+
+		str = vobject_get_string(prop);
+		if (str) {
+			g_checksum_update(data->secondary,
+					(const guchar *) str, strlen(str));
+			g_free(str);
+			g_checksum_update(data->secondary,
+					(const guchar *) "\0", 1);
+		}
+
+		/* Property components and parameters are included. */
+		initPropIterator(&sub_iterator, prop);
+
+		while (moreIteration(&sub_iterator)) {
+			subprop = nextVObject(&sub_iterator);
+
+			g_checksum_update(data->secondary,
+					(const guchar *) vObjectName(subprop),
+					strlen(vObjectName(subprop)));
+			g_checksum_update(data->secondary,
+					(const guchar *) "\0", 1);
+
+			str = vobject_get_string(subprop);
+			if (str) {
+				g_checksum_update(data->secondary,
+						(const guchar *) str,
+						strlen(str));
+				g_free(str);
+				g_checksum_update(data->secondary,
+						(const guchar *) "\0", 1);
+			}
+		}
+	}
+}
+
+/* Computes the digests used to detect changes of a folder's contents. */
+static gboolean phonebook_compute_folder_digest(const char *folder,
+						uint8_t primary_digest[16],
+						uint8_t secondary_digest[16])
+{
+	struct digest_data digest;
+	DIR *dp;
+	char *path;
+	int err;
+	gboolean valid = FALSE;
+	gsize len = g_checksum_type_get_length(G_CHECKSUM_MD5);
+
+	path = g_build_filename(root_folder, folder, NULL);
+
+	dp = opendir(path);
+	if (!dp) {
+		g_free(path);
+		return FALSE;
+	}
+
+	digest.primary = g_checksum_new(G_CHECKSUM_MD5);
+	digest.secondary = g_checksum_new(G_CHECKSUM_MD5);
+	digest.path = path;
+	digest.failed = FALSE;
+
+	/* Entries beyond 65535 are not covered by the digest */
+	err = foreach_vcard(dp, digest_entry, 0, 0xffff, &digest, NULL);
+
+	if (closedir(dp) < 0)
+		err = -errno;
+
+	g_free(path);
+
+	if (err < 0 || digest.failed)
+		goto done;
+
+	g_checksum_get_digest(digest.primary, primary_digest, &len);
+	g_checksum_get_digest(digest.secondary, secondary_digest, &len);
+	valid = TRUE;
+
+done:
+	g_checksum_free(digest.primary);
+	g_checksum_free(digest.secondary);
+
+	return valid;
+}
+
+static void dummy_update_folder_version(const char *folder)
+{
+	uint8_t primary[16], secondary[16];
+	uint8_t stored_primary[16], stored_secondary[16];
+	uint8_t counter[16];
+	gboolean primary_changed, secondary_changed;
+
+	/* Retries a previously failed save. */
+	metadata_save();
+
+	if (!folder_has_version(folder))
+		return;
+
+	if (!phonebook_compute_folder_digest(folder, primary, secondary))
+		return;
+
+	/* Missing counters restart with a new Database Identifier. */
+	if (!metadata_get(folder, PRIMARY_COUNTER, counter) ||
+			!metadata_get(folder, SECONDARY_COUNTER, counter)) {
+		dummy_metadata_init();
+		return;
+	}
+
+	/* A missing or unreadable digest counts as a change. */
+	primary_changed = !metadata_get(folder, "primary_digest",
+					stored_primary) ||
+			memcmp(primary, stored_primary, 16) != 0;
+	secondary_changed = !metadata_get(folder, "secondary_digest",
+					stored_secondary) ||
+			memcmp(secondary, stored_secondary, 16) != 0;
+
+	if (!primary_changed && !secondary_changed)
+		return;
+
+	if (!metadata_folder_version_counter_incr(folder, primary_changed,
+							secondary_changed)) {
+		dummy_metadata_init();
+		return;
+	}
+
+	metadata_set(folder, "primary_digest", primary);
+	metadata_set(folder, "secondary_digest", secondary);
+	metadata_save();
 }
 
 struct concat_data {
@@ -469,6 +744,7 @@ static gboolean read_dir(void *user_data)
 	dp = opendir(dummy->folder);
 	if (dp == NULL) {
 		int err = errno;
+
 		DBG("opendir(): %s(%d)", strerror(err), err);
 		goto done;
 	}
@@ -490,6 +766,7 @@ static gboolean read_dir(void *user_data)
 	foreach_vcard(dp, entry_concat, offset, max, &data, &count);
 
 	closedir(dp);
+
 done:
 	/* FIXME: Missing vCards fields filtering */
 	dummy->cb(data.buffer->str, data.buffer->len, count,
@@ -742,6 +1019,11 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 		return NULL;
 	}
 
+	folder = g_strndup(name, strlen(name) - 4);
+
+	dummy_update_folder_version(folder);
+	g_free(folder);
+
 	folder = g_strndup(filename, strlen(filename) - 4);
 	g_free(filename);
 	if (!is_dir(folder)) {
@@ -824,6 +1106,8 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	DIR *dp;
 	struct dummy_data *dummy;
 
+	dummy_update_folder_version(name);
+
 	foldername = g_build_filename(root_folder, name, NULL);
 	dp = opendir(foldername);
 	g_free(foldername);
diff --git a/obexd/plugins/phonebook-metadata.c b/obexd/plugins/phonebook-metadata.c
index 06cfa2a8a..005ed3b9e 100644
--- a/obexd/plugins/phonebook-metadata.c
+++ b/obexd/plugins/phonebook-metadata.c
@@ -163,7 +163,7 @@ gboolean metadata_file_open(const char *file)
 	return TRUE;
 }
 
-gboolean metadata_read(struct phonebook_metadata *metadata)
+gboolean metadata_read(const char *folder, struct phonebook_metadata *metadata)
 {
 	memset(metadata, 0, sizeof(*metadata));
 
@@ -192,3 +192,57 @@ void metadata_file_close(void)
 		metadata_file = NULL;
 	}
 }
+
+/* Increments a 128-bit big-endian counter. Returns FALSE on rollover. */
+static gboolean counter_incr(uint8_t counter[16])
+{
+	int i;
+
+	for (i = 15; i >= 0; i--) {
+		counter[i]++;
+
+		if (counter[i])
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
+/*
+ * Increments the primary and secondary folder version counters.
+ * Returns FALSE on missing counters or rollover.
+ */
+gboolean metadata_folder_version_counter_incr(const char *folder,
+						gboolean primary_changed,
+						gboolean secondary_changed)
+{
+	uint8_t primary[16];
+	uint8_t secondary[16];
+
+	if (!metadata_file || !metadata_kf)
+		return FALSE;
+
+	if (primary_changed) {
+		if (!metadata_get(folder, PRIMARY_COUNTER, primary))
+			return FALSE;
+
+		if (!counter_incr(primary))
+			return FALSE;
+
+		metadata_set(folder, PRIMARY_COUNTER, primary);
+	}
+
+	if (secondary_changed && (g_str_equal(folder, PB_CONTACTS_FOLDER) ||
+			g_str_equal(folder, PB_CALLS_SPEEDDIAL_FOLDER) ||
+			g_str_equal(folder, PB_CALLS_FAVORITE_FOLDER))) {
+		if (!metadata_get(folder, SECONDARY_COUNTER, secondary))
+			return FALSE;
+
+		if (!counter_incr(secondary))
+			return FALSE;
+
+		metadata_set(folder, SECONDARY_COUNTER, secondary);
+	}
+
+	return TRUE;
+}
diff --git a/obexd/plugins/phonebook-metadata.h b/obexd/plugins/phonebook-metadata.h
index c70c20ecd..cc87c7ce4 100644
--- a/obexd/plugins/phonebook-metadata.h
+++ b/obexd/plugins/phonebook-metadata.h
@@ -24,7 +24,8 @@ gboolean metadata_file_open(const char *file);
 void metadata_file_close(void);
 
 /* Reads metadata and zeroes invalid or unsaved values. */
-gboolean metadata_read(struct phonebook_metadata *metadata);
+gboolean metadata_read(const char *folder,
+				struct phonebook_metadata *metadata);
 
 /* Stores a hex encoded byte array. */
 void metadata_set(const char *group, const char *key,
@@ -40,6 +41,12 @@ gboolean metadata_get(const char *group, const char *key, uint8_t buf[16]);
 void metadata_identifier_update(void);
 
 /*
- * Persists the metadata file. Returns TRUE on success.
+ * Increments the primary and/or secondary folder version counters.
+ * Returns FALSE on missing counters or rollover.
  */
+gboolean metadata_folder_version_counter_incr(const char *folder,
+						gboolean primary_changed,
+						gboolean secondary_changed);
+
+/* Saves the metadata file when it has changes. Returns TRUE on success. */
 gboolean metadata_save(void);
diff --git a/obexd/plugins/phonebook.c b/obexd/plugins/phonebook.c
index 059414446..45e383d92 100644
--- a/obexd/plugins/phonebook.c
+++ b/obexd/plugins/phonebook.c
@@ -48,7 +48,8 @@ void phonebook_exit(void)
 	metadata_file_close();
 }
 
-int phonebook_get_metadata(struct phonebook_metadata *metadata)
+int phonebook_get_metadata(const char *folder,
+					struct phonebook_metadata *metadata)
 {
-	return metadata_read(metadata);
+	return metadata_read(folder, metadata);
 }
diff --git a/obexd/plugins/phonebook.h b/obexd/plugins/phonebook.h
index 6fb91f7e0..b2b2a3ab7 100644
--- a/obexd/plugins/phonebook.h
+++ b/obexd/plugins/phonebook.h
@@ -39,6 +39,8 @@
 #define PB_INFO_LOG "/telecom/pb/info.log"
 #define PB_CC_LOG "/telecom/pb/luid/cc.log"
 
+#define PRIMARY_COUNTER "primary_counter"
+#define SECONDARY_COUNTER "secondary_counter"
 
 struct apparam_field {
 	/* list and pull attributes */
@@ -108,7 +110,8 @@ char *phonebook_set_folder(const char *current_folder,
  * Returns the metadata identifying the current database contents. A zero
  * database identifier means the values are not persistent.
  */
-int phonebook_get_metadata(struct phonebook_metadata *metadata);
+int phonebook_get_metadata(const char *folder,
+					struct phonebook_metadata *metadata);
 
 /*
  * phonebook_pull should be used only to prepare pull request - prepared
-- 
2.34.1


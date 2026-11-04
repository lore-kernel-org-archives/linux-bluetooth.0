Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781279;
	b=4/S9H6Rr0i0P6s4WSi/tcw7W2O6wZGVXfyBOtySCanvlWty5FkTzathERsQqLoJi/fE9
	 0unvYqD13jZ+mSntQsldHofym6X4fPrJJVRXE4QOHI9IFZG8dmaZWMH5qhi3eCtb4iwh6
	 fjgUYqxhCjbHiy0MW6dOWpXVrEoslVBIkQQZliNxnpycYVykaE0+zd7GHMFWQn83AKkNr
	 Idr/43VVzEkdZo6aApOe9+1H4LDZNlKe5gLfmlQLgMt+KRaRmoGgxp3k/S1S16qdbZkF3
	 LIhV7Ttb7HYPDa+lRz+Bm0T/iEk9tVg/qbtQ9vgS/Kf6IaKMrbGUxAc48rJ58q1l7BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=LMFahJdjS6U+Ego5Q4GcaRynVa73tVZmt8xGW3rpeYQ=;
	b=UZrM4vozgqWyK82qtXSKfQBDO+/gaWFSbGKy4/W3opqZKw7ZS//xKxPFjBbHmk8CkMSk
	 AxJ6/xm+hX5z6vwYAJV18AXfpmP/86l/hKAyqkbY3AfpcjK2lOWCAtDuxhQLFNkcqq01y
	 5V5Cl6Kj/wTxrIH4Y3KBDf0gK/vD6f9jd8Xj1ikTi2PZmL8GlNQLwZkt1sZG06TbcheTP
	 Sr+uk3++jbdLwwv+9nREMVaj8vbmIuVsP88yOyP3iWQ8cCxbivuHvaQt8bPi/CBASJaRK
	 JmEoB5tM31EYgItGXopjd1cOvi8Yj6tav02Dc45MhHlq11M0DDyyepxNeQ5srze/LOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jxOUIu+h;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612CA606A332
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 612CA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jxOUIu+h
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48Knkp1229392
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LMFahJdjS6U
	+Ego5Q4GcaRynVa73tVZmt8xGW3rpeYQ=; b=jxOUIu+h5WIdoBetJLJrkR4PbbB
	MNO0lmpQgGzl6szzrmQR0HlRsL6TNxyKLCOr+uQGf1oymteqUU2dwafVce8Mb3uU
	BfMipctSW1pVdlr5wsm7AEBgQNlwiE2wpsA4RdsJynO4WV79GwwawPOLzPcnLwGs
	jt/1o2DpKYrvAa5fgNmkKO0/XClw+W6IgOLfzUCTs2BmAur59aFlpBkbSeT5GXLm
	tVizDw6GileeVxW6yWjIiQfrPdkTC/EEhTShhWXqjun2s9c5HMLt7ddN11ZumsRV
	I3SzdCRYn9xyJcHkcekyGsFlU01LQ83n9dTrIn/NspAx50mJTFxFKJZ46AQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8nju48-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48Yaee2686478;
	Wed, 4 Nov 2026 08:34:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A48YaiI2686432
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 897FA279C0; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 14/18] obexd/pbap: Add folder version counters
Date: Wed,  4 Nov 2026 16:34:25 +0800
Message-Id: <20261104083429.4111632-15-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX/8gKG456aNva
 lfhtPzEv4LMgvq45+YXs2MNPohAvvDFDcDWsQvENhLBhUr0M+BbMQpHYJNcsRjaP/tp7Jc8x7VA
 HUB41JlNDIofLCF4wNMlCxL7p6dsTPeZ57LMk3ruPfm486F7kFxLPxmKieyQxdiNrkvtskaMDoE
 UAaVM+vyrDn/BwAkMEp5a/R/b3Zmo8mCs6sVLVH0EyNo83yWQaspc6lpfLRBjkojyzOanN9pu6f
 Jlf4KuEYy6xAu2wbSP/Zh/JvzqFOr7mU8K5Y6qXVe1sl7/oPoJiFCShcwXXhVfSRYbJ5RGD3mZX
 7sOPDDJsaYntOJpeOM9hc4W0cpccTrFkDHxwg/CyVezWgzDtjRiIkGR4CEwarn+V35C4RimuBFI
 yDG7mPvOcjd1QiSMUzp43tDc1NX+dbmlkM52pcGuR+I6iPDlflk7to7kn5kvC0hK/uS4UWjtHwM
 OiwChxZRaCJzcwsL8fw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX0rYil3pc1pHF
 UB8QORm72zBvc33gpjCqLZh8PWjdF0bRAhS/JaCrwW7D04SgN4VCI004gkATQpkssfGYnS43NEw
 pmptDEMG2gAgrxIvxKqk4v5xDWjhYT4=
X-Proofpoint-GUID: G3hSoF0q0rRCJQrEnCDZEX2ukWLJJDG7
X-Proofpoint-ORIG-GUID: G3hSoF0q0rRCJQrEnCDZEX2ukWLJJDG7
X-Authority-Analysis: v=2.4 cv=As17T+9P c=1 sm=1 tr=0 ts=6aeaee1e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=7WgrJHsw8fBhsdb4IocA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040033

Add primary and secondary folder version counters to the dummy backend.
The counters are incremented when the content of a folder changes, and a
new Database Identifier is generated when they restart. The ebook and
tracker backends keep no counters and report a zero Database Identifier.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/phonebook-dummy.c    | 248 +++++++++++++++++++++++++++++
 obexd/plugins/phonebook-metadata.c |  54 +++++++
 obexd/plugins/phonebook-metadata.h |   8 +-
 obexd/plugins/phonebook.h          |   2 +
 4 files changed, 311 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 698510f6f..ca731c092 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -53,6 +53,12 @@ struct cache_query {
 	uint8_t newmissedcalls;
 };
 
+struct digest_data {
+	GChecksum *primary;
+	GChecksum *secondary;
+	char *path;
+};
+
 static char *root_folder = NULL;
 
 static void dummy_free(void *user_data)
@@ -76,9 +82,54 @@ static void query_free(void *user_data)
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
 
@@ -217,6 +268,194 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 	return 0;
 }
 
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
+	if (g_file_get_contents(entry, &contents, &len, NULL)) {
+		g_checksum_update(data->primary,
+					(const guchar *) contents, len);
+		g_free(contents);
+	}
+
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
+
+	/* Entries beyond 65535 are not covered by the digest */
+	foreach_vcard(dp, digest_entry, 0, 0xffff, &digest, NULL);
+
+	closedir(dp);
+	g_free(path);
+
+	g_checksum_get_digest(digest.primary, primary_digest, &len);
+	g_checksum_get_digest(digest.secondary, secondary_digest, &len);
+
+	g_checksum_free(digest.primary);
+	g_checksum_free(digest.secondary);
+
+	return TRUE;
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
+}
+
 struct concat_data {
 	GString *buffer;
 	const struct apparam_field *params;
@@ -578,6 +817,11 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
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
@@ -624,6 +868,8 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	char *filename;
 	int fd;
 
+	dummy_update_folder_version(folder);
+
 	filename = g_build_filename(root_folder, folder, id, NULL);
 
 	fd = open(filename, O_RDONLY);
@@ -660,6 +906,8 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	DIR *dp;
 	struct dummy_data *dummy;
 
+	dummy_update_folder_version(name);
+
 	foldername = g_build_filename(root_folder, name, NULL);
 	dp = opendir(foldername);
 	g_free(foldername);
diff --git a/obexd/plugins/phonebook-metadata.c b/obexd/plugins/phonebook-metadata.c
index 06cfa2a8a..dffdcda91 100644
--- a/obexd/plugins/phonebook-metadata.c
+++ b/obexd/plugins/phonebook-metadata.c
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
index c70c20ecd..a2f921f13 100644
--- a/obexd/plugins/phonebook-metadata.h
+++ b/obexd/plugins/phonebook-metadata.h
@@ -40,6 +40,12 @@ gboolean metadata_get(const char *group, const char *key, uint8_t buf[16]);
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
diff --git a/obexd/plugins/phonebook.h b/obexd/plugins/phonebook.h
index 6fb91f7e0..1bd6ff229 100644
--- a/obexd/plugins/phonebook.h
+++ b/obexd/plugins/phonebook.h
@@ -39,6 +39,8 @@
 #define PB_INFO_LOG "/telecom/pb/info.log"
 #define PB_CC_LOG "/telecom/pb/luid/cc.log"
 
+#define PRIMARY_COUNTER "primary_counter"
+#define SECONDARY_COUNTER "secondary_counter"
 
 struct apparam_field {
 	/* list and pull attributes */
-- 
2.34.1


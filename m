Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390280;
	b=tUHtVAc+8gNKAQKCBR/CIPLCVbBgpfqTPoDjGC9ipUdpEyHZgrwgDXL+uxVP2dCnAvf3
	 7cU0JhLguCx0b3KOp0UCNw7XF8Es+ERzm0RIQcZLsGqiAUpPo3/r+ANuaHh+wmqJKBw0p
	 1L83IOMN3sTtO/4YlLQ+ypnRGx5RL0rabh1pV665ZBKJ1gipKMZHWf0oreHFoZ2Q0Fcno
	 LaMEVVLDQceLc2w/e/eyFoo5Q9lK8THEYtTUC6s/WIVQxIkso4pcNJPG5cm4HPgbBUbN5
	 BgZO/reTibZbfe9stBHeE+MTuthdwYqeYqP/sIeG9FHVxW0lKhAVxTeWfksveuUTMrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390280;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fEMYzl6mjnbYiyGSaR91L3LHHWATYiZ7m7RXsPIuq0g=;
	b=hoDHPEEyna8kIo5Y2AGSEJXrErTIVNoaNwwcGTgVD84k3asoG2oX0tZrBZ5I4Aiu3SSu
	 +X3cWfgpPPDho9hiIuT3xzU0NtxmnLG3uEggzrG6GMS0OOpP/sNeccjetnLx+zjvVIoHz
	 yU2gwlUJF1GdjCcLSROa91VaaR8S9e+71KeJ+2L11a9lnnHE+dpjjGWJOx/uHTxEEu7mP
	 FL5tSX9zL7f9m0agHGhnuyAebH2TxcKtODeYVAZjXBHWMUbNxAjywXolvzQAlsU2yCSZ9
	 4tMUBs1pCO1ispPgY+PzCS028r3ybf5IcEdZlBH0h6nU5J5XR0nzHAWo3e+tKfP4p+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fcIGrn6y;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B860A2605
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB9B860A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fcIGrn6y
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB7DOaQ1590020;
	Wed, 11 Nov 2026 09:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fEMYzl6mjnb
	YiyGSaR91L3LHHWATYiZ7m7RXsPIuq0g=; b=fcIGrn6ynnIMCoD627FxqoszitB
	Yb2/WHXa2bG/uy7AhkqOsnx5H3c8lwXH95XOOtK2x5IE6XqwIUpFVBxwQ+LnLOIf
	WjQqxCD6k0C00HEvgruFZtgFetV2qLDT6aGiGmVkFofo2yIJOpwaPQGhgHjw4+vi
	OAJOZmIKwkTGBYGYo1PrCXi2p5jJISHTLpLgQ7hhQh0br5+vahQs42Jd1NzTftEJ
	ayNbg7HRZWUGYjMwYXgW2jE8z3kMenvB+FPAlBNy8FGe2/4PM5fbyGlS3ovCDs2p
	PnocYTIUjoQoZ8gQ5EqxrPkONyNJg+8FFnzUIZgsl83gZm1dK91XDoU3Nvw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksm8khs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iaSS2424297;
	Wed, 11 Nov 2026 09:44:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AB9iauE2424273
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 6C631243DB; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 16/20] obexd/pbap: Add folder version counters
Date: Wed, 11 Nov 2026 17:44:21 +0800
Message-Id: <20261111094425.1444893-17-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-GUID: nppOP1_AMJGr46TDGm2QjQ7uhzhc1pgQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfXwirIrkz+5oiW
 WaZwPoI0yzCboiHakK+IravmgjuNgmqThEtEKPKLlNQK7iRCOYwTaJm75vbqWRr6QQ3uUTx2nUX
 qpfKMOVnUYMPdMrSazEUx9vHucB79UcMAVqut3h0gzpDzxcmFpXMmmtU49BcKkCyRR3ngARrMg7
 RfnSQSA7roztJLCqYNr1YI9r5i502PZvcPb57IEiwE4YxaswXAi5B90WnCTEd/9ga06uXFaaVJB
 hLnkaQkYQyoAGnPHprSG9WIT/aOSK+ouLG1aoDUAneP7iLK0i/yxIL9u/qlbiVTv7lRmkZ2igX1
 vwNz5U8NmQfFyyFiCLwt/Yn4uhpJTT1+oDmXb09Mc+DzxOrQC+Gr6WpoKclnxbg32T5jE8iFW4A
 +dqEXAPcsaPFaunppZr35JgEUstB8GwbvYJ/ijwB8jCFoEz+lMFegWOS+CK1xyNwTsyPeiJbx94
 gY/LBcKiSHyEaiXVYaw==
X-Proofpoint-ORIG-GUID: nppOP1_AMJGr46TDGm2QjQ7uhzhc1pgQ
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af43906 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=7WgrJHsw8fBhsdb4IocA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX1FkDHARk149r
 GSGzErhTNeNkUoIap7aDXH1AgBiSlQwt6/rpt0eGwmP4fGJcVLOQU5tXm/E05Ats8DAV8FmUvEW
 Q8O2Usy59J3pErS8iPsfoT/wd5bDaSo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

Add primary and secondary folder version counters to the dummy backend.
The counters are incremented when the content of a folder changes, and a
new Database Identifier is generated when they restart. The ebook and
tracker backends keep no counters and report a zero Database Identifier.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/phonebook-dummy.c    | 246 +++++++++++++++++++++++++++++
 obexd/plugins/phonebook-metadata.c |  54 +++++++
 obexd/plugins/phonebook-metadata.h |   8 +-
 obexd/plugins/phonebook.h          |   2 +
 4 files changed, 309 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index f97693d0f..72d7ce622 100644
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
@@ -599,6 +838,11 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
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
@@ -681,6 +925,8 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
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


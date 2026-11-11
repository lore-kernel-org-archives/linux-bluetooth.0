Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390281;
	b=bS7T7yWe2tegsvh6QhPK1MuIut/pyWrMwoG8/rV9xV4LO0gH9kT4jg0rBRaz4CJC/+qa
	 To+OMnbcezmyQpF/lh3Gid4hmk8hhIbCOgCvqC0eon0TbNz5yxQG72yGVZuy2CtLQoG+V
	 9whHMqj2v9Fx5YGzxJgNntYTiuBWEVSaRQ9fMS2e8yyue0HrsbPvDvciK6Yo1d+Mc9Kut
	 ZdXOFaoELJh1wpiueVdyz0XkDA6+ouwAVAjjHsr3cVIqbOZGtbCL9gQ7KN1OXowXzFmhU
	 HR+I91b8ZuNqzjg03b+2OPk8+W17Yc8FkYCOjIZJopLBFakl0G5DOf9KHhpQsQBkl2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390281;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3CB7pHnMLnLARYFl3nIlI5hFFekCLLZmUGGaUDkAzTk=;
	b=BvbJF3jKuAu0LcasfBhwOO3I7IJtHEj3R6J87Hh4WcS93vKQtxiEsWwR8BgTMeiDODfJ
	 cxQoW2OID3WVIOCriF9Huf1fUMEeXe62Jkuq47eobl7YfsiXFgmCJ8BXO/dhCCDO9uR0m
	 AItye7lC50HTQi730OobwdzSK7FMwoG/hc7sMG7KJ1d0AzGzjaQR9rf6lxapI04KdrM/3
	 AlxALe0aKjDNk5mXXZfWn6A5PHwLeqwZragemWkBJpaf6q11u5Jm0vTafyWUaXdQXR3Mq
	 6Xs1XzmngcfPObA0W2p8R5WrnqphOgUaJ/hUxp7SXmtcuBZcRf+Vmt/WRt5mOKYJdCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NWNtKyRu;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1F60A261D
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39B1F60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NWNtKyRu
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KgEU300698;
	Wed, 11 Nov 2026 09:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3CB7pHnMLnL
	ARYFl3nIlI5hFFekCLLZmUGGaUDkAzTk=; b=NWNtKyRu4VKoEQydGZJqTi+FTWK
	cTsnKOnZSqF2+pCxCWzDFOZgrqCVqLN8Bx1khzZbJLasvhpygMPcKQYD8BQMzf+q
	ST/fadqKaWnrWd5jmg5RRdZjh58JYD4H7ri39gnvF4Pf22aivFQ/mTPMPY0rDK5Q
	uw4o9X6X8YkBROVhqpiBgoRxs0iB62QpqTRXOrXVPpRgdhdSt6lwju+nDikOOcJv
	lRUKRVvTvQ0sfKcu3jCoEoYTXJBwxwDVoAdpCUVkUUQ6CSRhzPLTBXp4hghn2K8D
	dx1JEQe6M4B3xgYe1NxZSIf3P26+1hrkfsU9husbuB07JU6Si75r3DxcYyg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5kmkq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iaS02424454;
	Wed, 11 Nov 2026 09:44:36 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AB9iaHT2424436
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:36 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 7487524409; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 18/20] obexd/pbap: Add vCardSelector support
Date: Wed, 11 Nov 2026 17:44:23 +0800
Message-Id: <20261111094425.1444893-19-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfXx734drZ0TthU
 4t1+q3nMw7VzzK7rfHI5IRqxFzkvTUyvne1a+pNRHdmZKYv/guXmUuf6yd/X5+l4+3m811rh6gP
 dQMSMZ2fJy09Mtc9vfzULFTqwG5wFLEIVv03mNAJvhheyVnVXQH0bRKQamRTvxkjs6nLC5cZLNX
 mAIT9L7eZmqvK+/7zkYcsfBRb/LCDBZktoOOcRADr+It0SoS+Ru3N9xOPe/9jwLeDHvCWFsiPqe
 9kU6Yv0uV6jYxpCVJnQ6uUIQPJRrgeiYov79qj5LCSilA4VEQlz3DBiwLYtpQZx5Kl547zK+0N0
 nxE8HoDY+VnE/lFfgEIMSk7txum4YavYbykBLMN0uGpXjW/xRAQFA1CbDeBynQx6InZ9pmj5wGf
 RT29Nrn1bQ6TdaMBb4my8ebghkYwLmEHslOlETKYis3At7o74oO9AVTeUwGwaTXY1F8SCLqux63
 wbGCnoa/UcqO5nOF+pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX9rYocP4brm7H
 R8dFJwi10IJiyZsCwLSAtZhNmKufiqVG9NxHfmJ4VLrzFLOTTnOnk/PZ0eUcmnIcHpDHQjnf6G2
 ScmFE9jxGU6Jsz+qY1fZXPf7XTC7U2c=
X-Proofpoint-ORIG-GUID: cL7uvJ7a7B5V3vRflTK9rZrj5KEZQ8WI
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af43907 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=BeCypHutYhW7dRN5KLMA:9
X-Proofpoint-GUID: cL7uvJ7a7B5V3vRflTK9rZrj5KEZQ8WI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

Apply vCardSelector and vCardSelectorOperator to phonebook and vCard
listing requests when vCard Selecting is negotiated. Count and paginate
matching entries.

Add property presence masks to the dummy, ebook and tracker backends.
Use the full name, nickname or telephone number when structured names
are empty.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c              |  50 +++++-
 obexd/plugins/phonebook-dummy.c   | 168 +++++++++++++++---
 obexd/plugins/phonebook-ebook.c   |  84 +++++++--
 obexd/plugins/phonebook-tracker.c | 284 +++++++++++++++++-------------
 obexd/plugins/phonebook.h         |  65 ++++++-
 obexd/plugins/vcard.c             |  69 ++++++++
 obexd/plugins/vcard.h             |   2 +
 7 files changed, 555 insertions(+), 167 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index c47be81ab..dba05b038 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -53,17 +53,21 @@
 #define NEWMISSEDCALLS_TAG		0x09
 #define PRIMARY_COUNTER_TAG		0x0A
 #define SECONDARY_COUNTER_TAG		0x0B
+#define VCARD_SELECTOR_TAG		0x0C
 #define DATABASEID_TAG			0x0D
+#define VCARD_SELECTOR_OPERATOR_TAG	0x0E
 #define SUPPORTED_FEATURES_TAG		0x10
 
 #define DOWNLOAD_FEATURE	0x00000001
 #define BROWSE_FEATURE		0x00000002
 #define DATABASEID_FEATURE	0x00000004
 #define FOLDER_VERSION_FEATURE	0x00000008
+#define VCARD_SELECTING_FEATURE	0x00000010
 
 #define PSE_SUPPORTED_FEATURES \
 	(DOWNLOAD_FEATURE | BROWSE_FEATURE | \
-	DATABASEID_FEATURE | FOLDER_VERSION_FEATURE)
+	DATABASEID_FEATURE | FOLDER_VERSION_FEATURE | \
+	VCARD_SELECTING_FEATURE)
 
 struct cache {
 	gboolean valid;
@@ -77,6 +81,7 @@ struct cache_entry {
 	char *name;
 	char *sound;
 	char *tel;
+	uint64_t mask;
 };
 
 struct pbap_session {
@@ -334,7 +339,8 @@ static void vcard_result(const char *buffer, size_t bufsize, int vcards,
 
 static void cache_entry_notify(const char *id, uint32_t handle,
 					const char *name, const char *sound,
-					const char *tel, void *user_data)
+					const char *tel, uint64_t mask,
+					void *user_data)
 {
 	struct pbap_session *pbap = user_data;
 	struct cache_entry *entry = g_new0(struct cache_entry, 1);
@@ -349,6 +355,7 @@ static void cache_entry_notify(const char *id, uint32_t handle,
 	entry->name = g_strdup(name);
 	entry->sound = g_strdup(sound);
 	entry->tel = g_strdup(tel);
+	entry->mask = mask;
 
 	cache->entries = g_slist_append(cache->entries, entry);
 }
@@ -444,6 +451,7 @@ static GSList *sort_entries(GSList *l, uint8_t order, uint8_t search_attrib,
 
 static int generate_response(struct pbap_session *pbap, uint8_t missed)
 {
+	GSList *filtered = NULL;
 	GSList *sorted;
 	GSList *l;
 	uint16_t max = pbap->params->maxlistcount;
@@ -453,9 +461,21 @@ static int generate_response(struct pbap_session *pbap, uint8_t missed)
 	response_add_missed_calls(pbap, missed);
 	response_add_metadata(pbap, TRUE);
 
+	/* Select matching entries from the full cache. */
+	for (l = pbap->cache.entries; l; l = l->next) {
+		struct cache_entry *entry = l->data;
+
+		if (phonebook_selector_match(entry->mask,
+					pbap->params->selector,
+					pbap->params->selector_operator))
+			filtered = g_slist_prepend(filtered, entry);
+	}
+
+	filtered = g_slist_reverse(filtered);
+
 	if (max == 0) {
-		/* Ignore all other parameter and return PhoneBookSize */
-		uint16_t size = g_slist_length(pbap->cache.entries);
+		/* Return the number of matching entries. */
+		uint16_t size = g_slist_length(filtered);
 
 		pbap->obj->firstpacket = TRUE;
 		pbap->obj->apparam = g_obex_apparam_set_uint16(
@@ -463,6 +483,8 @@ static int generate_response(struct pbap_session *pbap, uint8_t missed)
 							PHONEBOOKSIZE_TAG,
 							size);
 
+		g_slist_free(filtered);
+
 		return 0;
 	}
 
@@ -470,9 +492,10 @@ static int generate_response(struct pbap_session *pbap, uint8_t missed)
 	 * Don't free the sorted list content: this list contains
 	 * only the reference for the "real" cache entry.
 	 */
-	sorted = sort_entries(pbap->cache.entries, pbap->params->order,
+	sorted = sort_entries(filtered, pbap->params->order,
 				pbap->params->searchattrib,
 				(const char *) pbap->params->searchval);
+	g_slist_free(filtered);
 
 	/* Computing offset considering first entry of the phonebook */
 	l = g_slist_nth(sorted, pbap->params->liststartoffset);
@@ -560,16 +583,23 @@ static struct apparam_field *parse_aparam(const uint8_t *buffer, uint32_t hlen)
 		g_obex_apparam_get_uint16(apparam, LISTSTARTOFFSET_TAG,
 						&param->liststartoffset);
 		g_obex_apparam_get_uint64(apparam, FILTER_TAG, &param->filter);
+		g_obex_apparam_get_uint64(apparam, VCARD_SELECTOR_TAG,
+						&param->selector);
+		g_obex_apparam_get_uint8(apparam,
+						VCARD_SELECTOR_OPERATOR_TAG,
+						&param->selector_operator);
 		param->searchval = g_obex_apparam_get_string(apparam,
 						SEARCHVALUE_TAG);
 
 		g_obex_apparam_free(apparam);
 	}
 
-	DBG("o %x sa %x sv %s fil %" G_GINT64_MODIFIER "x for %x max %x off %x",
+	DBG("o %x sa %x sv %s fil %" G_GINT64_MODIFIER "x for %x max %x off %x "
+		"sel %" G_GINT64_MODIFIER "x op %x",
 			param->order, param->searchattrib, param->searchval,
 			param->filter, param->format, param->maxlistcount,
-			param->liststartoffset);
+			param->liststartoffset, param->selector,
+			param->selector_operator);
 
 	return param;
 }
@@ -654,6 +684,12 @@ static int pbap_get(struct obex_session *os, void *user_data)
 	if (params == NULL)
 		return -EBADR;
 
+	/* Ignore selectors unless vCard Selecting is negotiated. */
+	if (!(pbap->negotiated_features & VCARD_SELECTING_FEATURE)) {
+		params->selector = 0;
+		params->selector_operator = 0;
+	}
+
 	if (pbap->params) {
 		g_free(pbap->params->searchval);
 		g_free(pbap->params);
diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 72d7ce622..3c3ae709a 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -61,6 +61,109 @@ struct digest_data {
 
 static char *root_folder = NULL;
 
+static gboolean vobject_value_present(VObject *prop)
+{
+	const char *str;
+	const wchar_t *ustr;
+	VObject *size;
+
+	switch (vObjectValueType(prop)) {
+	case VCVT_STRINGZ:
+		str = vObjectStringZValue(prop);
+		return str && str[0];
+	case VCVT_USTRINGZ:
+		ustr = vObjectUStringZValue(prop);
+		return ustr && uStrLen(ustr) > 0;
+	case VCVT_UINT:
+	case VCVT_ULONG:
+		return TRUE;
+	case VCVT_RAW:
+		if (!vObjectAnyValue(prop))
+			return FALSE;
+
+		size = isAPropertyOf(prop, VCDataSizeProp);
+		if (!size)
+			return FALSE;
+
+		switch (vObjectValueType(size)) {
+		case VCVT_UINT:
+			return vObjectIntegerValue(size) > 0;
+		case VCVT_ULONG:
+			return vObjectLongValue(size) > 0;
+		default:
+			return FALSE;
+		}
+	case VCVT_VOBJECT:
+		return vObjectVObjectValue(prop) != NULL;
+	default:
+		return FALSE;
+	}
+}
+
+static gboolean vcard_property_present(VObject *v, const char *name)
+{
+	static const char * const name_fields[] = {
+		VCFamilyNameProp, VCGivenNameProp, VCAdditionalNamesProp,
+		VCNamePrefixesProp, VCNameSuffixesProp, NULL
+	};
+	static const char * const address_fields[] = {
+		VCPostalBoxProp, VCExtAddressProp, VCStreetAddressProp,
+		VCCityProp, VCRegionProp, VCPostalCodeProp, VCCountryNameProp,
+		NULL
+	};
+	static const char * const org_fields[] = {
+		VCOrgNameProp, VCOrgUnitProp, VCOrgUnit2Prop, VCOrgUnit3Prop,
+		VCOrgUnit4Prop, NULL
+	};
+	const char * const *fields = NULL;
+	VObjectIterator iterator;
+	VObject *prop;
+	unsigned int i;
+
+	if (!g_ascii_strcasecmp(name, VCNameProp))
+		fields = name_fields;
+	else if (!g_ascii_strcasecmp(name, VCAdrProp))
+		fields = address_fields;
+	else if (!g_ascii_strcasecmp(name, VCOrgProp))
+		fields = org_fields;
+
+	initPropIterator(&iterator, v);
+
+	while (moreIteration(&iterator)) {
+		prop = nextVObject(&iterator);
+
+		if (g_ascii_strcasecmp(vObjectName(prop), name))
+			continue;
+
+		if (vobject_value_present(prop))
+			return TRUE;
+
+		for (i = 0; fields && fields[i]; i++) {
+			VObject *field = isAPropertyOf(prop, fields[i]);
+
+			if (field && vobject_value_present(field))
+				return TRUE;
+		}
+	}
+
+	return FALSE;
+}
+
+static uint64_t vcard_presence_mask(VObject *v)
+{
+	uint64_t mask = 0;
+	unsigned int i;
+
+	for (i = 0; i < G_N_ELEMENTS(phonebook_selector_properties); i++) {
+		const char *property = phonebook_selector_properties[i];
+
+		if (property && vcard_property_present(v, property))
+			mask |= (1ULL << i);
+	}
+
+	return mask;
+}
+
 static void dummy_free(void *user_data)
 {
 	struct dummy_data *dummy = user_data;
@@ -459,6 +562,9 @@ static void dummy_update_folder_version(const char *folder)
 struct concat_data {
 	GString *buffer;
 	const struct apparam_field *params;
+	uint16_t offset;
+	uint16_t max;
+	uint16_t count;
 };
 
 static char *filter_vcard_photo(const char *buffer, size_t length,
@@ -537,6 +643,23 @@ static void entry_concat(const char *filename, VObject *v, void *user_data)
 	size_t filtered_len;
 	int len;
 
+	if (!phonebook_selector_match(vcard_presence_mask(v),
+					data->params->selector,
+					data->params->selector_operator))
+		return;
+
+	data->count++;
+
+	/*
+	 * Offset and MaxListCount apply to the vCards matching the
+	 * vCardSelector.
+	 */
+	if (data->count <= data->offset)
+		return;
+
+	if (data->count - data->offset > data->max)
+		return;
+
 	/*
 	 * VObject API uses len for IN and OUT
 	 * Written bytes is also returned in the len variable
@@ -555,41 +678,43 @@ static void entry_concat(const char *filename, VObject *v, void *user_data)
 static gboolean read_dir(void *user_data)
 {
 	struct dummy_data *dummy = user_data;
-	struct concat_data data;
+	struct concat_data data = { 0 };
 	DIR *dp;
-	uint16_t count = 0, max, offset;
 
 	data.buffer = g_string_new("");
 	data.params = dummy->apparams;
 
-	dp = opendir(dummy->folder);
-	if (dp == NULL) {
-		int err = errno;
-		DBG("opendir(): %s(%d)", strerror(err), err);
-		goto done;
-	}
-
 	/*
 	 * For PullPhoneBook function, the decision of returning the size
 	 * or contacts is made in the PBAP core. When MaxListCount is ZERO,
 	 * PCE wants to know the size of a given folder, PSE shall ignore all
-	 * other applicattion parameters that may be present in the request.
+	 * other application parameters that may be present in the request,
+	 * except the vCardSelector and vCardSelectorOperator, which still
+	 * apply to the returned size.
 	 */
-	if (dummy->apparams->maxlistcount == 0) {
-		max = 0xffff;
-		offset = 0;
-	} else {
-		max = dummy->apparams->maxlistcount;
-		offset = dummy->apparams->liststartoffset;
+	if (dummy->apparams->maxlistcount == 0)
+		data.max = 0xffff;
+	else {
+		data.max = dummy->apparams->maxlistcount;
+		data.offset = dummy->apparams->liststartoffset;
+	}
+
+	dp = opendir(dummy->folder);
+	if (dp == NULL) {
+		int err = errno;
+
+		DBG("opendir(): %s(%d)", strerror(err), err);
+
+		goto done;
 	}
 
-	foreach_vcard(dp, entry_concat, offset, max, &data, &count);
+	foreach_vcard(dp, entry_concat, 0, 0xffff, &data, NULL);
 
 	closedir(dp);
 done:
 	/* FIXME: Missing vCards fields filtering */
-	dummy->cb(data.buffer->str, data.buffer->len, count,
-			dummy->newmissedcalls, TRUE, dummy->user_data);
+	dummy->cb(data.buffer->str, data.buffer->len, data.count,
+				dummy->newmissedcalls, TRUE, dummy->user_data);
 
 	g_string_free(data.buffer, TRUE);
 
@@ -602,6 +727,7 @@ static void entry_notify(const char *filename, VObject *v, void *user_data)
 	VObject *property, *subproperty;
 	GString *name;
 	const char *tel;
+	uint64_t mask;
 	long unsigned int handle;
 
 	property = isAPropertyOf(v, VCNameProp);
@@ -614,6 +740,8 @@ static void entry_notify(const char *filename, VObject *v, void *user_data)
 	if (handle > UINT32_MAX)
 		return;
 
+	mask = vcard_presence_mask(v);
+
 	/* LastName; FirstName; MiddleName; Prefix; Suffix */
 
 	name = g_string_new("");
@@ -648,7 +776,7 @@ static void entry_notify(const char *filename, VObject *v, void *user_data)
 
 	tel = property ? fakeCString(vObjectUStringZValue(property)) : NULL;
 
-	query->entry_cb(filename, handle, name->str, NULL, tel,
+	query->entry_cb(filename, handle, name->str, NULL, tel, mask,
 							query->user_data);
 	g_string_free(name, TRUE);
 }
diff --git a/obexd/plugins/phonebook-ebook.c b/obexd/plugins/phonebook-ebook.c
index 07bf98678..d2acc4d9b 100644
--- a/obexd/plugins/phonebook-ebook.c
+++ b/obexd/plugins/phonebook-ebook.c
@@ -101,6 +101,42 @@ static void free_query_context(struct query_context *data)
 	g_free(data);
 }
 
+static uint64_t evcard_presence_mask(EVCard *evcard)
+{
+	GList *l;
+	/* VERSION is generated when serializing the vCard. */
+	uint64_t mask = 1ULL << 0;
+
+	for (l = e_vcard_get_attributes(evcard); l; l = l->next) {
+		EVCardAttribute *attrib = l->data;
+		const char *name = e_vcard_attribute_get_name(attrib);
+		GList *values;
+		unsigned int i;
+
+		for (values = e_vcard_attribute_get_values(attrib); values;
+							values = values->next) {
+			const char *value = values->data;
+
+			if (value && value[0])
+				break;
+		}
+
+		if (!values)
+			continue;
+
+		for (i = 0; i < G_N_ELEMENTS(phonebook_selector_properties);
+									i++) {
+			if (!g_ascii_strcasecmp(name,
+					phonebook_selector_properties[i])) {
+				mask |= 1ULL << i;
+				break;
+			}
+		}
+	}
+
+	return mask;
+}
+
 static char *evcard_to_string(EVCard *evcard, unsigned int format,
 							       uint64_t filter)
 {
@@ -275,7 +311,7 @@ static void phonebook_pull_read_ready(GObject *source_object,
 	GSList *l = NULL;
 	GSList *contacts = NULL;
 	GError *gerr = NULL;
-	unsigned int count, maxcount;
+	unsigned int count, maxcount, offset;
 
 	/* Finish async call to retrieve contacts */
 	data->queued_calls--;
@@ -292,28 +328,35 @@ static void phonebook_pull_read_ready(GObject *source_object,
 		goto done;
 	}
 
-	/*
-	 * When MaxListCount is zero, PCE wants to know the number of used
-	 * indexes in the phonebook of interest. All other parameters that
-	 * may be present in the request shall be ignored.
-	 */
 	maxcount = data->params->maxlistcount;
-	if (maxcount == 0) {
-		data->count += g_slist_length(contacts);
-		goto done;
-	}
+	offset = data->params->liststartoffset;
+	count = 0;
 
-	/*
-	 * Convert each contact to a vCard and append the card to
-	 * the buffer string.
-	 */
-	l = g_slist_nth(contacts, data->params->liststartoffset);
-	for (count = 0; l && count + data->count < maxcount;
-						l = g_slist_next(l), count++) {
+	for (l = contacts; l; l = l->next) {
 		EContact *contact = E_CONTACT(l->data);
 		EVCard *evcard = E_VCARD(contact);
 		char *vcard;
 
+		if (data->params->selector &&
+				!phonebook_selector_match(
+					evcard_presence_mask(evcard),
+					data->params->selector,
+					data->params->selector_operator))
+			continue;
+
+		if (maxcount == 0) {
+			count++;
+			continue;
+		}
+
+		if (offset) {
+			offset--;
+			continue;
+		}
+
+		if (count + data->count >= maxcount)
+			break;
+
 		if (data->params->format == PB_FORMAT_VCARD30)
 			vcard = evcard_to_string(evcard, EVC_FORMAT_VCARD_30,
 							 data->params->filter);
@@ -326,6 +369,7 @@ static void phonebook_pull_read_ready(GObject *source_object,
 		data->buf = g_string_append(data->buf, vcard);
 		data->buf = g_string_append(data->buf, "\r\n");
 		g_free(vcard);
+		count++;
 	}
 
 	DBG("collected %d contacts", count);
@@ -527,7 +571,8 @@ static void phonebook_create_cache_ready(GObject *source_object,
 			tel = g_strdup("");
 
 		data->entry_cb(uid, PHONEBOOK_INVALID_HANDLE, name, NULL,
-							tel, data->user_data);
+					tel, evcard_presence_mask(evcard),
+							data->user_data);
 
 		g_free(name);
 		g_free(uid);
@@ -605,7 +650,8 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	else
 		tel = g_strdup("");
 
-	data->entry_cb(uid, 0, cname, NULL, tel, data->user_data);
+	data->entry_cb(uid, 0, cname, NULL, tel, evcard_presence_mask(evcard),
+							data->user_data);
 	data->count++;
 
 	g_free(cname);
diff --git a/obexd/plugins/phonebook-tracker.c b/obexd/plugins/phonebook-tracker.c
index 07d8dd34b..9db62ab8e 100644
--- a/obexd/plugins/phonebook-tracker.c
+++ b/obexd/plugins/phonebook-tracker.c
@@ -144,32 +144,6 @@
 "}"									\
 "ORDER BY tracker:id(?_contact)"
 
-#define CONTACTS_QUERY_ALL_LIST						\
-	"SELECT ?c nco:nameFamily(?c) "					\
-	"nco:nameGiven(?c) nco:nameAdditional(?c) "			\
-	"nco:nameHonorificPrefix(?c) nco:nameHonorificSuffix(?c) "	\
-	"(SELECT "							\
-		"?nick "						\
-		"WHERE { "						\
-			"{ "						\
-				"?c nco:nickname ?nick "		\
-			"} UNION { "					\
-				"?c nco:hasAffiliation ?role . "	\
-				"?role nco:hasIMAddress ?im . "		\
-				"?im nco:imNickname ?nick "		\
-			"} "						\
-		"} "							\
-	") "								\
-	"nco:phoneNumber(?h) "						\
-	"WHERE { "							\
-		"?c a nco:PersonContact . "				\
-	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
-	"OPTIONAL { "							\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?h . "				\
-	"} "								\
-	"} GROUP BY ?c"
-
 #define CALLS_CONSTRAINTS(CONSTRAINT)					\
 " WHERE { "								\
 	"?_call a nmo:Call . "						\
@@ -194,27 +168,6 @@ CONSTRAINT								\
 	"} "								\
 "} "
 
-#define CALLS_LIST(CONSTRAINT)						\
-"SELECT ?_call nco:nameFamily(?_contact) "				\
-	"nco:nameGiven(?_contact) nco:nameAdditional(?_contact) "	\
-	"nco:nameHonorificPrefix(?_contact) "				\
-	"nco:nameHonorificSuffix(?_contact) "				\
-	"(SELECT "							\
-		"?nick "						\
-		"WHERE { "						\
-			"{ "						\
-				"?_contact nco:nickname ?nick "		\
-			"} UNION { "					\
-				"?_contact nco:hasAffiliation ?role . "	\
-				"?role nco:hasIMAddress ?im . "		\
-				"?im nco:imNickname ?nick "		\
-			"} "						\
-		"} "							\
-	") "								\
-	"nco:phoneNumber(?_cpn) "					\
-CALLS_CONSTRAINTS(CONSTRAINT)						\
-"ORDER BY DESC(nmo:sentDate(?_call)) "
-
 #define CALLS_QUERY(CONSTRAINT)						\
 "SELECT "								\
 "(SELECT fn:concat(rdf:type(?role_number),"				\
@@ -317,13 +270,9 @@ COMBINED_CONSTRAINT		\
 "FILTER (?_call = <%s>) "
 
 #define MISSED_CALLS_QUERY CALLS_QUERY(MISSED_CONSTRAINT)
-#define MISSED_CALLS_LIST CALLS_LIST(MISSED_CONSTRAINT)
 #define INCOMING_CALLS_QUERY CALLS_QUERY(INCOMING_CONSTRAINT)
-#define INCOMING_CALLS_LIST CALLS_LIST(INCOMING_CONSTRAINT)
 #define OUTGOING_CALLS_QUERY CALLS_QUERY(OUTGOING_CONSTRAINT)
-#define OUTGOING_CALLS_LIST CALLS_LIST(OUTGOING_CONSTRAINT)
 #define COMBINED_CALLS_QUERY CALLS_QUERY(COMBINED_CONSTRAINT)
-#define COMBINED_CALLS_LIST CALLS_LIST(COMBINED_CONSTRAINT)
 #define CONTACT_FROM_CALL_QUERY CALLS_QUERY(CALL_URI_CONSTRAINT)
 
 #define CONTACTS_QUERY_FROM_URI						\
@@ -482,11 +431,13 @@ struct pending_reply {
 
 enum phonebook_request {
 	PHONEBOOK_REQUEST_PULL,
+	PHONEBOOK_REQUEST_SELECT,
 	PHONEBOOK_REQUEST_ENTRY,
 	PHONEBOOK_REQUEST_CACHE,
 };
 
 struct contact_data {
+	gboolean name_present;
 	char *id;
 	struct phonebook_contact *contact;
 };
@@ -498,6 +449,7 @@ struct phonebook_data {
 	enum phonebook_request request;
 	const struct apparam_field *params;
 	GSList *contacts;
+	GHashTable *contact_index;
 	phonebook_cache_ready_cb ready_cb;
 	phonebook_entry_cb entry_cb;
 	uint8_t newmissedcalls;
@@ -573,15 +525,15 @@ static gboolean folder_is_valid(const char *folder)
 static const char *folder2query(const char *folder)
 {
 	if (g_str_equal(folder, PB_CONTACTS_FOLDER))
-		return CONTACTS_QUERY_ALL_LIST;
+		return CONTACTS_QUERY_ALL;
 	else if (g_str_equal(folder, PB_CALLS_INCOMING_FOLDER))
-		return INCOMING_CALLS_LIST;
+		return INCOMING_CALLS_QUERY;
 	else if (g_str_equal(folder, PB_CALLS_OUTGOING_FOLDER))
-		return OUTGOING_CALLS_LIST;
+		return OUTGOING_CALLS_QUERY;
 	else if (g_str_equal(folder, PB_CALLS_MISSED_FOLDER))
-		return MISSED_CALLS_LIST;
+		return MISSED_CALLS_QUERY;
 	else if (g_str_equal(folder, PB_CALLS_COMBINED_FOLDER))
-		return COMBINED_CALLS_LIST;
+		return COMBINED_CALLS_QUERY;
 
 	return NULL;
 }
@@ -810,12 +762,22 @@ static gboolean contact_matches(struct contact_data *c_data, const char *id,
 	return (cmp_ret == 0) ? TRUE : FALSE;
 }
 
-static struct phonebook_contact *find_contact(GSList *contacts, const char *id,
-							const char *datetime)
+static struct phonebook_contact *find_contact(struct phonebook_data *data,
+				const char *id, const char *datetime)
 {
 	GSList *l;
 
-	for (l = contacts; l; l = l->next) {
+	if (data->contact_index) {
+		struct phonebook_contact *contact;
+		char *key = g_strconcat(id, "\n", datetime, NULL);
+
+		contact = g_hash_table_lookup(data->contact_index, key);
+		g_free(key);
+
+		return contact;
+	}
+
+	for (l = data->contacts; l; l = l->next) {
 		struct contact_data *c_data = l->data;
 
 		if (contact_matches(c_data, id, datetime))
@@ -1235,6 +1197,7 @@ static void free_data_contacts(struct phonebook_data *data)
 
 	g_slist_free(data->contacts);
 	data->contacts = NULL;
+	g_clear_pointer(&data->contact_index, g_hash_table_destroy);
 }
 
 static void send_pull_part(struct phonebook_data *data,
@@ -1252,6 +1215,87 @@ static void send_pull_part(struct phonebook_data *data,
 	g_string_free(vcards, TRUE);
 }
 
+static void send_cache(struct phonebook_data *data)
+{
+	GSList *l;
+
+	for (l = data->contacts; l; l = l->next) {
+		struct contact_data *entry = l->data;
+		struct phonebook_contact *contact = entry->contact;
+		struct phonebook_field *number;
+		uint32_t handle;
+		char *name;
+		const char *tel;
+
+		number = contact->numbers ? contact->numbers->data : NULL;
+		tel = number ? number->text : "";
+
+		if (entry->name_present)
+			name = g_strdup_printf("%s;%s;%s;%s;%s",
+				contact->family ? contact->family : "",
+				contact->given ? contact->given : "",
+				contact->additional ? contact->additional : "",
+				contact->prefix ? contact->prefix : "",
+				contact->suffix ? contact->suffix : "");
+		else if (contact->fullname[0])
+			name = g_strdup(contact->fullname);
+		else if (contact->nickname[0])
+			name = g_strdup(contact->nickname);
+		else
+			name = g_strdup(tel);
+
+		handle = g_str_equal(entry->id, TRACKER_DEFAULT_CONTACT_ME) ?
+						0 : PHONEBOOK_INVALID_HANDLE;
+		data->entry_cb(entry->id, handle, name, "", tel,
+				phonebook_contact_get_mask(contact),
+				data->user_data);
+		g_free(name);
+	}
+
+	data->ready_cb(data->newmissedcalls, data->user_data);
+}
+
+static void send_selected_contacts(struct phonebook_data *data)
+{
+	const struct apparam_field *params = data->params;
+	unsigned int count = 0;
+	unsigned int offset = params->liststartoffset;
+	GSList *l;
+	GString *vcards;
+
+	vcards = g_string_new(NULL);
+
+	for (l = data->contacts; l; l = l->next) {
+		struct contact_data *entry = l->data;
+		uint64_t mask = phonebook_contact_get_mask(entry->contact);
+
+		if (!phonebook_selector_match(mask, params->selector,
+						params->selector_operator))
+			continue;
+
+		if (params->maxlistcount == 0) {
+			count++;
+			continue;
+		}
+
+		if (offset) {
+			offset--;
+			continue;
+		}
+
+		if (count == params->maxlistcount)
+			break;
+
+		phonebook_add_contact(vcards, entry->contact, params->filter,
+							params->format);
+		count++;
+	}
+
+	data->cb(vcards->str, vcards->len, count, data->newmissedcalls,
+						TRUE, data->user_data);
+	g_string_free(vcards, TRUE);
+}
+
 static int pull_contacts(const char **reply, int num_fields, void *user_data)
 {
 	struct phonebook_data *data = user_data;
@@ -1262,7 +1306,12 @@ static int pull_contacts(const char **reply, int num_fields, void *user_data)
 	gboolean cdata_present = FALSE, part_sent = FALSE;
 
 	if (num_fields < 0) {
-		data->cb(NULL, 0, num_fields, 0, TRUE, data->user_data);
+		if (data->request == PHONEBOOK_REQUEST_CACHE)
+			data->ready_cb(0, data->user_data);
+		else
+			data->cb(NULL, 0, num_fields, 0, TRUE,
+							data->user_data);
+
 		goto fail;
 	}
 
@@ -1274,7 +1323,7 @@ static int pull_contacts(const char **reply, int num_fields, void *user_data)
 
 	/* Trying to find contact in recently added contacts. It is needed for
 	 * contacts that have more than one telephone number filled */
-	contact = find_contact(data->contacts, reply[CONTACTS_ID_COL],
+	contact = find_contact(data, reply[CONTACTS_ID_COL],
 							reply[COL_DATE]);
 
 	/* If contact is already created then adding only new phone numbers */
@@ -1297,6 +1346,11 @@ static int pull_contacts(const char **reply, int num_fields, void *user_data)
 						TRACKER_DEFAULT_CONTACT_ME))
 		return 0;
 
+	/* All rows of a contact are merged before the selection. */
+	if (data->request == PHONEBOOK_REQUEST_CACHE ||
+			data->request == PHONEBOOK_REQUEST_SELECT)
+		goto add_entry;
+
 	if (g_strcmp0(data->last_id, reply[CONTACTS_ID_COL])) {
 		data->index++;
 		g_free(data->last_id);
@@ -1354,7 +1408,25 @@ add_numbers:
 		contact_data = g_new0(struct contact_data, 1);
 		contact_data->contact = contact;
 		contact_data->id = g_strdup(reply[CONTACTS_ID_COL]);
-		data->contacts = g_slist_append(data->contacts, contact_data);
+
+		for (i = COL_FAMILY_NAME; i <= COL_NAME_SUFFIX; i++) {
+			if (reply[i][0]) {
+				contact_data->name_present = TRUE;
+				break;
+			}
+		}
+
+		if (data->contact_index) {
+			char *key;
+
+			key = g_strconcat(reply[CONTACTS_ID_COL], "\n",
+							reply[COL_DATE], NULL);
+			g_hash_table_insert(data->contact_index, key, contact);
+			data->contacts = g_slist_prepend(data->contacts,
+							contact_data);
+		} else
+			data->contacts = g_slist_append(data->contacts,
+							contact_data);
 	}
 
 	if (part_sent)
@@ -1363,63 +1435,25 @@ add_numbers:
 	return 0;
 
 done:
+	if (data->contact_index)
+		data->contacts = g_slist_reverse(data->contacts);
+
 	/* Processing is end, this is definitely last part of transmission
 	 * (marking lastpart as TRUE) */
-	send_pull_part(data, params, TRUE);
-
-fail:
-	return -EINTR;
-	/*
-	 * phonebook_data is freed in phonebook_req_finalize. Useful in
-	 * cases when call is terminated.
-	 */
-}
-
-static int add_to_cache(const char **reply, int num_fields, void *user_data)
-{
-	struct phonebook_data *data = user_data;
-	char *formatted;
-	int i;
-
-	if (reply == NULL || num_fields < 0)
-		goto done;
-
-	/* the first element is the URI, always not empty */
-	for (i = 1; i < num_fields; i++) {
-		if (reply[i][0] != '\0')
-			break;
+	switch (data->request) {
+	case PHONEBOOK_REQUEST_CACHE:
+		send_cache(data);
+		break;
+	case PHONEBOOK_REQUEST_SELECT:
+		send_selected_contacts(data);
+		break;
+	case PHONEBOOK_REQUEST_PULL:
+	case PHONEBOOK_REQUEST_ENTRY:
+		send_pull_part(data, params, TRUE);
+		break;
 	}
 
-	if (i == num_fields &&
-			!g_str_equal(reply[0], TRACKER_DEFAULT_CONTACT_ME))
-		return 0;
-
-	if (i == 7)
-		formatted = g_strdup(reply[7]);
-	else if (i == 6)
-		formatted = g_strdup(reply[6]);
-	else
-		formatted = g_strdup_printf("%s;%s;%s;%s;%s",
-					reply[1], reply[2], reply[3], reply[4],
-					reply[5]);
-
-	/* The owner vCard must have the 0 handle */
-	if (strcmp(reply[0], TRACKER_DEFAULT_CONTACT_ME) == 0)
-		data->entry_cb(reply[0], 0, formatted, "",
-						reply[6], data->user_data);
-	else
-		data->entry_cb(reply[0], PHONEBOOK_INVALID_HANDLE, formatted,
-					"", reply[6], data->user_data);
-
-	g_free(formatted);
-
-	return 0;
-
-done:
-	if (num_fields <= 0)
-		data->ready_cb(num_fields < 0 ? 0 : data->newmissedcalls,
-							data->user_data);
-
+fail:
 	return -EINTR;
 	/*
 	 * phonebook_data is freed in phonebook_req_finalize. Useful in
@@ -1544,8 +1578,8 @@ static int pull_newmissedcalls(const char **reply, int num_fields,
 
 	if (data->request == PHONEBOOK_REQUEST_CACHE) {
 		query = folder2query(data->req_name);
-		col_amount = 8;
-		pull_cb = add_to_cache;
+		col_amount = PULL_QUERY_COL_AMOUNT;
+		pull_cb = pull_contacts;
 	} else if (data->request == PHONEBOOK_REQUEST_PULL &&
 					data->params->maxlistcount == 0) {
 		query = name2count_query(PB_CALLS_MISSED);
@@ -1599,12 +1633,18 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	DBG("name %s", name);
 
 	data = g_new0(struct phonebook_data, 1);
-	data->request = PHONEBOOK_REQUEST_PULL;
 	data->params = params;
 	data->user_data = user_data;
 	data->cb = cb;
 	data->req_name = g_strdup(name);
 
+	if (params->selector) {
+		data->request = PHONEBOOK_REQUEST_SELECT;
+		data->contact_index = g_hash_table_new_full(g_str_hash,
+						g_str_equal, g_free, NULL);
+	} else
+		data->request = PHONEBOOK_REQUEST_PULL;
+
 	if (err)
 		*err = 0;
 
@@ -1633,7 +1673,8 @@ int phonebook_pull_read(void *request)
 		query = NEW_MISSED_CALLS_COUNT_QUERY;
 		col_amount = COUNT_QUERY_COL_AMOUNT;
 		pull_cb = pull_newmissedcalls;
-	} else if (data->params->maxlistcount == 0) {
+	} else if (data->request == PHONEBOOK_REQUEST_PULL &&
+					data->params->maxlistcount == 0) {
 		query = name2count_query(data->req_name);
 		col_amount = COUNT_QUERY_COL_AMOUNT;
 		pull_cb = pull_contacts_size;
@@ -1715,6 +1756,8 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 
 	data = g_new0(struct phonebook_data, 1);
 	data->request = PHONEBOOK_REQUEST_CACHE;
+	data->contact_index = g_hash_table_new_full(g_str_hash,
+						g_str_equal, g_free, NULL);
 	data->entry_cb = entry_cb;
 	data->ready_cb = ready_cb;
 	data->user_data = user_data;
@@ -1725,7 +1768,8 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 					COUNT_QUERY_COL_AMOUNT,
 					pull_newmissedcalls, data);
 	else
-		ret = query_tracker(query, 8, add_to_cache, data);
+		ret = query_tracker(query, PULL_QUERY_COL_AMOUNT,
+							pull_contacts, data);
 
 	if (err)
 		*err = ret;
diff --git a/obexd/plugins/phonebook.h b/obexd/plugins/phonebook.h
index 1b5ced180..60aa433d2 100644
--- a/obexd/plugins/phonebook.h
+++ b/obexd/plugins/phonebook.h
@@ -55,6 +55,10 @@ struct apparam_field {
 	uint8_t order;
 	uint8_t searchattrib;
 	char *searchval;
+
+	/* vCard Selecting attributes */
+	uint64_t selector;
+	uint8_t selector_operator;
 };
 
 /* Metadata identifying the current database contents. */
@@ -75,15 +79,74 @@ typedef void (*phonebook_cb) (const char *buffer, size_t bufsize,
 /*
  * Interface between the PBAP core and backends to
  * append a new entry in the PBAP folder cache.
+ *
+ * mask is a bitmask of the vCard properties holding a value for this
+ * entry, using the bit assignment of the vCardSelector.
  */
 #define PHONEBOOK_INVALID_HANDLE 0xffffffff
 typedef void (*phonebook_entry_cb) (const char *id, uint32_t handle,
 					const char *name, const char *sound,
-					const char *tel, void *user_data);
+					const char *tel, uint64_t mask,
+					void *user_data);
 
 /* Notifies cache completion and the number of undismissed missed calls. */
 typedef void (*phonebook_cache_ready_cb) (uint8_t missed, void *user_data);
 
+/* vCardSelector property names, indexed by bit number. */
+static const char * const phonebook_selector_properties[] = {
+/* 0 */	"VERSION",
+	"FN",
+	"N",
+	"PHOTO",
+	"BDAY",
+	"ADR",
+	"LABEL",
+	"TEL",
+/* 8 */	"EMAIL",
+	"MAILER",
+	"TZ",
+	"GEO",
+	"TITLE",
+	"ROLE",
+	"LOGO",
+	"AGENT",
+/* 16 */	"ORG",
+	"NOTE",
+	"REV",
+	"SOUND",
+	"URL",
+	"UID",
+	"KEY",
+	"NICKNAME",
+/* 24 */	"CATEGORIES",
+	"PRODID",
+	"CLASS",
+	"SORT-STRING",
+/* 28 */	"X-IRMC-CALL-DATETIME",
+	"X-BT-SPEEDDIALKEY",
+	"X-BT-UCI",
+	"X-BT-UID"
+};
+
+/*
+ * A zero selector matches all entries. Bit 0 of the operator selects
+ * AND (1) or OR (0).
+ */
+static inline gboolean phonebook_selector_match(uint64_t mask,
+				uint64_t selector, uint8_t selector_operator)
+{
+	/* Ignore reserved property bits. */
+	selector &= ~(0x7fULL << 32);
+
+	if (!selector)
+		return TRUE;
+
+	if (selector_operator & 0x01)
+		return (mask & selector) == selector;
+
+	return (mask & selector) != 0;
+}
+
 
 /*
  * Set up and tear down the phonebook back-end. The back-end is shared by
diff --git a/obexd/plugins/vcard.c b/obexd/plugins/vcard.c
index 3827602cc..3f3f833dc 100644
--- a/obexd/plugins/vcard.c
+++ b/obexd/plugins/vcard.c
@@ -387,6 +387,75 @@ static gboolean contact_fields_present(struct phonebook_contact * contact)
 	return FALSE;
 }
 
+static gboolean field_values_present(GSList *fields)
+{
+	GSList *l;
+
+	for (l = fields; l; l = l->next) {
+		struct phonebook_field *field = l->data;
+
+		if (field->text && field->text[0])
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
+uint64_t phonebook_contact_get_mask(struct phonebook_contact *contact)
+{
+	const char * const values[] = {
+		[1] = contact->fullname,
+		[3] = contact->photo,
+		[4] = contact->birthday,
+		[12] = contact->title,
+		[13] = contact->role,
+		[16] = contact->company,
+		[21] = contact->uid,
+		[23] = contact->nickname,
+		[28] = contact->calltype != CALL_TYPE_NOT_A_CALL ?
+						contact->datetime : NULL,
+	};
+	uint64_t mask = FILTER_VERSION;
+	GSList *l;
+	unsigned int i;
+
+	for (i = 0; i < G_N_ELEMENTS(values); i++) {
+		if (values[i] && values[i][0])
+			mask |= 1ULL << i;
+	}
+
+	if (contact_fields_present(contact))
+		mask |= FILTER_N;
+
+	if (contact->department && contact->department[0])
+		mask |= FILTER_ORG;
+
+	if (field_values_present(contact->numbers))
+		mask |= FILTER_TEL;
+
+	if (field_values_present(contact->emails))
+		mask |= FILTER_EMAIL;
+
+	if (field_values_present(contact->urls))
+		mask |= FILTER_URL;
+
+	for (l = contact->addresses; l; l = l->next) {
+		struct phonebook_addr *addr = l->data;
+		GSList *field;
+
+		for (field = addr->fields; field; field = field->next) {
+			const char *value = field->data;
+
+			if (value && value[0]) {
+				mask |= FILTER_ADR;
+				break;
+			}
+		}
+	}
+
+	return mask;
+}
+
 static void vcard_printf_name(GString *vcards, uint8_t format,
 					struct phonebook_contact *contact)
 {
diff --git a/obexd/plugins/vcard.h b/obexd/plugins/vcard.h
index 880660ffa..29b82f5f8 100644
--- a/obexd/plugins/vcard.h
+++ b/obexd/plugins/vcard.h
@@ -63,6 +63,8 @@ struct phonebook_contact {
 void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 					uint64_t filter, uint8_t format);
 
+uint64_t phonebook_contact_get_mask(struct phonebook_contact *contact);
+
 void phonebook_contact_free(struct phonebook_contact *contact);
 
 void phonebook_addr_free(gpointer addr);
-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390280;
	b=jNnZb2CGjy9yywBuwMXKduskXs6G5YY9cDjAuC4u5HVIav5t1Hmwf/j1XBp+0jRV3wUH
	 g4ORIg9X7+jMiv8hLodF/q9FZkelzc/EzdMQ/YVEyKABC+pxQh0WPaYXw8nx7wvkGMd52
	 kd5S5tIGw9N3oJmYF5B9n/OJt3Ks8F+788n8R0Izy5z0nIb5Kmlya9upAUEZe3GnkRCmK
	 ygLLebHnCDjwOPGZV/9hH3JJ/7PN6dt+fxSjBWfO4oqLH8lGHt305pC2D6on213Y0L1h1
	 NAiLjE6vaT6FvtkxCbkvNukhEXpUnlTkHjYL0BttoAzOZQjKMb6eXPaak7qqdJpqSFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390280;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=WLfNYxPVlZQICPMAJKfJD0ISwIFspwrwyuxyFr693gw=;
	b=YJq6qiNXZMoJ24OWAmmkvfrOAoCPgPgBG8uA6x1e/iiRlpyfhRqhvyikvQgqIrP5OG54
	 brH7LXDuGL9JEWZ4KS7eH658gqvBgnelFAv9UWQPDm4f6dmknA8ULduO9EWhbHPWk2ZSx
	 hhuO3u+VPXV6F57y7PdybZqQ3jumTLcVwr9661yLENZPAS+IziDnpkcvObYe5bQeDaWQ5
	 WlgVUxZoTyC1OSMEhPWeHG3W2/TiZyJ2iy2BP65+ggVDQQYAooVAekvnYlrnCjbtivErT
	 HDemNzyUf59YOGiiCd8UDzutuygtxkLRJLiK0rTgPeGRhp2TYAT6hlfm9B0Dh7wFtAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ys6ZBELi;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFCF606A332
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CFCF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ys6ZBELi
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KkQP300848;
	Wed, 11 Nov 2026 09:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WLfNYxPVlZQ
	ICPMAJKfJD0ISwIFspwrwyuxyFr693gw=; b=Ys6ZBELiHDKHVIc+N331Q8Du8E6
	JdWP6uOzfRocKa7JcAxNNo90vOJq1lx1Aafa0Rki3RoLRxydvy6wFPG0FMq+NAeu
	PkN/hE7hEdMzfIVXkMxv0R2j38Uls2kbWlGaCyQJI2KlOWzCOm/3drZxANgLfAu1
	U9n/8mg6DHXGaAhDoc/xCZNvTuOJEa1asFgCquYeICkPVwYuEJTibiOqJXAr0I75
	bvbZFdTTsM6TFrR1FMwjnE5yHXPb31L3KmOIuiRgCsalISidivrOJq06gVo5QgBE
	N9zLzy85sLVOkJB28N/fWyyWg8vG9lxZsxDAiYfUKCTYdeaPTdqPNxItICA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5kmkh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:37 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iYln2424359;
	Wed, 11 Nov 2026 09:44:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AB9iZLT2424369
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 52A5A243CC; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 10/20] obexd/pbap: Add NewMissedCalls to vCard listing responses
Date: Wed, 11 Nov 2026 17:44:15 +0800
Message-Id: <20261111094425.1444893-11-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX0XVSWoTFNUFM
 cSdM3+I8lmeiZSgPm2nYab6UQaS6KtioG5OkdPWOaN3cO8jIl8FO2L/A+Awga1eVVDRVe8IzxMV
 7L66Jyk4hdRdwoyOOjpWvqOWep7qEiDKBGciY9Ould78AVXSeEmNtwqKjctNWWZg5+AD0B3MhQD
 +iDKTDp8sEIBP9i7/CATtIqSUvfYyEjrOL2pvnx7KB327kysubCGkJBEFhfhD5NYCfqI8q0fz9b
 VL+F8bJEX7dKSYNj2A4Z9h+1rOarwi4CIqI+k3HS3R7LdiEfZErRmcvMNiJfloy9TJspWMDBw4l
 DrtaKzrHDvw/TfkCML0SSFubIEwR1Nc4i/FgZmQTw6amcgPbmDrfQM822XNK3p+Pze+7sij+Jl/
 YNI4Hqp4oOCYrYCfsHEazxTyRmwWGlUzfSTnrTBC+7CvHLK3ZVVwZqnbKwegYqHURDOCer96IHM
 VYs5kA+WmmRUXGAtmmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX7A/mz24wTAsh
 v7itdCYDKvf4sR4py5m9jlFDMG9UBTtpfZYekpgaTLyI7GnvOpCfCU0F+lolXMOpXmW+LPkEZUL
 jyWuJVO0r7ixtkB/gK1unrKKTjr/7E8=
X-Proofpoint-ORIG-GUID: khQgScrDB-rmFNqaUhqd6_1lGVrtPc8I
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af43905 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=2PuV6dCUR46KBApHW4wA:9
X-Proofpoint-GUID: khQgScrDB-rmFNqaUhqd6_1lGVrtPc8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

Pass the missed call count from the backends to the PBAP core and
include NewMissedCalls in vCard listing responses.

Assisted-by: Claude:claude-sonnet-5-5
---
 obexd/plugins/pbap.c              | 14 ++++++----
 obexd/plugins/phonebook-dummy.c   | 10 ++++++-
 obexd/plugins/phonebook-ebook.c   |  2 +-
 obexd/plugins/phonebook-tracker.c | 44 +++++++++++++++++++++++++------
 obexd/plugins/phonebook.h         |  7 ++---
 5 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index e0d0cf1ab..02664e538 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -353,15 +353,16 @@ static GSList *sort_entries(GSList *l, uint8_t order, uint8_t search_attrib,
 	return sorted;
 }
 
-static int generate_response(void *user_data)
+static int generate_response(struct pbap_session *pbap, uint8_t missed)
 {
-	struct pbap_session *pbap = user_data;
 	GSList *sorted;
 	GSList *l;
 	uint16_t max = pbap->params->maxlistcount;
 
 	DBG("");
 
+	response_add_missed_calls(pbap, missed);
+
 	if (max == 0) {
 		/* Ignore all other parameter and return PhoneBookSize */
 		uint16_t size = g_slist_length(pbap->cache.entries);
@@ -401,10 +402,13 @@ static int generate_response(void *user_data)
 							VCARD_LISTING_END);
 	g_slist_free(sorted);
 
+	if (pbap->obj->apparam)
+		pbap->obj->firstpacket = TRUE;
+
 	return 0;
 }
 
-static void cache_ready_notify(void *user_data)
+static void cache_ready_notify(uint8_t missed, void *user_data)
 {
 	struct pbap_session *pbap = user_data;
 
@@ -415,11 +419,11 @@ static void cache_ready_notify(void *user_data)
 
 	pbap->cache.valid = TRUE;
 
-	generate_response(pbap);
+	generate_response(pbap, missed);
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
 
-static void cache_entry_done(void *user_data)
+static void cache_entry_done(uint8_t missed, void *user_data)
 {
 	struct pbap_session *pbap = user_data;
 	const char *id;
diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 6b91c199c..59fc77d6d 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -49,6 +49,7 @@ struct cache_query {
 	phonebook_cache_ready_cb ready_cb;
 	void *user_data;
 	DIR *dp;
+	uint8_t newmissedcalls;
 };
 
 static char *root_folder = NULL;
@@ -402,7 +403,7 @@ static gboolean create_cache(void *user_data)
 	 */
 	foreach_vcard(query->dp, entry_notify, 0, 0xffff, query, NULL);
 
-	query->ready_cb(query->user_data);
+	query->ready_cb(query->newmissedcalls, query->user_data);
 
 	return FALSE;
 }
@@ -674,6 +675,13 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	query->user_data = user_data;
 	query->dp = dp;
 
+	if (g_str_equal(name, PB_CALLS_MISSED_FOLDER)) {
+		foldername = g_build_filename(root_folder,
+						PB_CALLS_MISSED_FOLDER, NULL);
+		query->newmissedcalls = count_vcards(foldername);
+		g_free(foldername);
+	}
+
 	dummy = g_new0(struct dummy_data, 1);
 
 	dummy->id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, create_cache,
diff --git a/obexd/plugins/phonebook-ebook.c b/obexd/plugins/phonebook-ebook.c
index d8621b8f9..07bf98678 100644
--- a/obexd/plugins/phonebook-ebook.c
+++ b/obexd/plugins/phonebook-ebook.c
@@ -540,7 +540,7 @@ static void phonebook_create_cache_ready(GObject *source_object,
 
 done:
 	if (data->queued_calls == 0)
-		data->ready_cb(data->user_data);
+		data->ready_cb(0, data->user_data);
 
 	return;
 
diff --git a/obexd/plugins/phonebook-tracker.c b/obexd/plugins/phonebook-tracker.c
index 326bf8892..07d8dd34b 100644
--- a/obexd/plugins/phonebook-tracker.c
+++ b/obexd/plugins/phonebook-tracker.c
@@ -480,6 +480,12 @@ struct pending_reply {
 	int num_fields;
 };
 
+enum phonebook_request {
+	PHONEBOOK_REQUEST_PULL,
+	PHONEBOOK_REQUEST_ENTRY,
+	PHONEBOOK_REQUEST_CACHE,
+};
+
 struct contact_data {
 	char *id;
 	struct phonebook_contact *contact;
@@ -489,7 +495,7 @@ struct phonebook_data {
 	phonebook_cb cb;
 	void *user_data;
 	int index;
-	gboolean vcardentry;
+	enum phonebook_request request;
 	const struct apparam_field *params;
 	GSList *contacts;
 	phonebook_cache_ready_cb ready_cb;
@@ -1278,7 +1284,7 @@ static int pull_contacts(const char **reply, int num_fields, void *user_data)
 	}
 
 	/* We are doing a PullvCardEntry, no need for those checks */
-	if (data->vcardentry)
+	if (data->request == PHONEBOOK_REQUEST_ENTRY)
 		goto add_entry;
 
 	/* Last four fields are always present, ignoring them */
@@ -1411,7 +1417,8 @@ static int add_to_cache(const char **reply, int num_fields, void *user_data)
 
 done:
 	if (num_fields <= 0)
-		data->ready_cb(data->user_data);
+		data->ready_cb(num_fields < 0 ? 0 : data->newmissedcalls,
+							data->user_data);
 
 	return -EINTR;
 	/*
@@ -1517,7 +1524,11 @@ static int pull_newmissedcalls(const char **reply, int num_fields,
 	int nmissed;
 
 	if (num_fields < 0) {
-		data->cb(NULL, 0, num_fields, 0, TRUE, data->user_data);
+		if (data->request == PHONEBOOK_REQUEST_CACHE)
+			data->ready_cb(0, data->user_data);
+		else
+			data->cb(NULL, 0, num_fields, 0, TRUE,
+							data->user_data);
 
 		return -EINTR;
 	}
@@ -1531,7 +1542,12 @@ static int pull_newmissedcalls(const char **reply, int num_fields,
 		return 0;
 	}
 
-	if (data->params->maxlistcount == 0) {
+	if (data->request == PHONEBOOK_REQUEST_CACHE) {
+		query = folder2query(data->req_name);
+		col_amount = 8;
+		pull_cb = add_to_cache;
+	} else if (data->request == PHONEBOOK_REQUEST_PULL &&
+					data->params->maxlistcount == 0) {
 		query = name2count_query(PB_CALLS_MISSED);
 		col_amount = COUNT_QUERY_COL_AMOUNT;
 		pull_cb = pull_contacts_size;
@@ -1543,7 +1559,10 @@ static int pull_newmissedcalls(const char **reply, int num_fields,
 
 	err = query_tracker(query, col_amount, pull_cb, data);
 	if (err < 0) {
-		data->cb(NULL, 0, err, 0, TRUE, data->user_data);
+		if (data->request == PHONEBOOK_REQUEST_CACHE)
+			data->ready_cb(0, data->user_data);
+		else
+			data->cb(NULL, 0, err, 0, TRUE, data->user_data);
 
 		return -EINTR;
 	}
@@ -1580,6 +1599,7 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	DBG("name %s", name);
 
 	data = g_new0(struct phonebook_data, 1);
+	data->request = PHONEBOOK_REQUEST_PULL;
 	data->params = params;
 	data->user_data = user_data;
 	data->cb = cb;
@@ -1656,7 +1676,7 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	data->user_data = user_data;
 	data->params = params;
 	data->cb = cb;
-	data->vcardentry = TRUE;
+	data->request = PHONEBOOK_REQUEST_ENTRY;
 
 	if (g_str_has_prefix(id, CONTACT_ID_PREFIX) == TRUE ||
 				g_strcmp0(id, TRACKER_DEFAULT_CONTACT_ME) == 0)
@@ -1694,11 +1714,19 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	}
 
 	data = g_new0(struct phonebook_data, 1);
+	data->request = PHONEBOOK_REQUEST_CACHE;
 	data->entry_cb = entry_cb;
 	data->ready_cb = ready_cb;
 	data->user_data = user_data;
+	data->req_name = g_strdup(name);
+
+	if (g_str_equal(name, PB_CALLS_MISSED_FOLDER))
+		ret = query_tracker(NEW_MISSED_CALLS_COUNT_QUERY,
+					COUNT_QUERY_COL_AMOUNT,
+					pull_newmissedcalls, data);
+	else
+		ret = query_tracker(query, 8, add_to_cache, data);
 
-	ret = query_tracker(query, 8, add_to_cache, data);
 	if (err)
 		*err = ret;
 
diff --git a/obexd/plugins/phonebook.h b/obexd/plugins/phonebook.h
index 7e99de6e7..9ab5b72f6 100644
--- a/obexd/plugins/phonebook.h
+++ b/obexd/plugins/phonebook.h
@@ -72,11 +72,8 @@ typedef void (*phonebook_entry_cb) (const char *id, uint32_t handle,
 					const char *name, const char *sound,
 					const char *tel, void *user_data);
 
-/*
- * After notify all entries to PBAP core, the backend
- * needs to notify that the operation has finished.
- */
-typedef void (*phonebook_cache_ready_cb) (void *user_data);
+/* Notifies cache completion and the number of undismissed missed calls. */
+typedef void (*phonebook_cache_ready_cb) (uint8_t missed, void *user_data);
 
 
 /*
-- 
2.34.1


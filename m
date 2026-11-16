Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820021;
	b=yzs8i1ZNmc6ETEoZr46IC+1ffyl+Z7uqWv4PpXr9iCRIpfNLvAdcHhplOG4Tmem8GEdt
	 qP3E0sf/W2HU35xoaDcrpr3XCfw1jLQXjcBcJeazXiKHPaxZK8FJq3jNi1GUFJphdSo/a
	 P8q3siTAABLVHE+XiQCr5k/saS6OIrPZtv7w0VoM9Lr7V94azDVh33zna8VulL5VE/z/A
	 C3NCv27ysVeuu7twxJnTvWTfWN+bNAdm1XC5uC9R+oE3Yz2ijjkhnVdGNVz77kxpuVEV4
	 lLcpYwIkcUl4G4VvndjUb6NIGUqDxZpvXMH0bBineF59CbShOAzvy43rsszIf9ETWaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820021;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bjnNCfbUAlQYYNqKqqCUirxgitLCE3hVy+TBI9l46C4=;
	b=Rx7HvszuT1PGZexAKXUJ0ymoqMVYpiStBxobshJ163Dx0ckQDrjJyn5jE01obErqIjiG
	 OMYkgFif71vXe3o52o8d7XV20gCbB0cbxSTNaZp09XqH5Zhb4UG5jzJTPXzbPXtekPIi3
	 yoYFSAml0h8Hn4jEnO1VXkvDAP6ektQyUy5cvbJD1gsP0gwtSrgdvRaG4EJ7PCersRKws
	 +QwSUGTo25N1DWP6cPqGGBNssXJQqi2iU8NzgPVUP/KXqD7kIy+qXTpfID0HqI5jtcyFz
	 IsgjieuuhYpD10BG8OCLjmasnZ5sWILZMyl4DV6fH5qj+hZ8ChZyZYDW7g7QGoUKSFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TFYXdsd0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C598606A899
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C598606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TFYXdsd0
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7f3R91633229;
	Mon, 16 Nov 2026 09:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bjnNCfbUAlQ
	YYNqKqqCUirxgitLCE3hVy+TBI9l46C4=; b=TFYXdsd0972qfccmdnpx/6uOJUq
	ZUKJNzB88rB5aUrTmtDEMurF+Wy0yuzw8nVqEnmtUK/t1ngHRROn7/zn3y/NKUVG
	WiDWHvsFmKImjkpHtVSpGjk+5WR+V5BbRKy6385hcp5bnx72MfaVQPpYJF2XMRqn
	S5eIsFIdvD8fB45kzoWyTE/LlD48nMtgcxma85CL8iKRk+igf7ZHRFdj7E1Mx/BK
	JBA7rztRFrsTlRgnq6dg3V1XEc9UykRpAbnj5a6Pq0TseGprL7lyg2bu8h7oNxLi
	smlVHYwJ52q0e34vracKotHv70CJVQw516PQuBxRk0x6uv5SU7tfjHTjHBw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmanmxu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:58 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96uAf2942817;
	Mon, 16 Nov 2026 09:06:56 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AG96t202942782
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:55 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id A791627A05; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v3 10/20] obexd/pbap: Add NewMissedCalls to vCard listing responses
Date: Mon, 16 Nov 2026 17:06:24 +0800
Message-Id: <20261116090634.1222593-11-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Tc7GB4YT8Ys6D0LX-wTLl8R7J99_0ADL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX/tBpvowZSLBp
 lo9llGU5LA1mdpaBoLWn4GRACCGSw1PLlSt738uwGAUXfbnxLnyS01/vipp8uFFE9v3RJSrKoPs
 HKXKuKlK7onR4DfXQHmU/5SCWO4JuBo7ZwamW/0e4NmnkEGPVdCIUZJ8/GEvK5NrMAT8vOYOLAa
 felphkVJwbi35xY68qV0N78E8pW2iqaK6KGIijle9iJSeCXfrYGGR1zw5odUFNnh0D3aztlBgZO
 QQ5HH+pKENSBWTM+jHfhzRAx1ATWFkn9PZK47Pkv7DBCJSZTDBVoMDngwZPBD1YHnjIp4SVo0b6
 BX+016I6PUf2xntykVjAUCtjIUlog5gskasoStt7ue4HC/E4qA81s63uMqaxSpdC0dIDF9dVLGl
 QwlW710lks31C9EHjeOTq70Ao5IjOMcZqmOI4wJ6nuqjgQIxdid/+TI5OL5a3TRGvgOambLOrgE
 nRMdd1D5MvzNWlRhLCA==
X-Authority-Analysis: v=2.4 cv=NdhzRGD4 c=1 sm=1 tr=0 ts=6afac7b2 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=2PuV6dCUR46KBApHW4wA:9
X-Proofpoint-GUID: Tc7GB4YT8Ys6D0LX-wTLl8R7J99_0ADL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX3HAUUTPT4/1A
 mFj5nXI1mHZcTwQjfANm/4gdmsLm1LmJvAp1l1Q1KrV+nYRIVrbdJ8O8rVg0rJwuA5ikS/nUWYb
 V68iH724c68Tgvs8ioHT98HJe3UTgRI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

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
index c4598fa10..cd520d445 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -49,6 +49,7 @@ struct cache_query {
 	phonebook_cache_ready_cb ready_cb;
 	void *user_data;
 	DIR *dp;
+	uint8_t newmissedcalls;
 };
 
 static char *root_folder = NULL;
@@ -545,7 +546,7 @@ static gboolean create_cache(void *user_data)
 	 */
 	foreach_vcard(query->dp, entry_notify, 0, 0xffff, query, NULL);
 
-	query->ready_cb(query->user_data);
+	query->ready_cb(query->newmissedcalls, query->user_data);
 
 	return FALSE;
 }
@@ -817,6 +818,13 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
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


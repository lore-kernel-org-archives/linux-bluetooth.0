Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76DC388E7A
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292088; cv=none; b=YpgdRGk1bKvh6fVHaoh6r1TVtf8CySTehqpFRSmH9iSUg25mQugBAf5SfshT1ysUWk6fAow6Tb7X13xd7tyidZyii4lDs/EXRyv5n/j/ZyShDH0HcXQC6O31GUfoGWjcXXthocbLLZ0HHh4m2XX9H//0nocWrs6+TQCDTXGYNV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292088; c=relaxed/simple;
	bh=pDFCcLBAXfww7SNmgLaUb/Nu6khs2x6j9zuJt2EH/Ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDzX91wIX2RQJXWgM0mroZQcCDuOX+RR7u0jlMdTHEc5SZsHdI7e13xESzpy4akshrhj1U8nEdn4eyCWjxScXiegQT8f3F2io50jrlXqifREdOw6uMMA0m6/FelTtKmQv3ASKQWV9bwBCyQ6L0JzV6vcMiXBzqEdbxuVXZjHxZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4m1tUol; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UwytZA03; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4m1tUol";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UwytZA03"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCTVS01590166
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 12:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f7P7IxpT1WeEFpXd5WuldKCUK95xsjIfk0Q0DWOuQaQ=; b=g4m1tUoljCRBCPQo
	Ygrv5SwxKHLUsknL0j+nl3WpdazbYgk5qikBEnqs+18lDmG2tH/HgrrmMywcna/k
	25RmF7r6Ise5EqwjO4JG7P4nE3n7MhvLz+YtvtiYSm0fb2WrUger9HCrZRtY+nK8
	XxViRPMTAinEFYyY7B9qHJnDOq01rFuTb5FTaPcyjw9BL+DZN48Oz0ydE1AJX3vz
	iLnGNxsNd/jQf+HZX4wKhkbUlS1rnfRsEBghy22/m+uRrES4OvsPEgajtdy8tsoV
	CIm6Nuts5/7A3DyhOsoMRAaPPbVjUxgsojKPhfs/a0C/9JNXfWtuk7Lkz0EZhjGN
	PoOafg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u8kqea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 12:41:26 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8895156101so9030662a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784292085; x=1784896885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f7P7IxpT1WeEFpXd5WuldKCUK95xsjIfk0Q0DWOuQaQ=;
        b=UwytZA03/o45Sw5wR8mwQUdOeHjGEU8FVPJUU5k9Tob+/EYsWJyLKcqUXa0V8z/gEh
         B/W3VTjunQUQ9J3qazDhaYo2HeTMgxqnLbz56nl0pZattieNy+qTsbnzGHMuBK9gxNTp
         CpZ3COgesFsELDhCuQB0nRPEdSMT8BJq+cH56tLb8Yd4WSU6z1jK9XcKUh+e1i2F7bI7
         O2Mpe0jTVGMtu/SAFSziL0qjWuH9Ykc62y4r3HWXejW3ok5QyZhGm6lOsEl3cSndEM/D
         depoxGCwgqnnpxcsiSB83QFHdg9puisgQnNC46O10qDt3wxndfopEGLj2O15Om1gdgkA
         occQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784292085; x=1784896885;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7P7IxpT1WeEFpXd5WuldKCUK95xsjIfk0Q0DWOuQaQ=;
        b=AVISGdUTtftR7uDJ23MrW76La+ILKvjbVfOkNEHDE1QAyaW4kMzmNF6vDSX9uuy9+i
         ZeHNvELevWqW4v56Z2qZ6qLMxj34VV7bZ3IEda06Ha5uB5xm3J9KI0+uQlF22E/1kdE5
         TpICyYSVX/n7mEDHQN6J8spiTZJjK5iejinEfdb/uivgO+AZ5J7DWkTh0eKHaCFqPCWU
         sEU9usPT1zfh7VGOl4e1ko2b8POJfQ3ub14AGvDqpYx7B+6O+w3MP09Izli0JP9oTDLl
         XLM3Hmb1BKBrTT4a7N21k1eQvgHPvxoa/T7zID8lUyWC/G0mckHaYuv8zVSBpRS1jfmt
         DPXA==
X-Gm-Message-State: AOJu0YzDHFGyhaG0XoTWdvoB1uhK4XAuypg2zuetgA2AgG4d3m7dmhxk
	9GTJfNDW9i+TkBXJdhE6zbC2enShkURrMq62IJT5zpTzd9LH/YdkaSwdggQhKczq4Y1D3EERQZT
	lOiwZiqDBRGLW/w9PldY5Q/HUA7+zlzF8JJCIoCiwkz69VC6JNKh5KoIdINUqjCVIfoc3jaC1TQ
	hLfmg=
X-Gm-Gg: AfdE7clAWmOt3KJCQGcabGSBxxj8ByTIgtRQt2TAc6DYlHtCyaiU0Z7ZGOp+BICW/av
	nMrbAdjuBcxFFdPs2UiD7rCdHPOJOvyn+wurPD46g4Kacgjb/lRJkwDyZAKfxngO85jze2VRwY9
	i2bEYX7r4PZhxUDkvfTTqo5pzjKdToSWsthhacPRlh9xtAFd9jnG1tEoPfGt6gGZ+Uc644Q1xKt
	fbbia2LVGF+W2ATyQuz/jZFVUIPw7CziEvLdyaeNrxO0xIpdcvMWZ2KODjB0xDbjO44Cf/uY7Y5
	0GIWfa0x3xoW++CswDPoiHiUdYqEPlzJUVNzmntFXC6jELAuvF3HxixO6mu7QoDAvU+KQhZ1Lbh
	1fiInqdMmXM498igqi521tgThWdm3MQ==
X-Received: by 2002:a05:6300:95:b0:3ba:cd5b:3dc8 with SMTP id adf61e73a8af0-3c3ad7a31eemr2811974637.31.1784292085238;
        Fri, 17 Jul 2026 05:41:25 -0700 (PDT)
X-Received: by 2002:a05:6300:95:b0:3ba:cd5b:3dc8 with SMTP id adf61e73a8af0-3c3ad7a31eemr2811931637.31.1784292084759;
        Fri, 17 Jul 2026 05:41:24 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cd6e6esm5262562c88.13.2026.07.17.05.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 05:41:24 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 1/2] rap: Add RAS attribute access notification API
Date: Fri, 17 Jul 2026 18:11:10 +0530
Message-Id: <20260717124111.3296537-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717124111.3296537-1-naga.akella@oss.qualcomm.com>
References: <20260717124111.3296537-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FgJRwvosAFkMPRU1x1skRsLWBeiYxEWK
X-Proofpoint-ORIG-GUID: FgJRwvosAFkMPRU1x1skRsLWBeiYxEWK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEyOSBTYWx0ZWRfX4qWdKIIZOGNz
 IduVXq1HXKLkkmodq78Sx6KYhJAct11Vyc4dJzgG0prQ7Lj50wsr8WltqrSC2Z+1UWibHcz77Vx
 BMZxaz9KoiCrxdt91sPx4ukdKNkG/8o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEyOSBTYWx0ZWRfX+51xAIP7uWLQ
 T9wxlN2uY+xa/4ucG7I7raCkB+uUk7U89FczZuo+dWflA5IdkCzQjzMGMFqCdl3H7WdyDnNU6rs
 AWry8DnsinkRdFxiKNQBT4/kPcjvK7YUOP2jsiIZSnbLfH7gJ+UMQRUAzqIHA79n0kSby8dDA01
 9bCq8NdpBOUyN1IA7wfN5bSSDUI9MhH4iu6BWDLNTIIK9GfxI6YBR5e+do+mMMJSMl7UnbCSGoT
 gyhD6CtqgS4peMxoK6enu3Ih2lzMYgWCij9Xe78GiMjM9pHk7Kd+2xHmnsPBBpWcmB7dmcIWx5K
 DG+99v4krw3bnFrBNNf9ZNH617G6yGZgi++ahfxWGE4emXqAA9WqXBwqr0YMifmYwaaosKaz83S
 erElzwiGLUWl8JZ50r9wWd9U55OUTSNpjiV6QfmkD36Kto61zTIuDy/qXAiUnnQ3o5hfD1TWYVp
 l7qTFfewIgRaduCB3oA==
X-Authority-Analysis: v=2.4 cv=TL11jVla c=1 sm=1 tr=0 ts=6a5a22f6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=E4wFjaGSyFRzaZU7REwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170129

Add a callback registration mechanism to notify bt_rap consumers
when a remote peer accesses or discovers a RAS GATT attribute.
Introduce register/unregister APIs and invoke callbacks asynchronously
from all relevant RAS characteristic read/write handlers,
following the existing bt_rap_register() pattern to avoid
reentrancy into device/profile/D-Bus logic.
---
 src/shared/rap.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/rap.h |  6 +++
 2 files changed, 104 insertions(+)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index dfb272d3a..567abdb75 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -306,6 +306,7 @@ struct bt_rap {
 
 static struct queue *rap_db;
 static struct queue *bt_rap_cbs;
+static struct queue *bt_rap_accessed_cbs;
 static struct queue *sessions;
 
 struct bt_rap_cb {
@@ -315,6 +316,12 @@ struct bt_rap_cb {
 	void *user_data;
 };
 
+struct bt_rap_accessed_cb {
+	unsigned int id;
+	bt_rap_accessed_func_t func;
+	void *user_data;
+};
+
 struct bt_rap_ready {
 	unsigned int id;
 	bt_rap_ready_func_t func;
@@ -724,6 +731,42 @@ static void cs_tracker_init(struct cstracker *t)
 	t->segment_data.iov_len = 0;
 }
 
+static bool notify_ras_accessed_idle(void *user_data)
+{
+	struct bt_att *att = user_data;
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(bt_rap_accessed_cbs); entry;
+	     entry = entry->next) {
+		struct bt_rap_accessed_cb *cb = entry->data;
+
+		cb->func(att, cb->user_data);
+	}
+
+	return false;
+}
+
+static void notify_ras_accessed_destroy(void *user_data)
+{
+	struct bt_att *att = user_data;
+
+	bt_att_unref(att);
+}
+
+/*
+ * Notify that the remote side has discovered/accessed a RAS attribute.
+ * Deferred to idle so it does not reenter device/profile logic from within
+ * the gatt-server's request-dispatch stack.
+ */
+static void notify_ras_accessed(struct bt_att *att)
+{
+	if (!att || !bt_rap_accessed_cbs || queue_isempty(bt_rap_accessed_cbs))
+		return;
+
+	timeout_add(0, notify_ras_accessed_idle, bt_att_ref(att),
+					notify_ras_accessed_destroy);
+}
+
 static void ras_features_read_cb(struct gatt_db_attribute *attrib,
 				 unsigned int id, uint16_t offset,
 				 uint8_t opcode, struct bt_att *att,
@@ -737,6 +780,8 @@ static void ras_features_read_cb(struct gatt_db_attribute *attrib,
 	 */
 	uint8_t value[4] = { 0x01, 0x00, 0x00, 0x00 };
 
+	notify_ras_accessed(att);
+
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
 
@@ -745,6 +790,8 @@ static void ras_ondemand_read_cb(struct gatt_db_attribute *attrib,
 				 uint8_t opcode, struct bt_att *att,
 				 void *user_data)
 {
+	notify_ras_accessed(att);
+
 	/* No static read data – on‑demand data is pushed via
 	 * notifications
 	 */
@@ -761,6 +808,8 @@ static void ras_control_point_write_cb(struct gatt_db_attribute *attrib,
 				       uint8_t opcode, struct bt_att *att,
 				       void *user_data)
 {
+	notify_ras_accessed(att);
+
 	/* Control point handler - implementation TBD */
 }
 
@@ -773,6 +822,8 @@ static void ras_data_ready_read_cb(struct gatt_db_attribute *attrib,
 	uint16_t counter = 0;
 	uint8_t value[2];
 
+	notify_ras_accessed(att);
+
 	put_le16(counter, value);
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
@@ -785,6 +836,8 @@ static void ras_data_overwritten_read_cb(struct gatt_db_attribute *attrib,
 {
 	uint8_t value[2] = { 0x00, 0x00 };
 
+	notify_ras_accessed(att);
+
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
 
@@ -800,6 +853,7 @@ static void ras_ranging_data_ccc_write_cb(struct gatt_db_attribute *attrib,
 	uint16_t *this_ccc;
 	uint16_t *other_ccc;
 
+	notify_ras_accessed(att);
 	if (!ras) {
 		gatt_db_attribute_write_result(attrib, id,
 					BT_ATT_ERROR_UNLIKELY);
@@ -1052,6 +1106,50 @@ bool bt_rap_unregister(unsigned int id)
 	return true;
 }
 
+unsigned int bt_rap_ras_accessed_register(bt_rap_accessed_func_t func,
+							void *user_data)
+{
+	struct bt_rap_accessed_cb *cb;
+	static unsigned int id;
+
+	if (!func)
+		return 0;
+
+	if (!bt_rap_accessed_cbs)
+		bt_rap_accessed_cbs = queue_new();
+
+	cb = new0(struct bt_rap_accessed_cb, 1);
+	cb->id = ++id ? id : ++id;
+	cb->func = func;
+	cb->user_data = user_data;
+
+	queue_push_tail(bt_rap_accessed_cbs, cb);
+
+	return cb->id;
+}
+
+static bool match_accessed_id(const void *data, const void *match_data)
+{
+	const struct bt_rap_accessed_cb *cb = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return cb->id == id;
+}
+
+bool bt_rap_ras_accessed_unregister(unsigned int id)
+{
+	struct bt_rap_accessed_cb *cb;
+
+	cb = queue_remove_if(bt_rap_accessed_cbs, match_accessed_id,
+							UINT_TO_PTR(id));
+	if (!cb)
+		return false;
+
+	free(cb);
+
+	return true;
+}
+
 static inline size_t serialize_segmentation_header(
 				const struct segmentation_header *s,
 				uint8_t *out, size_t out_len)
diff --git a/src/shared/rap.h b/src/shared/rap.h
index 5582635e6..a78e9a5c6 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -15,6 +15,7 @@
 struct bt_rap;
 struct gatt_db;
 struct bt_gatt_client;
+struct bt_att;
 
 /* Channel Sounding Events */
 struct bt_rap_hci_cs_options {
@@ -161,6 +162,7 @@ typedef void (*bt_rap_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_rap_ready_func_t)(struct bt_rap *rap, void *user_data);
 typedef void (*bt_rap_destroy_func_t)(void *user_data);
 typedef void (*bt_rap_func_t)(struct bt_rap *rap, void *user_data);
+typedef void (*bt_rap_accessed_func_t)(struct bt_att *att, void *user_data);
 
 struct bt_rap *bt_rap_ref(struct bt_rap *rap);
 void bt_rap_unref(struct bt_rap *rap);
@@ -187,6 +189,10 @@ bool bt_rap_ready_unregister(struct bt_rap *rap, unsigned int id);
 
 bool bt_rap_unregister(unsigned int id);
 
+unsigned int bt_rap_ras_accessed_register(bt_rap_accessed_func_t func,
+							void *user_data);
+bool bt_rap_ras_accessed_unregister(unsigned int id);
+
 struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb);
 
 bool bt_rap_set_cs_config_params(void *hci_sm,
-- 


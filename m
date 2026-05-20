Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9A833A6F2
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294648; cv=none; b=WA6DBjisNNIprzQILQlfNprNjQJeSbHGn+sj7c3or0OETEcp/z5PSZv1g63PLkO5wZshNNOwPa+yEFLZcI3ux2LshKGX632q71AUEcAWADKWR9os8QHdcOWxK1BOpgcXxoER0jvMFHKGkP62XtE2VzTkjpQVAQNOZfq4Yp9acsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294648; c=relaxed/simple;
	bh=4FtqF+iSo1Ve8V3mBk//VVGlqH3p/s+AG8ffB61ovmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mtah5ymknq6HB717pBipQPI57mPdjhDXvnx/GK5mJ2echHz9MdIHKE7rSMnZGNFbyi++HFlEzhKEnjZVVtGIWnKT/w72ntIUFaLm9JEl+EkWkvGoZp1faJxVICw6IVBYFJYRmOr5OIbWuB4m+R376IdAlmiHK02mXQ0o8oAt0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I9t4yzm1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R4Z1OT0/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I9t4yzm1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R4Z1OT0/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KBZRkM3084892
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 16:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IKUOL9+iDGYdRFTCTEqNWT98a4fcLsiZC3Y
	y+Km5iOM=; b=I9t4yzm1NvEdpjF9TINcg07iBi3mDovQPRNN/4ZXeRnuO8sDYxj
	DTOuvXIv6TFWMw88swHphUaVSe98s/1A/7XaLilMkedeCNeur2oVAzNXuYLd5ux3
	U2+LdEAIWR3wdjDk0lJdqBLhw1o3TxZp2nAfJOHeHR587lmVyWR5tdPu7kIbwOC1
	EKbZmkaK8uX4uEjZGtZd3N+87jfGLKN5b2FThGvwB9lnGSG0V0Sp4ET3Zj5XkBlX
	XjFslB1Zun3TCFPRmxYBNluoc6d7YSRsPhvud9qC0aWmGqnx6H1qopIGvmSVKi6u
	dvLfKeu67476KZckpKkinH1rKYoE6EbqZ1g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9c7f1605-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 16:30:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2baf7378ad0so53534675ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779294643; x=1779899443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKUOL9+iDGYdRFTCTEqNWT98a4fcLsiZC3Yy+Km5iOM=;
        b=R4Z1OT0/8KSsksieYi9YJ6LFajQ8FtwOUYoyT9kkqlUBKxKMJXETAx25lKxF70mzjF
         VlFSu2a7qdyWDSRz1aRXEhxgUO8aV2Y7mHeumyx9+mlxMxD6Em2BV4IDu7fJbmFCQVR8
         jTM+5lpTmyV/E39unXsjIcL7wGjQwbdDPOoMYGebCUo4QUN4CuGXKCF5xgKZl8vVBkD1
         q7rttI4jMOeqFy1gc6MMegE5XbyY18ddQpiTT+Mi7OUJJAD/P/ZNTmZ5eknfyoDgk8yJ
         O7fDOKiwUE68Qm1yudSLefwlk7JpT6hizpLAPKaOz1mxZGCVhDNFE8MUx658l/GqoWpn
         LygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779294643; x=1779899443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKUOL9+iDGYdRFTCTEqNWT98a4fcLsiZC3Yy+Km5iOM=;
        b=h0u3q0YJiyULxtkZWJvMI6aQuSwpWJVEG9lBu2mU1fqft+CsFpDDq7zNGKgUmKeO5K
         9Qza59Qeaa4BNJuJVRAcGbLfthEmbpy9cFz0tCx6Mo1JOxXB68uE3uy9PO4hQ84DDP8D
         hLyzOwutjsPd0OeR6i1+Z4wScUVjrvm4dijaDSZ+IK/cq50r0f8N9PcJQRDgxaiN9bR5
         1TowFQT7uXqTl3Gjy4SLFsTh2eZvneDBJwaO9rN97lDH7tsXC0XOc755lqIzO8L2d8QL
         tXF/uO/tjjaT+gSfypqGrlwugF39lBC9IV/+8j45kjiJFj7NaitWBGlvGoZaIF62PUnS
         vGnQ==
X-Gm-Message-State: AOJu0YxsAuxbEkIcg2bYC7FDgF1ApvJciAYeaWta4ExU0BnDzpvhrzdY
	RDIOg9Rqg5CQ3ocs43TMCYGn2DuQeR87NRkzPFX0g0q3S4dBkMqVw3qkNQuqoMxRUZNgFaOoLlG
	6nObNgT4hjcTKTwJ2GR/n2ZAlYszxceGIBh4BOeXhaXaW5PQyIWEa4CCMGGyQv66GvSOlISmkSk
	y48hQ=
X-Gm-Gg: Acq92OFUX3BIXRzW2P1IDBmaRCX9SWfIucolVu+y6K6b4XetRFydqs6iagqrhT4FMvh
	4ugdg7zZfv3BBbdeyrokWfXUYOcu6W7O4XYripnWpXsIq6r/OXWi7oK89uJIJmHIC0NfplWizMw
	k6lvXT2NeZ5jvuZdxYn/rXbkdWxMcvhlqjLR8M+iOQpMLgEiPkwx0OHz3pMzFkpZDIejPApfvmx
	xyiYXiexI8dBI8+3MQowZYnOkYsYJDnxKoZxHxLet9NxnY6z8r8fqsqoqX4PMYR3iOYvv+bJV9M
	4kiVikRDpRalav5vMVxjUVVQE24Q4Lr2mRkVHDAw1mX8aIx9CGydpSD8FjWp/2DAHU4YJkDQ0a0
	7XnRbLg8V4CMaJTRdyS36BsOgFAYr6IBpxJwWUQP3QU4=
X-Received: by 2002:a17:903:388d:b0:2ba:3e50:e3f5 with SMTP id d9443c01a7336-2bd7e9769e2mr258288295ad.30.1779294642488;
        Wed, 20 May 2026 09:30:42 -0700 (PDT)
X-Received: by 2002:a17:903:388d:b0:2ba:3e50:e3f5 with SMTP id d9443c01a7336-2bd7e9769e2mr258287495ad.30.1779294641662;
        Wed, 20 May 2026 09:30:41 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe47bdsm230625995ad.44.2026.05.20.09.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:30:41 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v1] shared/rap: Add client real-time ranging registration and notification parsing
Date: Wed, 20 May 2026 22:00:37 +0530
Message-Id: <20260520163037.1823823-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a0de1b4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=oTFAAGwM8NcFQErM5UMA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: QVJYLv-19RI2U3pTo3LMU4rippTYfddK
X-Proofpoint-ORIG-GUID: QVJYLv-19RI2U3pTo3LMU4rippTYfddK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE2MCBTYWx0ZWRfX1cnkXwkSWxk3
 KiU+GULaMA4QOcrWhAPIxUDEoLIUWPTivb1PNOd4h2jTfCos6MBWM4PZTSBxDDQmVV3z2Rs9p+k
 lQ/DZjlOhuMkxLpMEQ9drAMhl3fTWyiZ+n/CSl2XzNNDAnLP9rhOZT3+7MPQOLTAjN0S6S7d3DJ
 RiGNyLf3aBTw7mihwzsL3QNXHj5ldKZSq08dGMvNPvopchC/0pE0bBRT/nbgOjRstBtC9ctpGkS
 lpKyGXeexC4fg2WdDVxcbHl25C8gJcbXFDr7KImZXC+/a79UjejT08t1TDIr33FNzShR7geRv5K
 8M+O1KynijOM4eO9/qyYT7WUsC8rqrNi81WhgHydbcqkOmJVPgu1A8lyZ2tLDTjRydynkqbzffk
 t3NlSiKbWbgXiMZnxTzr5GPTOJs5x5gnNT2RJ96s3GvtO3pQooZWMWecpLAjenWt5MCf2IH3TUm
 XsCpC84XOhfWDb7FCvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200160

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Read the RAS Features characteristic to determine whether the remote
device supports real-time ranging. If supported, register for real-time
characteristic notifications using the reqtracker for the CS initiator
role.

Parse incoming segmented RAS ranging data notifications by accumulating
segments via iovec and parsing complete subevent headers and CS mode 0-3
step data, including IQ/tone PCT samples, once the last segment arrives.
---
 src/shared/rap.c | 967 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 965 insertions(+), 2 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index 145da2060..eabc6d543 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -29,6 +29,9 @@
 #define DBG(_rap, fmt, ...) \
 	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ##__VA_ARGS__)
 
+#define SIGN_EXTEND_TO_16(val, bits) \
+	((int16_t)(((val) ^ (1U << ((bits)-1))) - (1U << ((bits)-1))))
+
 #define RAS_UUID16			0x185B
 
 /* Total number of attribute handles reserved for the RAS service */
@@ -43,6 +46,11 @@
 #define RAS_STEP_ABORTED_BIT   0x80/* set step aborted */
 #define RAS_SUBEVENT_HEADER_SIZE 8
 
+#define CS_MODE_ZERO_WIRE_INIT_SIZE 7
+#define CS_MODE_ZERO_WIRE_REF_SIZE 3
+#define CS_MODE_ONE_WIRE_SIZE_MIN 6
+#define CS_MODE_ONE_WIRE_SIZE_MAX 12
+
 enum pct_format {
 	IQ = 0,
 	PHASE = 1,
@@ -134,6 +142,28 @@ static inline void ranging_header_set_pct_format(struct ranging_header *hdr,
 				((format & 0x03) << 6);
 }
 
+static inline uint8_t ranging_header_get_antenna_mask(
+					const struct ranging_header *hdr)
+{
+	if (!hdr)
+		return 0;
+
+	return hdr->antenna_pct & 0x0F;
+}
+
+static inline uint8_t antenna_mask_count_paths(uint8_t antenna_mask)
+{
+	uint8_t count = 0;
+	uint8_t i;
+
+	for (i = 0; i < 4; i++) {
+		if (antenna_mask & (1u << i))
+			count++;
+	}
+
+	return count;
+}
+
 struct ras_subevent_header {
 	uint16_t start_acl_conn_event;
 	uint16_t frequency_compensation;
@@ -149,9 +179,21 @@ struct ras_subevent_header {
 #define RAS_DONE_STATUS_PACK(ranging, subevent) \
 	((uint8_t)(((ranging) & 0x0F) | (((subevent) & 0x0F) << 4)))
 
+#define RAS_DONE_STATUS_UNPACK_RANGING(packed) \
+	((uint8_t)((packed) & 0x0F))
+
+#define RAS_DONE_STATUS_UNPACK_SUBEVENT(packed) \
+	((uint8_t)(((packed) >> 4) & 0x0F))
+
 #define RAS_ABORT_REASON_PACK(ranging, subevent) \
 	((uint8_t)(((ranging) & 0x0F) | (((subevent) & 0x0F) << 4)))
 
+#define RAS_ABORT_REASON_UNPACK_RANGING(packed) \
+	((uint8_t)((packed) & 0x0F))
+
+#define RAS_ABORT_REASON_UNPACK_SUBEVENT(packed) \
+	((uint8_t)(((packed) >> 4) & 0x0F))
+
 struct ras_subevent {
 	struct ras_subevent_header subevent_header;
 	uint8_t subevent_data[];
@@ -206,6 +248,11 @@ struct cstracker {
 	uint16_t last_start_acl_conn_evt_counter;
 	uint16_t last_freq_comp;
 	int8_t last_ref_pwr_lvl;
+
+	/* Client - first segment carries this */
+	struct ranging_header   ranging_header_;
+	/* Client - subsequent segments appended using iovec */
+	struct iovec segment_data;
 };
 
 /* Ranging Service context */
@@ -254,6 +301,7 @@ struct bt_rap {
 	void *debug_data;
 	void *user_data;
 	struct cstracker *resptracker;
+	struct cstracker *reqtracker;
 };
 
 static struct queue *rap_db;
@@ -274,6 +322,28 @@ struct bt_rap_ready {
 	void *data;
 };
 
+typedef void (*rap_notify_t)(struct bt_rap *rap, uint16_t value_handle,
+			const uint8_t *value, uint16_t length,
+			void *user_data);
+
+struct bt_rap_notify {
+	unsigned int id;
+	struct bt_rap *rap;
+	rap_notify_t func;
+	void *user_data;
+};
+
+typedef void (*rap_func_t)(struct bt_rap *rap, bool success,
+			uint8_t att_ecode, const uint8_t *value,
+			uint16_t length, void *user_data);
+
+struct bt_rap_pending {
+	unsigned int id;
+	struct bt_rap *rap;
+	rap_func_t func;
+	void *userdata;
+};
+
 uint16_t default_ras_mtu = 247; /*Section 3.1.2 of RAP 1.0*/
 uint8_t ras_segment_header_size = 1;
 
@@ -542,6 +612,11 @@ static void rap_free(void *data)
 		rap->resptracker = NULL;
 	}
 
+	if (rap->reqtracker) {
+		free(rap->reqtracker);
+		rap->reqtracker = NULL;
+	}
+
 	queue_destroy(rap->notify, free);
 	queue_destroy(rap->pending, NULL);
 	queue_destroy(rap->ready_cbs, rap_ready_free);
@@ -641,6 +716,12 @@ static void cs_tracker_init(struct cstracker *t)
 	t->last_start_acl_conn_evt_counter = 0;
 	t->last_freq_comp = 0;
 	t->last_ref_pwr_lvl = 0;
+
+	/* Initialize ranging header using helper functions */
+	memset(&t->ranging_header_, 0, sizeof(t->ranging_header_));
+	/* Initialize segment accumulator */
+	t->segment_data.iov_base = NULL;
+	t->segment_data.iov_len = 0;
 }
 
 static void ras_features_read_cb(struct gatt_db_attribute *attrib,
@@ -1698,6 +1779,46 @@ static void form_ras_data_with_cs_subevent_result_cont(struct bt_rap *rap,
 		cont->step_data);
 }
 
+static void fill_initiator_data_from_cs_subevent_result_cont(struct bt_rap *rap,
+		const struct rap_ev_cs_subevent_result_cont *cont,
+		uint16_t length)
+{
+	size_t base_len = offsetof(struct rap_ev_cs_subevent_result_cont,
+					step_data);
+	struct cstracker *reqtracker;
+
+	if (!rap || !rap->reqtracker || !cont)
+		return;
+
+	if (length < base_len)
+		return;
+
+	DBG(rap, "Received CS subevent result continue subevent: len=%d",
+		length);
+
+	reqtracker = rap->reqtracker;
+
+}
+
+static void fill_initiator_data_from_cs_subevent_result(struct bt_rap *rap,
+		const struct rap_ev_cs_subevent_result *data,
+		uint16_t length)
+{
+	size_t base_len = offsetof(struct rap_ev_cs_subevent_result,
+					step_data);
+
+	if (!rap || !rap->reqtracker || !data)
+		return;
+
+	/* Defensive check: base header must be present */
+	if (length < base_len)
+		return;
+
+	DBG(rap, "Received CS subevent result subevent: len=%d", length);
+
+
+}
+
 void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
 						const void *param,
 						void *user_data)
@@ -1707,7 +1828,12 @@ void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
 
 	DBG(rap, "Received CS subevent CONT: len=%d", length);
 
-	form_ras_data_with_cs_subevent_result_cont(rap, cont, length);
+	if (rap->resptracker->role == CS_REFLECTOR)
+		form_ras_data_with_cs_subevent_result_cont(rap, cont, length);
+
+	if (rap->reqtracker->role == CS_INITIATOR)
+		fill_initiator_data_from_cs_subevent_result_cont(rap, cont,
+								length);
 }
 
 void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
@@ -1720,7 +1846,11 @@ void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
 	DBG(rap, "Received CS subevent: len=%d", length);
 
 	/* Populate CsProcedureData and send RAS payload */
-	form_ras_data_with_cs_subevent_result(rap, data, length);
+	if (rap->resptracker->role == CS_REFLECTOR)
+		form_ras_data_with_cs_subevent_result(rap, data, length);
+
+	if (rap->reqtracker->role == CS_INITIATOR)
+		fill_initiator_data_from_cs_subevent_result(rap, data, length);
 }
 
 void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
@@ -1763,6 +1893,7 @@ void bt_rap_hci_cs_config_complete_callback(uint16_t length,
 	const struct rap_ev_cs_config_cmplt *data = param;
 	struct bt_rap *rap = user_data;
 	struct cstracker *resptracker;
+	struct cstracker *reqtracker;
 
 	if (!rap)
 		return;
@@ -1781,6 +1912,19 @@ void bt_rap_hci_cs_config_complete_callback(uint16_t length,
 	resptracker->config_id = data->config_id;
 	resptracker->role = data->role;
 	resptracker->rtt_type = data->rtt_type;
+
+	if (!rap->reqtracker) {
+		reqtracker = new0(struct cstracker, 1);
+		cs_tracker_init(reqtracker);
+		rap->reqtracker = reqtracker;
+	}
+
+	reqtracker = rap->reqtracker;
+
+	/* Basic fields */
+	reqtracker->config_id = data->config_id;
+	reqtracker->role = data->role;
+	reqtracker->rtt_type = data->rtt_type;
 }
 
 struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
@@ -1815,6 +1959,821 @@ done:
 	return rap;
 }
 
+static void ras_pending_destroy(void *data)
+{
+	struct bt_rap_pending *pending = data;
+	struct bt_rap *rap = pending->rap;
+
+	if (queue_remove_if(rap->pending, NULL, pending))
+		free(pending);
+}
+
+static void ras_pending_complete(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct bt_rap_pending *pending = user_data;
+
+	if (pending->func)
+		pending->func(pending->rap, success, att_ecode, value, length,
+					  pending->userdata);
+}
+
+static void rap_read_value(struct bt_rap *rap, uint16_t value_handle,
+			   rap_func_t func, void *user_data)
+{
+	struct bt_rap_pending *pending;
+
+	pending = new0(struct bt_rap_pending, 1);
+	pending->rap = rap;
+	pending->func = func;
+	pending->userdata = user_data;
+
+	pending->id = bt_gatt_client_read_value(rap->client, value_handle,
+						ras_pending_complete, pending,
+						ras_pending_destroy);
+	if (!pending->id) {
+		DBG(rap, "Unable to send Read request");
+		free(pending);
+		return;
+	}
+
+	queue_push_tail(rap->pending, pending);
+}
+
+static void ras_register(uint16_t att_ecode, void *user_data)
+{
+	struct bt_rap_notify *notify = user_data;
+
+	if (att_ecode)
+		DBG(notify->rap, "RAS register failed 0x%04x", att_ecode);
+
+	(void)notify;
+}
+
+static void rap_notify(uint16_t value_handle, const uint8_t *value,
+				uint16_t length, void *user_data)
+{
+	struct bt_rap_notify *notify = user_data;
+
+	if (notify->func)
+		notify->func(notify->rap, value_handle, value, length,
+					 notify->user_data);
+}
+
+static void rap_notify_destroy(void *data)
+{
+	struct bt_rap_notify *notify = data;
+	struct bt_rap *rap = notify->rap;
+
+	if (queue_remove_if(rap->notify, NULL, notify))
+		free(notify);
+}
+
+static unsigned int bt_rap_register_notify(struct bt_rap *rap,
+					uint16_t value_handle,
+					rap_notify_t func,
+					void *user_data)
+{
+	struct bt_rap_notify *notify;
+
+	notify = new0(struct bt_rap_notify, 1);
+	notify->rap = rap;
+	notify->func = func;
+	notify->user_data = user_data;
+
+	DBG(rap, "register for notifications");
+
+	notify->id = bt_gatt_client_register_notify(rap->client,
+					value_handle, ras_register,
+					rap_notify, notify,
+					rap_notify_destroy);
+	if (!notify->id) {
+		DBG(rap, "Unable to register for notifications");
+		free(notify);
+		return 0;
+	}
+
+	queue_push_tail(rap->notify, notify);
+
+	return notify->id;
+}
+
+static inline bool parse_segmentation_header(struct iovec *iov,
+					     struct segmentation_header *s)
+{
+	uint8_t byte;
+
+	if (!util_iov_pull_u8(iov, &byte))
+		return false;
+
+	s->first_segment = (byte & 0x01) ? 1 : 0;
+	s->last_segment = (byte & 0x02) ? 1 : 0;
+	s->rolling_segment_counter = (byte >> 2) & 0x3F;
+
+	return true;
+}
+
+static void parse_i_q_sample(struct iovec *iov, int16_t *i_sample,
+				int16_t *q_sample)
+{
+	uint32_t buffer;
+	uint32_t i12;
+	uint32_t q12;
+
+	if (!util_iov_pull_le24(iov, &buffer)) {
+		*i_sample = 0;
+		*q_sample = 0;
+		return;
+	}
+
+	i12 =  buffer        & 0x0FFFU;   /* bits 0..11 */
+	q12 = (buffer >> 12) & 0x0FFFU;   /* bits 12..23 */
+
+	*i_sample = SIGN_EXTEND_TO_16(i12, 12);
+	*q_sample = SIGN_EXTEND_TO_16(q12, 12);
+}
+
+static size_t get_mode_zero_length(enum cs_role remote_role)
+{
+	return (remote_role == CS_ROLE_INITIATOR) ?
+		CS_MODE_ZERO_WIRE_INIT_SIZE :
+		CS_MODE_ZERO_WIRE_REF_SIZE;
+}
+
+static void parse_mode_zero(struct bt_rap *rap, struct iovec *mode_iov,
+			    enum cs_role remote_role)
+{
+	uint8_t packet_quality;
+	int8_t packet_rssi_dbm;
+	uint8_t packet_ant;
+	uint32_t init_measured_freq_offset = 0;
+
+	if (!util_iov_pull_u8(mode_iov, &packet_quality) ||
+	    !util_iov_pull_u8(mode_iov, (uint8_t *)&packet_rssi_dbm) ||
+	    !util_iov_pull_u8(mode_iov, &packet_ant)) {
+		DBG(rap, "Mode 0: failed to parse common fields");
+		return;
+	}
+
+	if (remote_role == CS_ROLE_INITIATOR) {
+		if (!util_iov_pull_le32(mode_iov, &init_measured_freq_offset)) {
+			DBG(rap, "Mode 0: failed to parse freq offset");
+			return;
+		}
+	}
+
+	if (remote_role == CS_ROLE_INITIATOR) {
+		DBG(rap, "    cs_mode_zero_data (INITIATOR): "
+			"Packet_Quality=%u Packet_RSSI=%d "
+			"Packet_Antenna=%u Measured_Freq_Offset=%u",
+			packet_quality,
+			packet_rssi_dbm,
+			packet_ant,
+			init_measured_freq_offset);
+	} else {
+		DBG(rap, "    cs_mode_zero_data (REFLECTOR): "
+			"Packet_Quality=%u Packet_RSSI=%d "
+			"Packet_Antenna=%u",
+			packet_quality,
+			packet_rssi_dbm,
+			packet_ant);
+	}
+}
+
+static size_t get_mode_one_length(bool include_pct)
+{
+	if (include_pct)
+		return CS_MODE_ONE_WIRE_SIZE_MAX;
+	return CS_MODE_ONE_WIRE_SIZE_MIN;
+}
+
+static void parse_mode_one(struct bt_rap *rap, struct iovec *mode_iov,
+			   enum cs_role remote_role, bool include_pct)
+{
+	uint8_t packet_quality;
+	uint8_t packet_nadm;
+	int8_t packet_rssi_dbm;
+	int16_t time_value;
+	uint8_t packet_ant;
+	int16_t pct1_i = 0, pct1_q = 0;
+	int16_t pct2_i = 0, pct2_q = 0;
+
+	/* Parse fixed fields (6 bytes) using util_iov_pull_* */
+	if (!util_iov_pull_u8(mode_iov, &packet_quality) ||
+	    !util_iov_pull_u8(mode_iov, &packet_nadm) ||
+	    !util_iov_pull_u8(mode_iov, (uint8_t *)&packet_rssi_dbm) ||
+	    !util_iov_pull_le16(mode_iov, (uint16_t *)&time_value) ||
+	    !util_iov_pull_u8(mode_iov, &packet_ant)) {
+		DBG(rap, "Mode 1: failed to parse fixed fields");
+		return;
+	}
+
+	/* Parse optional PCT fields using parse_i_q_sample */
+	if (include_pct) {
+		parse_i_q_sample(mode_iov, &pct1_i, &pct1_q);
+		parse_i_q_sample(mode_iov, &pct2_i, &pct2_q);
+	}
+
+	if (remote_role == CS_ROLE_INITIATOR) {
+		DBG(rap, "    cs_mode_one_data (INITIATOR): "
+			"Packet_Quality=%u Packet_NADM=%u "
+			"Packet_RSSI=%d ToA_ToD_Initiator=0x%4.4x "
+			"Packet_Antenna=%u",
+			packet_quality,
+			packet_nadm,
+			packet_rssi_dbm,
+			time_value,
+			packet_ant);
+		if (include_pct) {
+			DBG(rap, "    cs_mode_one_data (INITIATOR): "
+				"Packet_PCT1(I=0x%3.3x,Q=0x%3.3x) "
+				"Packet_PCT2(I=0x%3.3x,Q=0x%3.3x)",
+				pct1_i, pct1_q,
+				pct2_i, pct2_q);
+		}
+	} else {
+		DBG(rap, "    cs_mode_one_data (REFLECTOR): "
+			"Packet_Quality=%u Packet_NADM=%u "
+			"Packet_RSSI=%d ToD_ToA_Reflector=0x%4.4x  "
+			"Packet_Antenna=%u",
+			packet_quality,
+			packet_nadm,
+			packet_rssi_dbm,
+			time_value,
+			packet_ant);
+		if (include_pct) {
+			DBG(rap, "    cs_mode_one_data (REFLECTOR): "
+				"Packet_PCT1(I=0x%3.3x,Q=0x%3.3x) "
+				"Packet_PCT2(I=0x%3.3x,Q=0x%3.3x)",
+				pct1_i, pct1_q,
+				pct2_i, pct2_q);
+		}
+	}
+}
+
+static size_t get_mode_two_length(uint8_t num_antenna_paths)
+{
+	uint8_t num_tone_data = num_antenna_paths + 1;
+
+	return 1 + (4 * num_tone_data);
+}
+
+static void parse_mode_two(struct bt_rap *rap, struct iovec *mode_iov)
+{
+	uint8_t ant_perm_index;
+	int16_t tone_pct_i[5];
+	int16_t tone_pct_q[5];
+	uint8_t tone_quality[5];
+	uint8_t k;
+	uint8_t max_paths = 5;
+
+	if (!util_iov_pull_u8(mode_iov, &ant_perm_index)) {
+		DBG(rap, "Mode 2: failed to parse ant_perm_index");
+		return;
+	}
+
+	for (k = 0; k < max_paths; k++) {
+		int16_t i_val, q_val;
+
+		if (mode_iov->iov_len < 4) {
+			DBG(rap, "Mode 2: insufficient PCT for "
+				"path %u (rem=%zu)",
+				k, mode_iov->iov_len);
+			break;
+		}
+		parse_i_q_sample(mode_iov, &i_val, &q_val);
+		tone_pct_i[k] = i_val;
+		tone_pct_q[k] = q_val;
+
+		util_iov_pull_u8(mode_iov, &tone_quality[k]);
+		DBG(rap, "tone_quality_indicator : %d",
+			tone_quality[k]);
+		DBG(rap, "[i, q] : %d, %d",
+			tone_pct_i[k],
+			tone_pct_q[k]);
+	}
+
+	DBG(rap, "    cs_mode_two_data: ant_perm_idx=%u",
+		ant_perm_index);
+	for (k = 0; k < max_paths; k++) {
+		DBG(rap, "      tone[%u]: pct(I=0x%3.3x,Q=0x%3.3x) quality=%u",
+			k,
+			tone_pct_i[k],
+			tone_pct_q[k],
+			tone_quality[k]);
+	}
+}
+
+static size_t get_mode_three_length(uint8_t num_antenna_paths, bool include_pct)
+{
+	uint8_t num_tone_data = num_antenna_paths + 1;
+	size_t len;
+
+	/* Mode 1 portion: 6 bytes base + optional 6 bytes PCT */
+	len = 6;
+	if (include_pct)
+		len += 6;
+
+	/* Mode 2 portion: 1 byte antenna index + 4 bytes per tone */
+	len += 1 + (4 * num_tone_data);
+
+	return len;
+}
+
+static void parse_mode_three(struct bt_rap *rap, struct iovec *mode_iov,
+			     enum cs_role remote_role, bool include_pct)
+{
+	uint8_t packet_quality;
+	uint8_t packet_nadm;
+	int8_t packet_rssi_dbm;
+	int16_t time_value;
+	uint8_t packet_ant;
+	int16_t pct1_i = 0, pct1_q = 0;
+	int16_t pct2_i = 0, pct2_q = 0;
+	uint8_t ant_perm_index;
+	int16_t tone_pct_i[5];
+	int16_t tone_pct_q[5];
+	uint8_t tone_quality[5];
+	uint8_t k;
+	uint8_t max_paths = 5;
+
+	/* Parse Mode 1 portion (6 or 12 bytes) */
+	if (!util_iov_pull_u8(mode_iov, &packet_quality) ||
+	    !util_iov_pull_u8(mode_iov, &packet_nadm) ||
+	    !util_iov_pull_u8(mode_iov, (uint8_t *)&packet_rssi_dbm) ||
+	    !util_iov_pull_le16(mode_iov, (uint16_t *)&time_value) ||
+	    !util_iov_pull_u8(mode_iov, &packet_ant)) {
+		DBG(rap, "Mode 3: failed to parse Mode 1 fixed fields");
+		return;
+	}
+
+	/* Parse optional PCT fields using new logic */
+	if (include_pct) {
+		parse_i_q_sample(mode_iov, &pct1_i, &pct1_q);
+		parse_i_q_sample(mode_iov, &pct2_i, &pct2_q);
+	}
+
+	/* Parse Mode 2 portion - antenna permutation index */
+	if (!util_iov_pull_u8(mode_iov, &ant_perm_index)) {
+		DBG(rap, "Mode 3: failed to parse ant_perm_index");
+		return;
+	}
+
+	/* Parse tone paths using new logic */
+	for (k = 0; k < max_paths; k++) {
+		int16_t i_val, q_val;
+
+		if (mode_iov->iov_len < 4) {
+			DBG(rap, "Mode 3: insufficient PCT for "
+				"path %u (rem=%zu)",
+				k, mode_iov->iov_len);
+			break;
+		}
+		parse_i_q_sample(mode_iov, &i_val, &q_val);
+		tone_pct_i[k] = i_val;
+		tone_pct_q[k] = q_val;
+
+		util_iov_pull_u8(mode_iov, &tone_quality[k]);
+		DBG(rap, "tone_quality_indicator : %d",
+			tone_quality[k]);
+		DBG(rap, "[i, q] : %d, %d",
+			tone_pct_i[k],
+			tone_pct_q[k]);
+	}
+
+	if (remote_role == CS_ROLE_INITIATOR) {
+		DBG(rap, "    cs_mode_three_data (INITIATOR): "
+			"Packet_Quality=%u Packet_NADM=%u "
+			"Packet_RSSI=%d ToA_ToD_Initiator=0x%4.4x "
+			"Packet_Antenna=%u",
+			packet_quality,
+			packet_nadm,
+			packet_rssi_dbm,
+			time_value,
+			packet_ant);
+		if (include_pct) {
+			DBG(rap, "    cs_mode_three_data (INITIATOR): "
+				"Packet_PCT1(I=0x%3.3x,Q=0x%3.3x) "
+				"Packet_PCT2(I=0x%3.3x,Q=0x%3.3x)",
+				pct1_i, pct1_q,
+				pct2_i, pct2_q);
+		}
+		DBG(rap, "    cs_mode_three_data (INITIATOR): "
+			"Antenna_Permutation_Index=%u",
+			ant_perm_index);
+		for (k = 0; k < max_paths; k++) {
+			DBG(rap, "      Tone_PCT[%u](I=0x%3.3x,Q=0x%3.3x) "
+				"Tone_Quality_Indicator[%u]=%u",
+				k,
+				tone_pct_i[k],
+				tone_pct_q[k],
+				k,
+				tone_quality[k]);
+		}
+	} else {
+		DBG(rap, "    cs_mode_three_data (REFLECTOR): "
+			"Packet_Quality=%u Packet_NADM=%u "
+			"Packet_RSSI=%d ToD_ToA_Reflector=0x%4.4x "
+			"Packet_Antenna=%u",
+			packet_quality,
+			packet_nadm,
+			packet_rssi_dbm,
+			time_value,
+			packet_ant);
+		if (include_pct) {
+			DBG(rap, "    cs_mode_three_data (REFLECTOR): "
+				"Packet_PCT1(I=0x%3.3x,Q=0x%3.3x) "
+				"Packet_PCT2(I=0x%3.3x,Q=0x%3.3x)",
+				pct1_i, pct1_q,
+				pct2_i, pct2_q);
+		}
+		DBG(rap, "    cs_mode_three_data (REFLECTOR): "
+			"Antenna_Permutation_Index=%u",
+			ant_perm_index);
+		for (k = 0; k < max_paths; k++) {
+			DBG(rap, "      Tone_PCT[%u](I=0x%3.3x,Q=0x%3.3x) "
+				"Tone_Quality_Indicator[%u]=%u",
+				k,
+				tone_pct_i[k],
+				tone_pct_q[k],
+				k,
+				tone_quality[k]);
+		}
+	}
+}
+
+static void parse_ras_data_segments(struct bt_rap *rap,
+			       struct cstracker *reqtracker)
+{
+	const uint8_t *buf;
+	size_t buf_len;
+	size_t offset = 0;
+	uint8_t antenna_mask;
+	uint8_t num_antenna_paths;
+
+	if (!rap || !reqtracker)
+		return;
+
+	DBG(rap, "Complete RAS data received: %zu bytes",
+	    reqtracker->segment_data.iov_len);
+
+	/* Extract num_antenna_paths from ranging header */
+	antenna_mask =
+		ranging_header_get_antenna_mask(&reqtracker->ranging_header_);
+	num_antenna_paths = antenna_mask_count_paths(antenna_mask);
+
+	/* Validate complete RAS data structure before parsing */
+	buf = (const uint8_t *)reqtracker->segment_data.iov_base;
+	buf_len = reqtracker->segment_data.iov_len;
+
+	/* Process all subevents in the accumulated buffer */
+	while (offset + RAS_SUBEVENT_HEADER_SIZE <= buf_len) {
+		struct ras_subevent_header subevt_hdr;
+		const uint8_t *hdr = buf + offset;
+		uint8_t done_byte;
+		uint8_t abort_byte;
+
+		subevt_hdr.start_acl_conn_event = get_le16(hdr);
+		subevt_hdr.frequency_compensation =
+			get_le16(hdr + 2);
+
+		done_byte = hdr[4];
+		subevt_hdr.ranging_done_status =
+			RAS_DONE_STATUS_UNPACK_RANGING(done_byte);
+		subevt_hdr.subevent_done_status =
+			RAS_DONE_STATUS_UNPACK_SUBEVENT(done_byte);
+
+		abort_byte = hdr[5];
+		subevt_hdr.ranging_abort_reason =
+			RAS_ABORT_REASON_UNPACK_RANGING(abort_byte);
+		subevt_hdr.subevent_abort_reason =
+			RAS_ABORT_REASON_UNPACK_SUBEVENT(abort_byte);
+
+		subevt_hdr.reference_power_level = (int8_t)hdr[6];
+		subevt_hdr.num_steps_reported = hdr[7];
+
+		DBG(rap, "Parsed subevent: start_acl=%u "
+			"freq_comp=%d ref_pwr=%d steps=%u",
+		    subevt_hdr.start_acl_conn_event,
+		    subevt_hdr.frequency_compensation,
+		    subevt_hdr.reference_power_level,
+		    subevt_hdr.num_steps_reported);
+
+		offset += RAS_SUBEVENT_HEADER_SIZE;
+
+		/* Parse step data for this subevent */
+		for (uint8_t step_idx = 0;
+		     step_idx < subevt_hdr.num_steps_reported;
+		     step_idx++) {
+			uint8_t mode_byte;
+			bool step_aborted;
+			uint8_t step_mode;
+			size_t step_payload_len = 0;
+			uint8_t rtt_type;
+			bool include_pct;
+			/* Determine remote role */
+			enum cs_role local_role = reqtracker->role;
+			enum cs_role remote_role =
+				(local_role == CS_ROLE_INITIATOR) ?
+				CS_ROLE_REFLECTOR : CS_ROLE_INITIATOR;
+
+			if (offset >= buf_len) {
+				DBG(rap, "Insufficient data for "
+					"step %u", step_idx);
+				break;
+			}
+
+			/* Parse: 1 byte mode + variable payload */
+			mode_byte = buf[offset++];
+			step_aborted = (mode_byte & RAS_STEP_ABORTED_BIT) != 0;
+			step_mode = mode_byte & 0x7F;
+
+			if (step_aborted) {
+				DBG(rap, "  Step %u: mode=%u "
+					"(aborted)",
+					step_idx, step_mode);
+				continue;
+			}
+
+			/* Determine payload length and parse mode data */
+			rtt_type = reqtracker->rtt_type;
+			include_pct = (rtt_type == 0x01 || rtt_type == 0x02);
+
+			switch (step_mode) {
+			case CS_MODE_ZERO:
+				step_payload_len =
+					get_mode_zero_length(remote_role);
+				break;
+			case CS_MODE_ONE:
+				step_payload_len =
+					get_mode_one_length(include_pct);
+				break;
+			case CS_MODE_TWO:
+				step_payload_len =
+					get_mode_two_length(num_antenna_paths);
+				break;
+			case CS_MODE_THREE:
+				step_payload_len =
+					get_mode_three_length(
+						num_antenna_paths,
+						include_pct);
+				break;
+			default:
+				DBG(rap, "  Step %u: unknown mode=%u",
+					step_idx, step_mode);
+				step_payload_len = 0;
+				break;
+			}
+
+			if (offset + step_payload_len > buf_len) {
+				DBG(rap, "Insufficient data for "
+					"step %u payload (need %zu, have %zu)",
+					step_idx, step_payload_len,
+					buf_len - offset);
+				break;
+			}
+
+			DBG(rap, "  Step %u: mode=%u payload_len=%zu",
+			    step_idx, step_mode, step_payload_len);
+
+			/* Parse mode data if payload is present */
+			if (step_payload_len > 0) {
+				const uint8_t *payload_ptr = buf + offset;
+				struct iovec mode_iov;
+
+				mode_iov.iov_base = (void *)payload_ptr;
+				mode_iov.iov_len = step_payload_len;
+
+				switch (step_mode) {
+				case CS_MODE_ZERO:
+					parse_mode_zero(rap, &mode_iov,
+							remote_role);
+					break;
+				case CS_MODE_ONE:
+					parse_mode_one(rap, &mode_iov,
+						remote_role, include_pct);
+					break;
+				case CS_MODE_TWO:
+					parse_mode_two(rap, &mode_iov);
+					break;
+				case CS_MODE_THREE:
+					parse_mode_three(rap, &mode_iov,
+						remote_role, include_pct);
+					break;
+				default:
+					break;
+				}
+
+				/* Skip payload */
+				offset += step_payload_len;
+			}
+		}
+
+		/* Check if this is the last subevent */
+		if (subevt_hdr.subevent_done_status ==
+		    SUBEVENT_DONE_ALL_RESULTS_COMPLETE ||
+		    subevt_hdr.ranging_done_status ==
+		    RANGING_DONE_ALL_RESULTS_COMPLETE) {
+			DBG(rap, "Ranging procedure complete");
+			break;
+		}
+	}
+
+	/* Clean up accumulator */
+	free(reqtracker->segment_data.iov_base);
+	reqtracker->segment_data.iov_base = NULL;
+	reqtracker->segment_data.iov_len = 0;
+}
+
+static bool process_first_segment(struct bt_rap *rap,
+					struct cstracker *reqtracker,
+					struct iovec *iov, bool last_segment)
+{
+	uint16_t counter_config_val;
+	int8_t selected_tx_power;
+	uint8_t antenna_pct;
+
+	if (!util_iov_pull_le16(iov, &counter_config_val) ||
+	    !util_iov_pull_u8(iov, (uint8_t *)&selected_tx_power) ||
+	    !util_iov_pull_u8(iov, &antenna_pct)) {
+		DBG(rap, "First segment too short for ranging header");
+		return false;
+	}
+
+	ranging_header_set_counter(&reqtracker->ranging_header_,
+				counter_config_val & 0x0FFF);
+	ranging_header_set_config_id(&reqtracker->ranging_header_,
+				(counter_config_val >> 12) & 0x0F);
+	reqtracker->ranging_header_.selected_tx_power = selected_tx_power;
+	reqtracker->ranging_header_.antenna_pct = antenna_pct;
+
+	DBG(rap, "First segment: parsed ranging header "
+	    "(counter=%u, config_id=%u, tx_pwr=%d)",
+	    counter_config_val & 0x0FFF,
+	    (counter_config_val >> 12) & 0x0F,
+	    selected_tx_power);
+
+	if (reqtracker->segment_data.iov_base) {
+		free(reqtracker->segment_data.iov_base);
+		reqtracker->segment_data.iov_base = NULL;
+		reqtracker->segment_data.iov_len = 0;
+	}
+
+	if (iov->iov_len > 0) {
+		if (!util_iov_append(&reqtracker->segment_data,
+					iov->iov_base, iov->iov_len)) {
+			DBG(rap, "Failed to initialize segment accumulator");
+			return false;
+		}
+		DBG(rap, "First segment: initialized accumulator "
+		    "with %zu bytes", iov->iov_len);
+	}
+
+	if (!last_segment)
+		return false;
+
+	DBG(rap, "Single-segment: first=1, last=1");
+	return true;
+}
+
+static void ras_realtime_notify_cb(struct bt_rap *rap, uint16_t value_handle,
+				   const uint8_t *value, uint16_t length,
+				   void *user_data)
+{
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	struct segmentation_header seg_hdr;
+	struct cstracker *reqtracker;
+
+	if (!rap || !value || length == 0) {
+		DBG(rap, "Invalid notification data");
+		return;
+	}
+
+	DBG(rap, "Received real-time notification: handle=0x%04x len=%u",
+	    value_handle, length);
+
+	if (!parse_segmentation_header(&iov, &seg_hdr)) {
+		DBG(rap, "Failed to parse segmentation header");
+		return;
+	}
+
+	DBG(rap, "Segment: first=%u last=%u counter=%u",
+	    seg_hdr.first_segment, seg_hdr.last_segment,
+	    seg_hdr.rolling_segment_counter);
+
+	if (!rap->reqtracker) {
+		DBG(rap, "reqtracker is not initialised");
+		return;
+	}
+
+	reqtracker = rap->reqtracker;
+
+	if (seg_hdr.first_segment) {
+		if (!process_first_segment(rap, reqtracker, &iov,
+						seg_hdr.last_segment))
+			return;
+	} else {
+		if (iov.iov_len > 0) {
+			if (!util_iov_append(&reqtracker->segment_data,
+						iov.iov_base, iov.iov_len)) {
+				DBG(rap, "Failed to append segment data");
+				return;
+			}
+			DBG(rap, "Continuation segment: appended "
+			    "%zu bytes (total=%zu)",
+			    iov.iov_len,
+			    reqtracker->segment_data.iov_len);
+		}
+	}
+
+	/* Last segment: parse complete RAS data */
+	if (seg_hdr.last_segment)
+		parse_ras_data_segments(rap, reqtracker);
+}
+
+static void read_ras_features(struct bt_rap *rap, bool success,
+			uint8_t att_ecode,
+			const uint8_t *value, uint16_t length,
+			void *user_data)
+{
+	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
+	uint32_t features = 0;
+	struct ras *ras;
+	bool supports_realtime;
+	bool retrieve_lost;
+	bool abort_operation;
+
+	if (!success) {
+		DBG(rap, "Unable to read RAS Features: error 0x%02x",
+			att_ecode);
+		return;
+	}
+
+	ras = rap_get_ras(rap);
+
+	if (length == 0 || length > 4) {
+		DBG(rap, "Invalid RAS Features length: %u (expected 1-4)",
+			length);
+		return;
+	}
+
+	if (length < 4) {
+		uint8_t padded[4] = { 0, 0, 0, 0 };
+
+		memcpy(padded, value, length);
+		iov.iov_base = padded;
+		iov.iov_len = 4;
+		DBG(rap, "RAS Features: short read (%u bytes), zero-pad to 4",
+		    length);
+	}
+
+	if (!util_iov_pull_le32(&iov, &features)) {
+		DBG(rap, "Unable to parse RAS Features value");
+		return;
+	}
+
+	DBG(rap, "RAS Features: 0x%08x", features);
+
+	supports_realtime = (features & 0x01) != 0;
+	retrieve_lost = (features & 0x02) != 0;
+	abort_operation = (features & 0x04) != 0;
+
+	DBG(rap, "RAS Features - Real-time: %s, Retrieve Lost: %s, Abort: %s",
+	    supports_realtime ? "Yes" : "No",
+	    retrieve_lost ? "Yes" : "No",
+	    abort_operation ? "Yes" : "No");
+
+	DBG(rap, "RAS features read successfully, capabilities determined");
+
+	/* Register for real-time characteristic notifications if supported */
+	if (supports_realtime && ras && ras->realtime_chrc && rap->client) {
+		uint16_t value_handle;
+		bt_uuid_t uuid;
+
+		if (gatt_db_attribute_get_char_data(ras->realtime_chrc,
+					NULL, &value_handle,
+					NULL, NULL, &uuid)) {
+			unsigned int notify_id;
+
+			notify_id = bt_rap_register_notify(rap,
+						value_handle,
+						ras_realtime_notify_cb,
+						NULL);
+			if (!notify_id)
+				DBG(rap, "Failed to register for "
+					"real-time notifications");
+			else
+				DBG(rap, "Registered for real-time "
+					"features: id=%u", notify_id);
+		}
+	} else {
+		DBG(rap, "On demand ranging "
+			"remote device - skipping notification "
+			"registration");
+	}
+}
+
 static void foreach_rap_char(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct bt_rap *rap = user_data;
@@ -1848,6 +2807,10 @@ static void foreach_rap_char(struct gatt_db_attribute *attr, void *user_data)
 			return;
 
 		ras->feat_chrc = attr;
+		if (rap->client) {
+			rap_read_value(rap, value_handle,
+					read_ras_features, rap);
+		}
 	}
 
 	if (!bt_uuid_cmp(&uuid, &uuid_realtime)) {
-- 
2.34.1


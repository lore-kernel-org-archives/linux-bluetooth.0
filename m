Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E3386C0F
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362158; cv=none; b=O4Oc72zER4hljdGhidgME6SBYO5KgJX8CI/N0gCRa4/qEpkUXJOeqrhCa57Wec00YhHJKXpWwQwKxMeQlFe7GpoUQBG8gKfTpZGco/1elfL35+ZZLXbLK7u+kHzLJqC1Kv4VruFBg5+o5eHBFI9f5x9CgaoKfB5PV5Bt4cPjsIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362158; c=relaxed/simple;
	bh=y6sOYGdUv/Z/ediqL1Mo6JoiS7WY3ilmgsflrv3TWrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QOxkqDaRh+YdWGZ9MnHpfiZxMOIOJLV8s5j8KckX5D3ti/UWCcdDAj9zfotpryA82yiNdc6dcFm3vaMsxWPIAoEoElEzsiKvxe/WNBi9TyJapVpF5rCBMnqMli04dKijBrLE8WK7YZKNlit6LhsRKjMzDISSXAZ7pC/a/eL+jeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZWCrw+2w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Icz72RXX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZWCrw+2w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Icz72RXX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99u1k3772832
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 11:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ybcgaH5aKod83Ir1KDkWJ1WqUuZRlpaNGJ7
	Hb9w9n1U=; b=ZWCrw+2wmglIc0aN4qGm+QoAIeRKwcKzJ3zl8cVxde3q366iDAV
	oKbwChxxI15k6HBxxsj+XWVmlkCx+g0YvITOqqmlbsZTc47NgGBvQjXCBxTyfmv0
	PnxUt7ReRcLNmv76KK1fBcMrjAYF03aJ/MKQ+tdQ9dTZ37aLl3TRTTYfBTTCrrUp
	kRTMiQoznVJuG+deJc8XKL2eAggDUAl+aRHKq9nhPmtY9S4aYe+0MdKwo9A0QwXD
	cfpyD2oZY1OPm/ZMkBEt0bG5kE81U68oJr0CYcYhIG+DbjOC5sz6PYFma0iFRhr7
	+msymbLJaUJOAcSGP2D09bh5i+Dr47jH7xg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma42wry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 11:15:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-365e70c39d0so5686422a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779362155; x=1779966955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ybcgaH5aKod83Ir1KDkWJ1WqUuZRlpaNGJ7Hb9w9n1U=;
        b=Icz72RXXo3KDbrGkoA+1vwiJrvqtLzA/2Ju3QqBkgJxLifldKkTf2fEhQj2TFTRfKz
         9v6sp0iYxlQ/VIYRGZ5tTZh95vbBl2BsYWoNoTsUEWXySchmlGHkvQU1jWAfPhVkPrRG
         1GyPnRWymFeV8fiq3j7Bqkj0RvsLH1LV66KipO4qj819mF/oAiRzvyvERRs0CEVJ8x56
         tnJAz9aEWTk5l7ClNPnauwnROGom9MNnNr6F/DDpBnLVL38qsJREnv9U9ZTh+warqDw9
         /5+GdfzbTNW7aOUXmHlX4ne7WfT5rBaXcAc48fIUVvmhYqyDCYW4VSlXxrfQZ5tyrmmp
         oCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779362155; x=1779966955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybcgaH5aKod83Ir1KDkWJ1WqUuZRlpaNGJ7Hb9w9n1U=;
        b=A2+dhxS95BdJPCAztjiecYVX9yNb/Bn5sON3JML7jdPLdiIln8044AR2oMyCrokAs5
         9mAZJ3Ia0OO3gWIHubkvDw2SpXT/2HlS/NvEJ4ZfJFgL1jATIB7VVv1wmLARxN+1+GEp
         U/J/4uxmfQemDKMPzrvWj9a3hFrdosN+IioS8eesueYKG0SM5Tw2UeA1acrOZudRx6AK
         DAzAAKqe4ZnyMtz81vbVfuOoqGr97ZH73elCdgiZwaY1B+miGJDeGFymBFyMvXeIu2Dk
         p2PQ+23UDI5HZuTpjRQwhr5pv2mrGt1T301CVDQcaVHMZwcbStsccB5hSJWG2I52D4li
         nq8Q==
X-Gm-Message-State: AOJu0YzXy3BsEkgFEdxR6g+ZBjWDXVH7Brlx49QlLUi64PLrHHnP4wRv
	GsC7naeuno1B3sqina6G2Q40MrzLsC4EAK7eXhu9eprREeNRuhArtmlrdvwlGI738ocQ+rarAnU
	3g/HaJ0Cb1BCdlGIubUje0Lkr7axcGULvaS4+wcIxtO83r4tVTH7eooFz8uPLDxqvSZAOSu+stD
	1/kZA=
X-Gm-Gg: Acq92OHL/0IoypI/gj9ZCUFCbAiMEukSTY60TVSaA1Sv8fc2U3caYw9fe0wGXGAbJue
	Ur6DsiapF6U517c7xV7pI80GSbp1valuKprwXRMAft4x9SStdlF44DbToFn2UWMzuq9A2CVjKpD
	eOcgxpHmljjPaMuzuA4WQFgTxs0nvTNfdv7q81sBFF7vwfWyZVgps98sCRf26BCpaWdRVur1HfV
	Dvv8lbw679/HhwopX/RZ2HX1UU+AsrYRGUwBmIDART2V+9u/HYierc64HwLnkNTfZTgED2bxJzq
	WwnK0SxUPRE+n+uB6m6ifc6+N65Y2MXf5JsqdwSsnwGNDM+93jnOxSpgWSzRdjcwLkcRwJg10ph
	sPKwwxGbN5Mz1wZwrciOlQBJGshM9pUVhlBfUBZKSwnn/7YqwxDo7Zw==
X-Received: by 2002:a17:90b:3d8e:b0:366:132:fda3 with SMTP id 98e67ed59e1d1-36a45158279mr2437987a91.11.1779362154637;
        Thu, 21 May 2026 04:15:54 -0700 (PDT)
X-Received: by 2002:a17:90b:3d8e:b0:366:132:fda3 with SMTP id 98e67ed59e1d1-36a45158279mr2437931a91.11.1779362153933;
        Thu, 21 May 2026 04:15:53 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c851996f6f8sm38620a12.32.2026.05.21.04.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 04:15:53 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v4] shared/rap: Add client ranging registration and notification parsing
Date: Thu, 21 May 2026 16:45:50 +0530
Message-Id: <20260521111550.2508891-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ee96b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=8bThT1Dy-1J2BioF_FkA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: Ukiwe2ZwUbBeQlC9tr9SkTo7hbEvRbkD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDExMiBTYWx0ZWRfX7fpH9WyLF8+S
 pA7xxGEbRKfU6/Bh8akJ8DzzOmg+ImvbEvHRAxCSDapABF5vhMSthhYtIfV4Ieovk+SKdEfze8F
 PuogeVG5eBEEfk3if8d1Zc+cmj23KHRXHaSKK09E3uOS9Asa6ei6l0niShja2GoYo+U/qJYq9ct
 R/Ou4+ihwk01ZkHGKZ1/r5KNDTy7a5NLqIDSvkb5Fo5QQYSxKwxkEY2CMbTEVO/41VDXSXtpg+w
 gqHBA0b0sQSremPnHjbIhNH0mcgQ3y95LtYI4vvcZiCDqdaFTsOpAKjSQ4Z1nSYIRlQ0r1I1DvV
 kK8or6HAZmkJEUqigLI8IMZXFT8ofTbAZFy1nP1IzZ4zhAG6LN327xiGQiKrM/q5F9jJXDglImB
 ybK3YLM+csVDY0atAKjIZfVr6R9l6tmFIo+VByAW+XA22cq/GOW8x4ikeKmckLJwGqpO9bTh47H
 Q08HC2VCtEjfp8ryp6Q==
X-Proofpoint-ORIG-GUID: Ukiwe2ZwUbBeQlC9tr9SkTo7hbEvRbkD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210112

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Read the RAS Features characteristic to determine whether the remote
device supports real-time ranging. If supported, register for real-time
characteristic notifications using the reqtracker for the CS initiator
role.

Parse incoming segmented RAS ranging data notifications by accumulating
segments via iovec and parsing complete subevent headers and CS mode 0-3
step data, including IQ/tone PCT samples, once the last segment arrives.

Changes in v2:
Removed unneccsary DBG logs and unused variables.
Use helper functions for readablitiy and code indentation.

---
 src/shared/rap.c | 836 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 834 insertions(+), 2 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index 145da2060..3639c3f4d 100644
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
@@ -1698,6 +1779,42 @@ static void form_ras_data_with_cs_subevent_result_cont(struct bt_rap *rap,
 		cont->step_data);
 }
 
+static void fill_initiator_data_from_cs_subevent_result_cont(struct bt_rap *rap,
+		const struct rap_ev_cs_subevent_result_cont *cont,
+		uint16_t length)
+{
+	size_t base_len = offsetof(struct rap_ev_cs_subevent_result_cont,
+					step_data);
+
+	if (!rap || !rap->reqtracker || !cont)
+		return;
+
+	if (length < base_len)
+		return;
+
+	DBG(rap, "Received CS subevent result continue subevent: len=%d",
+		length);
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
@@ -1707,7 +1824,12 @@ void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
 
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
@@ -1720,7 +1842,11 @@ void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
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
@@ -1763,6 +1889,7 @@ void bt_rap_hci_cs_config_complete_callback(uint16_t length,
 	const struct rap_ev_cs_config_cmplt *data = param;
 	struct bt_rap *rap = user_data;
 	struct cstracker *resptracker;
+	struct cstracker *reqtracker;
 
 	if (!rap)
 		return;
@@ -1781,6 +1908,19 @@ void bt_rap_hci_cs_config_complete_callback(uint16_t length,
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
@@ -1815,6 +1955,694 @@ done:
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
+	/*Store this data as reflecter data*/
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
+	if (!util_iov_pull_u8(mode_iov, &packet_quality) ||
+	    !util_iov_pull_u8(mode_iov, &packet_nadm) ||
+	    !util_iov_pull_u8(mode_iov, (uint8_t *)&packet_rssi_dbm) ||
+	    !util_iov_pull_le16(mode_iov, (uint16_t *)&time_value) ||
+	    !util_iov_pull_u8(mode_iov, &packet_ant)) {
+		DBG(rap, "Mode 1: failed to parse fixed fields");
+		return;
+	}
+
+	if (include_pct) {
+		parse_i_q_sample(mode_iov, &pct1_i, &pct1_q);
+		parse_i_q_sample(mode_iov, &pct2_i, &pct2_q);
+	}
+
+	/*Store this data as reflecter data*/
+}
+
+static size_t get_mode_two_length(uint8_t num_antenna_paths)
+{
+	uint8_t num_tone_data = num_antenna_paths + 1;
+
+	return 1 + (4 * num_tone_data);
+}
+
+static void parse_mode_two(struct bt_rap *rap, struct iovec *mode_iov,
+			   uint8_t num_antenna_paths)
+{
+	uint8_t ant_perm_index;
+	int16_t tone_pct_i[5];
+	int16_t tone_pct_q[5];
+	uint8_t tone_quality[5];
+	uint8_t k;
+	uint8_t num_paths = (num_antenna_paths + 1) < 5 ?
+				(num_antenna_paths + 1) : 5;
+
+	if (!util_iov_pull_u8(mode_iov, &ant_perm_index)) {
+		DBG(rap, "Mode 2: failed to parse ant_perm_index");
+		return;
+	}
+
+	for (k = 0; k < num_paths; k++) {
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
+
+	/*Store this data as reflecter data*/
+}
+
+static size_t get_mode_three_length(uint8_t num_antenna_paths, bool include_pct)
+{
+	uint8_t num_tone_data = num_antenna_paths + 1;
+	size_t len;
+
+	len = 6;
+	if (include_pct)
+		len += 6;
+
+	len += 1 + (4 * num_tone_data);
+
+	return len;
+}
+
+static void parse_mode_three(struct bt_rap *rap, struct iovec *mode_iov,
+			     enum cs_role remote_role, bool include_pct,
+			     uint8_t num_antenna_paths)
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
+	uint8_t num_paths = (num_antenna_paths + 1) < 5 ?
+				(num_antenna_paths + 1) : 5;
+
+	if (!util_iov_pull_u8(mode_iov, &packet_quality) ||
+	    !util_iov_pull_u8(mode_iov, &packet_nadm) ||
+	    !util_iov_pull_u8(mode_iov, (uint8_t *)&packet_rssi_dbm) ||
+	    !util_iov_pull_le16(mode_iov, (uint16_t *)&time_value) ||
+	    !util_iov_pull_u8(mode_iov, &packet_ant)) {
+		DBG(rap, "Mode 3: failed to parse Mode 1 fixed fields");
+		return;
+	}
+
+	if (include_pct) {
+		parse_i_q_sample(mode_iov, &pct1_i, &pct1_q);
+		parse_i_q_sample(mode_iov, &pct2_i, &pct2_q);
+	}
+
+	if (!util_iov_pull_u8(mode_iov, &ant_perm_index)) {
+		DBG(rap, "Mode 3: failed to parse ant_perm_index");
+		return;
+	}
+
+	for (k = 0; k < num_paths; k++) {
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
+	/*Store this data as reflecter data*/
+}
+
+static bool parse_subevent_header(struct iovec *iov,
+					struct ras_subevent_header *hdr)
+{
+	uint16_t start_acl, freq_comp;
+	uint8_t done_byte, abort_byte, ref_pwr, num_steps;
+
+	if (!util_iov_pull_le16(iov, &start_acl) ||
+	    !util_iov_pull_le16(iov, &freq_comp) ||
+	    !util_iov_pull_u8(iov, &done_byte) ||
+	    !util_iov_pull_u8(iov, &abort_byte) ||
+	    !util_iov_pull_u8(iov, &ref_pwr) ||
+	    !util_iov_pull_u8(iov, &num_steps))
+		return false;
+
+	hdr->start_acl_conn_event = start_acl;
+	hdr->frequency_compensation = freq_comp;
+	hdr->ranging_done_status = RAS_DONE_STATUS_UNPACK_RANGING(done_byte);
+	hdr->subevent_done_status = RAS_DONE_STATUS_UNPACK_SUBEVENT(done_byte);
+	hdr->ranging_abort_reason =
+		RAS_ABORT_REASON_UNPACK_RANGING(abort_byte);
+	hdr->subevent_abort_reason =
+		RAS_ABORT_REASON_UNPACK_SUBEVENT(abort_byte);
+	hdr->reference_power_level = (int8_t)ref_pwr;
+	hdr->num_steps_reported = num_steps;
+
+	return true;
+}
+
+static bool parse_step(struct bt_rap *rap, struct iovec *iov,
+			struct cstracker *reqtracker,
+			uint8_t num_antenna_paths, uint8_t step_idx)
+{
+	uint8_t mode_byte, step_mode;
+	bool include_pct;
+	enum cs_role remote_role;
+	size_t step_payload_len;
+	struct iovec mode_iov;
+	void *payload;
+
+	if (!util_iov_pull_u8(iov, &mode_byte)) {
+		DBG(rap, "Insufficient data for step %u", step_idx);
+		return false;
+	}
+
+	if (mode_byte & RAS_STEP_ABORTED_BIT) {
+		DBG(rap, "  Step %u: mode=%u (aborted)",
+			step_idx, mode_byte & 0x7F);
+		return true;
+	}
+
+	step_mode = mode_byte & 0x7F;
+	include_pct = (reqtracker->rtt_type == 0x01 ||
+			reqtracker->rtt_type == 0x02);
+	remote_role = (reqtracker->role == CS_ROLE_INITIATOR) ?
+			CS_ROLE_REFLECTOR : CS_ROLE_INITIATOR;
+
+	switch (step_mode) {
+	case CS_MODE_ZERO:
+		step_payload_len = get_mode_zero_length(remote_role);
+		break;
+	case CS_MODE_ONE:
+		step_payload_len = get_mode_one_length(include_pct);
+		break;
+	case CS_MODE_TWO:
+		step_payload_len = get_mode_two_length(num_antenna_paths);
+		break;
+	case CS_MODE_THREE:
+		step_payload_len = get_mode_three_length(num_antenna_paths,
+								include_pct);
+		break;
+	default:
+		DBG(rap, "  Step %u: unknown mode=%u", step_idx, step_mode);
+		return true;
+	}
+
+	DBG(rap, "  Step %u: mode=%u payload_len=%zu",
+	    step_idx, step_mode, step_payload_len);
+
+	payload = util_iov_pull(iov, step_payload_len);
+	if (!payload) {
+		DBG(rap, "Insufficient data for step %u payload "
+			"(need %zu, have %zu)",
+			step_idx, step_payload_len, iov->iov_len);
+		return false;
+	}
+
+	mode_iov.iov_base = payload;
+	mode_iov.iov_len = step_payload_len;
+
+	switch (step_mode) {
+	case CS_MODE_ZERO:
+		parse_mode_zero(rap, &mode_iov, remote_role);
+		break;
+	case CS_MODE_ONE:
+		parse_mode_one(rap, &mode_iov, remote_role, include_pct);
+		break;
+	case CS_MODE_TWO:
+		parse_mode_two(rap, &mode_iov, num_antenna_paths);
+		break;
+	case CS_MODE_THREE:
+		parse_mode_three(rap, &mode_iov, remote_role, include_pct,
+						num_antenna_paths);
+		break;
+	default:
+		break;
+	}
+
+	return true;
+}
+
+static void parse_subevent_steps(struct bt_rap *rap, struct iovec *iov,
+				struct cstracker *reqtracker,
+				uint8_t num_antenna_paths, uint8_t num_steps)
+{
+	uint8_t i;
+
+	for (i = 0; i < num_steps; i++) {
+		if (!parse_step(rap, iov, reqtracker, num_antenna_paths, i))
+			break;
+	}
+}
+
+static void parse_ras_data_segments(struct bt_rap *rap,
+			       struct cstracker *reqtracker)
+{
+	struct iovec iov;
+	uint8_t antenna_mask;
+	uint8_t num_antenna_paths;
+
+	if (!rap || !reqtracker)
+		return;
+
+	DBG(rap, "Complete RAS data received: %zu bytes",
+	    reqtracker->segment_data.iov_len);
+
+	antenna_mask =
+		ranging_header_get_antenna_mask(&reqtracker->ranging_header_);
+	num_antenna_paths = antenna_mask_count_paths(antenna_mask);
+
+	iov = reqtracker->segment_data;
+
+	while (iov.iov_len >= RAS_SUBEVENT_HEADER_SIZE) {
+		struct ras_subevent_header hdr;
+
+		if (!parse_subevent_header(&iov, &hdr))
+			break;
+
+		DBG(rap, "Parsed subevent: start_acl=%u "
+			"freq_comp=%d ref_pwr=%d steps=%u",
+		    hdr.start_acl_conn_event,
+		    hdr.frequency_compensation,
+		    hdr.reference_power_level,
+		    hdr.num_steps_reported);
+
+		parse_subevent_steps(rap, &iov, reqtracker,
+					num_antenna_paths,
+					hdr.num_steps_reported);
+
+		if (hdr.subevent_done_status ==
+		    SUBEVENT_DONE_ALL_RESULTS_COMPLETE ||
+		    hdr.ranging_done_status ==
+		    RANGING_DONE_ALL_RESULTS_COMPLETE) {
+			DBG(rap, "Ranging procedure complete");
+			break;
+		}
+	}
+
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
@@ -1848,6 +2676,10 @@ static void foreach_rap_char(struct gatt_db_attribute *attr, void *user_data)
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


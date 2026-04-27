Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F953101A0
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289762; cv=none; b=cZXffYKk4P+Mx6O2MLvFuVJHpLsTwSJ9HhQQYrzzgXlUD6C3bCoiITYyDUpy3AfD47iLR7p5UuDt1Mc9043TuQ07LC3PhRWpLsnZhQDGBXnxmMM4v39KTxpD0s9jyRc7IHA3Y6XtA8EqhQkopdTM5RBRHo9LZROG6CGeh0C8Szc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289762; c=relaxed/simple;
	bh=tzDrXZfirpYyKo40xSOJY4RgZJXkvW1WupPgmpIey18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4bOTn7+PdysPS4MEwYO4Ryp7RzVSxyxEQeouLethga2yWzX+Yr3+DBAXop+Uaeydj1zmS+jNYrEUMNP4AHxp4+qeKYUN5pF2fFaeCUgaW1EY2KdQ86zwvUaPGChDZ5ra07XNwmf/rwa7r6iGK0EjXvF9DgWfG14mstkZicxy5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HdX8tLzp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HMaPoKh4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdX8tLzp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HMaPoKh4"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TGAD3682645
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 11:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WoPc/Ej2EgDAWomBRljVfcKl23/sFE7DyU9NGqNGcmw=; b=HdX8tLzpaflB29mL
	S3/IFKWmcup69mSoYip2w2ye3ozw8RE1CO6bHRM4PaeHmgdv92+zSBG2UPBgfOY7
	VKEZgnJywKqHc0d4Uv/GB9iPRU4EfrtjJUbCoTg6QSdCJNCXe791tQihavViklDR
	1AUtB264NRK/uMSzvohmtLCqk+dbZluk3pdeDYZpTTBO774Tss9UnhCW9tiUQupm
	Rrk8E1cSMXZnIbFQUOhTMw6x57xlovYtbMe/Z0VySSqJo5qA95VgouKsZmSsfWVa
	5whSxYuLFURYSR5EcTMfuivvjUUStw6FjPJBX+PmJd6TR41TYz2H72cwjjevVdF8
	7CFpug==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnmr5vpt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 11:35:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24a00d12cso102693325ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 04:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777289753; x=1777894553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoPc/Ej2EgDAWomBRljVfcKl23/sFE7DyU9NGqNGcmw=;
        b=HMaPoKh4qG/V/KCaqF6x683c7TSQT8mONw9ssj8gQ25k7a4qCsXBkx5ITW6s8Pf3/d
         /C3vMuAvdVynMOWBafVC0IGDalWDg7tnu9opQ/JgcT3ltMxIfady7rEZ6+/KIBJcCoCJ
         XeAz0pVCuci7KBE1LhibZ2KxNpuG2/gG6EL/F9YiHtITzcYumt3euDbN7a6udnUzEKMD
         RlvdrgSwVpxn8IBi/vK2QrLI5SjcbXQwyJKoniwkB41GN1sC4nyIL91hmw1oYj3qDZj5
         zaKSeO7SnzD/x37yCoy+AxVf9TjlJRONs5XXbtcZl7ypALpQsVhvkJr2lOtvNUbJc07A
         3lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777289753; x=1777894553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WoPc/Ej2EgDAWomBRljVfcKl23/sFE7DyU9NGqNGcmw=;
        b=UBb1mh160hP5szBg3utgtx4rgp3H7TZhbGwuxV24TmKfKt/UGGnx9NghmNTQEhEaqY
         nyRALATyRUxN/B1Ab9ll6mNP8boCVkblc82ZsYQXyMaDfmYwIl6BDxxKVx0ts1nWJ/3t
         cgQy1GC0Go0A0tes/WKkcJcYq+xOgQnDn0TSuGjeNtSlUcGcVLdi6tMLyFvtSHAL16Id
         0EQWvobttKDejsFLpj/gYP+8XdCIs2j8hU4CmYXQfx6lfWCALIxiiQy02qby1M01ot2v
         bSym08Zd8Gj0PojvH9K7YdnEPCEKugFzPSHZDAje+2IHCGcH6JAOVlyY8D4Ye+L1GBke
         VwCA==
X-Gm-Message-State: AOJu0YzgPR2l3ZIoEUVJiieitNXOZD/5Q4+wbJuEe4jo6MVewe8dkRGB
	rtrslcVc8ERwL+bKFMvfN+uPh/b+AUO2mV3xjVSGZTxGkYB22OaN+Pf9CiYxqDEXDm+2ZvEo/BS
	ZrwJnpMewqMkSD4lk5ouG4bcQ0TSt9h/pEL9Hb90pQ6obCUFEn9dO6LxDITF0HboyE7nAn1G2G/
	AGEAo=
X-Gm-Gg: AeBDiettzaVYw0TpZG8XQcajSn+6y6Q1mkyXeKxUmoSkrJqOYy9u9wE9gPC3u1IG4nn
	0HeP/TEawIInJx3iPcjJU+BrYu+4kJ+nlEzIcN3K1dHFuj86wismF5cR5z10TSYwEIJlG2bOMyi
	AFhOZ4SXUPxg1vMt4OS+FPNDIyggxCs4K5csZZDBLqiROOyiC+leeKGVuZpD+yIZxXXybhCiajX
	VCfWlNJaoeCvwZwqhHI670lwBv5XgMPFh9hZd7xabgOEDPGf/vFz/MBRgLxGuAA41XZH6b8AdFm
	cobJFajkeY1TMSClKc7w536xhN5CJXFf7Fz/Y/YizjmTh7PZp3nOH7oOuwXFpzIUBXkCPjOBHgC
	H4DK6BwRpFyVqomXLGVpPrmIsoIckN3pApCj13XKc3iR+2/gIC+KGGg==
X-Received: by 2002:a17:903:3b88:b0:2b2:ec31:25be with SMTP id d9443c01a7336-2b5f9f35acamr406205335ad.24.1777289752339;
        Mon, 27 Apr 2026 04:35:52 -0700 (PDT)
X-Received: by 2002:a17:903:3b88:b0:2b2:ec31:25be with SMTP id d9443c01a7336-2b5f9f35acamr406204835ad.24.1777289751478;
        Mon, 27 Apr 2026 04:35:51 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1763dsm282921055ad.23.2026.04.27.04.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 04:35:51 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v3 1/3] Add RAS packet formatting and notification support for CS reflector
Date: Mon, 27 Apr 2026 17:05:42 +0530
Message-Id: <20260427113544.1063560-2-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427113544.1063560-1-prathm@qti.qualcomm.com>
References: <20260427113544.1063560-1-prathm@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aqCCzyZV c=1 sm=1 tr=0 ts=69ef4a1a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=n4o-OkwBxEp8FnJwIMgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: ca2sogzkLleYj_K5MAsTvMUePS9a03-7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyMyBTYWx0ZWRfX0fdyDS4+VT77
 qX5m03G0MpcPw+DlDoznO7sbKyAZ8bHjxL8AolaR9GTMCj4x04v46nGhn8mYOrl3KyUOcNCuvKQ
 IVLKq6g0k5umMhGUGyJp3328T3wmi5J9Qh4cUCIRmRx9zBsKiXoCRtZOjb2tnPKTXeS7UfxK1/x
 0npcjTJ8SeU+Jv9YVdkEddfAUKNG4W1wd5j4/H9AgKC2tvnkv+PVmT4BPP1puwD/PGV1TV2r+RQ
 4gd9RQZqUgOrZoNKw+DPgBBu4CWHCc1tPi5S05QEg9PSqOlFTZnmkG5XOOm2RG0F+fBrw07Uphf
 Kn5LEzTR6ttu2B1QEZ3ObbAituvMRJWQkX5qVYR+PeeFN0egUufqc3OGoi489u7FOYWg5SgM2VZ
 l4KA1anXOBTF2ci1boSmraAOGzOba4onztIA2fynFh5TDyMxmWxcY1VEuC+ZIWtSEi+A88oRHIG
 glgZ5aNTYFBHLLK8T6A==
X-Proofpoint-ORIG-GUID: ca2sogzkLleYj_K5MAsTvMUePS9a03-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270123

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Implement complete RAS data pipeline:
 - Handle HCI CS subevent result/continuation events
 - Serialize ranging/subevent headers per spec
 - GATT notifications for real-time ranging data

---
 src/shared/rap.c | 1376 +++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/rap.h |    4 +-
 2 files changed, 1366 insertions(+), 14 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index ac6de04e0..5a08e023f 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -33,6 +33,170 @@
 /* Total number of attribute handles reserved for the RAS service */
 #define RAS_TOTAL_NUM_HANDLES		18
 
+/* 2(rc+cfg) + 1(tx_pwr) + 1(4 bits antenna_mask, 2 bits reserved,
+ * 2 bits pct_format)
+ */
+#define RAS_RANGING_HEADER_SIZE 4
+#define TOTAL_RAS_RANGING_HEADER_SIZE 5
+#define ATT_OVERHEAD 3 /* 1(opcode) + 2(char handle) */
+#define RAS_STEP_ABORTED_BIT   0x80/* set step aborted */
+#define RAS_SUBEVENT_HEADER_SIZE 8
+
+enum pct_format {
+	IQ = 0,
+	PHASE = 1,
+};
+
+enum ranging_done_status {
+	RANGING_DONE_ALL_RESULTS_COMPLETE = 0x0,
+	RANGING_DONE_PARTIAL_RESULTS = 0x1,
+	RANGING_DONE_ABORTED = 0xF,
+};
+
+enum subevent_done_status {
+	SUBEVENT_DONE_ALL_RESULTS_COMPLETE = 0x0,
+	SUBEVENT_DONE_PARTIAL_RESULTS = 0x1,
+	SUBEVENT_DONE_ABORTED = 0xF,
+};
+
+enum ranging_abort_reason {
+	RANGING_ABORT_NO_ABORT = 0x0,
+	RANGING_ABORT_LOCAL_HOST_OR_REMOTE = 0x1,
+	RANGING_ABORT_INSUFFICIENT_FILTERED_CHANNELS = 0x2,
+	RANGING_ABORT_INSTANT_HAS_PASSED = 0x3,
+	RANGING_ABORT_UNSPECIFIED = 0xF,
+};
+
+enum subevent_abort_reason {
+	SUBEVENT_ABORT_NO_ABORT = 0x0,
+	SUBEVENT_ABORT_LOCAL_HOST_OR_REMOTE = 0x1,
+	SUBEVENT_ABORT_NO_CS_SYNC_RECEIVED = 0x2,
+	SUBEVENT_ABORT_SCHEDULING_CONFLICTS_OR_LIMITED_RESOURCES = 0x3,
+	SUBEVENT_ABORT_UNSPECIFIED = 0xF,
+};
+
+/* Segmentation header: 1 byte
+ * bit 0: first_segment
+ * bit 1: last_segment
+ * bits 2-7: rolling_segment_counter (6 bits)
+ */
+struct segmentation_header {
+	uint8_t first_segment;
+	uint8_t last_segment;
+	uint8_t rolling_segment_counter;
+};
+
+/* Macros to pack/unpack segmentation header */
+#define SEG_HDR_PACK(first, last, counter) \
+	((uint8_t)(((first) ? 0x01 : 0x00) | \
+		((last) ? 0x02 : 0x00) | \
+		(((counter) & 0x3F) << 2)))
+
+#define SEG_HDR_UNPACK_FIRST(byte)    ((byte) & 0x01)
+#define SEG_HDR_UNPACK_LAST(byte)     (((byte) >> 1) & 0x01)
+#define SEG_HDR_UNPACK_COUNTER(byte)  (((byte) >> 2) & 0x3F)
+
+/* Ranging header: 4 bytes
+ * 0-1: ranging_counter (12 bits) | configuration_id (4 bits)
+ *      [little-endian]
+ * byte 2: selected_tx_power (signed)
+ * byte 3: antenna_paths_mask (4 bits) | reserved (2 bits) |
+ *         pct_format (2 bits)
+ */
+struct ranging_header {
+	uint16_t ranging_counter;
+	uint8_t configuration_id;
+	int8_t selected_tx_power;
+	uint8_t antenna_paths_mask;
+	uint8_t pct_format;
+} __packed;
+
+/* Macros to pack/unpack ranging header */
+#define RANGING_HDR_PACK_BYTE0_1(rc, cfg) \
+	((uint16_t)(((rc) & 0x0FFF) | (((cfg) & 0x0F) << 12)))
+
+#define RANGING_HDR_PACK_BYTE3(ant_mask, pct_fmt) \
+	((uint8_t)(((ant_mask) & 0x0F) | (((pct_fmt) & 0x03) << 6)))
+
+#define RANGING_HDR_UNPACK_RC(byte0_1) \
+	((uint16_t)((byte0_1) & 0x0FFF))
+
+#define RANGING_HDR_UNPACK_CFG(byte0_1) \
+	((uint8_t)(((byte0_1) >> 12) & 0x0F))
+
+#define RANGING_HDR_UNPACK_ANT_MASK(byte3) \
+	((uint8_t)((byte3) & 0x0F))
+
+#define RANGING_HDR_UNPACK_PCT_FMT(byte3) \
+	((uint8_t)(((byte3) >> 6) & 0x03))
+
+struct ras_subevent_header {
+	uint16_t start_acl_conn_event;
+	uint16_t frequency_compensation;
+	uint8_t ranging_done_status;
+	uint8_t subevent_done_status;
+	uint8_t ranging_abort_reason;
+	uint8_t subevent_abort_reason;
+	int8_t reference_power_level;
+	uint8_t num_steps_reported;
+};
+
+struct ras_subevent {
+	struct ras_subevent_header subevent_header;
+	uint8_t subevent_data[];
+};
+
+/* Role maps to Core CS roles (initiator/reflector) */
+enum cs_role {
+	CS_ROLE_INITIATOR = 0x00,
+	CS_ROLE_REFLECTOR = 0x01,
+};
+
+#define CS_INVALID_CONFIG_ID   0xFF
+/* Minimal enums (align to controller values if needed) */
+enum cs_procedure_done_status {
+	CS_PROC_ALL_RESULTS_COMPLETE = 0x00,
+	CS_PROC_PARTIAL_RESULTS      = 0x01,
+	CS_PROC_ABORTED              = 0x02
+};
+
+/* Main cs_procedure_data  */
+struct cs_procedure_data {
+	/* Identity and counters */
+	uint16_t counter;
+	uint8_t  num_antenna_paths;
+	/* Flags and status */
+	enum cs_procedure_done_status local_status;
+	enum cs_procedure_done_status remote_status;
+	bool contains_complete_subevent_;
+	/* RAS aggregation */
+	struct segmentation_header segmentation_header_;
+	struct ranging_header      ranging_header_;
+	struct iovec       ras_raw_data_;        /* raw concatenated */
+	uint16_t           ras_raw_data_index_;
+	struct ras_subevent_header  ras_subevent_header_;
+	struct iovec       ras_subevent_data_;   /* buffer per subevent */
+	uint8_t            ras_subevent_counter_;
+	/* Reference power levels */
+	int8_t initiator_reference_power_level;
+	int8_t reflector_reference_power_level;
+	bool ranging_header_prepended_;
+	bool ras_subevent_header_emitted;
+};
+
+struct cstracker {
+	enum cs_role        role;                 /* INITIATOR/REFLECTOR */
+	uint8_t             config_id;            /* CS_INVALID_CONFIG_ID */
+	uint8_t             selected_tx_power;    /* PROC_ENABLE_COMPLETE */
+	uint8_t             rtt_type;             /* RTT type */
+	struct cs_procedure_data *current_proc;
+	/* Cached header values for CONT events (per-connection state) */
+	uint16_t last_proc_counter;
+	uint16_t last_start_acl_conn_evt_counter;
+	uint16_t last_freq_comp;
+	int8_t last_ref_pwr_lvl;
+};
+
 /* Ranging Service context */
 struct ras {
 	struct bt_rap_db *rapdb;
@@ -43,9 +207,17 @@ struct ras {
 	struct gatt_db_attribute *realtime_chrc;
 	struct gatt_db_attribute *realtime_chrc_ccc;
 	struct gatt_db_attribute *ondemand_chrc;
+	struct gatt_db_attribute *ondemand_ccc;
 	struct gatt_db_attribute *cp_chrc;
+	struct gatt_db_attribute *cp_ccc;
 	struct gatt_db_attribute *ready_chrc;
+	struct gatt_db_attribute *ready_ccc;
 	struct gatt_db_attribute *overwritten_chrc;
+	struct gatt_db_attribute *overwritten_ccc;
+
+	/* CCC state tracking for mutual exclusivity */
+	uint16_t realtime_ccc_value;
+	uint16_t ondemand_ccc_value;
 };
 
 struct bt_rap_db {
@@ -70,6 +242,7 @@ struct bt_rap {
 	bt_rap_destroy_func_t debug_destroy;
 	void *debug_data;
 	void *user_data;
+	struct cstracker *resptracker;
 };
 
 static struct queue *rap_db;
@@ -90,6 +263,209 @@ struct bt_rap_ready {
 	void *data;
 };
 
+uint16_t default_ras_mtu = 247; /*Section 3.1.2 of RAP 1.0*/
+uint8_t ras_segment_header_size = 1;
+
+static struct cs_procedure_data *cs_procedure_data_create(
+					uint16_t procedure_counter,
+					uint8_t num_antenna_paths,
+					uint8_t configuration_id,
+					uint8_t selected_tx_power)
+{
+	struct cs_procedure_data *d;
+	uint8_t i;
+
+	d = calloc(1, sizeof(struct cs_procedure_data));
+
+	if (!d)
+		return NULL;
+
+	d->counter = procedure_counter;
+	d->num_antenna_paths = num_antenna_paths;
+	d->local_status = CS_PROC_PARTIAL_RESULTS;
+	d->remote_status = CS_PROC_PARTIAL_RESULTS;
+	d->contains_complete_subevent_ = false;
+	d->segmentation_header_.first_segment = 1;
+	d->segmentation_header_.last_segment = 0;
+	d->segmentation_header_.rolling_segment_counter = 0;
+	d->ranging_header_.ranging_counter = procedure_counter;
+	d->ranging_header_.configuration_id = configuration_id;
+	d->ranging_header_.selected_tx_power = selected_tx_power;
+	d->ranging_header_.antenna_paths_mask = 0;
+
+	for (i = 0; i < num_antenna_paths; i++)
+		d->ranging_header_.antenna_paths_mask |= (1u << i);
+
+	d->ranging_header_.pct_format = IQ;
+	memset(&d->ras_raw_data_, 0, sizeof(d->ras_raw_data_));
+	d->ras_raw_data_index_ = 0;
+	memset(&d->ras_subevent_data_, 0, sizeof(d->ras_subevent_data_));
+	d->ras_subevent_counter_ = 0;
+	d->initiator_reference_power_level = 0;
+	d->reflector_reference_power_level = 0;
+	d->ranging_header_prepended_ = false;
+	d->ras_subevent_header_emitted = false;
+
+	return d;
+}
+
+static void cs_procedure_data_destroy(struct cs_procedure_data *d)
+{
+	if (!d)
+		return;
+
+	free(d->ras_raw_data_.iov_base);
+	free(d->ras_subevent_data_.iov_base);
+	free(d);
+}
+
+static void cs_pd_set_local_status(struct cs_procedure_data *d,
+				enum cs_procedure_done_status s)
+{
+	if (d)
+		d->local_status = s;
+}
+
+static void cs_pd_set_remote_status(struct cs_procedure_data *d,
+				enum cs_procedure_done_status s)
+{
+	if (d)
+		d->remote_status = s;
+}
+
+static void cs_pd_set_reference_power_levels(struct cs_procedure_data *d,
+					int8_t init_lvl, int8_t ref_lvl)
+{
+	if (!d)
+		return;
+
+	d->initiator_reference_power_level = init_lvl;
+	d->reflector_reference_power_level = ref_lvl;
+}
+
+static void cs_pd_ras_begin_subevent(struct cs_procedure_data *d,
+				uint16_t start_acl_conn_event,
+				uint16_t frequency_compensation,
+				int8_t reference_power_level)
+{
+	if (!d)
+		return;
+
+	d->ras_subevent_counter_++;
+	d->ras_subevent_header_.start_acl_conn_event = start_acl_conn_event;
+	d->ras_subevent_header_.frequency_compensation =
+		frequency_compensation;
+	d->ras_subevent_header_.reference_power_level = reference_power_level;
+	d->ras_subevent_header_.num_steps_reported = 0;
+	d->ras_subevent_header_emitted = false;
+	d->ras_subevent_data_.iov_len = 0;
+}
+
+static bool cs_pd_ras_append_subevent_bytes(struct cs_procedure_data *d,
+					const uint8_t *bytes, size_t len)
+{
+	if (!d || !bytes || len == 0)
+		return false;
+
+	return util_iov_append(&d->ras_subevent_data_, bytes, len) != NULL;
+}
+
+static inline size_t serialize_ras_subevent_header(
+				const struct ras_subevent_header *h,
+				uint8_t *out, size_t out_len)
+{
+	uint16_t start_le;
+	uint16_t freq_le;
+
+	if (!h || !out || out_len < RAS_SUBEVENT_HEADER_SIZE)
+		return 0;
+
+	start_le = (uint16_t)h->start_acl_conn_event;
+	out[0] = (uint8_t)(start_le & 0xFF);
+	out[1] = (uint8_t)((start_le >> 8) & 0xFF);
+
+	freq_le = (uint16_t)h->frequency_compensation;
+	out[2] = (uint8_t)(freq_le & 0xFF);
+	out[3] = (uint8_t)((freq_le >> 8) & 0xFF);
+
+	out[4] = (uint8_t)((h->ranging_done_status & 0x0F) |
+			((h->subevent_done_status & 0x0F) << 4));
+
+	out[5] = (uint8_t)((h->ranging_abort_reason & 0x0F) |
+			((h->subevent_abort_reason & 0x0F) << 4));
+
+	out[6] = (uint8_t)h->reference_power_level;
+	out[7] = (uint8_t)h->num_steps_reported;
+
+	return RAS_SUBEVENT_HEADER_SIZE;
+}
+
+static bool cs_pd_ras_commit_subevent(struct cs_procedure_data *d,
+				uint8_t num_steps_reported,
+				uint8_t ranging_done_status,
+				uint8_t subevent_done_status,
+				uint8_t ranging_abort_reason,
+				uint8_t subevent_abort_reason)
+{
+	size_t hdr_sz;
+	size_t payload_sz;
+	size_t total;
+	uint8_t *buf;
+	size_t w;
+	bool ok;
+
+	if (!d)
+		return false;
+
+	d->ras_subevent_header_.num_steps_reported =
+		(uint8_t)(d->ras_subevent_header_.num_steps_reported +
+			num_steps_reported);
+	d->ras_subevent_header_.ranging_done_status = ranging_done_status;
+	d->ras_subevent_header_.subevent_done_status = subevent_done_status;
+	d->ras_subevent_header_.ranging_abort_reason = ranging_abort_reason;
+	d->ras_subevent_header_.subevent_abort_reason = subevent_abort_reason;
+
+	if (subevent_done_status == SUBEVENT_DONE_ALL_RESULTS_COMPLETE)
+		d->contains_complete_subevent_ = true;
+
+	if (subevent_done_status == SUBEVENT_DONE_PARTIAL_RESULTS)
+		return true;
+
+	if (!d->ras_subevent_header_emitted) {
+		hdr_sz = RAS_SUBEVENT_HEADER_SIZE;
+		payload_sz = d->ras_subevent_data_.iov_len;
+		total = hdr_sz + payload_sz;
+		buf = (uint8_t *)malloc(total);
+
+		if (!buf)
+			return false;
+
+		w = serialize_ras_subevent_header(&d->ras_subevent_header_,
+						buf, total);
+
+		if (w != hdr_sz) {
+			free(buf);
+			return false;
+		}
+
+		if (payload_sz > 0)
+			memcpy(buf + hdr_sz,
+				(const uint8_t *)d->ras_subevent_data_.iov_base,
+				payload_sz);
+
+		ok = util_iov_append(&d->ras_raw_data_, buf, total) != NULL;
+		free(buf);
+
+		if (!ok)
+			return false;
+
+		d->ras_subevent_data_.iov_len = 0;
+		d->ras_subevent_header_emitted = true;
+	}
+
+	return true;
+}
+
 static struct ras *rap_get_ras(struct bt_rap *rap)
 {
 	if (!rap)
@@ -155,6 +531,11 @@ static void rap_free(void *data)
 
 	rap_db_free(rap->rrapdb);
 
+	if (rap->resptracker) {
+		free(rap->resptracker);
+		rap->resptracker = NULL;
+	}
+
 	queue_destroy(rap->notify, free);
 	queue_destroy(rap->pending, NULL);
 	queue_destroy(rap->ready_cbs, rap_ready_free);
@@ -240,6 +621,22 @@ bool bt_rap_set_debug(struct bt_rap *rap, bt_rap_debug_func_t func,
 	return true;
 }
 
+static void cs_tracker_init(struct cstracker *t)
+{
+	if (!t)
+		return;
+
+	memset(t, 0, sizeof(*t));
+	t->role = CS_ROLE_REFLECTOR;
+	t->config_id = CS_INVALID_CONFIG_ID;
+	t->rtt_type = 0;
+	t->selected_tx_power = 0;
+	t->last_proc_counter = 0;
+	t->last_start_acl_conn_evt_counter = 0;
+	t->last_freq_comp = 0;
+	t->last_ref_pwr_lvl = 0;
+}
+
 static void ras_features_read_cb(struct gatt_db_attribute *attrib,
 				 unsigned int id, uint16_t offset,
 				 uint8_t opcode, struct bt_att *att,
@@ -304,6 +701,225 @@ static void ras_data_overwritten_read_cb(struct gatt_db_attribute *attrib,
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
 
+/* CCC write callbacks for custom handling */
+static void ras_realtime_ccc_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct ras *ras = user_data;
+	uint16_t ccc_value;
+
+	if (!ras) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_UNLIKELY);
+		return;
+	}
+
+	if (offset) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_INVALID_OFFSET);
+		return;
+	}
+
+	if (len != 2) {
+		gatt_db_attribute_write_result(attrib, id,
+			BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN);
+		return;
+	}
+
+	ccc_value = get_le16(value);
+
+	if (ccc_value != 0x0000 && ccc_value != 0x0001 &&
+	    ccc_value != 0x0002 && ccc_value != 0x0003) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ERROR_WRITE_REQUEST_REJECTED);
+		return;
+	}
+
+	/* Check mutual exclusivity: reject if trying to enable realtime
+	 * while ondemand is already enabled
+	 */
+	if (ccc_value != 0x0000 && ras->ondemand_ccc_value != 0x0000) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ERROR_CCC_IMPROPERLY_CONFIGURED);
+		return;
+	}
+
+	/* Update state */
+	ras->realtime_ccc_value = ccc_value;
+
+	gatt_db_attribute_write_result(attrib, id, 0);
+}
+
+static void ras_ondemand_ccc_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct ras *ras = user_data;
+	uint16_t ccc_value;
+
+	if (!ras) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_UNLIKELY);
+		return;
+	}
+
+	if (offset) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_INVALID_OFFSET);
+		return;
+	}
+
+	if (len != 2) {
+		gatt_db_attribute_write_result(attrib, id,
+				BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN);
+		return;
+	}
+
+	ccc_value = get_le16(value);
+
+	if (ccc_value != 0x0000 && ccc_value != 0x0001 && ccc_value != 0x0002 &&
+	    ccc_value != 0x0003) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ERROR_WRITE_REQUEST_REJECTED);
+		return;
+	}
+
+	/* Check mutual exclusivity: reject if trying to enable ondemand
+	 * while realtime is already enabled
+	 */
+	if (ccc_value != 0x0000 && ras->realtime_ccc_value != 0x0000) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ERROR_CCC_IMPROPERLY_CONFIGURED);
+		return;
+	}
+
+	/* Update state */
+	ras->ondemand_ccc_value = ccc_value;
+
+	gatt_db_attribute_write_result(attrib, id, 0);
+}
+
+static void ras_cp_ccc_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct ras *ras = user_data;
+	uint16_t ccc_value;
+
+	if (!ras) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_UNLIKELY);
+		return;
+	}
+
+	if (offset) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_INVALID_OFFSET);
+		return;
+	}
+
+	if (len != 2) {
+		gatt_db_attribute_write_result(attrib, id,
+			BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN);
+		return;
+	}
+
+	ccc_value = get_le16(value);
+
+	if (ccc_value != 0x0000 && ccc_value != 0x0001 &&
+	    ccc_value != 0x0002) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ERROR_WRITE_REQUEST_REJECTED);
+		return;
+	}
+
+	gatt_db_attribute_write_result(attrib, id, 0);
+}
+
+static void ras_ready_ccc_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct ras *ras = user_data;
+	uint16_t ccc_value;
+
+	if (!ras) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_UNLIKELY);
+		return;
+	}
+
+	if (offset) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_INVALID_OFFSET);
+		return;
+	}
+
+	if (len != 2) {
+		gatt_db_attribute_write_result(attrib, id,
+			BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN);
+		return;
+	}
+
+	ccc_value = get_le16(value);
+
+	if (ccc_value != 0x0000 && ccc_value != 0x0001 &&
+	    ccc_value != 0x0002 && ccc_value != 0x0003) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ERROR_WRITE_REQUEST_REJECTED);
+		return;
+	}
+
+	gatt_db_attribute_write_result(attrib, id, 0);
+}
+
+static void ras_overwritten_ccc_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct ras *ras = user_data;
+	uint16_t ccc_value;
+
+	if (!ras) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_UNLIKELY);
+		return;
+	}
+
+	if (offset) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_INVALID_OFFSET);
+		return;
+	}
+
+	if (len != 2) {
+		gatt_db_attribute_write_result(attrib, id,
+			BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN);
+		return;
+	}
+
+	ccc_value = get_le16(value);
+
+	if (ccc_value != 0x0000 && ccc_value != 0x0001 &&
+	    ccc_value != 0x0002 && ccc_value != 0x0003) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ERROR_WRITE_REQUEST_REJECTED);
+		return;
+	}
+
+	gatt_db_attribute_write_result(attrib, id, 0);
+}
 /* Service registration – store attribute pointers */
 static struct ras *register_ras_service(struct gatt_db *db)
 {
@@ -349,9 +965,9 @@ static struct ras *register_ras_service(struct gatt_db *db)
 						  NULL, NULL, ras);
 
 	ras->realtime_chrc_ccc =
-		gatt_db_service_add_ccc(ras->svc,
-					BT_ATT_PERM_READ |
-					BT_ATT_PERM_WRITE);
+		gatt_db_service_add_ccc_custom(ras->svc,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+					ras_realtime_ccc_write_cb, ras);
 
 	/* On-demand Ranging Data */
 	bt_uuid16_create(&uuid, RAS_ONDEMAND_DATA_UUID);
@@ -364,8 +980,9 @@ static struct ras *register_ras_service(struct gatt_db *db)
 						  ras_ondemand_read_cb, NULL,
 						  ras);
 
-	gatt_db_service_add_ccc(ras->svc,
-				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+	ras->ondemand_ccc = gatt_db_service_add_ccc_custom(ras->svc,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+					ras_ondemand_ccc_write_cb, ras);
 
 	/* RAS Control Point */
 	bt_uuid16_create(&uuid, RAS_CONTROL_POINT_UUID);
@@ -379,8 +996,9 @@ static struct ras *register_ras_service(struct gatt_db *db)
 						  ras_control_point_write_cb,
 						  ras);
 
-	gatt_db_service_add_ccc(ras->svc,
-				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+	ras->cp_ccc = gatt_db_service_add_ccc_custom(ras->svc,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+					ras_cp_ccc_write_cb, ras);
 
 	/* RAS Data Ready */
 	bt_uuid16_create(&uuid, RAS_DATA_READY_UUID);
@@ -394,8 +1012,9 @@ static struct ras *register_ras_service(struct gatt_db *db)
 						  ras_data_ready_read_cb, NULL,
 						  ras);
 
-	gatt_db_service_add_ccc(ras->svc,
-				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+	ras->ready_ccc = gatt_db_service_add_ccc_custom(ras->svc,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+					ras_ready_ccc_write_cb, ras);
 
 	/* RAS Data Overwritten */
 	bt_uuid16_create(&uuid, RAS_DATA_OVERWRITTEN_UUID);
@@ -409,8 +1028,9 @@ static struct ras *register_ras_service(struct gatt_db *db)
 						  ras_data_overwritten_read_cb,
 						  NULL, ras);
 
-	gatt_db_service_add_ccc(ras->svc,
-				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+	ras->overwritten_ccc = gatt_db_service_add_ccc_custom(ras->svc,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+					ras_overwritten_ccc_write_cb, ras);
 
 	/* Activate the service */
 	gatt_db_service_set_active(ras->svc, true);
@@ -503,32 +1123,746 @@ bool bt_rap_unregister(unsigned int id)
 	return true;
 }
 
+static inline size_t serialize_segmentation_header(
+				const struct segmentation_header *s,
+				uint8_t *out, size_t out_len)
+{
+	if (!s || !out || out_len < 1)
+		return 0;
+
+	/* [0] bit0: first, bit1: last, bits2..7: rolling counter */
+	out[0] = (s->first_segment ? 0x01 : 0x00) |
+		(s->last_segment ? 0x02 : 0x00) |
+		((s->rolling_segment_counter & 0x3F) << 2);
+
+	return 1;
+}
+
+static inline size_t serialize_ranging_header(const struct ranging_header *r,
+						uint8_t *out, size_t out_len)
+{
+	uint16_t rcid;
+
+	if (!r || !out || out_len < RAS_RANGING_HEADER_SIZE)
+		return 0;
+
+	/* Little-endian pack: [rc (12 bits) | cfg_id (4 bits)] */
+	rcid = RANGING_HDR_PACK_BYTE0_1(r->ranging_counter,
+					r->configuration_id);
+
+	put_le16(rcid, out + 0);
+	out[2] = (uint8_t)r->selected_tx_power;
+	/* Byte 3: antenna_paths_mask | reserved | pct_format */
+	out[3] = RANGING_HDR_PACK_BYTE3(r->antenna_paths_mask,
+					r->pct_format);
+
+	return RAS_RANGING_HEADER_SIZE;
+}
+
+static inline uint16_t ras_att_value_payload_max(struct bt_rap *rap)
+{
+	struct bt_att *att = bt_rap_get_att(rap);
+	uint16_t mtu = att ? bt_att_get_mtu(att) : default_ras_mtu;
+
+	return (uint16_t)(mtu > ATT_OVERHEAD ?
+		(mtu - ATT_OVERHEAD - TOTAL_RAS_RANGING_HEADER_SIZE -
+		ras_segment_header_size) : 0);
+}
+
+/* Prepend data to an iovec */
+static bool iov_prepend_bytes(struct iovec *iov, const uint8_t *bytes,
+				size_t len)
+{
+	size_t new_len;
+	void *new_base;
+
+	if (!iov || !bytes || len == 0)
+		return false;
+
+	new_len = iov->iov_len + len;
+	new_base = malloc(new_len);
+
+	if (!new_base)
+		return false;
+
+	memcpy(new_base, bytes, len);
+
+	if (iov->iov_len > 0)
+		memcpy((uint8_t *)new_base + len, iov->iov_base,
+			iov->iov_len);
+
+	free(iov->iov_base);
+	iov->iov_base = new_base;
+	iov->iov_len = new_len;
+
+	return true;
+}
+
+/* Append the 4-byte RangingHeader to ras_raw_data_ on first segment */
+static bool ras_maybe_prepend_ranging_header(struct cs_procedure_data *d)
+{
+	uint8_t hdr[RAS_RANGING_HEADER_SIZE];
+	size_t w;
+	bool ok;
+
+	if (!d)
+		return false;
+
+	if (d->ranging_header_prepended_)
+		return false;
+
+	if (!d->segmentation_header_.first_segment)
+		return false;
+
+	if (d->ras_raw_data_index_ != 0)
+		return false;
+
+	w = serialize_ranging_header(&d->ranging_header_, hdr, sizeof(hdr));
+
+	if (w != RAS_RANGING_HEADER_SIZE)
+		return false;
+
+	ok = iov_prepend_bytes(&d->ras_raw_data_, hdr, w);
+
+	if (ok)
+		d->ranging_header_prepended_ = true;
+
+	return ok;
+}
+
+static void send_ras_segment_data(struct bt_rap *rap,
+				struct cs_procedure_data *proc)
+{
+	struct ras *ras;
+	uint16_t value_max;
+	const uint16_t header_len = ras_segment_header_size;
+	uint16_t raw_payload_size;
+	bool ok;
+
+	if (!rap || !proc)
+		return;
+
+	if (!rap->lrapdb || !rap->lrapdb->ras)
+		return;
+	ras = rap->lrapdb->ras;
+	value_max = ras_att_value_payload_max(rap);
+
+	if (value_max == 0) {
+		DBG(rap, "value_max=0 (MTU not available?)");
+		return;
+	}
+
+	if (value_max <= header_len) {
+		DBG(rap, "value_max(%u) too small for header", value_max);
+		return;
+	}
+
+	raw_payload_size = (uint16_t)(value_max - header_len);
+
+	/* Convert tail recursion to loop */
+	while (true) {
+		size_t total_len = proc->ras_raw_data_.iov_len;
+		size_t index = proc->ras_raw_data_index_;
+		size_t unsent_data_size;
+		uint16_t copy_size;
+		uint16_t seg_len;
+		uint8_t *seg;
+		uint16_t wr = 0;
+
+		if (index > total_len)
+			index = total_len;
+
+		unsent_data_size = total_len - index;
+
+		if (unsent_data_size == 0)
+			return;
+
+		/* Set last_segment if procedure complete or fits in segment */
+		if ((proc->local_status != CS_PROC_PARTIAL_RESULTS &&
+				unsent_data_size <= raw_payload_size) ||
+			(proc->contains_complete_subevent_ &&
+				unsent_data_size <= raw_payload_size)) {
+			proc->segmentation_header_.last_segment = 1;
+		} else {
+			proc->segmentation_header_.last_segment = 0;
+		}
+
+		/* Wait for more data if needed and not last segment */
+		if (unsent_data_size < raw_payload_size &&
+				proc->segmentation_header_.last_segment == 0) {
+			DBG(rap, "waiting for more data (unsent=%zu < "
+				"payload=%u)", unsent_data_size,
+				raw_payload_size);
+			return;
+		}
+
+		copy_size = (uint16_t)((unsent_data_size < raw_payload_size) ?
+				unsent_data_size : raw_payload_size);
+		seg_len = (uint16_t)(header_len + copy_size);
+		seg = (uint8_t *)malloc(seg_len);
+
+		if (!seg) {
+			DBG(rap, "OOM (%u)", seg_len);
+			return;
+		}
+
+		wr += (uint16_t)serialize_segmentation_header(
+				&proc->segmentation_header_, seg + wr,
+				seg_len - wr);
+		memcpy(seg + wr,
+			(const uint8_t *)proc->ras_raw_data_.iov_base + index,
+			copy_size);
+		wr += copy_size;
+
+		/* Try sending to real-time characteristic */
+		if (ras->realtime_chrc)
+			ok = gatt_db_attribute_notify(ras->realtime_chrc, seg,
+						wr, bt_rap_get_att(rap));
+
+		/* Try sending to on-demand characteristic */
+		if (ras->ondemand_chrc)
+			ok = gatt_db_attribute_notify(ras->ondemand_chrc, seg,
+						wr, bt_rap_get_att(rap));
+
+		free(seg);
+
+		if (!ok) {
+			DBG(rap, "Failed to send RAS notification");
+			return;
+		}
+
+		/* Advance read cursor and update segmentation state */
+		proc->ras_raw_data_index_ += copy_size;
+		proc->segmentation_header_.first_segment = 0;
+		proc->segmentation_header_.rolling_segment_counter =
+			(uint8_t)((proc->segmentation_header_
+				.rolling_segment_counter + 1) & 0x3F);
+
+		if (proc->segmentation_header_.last_segment ||
+				proc->ras_raw_data_index_ >=
+				proc->ras_raw_data_.iov_len) {
+			DBG(rap, "RAS clear ras buffers");
+			proc->ras_raw_data_.iov_len = 0;
+			proc->ras_raw_data_index_ = 0;
+			proc->ranging_header_prepended_ = false;
+			return;
+		}
+	}
+}
+
+static inline void resptracker_reset_current_proc(struct cstracker *t)
+{
+	if (!t)
+		return;
+
+	if (t->current_proc) {
+		cs_procedure_data_destroy(t->current_proc);
+		t->current_proc = NULL;
+	}
+}
+/* Unified local subevent handler */
+static void handle_local_subevent_result(struct bt_rap *rap,
+					bool has_header_fields,
+					uint8_t config_id,
+					uint8_t num_ant_paths,
+					uint16_t proc_counter,
+					uint16_t start_acl_conn_evt_counter,
+					uint16_t freq_comp,
+					int8_t  ref_pwr_lvl,
+					uint8_t proc_done_status,
+					uint8_t subevt_done_status,
+					uint8_t abort_reason,
+					uint8_t num_steps_reported,
+					const void *step_bytes)
+{
+	struct cstracker *resptracker;
+	struct cs_procedure_data *proc;
+	const struct cs_step_data *steps;
+	uint8_t idx;
+
+	if (!rap || !rap->resptracker || !step_bytes)
+		return;
+
+	resptracker = rap->resptracker;
+
+	if (resptracker->current_proc) {
+		struct cs_procedure_data *cur = resptracker->current_proc;
+
+		if (has_header_fields && cur->counter != proc_counter) {
+			/* Safety: a new procedure; destroy the previous one */
+			resptracker_reset_current_proc(resptracker);
+		}
+	}
+
+	proc = resptracker->current_proc;
+	/* Cache header info from a RESULT event for later CONT usage */
+	if (has_header_fields) {
+		resptracker->last_proc_counter = proc_counter;
+		resptracker->last_start_acl_conn_evt_counter =
+			start_acl_conn_evt_counter;
+		resptracker->last_freq_comp = freq_comp;
+		resptracker->last_ref_pwr_lvl = ref_pwr_lvl;
+	}
+
+	/* Create the procedure on first use */
+	if (!proc) {
+		uint16_t create_counter = has_header_fields ? proc_counter :
+					resptracker->last_proc_counter;
+
+		proc = cs_procedure_data_create(create_counter,
+						num_ant_paths,
+						config_id,
+						resptracker->selected_tx_power);
+		if (!proc)
+			return;
+
+		resptracker->current_proc = proc;
+
+		/* Reference power levels and status defaults */
+		cs_pd_set_reference_power_levels(proc,
+			has_header_fields ? ref_pwr_lvl :
+				resptracker->last_ref_pwr_lvl,
+			has_header_fields ? ref_pwr_lvl :
+				resptracker->last_ref_pwr_lvl);
+		cs_pd_set_local_status(proc,
+			(enum cs_procedure_done_status)proc_done_status);
+		cs_pd_set_remote_status(proc,
+			(enum cs_procedure_done_status)subevt_done_status);
+	}
+
+	/* Begin a new RAS subevent only when we have header fields */
+	if (has_header_fields) {
+		cs_pd_ras_begin_subevent(proc,
+					start_acl_conn_evt_counter,
+					freq_comp,
+					ref_pwr_lvl);
+	}
+
+	/* step_bytes points to an array of struct cs_step_data */
+	steps = (const struct cs_step_data *)step_bytes;
+
+	/* Process each step */
+	for (idx = 0; idx < num_steps_reported; idx++) {
+		const struct cs_step_data *step = &steps[idx];
+		const uint8_t mode = step->step_mode;
+		const uint8_t channel = step->step_chnl;
+		const uint8_t payload_len = step->step_data_length;
+		uint8_t mode_byte;
+		uint8_t mode_type;
+		const uint8_t *payload;
+		uint8_t plen;
+		bool step_aborted;
+
+		/* Check if step is aborted: bit 7 of step_mode or
+		 * 0 payload len
+		 */
+		step_aborted = (mode & RAS_STEP_ABORTED_BIT) ||
+			(payload_len == 0);
+
+		DBG(rap, "step[%u]: mode=0x%02x channel=%u payload_len=%u "
+			"aborted=%s", idx, mode, channel, payload_len,
+			step_aborted ? "YES" : "NO");
+
+		/* Slim-step serialization for RAS:
+		 * - 1 byte: mode (bit7 set if aborted)
+		 * - payload: exactly step_data_length bytes (raw mode data)
+		 */
+		mode_byte = step->step_mode;
+		payload = (const uint8_t *)&step->step_mode_data;
+		plen = step->step_data_length;
+
+		if (step_aborted) {
+			/* Ensure abort bit is set */
+			mode_byte |= RAS_STEP_ABORTED_BIT;
+			cs_pd_ras_append_subevent_bytes(proc, &mode_byte, 1);
+			/* No payload when aborted - per RAS spec Table 3.8 */
+			DBG(rap, "step[%u]: mode=0x%02x aborted, "
+				"no payload sent", idx, mode_byte);
+		} else {
+			mode_type = mode & 0x03;
+
+			/* Mode byte first (without abort bit) */
+			cs_pd_ras_append_subevent_bytes(proc, &mode_byte, 1);
+
+			switch (mode_type) {
+			case CS_MODE_ZERO: {
+				/* Mode 0: use raw structure bytes */
+				payload =
+					(const uint8_t *)&step->step_mode_data;
+				plen = step->step_data_length;
+				cs_pd_ras_append_subevent_bytes(proc,
+								payload, plen);
+				DBG(rap, "step[%u]: mode=0x%02x Mode0 "
+					"payload_len=%u sent",
+					idx, mode_byte, (unsigned int)plen);
+				break;
+			}
+			case CS_MODE_ONE: {
+				const struct cs_mode_one_data *m1 =
+					&step->step_mode_data.mode_one_data;
+				uint8_t buf[16];  /* Max Mode 1 size */
+				uint8_t *p = buf;
+				uint16_t time_val;
+				enum cs_role cs_role = resptracker->role;
+				uint8_t cs_rtt_type = resptracker->rtt_type;
+
+				*p++ = m1->packet_quality;
+				*p++ = m1->packet_nadm;
+				*p++ = m1->packet_rssi_dbm;
+
+				/* Time value (2 bytes LE) - use the
+				 * appropriate field based on role
+				 */
+				if (cs_role == CS_ROLE_REFLECTOR)
+					time_val = m1->tod_toa_refl;
+				else
+					time_val = m1->toa_tod_init;
+
+				*p++ = (uint8_t)(time_val & 0xFF);
+				*p++ = (uint8_t)((time_val >> 8) & 0xFF);
+
+				*p++ = m1->packet_ant;
+
+				/* PCT samples if RTT type contains
+				 * sounding sequence
+				 */
+				if (cs_rtt_type == 0x01 ||
+						cs_rtt_type == 0x02) {
+					uint32_t pct1 =
+						((uint32_t)(m1->packet_pct1
+							.i_sample &
+							0x0FFF)) |
+						(((uint32_t)(m1->packet_pct1
+							.q_sample &
+							0x0FFF)) << 12);
+					*p++ = (uint8_t)(pct1 & 0xFF);
+					*p++ = (uint8_t)((pct1 >> 8) & 0xFF);
+					*p++ = (uint8_t)((pct1 >> 16) & 0xFF);
+
+					/* PCT2 (3 bytes) */
+					uint32_t pct2 =
+						((uint32_t)(m1->packet_pct2
+							.i_sample &
+							0x0FFF)) |
+						(((uint32_t)(m1->packet_pct2
+							.q_sample &
+							0x0FFF)) << 12);
+					*p++ = (uint8_t)(pct2 & 0xFF);
+					*p++ = (uint8_t)((pct2 >> 8) & 0xFF);
+					*p++ = (uint8_t)((pct2 >> 16) & 0xFF);
+				}
+
+				plen = (uint8_t)(p - buf);
+				cs_pd_ras_append_subevent_bytes(proc, buf,
+								plen);
+				DBG(rap, "step[%u]: mode=0x%02x Mode1 "
+					"serialized payload_len=%u role=%s "
+					"rtt_type=0x%02x",
+					idx, mode_byte, (unsigned int)plen,
+					cs_role == CS_ROLE_INITIATOR ?
+						"INIT" : "REFL", cs_rtt_type);
+				break;
+			}
+			case CS_MODE_TWO: {
+				const struct cs_mode_two_data *m2 =
+					&step->step_mode_data.mode_two_data;
+				/* Max Mode 2 size: 1 + 5*(3+1) = 21 bytes */
+				uint8_t buf[64];
+				uint8_t *p = buf;
+				uint8_t k;
+				uint8_t num_paths = (num_ant_paths + 1) < 5 ?
+					(num_ant_paths + 1) : 5;
+
+				*p++ = m2->ant_perm_index;
+
+				/* Serialize each path: PCT (3 bytes) +
+				 * quality (1 byte)
+				 */
+				for (k = 0; k < num_paths; k++) {
+					/* Convert 4-byte structure PCT to
+					 * 3-byte wire format
+					 */
+					uint32_t pct =
+						((uint32_t)(m2->tone_pct[k]
+							.i_sample &
+							0x0FFF)) |
+						(((uint32_t)(m2->tone_pct[k]
+							.q_sample &
+							0x0FFF)) << 12);
+					*p++ = (uint8_t)(pct & 0xFF);
+					*p++ = (uint8_t)((pct >> 8) & 0xFF);
+					*p++ = (uint8_t)((pct >> 16) & 0xFF);
+
+					*p++ = m2->tone_quality_indicator[k];
+				}
+
+				plen = (uint8_t)(p - buf);
+				cs_pd_ras_append_subevent_bytes(proc, buf,
+								plen);
+				DBG(rap, "step[%u]: mode=0x%02x Mode2 "
+					"serialized payload_len=%u paths=%u",
+					idx, mode_byte, (unsigned int)plen,
+					num_paths);
+				break;
+			}
+			case CS_MODE_THREE: {
+				const struct cs_mode_three_data *m3 =
+					&step->step_mode_data.mode_three_data;
+				const struct cs_mode_one_data *m1 =
+					&m3->mode_one_data;
+				const struct cs_mode_two_data *m2 =
+					&m3->mode_two_data;
+				uint8_t buf[80];  /* Max Mode 3 size */
+				uint8_t *p = buf;
+				uint8_t k;
+				uint8_t num_paths = (num_ant_paths + 1) < 5 ?
+					(num_ant_paths + 1) : 5;
+				uint8_t cs_rtt_type = resptracker->rtt_type;
+				enum cs_role cs_role = resptracker->role;
+				uint16_t time_val;
+				bool include_pct;
+
+				/* Determine if PCT samples should be
+				 * included
+				 */
+				include_pct = (cs_rtt_type == 0x01 ||
+						cs_rtt_type == 0x02) &&
+					(cs_role == CS_ROLE_INITIATOR ||
+						cs_role == CS_ROLE_REFLECTOR);
+
+				/* Mode 1 portion - basic fields */
+				*p++ = m1->packet_quality;
+				*p++ = m1->packet_nadm;
+				*p++ = m1->packet_rssi_dbm;
+
+				/* Time value based on role */
+				if (cs_role == CS_ROLE_REFLECTOR)
+					time_val = m1->tod_toa_refl;
+				else
+					time_val = m1->toa_tod_init;
+
+				*p++ = (uint8_t)(time_val & 0xFF);
+				*p++ = (uint8_t)((time_val >> 8) & 0xFF);
+
+				*p++ = m1->packet_ant;
+
+				/* PCT samples if conditions met */
+				if (include_pct) {
+					uint32_t pct1 =
+						((uint32_t)(m1->packet_pct1
+							.i_sample &
+							0x0FFF)) |
+						(((uint32_t)(m1->packet_pct1
+							.q_sample &
+							0x0FFF)) << 12);
+					*p++ = (uint8_t)(pct1 & 0xFF);
+					*p++ = (uint8_t)((pct1 >> 8) & 0xFF);
+					*p++ = (uint8_t)((pct1 >> 16) & 0xFF);
+
+					uint32_t pct2 =
+						((uint32_t)(m1->packet_pct2
+							.i_sample &
+							0x0FFF)) |
+						(((uint32_t)(m1->packet_pct2
+							.q_sample &
+							0x0FFF)) << 12);
+					*p++ = (uint8_t)(pct2 & 0xFF);
+					*p++ = (uint8_t)((pct2 >> 8) & 0xFF);
+					*p++ = (uint8_t)((pct2 >> 16) & 0xFF);
+				}
+
+				/* Mode 2 portion */
+				*p++ = m2->ant_perm_index;
+
+				for (k = 0; k < num_paths; k++) {
+					uint32_t pct =
+						((uint32_t)(m2->tone_pct[k]
+							.i_sample &
+							0x0FFF)) |
+						(((uint32_t)(m2->tone_pct[k]
+							.q_sample &
+							0x0FFF)) << 12);
+					*p++ = (uint8_t)(pct & 0xFF);
+					*p++ = (uint8_t)((pct >> 8) & 0xFF);
+					*p++ = (uint8_t)((pct >> 16) & 0xFF);
+
+					*p++ = m2->tone_quality_indicator[k];
+				}
+
+				plen = (uint8_t)(p - buf);
+				cs_pd_ras_append_subevent_bytes(proc, buf,
+								plen);
+				DBG(rap, "step[%u]: mode=0x%02x Mode3 "
+					"serialized payload_len=%u paths=%u "
+					"role=%s rtt_type=0x%02x pct=%s",
+					idx, mode_byte, (unsigned int)plen,
+					num_paths,
+					cs_role == CS_ROLE_INITIATOR ?
+						"INIT" : "REFL",
+					cs_rtt_type,
+					include_pct ? "YES" : "NO");
+				break;
+			}
+			default:
+				/* Unknown mode: use raw structure bytes */
+				payload =
+					(const uint8_t *)&step->step_mode_data;
+				plen = step->step_data_length;
+				cs_pd_ras_append_subevent_bytes(proc, payload,
+								plen);
+				DBG(rap, "step[%u]: mode=0x%02x unknown mode, "
+					"payload_len=%u sent",
+					idx, mode_byte, (unsigned int)plen);
+				break;
+			}
+		}
+	}
+
+	/* Update status for this chunk */
+	cs_pd_set_local_status(proc,
+			(enum cs_procedure_done_status)proc_done_status);
+	cs_pd_set_remote_status(proc,
+			(enum cs_procedure_done_status)subevt_done_status);
+
+	/* Commit subevent chunk (RESULT or CONT) */
+	cs_pd_ras_commit_subevent(proc,
+		num_steps_reported,
+		proc_done_status,
+		subevt_done_status,
+		abort_reason & 0x0F,
+		(abort_reason >> 4) & 0x0F);
+
+	/* Ensure first segment body starts with the 4-byte RangingHeader */
+	ras_maybe_prepend_ranging_header(proc);
+
+	if (subevt_done_status != SUBEVENT_DONE_PARTIAL_RESULTS)
+		/* Send RAS raw segment data */
+		send_ras_segment_data(rap, proc);
+
+	/* Procedure complete? Clean up */
+	if (proc_done_status == CS_PROC_ALL_RESULTS_COMPLETE) {
+		DBG(rap, "Destroying CsProcedureData counter=%u and "
+			"clearing current_proc", proc->counter);
+		resptracker_reset_current_proc(resptracker);
+		/* Reset cached header values for next procedure */
+		resptracker->last_proc_counter = 0;
+		resptracker->last_start_acl_conn_evt_counter = 0;
+		resptracker->last_freq_comp = 0;
+		resptracker->last_ref_pwr_lvl = 0;
+	}
+}
+
+static void form_ras_data_with_cs_subevent_result(struct bt_rap *rap,
+		const struct rap_ev_cs_subevent_result *data,
+		uint16_t length)
+{
+	size_t base_len = offsetof(struct rap_ev_cs_subevent_result,
+					step_data);
+
+	if (!rap || !rap->resptracker || !data)
+		return;
+
+	/* Defensive check: base header must be present */
+	if (length < base_len)
+		return;
+
+	DBG(rap, "Received CS subevent result subevent: len=%d", length);
+
+	handle_local_subevent_result(rap,
+		true,			/* has header fields */
+		data->config_id,
+		data->num_ant_paths,
+		data->proc_counter,
+		data->start_acl_conn_evt_counter,
+		data->freq_comp,
+		data->ref_pwr_lvl,
+		data->proc_done_status,
+		data->subevt_done_status,
+		data->abort_reason,
+		data->num_steps_reported,
+		data->step_data);	/* start of steps */
+}
+static void form_ras_data_with_cs_subevent_result_cont(struct bt_rap *rap,
+		const struct rap_ev_cs_subevent_result_cont *cont,
+		uint16_t length)
+{
+	size_t base_len = offsetof(struct rap_ev_cs_subevent_result_cont,
+					step_data);
+	struct cstracker *resptracker;
+
+	if (!rap || !rap->resptracker || !cont)
+		return;
+
+	if (length < base_len)
+		return;
+
+	DBG(rap, "Received CS subevent result continue subevent: len=%d",
+		length);
+
+	resptracker = rap->resptracker;
+
+	/* Use cached header values captured from the last RESULT event */
+	handle_local_subevent_result(rap,
+		false,			/* CONT has no header fields */
+		cont->config_id,
+		cont->num_ant_paths,
+		resptracker->last_proc_counter,
+		resptracker->last_start_acl_conn_evt_counter,
+		resptracker->last_freq_comp,
+		resptracker->last_ref_pwr_lvl,
+		cont->proc_done_status,
+		cont->subevt_done_status,
+		cont->abort_reason,
+		cont->num_steps_reported,
+		cont->step_data);
+}
 void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
 						const void *param,
 						void *user_data)
 {
+	const struct rap_ev_cs_subevent_result_cont *cont = param;
 	struct bt_rap *rap = user_data;
 
 	DBG(rap, "Received CS subevent CONT: len=%d", length);
+
+	form_ras_data_with_cs_subevent_result_cont(rap, cont, length);
 }
 
 void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
 					const void *param,
 					void *user_data)
 {
+	const struct rap_ev_cs_subevent_result *data = param;
 	struct bt_rap *rap = user_data;
 
 	DBG(rap, "Received CS subevent: len=%d", length);
+
+	/* Populate CsProcedureData and send RAS payload */
+	form_ras_data_with_cs_subevent_result(rap, data, length);
 }
 
 void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
 						const void *param,
 						void *user_data)
 {
+	const struct rap_ev_cs_proc_enable_cmplt *data = param;
 	struct bt_rap *rap = user_data;
+	struct cstracker *resptracker;
 
 	DBG(rap, "Received CS procedure enable complete subevent: len=%d",
 	    length);
+
+	if (!rap->resptracker) {
+		resptracker = new0(struct cstracker, 1);
+		cs_tracker_init(resptracker);
+		rap->resptracker = resptracker;
+	}
+
+	resptracker = rap->resptracker;
+
+	/* Populate responder tracker */
+	resptracker->config_id = data->config_id;
+	resptracker->selected_tx_power = data->sel_tx_pwr;
 }
 
 void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
@@ -544,9 +1878,27 @@ void bt_rap_hci_cs_config_complete_callback(uint16_t length,
 					const void *param,
 					void *user_data)
 {
+	const struct rap_ev_cs_config_cmplt *data = param;
 	struct bt_rap *rap = user_data;
+	struct cstracker *resptracker;
+
+	if (!rap)
+		return;
 
 	DBG(rap, "Received CS config complete subevent: len=%d", length);
+
+	if (!rap->resptracker) {
+		resptracker = new0(struct cstracker, 1);
+		cs_tracker_init(resptracker);
+		rap->resptracker = resptracker;
+	}
+
+	resptracker = rap->resptracker;
+
+	/* Basic fields */
+	resptracker->config_id = data->config_id;
+	resptracker->role = data->role;
+	resptracker->rtt_type = data->rtt_type;
 }
 
 struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
@@ -786,7 +2138,7 @@ bool bt_rap_attach(struct bt_rap *rap, struct bt_gatt_client *client)
 
 	bt_uuid16_create(&uuid, RAS_UUID16);
 
-	gatt_db_foreach_service(rap->lrapdb->db, &uuid,
+	gatt_db_foreach_service(rap->rrapdb->db, &uuid,
 				foreach_rap_service, rap);
 
 	return true;
diff --git a/src/shared/rap.h b/src/shared/rap.h
index 15ddea295..c9431aecd 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -97,11 +97,11 @@ struct cs_mode_zero_data {
 
 struct cs_mode_one_data {
 	uint8_t packet_quality;
-	uint8_t packet_rssi_dbm;
-	uint8_t packet_ant;
 	uint8_t packet_nadm;
+	uint8_t packet_rssi_dbm;
 	int16_t toa_tod_init;
 	int16_t tod_toa_refl;
+	uint8_t packet_ant;
 	struct pct_iq_sample packet_pct1;
 	struct pct_iq_sample packet_pct2;
 };
-- 
2.34.1


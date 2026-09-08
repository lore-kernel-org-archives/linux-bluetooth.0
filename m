Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F387832E13B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 04:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841692; cv=none; b=NtnnB1FHdFYq+9Osb9FtL+4aVdfQwKvIfMHAZBQuLuWNGxM1f7heRDDlS7UrbZbAyv3Cq1zKG8NhpLWPlrZdz1GKeJpaBVhxjhIC+Txk09ISnhR1RUXdVxOLPAh4sI3hMZTB7r/HXcxUkOnO5LFfOeO/BAGqlFVEDJxU6/7SkaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841692; c=relaxed/simple;
	bh=WdFjSEWqvktw0/3RwKqJ4S+3Kx1v977Isxn0nVEAtxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HS+r8w5AOmHrgsA9pe6wEEBqImln6o7c79MwTpZVQjFHZm5DkUFmJc85iMH1we9156zttLOTIS4ABarcCkAfUSmMW/WqXvHZtCB9O//sXqIxmH5oFixTyL6h5lACwzH2rvHuFbYTocQX/dJDZH42nJQKqBxqg26Jvx3bYIJjf84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QvPaQbiM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AUYeuKzY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QvPaQbiM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AUYeuKzY"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687NlQ9B1656348
	for <linux-bluetooth@vger.kernel.org>; Tue, 8 Sep 2026 04:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pDdYfoUgzIE0WzxXzFH1ZjmYsvr9T5AxjjcN+hTyYrg=; b=QvPaQbiMHDQPRldG
	rt8uSzKx0vLJw/iQU1HxAQf/wxL8Vx0lnsO3GLsNWWhwNgNnA1+7QE2Q6SfECUzo
	SZwgyQZc6/XQ7b24vtoLDAzAI1s1k7F5G2+ky+FQubAwNEtH4wa/4J6RuaRQC7ai
	XnOX6N+XrmYRKiXzHSkPtAdzLwxjZwEItyWKMq0IJcsvV9LkW9TJ86red/gTuDoV
	4bPSienEboNmFdiosl0LbgPH9qvINH2waj6L+aXrVwigZYyXpcck+ptI6+BnmXC4
	IW0pwIdWxJJU+vALFxA2seIwGE3iZLYyonwti7v3R/ZM4QjZZjY8CbamQVUIphzB
	efmp1Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghssg3mrf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 04:28:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso5638861a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 21:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788841687; x=1789446487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pDdYfoUgzIE0WzxXzFH1ZjmYsvr9T5AxjjcN+hTyYrg=;
        b=AUYeuKzYbc9WcQc+UV9UtvpIlMGzooOod4GTdOcvX6eROaHItxG5u1wypCe59eK61P
         IcOsbIbxtQCxOG/aNAHQTo6AECzCYOMwpNJf4KbvaPU5aC6Sl92twvTIPWcT+uy2O8M5
         vMu78XIJ5hcQ6QEzykUivMVPb74uF+ojsQxTX9JgPg/RgfGrG63auPlwcDiNj86SN7VV
         C3ussybcolOOOfv9LiG1Q5Zg364ENYUAC5JlZCrqKonyZqb2o8O39X7g3QD4jKuapSKV
         cqC+sMSHJK2FqXnxZAggv+i68VnJQWIh7KEiHIfN++YQL1zRFb4HcUzzgs40EXU8dN+C
         OzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788841687; x=1789446487;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pDdYfoUgzIE0WzxXzFH1ZjmYsvr9T5AxjjcN+hTyYrg=;
        b=bmhvOBiMMhcqfKjR35lANj95cjF0/jZBEzS2YoduEgwOLlVG1+8k8AKrhM8/kiPsQs
         qRrEtL576ts1wF01gUNlBJzRA2ig/TRuiRQPZOIMniF3YEo6WOakzEHQ+krlrHwa3h/c
         y7MwMAPxOizRn4M0lnH+hjlQOFSykB0g6PMSCEgmieWQine6ozhVZCTQ3UAPybVg6vfy
         UEC3kdiBZw/374aZfQgNjn/Z4xybLzJxjJ7j+RGTi4d6pYxGuIBU6PLwSbbH6bRI2UIL
         URoDKiUROgVyiMfREIj7cEMkmxoQzJ85NrJwYkBIjflJrY9yLZrtVdbxlLOaqOQKDi36
         jEDQ==
X-Gm-Message-State: AFuF++l48et4a9G5moI2ovOnKZqEqpG4ZFLzkSElZl/42osNzvjHPcfU
	lxlkLEhf19ipMC2unxACOrfETUd19b96BVKhJEstcxb13qwWGO4aOX9posQuSUxOB/rnJSb+yBm
	kP+RUod8K1pSQ+WpX559VcEtmdwPgVwnZY9gp0AdAz+YwCsxaOaM90GAw9MmcSmTENwtNCxjk1E
	maSPY=
X-Gm-Gg: AYBFou3hpxEaxbdhh4OqeqowTwuUoYt3rkm+fB+BJ8nate8P5pK31o9vkcqmA6avjmH
	+4g7ySpWaxVO7eO4e1fMkW3RGOk7H0XQoHqRQBu7LCZt0MHgyYGQPhmKoGHYWLxmhGz0nP8bnuW
	UP9LhkgncL9xf7iih2Z+v1eZaTAkjsj4NQkdy4pDI2dcsnH32bVEhAqKD3sJMDAMMcvCvwPAvt/
	az1ZeYwc/GsZ0jst7eg/gnwxD+5EWp1JEDsinj/AYDBYdOPld6PhV/8cmgiF6sjMkqlTPXZgATs
	s01SuNKfDvn8LystZP/FTd9F9LbzwwCWFsJPIX5wmjEe+qtxkNSfoWnQtKR4ibJnaCDK+ky95Xp
	JZROlQcfKIu6dS2suoNDbIAGSADXJ2g==
X-Received: by 2002:a05:6a20:914f:b0:3d0:88f5:f806 with SMTP id adf61e73a8af0-3da3a03d00bmr37791913637.15.1788841686949;
        Mon, 07 Sep 2026 21:28:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:914f:b0:3d0:88f5:f806 with SMTP id adf61e73a8af0-3da3a03d00bmr37789782637.15.1788841669696;
        Mon, 07 Sep 2026 21:27:49 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b8f44d7sm31577301eec.22.2026.09.07.21.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 21:27:49 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 2/3] shared: add support for on-demand notification handling
Date: Tue,  8 Sep 2026 09:57:26 +0530
Message-Id: <20260908042727.1677501-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908042727.1677501-1-naga.akella@oss.qualcomm.com>
References: <20260908042727.1677501-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA0NiBTYWx0ZWRfX+pgYnMeWPyZz
 XGgfoMFt68NA39h3U6KC1Q3D2b9nSKW5wYQh3pWrKAvjV1ryCZ09yGpZB6eLOF+2ULYckm98gTC
 VEE7PITUaGSwqZDQId4uYLr4gTebVJAprLrTMD3Xbtzpu1ND7SXUNHDxEop2Gxlyh2dPCy5HY4g
 YOGylft28fEC113iYFtgu9aio4j6tEsn/IIjGKhpbPxjfFcC6g17uX4ScxEz7zfg0IXsI+qkJsq
 IaeZMnEBXc2ULfo1lYsmuwLRa2o9+SBVxH5wDuZpiWZUFIRIEk7v3Nnt7QgnSZnsC2qbHrF7q99
 NPRrC8nwl2JzCmGVs2FXmc9WS9l38jQB+nn3jo73n33bJ3OuXI0lUvx/zVKX13yIquZyopZowVd
 wX0Q9wCe5JjzWDQsnjs/89i465gFwMGJI4Et8eZY6Le9n8PUTI8uPepcuntQz0dgmsPY13RxJug
 3WBWfXwajCrqskhwZNA==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a9f8ed8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=zxiRJ2eMCz6ahiQph5EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: vrKuK2X1SD1V73-k4HOFa6Ax51Zt0Phg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA0NiBTYWx0ZWRfX7lDdZcPXLzrg
 fRCCinRCGfrQwvpfoJhIXef7DZxeDrGIaSfbpFVzDgPQv9bAq7jDO6DzXp/eu0+rnit9nDWEFLw
 6Sq3Es9lKICa6CUpSlUvBYorfoO4wwo=
X-Proofpoint-GUID: vrKuK2X1SD1V73-k4HOFa6Ax51Zt0Phg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080046

When OndemandRanging is enabled in main.conf, allow the reflector role
to send on-demand ranging data. In the initiator role, handle
on-demand ranging data notifications and the associated control point
opcodes.
---
 src/shared/rap.c | 849 +++++++++++++++++++++++++++++++++++++++++++----
 src/shared/rap.h |   6 +
 2 files changed, 788 insertions(+), 67 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index be80154cd..e55bbe088 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -25,8 +25,15 @@
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-server.h"
 #include "src/shared/gatt-client.h"
+#include "src/shared/timeout.h"
 #include "src/shared/rap.h"
 
+/* Watchdog for a RAS Control Point request the initiator is awaiting a
+ * response for. Guards against a lost/dropped notification leaving
+ * ras_ondemand_client permanently stuck waiting.
+ */
+#define RAS_CP_RESPONSE_TIMEOUT (10 * 1000)
+
 #define DBG(_rap, fmt, ...) \
 	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ##__VA_ARGS__)
 
@@ -226,7 +233,7 @@ enum cs_procedure_done_status {
 	CS_PROC_ABORTED              = 0x0F
 };
 
-/* Per-procedure tracking — one entry per HCI procedure counter */
+/* Per-procedure tracking - one entry per HCI procedure counter */
 struct cs_proc_state {
 	uint16_t proc_counter;
 	struct bcs_procedure_data bcs_data;
@@ -276,6 +283,18 @@ struct cstracker {
 	struct ranging_header   ranging_header_;
 	/* Client - subsequent segments appended using iovec */
 	struct iovec segment_data;
+	/* Client - segment reassembly continuity tracking: true from a
+	 * valid first segment until a detected gap, an append failure,
+	 * or bt_rap_detach(). NOT cleared on last_segment - a ranging
+	 * procedure's later subevents can arrive as further first/last
+	 * cycles without repeating first_segment=1, so this stays active
+	 * across them (see ras_reassemble_segment_notify()).
+	 */
+	bool                     reassembly_active;
+	/* Client - rolling_segment_counter value the next segment must
+	 * carry; only meaningful while reassembly_active is true.
+	 */
+	uint8_t                  expected_segment_counter;
 
 	/* Session-level config template and per-procedure state */
 	struct bcs_procedure_data     bcs_proc_data;
@@ -284,6 +303,64 @@ struct cstracker {
 	uint64_t                      proc_start_timestamp_nanos;
 };
 
+/* RAS Control Point op codes */
+enum ras_cp_opcode {
+	RAS_CP_OP_GET_RANGING_DATA = 0x00,
+	RAS_CP_OP_ACK_RANGING_DATA = 0x01,
+	/* 0x02 Retrieve_Lost_Ranging_Data_Segments,
+	 * 0x03 Abort_Operation,
+	 * 0x04 Set_Filter - optional, not implemented
+	 */
+};
+
+/* RAS Control Point response op codes */
+enum ras_cp_rsp_opcode {
+	RAS_CP_RSP_COMPLETE_RANGING_DATA = 0x00,
+	RAS_CP_RSP_RESPONSE_CODE         = 0x02,
+};
+
+/* RAS Control Point response code values */
+enum ras_cp_response_code {
+	RAS_CP_RSP_CODE_SUCCESS                 = 0x01,
+	RAS_CP_RSP_CODE_OPCODE_NOT_SUPPORTED    = 0x02,
+	RAS_CP_RSP_CODE_INVALID_PARAMETER       = 0x03,
+	RAS_CP_RSP_CODE_PROCEDURE_NOT_COMPLETED = 0x06,
+	RAS_CP_RSP_CODE_SERVER_BUSY             = 0x07,
+	RAS_CP_RSP_CODE_NO_RECORDS_FOUND        = 0x08,
+};
+
+/* Single-slot buffer for a completed CS Procedure's Ranging Data Body,
+ * retained until the client sends ACK_Ranging_Data. Lives on struct bt_rap
+ * (one per remote connection) rather than on the shared struct ras (one
+ * per local adapter GATT database) so that concurrently connected
+ * centrals cannot evict or receive each other's cached ranging data.
+ */
+struct ras_ondemand_cache {
+	bool     valid;
+	uint16_t counter;
+	struct iovec data;
+	uint16_t send_index;
+	struct segmentation_header seg_hdr;
+};
+
+/* Initiator role: which RAS Control Point request the client is
+ * currently awaiting a response for.
+ */
+enum ras_cp_pending {
+	RAS_CP_PENDING_NONE = 0,
+	RAS_CP_PENDING_GET,
+	RAS_CP_PENDING_ACK,
+};
+
+struct ras_ondemand_client {
+	enum ras_cp_pending pending_op;
+	uint16_t            pending_counter;
+	/* Watchdog for the outstanding request named above; fires if the
+	 * peer never sends a Control Point response.
+	 */
+	unsigned int        cp_timeout_id;
+};
+
 /* Ranging Service context */
 struct ras {
 	struct bt_rap_db *rapdb;
@@ -305,8 +382,21 @@ struct ras {
 	/* CCC state tracking for mutual exclusivity */
 	uint16_t realtime_ccc_value;
 	uint16_t ondemand_ccc_value;
+
+	/* Initiator role: pending RAS Control Point request state */
+	struct ras_ondemand_client client;
 };
 
+static inline bool ras_is_ondemand_mode(const struct ras *ras)
+{
+	return ras && ras->ondemand_ccc_value != 0;
+}
+
+/* Initiator role: forward declaration needed by bt_rap_detach() below;
+ * defined alongside the other RAS Control Point client helpers.
+ */
+static void ras_ondemand_client_reset(struct ras *ras);
+
 struct bt_rap_db {
 	struct gatt_db *db;
 	struct ras *ras;
@@ -341,6 +431,18 @@ struct bt_rap {
 	uint16_t conn_interval;
 	struct cstracker *resptracker;
 	struct cstracker *reqtracker;
+
+	/* Initiator role: false = real-time (default), true = on-demand.
+	 * Must be set before the RAS Features read completes during
+	 * bt_rap_attach() to take effect.
+	 */
+	bool ondemand_mode;
+
+	/* Responder role: this connection's on-demand ranging data cache.
+	 * Per-connection (not on the shared struct ras) so that concurrent
+	 * centrals cannot evict or receive each other's cached data.
+	 */
+	struct ras_ondemand_cache cache;
 };
 
 static struct queue *rap_db;
@@ -821,6 +923,51 @@ void bt_rap_detach(struct bt_rap *rap)
 	bt_att_unregister_disconnect(rap->att, rap->disconn_id);
 	rap->att = NULL;
 
+	/* Segment reassembly state (reqtracker) is not tied to any one
+	 * connection instance - drop it here too, otherwise a stale
+	 * expected_segment_counter/ranging_header_/segment_data left over
+	 * from before the disconnect could be fed by a continuation
+	 * segment on the next connection whose rolling counter happens to
+	 * collide (it is only 6 bits wide).
+	 */
+	if (rap->reqtracker) {
+		free(rap->reqtracker->segment_data.iov_base);
+		rap->reqtracker->segment_data.iov_base = NULL;
+		rap->reqtracker->segment_data.iov_len = 0;
+		rap->reqtracker->reassembly_active = false;
+		rap->reqtracker->expected_segment_counter = 0;
+	}
+
+	/* Responder role: drop any un-ACKed on-demand cache for this
+	 * connection so a reconnect (by this or another central) cannot
+	 * be served stale ranging data via Get_Ranging_Data.
+	 */
+	free(rap->cache.data.iov_base);
+	memset(&rap->cache, 0, sizeof(rap->cache));
+
+	if (rap->rrapdb && rap->rrapdb->ras) {
+		struct ras *ras = rap->rrapdb->ras;
+
+		ras_ondemand_client_reset(ras);
+
+		/* foreach_rap_char() only (re-)issues the RAS Features
+		 * read and its resulting notify subscriptions when a
+		 * *_chrc pointer is NULL. Clear all of them here so the
+		 * next bt_rap_attach()'s rediscovery pass re-arms
+		 * subscriptions against the freshly cloned client
+		 * instead of silently staying unsubscribed - or, if the
+		 * remote GATT db was rebuilt (unbonded device,
+		 * GattCacheDisable, service-changed), holding onto
+		 * gatt_db_attribute pointers that no longer exist.
+		 */
+		ras->feat_chrc = NULL;
+		ras->realtime_chrc = NULL;
+		ras->ondemand_chrc = NULL;
+		ras->cp_chrc = NULL;
+		ras->ready_chrc = NULL;
+		ras->overwritten_chrc = NULL;
+	}
+
 	queue_foreach(bt_rap_cbs, rap_detached, rap);
 }
 
@@ -855,6 +1002,8 @@ static void rap_free(void *data)
 
 	rap_db_free(rap->rrapdb);
 
+	free(rap->cache.data.iov_base);
+
 	if (rap->resptracker) {
 		free(rap->resptracker->segment_data.iov_base);
 		free(rap->resptracker);
@@ -1045,25 +1194,18 @@ static void ras_features_read_cb(struct gatt_db_attribute *attrib,
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
 
-static void ras_ondemand_read_cb(struct gatt_db_attribute *attrib,
-				 unsigned int id, uint16_t offset,
-				 uint8_t opcode, struct bt_att *att,
-				 void *user_data)
-{
-	struct ras *ras = user_data;
-
-	if (ras)
-		bt_rap_get_session(att, ras->rapdb->db);
-
-	/* No static read data – on‑demand data is pushed via
-	 * notifications
-	 */
-	gatt_db_attribute_read_result(attrib, id, 0, NULL, 0);
-}
+static void ras_cp_send_response_code(struct bt_rap *rap, struct ras *ras,
+					uint8_t response_code);
+static void ras_cp_send_complete_ranging_data(struct bt_rap *rap,
+					struct ras *ras, uint16_t counter);
+static void send_ondemand_segment_data(struct bt_rap *rap, struct ras *ras);
+static void ras_ondemand_cache_clear(struct bt_rap *rap);
 
 /*
- * Control point handler.
- * Parses the opcode and acts on queued data (implementation TBD).
+ * RAS Control Point handler, dispatches Get_Ranging_Data and
+ * ACK_Ranging_Data. The remaining, optional
+ * op codes (Retrieve_Lost_Ranging_Data_Segments, Abort_Operation,
+ * Set_Filter) are not implemented.
  */
 static void ras_control_point_write_cb(struct gatt_db_attribute *attrib,
 				       unsigned int id, uint16_t offset,
@@ -1072,14 +1214,75 @@ static void ras_control_point_write_cb(struct gatt_db_attribute *attrib,
 				       void *user_data)
 {
 	struct ras *ras = user_data;
+	struct bt_rap *rap;
+	uint16_t counter;
 
-	if (ras)
-		bt_rap_get_session(att, ras->rapdb->db);
+	if (!ras) {
+		gatt_db_attribute_write_result(attrib, id,
+						BT_ATT_ERROR_UNLIKELY);
+		return;
+	}
+
+	rap = bt_rap_get_session(att, ras->rapdb->db);
+
+	if (!rap) {
+		gatt_db_attribute_write_result(attrib, id,
+						BT_ATT_ERROR_UNLIKELY);
+		return;
+	}
+
+	if (!len) {
+		gatt_db_attribute_write_result(attrib, id, 0);
+		return;
+	}
+
+	switch (value[0]) {
+	case RAS_CP_OP_GET_RANGING_DATA:
+		if (len != 3) {
+			ras_cp_send_response_code(rap, ras,
+					RAS_CP_RSP_CODE_INVALID_PARAMETER);
+			break;
+		}
+
+		counter = get_le16(value + 1);
+
+		if (!rap->cache.valid || rap->cache.counter != counter) {
+			ras_cp_send_response_code(rap, ras,
+					RAS_CP_RSP_CODE_NO_RECORDS_FOUND);
+			break;
+		}
+
+		send_ondemand_segment_data(rap, ras);
+		break;
+	case RAS_CP_OP_ACK_RANGING_DATA:
+		if (len != 3) {
+			ras_cp_send_response_code(rap, ras,
+					RAS_CP_RSP_CODE_INVALID_PARAMETER);
+			break;
+		}
+
+		counter = get_le16(value + 1);
+
+		if (!rap->cache.valid || rap->cache.counter != counter) {
+			ras_cp_send_response_code(rap, ras,
+					RAS_CP_RSP_CODE_NO_RECORDS_FOUND);
+			break;
+		}
 
-	/* Control point handler - implementation TBD */
+		ras_ondemand_cache_clear(rap);
+
+		ras_cp_send_response_code(rap, ras, RAS_CP_RSP_CODE_SUCCESS);
+		break;
+	default:
+		ras_cp_send_response_code(rap, ras,
+					RAS_CP_RSP_CODE_OPCODE_NOT_SUPPORTED);
+		break;
+	}
+
+	gatt_db_attribute_write_result(attrib, id, 0);
 }
 
-/* Data Ready – returns the latest ranging counter. */
+/* Data Ready - returns the latest ranging counter. */
 static void ras_data_ready_read_cb(struct gatt_db_attribute *attrib,
 				   unsigned int id, uint16_t offset,
 				   uint8_t opcode, struct bt_att *att,
@@ -1096,7 +1299,7 @@ static void ras_data_ready_read_cb(struct gatt_db_attribute *attrib,
 	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
 }
 
-/* Data Overwritten – indicates how many results were overwritten. */
+/* Data Overwritten - indicates how many results were overwritten. */
 static void ras_data_overwritten_read_cb(struct gatt_db_attribute *attrib,
 					 unsigned int id, uint16_t offset,
 					 uint8_t opcode, struct bt_att *att,
@@ -1177,7 +1380,7 @@ static void ras_ranging_data_ccc_write_cb(struct gatt_db_attribute *attrib,
 	gatt_db_attribute_write_result(attrib, id, 0);
 }
 
-/* Service registration – store attribute pointers */
+/* Service registration - store attribute pointers */
 static struct ras *register_ras_service(struct gatt_db *db)
 {
 	struct ras *ras;
@@ -1234,8 +1437,7 @@ static struct ras *register_ras_service(struct gatt_db *db)
 						  BT_ATT_PERM_READ_ENCRYPT,
 						  BT_GATT_CHRC_PROP_NOTIFY |
 						  BT_GATT_CHRC_PROP_INDICATE,
-						  ras_ondemand_read_cb, NULL,
-						  ras);
+						  NULL, NULL, ras);
 
 	ras->ondemand_ccc = gatt_db_service_add_ccc_custom(ras->svc,
 					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
@@ -1495,6 +1697,179 @@ static bool ras_maybe_prepend_ranging_header(struct cs_procedure_data *d)
 	return ok;
 }
 
+static void ras_ondemand_cache_clear(struct bt_rap *rap)
+{
+	if (!rap)
+		return;
+
+	free(rap->cache.data.iov_base);
+	rap->cache.data.iov_base = NULL;
+	rap->cache.data.iov_len = 0;
+	rap->cache.valid = false;
+	rap->cache.counter = 0;
+	rap->cache.send_index = 0;
+}
+
+static void ras_ondemand_cache_store(struct bt_rap *rap,
+					struct cs_procedure_data *proc)
+{
+	if (!rap || !proc)
+		return;
+
+	rap->cache.data = proc->ras_raw_data_;
+	rap->cache.counter = proc->counter;
+	rap->cache.valid = true;
+	rap->cache.send_index = 0;
+	memset(&rap->cache.seg_hdr, 0, sizeof(rap->cache.seg_hdr));
+
+	proc->ras_raw_data_.iov_base = NULL;
+	proc->ras_raw_data_.iov_len = 0;
+	proc->ras_raw_data_index_ = 0;
+}
+
+static void ras_send_ranging_data_ready(struct bt_rap *rap, struct ras *ras,
+					uint16_t counter)
+{
+	uint8_t value[2];
+
+	if (!rap || !ras || !ras->ready_chrc)
+		return;
+
+	put_le16(counter, value);
+	gatt_db_attribute_notify(ras->ready_chrc, value, sizeof(value),
+					bt_rap_get_att(rap));
+}
+
+static void ras_send_ranging_data_overwritten(struct bt_rap *rap,
+					struct ras *ras, uint16_t counter)
+{
+	uint8_t value[2];
+
+	if (!rap || !ras || !ras->overwritten_chrc)
+		return;
+
+	put_le16(counter, value);
+	gatt_db_attribute_notify(ras->overwritten_chrc, value, sizeof(value),
+					bt_rap_get_att(rap));
+}
+
+static void ras_cp_send_response_code(struct bt_rap *rap, struct ras *ras,
+					uint8_t response_code)
+{
+	uint8_t value[2] = { RAS_CP_RSP_RESPONSE_CODE, response_code };
+
+	if (!rap || !ras || !ras->cp_chrc)
+		return;
+
+	gatt_db_attribute_notify(ras->cp_chrc, value, sizeof(value),
+					bt_rap_get_att(rap));
+}
+
+static void ras_cp_send_complete_ranging_data(struct bt_rap *rap,
+					struct ras *ras, uint16_t counter)
+{
+	uint8_t value[3];
+
+	if (!rap || !ras || !ras->cp_chrc)
+		return;
+
+	value[0] = RAS_CP_RSP_COMPLETE_RANGING_DATA;
+	put_le16(counter, value + 1);
+
+	gatt_db_attribute_notify(ras->cp_chrc, value, sizeof(value),
+					bt_rap_get_att(rap));
+}
+
+static void send_ondemand_segment_data(struct bt_rap *rap, struct ras *ras)
+{
+	uint16_t value_max;
+	const uint16_t header_len = ras_segment_header_size;
+	uint16_t raw_payload_size;
+
+	if (!rap || !ras || !rap->cache.valid)
+		return;
+
+	value_max = ras_att_value_payload_max(rap);
+
+	if (value_max <= header_len) {
+		DBG(rap, "value_max(%u) too small for header", value_max);
+		/* Tell the initiator now instead of leaving it waiting
+		 * indefinitely for a Complete_Ranging_Data response that
+		 * will never come; the cached data is left intact so a
+		 * later retry (e.g. after MTU/DLE negotiation) can still
+		 * succeed.
+		 */
+		ras_cp_send_response_code(rap, ras,
+					RAS_CP_RSP_CODE_SERVER_BUSY);
+		return;
+	}
+
+	raw_payload_size = (uint16_t)(value_max - header_len);
+
+	rap->cache.send_index = 0;
+	rap->cache.seg_hdr.first_segment = 1;
+	rap->cache.seg_hdr.last_segment = 0;
+	rap->cache.seg_hdr.rolling_segment_counter = 0;
+
+	while (true) {
+		size_t total_len = rap->cache.data.iov_len;
+		size_t index = rap->cache.send_index;
+		size_t unsent_data_size = total_len - index;
+		uint16_t copy_size;
+		uint16_t seg_len;
+		uint8_t *seg;
+		uint16_t wr = 0;
+		bool ok;
+
+		rap->cache.seg_hdr.last_segment =
+			(unsent_data_size <= raw_payload_size) ? 1 : 0;
+
+		copy_size = (uint16_t)((unsent_data_size < raw_payload_size) ?
+				unsent_data_size : raw_payload_size);
+		seg_len = (uint16_t)(header_len + copy_size);
+		seg = (uint8_t *)malloc(seg_len);
+
+		if (!seg) {
+			DBG(rap, "OOM (%u)", seg_len);
+			ras_cp_send_response_code(rap, ras,
+					RAS_CP_RSP_CODE_SERVER_BUSY);
+			return;
+		}
+
+		wr += (uint16_t)
+			serialize_segmentation_header(&rap->cache.seg_hdr,
+			seg + wr, seg_len - wr);
+		memcpy(seg + wr,
+			(const uint8_t *)rap->cache.data.iov_base + index,
+			copy_size);
+		wr += copy_size;
+
+		ok = gatt_db_attribute_notify(ras->ondemand_chrc, seg, wr,
+						bt_rap_get_att(rap));
+
+		free(seg);
+
+		if (!ok) {
+			DBG(rap, "Failed to send on-demand RAS notification");
+			ras_cp_send_response_code(rap, ras,
+					RAS_CP_RSP_CODE_SERVER_BUSY);
+			return;
+		}
+
+		rap->cache.send_index += copy_size;
+		rap->cache.seg_hdr.first_segment = 0;
+		rap->cache.seg_hdr.rolling_segment_counter =
+			(uint8_t)((rap->cache.seg_hdr
+				.rolling_segment_counter + 1) & 0x3F);
+
+		if (rap->cache.seg_hdr.last_segment) {
+			ras_cp_send_complete_ranging_data(rap, ras,
+							rap->cache.counter);
+			return;
+		}
+	}
+}
+
 static void send_ras_segment_data(struct bt_rap *rap,
 				struct cs_procedure_data *proc)
 {
@@ -2046,12 +2421,32 @@ static void handle_local_subevent_result(struct bt_rap *rap,
 	/* Ensure first segment body starts with the 4-byte RangingHeader */
 	ras_maybe_prepend_ranging_header(proc);
 
-	if (subevt_done_status != SUBEVENT_DONE_PARTIAL_RESULTS)
-		/* Send RAS raw segment data */
-		send_ras_segment_data(rap, proc);
+	if (subevt_done_status != SUBEVENT_DONE_PARTIAL_RESULTS) {
+		struct ras *ras = rap->lrapdb ? rap->lrapdb->ras : NULL;
+
+		/* Real-time Ranging mode
+		 */
+		if (!ras_is_ondemand_mode(ras))
+			send_ras_segment_data(rap, proc);
+	}
 
 	/* Procedure complete? Clean up */
 	if (proc_done_status == CS_PROC_ALL_RESULTS_COMPLETE) {
+		struct ras *ras = rap->lrapdb ? rap->lrapdb->ras : NULL;
+
+		if (ras_is_ondemand_mode(ras)) {
+			if (rap->cache.valid) {
+				uint16_t evicted_counter = rap->cache.counter;
+
+				ras_ondemand_cache_clear(rap);
+				ras_send_ranging_data_overwritten(rap, ras,
+							evicted_counter);
+			}
+
+			ras_ondemand_cache_store(rap, proc);
+			ras_send_ranging_data_ready(rap, ras, proc->counter);
+		}
+
 		DBG(rap, "Destroying CsProcedureData counter=%u and "
 			"clearing current_proc", proc->counter);
 		resptracker_reset_current_proc(resptracker);
@@ -2524,6 +2919,16 @@ void bt_rap_set_conn_interval(struct bt_rap *rap, uint16_t conn_interval)
 	rap->conn_interval = conn_interval;
 }
 
+bool bt_rap_set_ondemand_ranging(struct bt_rap *rap, bool enable)
+{
+	if (!rap)
+		return false;
+
+	rap->ondemand_mode = enable;
+
+	return true;
+}
+
 struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 {
 	struct bt_rap *rap;
@@ -2656,6 +3061,91 @@ static unsigned int bt_rap_register_notify(struct bt_rap *rap,
 	return notify->id;
 }
 
+static void ras_ondemand_client_reset(struct ras *ras)
+{
+	if (!ras)
+		return;
+
+	if (ras->client.cp_timeout_id) {
+		timeout_remove(ras->client.cp_timeout_id);
+		ras->client.cp_timeout_id = 0;
+	}
+
+	ras->client.pending_op = RAS_CP_PENDING_NONE;
+	ras->client.pending_counter = 0;
+}
+
+/* Initiator role: fires when the peer never answers an outstanding
+ * Get_Ranging_Data/ACK_Ranging_Data request. Without this, a dropped
+ * notification would leave client.pending_op stuck forever, silently
+ * blocking all future Ranging Data Ready handling for this connection.
+ */
+static bool ras_cp_timeout_cb(void *user_data)
+{
+	struct bt_rap *rap = user_data;
+	struct ras *ras = rap_get_ras(rap);
+
+	if (ras) {
+		DBG(rap, "RAS CP response timed out (pending_op=%d "
+		    "counter=%u) - resetting", ras->client.pending_op,
+		    ras->client.pending_counter);
+
+		/* The glib source is about to be destroyed on return; avoid
+		 * ras_ondemand_client_reset() also calling timeout_remove()
+		 * on it.
+		 */
+		ras->client.cp_timeout_id = 0;
+		ras_ondemand_client_reset(ras);
+	}
+
+	return false;
+}
+
+static void ras_cp_arm_timeout(struct bt_rap *rap, struct ras *ras)
+{
+	if (!ras)
+		return;
+
+	if (ras->client.cp_timeout_id)
+		timeout_remove(ras->client.cp_timeout_id);
+
+	ras->client.cp_timeout_id = timeout_add(RAS_CP_RESPONSE_TIMEOUT,
+						ras_cp_timeout_cb, rap, NULL);
+}
+
+static bool ras_cp_write_op(struct bt_rap *rap, struct ras *ras,
+				uint8_t opcode, uint16_t counter)
+{
+	uint8_t value[3];
+	uint16_t value_handle;
+
+	if (!rap || !ras || !ras->cp_chrc || !rap->client)
+		return false;
+
+	if (!gatt_db_attribute_get_char_data(ras->cp_chrc, NULL,
+					&value_handle, NULL, NULL, NULL))
+		return false;
+
+	value[0] = opcode;
+	put_le16(counter, value + 1);
+
+	return bt_gatt_client_write_without_response(rap->client,
+					value_handle, false,
+					value, sizeof(value));
+}
+
+static bool ras_cp_send_get_ranging_data(struct bt_rap *rap, struct ras *ras,
+					uint16_t counter)
+{
+	return ras_cp_write_op(rap, ras, RAS_CP_OP_GET_RANGING_DATA, counter);
+}
+
+static bool ras_cp_send_ack_ranging_data(struct bt_rap *rap, struct ras *ras,
+					uint16_t counter)
+{
+	return ras_cp_write_op(rap, ras, RAS_CP_OP_ACK_RANGING_DATA, counter);
+}
+
 static inline bool parse_segmentation_header(struct iovec *iov,
 					     struct segmentation_header *s)
 {
@@ -3138,7 +3628,7 @@ static void parse_ras_data_segments(struct bt_rap *rap,
 
 static bool process_first_segment(struct bt_rap *rap,
 					struct cstracker *reqtracker,
-					struct iovec *iov, bool last_segment)
+					struct iovec *iov)
 {
 	uint16_t counter_config_val;
 	int8_t selected_tx_power;
@@ -3180,16 +3670,11 @@ static bool process_first_segment(struct bt_rap *rap,
 		    "with %zu bytes", iov->iov_len);
 	}
 
-	if (!last_segment)
-		return false;
-
-	DBG(rap, "Single-segment: first=1, last=1");
 	return true;
 }
 
-static void ras_realtime_notify_cb(struct bt_rap *rap, uint16_t value_handle,
-				   const uint8_t *value, uint16_t length,
-				   void *user_data)
+static void ras_reassemble_segment_notify(struct bt_rap *rap,
+					const uint8_t *value, uint16_t length)
 {
 	struct iovec iov = { .iov_base = (void *)value, .iov_len = length };
 	struct segmentation_header seg_hdr;
@@ -3200,9 +3685,6 @@ static void ras_realtime_notify_cb(struct bt_rap *rap, uint16_t value_handle,
 		return;
 	}
 
-	DBG(rap, "Received real-time notification: handle=0x%04x len=%u",
-	    value_handle, length);
-
 	if (!parse_segmentation_header(&iov, &seg_hdr)) {
 		DBG(rap, "Failed to parse segmentation header");
 		return;
@@ -3220,14 +3702,40 @@ static void ras_realtime_notify_cb(struct bt_rap *rap, uint16_t value_handle,
 	reqtracker = rap->reqtracker;
 
 	if (seg_hdr.first_segment) {
-		if (!process_first_segment(rap, reqtracker, &iov,
-						seg_hdr.last_segment))
+		if (!process_first_segment(rap, reqtracker, &iov))
 			return;
+
+		reqtracker->reassembly_active = true;
+		reqtracker->expected_segment_counter =
+			(seg_hdr.rolling_segment_counter + 1) & 0x3F;
 	} else {
+		if (!reqtracker->reassembly_active) {
+			DBG(rap, "Continuation segment with no first "
+			    "segment received this cycle - dropping");
+			return;
+		}
+
+		if (seg_hdr.rolling_segment_counter !=
+				reqtracker->expected_segment_counter) {
+			DBG(rap, "Segment counter gap (got=%u want=%u) - "
+			    "discarding in-progress transfer",
+			    seg_hdr.rolling_segment_counter,
+			    reqtracker->expected_segment_counter);
+			free(reqtracker->segment_data.iov_base);
+			reqtracker->segment_data.iov_base = NULL;
+			reqtracker->segment_data.iov_len = 0;
+			reqtracker->reassembly_active = false;
+			return;
+		}
+
+		reqtracker->expected_segment_counter =
+			(seg_hdr.rolling_segment_counter + 1) & 0x3F;
+
 		if (iov.iov_len > 0) {
 			if (!util_iov_append(&reqtracker->segment_data,
 						iov.iov_base, iov.iov_len)) {
 				DBG(rap, "Failed to append segment data");
+				reqtracker->reassembly_active = false;
 				return;
 			}
 			DBG(rap, "Continuation segment: appended "
@@ -3237,11 +3745,197 @@ static void ras_realtime_notify_cb(struct bt_rap *rap, uint16_t value_handle,
 		}
 	}
 
-	/* Last segment: parse complete RAS data */
+	/* Last segment: parse the RAS data accumulated so far.
+	 *
+	 * Do NOT clear reassembly_active here. On real hardware a single
+	 * ranging procedure's data can arrive as several ATT-level
+	 * first/last segment cycles - one per subevent - with the 4-byte
+	 * Ranging Header (and first_segment=1) sent only once, on the very
+	 * first cycle. Later cycles are continuation-only (first_segment=0)
+	 * even though they each close with last_segment=1. Leaving
+	 * reassembly_active set lets those later continuation segments be
+	 * accepted instead of being dropped as "no first segment received".
+	 * parse_ras_data_segments() already frees segment_data before
+	 * returning, so the next continuation simply starts a fresh
+	 * accumulation; a genuinely new procedure still resets all of this
+	 * state unconditionally via its own first_segment=1.
+	 */
 	if (seg_hdr.last_segment)
 		parse_ras_data_segments(rap, reqtracker);
 }
 
+/* Real-time and on-demand notifications share identical segment
+ * reassembly (see ras_reassemble_segment_notify()); the only difference
+ * is the log label, passed in via user_data at registration time. For
+ * on-demand, the last segment does not itself trigger ACK, the ACK is
+ * driven by the RAS Control Point's Complete_Ranging_Data response
+ * (see ras_cp_response_notify_cb()).
+ */
+static void ras_segment_notify_cb(struct bt_rap *rap, uint16_t value_handle,
+				   const uint8_t *value, uint16_t length,
+				   void *user_data)
+{
+	const char *label = user_data ? user_data : "real-time";
+
+	DBG(rap, "Received %s notification: handle=0x%04x len=%u",
+	    label, value_handle, length);
+
+	ras_reassemble_segment_notify(rap, value, length);
+}
+
+/* Initiator role: reacts to a Ranging Data Ready notification/indication
+ * by requesting the newly-available data via Get_Ranging_Data.
+ */
+static void ras_data_ready_notify_cb(struct bt_rap *rap, uint16_t value_handle,
+				   const uint8_t *value, uint16_t length,
+				   void *user_data)
+{
+	struct ras *ras = rap_get_ras(rap);
+	uint16_t counter;
+
+	if (!rap || !ras || length < 2) {
+		DBG(rap, "Invalid Ranging Data Ready notification");
+		return;
+	}
+
+	counter = get_le16(value);
+
+	if (ras->client.pending_op != RAS_CP_PENDING_NONE) {
+		DBG(rap, "CP busy (pending_op=%d pending_counter=%u), "
+		    "dropping Ready for counter=%u", ras->client.pending_op,
+		    ras->client.pending_counter, counter);
+		return;
+	}
+
+	ras->client.pending_op = RAS_CP_PENDING_GET;
+	ras->client.pending_counter = counter;
+
+	if (!ras_cp_send_get_ranging_data(rap, ras, counter)) {
+		DBG(rap, "Failed to send Get_Ranging_Data for counter=%u",
+		    counter);
+		ras_ondemand_client_reset(ras);
+		return;
+	}
+
+	ras_cp_arm_timeout(rap, ras);
+}
+
+/* Initiator role: reacts to a Ranging Data Overwritten notification
+ * by abandoning any pending request for that counter.
+ */
+static void ras_data_overwritten_notify_cb(struct bt_rap *rap,
+				   uint16_t value_handle,
+				   const uint8_t *value, uint16_t length,
+				   void *user_data)
+{
+	struct ras *ras = rap_get_ras(rap);
+	uint16_t counter;
+
+	if (!rap || !ras || length < 2) {
+		DBG(rap, "Invalid Ranging Data Overwritten notification");
+		return;
+	}
+
+	counter = get_le16(value);
+
+	DBG(rap, "Ranging Data Overwritten: counter=%u", counter);
+
+	if (ras->client.pending_counter == counter)
+		ras_ondemand_client_reset(ras);
+}
+
+/* Initiator role: handles RAS Control Point responses sent by the remote
+ * reflector.
+ */
+static void ras_cp_response_notify_cb(struct bt_rap *rap,
+				   uint16_t value_handle,
+				   const uint8_t *value, uint16_t length,
+				   void *user_data)
+{
+	struct ras *ras = rap_get_ras(rap);
+	uint16_t counter;
+	uint8_t code;
+
+	if (!rap || !ras || length < 2) {
+		DBG(rap, "Invalid RAS Control Point response");
+		return;
+	}
+
+	switch (value[0]) {
+	case RAS_CP_RSP_COMPLETE_RANGING_DATA:
+		if (ras->client.pending_op != RAS_CP_PENDING_GET) {
+			DBG(rap, "Unexpected Complete_Ranging_Data "
+			    "(pending_op=%d)", ras->client.pending_op);
+			return;
+		}
+
+		if (length < 3) {
+			DBG(rap, "Complete_Ranging_Data too short (len=%u)",
+			    length);
+			ras_ondemand_client_reset(ras);
+			return;
+		}
+
+		counter = get_le16(value + 1);
+		if (counter != ras->client.pending_counter) {
+			DBG(rap, "Complete_Ranging_Data counter mismatch "
+			    "(got=%u want=%u)", counter,
+			    ras->client.pending_counter);
+			ras_ondemand_client_reset(ras);
+			return;
+		}
+
+		ras->client.pending_op = RAS_CP_PENDING_ACK;
+		if (!ras_cp_send_ack_ranging_data(rap, ras, counter))
+			ras_ondemand_client_reset(ras);
+		else
+			ras_cp_arm_timeout(rap, ras);
+		break;
+	case RAS_CP_RSP_RESPONSE_CODE:
+		code = value[1];
+		DBG(rap, "RAS CP response code=0x%02x (pending_op=%d "
+		    "counter=%u)", code, ras->client.pending_op,
+		    ras->client.pending_counter);
+		ras_ondemand_client_reset(ras);
+		break;
+	default:
+		DBG(rap, "Unknown RAS CP response opcode 0x%02x", value[0]);
+		ras_ondemand_client_reset(ras);
+		break;
+	}
+}
+
+/* Initiator role: subscribe to a single on-demand-related characteristic,
+ * logging (not failing) on any missing attribute/handle so a
+ * partially-capable peer doesn't block subscription to the others.
+ */
+static void rap_subscribe_ondemand_chrc(struct bt_rap *rap,
+					struct gatt_db_attribute *chrc,
+					rap_notify_t func, const char *name)
+{
+	uint16_t value_handle;
+	unsigned int notify_id;
+
+	if (!chrc) {
+		DBG(rap, "%s characteristic not found on peer", name);
+		return;
+	}
+
+	if (!gatt_db_attribute_get_char_data(chrc, NULL, &value_handle,
+					NULL, NULL, NULL)) {
+		DBG(rap, "Unable to resolve %s value handle", name);
+		return;
+	}
+
+	notify_id = bt_rap_register_notify(rap, value_handle, func,
+							(void *)name);
+	if (!notify_id)
+		DBG(rap, "Failed to register for %s notifications", name);
+	else
+		DBG(rap, "Registered for %s notifications: id=%u", name,
+							notify_id);
+}
+
 static void read_ras_features(struct bt_rap *rap, bool success,
 			uint8_t att_ecode,
 			const uint8_t *value, uint16_t length,
@@ -3293,32 +3987,53 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 
 	DBG(rap, "RAS features read successfully, capabilities determined");
 
-	/* Register for real-time characteristic notifications if supported */
-	if (supports_realtime && ras && ras->realtime_chrc && rap->client) {
-		uint16_t value_handle;
-		bt_uuid_t uuid;
-
-		if (gatt_db_attribute_get_char_data(ras->realtime_chrc,
-					NULL, &value_handle,
-					NULL, NULL, &uuid)) {
-			unsigned int notify_id;
-
-			notify_id = bt_rap_register_notify(rap,
-						value_handle,
-						ras_realtime_notify_cb,
-						NULL);
-			if (!notify_id)
-				DBG(rap, "Failed to register for "
-					"real-time notifications");
-			else
-				DBG(rap, "Registered for real-time "
-					"features: id=%u", notify_id);
+	if (!ras || !rap->client) {
+		DBG(rap, "No remote RAS attributes/client to subscribe to");
+		return;
+	}
+
+	if (!rap->ondemand_mode) {
+		/* Register for real-time characteristic notifications */
+		if (supports_realtime && ras->realtime_chrc) {
+			uint16_t value_handle;
+
+			if (gatt_db_attribute_get_char_data(ras->realtime_chrc,
+						NULL, &value_handle,
+						NULL, NULL, NULL)) {
+				unsigned int notify_id;
+
+				notify_id = bt_rap_register_notify(rap,
+							value_handle,
+							ras_segment_notify_cb,
+							"real-time");
+				if (!notify_id)
+					DBG(rap, "Failed to register for "
+						"real-time notifications");
+				else
+					DBG(rap, "Registered for real-time "
+						"features: id=%u", notify_id);
+			}
 		}
-	} else {
-		DBG(rap, "On demand ranging "
-			"remote device - skipping notification "
-			"registration");
+
+		return;
 	}
+
+	/* On-demand mode: subscribe to each on-demand characteristic
+	 * independently so a partially-capable peer doesn't block the
+	 * others.
+	 */
+	rap_subscribe_ondemand_chrc(rap, ras->ondemand_chrc,
+					ras_segment_notify_cb,
+					"on-demand");
+	rap_subscribe_ondemand_chrc(rap, ras->cp_chrc,
+					ras_cp_response_notify_cb,
+					"RAS Control Point");
+	rap_subscribe_ondemand_chrc(rap, ras->ready_chrc,
+					ras_data_ready_notify_cb,
+					"Ranging Data Ready");
+	rap_subscribe_ondemand_chrc(rap, ras->overwritten_chrc,
+					ras_data_overwritten_notify_cb,
+					"Ranging Data Overwritten");
 }
 
 static void foreach_rap_char(struct gatt_db_attribute *attr, void *user_data)
diff --git a/src/shared/rap.h b/src/shared/rap.h
index b0cf307c2..9ab577710 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -297,3 +297,9 @@ void bt_rap_set_local_sw_time(struct bt_rap *rap, uint8_t local_sw_time);
 void bt_rap_set_remote_sw_time(struct bt_rap *rap, uint8_t remote_sw_time);
 
 void bt_rap_set_conn_interval(struct bt_rap *rap, uint16_t conn_interval);
+
+/* Initiator role: select real-time (false, default) or on-demand (true)
+ * ranging data delivery. Must be called before bt_rap_attach() drives
+ * GATT discovery to completion to take effect.
+ */
+bool bt_rap_set_ondemand_ranging(struct bt_rap *rap, bool enable);
-- 


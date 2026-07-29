Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1E3C3F63
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321034; cv=none; b=EQu6wyzRW4pE9hmVY5tgT6dsJZv9eR4InbZYQ071JHPGQRl1NxQ0vCUyuXE6ATQZE5WIPemWjc6GnPQQj5vjDTW7a05rQ8eszYnTVJ1ikXoI9YI6k/jDPn2MavC5zC2uBR57gQm99bI5mz1q9VJj+2jJ5OVQk27AWxOvdCLnEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321034; c=relaxed/simple;
	bh=oB2KYdUJ+a9FB6tpJT/C0VelSuM+/ekDkLhH5faa3m8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABwhf7KwxbO4GFkq7jycqOoEfe6T92v9b6/3k5VEGvrtxrpXqYZ1gUizqXrZgipah6zfu+CtXLKsF74ZoPbdnlHRqW1ad2cjEK+QI7eW7RiEDc4+pU/cpl8HvDJ/XDGAZuZrCgqbPhEnVMsjHuyfFefQxeZmGKCH493MCLBKxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mzs8WpBd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SlJe6oHt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mzs8WpBd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SlJe6oHt"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T9o7Lv1870416
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KaWtJNdqsvm9dthGT1l003eLSs+JgEA93SVwyHdlxps=; b=mzs8WpBdXCiFRX+N
	uH4GeoFGwbNLjoLC1r1KJlPaHIRJ3CmsFLpZlblvHai7lN/IuJnbXxEGXVxpiu/h
	frbycqyOiUp5Xd6cb5+OEiGXdS7yBWaSUYkeLOGS1nzE1AWYKZDl9u963pwmo3aj
	HDdxYxESTIEzZdE2xPSK86y+AGXc+O6pwKsPMIXcymVJwULs9DiL5bQ53dr1tYyy
	eAPttzdK+erkcyb9sFkRHp4lCdgYlP3oKAP0xHvKnvQ2TRyvKTNm2o22J8bOERKK
	yoebm6i4HvhfgSMxYfdWrTYSQlbKHzBJsqLXzaw98CHiOOXX053qwTBe/ZGeVjJc
	baNcog==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqf83861j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:30:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso1446073a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785321031; x=1785925831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KaWtJNdqsvm9dthGT1l003eLSs+JgEA93SVwyHdlxps=;
        b=SlJe6oHtbCNJSlmHouZrNBzttUX/dUQoMvASWvFw/R64/O6JywE9mao+B7KmvbThFl
         yTnw1pl7rV1Fc7wNS4QABjeubhctYAwz/8CT0b1xKAvqcB5kgp/qP5RIS3DsRsSCFDHM
         9+ArpPqScBorAU84jmICKag4MfVqMgVI7ynj04/iIOebI2KVCHlgA8yyF12sBRueusS/
         ISc7yzOmuAWPMXiYkUwcboUx8Qut68Q1QtySja9CLbj1V/EruLtvlDlqlXq2VHXlHXe9
         iyEW1fyEjtovJaNAHTNL0I03G9PFXzbRsDLi8jBertpCGA1bcqq3lRYFJd/3VgtfLOEv
         CWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321031; x=1785925831;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KaWtJNdqsvm9dthGT1l003eLSs+JgEA93SVwyHdlxps=;
        b=drJ3LBKfVpkFRQQj9r+x1jzqvG1nUvkSHGn6uKau70b3z9qVxRgTKpnzB0UWUL5bTU
         ZrdXVQDAXQ82eK7kb1EGIWZQP5of5voxc6QEgFGKZ38YhzyRs1SzViccm4oSHS1oVzoM
         /Oj/6J9BgJmBqZ8tPf6gPer3C8uAzAdOP8nqzPq6d5yT8lLZYUasz1l0LF6hcH8DICWc
         Vaysoc1rc0Vrxo0ROz3JEKq8OCO+J/Wb9bLHHSS2uGYT6VJCxtB/TiXkASX/Kh0d4Q6M
         OugAo0trUxSjjFiI/oHjzkRqsD4MAJfwnFhLtcHUY7fVLXXF1EjNpuj6E1kdzdnizlnq
         okfw==
X-Gm-Message-State: AOJu0Ywro7kdQ7isjkda7tDJmFWtVfu8K9gEMpors3fvRwdFP1EpEshY
	eZUM4tVQRixeyQ56NQ1K5EKVhtTkxDEZnzXbMjbUuDGTB38PjM+0IpjN5RXkWd5vl7iVdOIPcK1
	uFepOmco1k/3FeR5SVxuu/Mkq7XpCrDGdHooR4W6FoNR/S+HKKQvH+sHtSlEgHJ3YM4s84qD2F3
	tASCk=
X-Gm-Gg: AR+sD12/CxoTMn2kw5FwOkoQvKCvKV+6Vh5QJmApLS5g1+3MqK3prYKxQZlnKZX4sXy
	QZN3TvaZOJZzRVUihuWdFi+ZiKOfxcQoGrSK2oms4Ea52JVfRnLAEzjz7pefR75WdfVLyGqA+OB
	URtF2EE5nelZtGX+vBunzDJ7pYf4FdqxCMrIk9At+FyiKDyhZzEzC834DeCXD3TBX7CJ9dpXfCH
	Rbdj3l6RdmJujWDBiPDOpeDI+fPNnhdEvljydkdV4sgJ8K45HyhDk8242s80KcmGHVl9ipJ+Vcr
	VVzBZE6bnhGc9GEFUro7GvvHuST0fYTp2JCTcdXGumQPs9STvVDlB+i8u0yjdnejtBSecJ8zO8x
	cV0ptMw6FwE6AVafZBCDAp/5izgQFpA==
X-Received: by 2002:a17:90b:1b07:b0:38d:e5d0:9bd with SMTP id 98e67ed59e1d1-38f6a51ba7bmr6115813a91.26.1785321030428;
        Wed, 29 Jul 2026 03:30:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1b07:b0:38d:e5d0:9bd with SMTP id 98e67ed59e1d1-38f6a51ba7bmr6115781a91.26.1785321029744;
        Wed, 29 Jul 2026 03:30:29 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7262bc27sm11028649c88.2.2026.07.29.03.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 03:30:29 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 1/3] shared/rap: Add bcs_procedure_data aggregation and procedure data API
Date: Wed, 29 Jul 2026 16:00:17 +0530
Message-Id: <20260729103019.4178720-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729103019.4178720-1-naga.akella@oss.qualcomm.com>
References: <20260729103019.4178720-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4NiBTYWx0ZWRfX+FqxUW+K+bHo
 ThkKlnQVBR240aODKGtr/JXRRo6esnrq2Th3izG+ePMM7jcXulMQ8k8egqQgmCnBRbUWGaAEzd1
 Hk2FtnC1uIQRnQ+ClZY5cnbSJwR9MvE=
X-Proofpoint-ORIG-GUID: S_ISGE5i2cenTq_gu5GRAjkuM36LzWMv
X-Proofpoint-GUID: S_ISGE5i2cenTq_gu5GRAjkuM36LzWMv
X-Authority-Analysis: v=2.4 cv=AaaB2XXG c=1 sm=1 tr=0 ts=6a69d647 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=C4rH-d3b2fZPOIAJbaIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4NiBTYWx0ZWRfX9Ut4N3vPTiAh
 X/r8IzZ9xB9LTWjElGvHW64asXasAbhZ9Zx2s3dBO3PXizK3liO+npJKVCZN7rdAa3cMy2re5UG
 QnP5PblI1+N/nAOqYEfos9IhnjO0HV1i++GJFHR4+ETqn+i5In6pdHDuGJsBI+8T3wV3fLXj+as
 K9bmTegXvTzzz3b6MdAsW8KQgLhPMTupmfUia6cteFnQaxTFH07tG5NLFnjw8VtojFWiT8G/ayh
 9ST/cRb+VIenXSjf7jQUwWMG6od/4e5QOW6aof5FSm3dQX3LADB4SHeyNfRwfBu8vMDPuoXU2Sw
 Pz5PwV65otd1beqGevrIlyooBxXCrylDQHH+b7glGmQ1Jj+MDSANIuc79AhR6SDXktrPaVedXc6
 UTmbbDpuRwnIWuAzuxTi1OsFa2bSPmiXaZLkUdHfQT8J5p9qUAuJTLaH7jhZnrcdxVllp/ruzgs
 vT71N0v2DsFH7v6bAgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290086

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Define bcs_procedure_data to hold per-procedure CS results from both
the local initiator and remote reflector, including subevent step data,
selected TX powers, procedure enable config, CS config, sw_time values,
and BLE connection interval.

Add cs_proc_state with a 16-entry ring buffer in cstracker to track
procedures keyed by procedure counter, accumulating results
independently from each side until both report all-results-complete.

Update parse_mode_{0,1,2,3}, parse_step, and parse_subevent_steps with
output pointer parameters to capture remote reflector step data.
Introduce parse_cs_local_initiator_data() to store local HCI subevent
results, handling both initial and continuation events. Update
parse_ras_data_segments() to route decoded RAS subevent data into the
matching cs_proc_state as reflector results.

Add bt_rap_set_procedure_data_cb() to register a callback fired once
both local and remote results are complete for a given procedure.
Add bt_rap_set_local_sw_time(), bt_rap_set_remote_sw_time(), and
bt_rap_set_conn_interval() so callers such as rap_hci.c can supply the
CS capability sw_time and connection interval required by upper-layer
distance calculation algorithms.

Remove unwanted function rap_detached , fix for rap profile level
disconnections
---
 src/shared/rap.c | 673 ++++++++++++++++++++++++++++++++++++++++++++---
 src/shared/rap.h |  50 ++++
 2 files changed, 687 insertions(+), 36 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index dfb272d3a..91cb6ec55 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -12,6 +12,8 @@
 #include <stdbool.h>
 #include <unistd.h>
 #include <errno.h>
+#include <time.h>
+#include <glib.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/hci.h"
@@ -151,6 +153,16 @@ static inline uint8_t ranging_header_get_antenna_mask(
 	return hdr->antenna_pct & 0x0F;
 }
 
+static inline uint16_t ranging_header_get_counter(
+					const struct ranging_header *hdr)
+{
+	if (!hdr)
+		return 0;
+
+	return (uint16_t)(hdr->counter_config[0] |
+			  ((hdr->counter_config[1] & 0x0F) << 8));
+}
+
 static inline uint8_t antenna_mask_count_paths(uint8_t antenna_mask)
 {
 	uint8_t count = 0;
@@ -206,11 +218,23 @@ enum cs_role {
 };
 
 #define CS_INVALID_CONFIG_ID   0xFF
+#define CS_RANGING_COUNTER_MASK   0x0FFF
+
 /* Minimal enums (align to controller values if needed) */
 enum cs_procedure_done_status {
 	CS_PROC_ALL_RESULTS_COMPLETE = 0x00,
 	CS_PROC_PARTIAL_RESULTS      = 0x01,
-	CS_PROC_ABORTED              = 0x02
+	CS_PROC_ABORTED              = 0x0F
+};
+
+/* Per-procedure tracking — one entry per HCI procedure counter */
+struct cs_proc_state {
+	uint16_t proc_counter;
+	struct bcs_procedure_data bcs_data;
+	enum cs_procedure_done_status local_status;
+	bool                          local_has_complete_subevent;
+	enum cs_procedure_done_status remote_status;
+	bool                          remote_has_complete_subevent;
 };
 
 /* Main cs_procedure_data  */
@@ -253,6 +277,12 @@ struct cstracker {
 	struct ranging_header   ranging_header_;
 	/* Client - subsequent segments appended using iovec */
 	struct iovec segment_data;
+
+	/* Session-level config template and per-procedure state */
+	struct bcs_procedure_data     bcs_proc_data;
+	struct queue                  *proc_states;
+	uint8_t                       procedure_sequence_after_enable;
+	uint64_t                      proc_start_timestamp_nanos;
 };
 
 /* Ranging Service context */
@@ -300,6 +330,15 @@ struct bt_rap {
 	bt_rap_destroy_func_t debug_destroy;
 	void *debug_data;
 	void *user_data;
+
+	bt_rap_procedure_data_func_t  procedure_data_cb;
+	bt_rap_destroy_func_t         procedure_data_destroy;
+	void                         *procedure_data_user_data;
+
+	/* CS capabilities sw_time and connection interval for config param */
+	uint8_t local_sw_time;
+	uint8_t remote_sw_time;
+	uint16_t conn_interval;
 	struct cstracker *resptracker;
 	struct cstracker *reqtracker;
 };
@@ -542,6 +581,178 @@ static bool cs_pd_ras_commit_subevent(struct cs_procedure_data *d,
 	return true;
 }
 
+/* ---------- bcs_procedure_data helpers ----------------------------------- */
+static uint64_t get_time_nanos(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_REALTIME, &ts);
+	return (uint64_t)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+}
+
+static void bcs_proc_data_clear(struct bcs_procedure_data *proc)
+{
+	uint32_t i;
+
+	if (!proc)
+		return;
+
+	for (i = 0; i < proc->initiator_subevent_count; i++)
+		free(proc->initiator_subevent_results[i].step_data);
+	free(proc->initiator_subevent_results);
+	proc->initiator_subevent_results = NULL;
+	proc->initiator_subevent_count = 0;
+
+	for (i = 0; i < proc->reflector_subevent_count; i++)
+		free(proc->reflector_subevent_results[i].step_data);
+	free(proc->reflector_subevent_results);
+	proc->reflector_subevent_results = NULL;
+	proc->reflector_subevent_count = 0;
+}
+
+static bool bcs_proc_data_add_initiator_subevent(
+					struct bcs_procedure_data *proc,
+					uint16_t start_acl_evt,
+					uint16_t freq_comp,
+					int8_t ref_pwr,
+					uint8_t num_ant_paths,
+					uint8_t abort_reason,
+					uint64_t timestamp_nanos,
+					struct cs_step_data *steps,
+					uint32_t num_steps)
+{
+	struct cs_subevent_result_data *arr;
+	uint32_t new_count;
+
+	if (!proc)
+		return false;
+
+	new_count = proc->initiator_subevent_count + 1;
+	arr = realloc(proc->initiator_subevent_results,
+					new_count * sizeof(*arr));
+	if (!arr) {
+		free(steps);
+		return false;
+	}
+
+	arr[new_count - 1].start_acl_conn_evt_counter = start_acl_evt;
+	arr[new_count - 1].freq_comp = freq_comp;
+	arr[new_count - 1].ref_pwr_lvl = ref_pwr;
+	arr[new_count - 1].num_ant_paths = num_ant_paths;
+	arr[new_count - 1].subevent_abort_reason = abort_reason;
+	arr[new_count - 1].timestamp_nanos = timestamp_nanos;
+	arr[new_count - 1].num_steps = num_steps;
+	arr[new_count - 1].step_data = steps;
+
+	proc->initiator_subevent_results = arr;
+	proc->initiator_subevent_count = new_count;
+	return true;
+}
+
+static bool bcs_proc_data_add_reflector_subevent(
+					struct bcs_procedure_data *proc,
+					uint16_t start_acl_evt,
+					uint16_t freq_comp,
+					int8_t ref_pwr,
+					uint8_t num_ant_paths,
+					uint8_t abort_reason,
+					uint64_t timestamp_nanos,
+					struct cs_step_data *steps,
+					uint32_t num_steps)
+{
+	struct cs_subevent_result_data *arr;
+	uint32_t new_count;
+
+	if (!proc)
+		return false;
+
+	new_count = proc->reflector_subevent_count + 1;
+	arr = realloc(proc->reflector_subevent_results,
+					new_count * sizeof(*arr));
+	if (!arr) {
+		free(steps);
+		return false;
+	}
+
+	arr[new_count - 1].start_acl_conn_evt_counter = start_acl_evt;
+	arr[new_count - 1].freq_comp = freq_comp;
+	arr[new_count - 1].ref_pwr_lvl = ref_pwr;
+	arr[new_count - 1].num_ant_paths = num_ant_paths;
+	arr[new_count - 1].subevent_abort_reason = abort_reason;
+	arr[new_count - 1].timestamp_nanos = timestamp_nanos;
+	arr[new_count - 1].num_steps = num_steps;
+	arr[new_count - 1].step_data = steps;
+
+	proc->reflector_subevent_results = arr;
+	proc->reflector_subevent_count = new_count;
+	return true;
+}
+
+static bool match_proc_counter(const void *data, const void *match_data)
+{
+	const struct cs_proc_state *s = data;
+	uint16_t proc_counter = PTR_TO_UINT(match_data);
+
+	return s->proc_counter == proc_counter;
+}
+
+static void free_proc_state(void *data)
+{
+	struct cs_proc_state *s = data;
+
+	bcs_proc_data_clear(&s->bcs_data);
+	free(s);
+}
+
+static struct cs_proc_state *find_or_create_proc_state(struct cstracker *t,
+							uint16_t proc_counter)
+{
+	struct cs_proc_state *s;
+
+	s = queue_find(t->proc_states, match_proc_counter,
+					UINT_TO_PTR(proc_counter));
+	if (s)
+		return s;
+
+	s = new0(struct cs_proc_state, 1);
+	s->proc_counter  = proc_counter;
+	s->local_status  = CS_PROC_PARTIAL_RESULTS;
+	s->remote_status = CS_PROC_PARTIAL_RESULTS;
+	/* Copy session-level config from template */
+	s->bcs_data.proc_enable_config = t->bcs_proc_data.proc_enable_config;
+	s->bcs_data.cs_config = t->bcs_proc_data.cs_config;
+	s->bcs_data.t_sw_time_us_supported_by_local =
+			t->bcs_proc_data.t_sw_time_us_supported_by_local;
+	s->bcs_data.t_sw_time_us_supported_by_remote =
+			t->bcs_proc_data.t_sw_time_us_supported_by_remote;
+	s->bcs_data.ble_conn_interval = t->bcs_proc_data.ble_conn_interval;
+	s->bcs_data.initiator_selected_tx_power =
+			t->bcs_proc_data.initiator_selected_tx_power;
+	s->bcs_data.procedure_counter = proc_counter;
+
+	queue_push_tail(t->proc_states, s);
+
+	return s;
+}
+
+static struct cs_proc_state *find_proc_state_for_ras(struct cstracker *t,
+						uint16_t ranging_counter)
+{
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(t->proc_states); entry;
+							entry = entry->next) {
+		struct cs_proc_state *s = entry->data;
+
+		if ((s->proc_counter & CS_RANGING_COUNTER_MASK) ==
+		    ranging_counter)
+			return s;
+	}
+	return NULL;
+}
+
+/* ---------- end bcs helpers ---------------------------------------------- */
+
 static struct ras *rap_get_ras(struct bt_rap *rap)
 {
 	if (!rap)
@@ -556,14 +767,6 @@ static struct ras *rap_get_ras(struct bt_rap *rap)
 	return rap->rrapdb->ras;
 }
 
-static void rap_detached(void *data, void *user_data)
-{
-	struct bt_rap_cb *cb = data;
-	struct bt_rap *rap = user_data;
-
-	cb->detached(rap, cb->user_data);
-}
-
 void bt_rap_detach(struct bt_rap *rap)
 {
 	if (!queue_remove(sessions, rap))
@@ -572,8 +775,6 @@ void bt_rap_detach(struct bt_rap *rap)
 	bt_gatt_client_idle_unregister(rap->client, rap->idle_id);
 	bt_gatt_client_unref(rap->client);
 	rap->client = NULL;
-
-	queue_foreach(bt_rap_cbs, rap_detached, rap);
 }
 
 static void rap_db_free(void *data)
@@ -608,15 +809,21 @@ static void rap_free(void *data)
 	rap_db_free(rap->rrapdb);
 
 	if (rap->resptracker) {
+		free(rap->resptracker->segment_data.iov_base);
 		free(rap->resptracker);
 		rap->resptracker = NULL;
 	}
 
 	if (rap->reqtracker) {
+		queue_destroy(rap->reqtracker->proc_states, free_proc_state);
+		free(rap->reqtracker->segment_data.iov_base);
 		free(rap->reqtracker);
 		rap->reqtracker = NULL;
 	}
 
+	if (rap->procedure_data_destroy)
+		rap->procedure_data_destroy(rap->procedure_data_user_data);
+
 	queue_destroy(rap->notify, free);
 	queue_destroy(rap->pending, NULL);
 	queue_destroy(rap->ready_cbs, rap_ready_free);
@@ -702,6 +909,24 @@ bool bt_rap_set_debug(struct bt_rap *rap, bt_rap_debug_func_t func,
 	return true;
 }
 
+bool bt_rap_set_procedure_data_cb(struct bt_rap *rap,
+				  bt_rap_procedure_data_func_t cb,
+				  void *user_data,
+				  bt_rap_destroy_func_t destroy)
+{
+	if (!rap)
+		return false;
+
+	if (rap->procedure_data_destroy)
+		rap->procedure_data_destroy(rap->procedure_data_user_data);
+
+	rap->procedure_data_cb      = cb;
+	rap->procedure_data_destroy = destroy;
+	rap->procedure_data_user_data = user_data;
+
+	return true;
+}
+
 static void cs_tracker_init(struct cstracker *t)
 {
 	if (!t)
@@ -716,6 +941,7 @@ static void cs_tracker_init(struct cstracker *t)
 	t->last_start_acl_conn_evt_counter = 0;
 	t->last_freq_comp = 0;
 	t->last_ref_pwr_lvl = 0;
+	t->proc_states = queue_new();
 
 	/* Initialize ranging header using helper functions */
 	memset(&t->ranging_header_, 0, sizeof(t->ranging_header_));
@@ -1804,12 +2030,179 @@ static void form_ras_data_with_cs_subevent_result_cont(struct bt_rap *rap,
 		cont->step_data);
 }
 
+static void write_procedure_data_to_bcs_algo(struct bt_rap *rap,
+					     struct bcs_procedure_data *bcs)
+{
+	if (!rap || !bcs)
+		return;
+
+	if (rap->reqtracker && rap->reqtracker->proc_start_timestamp_nanos) {
+		uint64_t elapsed_nanos = get_time_nanos() -
+				rap->reqtracker->proc_start_timestamp_nanos;
+		uint32_t k;
+
+		DBG(rap, "Procedure elapsed time: %llu nanos",
+		    (unsigned long long)elapsed_nanos);
+
+		for (k = 0; k < bcs->initiator_subevent_count; k++)
+			bcs->initiator_subevent_results[k].timestamp_nanos =
+								elapsed_nanos;
+		for (k = 0; k < bcs->reflector_subevent_count; k++)
+			bcs->reflector_subevent_results[k].timestamp_nanos =
+								elapsed_nanos;
+	}
+
+	DBG(rap, "procedure_counter=%u sequence=%u "
+	    "init_tx_pwr=%d refl_tx_pwr=%d "
+	    "init_abort=%d refl_abort=%d "
+	    "init_subevents=%u refl_subevents=%u",
+	    bcs->procedure_counter, bcs->procedure_sequence,
+	    bcs->initiator_selected_tx_power,
+	    bcs->reflector_selected_tx_power,
+	    bcs->initiator_procedure_abort_reason,
+	    bcs->reflector_procedure_abort_reason,
+	    bcs->initiator_subevent_count,
+	    bcs->reflector_subevent_count);
+
+	if (rap->procedure_data_cb)
+		rap->procedure_data_cb(rap, bcs,
+				       rap->procedure_data_user_data);
+
+	bcs_proc_data_clear(bcs);
+}
+
+static void check_cs_procedure_complete(struct bt_rap *rap,
+					 struct cstracker *reqtracker,
+					 struct cs_proc_state *state)
+{
+	struct bcs_procedure_data *bcs = &state->bcs_data;
+
+	if (!rap->procedure_data_cb)
+		return;
+
+	if (state->local_status != CS_PROC_ALL_RESULTS_COMPLETE ||
+	    state->remote_status != CS_PROC_ALL_RESULTS_COMPLETE) {
+		DBG(rap, "Procedure not complete: local=%d remote=%d",
+		    state->local_status, state->remote_status);
+		return;
+	}
+
+	if (!state->local_has_complete_subevent &&
+	    !state->remote_has_complete_subevent) {
+		DBG(rap, "No complete subevent available");
+		return;
+	}
+
+	reqtracker->procedure_sequence_after_enable++;
+	bcs->procedure_sequence = reqtracker->procedure_sequence_after_enable;
+	write_procedure_data_to_bcs_algo(rap, bcs);
+
+	queue_remove(reqtracker->proc_states, state);
+	free(state);
+}
+
+static void parse_cs_local_initiator_data(struct bt_rap *rap,
+					bool has_header_fields,
+					uint8_t config_id,
+					uint8_t num_ant_paths,
+					uint16_t proc_counter,
+					uint16_t start_acl_conn_evt_counter,
+					uint16_t freq_comp,
+					int8_t ref_pwr_lvl,
+					uint8_t proc_done_status,
+					uint8_t subevt_done_status,
+					uint8_t abort_reason,
+					uint8_t num_steps_reported,
+					const struct cs_step_data *hci_steps)
+{
+	struct cstracker *reqtracker = rap->reqtracker;
+	uint16_t effective_counter;
+	struct cs_proc_state *state;
+	struct bcs_procedure_data *bcs;
+
+	effective_counter = has_header_fields ? proc_counter
+					      : reqtracker->last_proc_counter;
+
+	state = find_or_create_proc_state(reqtracker, effective_counter);
+	if (!state)
+		return;
+
+	bcs = &state->bcs_data;
+
+	bcs->initiator_selected_tx_power      = reqtracker->selected_tx_power;
+	bcs->initiator_procedure_abort_reason = abort_reason & 0x0F;
+
+	state->local_status =
+		(enum cs_procedure_done_status)(proc_done_status & 0x0F);
+	if ((subevt_done_status & 0x0F) == 0x00)
+		state->local_has_complete_subevent = true;
+
+	if (has_header_fields) {
+		struct cs_step_data *steps = NULL;
+
+		reqtracker->proc_start_timestamp_nanos = get_time_nanos();
+
+		bcs->procedure_counter        = proc_counter;
+		reqtracker->last_proc_counter = proc_counter;
+		reqtracker->last_start_acl_conn_evt_counter =
+					start_acl_conn_evt_counter;
+		reqtracker->last_freq_comp   = freq_comp;
+		reqtracker->last_ref_pwr_lvl = ref_pwr_lvl;
+
+		if (num_steps_reported > 0 && hci_steps) {
+			steps = calloc(num_steps_reported, sizeof(*steps));
+			if (!steps)
+				return;
+			memcpy(steps, hci_steps,
+			       num_steps_reported * sizeof(*steps));
+		}
+
+		bcs_proc_data_add_initiator_subevent(bcs,
+				start_acl_conn_evt_counter,
+				freq_comp, ref_pwr_lvl,
+				num_ant_paths,
+				(abort_reason >> 4) & 0x0F,
+				0,
+				steps, num_steps_reported);
+	} else {
+		struct cs_subevent_result_data *last;
+		struct cs_step_data *new_steps;
+		uint32_t old_count, new_count;
+
+		if (!bcs->initiator_subevent_results ||
+		    bcs->initiator_subevent_count == 0)
+			return;
+
+		last = &bcs->initiator_subevent_results[
+					bcs->initiator_subevent_count - 1];
+		old_count = last->num_steps;
+		new_count = old_count + num_steps_reported;
+
+		if (num_steps_reported > 0 && hci_steps) {
+			new_steps = realloc(last->step_data,
+					    new_count * sizeof(*new_steps));
+			if (!new_steps)
+				return;
+
+			memcpy(&new_steps[old_count], hci_steps,
+			       num_steps_reported * sizeof(*new_steps));
+			last->step_data = new_steps;
+			last->num_steps = new_count;
+		}
+
+		last->subevent_abort_reason = (abort_reason >> 4) & 0x0F;
+	}
+
+	check_cs_procedure_complete(rap, reqtracker, state);
+}
+
 static void fill_initiator_data_from_cs_subevent_result_cont(struct bt_rap *rap,
 		const struct rap_ev_cs_subevent_result_cont *cont,
 		uint16_t length)
 {
 	size_t base_len = offsetof(struct rap_ev_cs_subevent_result_cont,
 					step_data);
+	struct cstracker *reqtracker;
 
 	if (!rap || !rap->reqtracker || !cont)
 		return;
@@ -1819,6 +2212,22 @@ static void fill_initiator_data_from_cs_subevent_result_cont(struct bt_rap *rap,
 
 	DBG(rap, "Received CS subevent result continue subevent: len=%u",
 		length);
+
+	reqtracker = rap->reqtracker;
+
+	parse_cs_local_initiator_data(rap,
+				false,
+				cont->config_id,
+				cont->num_ant_paths,
+				reqtracker->last_proc_counter,
+				reqtracker->last_start_acl_conn_evt_counter,
+				reqtracker->last_freq_comp,
+				reqtracker->last_ref_pwr_lvl,
+				cont->proc_done_status,
+				cont->subevt_done_status,
+				cont->abort_reason,
+				cont->num_steps_reported,
+				cont->step_data);
 }
 
 static void fill_initiator_data_from_cs_subevent_result(struct bt_rap *rap,
@@ -1836,7 +2245,20 @@ static void fill_initiator_data_from_cs_subevent_result(struct bt_rap *rap,
 		return;
 
 	DBG(rap, "Received CS subevent result subevent: len=%u", length);
-	/* TODO: Store initiator subevent result data */
+
+	parse_cs_local_initiator_data(rap,
+				true,
+				data->config_id,
+				data->num_ant_paths,
+				data->proc_counter,
+				data->start_acl_conn_evt_counter,
+				data->freq_comp,
+				data->ref_pwr_lvl,
+				data->proc_done_status,
+				data->subevt_done_status,
+				data->abort_reason,
+				data->num_steps_reported,
+				data->step_data);
 }
 
 void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
@@ -1880,6 +2302,7 @@ void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
 	const struct rap_ev_cs_proc_enable_cmplt *data = param;
 	struct bt_rap *rap = user_data;
 	struct cstracker *resptracker;
+	struct cstracker *reqtracker;
 
 	DBG(rap, "Received CS procedure enable complete subevent: len=%u",
 	    length);
@@ -1895,6 +2318,21 @@ void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
 	/* Populate responder tracker */
 	resptracker->config_id = data->config_id;
 	resptracker->selected_tx_power = data->sel_tx_pwr;
+
+	if (!rap->reqtracker) {
+		reqtracker = new0(struct cstracker, 1);
+		cs_tracker_init(reqtracker);
+		rap->reqtracker = reqtracker;
+	}
+
+	reqtracker = rap->reqtracker;
+	reqtracker->config_id = data->config_id;
+	reqtracker->selected_tx_power = data->sel_tx_pwr;
+	reqtracker->bcs_proc_data.initiator_selected_tx_power =
+							data->sel_tx_pwr;
+
+	/* Store procedure enable config in the session-level template */
+	reqtracker->bcs_proc_data.proc_enable_config = *data;
 }
 
 void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
@@ -1945,6 +2383,39 @@ void bt_rap_hci_cs_config_complete_callback(uint16_t length,
 	reqtracker->config_id = data->config_id;
 	reqtracker->role = data->role;
 	reqtracker->rtt_type = data->rtt_type;
+	reqtracker->procedure_sequence_after_enable = 0;
+
+	/* Store cs_config in session-level template for procedure data */
+	reqtracker->bcs_proc_data.cs_config = *data;
+	reqtracker->bcs_proc_data.t_sw_time_us_supported_by_local =
+						rap->local_sw_time;
+	reqtracker->bcs_proc_data.t_sw_time_us_supported_by_remote =
+						rap->remote_sw_time;
+	reqtracker->bcs_proc_data.ble_conn_interval = rap->conn_interval;
+}
+
+void bt_rap_set_local_sw_time(struct bt_rap *rap, uint8_t local_sw_time)
+{
+	if (!rap)
+		return;
+
+	rap->local_sw_time = local_sw_time;
+}
+
+void bt_rap_set_remote_sw_time(struct bt_rap *rap, uint8_t remote_sw_time)
+{
+	if (!rap)
+		return;
+
+	rap->remote_sw_time = remote_sw_time;
+}
+
+void bt_rap_set_conn_interval(struct bt_rap *rap, uint16_t conn_interval)
+{
+	if (!rap)
+		return;
+
+	rap->conn_interval = conn_interval;
 }
 
 struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
@@ -2122,7 +2593,8 @@ static size_t get_mode_zero_length(enum cs_role remote_role)
 }
 
 static void parse_mode_zero(struct bt_rap *rap, struct iovec *mode_iov,
-			    enum cs_role remote_role)
+			    enum cs_role remote_role,
+			    struct cs_mode_zero_data *out)
 {
 	uint8_t packet_quality;
 	int8_t packet_rssi_dbm;
@@ -2143,7 +2615,12 @@ static void parse_mode_zero(struct bt_rap *rap, struct iovec *mode_iov,
 		}
 	}
 
-	/* TODO: Store this data as reflector data */
+	if (out) {
+		out->packet_quality = packet_quality;
+		out->packet_rssi_dbm = (uint8_t)packet_rssi_dbm;
+		out->packet_ant = packet_ant;
+		out->init_measured_freq_offset = init_measured_freq_offset;
+	}
 }
 
 static size_t get_mode_one_length(bool include_pct)
@@ -2154,7 +2631,8 @@ static size_t get_mode_one_length(bool include_pct)
 }
 
 static void parse_mode_one(struct bt_rap *rap, struct iovec *mode_iov,
-			   enum cs_role remote_role, bool include_pct)
+			   enum cs_role remote_role, bool include_pct,
+			   struct cs_mode_one_data *out)
 {
 	uint8_t packet_quality;
 	uint8_t packet_nadm;
@@ -2178,7 +2656,20 @@ static void parse_mode_one(struct bt_rap *rap, struct iovec *mode_iov,
 		parse_i_q_sample(mode_iov, &pct2_i, &pct2_q);
 	}
 
-	/* TODO: Store this data as reflector data */
+	if (out) {
+		out->packet_quality = packet_quality;
+		out->packet_nadm = packet_nadm;
+		out->packet_rssi_dbm = (uint8_t)packet_rssi_dbm;
+		out->packet_ant = packet_ant;
+		if (remote_role == CS_ROLE_REFLECTOR)
+			out->tod_toa_refl = time_value;
+		else
+			out->toa_tod_init = time_value;
+		out->packet_pct1.i_sample = pct1_i;
+		out->packet_pct1.q_sample = pct1_q;
+		out->packet_pct2.i_sample = pct2_i;
+		out->packet_pct2.q_sample = pct2_q;
+	}
 }
 
 static size_t get_mode_two_length(uint8_t num_antenna_paths)
@@ -2189,7 +2680,8 @@ static size_t get_mode_two_length(uint8_t num_antenna_paths)
 }
 
 static void parse_mode_two(struct bt_rap *rap, struct iovec *mode_iov,
-			   uint8_t num_antenna_paths)
+			   uint8_t num_antenna_paths,
+			   struct cs_mode_two_data *out)
 {
 	uint8_t ant_perm_index;
 	int16_t tone_pct_i[5];
@@ -2228,7 +2720,14 @@ static void parse_mode_two(struct bt_rap *rap, struct iovec *mode_iov,
 	DBG(rap, "    cs_mode_two_data: ant_perm_idx=%u",
 		ant_perm_index);
 
-	/* TODO: Store this data as reflector data */
+	if (out) {
+		out->ant_perm_index = ant_perm_index;
+		for (k = 0; k < num_paths; k++) {
+			out->tone_pct[k].i_sample = tone_pct_i[k];
+			out->tone_pct[k].q_sample = tone_pct_q[k];
+			out->tone_quality_indicator[k] = tone_quality[k];
+		}
+	}
 }
 
 static size_t get_mode_three_length(uint8_t num_antenna_paths, bool include_pct)
@@ -2239,13 +2738,17 @@ static size_t get_mode_three_length(uint8_t num_antenna_paths, bool include_pct)
 
 static void parse_mode_three(struct bt_rap *rap, struct iovec *mode_iov,
 			     enum cs_role remote_role, bool include_pct,
-			     uint8_t num_antenna_paths)
+			     uint8_t num_antenna_paths,
+			     struct cs_mode_three_data *out)
 {
+	struct cs_mode_one_data *out_m1 = out ? &out->mode_one_data : NULL;
+	struct cs_mode_two_data *out_m2 = out ? &out->mode_two_data : NULL;
+
 	/* Mode 3 = Mode 1 + Mode 2 */
-	parse_mode_one(rap, mode_iov, remote_role, include_pct);
+	parse_mode_one(rap, mode_iov, remote_role, include_pct, out_m1);
 
 	if (mode_iov->iov_len > 0)
-		parse_mode_two(rap, mode_iov, num_antenna_paths);
+		parse_mode_two(rap, mode_iov, num_antenna_paths, out_m2);
 }
 
 static bool parse_subevent_header(struct iovec *iov,
@@ -2278,7 +2781,8 @@ static bool parse_subevent_header(struct iovec *iov,
 
 static bool parse_step(struct bt_rap *rap, struct iovec *iov,
 			struct cstracker *reqtracker,
-			uint8_t num_antenna_paths, uint8_t step_idx)
+			uint8_t num_antenna_paths, uint8_t step_idx,
+			struct cs_step_data *out_step)
 {
 	uint8_t mode_byte, step_mode;
 	bool include_pct;
@@ -2337,20 +2841,42 @@ static bool parse_step(struct bt_rap *rap, struct iovec *iov,
 	mode_iov.iov_base = payload;
 	mode_iov.iov_len = step_payload_len;
 
+	if (out_step) {
+		out_step->step_mode = step_mode;
+		out_step->step_chnl = 0;
+		out_step->step_data_length = (uint8_t)step_payload_len;
+	}
+
 	switch (step_mode) {
-	case CS_MODE_ZERO:
-		parse_mode_zero(rap, &mode_iov, remote_role);
+	case CS_MODE_ZERO: {
+		struct cs_mode_zero_data *out = out_step ?
+			&out_step->step_mode_data.mode_zero_data : NULL;
+
+		parse_mode_zero(rap, &mode_iov, remote_role, out);
 		break;
-	case CS_MODE_ONE:
-		parse_mode_one(rap, &mode_iov, remote_role, include_pct);
+	}
+	case CS_MODE_ONE: {
+		struct cs_mode_one_data *out = out_step ?
+			&out_step->step_mode_data.mode_one_data : NULL;
+
+		parse_mode_one(rap, &mode_iov, remote_role, include_pct, out);
 		break;
-	case CS_MODE_TWO:
-		parse_mode_two(rap, &mode_iov, num_antenna_paths);
+	}
+	case CS_MODE_TWO: {
+		struct cs_mode_two_data *out = out_step ?
+			&out_step->step_mode_data.mode_two_data : NULL;
+
+		parse_mode_two(rap, &mode_iov, num_antenna_paths, out);
 		break;
-	case CS_MODE_THREE:
+	}
+	case CS_MODE_THREE: {
+		struct cs_mode_three_data *out = out_step ?
+			&out_step->step_mode_data.mode_three_data : NULL;
+
 		parse_mode_three(rap, &mode_iov, remote_role, include_pct,
-						num_antenna_paths);
+					num_antenna_paths, out);
 		break;
+	}
 	default:
 		break;
 	}
@@ -2360,12 +2886,16 @@ static bool parse_step(struct bt_rap *rap, struct iovec *iov,
 
 static void parse_subevent_steps(struct bt_rap *rap, struct iovec *iov,
 				struct cstracker *reqtracker,
-				uint8_t num_antenna_paths, uint8_t num_steps)
+				uint8_t num_antenna_paths, uint8_t num_steps,
+				struct cs_step_data *out_steps)
 {
 	uint8_t i;
 
 	for (i = 0; i < num_steps; i++) {
-		if (!parse_step(rap, iov, reqtracker, num_antenna_paths, i))
+		struct cs_step_data *out = out_steps ? &out_steps[i] : NULL;
+
+		if (!parse_step(rap, iov, reqtracker, num_antenna_paths, i,
+				out))
 			break;
 	}
 }
@@ -2376,6 +2906,10 @@ static void parse_ras_data_segments(struct bt_rap *rap,
 	struct iovec iov;
 	uint8_t antenna_mask;
 	uint8_t num_antenna_paths;
+	uint16_t ranging_counter;
+	struct cs_proc_state *state = NULL;
+	struct bcs_procedure_data *bcs = NULL;
+	bool is_initiator;
 
 	if (!rap || !reqtracker)
 		return;
@@ -2387,10 +2921,30 @@ static void parse_ras_data_segments(struct bt_rap *rap,
 		ranging_header_get_antenna_mask(&reqtracker->ranging_header_);
 	num_antenna_paths = antenna_mask_count_paths(antenna_mask);
 
+	ranging_counter =
+		ranging_header_get_counter(&reqtracker->ranging_header_);
+
+	/* Find the per-procedure state that matches this RAS counter */
+	if (rap->procedure_data_cb) {
+		state = find_proc_state_for_ras(reqtracker, ranging_counter);
+		if (state) {
+			bcs = &state->bcs_data;
+			bcs->reflector_selected_tx_power =
+				reqtracker->ranging_header_.selected_tx_power;
+		}
+	}
+
+	/* When local role=INITIATOR, remote data goes to
+	 * reflector_subevent_results. When local role=REFLECTOR,
+	 * remote data goes to initiator_subevent_results.
+	 */
+	is_initiator = (reqtracker->role == CS_ROLE_INITIATOR);
+
 	iov = reqtracker->segment_data;
 
 	while (iov.iov_len >= RAS_SUBEVENT_HEADER_SIZE) {
 		struct ras_subevent_header hdr;
+		struct cs_step_data *steps = NULL;
 
 		if (!parse_subevent_header(&iov, &hdr))
 			break;
@@ -2402,19 +2956,66 @@ static void parse_ras_data_segments(struct bt_rap *rap,
 		    hdr.reference_power_level,
 		    hdr.num_steps_reported);
 
+		if (bcs && hdr.num_steps_reported > 0)
+			steps = calloc(hdr.num_steps_reported, sizeof(*steps));
+
 		parse_subevent_steps(rap, &iov, reqtracker,
 					num_antenna_paths,
-					hdr.num_steps_reported);
+					hdr.num_steps_reported,
+					steps);
+
+		if (bcs) {
+			uint32_t stored_steps =
+					steps ? hdr.num_steps_reported : 0;
+
+			if (is_initiator)
+				bcs_proc_data_add_reflector_subevent(bcs,
+					hdr.start_acl_conn_event,
+					hdr.frequency_compensation,
+					hdr.reference_power_level,
+					num_antenna_paths,
+					hdr.subevent_abort_reason,
+					0,
+					steps, stored_steps);
+			else
+				bcs_proc_data_add_initiator_subevent(bcs,
+					hdr.start_acl_conn_event,
+					hdr.frequency_compensation,
+					hdr.reference_power_level,
+					num_antenna_paths,
+					hdr.subevent_abort_reason,
+					0,
+					steps, stored_steps);
+			steps = NULL; /* ownership transferred */
+		} else {
+			free(steps);
+			steps = NULL;
+		}
 
-		if (hdr.subevent_done_status ==
-		    SUBEVENT_DONE_ALL_RESULTS_COMPLETE ||
-		    hdr.ranging_done_status ==
+		if (state) {
+			if (hdr.subevent_done_status ==
+			    SUBEVENT_DONE_ALL_RESULTS_COMPLETE)
+				state->remote_has_complete_subevent = true;
+			if (hdr.ranging_done_status ==
+			    RANGING_DONE_ALL_RESULTS_COMPLETE)
+				state->remote_status =
+						CS_PROC_ALL_RESULTS_COMPLETE;
+		}
+
+		if (bcs && hdr.ranging_abort_reason)
+			bcs->reflector_procedure_abort_reason =
+					hdr.ranging_abort_reason & 0x0F;
+
+		if (hdr.ranging_done_status ==
 		    RANGING_DONE_ALL_RESULTS_COMPLETE) {
 			DBG(rap, "Ranging procedure complete");
 			break;
 		}
 	}
 
+	if (state)
+		check_cs_procedure_complete(rap, reqtracker, state);
+
 	free(reqtracker->segment_data.iov_base);
 	reqtracker->segment_data.iov_base = NULL;
 	reqtracker->segment_data.iov_len = 0;
diff --git a/src/shared/rap.h b/src/shared/rap.h
index 5582635e6..342b504ea 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -157,10 +157,45 @@ struct rap_ev_cs_subevent_result_cont {
 	struct cs_step_data step_data[];
 };
 
+struct cs_subevent_result_data {
+	uint16_t             start_acl_conn_evt_counter;
+	uint16_t             freq_comp;
+	int8_t               ref_pwr_lvl;
+	uint8_t              num_ant_paths;
+	uint8_t              subevent_abort_reason;
+	uint64_t             timestamp_nanos;
+	uint32_t             num_steps;
+	struct cs_step_data *step_data;
+};
+
+struct bcs_procedure_data {
+	uint16_t procedure_counter;
+	uint16_t procedure_sequence;
+
+	int8_t   initiator_selected_tx_power;
+	int8_t   reflector_selected_tx_power;
+
+	struct cs_subevent_result_data *initiator_subevent_results;
+	uint32_t initiator_subevent_count;
+	uint8_t  initiator_procedure_abort_reason;
+
+	struct cs_subevent_result_data *reflector_subevent_results;
+	uint32_t reflector_subevent_count;
+	uint8_t  reflector_procedure_abort_reason;
+
+	struct rap_ev_cs_proc_enable_cmplt proc_enable_config;
+	struct rap_ev_cs_config_cmplt      cs_config;
+	uint8_t  t_sw_time_us_supported_by_local;
+	uint8_t  t_sw_time_us_supported_by_remote;
+	uint16_t ble_conn_interval;
+};
 typedef void (*bt_rap_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_rap_ready_func_t)(struct bt_rap *rap, void *user_data);
 typedef void (*bt_rap_destroy_func_t)(void *user_data);
 typedef void (*bt_rap_func_t)(struct bt_rap *rap, void *user_data);
+typedef void (*bt_rap_procedure_data_func_t)(struct bt_rap *rap,
+					struct bcs_procedure_data *data,
+					void *user_data);
 
 struct bt_rap *bt_rap_ref(struct bt_rap *rap);
 void bt_rap_unref(struct bt_rap *rap);
@@ -177,6 +212,10 @@ bool bt_rap_set_user_data(struct bt_rap *rap, void *user_data);
 bool bt_rap_set_debug(struct bt_rap *rap, bt_rap_debug_func_t func,
 			void *user_data, bt_rap_destroy_func_t destroy);
 
+bool bt_rap_set_procedure_data_cb(struct bt_rap *rap,
+				bt_rap_procedure_data_func_t cb,
+				void *user_data,
+				bt_rap_destroy_func_t destroy);
 /* session related functions */
 unsigned int bt_rap_register(bt_rap_func_t attached, bt_rap_func_t detached,
 					void *user_data);
@@ -228,6 +267,10 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 			int8_t max_tx_power);
 void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm);
 
+bool bt_rap_hci_set_procedure_data_cb(void *hci_sm,
+				bt_rap_procedure_data_func_t cb,
+				void *user_data,
+				bt_rap_destroy_func_t destroy);
 /* Connection handle mapping functions */
 bool bt_rap_set_conn_hndl(void *hci_sm,
 			struct bt_rap *rap,
@@ -245,3 +288,10 @@ void bt_rap_set_timeout_cb(void *hci_sm, void (*func)(void *),
 
 void bt_rap_set_proc_active_cb(void *hci_sm, void (*func)(bool, void *),
 				void *user_data);
+
+/* CS capability sw_time and connection interval setters */
+void bt_rap_set_local_sw_time(struct bt_rap *rap, uint8_t local_sw_time);
+
+void bt_rap_set_remote_sw_time(struct bt_rap *rap, uint8_t remote_sw_time);
+
+void bt_rap_set_conn_interval(struct bt_rap *rap, uint16_t conn_interval);
-- 


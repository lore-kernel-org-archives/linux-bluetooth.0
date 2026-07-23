Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE67415F3A
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800491; cv=none; b=C61RZR+EgLQE/xZV6f5/1uPOqebks028EBivlqYDtt5mXN7ZgAhMOVZSBqLy5txezyTkqJb/eLUwolXQAHo76GouYFcnLIGJOc22qOvd/S5Ci5ULy+BkTFB7kdSNf6z2S15QyRJwHdNHxApMm2Ba/K8W5rGHGkNPL84SZzLsSFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800491; c=relaxed/simple;
	bh=oBX29jZiEt+D2/buS2L+0i7L3WAaRQ8z+9T54snAU0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JtT0YNdbgPulbiwM4I1A1e60q6whmV37vFMD2eIEdD5PzeLXs/FUJ3Q3IBe6DK0u+dmABXahRgCNc4LK5ZWm/bVpuGfa4xX2nwJZlY8O2gLpvJ8UsT9sbQ8rbYd5t6NMtA5qhGvcIKMYHejUcWbePrdoEv1/3jU6HBGHZJgpv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aEohfa1C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eo2HY2b2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aEohfa1C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eo2HY2b2"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N8qkXJ3642784
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 09:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rTRPmzLbxW/4MdcLcQBgJJ
	wk7qus2vbW3nhBgux/Gl4=; b=aEohfa1CITzqPrPPlMAeqyAWM/06kMTaL1gEjq
	AnIQ9GE+lC2Gp2l7Ljjjydteszcre0XSWo8XFoFEPpFFvvvCycq4xrFMv3jCnjdR
	X6Yi9dcWRB9pvmnz/gF3FY285u6WU6g09PWR4oWnuRsYJfO18lfXnTTbPQ1RUdu2
	abntIU9hgH7tvcHmxVU3bFghZvzHThkCWxLtxVR4IOKVsW+CTyLRhvBlbBJziPlq
	eQBTyJfsEJY/tZbGuokRcDLaNbvsj725nAKjSB/TM9fb4hth2nsbtp67djDesctt
	UoLpnc/AT7HLR9E54UoysEkEmex6PXxoyBzYPV09vvem8i4A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkayh9e6c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 09:54:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cee1ec30f2so7255395ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 02:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784800486; x=1785405286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTRPmzLbxW/4MdcLcQBgJJwk7qus2vbW3nhBgux/Gl4=;
        b=eo2HY2b2CKhNBw29YqPtkw2HDnVUwe1cShVw+AmzO1IlHRdMN47jhg/FG6JKpGGMf8
         GyW8PQp7EDmE3LMEkfUNtQ4XugyXoRPSh37fxlHDdxrDVRX9VDg6asLJN4VES2w+dQFq
         FOINRDhC99p0um3BAqhCIvUNDJv45VVLdTQafMZea/rbldN++mJ3wnQYerSqGmtj55By
         nrobT+GQCTUoIBACXwDxnl9LodhxCatP1d6IDApOTwL8NfJc1Q/6iT5fsor62kg3FkM/
         qmTUaaA9gwvEGkOMUDrIclgm+mbu8H7PFN8eOMmdYf5C8VZwEpEOPT9tF6jEzbSOV/Sw
         WsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784800486; x=1785405286;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rTRPmzLbxW/4MdcLcQBgJJwk7qus2vbW3nhBgux/Gl4=;
        b=hu7SJQRu9vJMGllchpv2MmcyPV9Qz0y/bx2/uaPMOCEIfUghbmQ9xvoj4Ux2u/jWSk
         WPnWW/W82yHJ8pO6naNekAYe3JBc4/CfkBc2hSWIrPpMLQvbh7IpxGXvHGjAQmCQf6jS
         ZuutcN5tvzfmZ1YDMbKxfv0GbZie6NvtW2GExhPuZZPbUJZMN/3WlRGL3sTf/CSCcWgp
         wx7yvN1auHrJw+7lpR8NgtfZwIgqjUzCy1w6CIvC69w9VWwX1GoRVq92tFcvZEuCt4ei
         eknAWkWJIeg8/5rqoqyc1J4mzadeXpLGoKX37R43Fsg9usdNzojhNNMlA7NxO6zTqHdz
         QaOA==
X-Gm-Message-State: AOJu0Yy4nWGXWDL4Ieeg1mV3640Q8Y9vMAMDFHHtUeTYGoQTCJXNMHS6
	cchJcnFRNQhP6OFVI/EQn62oTTTosWYr2COQe//L8F+Ouf051jgZwpPdGRrZ0P0CsXYuLHTC0F3
	uKoXi71d3o/X7diEurCGayw6F+3QHb9K44jRjR0efVMluxpU9BQCQRBsrS89beFLesF3Cw6TFd1
	MaDys=
X-Gm-Gg: AR+sD10AV9LwDXnOX3CC9RaC83aYbfh0j0QzCq/+P1sNz9KsmMz1tUfriXqhn/2b6GW
	PzI3GqVyvKuLu9CmZtaeQjAl5tIeoEdcOLIdhHkLuwfHbLaN+7n0zRwAIDqHK2SeLawc2YLfWfc
	hXiyxrnKATkaXZSLmhfQQbSrcrqCkA7GidMyLA0vx0c+0zf4wW+mTwUha1L5BocQoa4xZtnJPbP
	3+esUwVGc1T3oiqOwr1mTsZwdgXt/sDU6VNHSoNRdFUBpkq8ssZqCrgTKouZl5KvU2Gc4e6xqdK
	ek8McSKfsz2QXilhxaz2K0PoYdGfBbhEYj18LW4eo4Q6MFMq5C0NvOtxbDVeJWHhFfnw+VI6TQC
	3wcWTzPuAqSGoo03leA8AUw==
X-Received: by 2002:a17:903:3b8f:b0:2c9:b8b7:5d1c with SMTP id d9443c01a7336-2cfa6b7a885mr30777975ad.16.1784800485760;
        Thu, 23 Jul 2026 02:54:45 -0700 (PDT)
X-Received: by 2002:a17:903:3b8f:b0:2c9:b8b7:5d1c with SMTP id d9443c01a7336-2cfa6b7a885mr30777655ad.16.1784800485029;
        Thu, 23 Jul 2026 02:54:45 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e5f17sm31495435ad.41.2026.07.23.02.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:54:44 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v5] shared/rap: Add bcs_procedure_data aggregation and procedure data API
Date: Thu, 23 Jul 2026 15:24:40 +0530
Message-Id: <20260723095440.2524972-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HZgkiCE8 c=1 sm=1 tr=0 ts=6a61e4e7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=C4rH-d3b2fZPOIAJbaIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: YTK8UNDfgqNMQU5AlbykYQ0INqygHEDb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5NyBTYWx0ZWRfX/3xZNv9hpMqm
 XMV5fviHAnl7zZfFfICHRtWLCjYlJkM+qVJXmUG6PL5xDwr8FXhoBWXzIIn7pBPiEfDkz16Nb3q
 p4d/o7QvE2Cgxn747z2s9y5coIEOkKvId4Z7zvWHN7s74nJNx2A6rp7vCgT3Xq3pk3B0Xo80QB0
 BfljUvHLtpNd3a7GmR6o3FdXqi82VBhUL1EGdreGlNMiKRJ+BQnBd4N99FWtp1GlloclmTYsKj9
 T1Ja4IBhLTki9lYQBvQMvYjWxpkUHhPfM549IQvQeZxAG/3iO71IA7nyca6bS0zdfSy9JFtkzZi
 m60zvLNl2SFy2pOCFExUAS5LRTjTcc/zQEy1OcSrOryFWJ5BNRO02d5VA52jHQXZa8Ey+d5cPRT
 FBz+cWBs8hJ/uTRM+9E1AlRkiVhKwFV88RYmVsg7xdeYPXxhMVdSJ288Ql2BRNaalJX7FKZYoJK
 NQwa1lK95AF40ekjCWQ==
X-Proofpoint-GUID: YTK8UNDfgqNMQU5AlbykYQ0INqygHEDb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5NyBTYWx0ZWRfX7elBZQO/Gxmx
 fn1NWOjur7p1ahDkcpbo/MaLg5WnNlDOndeMxJMxwHtbRHQWwaxUuLHXccixo17khL8FX38zr/o
 2N5YGgcOa/Z8JyLqKq2+gp+RS/7vOFA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230097

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
index dfb272d3a..eadc41707 100644
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
@@ -542,6 +581,177 @@ static bool cs_pd_ras_commit_subevent(struct cs_procedure_data *d,
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
+/* ---------- end bcs helpers ---------------------------------------------- */
+
 static struct ras *rap_get_ras(struct bt_rap *rap)
 {
 	if (!rap)
@@ -556,14 +766,6 @@ static struct ras *rap_get_ras(struct bt_rap *rap)
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
@@ -572,8 +774,6 @@ void bt_rap_detach(struct bt_rap *rap)
 	bt_gatt_client_idle_unregister(rap->client, rap->idle_id);
 	bt_gatt_client_unref(rap->client);
 	rap->client = NULL;
-
-	queue_foreach(bt_rap_cbs, rap_detached, rap);
 }
 
 static void rap_db_free(void *data)
@@ -608,15 +808,21 @@ static void rap_free(void *data)
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
@@ -702,6 +908,24 @@ bool bt_rap_set_debug(struct bt_rap *rap, bt_rap_debug_func_t func,
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
@@ -716,6 +940,7 @@ static void cs_tracker_init(struct cstracker *t)
 	t->last_start_acl_conn_evt_counter = 0;
 	t->last_freq_comp = 0;
 	t->last_ref_pwr_lvl = 0;
+	t->proc_states = queue_new();
 
 	/* Initialize ranging header using helper functions */
 	memset(&t->ranging_header_, 0, sizeof(t->ranging_header_));
@@ -1804,12 +2029,180 @@ static void form_ras_data_with_cs_subevent_result_cont(struct bt_rap *rap,
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
2.34.1


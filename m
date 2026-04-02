Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10EB35958
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126366; cv=none; b=Ugn6W9LAAjdtsHhkA/PIxDnqXYt+QJ53cZzHmQSAfNv+jTxVratoetFjuDslPZX+BoEBhsbBn0fcQ4ylzOIaYT6TuMAHt5RRLA2z6DmtYhc2LnAP++1CO642CDIGlwu3LMUn9tj/Ja0QWIKfEsYuGvxMyitxvPkJPG9kBPL5MQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126366; c=relaxed/simple;
	bh=wnqs73yqtT3jTjHAfv9P7Yo6SRhjntkQGtx6ujb4nyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D28FTDfOeZf7rg46ZsHbLnPAe9Gd9yyuXyUDEnMXbv3osGbbsIBt6UHtm9xrMVC9VVnFgjRCtObWRIRLCvkw/0WbUYs7KByCcGIAUcub3lY1FnLI+sN+sZrZDBlI7qxIKj+9oZovL6hSJHtIJMh4T6ObTHXV/WWANiOAHnmQwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=glFt6Tfw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TEsOYy81; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="glFt6Tfw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TEsOYy81"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6328Rrh8352074
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 Apr 2026 10:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=O+KQZvKV+kc
	YZ45yX9RukF/Jj8wWq2f8AsTV0MSnfbQ=; b=glFt6TfwQfKfamJW+9Mr+sN9658
	1bxBOZ8Y3aQ5iQKDm3y9Q6actn5Zi/qEpnFwb9kFg7IAXLeI23jkUbSdekY5rhP2
	JlOubA6HwzdDlSresYyFmBx7A0eQVGnuRl+MuzMuLb2NlW7sxxJXzkI5aDvzwki1
	TSWrZgIA778QJaH8kBSe9PjzQ6U8qu2Urh6N9tBovqy3Bedxfroa4JhTFzShqZro
	u7ULkHKkAHRo8SEb8YYX9XiOH67Z26+cBh96o4Ij5Xj2DaN2pbTuaOHjuULRc7ay
	MZsNC8goZdxhOBBzs8sj3XsD9QgOXFrdx/HwunI9mAkR8rpPFdnI72LmwEg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9myh8g8c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 10:39:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35c12a3bbb9so787165a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775126363; x=1775731163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+KQZvKV+kcYZ45yX9RukF/Jj8wWq2f8AsTV0MSnfbQ=;
        b=TEsOYy81BV915m54w84LLN6VthLY0c6zI1wTX66NI633PxrVAP9g6fFpmWCv+j2DpC
         c5JnD+qzsZZGwDFfq4i2IX7qurvRvOVr+3Vewiq5ntAAXSOXr1AwtgOF0h82D/TAIl+D
         rEcSpLRoTQB5j+ATHpQwqbmX/afYrACZEmTA4CCFOCgRQtmBKd2O/BUa0H/Xd3RpBfxx
         UsJS1UjnRjAh/ui1+k+zERPtdMZFy7IPJvqHBGNTKIIqSA5Z4wNmuAUCRRRk6asnNF7k
         EUkVBE85rYuWDCv6N4Ji0BxcfCxHdfeJ/U4Mli7ajr5xd7ntPUkhuyNe7+9vLRpvAFqR
         zlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775126363; x=1775731163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O+KQZvKV+kcYZ45yX9RukF/Jj8wWq2f8AsTV0MSnfbQ=;
        b=Ckd97ZKmFSb3ufJEnvQQqpOwtWp/Z/lw+rvKELPtqAWfaym1Y+/aCnPgy+duUKnZ3c
         ZDRw6rlRVNuc/WQjuDrp8ztGK9D0n/EubKDNi2zF27HJake/GjQ/7Rg4Y+MbGPlDah8i
         CcyUX34K5Hr02zr03jY5LEaQ+aVNVreVyem0YI+UJTi2LIUVMtGPBQA86x52PVn2TX63
         MUEKHIwHEfkrW7KfSnW3ZggWDSCsQKIFZQf225MF9rlipypHXaEq5h1pLbEBYFkFEliy
         ZfrmjRqDIKNXTSfNAq028gYcqZgPIVCoh/TMNoTV+w1HTVqx054IGKf9GbNnGlMX4Q7/
         g0iw==
X-Gm-Message-State: AOJu0YxiJIM9woHLGK90hIeXtUeZhlkO+NN+1id1bd/qpIbMy+ixrkAQ
	/K9EEv0LDvcaM20tmFH8Oxo1enHZYzKFTmbMRmiwxM+hMBBzI3UjV94aWEcNwT7snFMpF9Wn7K9
	cBYabqxtkvj5Lh9/xc5D34JqHYtaR3o7xRWaGIyMsFcFMMpAFA+fViwEPtn3Y1tKGB9L982fxDC
	hd2n4=
X-Gm-Gg: AeBDiestS7s8bayyktt52PmzlM+buVbFNEJDs4T9JvU90onsE5r3sc6rRkpoRmTHqPg
	gq1vBnuJQUgypz2sA5u3C6+5OfPz4ALLAWQkK2uD526ZFZdvspMOP6NVpaIiMVvz0PqWOBCOs8C
	0gPyXhLNp/Ey+vtubN48jLFIsz1nSZd+FARkKY/+mDf2ehuJISy3rkhTn30uENQhAu9SMQ/q7DN
	uVVimwKuqLmYhI4Uhj0yBnat9SVhzHWcb9zM9wENFWSu+sE7NCC4rKTJvIahP3EORhAZHzoNeaP
	teZz75h85KTNukkd3WI9xSbV0iQCldh36BmaIJYLxESQO5OjavoLaRRghXLIQFtg9K5AOHRKX2E
	qUxC+RqcA4hLOMu3/9nD6SG1f+iVYuk8CKqnRYAzymDJIXjOyT/U=
X-Received: by 2002:a17:90b:5544:b0:358:db7b:f686 with SMTP id 98e67ed59e1d1-35dc6f4e67dmr6350024a91.26.1775126363174;
        Thu, 02 Apr 2026 03:39:23 -0700 (PDT)
X-Received: by 2002:a17:90b:5544:b0:358:db7b:f686 with SMTP id 98e67ed59e1d1-35dc6f4e67dmr6349999a91.26.1775126362702;
        Thu, 02 Apr 2026 03:39:22 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe624756sm9993420a91.5.2026.04.02.03.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 03:39:22 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 1/3] shared: rap: Introduce Channel Sounding HCI raw  interface support
Date: Thu,  2 Apr 2026 16:08:58 +0530
Message-Id: <20260402103900.310778-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402103900.310778-1-naga.akella@oss.qualcomm.com>
References: <20260402103900.310778-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ISJkHwr1IMwdKywoTs1ohIDlLWAQEsU6
X-Proofpoint-ORIG-GUID: ISJkHwr1IMwdKywoTs1ohIDlLWAQEsU6
X-Authority-Analysis: v=2.4 cv=JII2csKb c=1 sm=1 tr=0 ts=69ce475c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=U2x06QSrdqR-QH8RZ5UA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NSBTYWx0ZWRfX4kNMZhEYPEgk
 rSwqCF31E3xPTo9z1pYHf9dgItiByGRPNQyk4dSZMZSrJc0yIAqbaFA4uAGYEc2BQ7pMxRaR3Ui
 fi93/SzjmMqHNctTLHvs5MAgtUa6eL46yE+vcjWsvgn8Lu2JgMu8wvtrp4IK5LRuBw3/cwL/6Cc
 2mRLabVEPsoCEU+7/YyUadXuKqz8cr1u8gwcq+Kd1D+6MbYVkA7bgEwZxjwtuiTsPXJ69QJaTJp
 psbt9VEt/xwuP8AeDx48GCSYOLWZjjE5OxXTi0+mwBELBBlPdB5iB+SFmTPUePAcch3CopLdKOd
 s6kOL+7YLBB/DIdmYB/8qGp1S+cVpka0kvIsADXo2zrvZ2qnMnJZiKe8u0aO7hXM6q2/5VZx4Ri
 UWCFmz/P/jpDy3dQCmEYl4TAo6fCdWXV8RWsg988vjQnzmnL+KUpgTede8QkLzJCgFb0xm6W+lV
 P5ROCgXcVzT++emNKxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020095

Implement stub callbacks for Channel Sounding HCI events and add the
required protocol definitions for CS configuration, procedure control,
and subevent result parsing

Add data structures to support Channel Sounding Processing
---
 src/shared/rap.c |  46 +++++++++++++
 src/shared/rap.h | 168 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index 39ef3f278..a0ca6ca71 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -504,6 +504,52 @@ bool bt_rap_unregister(unsigned int id)
 	return true;
 }
 
+void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
+						const void *param,
+						void *user_data)
+{
+	struct bt_rap *rap = user_data;
+
+	DBG(rap, "Received CS subevent CONT: len=%d", length);
+}
+
+void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
+					const void *param,
+					void *user_data)
+{
+	struct bt_rap *rap = user_data;
+
+	DBG(rap, "Received CS subevent: len=%d", length);
+}
+
+void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
+						const void *param,
+						void *user_data)
+{
+	struct bt_rap *rap = user_data;
+
+	DBG(rap, "Received CS procedure enable complete subevent: len=%d",
+	    length);
+}
+
+void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
+						 const void *param,
+						 void *user_data)
+{
+	struct bt_rap *rap = user_data;
+
+	DBG(rap, "Received CS security enable subevent: len=%d", length);
+}
+
+void bt_rap_hci_cs_config_complete_callback(uint16_t length,
+					const void *param,
+					void *user_data)
+{
+	struct bt_rap *rap = user_data;
+
+	DBG(rap, "Received CS config complete subevent: len=%d", length);
+}
+
 struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 {
 	struct bt_rap *rap;
diff --git a/src/shared/rap.h b/src/shared/rap.h
index a1d1ff2ae..5bd45a65d 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -9,9 +9,154 @@
 #include <inttypes.h>
 
 #include "src/shared/io.h"
+#include "lib/bluetooth/mgmt.h"
+#include "src/shared/hci.h"
 
 struct bt_rap;
 
+/* Channel Sounding Events */
+struct bt_rap_hci_cs_options {
+	uint8_t role;
+	uint8_t cs_sync_ant_sel;
+	int8_t max_tx_power;
+	int rtt_type;
+};
+
+#define CS_MODE_ZERO				0x00
+#define CS_MODE_ONE				0x01
+#define CS_MODE_TWO				0x02
+#define CS_MODE_THREE				0x03
+
+#define CS_REFLECTOR			0x01
+#define CS_INITIATOR			0x00
+
+#define CS_MAX_ANT_PATHS			0x05
+#define CS_MAX_STEPS			0xA0
+#define CS_MAX_STEP_DATA_LEN		0xFF
+
+struct rap_ev_cs_config_cmplt {
+	uint8_t status;
+	uint16_t conn_hdl;
+	uint8_t config_id;
+	uint8_t action;
+	uint8_t main_mode_type;
+	uint8_t sub_mode_type;
+	uint8_t min_main_mode_steps;
+	uint8_t max_main_mode_steps;
+	uint8_t main_mode_rep;
+	uint8_t mode_0_steps;
+	uint8_t role;
+	uint8_t rtt_type;
+	uint8_t cs_sync_phy;
+	uint8_t channel_map[10];
+	uint8_t channel_map_rep;
+	uint8_t channel_sel_type;
+	uint8_t ch3c_shape;
+	uint8_t ch3c_jump;
+	uint8_t reserved;
+	uint8_t t_ip1_time;
+	uint8_t t_ip2_time;
+	uint8_t t_fcs_time;
+	uint8_t t_pm_time;
+} __packed;
+
+struct rap_ev_cs_sec_enable_cmplt {
+	uint8_t status;
+	uint16_t conn_hdl;
+} __packed;
+
+struct rap_ev_cs_proc_enable_cmplt {
+	uint8_t status;
+	uint16_t conn_hdl;
+	uint8_t config_id;
+	uint8_t state;
+	uint8_t tone_ant_config_sel;
+	int8_t sel_tx_pwr;
+	uint8_t sub_evt_len[3];
+	uint8_t sub_evts_per_evt;
+	uint16_t sub_evt_intrvl;
+	uint16_t evt_intrvl;
+	uint16_t proc_intrvl;
+	uint16_t proc_counter;
+	uint16_t max_proc_len;
+} __packed;
+
+#define CS_MAX_STEPS			0xA0
+
+struct pct_iq_sample {
+	int16_t i_sample;
+	int16_t q_sample;
+} __packed;
+
+struct cs_mode_zero_data {
+	uint8_t packet_quality;
+	uint8_t packet_rssi_dbm;
+	uint8_t packet_ant;
+	uint32_t init_measured_freq_offset;
+} __packed;
+
+struct cs_mode_one_data {
+	uint8_t packet_quality;
+	uint8_t packet_rssi_dbm;
+	uint8_t packet_ant;
+	uint8_t packet_nadm;
+	int16_t toa_tod_init;
+	int16_t tod_toa_refl;
+	struct pct_iq_sample packet_pct1;
+	struct pct_iq_sample packet_pct2;
+} __packed;
+
+struct cs_mode_two_data {
+	uint8_t ant_perm_index;
+	struct pct_iq_sample tone_pct[4];
+	uint8_t tone_quality_indicator[4];
+} __packed;
+
+struct cs_mode_three_data {
+	struct cs_mode_one_data mode_one_data;
+	struct cs_mode_two_data mode_two_data;
+} __packed;
+
+union cs_mode_data {
+	struct cs_mode_zero_data mode_zero_data;
+	struct cs_mode_one_data mode_one_data;
+	struct cs_mode_two_data mode_two_data;
+	struct cs_mode_three_data mode_three_data;
+};
+
+struct cs_step_data {
+	uint8_t step_mode;
+	uint8_t step_chnl;
+	uint8_t step_data_length;
+	union cs_mode_data step_mode_data;
+} __packed;
+
+struct rap_ev_cs_subevent_result {
+	uint16_t conn_hdl;
+	uint8_t config_id;
+	uint16_t start_acl_conn_evt_counter;
+	uint16_t proc_counter;
+	uint16_t freq_comp;
+	uint8_t ref_pwr_lvl;
+	uint8_t proc_done_status;
+	uint8_t subevt_done_status;
+	uint8_t abort_reason;
+	uint8_t num_ant_paths;
+	uint8_t num_steps_reported;
+	struct cs_step_data step_data[];
+} __packed;
+
+struct rap_ev_cs_subevent_result_cont {
+	uint16_t conn_hdl;
+	uint8_t config_id;
+	uint8_t proc_done_status;
+	uint8_t subevt_done_status;
+	uint8_t abort_reason;
+	uint8_t num_ant_paths;
+	uint8_t num_steps_reported;
+	struct cs_step_data step_data[];
+} __packed;
+
 typedef void (*bt_rap_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_rap_ready_func_t)(struct bt_rap *rap, void *user_data);
 typedef void (*bt_rap_destroy_func_t)(void *user_data);
@@ -43,3 +188,26 @@ bool bt_rap_ready_unregister(struct bt_rap *rap, unsigned int id);
 bool bt_rap_unregister(unsigned int id);
 
 struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb);
+
+/* HCI Raw Channel Approach */
+void bt_rap_hci_cs_config_complete_callback(uint16_t length,
+					     const void *param,
+					     void *user_data);
+void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
+						 const void *param,
+						 void *user_data);
+void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
+						      const void *param,
+						      void *user_data);
+void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
+					     const void *param,
+					     void *user_data);
+void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
+						  const void *param,
+						  void *user_data);
+
+void bt_rap_hci_set_le_bcs_options(uint8_t role, uint8_t cs_sync_ant_sel,
+				   int8_t max_tx_power);
+
+bool bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci);
+void bt_rap_hci_sm_cleanup(void);
-- 


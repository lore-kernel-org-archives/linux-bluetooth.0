Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284EC4314A2
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354584; cv=none; b=czFawyC5Sy2phSqbn5gVNHbp4IVx8P9Inkx07EGFTUMOxEzUycP+QwRYfBf5kqZrZqU7OUJIyFBO90ip+KEq5MYgThdO0i7zxafTd3w6pan/hTfYt9UDk//kB7V2APktS0NSlG3KCHuC4h7Ou18FUdNHwBD6xLNwlO3AEeETL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354584; c=relaxed/simple;
	bh=3YkEhdf4yauYO3JXSFbIFKVRUJxCgANKd9pm79Jt6wU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJyvMmduIvcS9+HIGleLHKbsF2myxwQJRoaKgkjb8rzpNsYHucGp7HDaLHvG1uGSKHujiSpGqhWfXFUtMlrPscdJvV8LkIhyr9V+/N0ACHAZg2K+Gu3pxuLhSAYNc3aZfwU03xvP5mAuLx3gxvUrsYKJP2PZjvzVR4dic5EMmzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XB4HHhWG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KfHu7k4z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XB4HHhWG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KfHu7k4z"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFGil809794
	for <linux-bluetooth@vger.kernel.org>; Mon, 6 Jul 2026 16:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zPlSMKQ3haf
	zEh3F9FKV+QZZoLFMNPJJHN71OGP9/84=; b=XB4HHhWGW0Q5kqE5psAKAFkYr62
	V/bR/jZLf0KGoJ3RWa39R4GCbI919CZQv+JQUFpQIlugtDXnfG3v0eq2NRnXrsZG
	VMKLo0CUd9AcFYuP7c0Nng66HqmIWC6Pc9NTWNluYe3+hSjarznNmQTDf1fpNABu
	YT3S7mt6EScpW9EFw3gjtk33lgllTr80++2VtB1f1RzvHeyL/TKtyl2IiVgyTzjz
	IY43XiPr5wIUSedWSzryi6f2n1ELsCFnMXZ9tq5sMeVGZV1g3rXxso3c+KrXfp8q
	K15uBtLHjnMWzkMARUoLt5UWeYreAvVgzo/zfQOipmvdrr5ikewbWmKbTSA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsa7rt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 16:16:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38096521198so4930269a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783354578; x=1783959378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPlSMKQ3hafzEh3F9FKV+QZZoLFMNPJJHN71OGP9/84=;
        b=KfHu7k4zKWwGeawctOZKLnF70+zWbgTPXxsVQ1ZtabP2jjqLfVx+tY9rG3sR/RZ3S7
         sbQ3ziipBpdjub+fw7QCw89qVBEMHCf1CJR5mXSsbakusVtO6nqcNvMQeZM6HXrXkZPd
         ulMiRCx6OwksakbCmfQ2NVxL3G6RnPxbmjDlrLOT7mK179ctbQfg1gQfu6VpGi1Jba9r
         J97B2eZBiIo3YfeSjP4zC6JkZT9FKwCLcmVsRQGibS3bWKknhfgoExJ0gomrYxHAXTZ7
         odb7bcMaWGoEsQpbLaKd5UFxhAbNsSmknqQj13WJ7c5JqljSYQkLzBO5UuzrcIEP0BQs
         QA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354578; x=1783959378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zPlSMKQ3hafzEh3F9FKV+QZZoLFMNPJJHN71OGP9/84=;
        b=ToPCSCQC9Oqk2IuUT2WrE7UEhE4vqgYxCuoye3FyaeVpzsDO8MPumZDDH9bGOMvtMd
         hC89kbmvAQe22Uniqe38fum3rHNEf+LZkJgkXSUOqU/z/2bm7uyzMGCcevR/IlE/O50E
         KrtxSnYuZcZ6kt0doFnU5LpGn0Ed/zAlOemHFdOutG180c0nXzN7uWD9zt5CFfWPbMdN
         lD5X/S0M/rDLo3YNsYIAl98LI1z3wZKAuI7H77MKqYu0IbSOLXxU8KIUiWC1n/j0QRsd
         N25WDTzZWN5XdzDXhzhT7whF7RdlZuCubvATqvdJpzqZryTozmfLo+jf886O9Dr0b8O0
         Q+/w==
X-Gm-Message-State: AOJu0YyVZhMCL5OKXDXUGx7PJOlvF9PmNEBmEYCRCyYvplhvmmOmXVnA
	MP+N9IG08HBxfKxVuDrxNvv+66rsdYCGWZEcKcK5oNYn+JxepFWqL+cd9jHBebI3zhWQVRN6gZ/
	o407V+87B8oFcaAMUYv39kvVYeE87R/c5NUVYf+KnDDiM5AVmkn1NMC8VbTbkWwK4dRCs07wCLE
	bPanM=
X-Gm-Gg: AfdE7cmWPbE05H3tYSNvaafa6oXguJmi39vA1w16eyBTv1TY7H8BpIIMXCWFBJfTLVY
	q2vivnblW7eK7UQBAuiE6Pmxxo4bwv22V8WwBXgt+L/68aA+mPDAWq7yirIxQEwWcQMlhBnn+W3
	fzR+uO6DlVZ/CVjORxaX52i98Lh/UNkVhKJwJfdw76/CbD+PcH90BqlAW3mPW2usmVLggm3cRSf
	tFrgDMWGPU9Lr6B34mi6dX6Ua0XlAn1ooofG7F/BjQEekeezdsyfsG0AGg4Z9lxFW+VlzCWr0U2
	WsboRDck3Uj5dzL7mhNbUO+zbfCNbYPw4UJw8xB8cLHHfNaLQ+7T7l+BVOHI63lFva1VI6RrRpR
	C4/O1/e2v4XI0hBbYjn0oIkTy3Pm4Gp6Pry2grxot
X-Received: by 2002:a17:90b:5283:b0:37d:7bbb:afab with SMTP id 98e67ed59e1d1-38756ed119fmr1363738a91.11.1783354577694;
        Mon, 06 Jul 2026 09:16:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5283:b0:37d:7bbb:afab with SMTP id 98e67ed59e1d1-38756ed119fmr1363685a91.11.1783354577114;
        Mon, 06 Jul 2026 09:16:17 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f31e7a2a8sm40022434eec.25.2026.07.06.09.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:16:16 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 1/5] rap: Add Channel Sounding parameter types and APIs
Date: Mon,  6 Jul 2026 21:45:59 +0530
Message-Id: <20260706161603.2744459-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706161603.2744459-1-naga.akella@oss.qualcomm.com>
References: <20260706161603.2744459-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XGhDYj6AkSIAglSNkvz6fr6wUDJYWvWO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfX5UErYApouif0
 ITwwNs/kYv2wtbIcD7Rnh2vmUlxqFzRAiecaiFp5xc+DU7VyTWjlsZ4JoyB+WOiR00qLyrA1Sqq
 xa4AstyN7LjGtNo4B0O8W58LjOJx39aUzyIGvmbD3MXp4W2aJCeicIpaJdYKrnXwSk4AqbiQttQ
 lgN9oiY6SNMkAvH0K6+FgEzy6R7XS/mW5KPimWFZqjlO6HIuGkQRK+1IAa8gWFFihntrLJ4V7er
 BKlJcuAuQ/X+9dUwWRIL5grX08BL+9Ooxk1XwTIa83VuK9h8wZ9JeaOPVFpn52mKhD2XPpnw+Pg
 07iA3QAXBaqWTMuNkRYbwicqmGySG/6/O/Xeanm94V9Sv9HEhPo02kry7Jb01IBUXa5pvAe8SmV
 jGBQIznDGqgpsqvQeLAB0f/bcX44Be98kCIaSPQv940I8h3gO7HNVUeUSoOgyahGqqTOlgJNFQw
 5sGoimF2IAAXF4QnLyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfXzJ2xuB0T8UDp
 f5CArzm4z6u7xv7ujqTVIO29bFL8LCuBywS31z1/lQY+CC7kO9R3v37lHU8/o9km1yc88gAs+bu
 tmSkQMsShAcHQFUKNGC/fVEiTGPnPyQ=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4bd4d2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=nIMCxDPfprBCQ9Y--Y4A:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: XGhDYj6AkSIAglSNkvz6fr6wUDJYWvWO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060165

Add shared Channel Sounding parameter structures
(bt_rap_le_cs_config, bt_rap_le_cs_frequency and
bt_rap_le_cs_default_settings) for exchanging
CS configuration, frequency, and default settings
between the RAP DBus layer and HCI state machine.

Add getter/setter APIs for CS config, frequency
and default settings, add measurement.
---
 Makefile.am           |  2 +-
 src/shared/cs-types.h | 55 +++++++++++++++++++++++++++++++++++++++++++
 src/shared/rap.h      | 47 +++++++++++++++++++++++++++---------
 3 files changed, 92 insertions(+), 12 deletions(-)
 create mode 100644 src/shared/cs-types.h

diff --git a/Makefile.am b/Makefile.am
index 76c4ab5d4..a7b063c6e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -249,7 +249,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/asha.h src/shared/asha.c \
 			src/shared/battery.h src/shared/battery.c \
 			src/shared/uinput.h src/shared/uinput.c \
-			src/shared/rap.h src/shared/rap.c
+			src/shared/rap.h src/shared/rap.c src/shared/cs-types.h
 
 
 if READLINE
diff --git a/src/shared/cs-types.h b/src/shared/cs-types.h
new file mode 100644
index 000000000..62ab643cf
--- /dev/null
+++ b/src/shared/cs-types.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ * BlueZ - Bluetooth protocol stack for Linux
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#pragma once
+
+#include <stdint.h>
+
+#define BT_RAP_CS_MAX_CONFIGS   4
+#define BT_RAP_CS_MAX_FREQ_SETS 3
+
+struct bt_rap_le_cs_config {
+	uint8_t num_configs;
+	uint8_t config_id[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t main_mode_type[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t sub_mode_type[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t main_mode_min_steps[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t main_mode_max_steps[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t main_mode_repetition[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t mode0_steps[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t role[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t rtt_types[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t cs_sync_phy[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t channel_map[BT_RAP_CS_MAX_CONFIGS][10];
+	uint8_t channel_map_repetition[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t channel_selection_type[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t channel_shape[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t channel_jump[BT_RAP_CS_MAX_CONFIGS];
+	uint8_t companion_signal_enable[BT_RAP_CS_MAX_CONFIGS];
+};
+
+struct bt_rap_le_cs_frequency {
+	uint8_t  num_durations;
+	uint16_t max_procedure_duration[BT_RAP_CS_MAX_FREQ_SETS];
+	uint16_t min_period_between_procedures[BT_RAP_CS_MAX_FREQ_SETS];
+	uint16_t max_period_between_procedures[BT_RAP_CS_MAX_FREQ_SETS];
+	uint16_t max_procedure_count[BT_RAP_CS_MAX_FREQ_SETS];
+	uint8_t  min_sub_event_len[BT_RAP_CS_MAX_FREQ_SETS][3];
+	uint8_t  max_sub_event_len[BT_RAP_CS_MAX_FREQ_SETS][3];
+	uint8_t  tone_antenna_config_selection[BT_RAP_CS_MAX_FREQ_SETS];
+	uint8_t  phy[BT_RAP_CS_MAX_FREQ_SETS];
+	uint8_t  tx_power_delta[BT_RAP_CS_MAX_FREQ_SETS];
+	uint8_t  preferred_peer_antenna[BT_RAP_CS_MAX_FREQ_SETS];
+	uint8_t  snr_control_initiator[BT_RAP_CS_MAX_FREQ_SETS];
+	uint8_t  snr_control_reflector[BT_RAP_CS_MAX_FREQ_SETS];
+};
+
+struct bt_rap_le_cs_default_settings {
+	uint8_t role;
+	uint8_t cs_sync_ant_sel;
+	int8_t  max_tx_power;
+};
diff --git a/src/shared/rap.h b/src/shared/rap.h
index 7bc49f03d..22cb46653 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -9,8 +9,8 @@
 #include <inttypes.h>
 
 #include "src/shared/io.h"
-#include "bluetooth/mgmt.h"
 #include "src/shared/hci.h"
+#include "src/shared/cs-types.h"
 
 struct bt_rap;
 struct gatt_db;
@@ -189,22 +189,39 @@ bool bt_rap_unregister(unsigned int id);
 
 struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb);
 
+bool bt_rap_set_cs_config_params(void *hci_sm,
+				const struct bt_rap_le_cs_config *config);
+bool bt_rap_set_cs_freq_params(void *hci_sm,
+				const struct bt_rap_le_cs_frequency *frequency);
+bool bt_rap_set_default_settings_params(void *hci_sm,
+				const struct bt_rap_le_cs_default_settings *s);
+bool bt_rap_get_cs_config_params(void *hci_sm,
+				struct bt_rap_le_cs_config *config);
+bool bt_rap_get_cs_freq_params(void *hci_sm,
+				struct bt_rap_le_cs_frequency *frequency);
+bool bt_rap_get_default_settings_params(void *hci_sm,
+				struct bt_rap_le_cs_default_settings *s);
+/* Distance measurement control */
+bool bt_rap_start_measurement(void *hci_sm, uint16_t conn_handle,
+				uint32_t duration_secs);
+bool bt_rap_stop_measurement(void *hci_sm);
+
 /* HCI Raw Channel Approach */
 void bt_rap_hci_cs_config_complete_callback(uint16_t length,
-					     const void *param,
-					     void *user_data);
+				const void *param,
+				void *user_data);
 void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
-						 const void *param,
-						 void *user_data);
+				const void *param,
+				void *user_data);
 void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
-						      const void *param,
-						      void *user_data);
+				const void *param,
+				void *user_data);
 void bt_rap_hci_cs_subevent_result_callback(uint16_t length,
-					     const void *param,
-					     void *user_data);
+				const void *param,
+				void *user_data);
 void bt_rap_hci_cs_subevent_result_cont_callback(uint16_t length,
-						  const void *param,
-						  void *user_data);
+				const void *param,
+				void *user_data);
 
 void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 			uint8_t role, uint8_t cs_sync_ant_sel,
@@ -220,3 +237,11 @@ bool bt_rap_set_conn_hndl(void *hci_sm,
 			bool is_central);
 
 void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle);
+
+bool bt_rap_is_procedure_active(void *hci_sm);
+
+void bt_rap_set_timeout_cb(void *hci_sm, void (*func)(void *),
+				void *user_data);
+
+void bt_rap_set_proc_active_cb(void *hci_sm, void (*func)(bool, void *),
+				void *user_data);
-- 


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11087370D5E
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783858686; cv=none; b=fYD1FhtiTMU0laKtiDt7/924TGXRvw9jQsf0YH9fmkF5j2Z1Vx8XlqRS+SJEplzgG+zoM420s8yqMX79rkEiJocYzAi1fQwar3JIc46plxgrbKmuRhQkGLjhZU2+PbPtKU8Ona7KrcNkeY10ze3eUjE1VBW09yRzgvRneS+aHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783858686; c=relaxed/simple;
	bh=8WA6p/0wiTfKWqWxABEp3eLCsxMiRXOP72zXB2yx034=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+DBUxL1aLyM8i3Dm34Cb0J711C2tPdhSAh7uFD9YS4A2xOPnj9/ixnVsC0iyvMyx5gwpsNiiv+WzYj3bP8KknMm5YTuywMk3yRJzjyCFKN7SeKqJLzepCg/v8A1R2DKw/h1eweqd9MbbEDUx6w7rh5572ao8QirbTrdJz3i4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EKnJBDRG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Chs00jne; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EKnJBDRG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Chs00jne"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CAcpF22403511
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VnePDlf4jvF
	B5fxwH4nz2ECFHVsFzom0R6dISUmNV1o=; b=EKnJBDRGoAotFT4Nx937Mx1yVYg
	xBHeQ8sUBWuow8zhTkC6tXOq02im06GqFihQ1ZOiG7mhjqM2kvGHhtqVeOQ7cD8I
	ptfgM+9SvbRjtkGO1Td46x+rWDPdOG7eJfDiIw8C2pfion8B5Yo10MRbMxIhiDVO
	5Vgzl5BO79Hq40ThjACxhl7XKIhcgoCTsqIOlPrYdC58PYp9rI2vPssNchB2EcGY
	K/e7/DGOFxVtkUJcdV3TLnV/uVdQhcdb+jGS4ecvoRSaGnOtOpJKLnotizXRm5MV
	ROzmi625PPdNyorDbHpjP6//ymAJuA2junhdaG5scLV3srO4w2LrMSnpoeA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe9hjs96-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:18:03 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484b57b98bso4522392b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 05:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783858682; x=1784463482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VnePDlf4jvFB5fxwH4nz2ECFHVsFzom0R6dISUmNV1o=;
        b=Chs00jnedVhS/qNnJI4IKB15XPEOmZcXnglzKzTj4+HaBiPxTfpnlqopitejHN5xnO
         q5M94rhgij979i216SJSyEIXlaRhCDpG5IHcTNyDeKmJYRwUG4INaewY1uZ+LRT801Pb
         D04GDiO0Gq6MyhiJGS1CeLok+rAbLCJGafsh/0UvCnE0G5GwxxcXScV5RIi9j2Icx8ti
         FV71D5UuZdOXhFiHp6tq04FLMbZQhMHZxvSXVX9bYouhrGfOUgSoUkCYynOUbPmnOkof
         AlZJq4BlvylguWq2urYwuoIb8W90FhruQhCOBm21mdRoqU8wuxnqVGR3oU0hT8+qW7fw
         slCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783858682; x=1784463482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VnePDlf4jvFB5fxwH4nz2ECFHVsFzom0R6dISUmNV1o=;
        b=QWkcBO6cDbsSj17KWblju4dY017L1/8RuditpT188GTZJSixNfDWE6CJgvjJmmhKYG
         QWzsf5DyLYoxMP82Y3jW1yYhtf2vpLavskOE4+rUt9jux1WCp3szDo718WUek30PRDHw
         H4BWlSz3jVCIAbsE+oqlSrP/D3BvAuig0vxXlrItaadV6lzlld5aA/60CoqZ9yihWV3X
         I54pRFcFbOxGvWvmDhJsdhZD8MFs6MQ0g17kg2sMLvu/fYWwqT5Z42tSCvdG3Rh74ss1
         127risldP86NUTKH9mCeES4FWgaDhCtVip3FltmGjQb8ZAQS7FqY9wTUeyLOGlp1vyfx
         Vbfw==
X-Gm-Message-State: AOJu0YxALO3w+pO+R8Pa0ZBGdBEopTig38BCKHHcuYqhbkd8+yi25xTl
	5fW20vcz3Ne7IpiL2z8FWbKJO95JnSUumLG5otya4us68fqQbrmzUMDmk1i+5+DwEhZ3/EDTNcs
	rooGFMH7wjWcYGYKWJ7ZaNoUQBSWmv7GxvK74/lvj66wyAEK3hssqkNq9xkicbe9lXVvNrfWqGb
	p739I=
X-Gm-Gg: AfdE7cnmfHGMI8yxvymdED073qg3BRF6LRmINTY10DpCICrfU4f8rXpQKRIhmkGr1Hw
	f8YJqWW5kjWm2FMwq4QlpHzS8ZVsCqePRCXWfqW3wxOOfDq7gl6JA4OI4E9PayKYh74eRinnRJ5
	7REDCIAst65yr1pbxE1rz3SC6rjzc1Ao7bEbprgCHo7GOdeZlgLfcReZbC32fAuzqLrPlyQuHlK
	xZv7PzxFYfDksOYYhS7lq/W6KvlkZPEfBbUN/rygy34I2qf0EerA0zcjEoAa8EGI2iGrrJwMC1M
	56PQpB0HPLyw2xdcRcXEaz6ywHMBMe+4LzBKMDsGiffGG2Nsri561lz281bFWupo1Pr/F2PmLEu
	7t+Lg3ww7FWIiZn09G5N8TTBUr4mavKIX0Nl0IJOg
X-Received: by 2002:a05:6a21:3a85:b0:3bf:99fb:db96 with SMTP id adf61e73a8af0-3c110be06e4mr5437411637.49.1783858681683;
        Sun, 12 Jul 2026 05:18:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a85:b0:3bf:99fb:db96 with SMTP id adf61e73a8af0-3c110be06e4mr5437398637.49.1783858681275;
        Sun, 12 Jul 2026 05:18:01 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm29061040c88.1.2026.07.12.05.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 05:18:00 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 1/4] rap: Add Channel Sounding parameter types and APIs
Date: Sun, 12 Jul 2026 17:47:40 +0530
Message-Id: <20260712121743.2842547-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260712121743.2842547-1-naga.akella@oss.qualcomm.com>
References: <20260712121743.2842547-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ivdL9pyw1N-Th40hlI_Qx0HpYETV786r
X-Authority-Analysis: v=2.4 cv=SajHsPRu c=1 sm=1 tr=0 ts=6a5385fb cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=GhXf9q-71yA2H53oXBwA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: ivdL9pyw1N-Th40hlI_Qx0HpYETV786r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDEyOSBTYWx0ZWRfXxx/wQiPQfKPM
 K4Kt9wO13uAsb9BvbinX0JbchKU3Y/YLx9vsOsYVzaVrDsqHYZ8HiDGCe+uPAQPDnZYRymKUh83
 LtUcR2K2o6C6IJUCtTGRo3Zx8Znf0HrBeGSQcTIj0+Ocq8w0CYEOH1wc2ZysaVSBf89QSuP36ZA
 F6RfbS9J3qyeYloPTQI2O47YlfYlhgdVhOuHGiQRPrOo0mS5dmqoIbKUhZybVpRc6jYSnznql4e
 2QDeK5UpaHfkRYpulrLwEZ/Sln5MlDtXmFJD9pI8f1BG0RJcJyFzAts3NyustuUsSj1f9jgPqjw
 /H0mhoiRhaSCUG2EcLwBhJbHHnBJ8BzbTjvvj1fdz2HomQOxPDGVrHyymEb/GvrC2I3IZgJzbf2
 FhBeGev1o2mECiwlC01MEHJU0hwRKjzgD/HUfAs7u0hILKlR46Jcb9MPgKTy3HftlNlv/tAlcfB
 YVhlQWTXKFPVTxRuKig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDEyOSBTYWx0ZWRfXwpYCMhVuGN8Y
 CoLWaQQghagwf0SaHH0ZA3shkvFIh5thUHIGasRqnanOWO4c8G66k4iHOtNYvlho05gkdlwHPKV
 h/sRpO1j24fBJtrvYZboKuMyYlqGTf0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120129

Add shared Channel Sounding parameter structures
(bt_rap_le_cs_config, bt_rap_le_cs_frequency and
bt_rap_le_cs_default_settings) for exchanging
CS configuration, frequency, and default settings
between the RAP DBus layer and HCI state machine.

Add getter/setter APIs for CS config, frequency
and default settings, add measurement.
---
 Makefile.am           |  2 +-
 src/shared/cs-types.h | 50 +++++++++++++++++++++++++++++++++++++++++++
 src/shared/rap.h      | 27 ++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 2 deletions(-)
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
index 000000000..0d53d4ab8
--- /dev/null
+++ b/src/shared/cs-types.h
@@ -0,0 +1,50 @@
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
+struct bt_rap_le_cs_config {
+	uint8_t config_id;
+	uint8_t main_mode_type;
+	uint8_t sub_mode_type;
+	uint8_t main_mode_min_steps;
+	uint8_t main_mode_max_steps;
+	uint8_t main_mode_repetition;
+	uint8_t mode0_steps;
+	uint8_t role;
+	uint8_t rtt_types;
+	uint8_t cs_sync_phy;
+	uint8_t channel_map[10];
+	uint8_t channel_map_repetition;
+	uint8_t channel_selection_type;
+	uint8_t channel_shape;
+	uint8_t channel_jump;
+	uint8_t companion_signal_enable;
+};
+
+struct bt_rap_le_cs_frequency {
+	uint16_t max_procedure_duration;
+	uint16_t min_period_between_procedures;
+	uint16_t max_period_between_procedures;
+	uint16_t max_procedure_count;
+	uint8_t  min_sub_event_len[3];
+	uint8_t  max_sub_event_len[3];
+	uint8_t  tone_antenna_config_selection;
+	uint8_t  phy;
+	uint8_t  tx_power_delta;
+	uint8_t  preferred_peer_antenna;
+	uint8_t  snr_control_initiator;
+	uint8_t  snr_control_reflector;
+};
+
+struct bt_rap_le_cs_default_settings {
+	uint8_t role;
+	uint8_t cs_sync_ant_sel;
+	int8_t  max_tx_power;
+};
diff --git a/src/shared/rap.h b/src/shared/rap.h
index 7bc49f03d..5582635e6 100644
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
@@ -189,6 +189,23 @@ bool bt_rap_unregister(unsigned int id);
 
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
 					     const void *param,
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


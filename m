Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E2B3C09FE
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667320; cv=none; b=R2fHFUW3qbpk/f1BbCocf6JY+2u0dW+eLkz8RkFN35LUgU5G70lJzT9+EBbnGyxdOv2fR2ApmNkbDQhgOZcOa3SUnbKWG+57cxl6BHULI/1fRIWY+40Ot1AfQK54TKwzVQLMM7PL2VwJO15Vih5MoOhlXUSQR1Y/P334jurhEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667320; c=relaxed/simple;
	bh=8WA6p/0wiTfKWqWxABEp3eLCsxMiRXOP72zXB2yx034=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pM1GiHZO9kHw1ls9QkCOt765fXCeefWP+ci0LG1WbINKSyRGai1zXvNRRA+29RH/OqCF7b5sX0knIENlnIj33xnk39NfKP6OVWitngLaLIYUAHysrssi6aQ6XOKC5Jx3iA6VMcruyAW2kJNQw+k8WMniW9X/mZqROXPADo7Hjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aUOqpOJJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hzKjxUCE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aUOqpOJJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hzKjxUCE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3nOgi3753137
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 07:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VnePDlf4jvF
	B5fxwH4nz2ECFHVsFzom0R6dISUmNV1o=; b=aUOqpOJJdpopgw/l8ZqmIk9Qco1
	sYWeIGDap3AldQ/3gKVvGgbKV8pU2DTh2jXXmuDZpENpjZXxKYCIA8E0C+hhYiXj
	RxzPVxJ8NQdg+vBxzCFKrPJ7JsjKLfyVZkUgMtYVkD2m+ROqN0TDs7UCuvzVDGtf
	2GceOTrRLwNRDV8gPedIPwTtPfbBeprfMDQ5dTqkiHO7Mi+DjYXuuZm6wFkkFakh
	LsgBt/2ak09aKZCOFm7tBChIZV24pJDo03+aAWgXQe0rI4GPJS+U6VdwPrVWlOGP
	zM+cfAImPupjKtLRT7HfZSar1FRvpB2Ktt22tStSIxdkdNVtv/ZyLIx0RBw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjbfd9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 07:08:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38001e788d6so1215952a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783667316; x=1784272116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VnePDlf4jvFB5fxwH4nz2ECFHVsFzom0R6dISUmNV1o=;
        b=hzKjxUCEpsHdYDdsLvTz/WYeJccoYKWiyQrPoNJCaPG3Hr/oxCoxtz1x5dn12/hGYq
         Z3Q7DURpH+YTFeSfc5iVgPUVgJ0cJsqAi/5JhmDDHIswPYFnFRyzLv+F5VRlwRX3RuKW
         TaxyggrmqdmsxjSBY6qyRJcxtKZNfzRWXjNWzItxKdYTOr+/U7+IBSSCV3RXO2H3oa+G
         5Zg4g81WxN3MLtZFCLhrW2FzjdS41GhRoNFn14WXwKWF4xy4RS1IYRxfePsjP9nUwbia
         f888TGhw+Wdo9dlxoiDSmHSNd8HY7KLu+yk4JBdC7lrV56bnPfbqVzUeR+xlsGGwYgyH
         eyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783667316; x=1784272116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VnePDlf4jvFB5fxwH4nz2ECFHVsFzom0R6dISUmNV1o=;
        b=hcgdQn4fJd0kN7qQLmtLGveIVxrKXrX4F5+OWNHGKxD9HuWDOmTc7uq8mgzzSBK6gl
         KNQIsIjpE/J4Ux54CxUXbZnHtSPNQfeTD/qSiYTOmJUOBd56j+aA03OJ5N350XttxU6Q
         wsZQ6ZeofEvGjbOZ0y12TG+9EGbZmOLhiBmr5Jc4tCgPZS+Ucdz28jNlE74yk5Um1jCP
         qWB5+IwDolofHjH0hgcIaJdVVjwih2dbE1yOIbTj36IoG/S4wEKohJGm3xjwNLH/borB
         yuC1igwKFoEHZPheZahyEkUx1gi086X2Wtl0doMQFAuuBUWrL1r3zPJNAL0T6zSVDiU8
         M3tg==
X-Gm-Message-State: AOJu0Yzm00U0Uz122+QSeMxBlFKUo5aJGN8BCzWLNbn2a70t2B/GIQ98
	Wo18GeBCHRIn4moPXJCneMskXnVkJ/OJJGetpgRomLe8wJZRAIl0V+7212EpCJ9OpCoWnFmZkSf
	Jvzn2QKgBv2+Y34M2yutXKQCwpa7zr1b6+klFPflt8MU/1tm26bmBXqLSbGKeR6XNOvMoasj2Jg
	Y4m58=
X-Gm-Gg: AfdE7ckyJ8fSwc13m1ourHF9v3apdqgFOdXKBoaw8eeTxA1Ma03dnieb1JRGgbT0qbh
	b2HA0CqjyZZuxxSSGymt/UT2zB7hRP+sMSRJYFui+dTPmRYb4O4R/nXhANVYZdeSzVJvw/HuVaC
	RkKLNw+KJAiWyCMI7lExXA4IVqbgmb/Dy8CXt/dnEu8Z7glIJB1L+sGxpfXblTx+nK/UVKoZBN4
	Voo6629XXXz/Bi587LI9vykkW07awezSA/ezmNWspQwP/x6C23Wk0PqvSQLzxZ/Bsq0u/rdWGQE
	QyTwryaBhpvuYMDpyGqczObDySSjPNXPPlLBWVjGGN16H8Dw97Shc6/Z29s33R0g8+5Sg7b41aH
	k/ngf2qWfQhz67cLaUBbwbvHlPt5dT8mjVQTqrBsz
X-Received: by 2002:a17:90b:17c4:b0:381:5ab5:b667 with SMTP id 98e67ed59e1d1-38942493f10mr10429750a91.31.1783667316017;
        Fri, 10 Jul 2026 00:08:36 -0700 (PDT)
X-Received: by 2002:a17:90b:17c4:b0:381:5ab5:b667 with SMTP id 98e67ed59e1d1-38942493f10mr10429735a91.31.1783667315489;
        Fri, 10 Jul 2026 00:08:35 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm43082332eec.1.2026.07.10.00.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:08:35 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 1/2] rap: Add Channel Sounding parameter types and APIs
Date: Fri, 10 Jul 2026 12:38:19 +0530
Message-Id: <20260710070820.3793624-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710070820.3793624-1-naga.akella@oss.qualcomm.com>
References: <20260710070820.3793624-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2NyBTYWx0ZWRfXyAtChghE24fN
 0XU8sZLPuXWlt9jK/uXG0e4lzdj410OK1FWwFfv0B+p3INxcA0fWc85GUvzxWnrCBN4ulbdtu2z
 0/1G6K3HsPtJ4gVszb9bfK6n/JJVTJ7+lhny5ON09OenifQMs09kW24jc6T99Ve/D+YhHVfbqGr
 FPnsx75isc2bJoElrIRomp+uGlsN4IX64oJby0jImmmZnVf5EXTBbc4LGVUe/1C5Lk3B5IDeqLc
 S5UIeDYYQ6XBF6o9Ya+28lD1SiJKcXhrteJEhpnKsGFrZ6I5snZ/We6NPBuLFPcipIxDkSMg5Bx
 WxfhLQ97HsqxEFkfTJv8r3yxbqcMwymSG/ycjO1Vwu/G770IxjYmF2uLzT0lJZAXZpJmTHcH0nJ
 ycf3Cuf/3VsYr67lscdoftLEkykwLEQbS6EJH33R6y3l9vR1khy5b7Ld+PFvCKSCeUj9CPpQgZo
 3gYi+oUtLXOkrVRwpIw==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a509a75 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=GhXf9q-71yA2H53oXBwA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: gToG0jrG9IZ_QQzVPKITPMVk-tbwZt5o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2NyBTYWx0ZWRfXzvEOyFII4lGg
 Hj2BbcU2eSo+YF51ReTvGC1kgx5D0Mfp/h3e8gDMeQOWgTeJe4YY9FTIwEmKHp6DX381pVGE9Rm
 VIRLyutj3LRkXQoe+oxiivBTO8FnnDA=
X-Proofpoint-ORIG-GUID: gToG0jrG9IZ_QQzVPKITPMVk-tbwZt5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100067

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


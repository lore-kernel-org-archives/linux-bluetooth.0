Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162C35958
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126383; cv=none; b=JT3EBVrnmG+RwjLSdB5dyX5HsG1ez/PzwC14w47Mtiwi40RRkkjjWUavuQf51c87AmXb+bdiOncCudk7rMvGfjV47guW3pj2ItMBgcHG7WHk69JsnfC7sjjEoaAZHgow9pE//b4zGV7/e27Le67eeASOg2+YZYodjFuhxlBtocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126383; c=relaxed/simple;
	bh=KiBFcF4cw+PngfCpMyVF7roNsv5CggRpyUoGicScAHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GY2LNv+JhJ50ZQ/qMC4xOOb4qc7TQ1fZ7hBg3ESw5iJbvN0JPcKZCT8Vjw8/mV7XvSFxiKjoUtwjCF8gfzr+8fc29Sa/lJ68ehXPxV4nYnBinCXMyJ84csr7JwiOnBK+Ls/ZayYsZ+xXYzsJHgOQ0Ar/ak0PJVRDHrF6qwN8VDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iOt68SYB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W2qooy9r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iOt68SYB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W2qooy9r"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63271EFY1964872
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 Apr 2026 10:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ztpKIwaRyJU5Ow7Gp+d9Zg0w8nK/p99oDuPQVPnMkN8=; b=iOt68SYBM/Dq46Ji
	q5NgATBAkA+BzyEkootZ8QoS+LN9cDNZS0hsVhXEoF6pF3MADPRWVqWzS1onrwY4
	0Idtyko0zS0RemAhbNvk/RzDVkYPu6yvGKUBaOsBbmGoTl1fr1VsQb0k5M7fb5jA
	H49vl+8s5KotkJl8dBADen73N7oKSn3FcyhMz9XmJ+rtYhdix5FQMqEuBpLpY5Jw
	Zv1LGrvzTzCZFWEY8TUAa4YaN8M6CRfZ6mYxdTq29PWfrFndHzE5ahHbObjYhiVr
	KgjEuUC2ue22LqI2z6/Oyf/b/47MVRAwP2rr5kC0+lkFpgF8prZmdM+QJLKHxJyk
	1EOFpg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9b9h2nrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 10:39:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso729380a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 03:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775126379; x=1775731179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztpKIwaRyJU5Ow7Gp+d9Zg0w8nK/p99oDuPQVPnMkN8=;
        b=W2qooy9rJ+JlCFdoQgqJNKOh0ocOzyG8idTWubIqTdnUqZmNRzszOknmkC+OKhUMyJ
         HwV4+/d4Dfnyi7tDqDz5L4ZabnOV1sgVAWsdJt7jjDmTb3lMLhuCTz9T1YXTSkABUFmK
         rVdYdteIge7Z+BZXvH0OEt6F+RCvl9hG+K69ABRLCbJ5l+3r8CTwsg3YymkKXITZ71Me
         WcFTHa+X58eGGeeAsNIFMqF89u2v8IGg/wQwu9J97xPRhgjXp9b1Uox7gaMMmy70bSHx
         9zSqOu0hXVxcDomqwtnbcdifCxoD75cISgUhjGcHftSazeWhSw09/U2v2FW0MP7V70TJ
         ZkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775126379; x=1775731179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ztpKIwaRyJU5Ow7Gp+d9Zg0w8nK/p99oDuPQVPnMkN8=;
        b=Etztf8RGVCvzgDLBscoy1iSQsG/P+9li9WWIkghxqPGcQuBc5VBg45J2AXBbQinpJa
         pUQawBgpPdSiewRo2yavsWZ1WILf4ICB2dIUxowk6QyATUglBEEtbmApByjNn0cVYaff
         /vWD3/iV9WJXFQpOKuEYrbioh8E+CXXzjfvLTWwOL50KYQO+HugRZx6a+Ow/rOPH1o3y
         LE2AMExZeLLSjW7JWtxqJ7JnadAfYCkjU+K1AEt0cMTmn9TS6EWDKZ4OXQwAAnSV/nfV
         zHZRAFwZFPqIInEkU0YO+E++TPrN+gZnt7bNqX+GfHSuoWVxJb0bqcttydGDhWemJjZF
         pbDw==
X-Gm-Message-State: AOJu0Yy8baVBEnWjlC/j2qDMAVue8NxwJJELDKZuW2ft/q8GLSDnSOwu
	noGVgd+usY108+VtjqBTldM+SnZ7StJ1WpxQOgCy/8kIUd7BEVX9CBHNq3LQUgIyhD8DqCA2Kau
	RQYyzeSUQYUhwyAyl4AKNu4TaVkS0CFZyJBv8VeQwPWo9A9udqu6oU8PPdiSkyZuVzeE8729XgF
	+FXT0=
X-Gm-Gg: AeBDieundPOSvjSc3frTLXUPsDlMKE8xzWgWhx0hbVr0mbrUbOeebCxGpSGlhSKxYYK
	7zz9p9AqrkWqCMbAEqyUlZ5FXxlLZcZ8BnKI3umvpiQXvok1hVUbIDDHIYFFkBWDmcKX26RJkIW
	F6OUxUUtVs85u4wSLWPy8mGr1if6fZ02GVKkfcow0UTvJAUrfBVhQnQvYavtxfE6JNNOOgKEyw9
	Xw5snvclOaENbwOk5XalGyN4eczpkBEGMKe+8L6dszmwCOUjUtD5nNw/44uf0OgboOwT2dwwJYD
	mgZXTVyUJhzEDY9Hl7FevtQpUURwNhKUaFCgrkL2QpS0E0B3I6QkXj+s2aUf4//pcfknZqYXoV5
	VZGQTs5potPSQgmbT9E/TuFJViSn8LeAQ68DXnaT6bGSLtllU+EY=
X-Received: by 2002:a17:90b:224e:b0:35d:a4c0:a0ac with SMTP id 98e67ed59e1d1-35dc6ea7a4emr6662693a91.3.1775126378638;
        Thu, 02 Apr 2026 03:39:38 -0700 (PDT)
X-Received: by 2002:a17:90b:224e:b0:35d:a4c0:a0ac with SMTP id 98e67ed59e1d1-35dc6ea7a4emr6662649a91.3.1775126377867;
        Thu, 02 Apr 2026 03:39:37 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe624756sm9993420a91.5.2026.04.02.03.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 03:39:37 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 3/3] profiles: ranging: Add HCI LE Event Handling in  Reflector role
Date: Thu,  2 Apr 2026 16:09:00 +0530
Message-Id: <20260402103900.310778-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402103900.310778-1-naga.akella@oss.qualcomm.com>
References: <20260402103900.310778-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqLrRTXh c=1 sm=1 tr=0 ts=69ce476b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=9nge0j2a8-S9m91UDHUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: PhfPF1PT4mwX46vbM4nNh-RPaGBosyjC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NSBTYWx0ZWRfX/SP4HZyqcwCN
 M7US7J5MrOCEZTUrAl8dqD+FW3e0VdiaOGNnsnAwhBdjiP2RIg3OrgInEXjlPWeBI0HW80jCq1K
 VVA5W/7Ka+YgPepdezdwnKqd+kXgbO8j1rV+owxucoO0DP2Dn08vvKyN3O33h/K7Hsj9Mx7Br36
 VhZyL/D4pY4x5Lidy+1LzFuN4gmtes239JUvlajbE+bU7jBZOgD9s6vnFx6GjeQtpGqCfuv52RF
 navG7ELjEeS7tWra/9rFijvcEASfli1CVBAgFZgLWa8JbR0IGn02A57AdKziFdFGqRe0aO7Xx0+
 NHBl9Y40TzQa3SGp5NNjME6pj1cxHWqqS+C/j/JnFpCQXt3FzPmE3h8iqQ7ha7Aom9l30EW09qk
 aMRppthE+8Eq14CC71f0D6TEmgppNXOZpq54GxKIWmAgB/rUwc4OvE+4frc2qKheVbJTZ3xIwkx
 zAwN01qTxgTOv8qaOAg==
X-Proofpoint-GUID: PhfPF1PT4mwX46vbM4nNh-RPaGBosyjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020095

Open RAW HCI Channel for CS Event Handling
Parse the following HCI LE CS Events in reflector role
and route the events to RAP Profile.
 1. HCI_EVT_LE_CS_READ_RMT_SUPP_CAP_COMPLETE
 2. HCI_EVT_LE_CS_CONFIG_COMPLETE
 3. HCI_EVT_LE_CS_SECURITY_ENABLE_COMPLETE
 4. HCI_EVT_LE_CS_PROCEDURE_ENABLE_COMPLETE
 5. HCI_EVT_LE_CS_SUBEVENT_RESULT
 6. HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE
Send HCI_OP_LE_CS_SET_DEFAULT_SETTINGS to the controller
with default settings selected by the user.
---
 Makefile.plugins           |    3 +-
 profiles/ranging/rap.c     |   27 +
 profiles/ranging/rap_hci.c | 1296 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1325 insertions(+), 1 deletion(-)
 create mode 100644 profiles/ranging/rap_hci.c

diff --git a/Makefile.plugins b/Makefile.plugins
index c9efadb45..ac667beda 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -89,7 +89,8 @@ builtin_modules += battery
 builtin_sources += profiles/battery/battery.c
 
 builtin_modules += rap
-builtin_sources += profiles/ranging/rap.c
+builtin_sources += profiles/ranging/rap.c \
+		profiles/ranging/rap_hci.c
 
 if SIXAXIS
 builtin_modules += sixaxis
diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index f03454c72..1b144b471 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -34,12 +34,17 @@
 #include "src/shared/rap.h"
 #include "attrib/att.h"
 #include "src/log.h"
+#include "src/btd.h"
 
+#define USE_BT_HCI_RAW_CHANNEL	1
 struct rap_data {
 	struct btd_device *device;
 	struct btd_service *service;
 	struct bt_rap *rap;
 	unsigned int ready_id;
+#if USE_BT_HCI_RAW_CHANNEL
+	struct bt_hci *hci;
+#endif
 };
 
 static struct queue *sessions;
@@ -95,6 +100,12 @@ static void rap_data_free(struct rap_data *data)
 	}
 
 	bt_rap_ready_unregister(data->rap, data->ready_id);
+#if USE_BT_HCI_RAW_CHANNEL
+	if (data->hci) {
+		bt_rap_hci_sm_cleanup();
+		bt_hci_unref(data->hci);
+	}
+#endif
 	bt_rap_unref(data->rap);
 	free(data);
 }
@@ -194,6 +205,22 @@ static int rap_probe(struct btd_service *service)
 		free(data);
 		return -EINVAL;
 	}
+#if USE_BT_HCI_RAW_CHANNEL
+	int16_t hci_index = btd_adapter_get_index(adapter);
+
+	data->hci = bt_hci_new_raw_device(hci_index);
+	if (bt_rap_attach_hci(data->rap, data->hci)) {
+		DBG("HCI raw channel initialized, hci%d", hci_index);
+		bt_rap_hci_set_le_bcs_options(
+					btd_opts.defaults.bcs.role,
+					btd_opts.defaults.bcs.cs_sync_ant_sel,
+					btd_opts.defaults.bcs.max_tx_power);
+	} else {
+		error("HCI raw channel not available (may be in use)");
+	}
+#else /* USE_BT_HCI_RAW_CHANNEL */
+	DBG("MGMT Events");
+#endif /* USE_BT_HCI_RAW_CHANNEL */
 
 	rap_data_add(data);
 
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
new file mode 100644
index 000000000..5d1aba8f2
--- /dev/null
+++ b/profiles/ranging/rap_hci.c
@@ -0,0 +1,1296 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <unistd.h>
+#include <string.h>
+#include <endian.h>
+
+#include "lib/bluetooth/bluetooth.h"
+#include "src/shared/util.h"
+#include "src/shared/rap.h"
+#include "src/shared/hci.h"
+#include "src/log.h"
+#include "monitor/bt.h"
+
+#ifndef MIN
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
+/*  CS State Definitions */
+enum cs_state_t {
+	CS_INIT,
+	CS_STOPPED,
+	CS_STARTED,
+	CS_WAIT_CONFIG_CMPLT,
+	CS_WAIT_SEC_CMPLT,
+	CS_WAIT_PROC_CMPLT,
+	CS_HOLD,
+	CS_UNSPECIFIED
+};
+
+const char *state_names[] = {
+	"CS_INIT",
+	"CS_STOPPED",
+	"CS_STARTED",
+	"CS_WAIT_CONFIG_CMPLT",
+	"CS_WAIT_SEC_CMPLT",
+	"CS_WAIT_PROC_CMPLT",
+	"CS_HOLD",
+	"CS_UNSPECIFIED"
+};
+
+/* Callback Function Type */
+typedef void (*cs_callback_t)(uint16_t length,
+			const void *param, void *user_data);
+
+/* State Machine Context */
+struct cs_state_machine_t {
+	enum cs_state_t current_state;
+	enum cs_state_t old_state;
+	struct bt_hci *hci;
+	struct bt_rap *rap;
+	unsigned int event_id;
+	bool initiator;
+	bool procedure_active;
+};
+
+struct cs_callback_map_t {
+	enum cs_state_t state;
+	cs_callback_t callback;
+};
+
+struct cs_callback_map_t cs_callback_map[] = {
+	{ CS_WAIT_CONFIG_CMPLT, bt_rap_hci_cs_config_complete_callback },
+	{ CS_WAIT_SEC_CMPLT, bt_rap_hci_cs_sec_enable_complete_callback },
+	{ CS_WAIT_PROC_CMPLT, bt_rap_hci_cs_procedure_enable_complete_callback }
+};
+
+#define CS_CALLBACK_MAP_SIZE ARRAY_SIZE(cs_callback_map)
+
+struct bt_rap_hci_cs_options cs_opt;
+struct cs_state_machine_t *sm;
+
+/*  State Machine Functions */
+void cs_state_machine_init(struct cs_state_machine_t *sm, struct bt_rap *rap,
+				struct bt_hci *hci)
+{
+	if (!sm)
+		return;
+
+	memset(sm, 0, sizeof(struct cs_state_machine_t));
+	sm->current_state = CS_UNSPECIFIED;
+	sm->rap = rap;
+	sm->hci = hci;
+	sm->initiator = false;
+	sm->procedure_active = false;
+}
+
+void bt_rap_hci_sm_cleanup(void)
+{
+	if (!sm)
+		return;
+
+	if (sm->event_id)
+		bt_hci_unregister(sm->hci, sm->event_id);
+
+	sm->current_state = CS_UNSPECIFIED;
+	sm->rap = NULL;
+	sm->hci = NULL;
+	sm->procedure_active = false;
+
+	free(sm);
+}
+
+void bt_rap_hci_set_le_bcs_options(uint8_t role, uint8_t cs_sync_ant_sel,
+					int8_t max_tx_power)
+{
+	cs_opt.role = role;
+	cs_opt.cs_sync_ant_sel = cs_sync_ant_sel;
+	cs_opt.max_tx_power = max_tx_power;
+}
+
+/* State Transition Logic */
+void cs_set_state(struct cs_state_machine_t *sm, enum cs_state_t new_state)
+{
+	if (!sm)
+		return;
+
+	if (sm->current_state == new_state)
+		return;
+
+	/* Validate state values before array access */
+	if (sm->current_state > CS_UNSPECIFIED || new_state > CS_UNSPECIFIED) {
+		DBG("[ERROR] Invalid state transition attempted\n");
+		return;
+	}
+
+	DBG("[STATE] Transition: %s → %s\n",
+		state_names[sm->current_state],
+		state_names[new_state]);
+
+	sm->old_state = sm->current_state;
+	sm->current_state = new_state;
+}
+
+enum cs_state_t cs_get_current_state(struct cs_state_machine_t *sm)
+{
+	return sm ? sm->current_state : CS_UNSPECIFIED;
+}
+
+bool cs_is_procedure_active(const struct cs_state_machine_t *sm)
+{
+	return sm ? sm->procedure_active : false;
+}
+
+/* HCI Event Callbacks */
+static void rap_def_settings_done_cb(const void *data, uint8_t size,
+					void *user_data)
+{
+	struct bt_hci_rsp_le_cs_set_def_settings *rp;
+	struct cs_state_machine_t *sm = (struct cs_state_machine_t *)user_data;
+
+	if (!sm || !data ||
+		size < sizeof(struct bt_hci_rsp_le_cs_set_def_settings))
+		return;
+
+	DBG("[EVENT] CS default Setting Complete (size=0x%02X)\n", size);
+
+	rp = (struct bt_hci_rsp_le_cs_set_def_settings *)data;
+
+	if (cs_get_current_state(sm) != CS_INIT) {
+		DBG("Event received in Wrong State!! Expected : CS_INIT");
+		return;
+	}
+
+	if (rp->status == 0) {
+		/* Success - proceed to configuration */
+		cs_set_state(sm, CS_WAIT_CONFIG_CMPLT);
+
+		/* Reflector role */
+		DBG("Waiting for CS Config Completed event...\n");
+		/* TODO: Initiator role - Send CS Config complete cmd */
+	} else {
+		/* Error - transition to stopped */
+		DBG("[ERROR]CS Set default setting failed with status 0x%02X\n",
+		rp->status);
+		cs_set_state(sm, CS_STOPPED);
+	}
+}
+
+void rap_send_hci_def_settings_command(struct cs_state_machine_t *sm,
+		struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *ev)
+{
+	struct bt_hci_cmd_le_cs_set_def_settings cp;
+	unsigned int status;
+
+	memset(&cp, 0, sizeof(cp));
+
+	if (ev->handle)
+		cp.handle = ev->handle;
+	cp.role_enable = cs_opt.role;
+	cp.cs_sync_antenna_selection = cs_opt.cs_sync_ant_sel;
+	cp.max_tx_power = cs_opt.max_tx_power;
+
+	if (!sm || !sm->hci) {
+		DBG("[ERR] Set Def Settings: sm or hci is null");
+		return;
+	}
+
+	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_SET_DEF_SETTINGS,
+				&cp, sizeof(cp), rap_def_settings_done_cb,
+				sm, NULL);
+
+	DBG("sending set default settings case, status : %d", status);
+	if (!status)
+		DBG("Failed to send default settings cmd");
+}
+
+static void rap_rd_rmt_supp_cap_cmplt_evt(const uint8_t *data, uint8_t size,
+					   void *user_data)
+{
+	struct cs_state_machine_t *sm = (struct cs_state_machine_t *)user_data;
+	struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete ev;
+	struct iovec iov;
+	uint8_t status;
+	uint16_t handle;
+
+	if (!sm || !data ||
+		size < sizeof(struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete))
+		return;
+
+	/* Initialize iovec with the event data */
+	iov.iov_base = (void *)data;
+	iov.iov_len = size;
+
+	/* Parse all fields in order using iovec */
+	if (!util_iov_pull_u8(&iov, &status)) {
+		DBG("[ERROR] Failed to parse Status\n");
+		return;
+	}
+
+	if (!util_iov_pull_le16(&iov, &handle)) {
+		DBG("[ERROR] Failed to parse Connection_Handle\n");
+		return;
+	}
+
+	ev.status = status;
+	ev.handle = handle;
+
+	DBG("[EVENT] Remote Capabilities Complete\n");
+	DBG("status=0x%02X, handle=0x%04X\n", ev.status, ev.handle);
+
+	if (ev.status == 0) {
+		uint8_t u8_val;
+		uint16_t u16_val;
+
+		/* Parse remaining fields only if status is success */
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.num_config_supported = u8_val;
+
+		if (!util_iov_pull_le16(&iov, &u16_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.max_consecutive_procedures_supported = u16_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.num_antennas_supported = u8_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.max_antenna_paths_supported = u8_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.roles_supported = u8_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.modes_supported = u8_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.rtt_capability = u8_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.rtt_aa_only_n = u8_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.rtt_sounding_n = u8_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.rtt_random_payload_n = u8_val;
+
+		if (!util_iov_pull_le16(&iov, &u16_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.nadm_sounding_capability = u16_val;
+
+		if (!util_iov_pull_le16(&iov, &u16_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.nadm_random_capability = u16_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.cs_sync_phys_supported = u8_val;
+
+		if (!util_iov_pull_le16(&iov, &u16_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.subfeatures_supported = u16_val;
+
+		if (!util_iov_pull_le16(&iov, &u16_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.t_ip1_times_supported = u16_val;
+
+		if (!util_iov_pull_le16(&iov, &u16_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.t_ip2_times_supported = u16_val;
+
+		if (!util_iov_pull_le16(&iov, &u16_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.t_fcs_times_supported = u16_val;
+
+		if (!util_iov_pull_le16(&iov, &u16_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.t_pm_times_supported = u16_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+		ev.t_sw_time_supported = u8_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+
+		DBG("[EVENT] Remote Capabilities: num_config=%u, ",
+			ev.num_config_supported);
+		DBG("max_consecutive_proc=%u, num_antennas=%u, ",
+			ev.max_consecutive_procedures_supported,
+			ev.num_antennas_supported);
+		DBG("max_antenna_paths=%u, roles=0x%02X, modes=0x%02X\n",
+			ev.max_antenna_paths_supported,
+			ev.roles_supported,
+			ev.modes_supported);
+
+		rap_send_hci_def_settings_command(sm, &ev);
+		cs_set_state(sm, CS_INIT);
+	} else {
+		/* Error - transition to stopped */
+		DBG("[ERROR] Remote capabilities failed with status 0x%02X\n",
+			ev.status);
+		cs_set_state(sm, CS_STOPPED);
+	}
+}
+
+static void rap_cs_config_cmplt_evt(const uint8_t *data, uint8_t size,
+				    void *user_data)
+{
+	struct cs_state_machine_t *sm = (struct cs_state_machine_t *)user_data;
+	struct rap_ev_cs_config_cmplt rap_ev;
+	struct iovec iov;
+	uint8_t status;
+	uint16_t handle;
+	uint8_t i;
+
+	if (!sm || !data ||
+		size < sizeof(struct bt_hci_evt_le_cs_config_complete))
+		return;
+
+	/* Initialize iovec with the event data */
+	iov.iov_base = (void *)data;
+	iov.iov_len = size;
+
+	DBG("[EVENT] Configuration Complete (size=0x%02X)\n", size);
+
+	/* State Check */
+	if (cs_get_current_state(sm) != CS_WAIT_CONFIG_CMPLT) {
+		DBG("Event received in Wrong State!! ");
+		DBG("Expected : CS_WAIT_CONFIG_CMPLT");
+		return;
+	}
+
+	/* Parse all fields in order using iovec */
+	if (!util_iov_pull_u8(&iov, &status)) {
+		DBG("[ERROR] Failed to parse Status\n");
+		return;
+	}
+
+	if (!util_iov_pull_le16(&iov, &handle)) {
+		DBG("[ERROR] Failed to parse Connection_Handle\n");
+		return;
+	}
+
+	rap_ev.status = status;
+	rap_ev.conn_hdl = cpu_to_le16(handle);
+
+	if (rap_ev.status == 0) {
+		/* Parse remaining fields only if status is success */
+		if (!util_iov_pull_u8(&iov, &rap_ev.config_id) ||
+			!util_iov_pull_u8(&iov, &rap_ev.action) ||
+			!util_iov_pull_u8(&iov, &rap_ev.main_mode_type) ||
+			!util_iov_pull_u8(&iov, &rap_ev.sub_mode_type) ||
+			!util_iov_pull_u8(&iov, &rap_ev.min_main_mode_steps) ||
+			!util_iov_pull_u8(&iov, &rap_ev.max_main_mode_steps) ||
+			!util_iov_pull_u8(&iov, &rap_ev.main_mode_rep) ||
+			!util_iov_pull_u8(&iov, &rap_ev.mode_0_steps) ||
+			!util_iov_pull_u8(&iov, &rap_ev.role) ||
+			!util_iov_pull_u8(&iov, &rap_ev.rtt_type) ||
+			!util_iov_pull_u8(&iov, &rap_ev.cs_sync_phy)) {
+			DBG("[ERROR] Failed to parse config fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+
+		/* Store rtt_type in global options */
+		cs_opt.rtt_type = rap_ev.rtt_type;
+
+		/* Parse Channel_Map (10 bytes) */
+		for (i = 0; i < 10; i++) {
+			if (!util_iov_pull_u8(&iov, &rap_ev.channel_map[i])) {
+				DBG("[ERROR] Failed to parse Channel_Map[%u]\n",
+					i);
+				cs_set_state(sm, CS_STOPPED);
+				return;
+			}
+		}
+
+		/* Parse remaining fields */
+		if (!util_iov_pull_u8(&iov, &rap_ev.channel_map_rep) ||
+			!util_iov_pull_u8(&iov, &rap_ev.channel_sel_type) ||
+			!util_iov_pull_u8(&iov, &rap_ev.ch3c_shape) ||
+			!util_iov_pull_u8(&iov, &rap_ev.ch3c_jump) ||
+			!util_iov_pull_u8(&iov, &rap_ev.reserved) ||
+			!util_iov_pull_u8(&iov, &rap_ev.t_ip1_time) ||
+			!util_iov_pull_u8(&iov, &rap_ev.t_ip2_time) ||
+			!util_iov_pull_u8(&iov, &rap_ev.t_fcs_time) ||
+			!util_iov_pull_u8(&iov, &rap_ev.t_pm_time)) {
+			DBG("[ERROR] Failed to parse timing fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			return;
+		}
+
+		DBG("[EVENT] Config Complete: config_id=%u, action=%u, ",
+			rap_ev.config_id, rap_ev.action);
+		DBG("main_mode=%u, sub_mode=%u, role=%u, rtt_type=%u\n",
+			rap_ev.main_mode_type, rap_ev.sub_mode_type,
+			rap_ev.role, rap_ev.rtt_type);
+
+		/* Success - proceed to Security enable complete */
+		cs_set_state(sm, CS_WAIT_SEC_CMPLT);
+
+		/* Reflector role */
+		DBG("Waiting for security enable event...\n");
+		/* TODO: Initiator role - Send CS Security enable cmd */
+	} else {
+		/* Error - transition to stopped */
+		DBG("[ERROR] Configuration failed with status 0x%02X\n",
+			rap_ev.status);
+		cs_set_state(sm, CS_STOPPED);
+	}
+
+	/* Send Callback to RAP Profile */
+	for (size_t i = 0; i < CS_CALLBACK_MAP_SIZE; i++) {
+		if (cs_callback_map[i].state == sm->old_state) {
+			cs_callback_map[i].callback(size, &rap_ev, sm->rap);
+			return;
+		}
+	}
+}
+
+static void rap_cs_sec_enable_cmplt_evt(const uint8_t *data, uint8_t size,
+					 void *user_data)
+{
+	struct cs_state_machine_t *sm = (struct cs_state_machine_t *)user_data;
+	struct rap_ev_cs_sec_enable_cmplt rap_ev;
+	struct iovec iov;
+	uint8_t status;
+	uint16_t handle;
+
+	if (!sm || !data ||
+		size < sizeof(struct bt_hci_evt_le_cs_sec_enable_complete))
+		return;
+
+	/* Initialize iovec with the event data */
+	iov.iov_base = (void *)data;
+	iov.iov_len = size;
+
+	DBG("[EVENT] Security Enable Complete (size=0x%02X)\n", size);
+
+	/* State Check */
+	if (cs_get_current_state(sm) != CS_WAIT_SEC_CMPLT) {
+		DBG("Event received in Wrong State!! ");
+		DBG("Expected : CS_WAIT_SEC_CMPLT");
+		return;
+	}
+
+	/* Parse all fields in order using iovec */
+	if (!util_iov_pull_u8(&iov, &status)) {
+		DBG("[ERROR] Failed to parse Status\n");
+		return;
+	}
+
+	if (!util_iov_pull_le16(&iov, &handle)) {
+		DBG("[ERROR] Failed to parse Connection_Handle\n");
+		return;
+	}
+
+	rap_ev.status = status;
+	rap_ev.conn_hdl = cpu_to_le16(handle);
+
+	DBG("[EVENT] Security Enable: status=0x%02X, handle=0x%04X\n",
+		rap_ev.status, handle);
+
+	if (rap_ev.status == 0) {
+		/* Success - proceed to configuration */
+		cs_set_state(sm, CS_WAIT_PROC_CMPLT);
+
+		/* Reflector role */
+		DBG("Waiting for CS Proc complete event...\n");
+		/* TODO: Initiator - Send CS Proc Set Parameter and enable */
+	} else {
+		/* Error - transition to stopped */
+		DBG("[ERROR] Security enable failed with status 0x%02X\n",
+			rap_ev.status);
+		cs_set_state(sm, CS_STOPPED);
+	}
+
+	/* Send Callback to RAP Profile */
+	for (size_t i = 0; i < CS_CALLBACK_MAP_SIZE; i++) {
+		if (cs_callback_map[i].state == sm->old_state) {
+			cs_callback_map[i].callback(size, &rap_ev, sm->rap);
+			return;
+		}
+	}
+}
+
+static void rap_cs_proc_enable_cmplt_evt(const uint8_t *data, uint8_t size,
+					  void *user_data)
+{
+	struct cs_state_machine_t *sm = (struct cs_state_machine_t *)user_data;
+	struct rap_ev_cs_proc_enable_cmplt rap_ev;
+	struct iovec iov;
+	uint8_t status;
+	uint16_t handle;
+	uint8_t i;
+
+	if (!sm || !data ||
+		size < sizeof(struct bt_hci_evt_le_cs_proc_enable_complete))
+		return;
+
+	/* Initialize iovec with the event data */
+	iov.iov_base = (void *)data;
+	iov.iov_len = size;
+
+	DBG("[EVENT] Procedure Enable Complete (size=0x%02X)\n", size);
+
+	/* State Check */
+	if (cs_get_current_state(sm) != CS_WAIT_PROC_CMPLT) {
+		DBG("Event received in Wrong State!! ");
+		DBG("Expected : CS_WAIT_PROC_CMPLT");
+		return;
+	}
+
+	/* Parse all fields in order using iovec */
+	if (!util_iov_pull_u8(&iov, &status)) {
+		DBG("[ERROR] Failed to parse Status\n");
+		return;
+	}
+
+	if (!util_iov_pull_le16(&iov, &handle)) {
+		DBG("[ERROR] Failed to parse Connection_Handle\n");
+		return;
+	}
+
+	rap_ev.status = status;
+	rap_ev.conn_hdl = cpu_to_le16(handle);
+
+	if (rap_ev.status == 0) {
+		uint8_t u8_val;
+		uint16_t u16_val;
+
+		/* Parse remaining fields only if status is success */
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse ");
+			DBG("procedure enable fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			sm->procedure_active = false;
+			return;
+		}
+		rap_ev.config_id = u8_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse ");
+			DBG("procedure enable fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			sm->procedure_active = false;
+			return;
+		}
+		rap_ev.state = u8_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse ");
+			DBG("procedure enable fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			sm->procedure_active = false;
+			return;
+		}
+		rap_ev.tone_ant_config_sel = u8_val;
+
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse ");
+			DBG("procedure enable fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			sm->procedure_active = false;
+			return;
+		}
+
+		rap_ev.sel_tx_pwr = u8_val;
+
+		/* Parse Subevent_Len (3 bytes) */
+		for (i = 0; i < 3; i++) {
+			if (!util_iov_pull_u8(&iov, &u8_val)) {
+				DBG("[ERROR]Failed to parse Subevent_Len[%u]\n",
+					i);
+				cs_set_state(sm, CS_STOPPED);
+				sm->procedure_active = false;
+				return;
+			}
+			rap_ev.sub_evt_len[i] = u8_val;
+		}
+
+		/* Parse remaining fields */
+		if (!util_iov_pull_u8(&iov, &u8_val)) {
+			DBG("[ERROR] Failed to parse ");
+			DBG("procedure timing fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			sm->procedure_active = false;
+			return;
+		}
+		rap_ev.sub_evts_per_evt = u8_val;
+
+		if (!util_iov_pull_le16(&iov, &u16_val)) {
+			DBG("[ERROR] Failed to parse ");
+			DBG("procedure timing fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			sm->procedure_active = false;
+			return;
+		}
+		rap_ev.sub_evt_intrvl = u16_val;
+
+		if (!util_iov_pull_le16(&iov, &u16_val)) {
+			DBG("[ERROR] Failed to parse ");
+			DBG("procedure timing fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			sm->procedure_active = false;
+			return;
+		}
+		rap_ev.evt_intrvl = u16_val;
+
+		if (!util_iov_pull_le16(&iov, &u16_val)) {
+			DBG("[ERROR] Failed to parse ");
+			DBG("procedure timing fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			sm->procedure_active = false;
+			return;
+		}
+		rap_ev.proc_intrvl = u16_val;
+
+		if (!util_iov_pull_le16(&iov, &u16_val)) {
+			DBG("[ERROR] Failed to parse ");
+			DBG("procedure timing fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			sm->procedure_active = false;
+			return;
+		}
+		rap_ev.proc_counter = u16_val;
+
+		if (!util_iov_pull_le16(&iov, &u16_val)) {
+			DBG("[ERROR] Failed to parse ");
+			DBG("procedure timing fields\n");
+			cs_set_state(sm, CS_STOPPED);
+			sm->procedure_active = false;
+			return;
+		}
+
+		DBG("[EVENT] Procedure Enable: config_id=%u, state=%u, ",
+			rap_ev.config_id, rap_ev.state);
+		DBG("sub_evts_per_evt=%u, evt_intrvl=%u, proc_intrvl=%u\n",
+			rap_ev.sub_evts_per_evt, rap_ev.evt_intrvl,
+			rap_ev.proc_intrvl);
+
+		/* Success - procedure started */
+		cs_set_state(sm, CS_STARTED);
+		sm->procedure_active = true;
+	} else {
+		/* Error - transition to stopped */
+		DBG("[ERROR] Procedure enable failed with status 0x%02X\n",
+			rap_ev.status);
+		cs_set_state(sm, CS_STOPPED);
+		sm->procedure_active = false;
+	}
+
+	/* Send Callback to RAP Profile */
+	for (size_t i = 0; i < CS_CALLBACK_MAP_SIZE; i++) {
+		if (cs_callback_map[i].state == sm->old_state) {
+			cs_callback_map[i].callback(size, &rap_ev, sm->rap);
+			return;
+		}
+	}
+}
+
+static void parse_i_q_sample(struct iovec *iov, int16_t *i_sample,
+				int16_t *q_sample)
+{
+	uint8_t bytes[3];
+	uint32_t buffer;
+	uint32_t i12;
+	uint32_t q12;
+
+	/* Pull 3 bytes from iovec */
+	if (!util_iov_pull_u8(iov, &bytes[0]) ||
+		!util_iov_pull_u8(iov, &bytes[1]) ||
+		!util_iov_pull_u8(iov, &bytes[2])) {
+		*i_sample = 0;
+		*q_sample = 0;
+		return;
+	}
+
+	/* Reconstruct 24-bit buffer from 3 bytes */
+	buffer = (uint32_t)bytes[0] | ((uint32_t)bytes[1] << 8) |
+				((uint32_t)bytes[2] << 16);
+	i12 =  buffer        & 0x0FFFU;   /* bits 0..11 */
+	q12 = (buffer >> 12) & 0x0FFFU;   /* bits 12..23 */
+
+	/* Sign-extend 12-bit values to 16-bit */
+	*i_sample = (int16_t)((int32_t)(i12 << 20) >> 20);
+	*q_sample = (int16_t)((int32_t)(q12 << 20) >> 20);
+}
+
+/* Parse CS Mode 0 step data */
+static void parse_mode_zero_data(struct iovec *iov,
+				 struct cs_mode_zero_data *mode_data,
+				 uint8_t cs_role)
+{
+	uint32_t freq_offset;
+
+	if (iov->iov_len < 3) {
+		DBG("Mode 0: too short (<3)");
+		return;
+	}
+
+	util_iov_pull_u8(iov, &mode_data->packet_quality);
+	util_iov_pull_u8(iov, &mode_data->packet_rssi_dbm);
+	util_iov_pull_u8(iov, &mode_data->packet_ant);
+	DBG("CS Step mode 0");
+
+	if (cs_role == CS_INITIATOR && iov->iov_len >= 4) {
+		util_iov_pull_le32(iov, &freq_offset);
+		mode_data->init_measured_freq_offset = freq_offset;
+	}
+}
+
+/* Parse CS Mode 1 step data */
+static void parse_mode_one_data(struct iovec *iov,
+				struct cs_mode_one_data *mode_data,
+				uint8_t cs_role, uint8_t cs_rtt_type)
+{
+	uint16_t time_val;
+
+	if (iov->iov_len < 4) {
+		DBG("Mode 1: too short (<4)");
+		return;
+	}
+
+	DBG("CS Step mode 1");
+	util_iov_pull_u8(iov, &mode_data->packet_quality);
+	util_iov_pull_u8(iov, &mode_data->packet_rssi_dbm);
+	util_iov_pull_u8(iov, &mode_data->packet_ant);
+	util_iov_pull_u8(iov, &mode_data->packet_nadm);
+
+	if (iov->iov_len >= 2) {
+		util_iov_pull_le16(iov, &time_val);
+		if (cs_role == CS_REFLECTOR)
+			mode_data->tod_toa_refl = time_val;
+		else
+			mode_data->toa_tod_init = time_val;
+	}
+
+	if ((cs_rtt_type == 0x01 || cs_rtt_type == 0x02) &&
+		iov->iov_len >= 6) {
+		int16_t i_val, q_val;
+
+		parse_i_q_sample(iov, &i_val, &q_val);
+		mode_data->packet_pct1.i_sample = i_val;
+		mode_data->packet_pct1.q_sample = q_val;
+
+		parse_i_q_sample(iov, &i_val, &q_val);
+		mode_data->packet_pct2.i_sample = i_val;
+		mode_data->packet_pct2.q_sample = q_val;
+	}
+}
+
+/* Parse CS Mode 2 step data */
+static void parse_mode_two_data(struct iovec *iov,
+				struct cs_mode_two_data *mode_data,
+				uint8_t max_paths)
+{
+	uint8_t k;
+
+	if (iov->iov_len < 1) {
+		DBG("Mode 2: too short (<1)");
+		return;
+	}
+
+	util_iov_pull_u8(iov, &mode_data->ant_perm_index);
+	DBG("CS Step mode 2, max paths : %d", max_paths);
+
+	for (k = 0; k < max_paths; k++) {
+		int16_t i_val, q_val;
+
+		if (iov->iov_len < 4) {
+			DBG("Mode 2: insufficient PCT for path %u (rem=%zu)",
+				k, iov->iov_len);
+			break;
+		}
+		parse_i_q_sample(iov, &i_val, &q_val);
+		mode_data->tone_pct[k].i_sample = i_val;
+		mode_data->tone_pct[k].q_sample = q_val;
+
+		util_iov_pull_u8(iov, &mode_data->tone_quality_indicator[k]);
+		DBG("tone_quality_indicator : %d",
+			mode_data->tone_quality_indicator[k]);
+		DBG("[i, q] : %d, %d",
+			mode_data->tone_pct[k].i_sample,
+			mode_data->tone_pct[k].q_sample);
+	}
+}
+
+/* Parse CS Mode 3 step data */
+static void parse_mode_three_data(struct iovec *iov,
+				struct cs_mode_three_data *mode_data,
+				uint8_t cs_role, uint8_t cs_rtt_type,
+				uint8_t max_paths)
+{
+	uint8_t k;
+	struct cs_mode_one_data *mode_one = &mode_data->mode_one_data;
+	struct cs_mode_two_data *mode_two = &mode_data->mode_two_data;
+
+	if (iov->iov_len < 4) {
+		DBG("Mode 3: mode1 too short (<4)");
+		return;
+	}
+
+	DBG("CS Step mode 3");
+
+	/* Parse Mode 1 portion */
+	parse_mode_one_data(iov, mode_one, cs_role, cs_rtt_type);
+
+	/* Parse Mode 2 portion */
+	if (iov->iov_len >= 1) {
+		util_iov_pull_u8(iov, &mode_two->ant_perm_index);
+		for (k = 0; k < max_paths; k++) {
+			int16_t i_val, q_val;
+
+			if (iov->iov_len < 4)
+				break;
+			parse_i_q_sample(iov, &i_val, &q_val);
+			mode_two->tone_pct[k].i_sample = i_val;
+			mode_two->tone_pct[k].q_sample = q_val;
+
+			util_iov_pull_u8(iov,
+					 &mode_two->tone_quality_indicator[k]);
+		}
+	}
+}
+
+/* Parse a single CS step */
+static void parse_cs_step(struct iovec *iov, struct cs_step_data *step,
+			uint8_t cs_role, uint8_t cs_rtt_type,
+			uint8_t max_paths)
+{
+	uint8_t mode;
+	uint8_t chnl;
+	uint8_t length;
+
+	/* Check if we have enough data for the 3-byte header */
+	if (iov->iov_len < 3) {
+		DBG("Truncated header for step");
+		return;
+	}
+
+	/* Read mode, channel, and length (3-byte header) */
+	if (!util_iov_pull_u8(iov, &mode) ||
+		!util_iov_pull_u8(iov, &chnl) ||
+		!util_iov_pull_u8(iov, &length)) {
+		DBG("Failed to read header for step");
+		return;
+	}
+
+	DBG("event->step_data_len : %d", length);
+
+	step->step_mode = mode;
+	step->step_chnl = chnl;
+	step->step_data_length = length;
+
+	DBG("Step: mode=%u chnl=%u data_len=%u", mode, chnl, length);
+
+	if (iov->iov_len < length) {
+		DBG("Truncated payload for step (need %u, have %zu)",
+			length, iov->iov_len);
+		return;
+	}
+
+	/* Parse step data based on mode */
+	switch (mode) {
+	case CS_MODE_ZERO:
+		parse_mode_zero_data(iov, &step->step_mode_data.mode_zero_data,
+					cs_role);
+		break;
+	case CS_MODE_ONE:
+		parse_mode_one_data(iov, &step->step_mode_data.mode_one_data,
+					cs_role, cs_rtt_type);
+		break;
+	case CS_MODE_TWO:
+		parse_mode_two_data(iov, &step->step_mode_data.mode_two_data,
+					max_paths);
+		break;
+	case CS_MODE_THREE:
+		parse_mode_three_data(iov,
+					&step->step_mode_data.mode_three_data,
+					cs_role, cs_rtt_type, max_paths);
+		break;
+	default:
+		DBG("Unknown step mode %d", mode);
+		/* Skip the entire step data */
+		util_iov_pull(iov, length);
+		break;
+	}
+}
+
+static void rap_cs_subevt_result_evt(const uint8_t *data, uint8_t size,
+				void *user_data)
+{
+	struct cs_state_machine_t *sm = (struct cs_state_machine_t *)user_data;
+	struct rap_ev_cs_subevent_result *rap_ev;
+	struct iovec iov;
+	uint8_t cs_role;
+	uint8_t cs_rtt_type;
+	uint8_t max_paths;
+	uint8_t steps;
+	size_t send_len = 0;
+	uint16_t handle;
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
+	uint8_t i;
+
+	if (!sm || !data ||
+		size < sizeof(struct bt_hci_evt_le_cs_subevent_result))
+		return;
+
+	/* Initialize iovec with the event data */
+	iov.iov_base = (void *)data;
+	iov.iov_len = size;
+
+	/* Check if Procedure is active or not */
+	if (!sm->procedure_active) {
+		DBG("Received Subevent event when Procedure is inactive!");
+		return;
+	}
+
+	/* Parse header fields using iovec */
+	if (!util_iov_pull_le16(&iov, &handle)) {
+		DBG("[ERROR] Failed to parse Connection_Handle\n");
+		return;
+	}
+
+	if (!util_iov_pull_u8(&iov, &config_id) ||
+		!util_iov_pull_le16(&iov, &start_acl_conn_evt_counter) ||
+		!util_iov_pull_le16(&iov, &proc_counter) ||
+		!util_iov_pull_le16(&iov, &freq_comp) ||
+		!util_iov_pull_u8(&iov, &ref_pwr_lvl) ||
+		!util_iov_pull_u8(&iov, &proc_done_status) ||
+		!util_iov_pull_u8(&iov, &subevt_done_status) ||
+		!util_iov_pull_u8(&iov, &abort_reason) ||
+		!util_iov_pull_u8(&iov, &num_ant_paths) ||
+		!util_iov_pull_u8(&iov, &num_steps_reported)) {
+		DBG("[ERROR] Failed to parse subevent fields\n");
+		return;
+	}
+
+	cs_role = cs_opt.role;
+	cs_rtt_type = cs_opt.rtt_type;
+	max_paths = MIN((num_ant_paths + 1), CS_MAX_ANT_PATHS);
+	steps = MIN(num_steps_reported, CS_MAX_STEPS);
+	send_len = offsetof(struct rap_ev_cs_subevent_result, step_data) +
+					steps * sizeof(struct cs_step_data);
+	rap_ev = (struct rap_ev_cs_subevent_result *)malloc(send_len);
+	if (!rap_ev) {
+		DBG("[ERROR] Failed to allocate memory for subevent result\n");
+		return;
+	}
+
+	DBG("[EVENT] Subevent Result (length=%u)\n", size);
+	rap_ev->conn_hdl                     = le16_to_cpu(handle);
+	rap_ev->config_id                    = config_id;
+	rap_ev->start_acl_conn_evt_counter   = start_acl_conn_evt_counter;
+	rap_ev->proc_counter                 = proc_counter;
+	rap_ev->freq_comp                    = freq_comp;
+	rap_ev->ref_pwr_lvl                  = ref_pwr_lvl;
+	rap_ev->proc_done_status             = proc_done_status;
+	rap_ev->subevt_done_status           = subevt_done_status;
+	rap_ev->abort_reason                 = abort_reason;
+	rap_ev->num_ant_paths                = num_ant_paths;
+	rap_ev->num_steps_reported           = steps;
+
+	if (num_steps_reported > CS_MAX_STEPS) {
+		DBG("Too many steps reported: %u (max %u)",
+			num_steps_reported, CS_MAX_STEPS);
+		goto send_event;
+	}
+
+	/* Early exit for error conditions */
+	if (rap_ev->subevt_done_status == 0xF ||
+	    rap_ev->proc_done_status == 0xF) {
+		DBG("CS Procedure/Subevent aborted: ");
+		DBG("sub evt status = %d, proc status = %d, reason = %d",
+			rap_ev->subevt_done_status, rap_ev->proc_done_status,
+			rap_ev->abort_reason);
+		goto send_event;
+	}
+
+	/* Parse interleaved step data from remaining iovec data */
+	for (i = 0; i < steps; i++)
+		parse_cs_step(&iov, &rap_ev->step_data[i], cs_role, cs_rtt_type,
+			max_paths);
+
+send_event:
+	DBG("CS subevent result processed: %zu bytes, ", send_len);
+	bt_rap_hci_cs_subevent_result_callback(send_len, rap_ev, sm->rap);
+	free(rap_ev);
+}
+
+static void rap_cs_subevt_result_cont_evt(const uint8_t *data, uint8_t size,
+					void *user_data)
+{
+	struct cs_state_machine_t *sm = (struct cs_state_machine_t *)user_data;
+	struct rap_ev_cs_subevent_result_cont *rap_ev;
+	struct iovec iov;
+	uint8_t cs_role;
+	uint8_t cs_rtt_type;
+	uint8_t max_paths;
+	uint8_t steps;
+	size_t send_len = 0;
+	uint16_t handle;
+	uint8_t config_id;
+	uint8_t proc_done_status;
+	uint8_t subevt_done_status;
+	uint8_t abort_reason;
+	uint8_t num_ant_paths;
+	uint8_t num_steps_reported;
+	uint8_t i;
+
+	if (!sm || !data ||
+		size < sizeof(struct bt_hci_evt_le_cs_subevent_result_continue))
+		return;
+
+	/* Initialize iovec with the event data */
+	iov.iov_base = (void *)data;
+	iov.iov_len = size;
+
+	/* Check if Procedure is active or not */
+	if (!sm->procedure_active) {
+		DBG("Received Subevent when CS Procedure is inactive!");
+		return;
+	}
+
+	/* Parse header fields using iovec */
+	if (!util_iov_pull_le16(&iov, &handle)) {
+		DBG("[ERROR] Failed to parse Connection_Handle\n");
+		return;
+	}
+
+	if (!util_iov_pull_u8(&iov, &config_id) ||
+		!util_iov_pull_u8(&iov, &proc_done_status) ||
+		!util_iov_pull_u8(&iov, &subevt_done_status) ||
+		!util_iov_pull_u8(&iov, &abort_reason) ||
+		!util_iov_pull_u8(&iov, &num_ant_paths) ||
+		!util_iov_pull_u8(&iov, &num_steps_reported)) {
+		DBG("[ERROR] Failed to parse subevent continue fields ");
+		return;
+	}
+
+	cs_role = cs_opt.role;
+	cs_rtt_type = cs_opt.rtt_type;
+	max_paths = MIN((num_ant_paths + 1), CS_MAX_ANT_PATHS);
+	steps = MIN(num_steps_reported, CS_MAX_STEPS);
+	send_len = offsetof(struct rap_ev_cs_subevent_result_cont, step_data) +
+					steps * sizeof(struct cs_step_data);
+	rap_ev = (struct rap_ev_cs_subevent_result_cont *)malloc(send_len);
+	if (!rap_ev) {
+		DBG("[ERROR] Failed to allocate memory for subevent result\n");
+		return;
+	}
+
+	DBG("[EVENT] Subevent Result Cont (length=%u)\n", size);
+	rap_ev->conn_hdl                     = le16_to_cpu(handle);
+	rap_ev->config_id                    = config_id;
+	rap_ev->proc_done_status             = proc_done_status;
+	rap_ev->subevt_done_status           = subevt_done_status;
+	rap_ev->abort_reason                 = abort_reason;
+	rap_ev->num_ant_paths                = num_ant_paths;
+	rap_ev->num_steps_reported           = steps;
+
+	if (num_steps_reported > CS_MAX_STEPS) {
+		DBG("Too many steps reported: %u (max %u)",
+			num_steps_reported, CS_MAX_STEPS);
+		goto send_event;
+	}
+
+	/* Early exit for error conditions */
+	if (rap_ev->subevt_done_status == 0xF ||
+	    rap_ev->proc_done_status == 0xF) {
+		DBG("CS Procedure/Subevent aborted: ");
+		DBG("sub evt status = %d, proc status = %d, reason = %d",
+			rap_ev->subevt_done_status, rap_ev->proc_done_status,
+			rap_ev->abort_reason);
+		goto send_event;
+	}
+
+	/* Parse interleaved step data from remaining iovec data */
+	for (i = 0; i < steps; i++)
+		parse_cs_step(&iov, &rap_ev->step_data[i], cs_role, cs_rtt_type,
+			max_paths);
+
+send_event:
+	DBG("CS subevent result cont processed: %zu bytes, ", send_len);
+	bt_rap_hci_cs_subevent_result_cont_callback(send_len, rap_ev, sm->rap);
+	free(rap_ev);
+}
+
+/* HCI Event Registration */
+static void rap_handle_hci_events(const void *data, uint8_t size,
+				void *user_data)
+{
+	struct iovec iov;
+	uint8_t subevent;
+
+	/* Initialize iovec with the event data */
+	iov.iov_base = (void *)data;
+	iov.iov_len = size;
+
+	/* Pull the subevent code */
+	if (!util_iov_pull_u8(&iov, &subevent))
+		return;
+
+	/* Now iov points to the payload, and iov_len is the payload length */
+	switch (subevent) {
+	case BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE:
+		rap_rd_rmt_supp_cap_cmplt_evt(iov.iov_base,
+					iov.iov_len, user_data);
+		break;
+	case BT_HCI_EVT_LE_CS_CONFIG_COMPLETE:
+		rap_cs_config_cmplt_evt(iov.iov_base,
+					iov.iov_len, user_data);
+		break;
+	case BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE:
+		rap_cs_sec_enable_cmplt_evt(iov.iov_base,
+					iov.iov_len, user_data);
+		break;
+	case BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE:
+		rap_cs_proc_enable_cmplt_evt(iov.iov_base,
+					iov.iov_len, user_data);
+		break;
+	case BT_HCI_EVT_LE_CS_SUBEVENT_RESULT:
+		rap_cs_subevt_result_evt(iov.iov_base,
+					iov.iov_len, user_data);
+		break;
+	case BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE:
+		rap_cs_subevt_result_cont_evt(iov.iov_base,
+					iov.iov_len, user_data);
+		break;
+	default:
+		break;
+	}
+}
+
+void bt_rap_hci_register_events(struct bt_rap *rap, struct bt_hci *hci)
+{
+	if (!rap || !hci)
+		return;
+
+	sm = new0(struct cs_state_machine_t, 1);
+	if (!sm) {
+		DBG("[ERROR] Failed to allocate state machine\n");
+		return;
+	}
+
+	cs_state_machine_init(sm, rap, hci);
+	sm->event_id = bt_hci_register(hci, BT_HCI_EVT_LE_META_EVENT,
+					rap_handle_hci_events, sm, NULL);
+
+	DBG("bt_hci_register done, event_id : %d", sm->event_id);
+
+	if (!sm->event_id) {
+		DBG("Error: Failed to register hci le meta events ");
+		DBG("event_id=0x%02X\n", sm->event_id);
+		free(sm);
+		return;
+	}
+}
+
+bool bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci)
+{
+	if (!rap)
+		return false;
+
+	if (!hci) {
+		DBG("Failed to create HCI RAW channel ");
+		bt_hci_unref(hci);
+		return false;
+	}
+
+	bt_rap_hci_register_events(rap, hci);
+
+	return true;
+}
-- 


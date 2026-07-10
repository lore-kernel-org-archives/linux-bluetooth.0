Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B73F9F56
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676977; cv=none; b=ZOp3FtDq4dGYGhb63ECOefy8nYoaJwv2Zm+nSMOnapyQKSnc7e5f6WOC7uDLRT/puoppK+g2AtWsm5p1ZmewqPK2ZXHvw07zm1+ZQ4iF2ekC7hnXDviU6DjgZTrMvgz27JcmD6jsNsoi2NUnJ/78JT1cWz8oyDLD0S5cK6lv1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676977; c=relaxed/simple;
	bh=8WA6p/0wiTfKWqWxABEp3eLCsxMiRXOP72zXB2yx034=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cocCfn1VGlM2V6p2+IWJpvoY889NlEqNRd3US+cKjuGywH0yPLooBYwliMg73zHRlZg6qtDwhEcY5QkAB/+okaxzQBH291WeEh84bzTdIvlZ3Ct3FL6kGPEVFf3avZDbVbUOZJ7Rg30ddNNXiFByO0FlO+D4mqWfkSF1cLHeVm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kscSWGBf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I5qxKvwU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kscSWGBf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I5qxKvwU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7eKKH190769
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VnePDlf4jvF
	B5fxwH4nz2ECFHVsFzom0R6dISUmNV1o=; b=kscSWGBfn4CEZGXVMCaCAdo6YKm
	LADCad3aaQec30uzSMtWlt4SuV8dtrLKzLBng+uFAMiKq4FV9szq5iPucA+qCk2H
	XeCzHacmFLKJ7UQ0lhdI/F8SS2U/2+kpX7SUguTo2U5Ing57uE1WRgBUJyoQ5tt2
	8aRQ5gPdHgrh6ndr0OY8VRAxD5wIh4O2FotWA2z2m59s4CLwzLgE/dAHAAJYpAWo
	89HhKnal53KhiZu/1F3YcwzWlwHbVCGRMlTS+65eU6WQYp9j0Hxj3wWy5Ftk51XB
	Sio94N3YcD73qGJ8Q4Laie7J8YTNKVBUsIscFYQJTTiQqWzHp3wqcg0pj5g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n19sw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:49:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so1342356a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783676971; x=1784281771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VnePDlf4jvFB5fxwH4nz2ECFHVsFzom0R6dISUmNV1o=;
        b=I5qxKvwUGkGQx4KlByVrh9h+rYG3zNyuZYLjJpMSZtOvbyuhWVGTE1CZz+e2iD8cxF
         A+5LrQOWqocV9R35HOyg1adW5isX+Dv3bFRjPw6AiLtJ6l9PfKKCKhZGamm5+zrvMiKc
         5Yu/7Kt+kZM9aaR1lJEBi15gQxhyI9YCRvG11wkuEdg7zPWdcz+uXPLz25cc2UBGv8U0
         f9gtI1UHMsP7S7/c20Z/w9rXw2BfTW1Aj6LnfSVM3wCh5rJdiZaQo2ogtx6nbhB5mmB+
         f6P/oNMVZbkR/m18eLZFRT/eRoa+50kWycOZfkhFJu9WJZCMLteQjCXbNn8oH0hV3PRk
         2cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783676971; x=1784281771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VnePDlf4jvFB5fxwH4nz2ECFHVsFzom0R6dISUmNV1o=;
        b=KgjXpsUk4yvJ25P7LhSnKGtdx+AXnSEXii4Qouza9N3NzQjQrHkCgbdktpOmz1v0uw
         EPJKUyYJmh2PegTvw5BVsbNZwaacp1/Q0vRxERllaOd3ypekPaVsmqvIoUF/9hJwMrmf
         v0r8ZaLbGBlzyfGtQfSwk5YlZXNi5Qr5mKKBbLAZCBc0P6u13ThUwTHVFEFhlzapFi8u
         GDfzWWauexNxoxpNJIjk9l92v0ZOgBQCSiO+vJRY0eJz1gLH4IZxfPqprro8BSULYHEX
         epqwuDHxGcAtqcLPZj12UuBk6/3Fh33IcQSVBdxgcsgvXvBojpv5dgAfv/UieNJVu9iH
         FrBA==
X-Gm-Message-State: AOJu0Yxigz0c2U5bOAl/MssoRrpHQ4ZLpjcIdIEIMUg4htviXOdhR2SL
	AatYDcYmHO8YTcn1AOp/Yv5AJp9IN+n4z2hfC1M8+amr74OMiaFAUOZevEqEiN2zgwqCsc0/ov7
	WCIiuMVuF28KF+SxDrr7hLQzcukR6huTbELdXCNvh27BJaEXxI677dDjlZH+Zsl7j8B0z4zHv9V
	TVLQY=
X-Gm-Gg: AfdE7clb44WAEARvAUJM30BFnMI+OezZwF104XImktWh1XLkSW1Vvv2mFZJBR9oTYMx
	63EwNY/PH0JOiVNcfiQoztVhByWnfd7/bH4grHmfrG0UD7Ox445zKhZlcyZRPsPUBu3uDHFCbL7
	X2scSFHpLBjZM2hGfw+f7CbrhakEXifiv1ctpVNrsz1QZeNFuyBpwraz0B/H1K7OpT4+y94mzQM
	PkWOn+IKbiR58GQnr5om66bE12GL4vrKJN5Pf4HG9ayQ0yqutZGMexf6Zv55YuUmQNx3wT4kNKv
	RqGn+gRWF1OFZEonPxkoBUgxc+hW2Ahn058dbK5H8EtPFFUAkBn3ku9bLAJU5EANus/Cs7FbOmj
	fggipjRyLWlrump9m0zq3hXeFCPvJmFESL0y5xz4E
X-Received: by 2002:a05:6a20:6f8d:b0:3b2:a809:1000 with SMTP id adf61e73a8af0-3c0bcf48f6emr12892300637.3.1783676970410;
        Fri, 10 Jul 2026 02:49:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f8d:b0:3b2:a809:1000 with SMTP id adf61e73a8af0-3c0bcf48f6emr12892264637.3.1783676969867;
        Fri, 10 Jul 2026 02:49:29 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b3206aaasm4106526eec.13.2026.07.10.02.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:49:29 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 1/4] rap: Add Channel Sounding parameter types and APIs
Date: Fri, 10 Jul 2026 15:19:16 +0530
Message-Id: <20260710094919.4047204-2-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710094919.4047204-1-naga.akella@oss.qualcomm.com>
References: <20260710094919.4047204-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NiBTYWx0ZWRfX83XuDxYpfqu1
 psuqI/QYte3MZT/ZTM8+nJ3bBOpIZ38owJz3bLLs1LOlPCip8vE+wKNmKjyiMAoAMDoq9jOaeQS
 MZM2v/KUi29IZieNKRmVf7ZRD7lsZR8=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a50c02b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=GhXf9q-71yA2H53oXBwA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: pMTXTCiuMDhAbxrEWlDcY6v74vHP_hjP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NiBTYWx0ZWRfX2c91UOiOqRVA
 e3fw3rb1ApJVP02Nk/3PD2phqKWbunVOAJT0FyORM21d7NsujqS4029GCQe2DhqP3UBKZy+t2u1
 3Tn2tqdKMUZxryPXMCcb+CZQx7mO3ZO7b8PeoE6wW14AbU4zPxKXlvoRJ35yxGW276fzhvXmEUd
 jFFi4dSfeI726dYhxCMH1z9G4/pswmIRfHU8CE0R326XUMDZxb2/YXNE7epHzgteSMt5NX6tllk
 13dytZW7mSwdbKiCSN9k6K00iltamZIBMJaeyHI1FojFv39hXbDUArPB+gYFOCQ3bi3d+vg6Flv
 FlFoyI23+UL716Kre+IWkFC8Ec+U6oK9mi3iL7W9OJwOMvkb578ra8ZPvFoP2Hl+JpUdRIqmPrW
 CHqQRTksLXIXN/uCGapY3XTxZbSwLVJrI3JBUehDOrUoZ/lvhLialbSywwMLacn5dRmS616prMo
 C5ZXH2T0RkcVfusQm4A==
X-Proofpoint-GUID: pMTXTCiuMDhAbxrEWlDcY6v74vHP_hjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100096

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


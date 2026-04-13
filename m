Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A103B38A7
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076919; cv=none; b=BqxMOfL6x4U1h3/iazCORX3pPy650S1qCPCubStgxmGj4L4StZZnPPnS0et1zCxhSWuWEXxHl4Jpkk3pF48XliupYZW/yymLbmZ7tCMiT7dpf2b41EsWt3Nbmf1l3BR+cmIVDR7AW67jJ5foZCeYieFI0XiVo3UrbITLhBdRnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076919; c=relaxed/simple;
	bh=fLXldxL23202qLGEgPcmMpYZ7V8hXDDawq6mHL8FydY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwVb9oF3ts40w9+qvVo/bp8ZwWqUgZkQqR1cqdFyDTAhq7fKzdNK1VotdSGe5b8yfdug+eXWdKSC4TzHOiz4qujv+kfDJcsNmo3zwG901jmxcZYbAohi6Lgkajmi8zwRWd5wesNuTeeUrP5sJOJWgqoEOVk79uyLZo/e/boiuyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D+0Jbfw/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MaS+0YNu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D+0Jbfw/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MaS+0YNu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D7T9a7445957
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 10:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/XyHd4vn7rL9nT6dsEfQeg2pkCnd19mptkP3UCJg6uo=; b=D+0Jbfw/ppLqVrvt
	UfJnGIx2FslnDA4MGdkJozny8NCHaMcfo5SIe6LbY++xE3lJXwCFeAJNsGiId+mT
	twuZBt8M6V36vyKNnTqV0caWHZiuQ8EGCi7ig51fhzmd1oWZJwdiL2NJAy3WPa6L
	auVsBKXlIH3YE8Cne/CrbCcZ2mANZgh24tRzBTzAVZ34x79CdPGXfHbGxJ5lPSNz
	B9gH/MlWMcA3JWLwvL2GV22d7hEqJYyCljtdx6em3JghBQ+/6k8WBPMBM381M7ka
	aLszqeXnI1w+KlycO7rcH2if024FOJuU4wRvAot713ZxPF6aypyMYKvGJLqKfHNF
	eESO4g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfffhvvym-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 10:41:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso12094445ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 03:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776076914; x=1776681714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XyHd4vn7rL9nT6dsEfQeg2pkCnd19mptkP3UCJg6uo=;
        b=MaS+0YNu3AohTHGaWSSU0bt4yahtNyyRu3Ap08GrA7W0LX5AO08+k0J/pTyJ/bU6y4
         GK0yRaKE+AB97LcKOEItS7maTiyZuZfxHH4AfhqZuipBHaicuJpAYF1n8+xxlzS6hOAf
         T7Dri7bgEZuKCyJ/g5jTbGzZaMd1nxcRPRPvFZTeUpvFS+tRFUol48KJfZqBq9jkwQeJ
         hb8ad0gh2qbRJPIcnBpIOcvI4E6s0WPvd9MjJqvKvYiJHgEiNUddWMl2fbFuCoat7SSF
         r9i8ReAHZmuc1zlvUHsrg60AV147dTdCdL6PsFYOUHu0Tnu5FyBtWU9To064IREJQyRY
         WWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776076914; x=1776681714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/XyHd4vn7rL9nT6dsEfQeg2pkCnd19mptkP3UCJg6uo=;
        b=WnSf2ez/D/K32CQED1wbOl47G22+u7tWQCLxEv8Bk6P+O8d6ML4ETYOj8LIJjJllHa
         lHYwJxYo/rX6H0A2M9m6oLZOaCsCzwS+eijRmfD5ygjBMjkkRuVaDgmYDUv3I7qSvy/i
         k4VuypGss3o7jkqTFjUQLlS9KrP5wgpJKr9ev0hOBAROrd9uANb/yNYGh5TQV88WWKT8
         lZ7IvYpPgNCAOI0uVqrqeWm3BWk1xvJeu17pVESndPE3wxFSy4PmyV849YjcYD2SyCgI
         PzBin9utWHRopu4yOjr3gFH3D/sE6zLtC+lKB0+K4nIjEUSG1A0fTXC3rfT5NcubPPSH
         xYDA==
X-Gm-Message-State: AOJu0YySsCWmW51u07yyLX18i1oHEnwP3abNG2idX3kFMHMTOuS8JXS/
	z0nPZaBcgq9r61LsRAA1hKh5lOkGfIj1xal9sgWtpeZrMvLFlQ83l8sayiE41Ld4dhiMRNsixy6
	OzXDzvU0E6yZSMtAPjaRsI53SaP1ZeRqelhRma6tUEGwkb1YwXrX7YaJiMMJe7QqmvyBuLbp4cD
	C7T0k=
X-Gm-Gg: AeBDiet2C2QqJ5yLPoYRY++kMQZA/CYBwbVeFanm0I9nKptDcdduMK6iwr7HT07M0WJ
	m9raczUUBBz7k+QOqM+U8fzR4R9/sJFgFd4Jk1GZwjt9UCNwjojLA0l4vVFFg/lQDEm7kOPENRB
	i9JGmBHffOAGb4pMHmBMnf3BB5cp0ObORMetcuS6ooFVHELatCRKlfPkUQ2Dz8aeYb/JpHTYkkX
	FTfHTUMZ88ku/MrOo0RpG3LrRHQZyqURGh1fAXZyfE0dYzQwJ9YhFUlHGO2R0PAnLOdbbFs58Zu
	fVOD1TwPMZksxkY7MVZ0e3jMYVJt+VoStWHO+w5DibrNV4PbXDYKINDO1FEuVzYTGAw84TTA5YH
	BEJILBkaHiPL46GurTTUG2CW6olwcCIeZL47RkyE6KgF0d4pcHwg=
X-Received: by 2002:a17:903:acb:b0:2b0:5cb4:d89d with SMTP id d9443c01a7336-2b2d5a698e9mr138646935ad.29.1776076913838;
        Mon, 13 Apr 2026 03:41:53 -0700 (PDT)
X-Received: by 2002:a17:903:acb:b0:2b0:5cb4:d89d with SMTP id d9443c01a7336-2b2d5a698e9mr138646455ad.29.1776076912971;
        Mon, 13 Apr 2026 03:41:52 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4e0f909sm144495055ad.35.2026.04.13.03.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 03:41:52 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 3/3] profiles: ranging: Add HCI LE Event Handling in  Reflector role
Date: Mon, 13 Apr 2026 16:11:16 +0530
Message-Id: <20260413104116.1605357-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413104116.1605357-1-naga.akella@oss.qualcomm.com>
References: <20260413104116.1605357-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwMyBTYWx0ZWRfX9Vn8wDql25ZF
 ffh4glnxwwApsgXDvSNKq8/Jzwem380PgSe/t5MlcT0QKX0k+BR4chRxz7J3MaF8DAZi/dke+WM
 1UzVSOEYRO56l03nD6RWwghy8BcGr7yO5EZpCA1x9xWzJOxFRYclNizxpTrJ7/d4x6AqxUf7USs
 Av8nZGhQ+jq81DDOLMjRuncm4Nc/mWRFsQgGj4juSeXN9nRUgd6XIompZuNCg8Oj54uzR6+Jz4O
 byWFEit1BHNJ8o7b8jEqgOeYmbAG6KrmycZolEBgnELfdc4T7Lt6hjqRjEoz2zGHQdl2Uw03PMH
 nuUBWOJOoo9T1zcCSIlxKBnRx3WjTlcBqybKxLsJLMfBT8/w4qkO5MDUaxN7LkvhE4SqMY6SejG
 xPxm5PiXHFewga6laJ0WEtk8ixDRO7KO8Nc7YT60KzrXknilsatdIfipyQWyDiY4wOo7mtNkDBk
 hKNfmoDVQ/hr494I57A==
X-Proofpoint-ORIG-GUID: zwI8FtR7-KjVMGsl_fdjgoJruZ1mTo2n
X-Authority-Analysis: v=2.4 cv=FOkrAeos c=1 sm=1 tr=0 ts=69dcc873 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=BE-wQBOjkMQjn6is65kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: zwI8FtR7-KjVMGsl_fdjgoJruZ1mTo2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130103

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
Map connection handle received to device connection
---
 Makefile.plugins           |    3 +-
 profiles/ranging/rap.c     |   83 ++-
 profiles/ranging/rap_hci.c | 1288 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1367 insertions(+), 7 deletions(-)
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
index f03454c72..63682e318 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -17,6 +17,7 @@
 #include "gdbus/gdbus.h"
 
 #include "bluetooth/bluetooth.h"
+#include "bluetooth/l2cap.h"
 #include "bluetooth/uuid.h"
 
 #include "src/plugin.h"
@@ -34,12 +35,17 @@
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
@@ -61,10 +67,10 @@ static void rap_debug(const char *str, void *user_data)
 
 static void rap_data_add(struct rap_data *data)
 {
-	DBG("%p", data);
+	DBG("%p", (void *)data);
 
 	if (queue_find(sessions, NULL, data)) {
-		error("data %p already added", data);
+		error("data %p already added", (void *)data);
 		return;
 	}
 
@@ -95,13 +101,21 @@ static void rap_data_free(struct rap_data *data)
 	}
 
 	bt_rap_ready_unregister(data->rap, data->ready_id);
+#if USE_BT_HCI_RAW_CHANNEL
+	if (data->hci) {
+		bt_rap_hci_sm_cleanup();
+		bt_hci_unref(data->hci);
+	}
+#endif
+	/* Clean up HCI connection mappings */
+	bt_rap_detach_hci(data->rap);
 	bt_rap_unref(data->rap);
 	free(data);
 }
 
 static void rap_data_remove(struct rap_data *data)
 {
-	DBG("%p", data);
+	DBG("%p", (void *)data);
 
 	if (!queue_remove(sessions, data))
 		return;
@@ -118,7 +132,7 @@ static void rap_detached(struct bt_rap *rap, void *user_data)
 {
 	struct rap_data *data;
 
-	DBG("%p", rap);
+	DBG("%p", (void *)rap);
 
 	data = queue_find(sessions, match_data, rap);
 	if (!data) {
@@ -131,7 +145,7 @@ static void rap_detached(struct bt_rap *rap, void *user_data)
 
 static void rap_ready(struct bt_rap *rap, void *user_data)
 {
-	DBG("%p", rap);
+	DBG("%p", (void *)rap);
 }
 
 static void rap_attached(struct bt_rap *rap, void *user_data)
@@ -140,7 +154,7 @@ static void rap_attached(struct bt_rap *rap, void *user_data)
 	struct bt_att *att;
 	struct btd_device *device;
 
-	DBG("%p", rap);
+	DBG("%p", (void *)rap);
 
 	data = queue_find(sessions, match_data, rap);
 	if (data) {
@@ -194,6 +208,22 @@ static int rap_probe(struct btd_service *service)
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
 
@@ -228,6 +258,10 @@ static int rap_accept(struct btd_service *service)
 	struct btd_device *device = btd_service_get_device(service);
 	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
 	struct rap_data *data = btd_service_get_user_data(service);
+	struct bt_att *att;
+	const bdaddr_t *bdaddr;
+	uint8_t bdaddr_type;
+	uint16_t handle;
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
@@ -243,6 +277,43 @@ static int rap_accept(struct btd_service *service)
 		return -EINVAL;
 	}
 
+	/* Set up connection handle mapping for CS event routing */
+	att = bt_rap_get_att(data->rap);
+	bdaddr = device_get_address(device);
+	bdaddr_type = device_get_le_address_type(device);
+
+	if (att && data->hci) {
+		/* Use bt_hci_get_conn_info to find the connection handle
+		 * by iterating through all connections and matching bdaddr
+		 */
+		struct bt_hci_conn_info conn_info;
+		bool found = false;
+
+		/* Try handles from 0x0001 to 0x0EFF
+		 * (valid LE connection handle range)
+		 */
+		for (handle = 0x0001; handle <= 0x0EFF; handle++) {
+			if (bt_hci_get_conn_info(data->hci, handle,
+				&conn_info)) {
+				/* Check if bdaddr matches */
+				if (memcmp(conn_info.bdaddr, bdaddr, 6) == 0) {
+					found = true;
+					DBG("Found conn handle 0x%04X", handle);
+					break;
+				}
+			}
+		}
+
+		if (found) {
+			DBG("Setting up handle mapping: handle=0x%04X", handle);
+			bt_rap_set_conn_handle(data->rap, handle,
+						(const uint8_t *)bdaddr,
+						bdaddr_type);
+		} else {
+			error("Failed to find connection handle for device");
+		}
+	}
+
 	btd_service_connecting_complete(service, 0);
 
 	return 0;
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
new file mode 100644
index 000000000..b00719ae2
--- /dev/null
+++ b/profiles/ranging/rap_hci.c
@@ -0,0 +1,1288 @@
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
+#include "src/shared/queue.h"
+#include "src/shared/rap.h"
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
+/* Connection Handle Mapping */
+struct rap_conn_mapping {
+	uint16_t handle;
+	uint8_t bdaddr[6];
+	uint8_t bdaddr_type;
+	struct bt_att *att;
+	struct bt_rap *rap;
+};
+
+static struct queue *conn_mappings;
+
+/* Connection Mapping Helper Functions */
+static void mapping_free(void *data)
+{
+	struct rap_conn_mapping *mapping = data;
+
+	if (!mapping)
+		return;
+
+	free(mapping);
+}
+
+static bool match_mapping_handle(const void *a, const void *b)
+{
+	const struct rap_conn_mapping *mapping = a;
+	uint16_t handle = PTR_TO_UINT(b);
+
+	return mapping->handle == handle;
+}
+
+static bool match_mapping_rap(const void *a, const void *b)
+{
+	const struct rap_conn_mapping *mapping = a;
+	const struct bt_rap *rap = b;
+
+	return mapping->rap == rap;
+}
+
+static struct rap_conn_mapping *find_mapping_by_handle(uint16_t handle)
+{
+	if (!conn_mappings)
+		return NULL;
+
+	return queue_find(conn_mappings, match_mapping_handle,
+				UINT_TO_PTR(handle));
+}
+
+static bool add_conn_mapping(uint16_t handle, const uint8_t *bdaddr,
+				uint8_t bdaddr_type, struct bt_att *att,
+				struct bt_rap *rap)
+{
+	struct rap_conn_mapping *mapping;
+
+	if (!conn_mappings) {
+		conn_mappings = queue_new();
+		if (!conn_mappings)
+			return false;
+	}
+
+	/* Check if mapping already exists */
+	mapping = find_mapping_by_handle(handle);
+	if (mapping) {
+		/* Update existing mapping */
+		if (bdaddr)
+			memcpy(mapping->bdaddr, bdaddr, 6);
+		mapping->bdaddr_type = bdaddr_type;
+		mapping->att = att;
+		mapping->rap = rap;
+		return true;
+	}
+
+	/* Create new mapping */
+	mapping = new0(struct rap_conn_mapping, 1);
+	if (!mapping)
+		return false;
+
+	mapping->handle = handle;
+	if (bdaddr)
+		memcpy(mapping->bdaddr, bdaddr, 6);
+	mapping->bdaddr_type = bdaddr_type;
+	mapping->att = att;
+	mapping->rap = rap;
+
+	return queue_push_tail(conn_mappings, mapping);
+}
+
+static void remove_conn_mapping(uint16_t handle)
+{
+	struct rap_conn_mapping *mapping;
+
+	if (!conn_mappings)
+		return;
+
+	mapping = queue_remove_if(conn_mappings, match_mapping_handle,
+					UINT_TO_PTR(handle));
+	if (mapping)
+		mapping_free(mapping);
+}
+
+static void remove_rap_mappings(struct bt_rap *rap)
+{
+	if (!conn_mappings)
+		return;
+
+	queue_remove_all(conn_mappings, match_mapping_rap, rap,
+				mapping_free);
+}
+
+static struct bt_rap *resolve_handle_to_rap(uint16_t handle,
+						struct bt_hci *hci)
+{
+	struct rap_conn_mapping *mapping;
+	struct bt_hci_conn_info conn_info;
+
+	/* First try to find in mapping cache */
+	mapping = find_mapping_by_handle(handle);
+	if (mapping && mapping->rap) {
+		DBG("Found handle 0x%04X in mapping cache", handle);
+		return mapping->rap;
+	}
+
+	/* Fallback: Try to get connection info via ioctl */
+	if (hci && bt_hci_get_conn_info(hci, handle, &conn_info)) {
+		DBG("Got connection info via ioctl for handle 0x%04X:", handle);
+		DBG("  bdaddr=%02x:%02x:%02x:%02x:%02x:%02x link_type=0x%02x",
+			conn_info.bdaddr[5], conn_info.bdaddr[4],
+			conn_info.bdaddr[3], conn_info.bdaddr[2],
+			conn_info.bdaddr[1], conn_info.bdaddr[0],
+			conn_info.type);
+		DBG("  Note: Cannot determine RAP instance from ioctl alone");
+	}
+
+	/* Profile layer should have called bt_rap_set_conn_handle() during
+	 * connection establishment. If we reach here, the mapping was not set.
+	 */
+	DBG("No mapping found for handle 0x%04X", handle);
+	DBG("Profile layer should call bt_rap_set_conn_handle() on connect");
+
+	return NULL;
+}
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
+	const struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *evt;
+	struct bt_rap *rap;
+	struct iovec iov;
+
+	if (!sm || !data ||
+		size < sizeof(struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete))
+		return;
+
+	/* Initialize iovec with the event data */
+	iov.iov_base = (void *)data;
+	iov.iov_len = size;
+
+	/* Pull the entire structure at once */
+	evt = util_iov_pull_mem(&iov, sizeof(*evt));
+	if (!evt) {
+		DBG("[ERROR] Failed to pull remote cap complete struct\n");
+		return;
+	}
+
+	DBG("[EVENT] Remote Capabilities Complete\n");
+	DBG("status=0x%02X, handle=0x%04X\n", evt->status, evt->handle);
+
+	/* Check status */
+	if (evt->status != 0) {
+		DBG("[ERROR] Remote capabilities failed with status 0x%02X\n",
+			evt->status);
+		cs_set_state(sm, CS_STOPPED);
+		return;
+	}
+
+	/* Resolve handle to RAP instance */
+	rap = resolve_handle_to_rap(evt->handle, sm->hci);
+	if (!rap) {
+		DBG("[WARN] Could not resolve handle 0x%04X to RAP instance\n",
+			evt->handle);
+		/* Continue with state machine RAP for now */
+		rap = sm->rap;
+	}
+
+	DBG("[EVENT] Remote Capabilities: num_config=%u, ",
+		evt->num_config_supported);
+	DBG("max_consecutive_proc=%u, num_antennas=%u, ",
+		evt->max_consecutive_procedures_supported,
+		evt->num_antennas_supported);
+	DBG("max_antenna_paths=%u, roles=0x%02X, modes=0x%02X\n",
+		evt->max_antenna_paths_supported,
+		evt->roles_supported,
+		evt->modes_supported);
+
+	rap_send_hci_def_settings_command(sm,
+		(struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *)evt);
+	cs_set_state(sm, CS_INIT);
+}
+
+static void rap_cs_config_cmplt_evt(const uint8_t *data, uint8_t size,
+				    void *user_data)
+{
+	struct cs_state_machine_t *sm = (struct cs_state_machine_t *)user_data;
+	const struct bt_hci_evt_le_cs_config_complete *evt;
+	struct rap_ev_cs_config_cmplt rap_ev;
+	struct iovec iov;
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
+	/* Pull the entire structure at once */
+	evt = util_iov_pull_mem(&iov, sizeof(*evt));
+	if (!evt) {
+		DBG("[ERROR] Failed to pull config complete struct\n");
+		return;
+	}
+
+	DBG("status=0x%02X, handle=0x%04X\n", evt->status, evt->handle);
+
+	/* Check status */
+	if (evt->status != 0) {
+		DBG("[ERROR] Configuration failed with status 0x%02X\n",
+			evt->status);
+		cs_set_state(sm, CS_STOPPED);
+		return;
+	}
+
+	/* Copy fields to rap_ev structure */
+	rap_ev.status = evt->status;
+	rap_ev.conn_hdl = cpu_to_le16(evt->handle);
+	rap_ev.config_id = evt->config_id;
+	rap_ev.action = evt->action;
+	rap_ev.main_mode_type = evt->main_mode_type;
+	rap_ev.sub_mode_type = evt->sub_mode_type;
+	rap_ev.min_main_mode_steps = evt->min_main_mode_steps;
+	rap_ev.max_main_mode_steps = evt->max_main_mode_steps;
+	rap_ev.main_mode_rep = evt->main_mode_repetition;
+	rap_ev.mode_0_steps = evt->mode_0_steps;
+	rap_ev.role = evt->role;
+	rap_ev.rtt_type = evt->rtt_type;
+	rap_ev.cs_sync_phy = evt->cs_sync_phy;
+	memcpy(rap_ev.channel_map, evt->channel_map, 10);
+	rap_ev.channel_map_rep = evt->channel_map_repetition;
+	rap_ev.channel_sel_type = evt->channel_selection_type;
+	rap_ev.ch3c_shape = evt->ch3c_shape;
+	rap_ev.ch3c_jump = evt->ch3c_jump;
+	rap_ev.reserved = evt->reserved;
+	rap_ev.t_ip1_time = evt->t_ip1_time;
+	rap_ev.t_ip2_time = evt->t_ip2_time;
+	rap_ev.t_fcs_time = evt->t_fcs_time;
+	rap_ev.t_pm_time = evt->t_pm_time;
+
+	/* Store rtt_type in global options */
+	cs_opt.rtt_type = rap_ev.rtt_type;
+
+	DBG("[EVENT] Config Complete: config_id=%u, action=%u, ",
+		rap_ev.config_id, rap_ev.action);
+	DBG("main_mode=%u, sub_mode=%u, role=%u, rtt_type=%u\n",
+		rap_ev.main_mode_type, rap_ev.sub_mode_type,
+		rap_ev.role, rap_ev.rtt_type);
+
+	/* Success - proceed to Security enable complete */
+	cs_set_state(sm, CS_WAIT_SEC_CMPLT);
+
+	/* Reflector role */
+	DBG("Waiting for security enable event...\n");
+	/* TODO: Initiator role - Send CS Security enable cmd */
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
+	const struct bt_hci_evt_le_cs_proc_enable_complete *evt;
+	struct rap_ev_cs_proc_enable_cmplt rap_ev;
+	struct iovec iov;
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
+	/* Pull the entire structure at once */
+	evt = util_iov_pull_mem(&iov, sizeof(*evt));
+	if (!evt) {
+		DBG("[ERROR] Failed to pull proc enable complete struct\n");
+		return;
+	}
+
+	DBG("status=0x%02X, handle=0x%04X\n", evt->status, evt->handle);
+
+	/* Check status */
+	if (evt->status != 0) {
+		DBG("[ERROR] Procedure enable failed with status 0x%02X\n",
+			evt->status);
+		cs_set_state(sm, CS_STOPPED);
+		sm->procedure_active = false;
+		return;
+	}
+
+	/* Copy fields to rap_ev structure */
+	rap_ev.status = evt->status;
+	rap_ev.conn_hdl = cpu_to_le16(evt->handle);
+	rap_ev.config_id = evt->config_id;
+	rap_ev.state = evt->state;
+	rap_ev.tone_ant_config_sel = evt->tone_antenna_config_selection;
+	rap_ev.sel_tx_pwr = evt->selected_tx_power;
+	memcpy(rap_ev.sub_evt_len, evt->subevent_len, 3);
+	rap_ev.sub_evts_per_evt = evt->subevents_per_event;
+	rap_ev.sub_evt_intrvl = evt->subevent_interval;
+	rap_ev.evt_intrvl = evt->event_interval;
+	rap_ev.proc_intrvl = evt->procedure_interval;
+	rap_ev.proc_counter = evt->procedure_count;
+	rap_ev.max_proc_len = evt->max_procedure_len;
+
+	DBG("[EVENT] Procedure Enable: config_id=%u, state=%u, ",
+		rap_ev.config_id, rap_ev.state);
+	DBG("sub_evts_per_evt=%u, evt_intrvl=%u, proc_intrvl=%u\n",
+		rap_ev.sub_evts_per_evt, rap_ev.evt_intrvl,
+		rap_ev.proc_intrvl);
+
+	/* Success - procedure started */
+	cs_set_state(sm, CS_STARTED);
+	sm->procedure_active = true;
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
+/* Subevent handler function type */
+typedef void (*subevent_handler_t)(const uint8_t *data, uint8_t size,
+				   void *user_data);
+
+/* Subevent table entry */
+struct subevent_entry {
+	uint8_t opcode;
+	uint8_t min_len;
+	uint8_t max_len;
+	subevent_handler_t handler;
+	const char *name;
+};
+
+/* Subevent dispatch table */
+static const struct subevent_entry subevent_table[] = {
+	{
+		.opcode = BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE,
+		.min_len = sizeof(
+			struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete),
+		.max_len = 0xFF,
+		.handler = rap_rd_rmt_supp_cap_cmplt_evt,
+		.name = "CS Read Remote Supported Capabilities Complete"
+	},
+	{
+		.opcode = BT_HCI_EVT_LE_CS_CONFIG_COMPLETE,
+		.min_len = sizeof(struct bt_hci_evt_le_cs_config_complete),
+		.max_len = 0xFF,
+		.handler = rap_cs_config_cmplt_evt,
+		.name = "CS Config Complete"
+	},
+	{
+		.opcode = BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE,
+		.min_len = sizeof(struct bt_hci_evt_le_cs_sec_enable_complete),
+		.max_len = 0xFF,
+		.handler = rap_cs_sec_enable_cmplt_evt,
+		.name = "CS Security Enable Complete"
+	},
+	{
+		.opcode = BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE,
+		.min_len = sizeof(struct bt_hci_evt_le_cs_proc_enable_complete),
+		.max_len = 0xFF,
+		.handler = rap_cs_proc_enable_cmplt_evt,
+		.name = "CS Procedure Enable Complete"
+	},
+	{
+		.opcode = BT_HCI_EVT_LE_CS_SUBEVENT_RESULT,
+		.min_len = sizeof(struct bt_hci_evt_le_cs_subevent_result),
+		.max_len = 0xFF,
+		.handler = rap_cs_subevt_result_evt,
+		.name = "CS Subevent Result"
+	},
+	{
+		.opcode = BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
+		.min_len = sizeof(
+			struct bt_hci_evt_le_cs_subevent_result_continue),
+		.max_len = 0xFF,
+		.handler = rap_cs_subevt_result_cont_evt,
+		.name = "CS Subevent Result Continue"
+	}
+};
+
+#define SUBEVENT_TABLE_SIZE ARRAY_SIZE(subevent_table)
+
+/* HCI Event Registration */
+static void rap_handle_hci_events(const void *data, uint8_t size,
+				void *user_data)
+{
+	struct iovec iov;
+	uint8_t subevent;
+	const struct subevent_entry *entry = NULL;
+	size_t i;
+
+	/* Initialize iovec with the event data */
+	iov.iov_base = (void *)data;
+	iov.iov_len = size;
+
+	/* Pull the subevent code */
+	if (!util_iov_pull_u8(&iov, &subevent)) {
+		DBG("Failed to parse subevent code");
+		return;
+	}
+
+	/* Find the subevent in the table */
+	for (i = 0; i < SUBEVENT_TABLE_SIZE; i++) {
+		if (subevent_table[i].opcode == subevent) {
+			entry = &subevent_table[i];
+			break;
+		}
+	}
+
+	/* Check if subevent is supported */
+	if (!entry) {
+		DBG("Unknown subevent: 0x%02X", subevent);
+		return;
+	}
+
+	/* Validate payload length */
+	if (iov.iov_len < entry->min_len) {
+		DBG("%s: payload too short (%zu < %u)",
+		    entry->name, iov.iov_len, entry->min_len);
+		return;
+	}
+
+	if (entry->max_len != 0xFF && iov.iov_len > entry->max_len) {
+		DBG("%s: payload too long (%zu > %u)",
+		    entry->name, iov.iov_len, entry->max_len);
+		return;
+	}
+
+	/* Call the handler */
+	DBG("Handling %s (opcode=0x%02X, len=%zu)",
+	    entry->name, subevent, iov.iov_len);
+
+	entry->handler(iov.iov_base, iov.iov_len, user_data);
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
+
+bool bt_rap_set_conn_handle(struct bt_rap *rap, uint16_t handle,
+				const uint8_t *bdaddr, uint8_t bdaddr_type)
+{
+	struct bt_att *att;
+
+	if (!rap)
+		return false;
+
+	att = bt_rap_get_att(rap);
+	if (!att)
+		return false;
+
+	DBG("Setting connection mapping: handle=0x%04X, ", handle);
+	if (bdaddr) {
+		DBG("bdaddr=%02x:%02x:%02x:%02x:%02x:%02x type=%u",
+			bdaddr[5], bdaddr[4], bdaddr[3],
+			bdaddr[2], bdaddr[1], bdaddr[0], bdaddr_type);
+	}
+
+	return add_conn_mapping(handle, bdaddr, bdaddr_type, att, rap);
+}
+
+void bt_rap_clear_conn_handle(struct bt_rap *rap, uint16_t handle)
+{
+	if (!rap)
+		return;
+
+	DBG("Clearing connection mapping: handle=0x%04X", handle);
+	remove_conn_mapping(handle);
+}
+
+void bt_rap_detach_hci(struct bt_rap *rap)
+{
+	if (!rap)
+		return;
+
+	DBG("Detaching RAP from HCI, cleaning up mappings");
+
+	/* Remove all mappings associated with this RAP instance */
+	remove_rap_mappings(rap);
+}
-- 


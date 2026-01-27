Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29A2FFFB7
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536152; cv=none; b=ncXvMcMqXWq76yJkQs5PoDuo74x1l9dvvimmdou7g5IyoRyF/rv+FU80y7/6mi0PXTIAdFn85WDhzy7umpHhy1RLMGCsclkHZdj4AbHseviwBTsVC40SCbshDdK0N7ZqISFd3qbS85NuxaaX9wPM8vckyirkWyCJjdt9shoYLrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536152; c=relaxed/simple;
	bh=4nmLDTIQkTyB6du2dwTEPRrxpe0e5X+9/dJzweX84R8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/awDPB5owCoJeaV3uW4BYYLnkiccKFu3PMso5a8jceKrc+NA/luaSXNnoynKb475CqvwErIJEbneddXixiD9eVTwmFhdEFCZVXzEJHT1dfNXXjd16ZdRZWB9DJzlEDCj0TahUdFEixlVtR1goPDnTK7iGj/v9ompF9HhClVUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O/dxCbIf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KUx9gDgP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O/dxCbIf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KUx9gDgP"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RAbveP1268765
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fwO/VaNZxmao/DUt+h/EjZOeMcEorx8H8F005SZWFq4=; b=O/dxCbIfS7RaPiwm
	jV0S8yoW5hKOc9to2sfqznRTghNoBFjrGvmXCj3wPcmADpiR5q3ootDarb1071qi
	cLazh92dSHEa3SmmhVatoBaDkmLYI3EvitxO/IlPpRzXHuFuJRGLcTyOfHwG7wje
	2nSkJnSlGA1fxHVaA3bMx2Ufj4qC0dzunq/INnD+241vwMm5ogzRNbq9Lakjg4K2
	NOfTUTP2eQ5n2r+ifLKiHhNays6NTtz9KYNmb0EImov+uv/2qRXVTKlXJx4cy3mS
	V85KfVqWslseGhbmdksqg2ZhxR1AMyl+5TLSP+r5HvLF/KE9ZmpCu0ZtSZLSsZ62
	lAZdiA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxnyatr29-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a377e15716so153621385ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769536148; x=1770140948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwO/VaNZxmao/DUt+h/EjZOeMcEorx8H8F005SZWFq4=;
        b=KUx9gDgP0iFcyeO6RoFvlsS1obzzDZA+CPRA28FxDsLOqpsH0e4aPhoL+cGdGfVhQG
         HisLBH+Oa3amZE8AOOpZPUZsmvtTwkEpqR78aDLJDr3N5Duk6jVcONOMLQP1RXBM1yLm
         y6ShNC+rMHJQlJ2pGzRDidnntyUZdoNVKS84SiTAz5qI1Blzy7g3QiXMSytJQGewKx80
         x5+6RLr3/VQz9kNBUHUJg9tXrVlYlonm66PembHjBPv8hDyFCJJ3yAgIZKTgmD1UtX/M
         Nl+0kcx8Um5bDx+kwgfQNCp5+GlYJ3Y56rhDwrc4llEPizCi8jhuztpGg3A4Fl40l3Rq
         kEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536148; x=1770140948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fwO/VaNZxmao/DUt+h/EjZOeMcEorx8H8F005SZWFq4=;
        b=IsrH0f1/PzjqYx2b0qOZZLkFT03un0GDtq0slUoMtZZb7L97u6e/7m7mpYQONUpjAR
         MMuftXtbsIq3v1Eg48HvNzp7Qvqax7zVbQm9Y1jyNF6iMXNYUrYYivxBjvkjBsuOqlGM
         rLcYVcIhZ5Nfq2zC7rEXxSDM3ksFV0xvRLkfWSSrXWxzIojV6r8zvOFCawPDaUq8xjzw
         ZZS6kbEI8CfTMDCLmgZAir4q1MloccF9AVctVUqPQ2DVXtTjj0Z9+3DydpB9t76ITYCq
         3OrHGNMhYMgRCVC9UWOXDuOYCXSOdl7VfPXV8sS7jwVdLZgryFTWSk7DlmPwvLwoinL/
         56Rg==
X-Gm-Message-State: AOJu0YxG4qLdxhGXBFGHTHM6pUwzd2PSUgqvbEEstlnCbwqFgt9iwc5I
	+CV8OFg5futIGNpStDS3dozoVDcvM0uygj1eKHUIxyIfGaRztgPdUniNjKM/9QOLPIHYQj4ZIVy
	KAoo4kX7VZY1laLl6KmQc4rCyF0+As8kr6fsUaPboFvw8Xe4asxf1fWJYPu7JlP6IPdKVKNj00I
	ito3U=
X-Gm-Gg: AZuq6aK12rxEx/zwNhqtVJ58dsJixA4+/sFDpq/nElARwoxTOy7A5VpG3+ogNfSR5MN
	wsfKmC0CdNBqekaQohUNe5/3ylvzLZMZqLQMYuS98eBCKsy5bRnREejrcuRvEt+E+dLmnm4WeSX
	XdfImDkPSJ+m0sfP37KI2cKyGCKpyb30bzanE1ElryIzJG5mVMJi2Jh/iX6Chxnq7y4q+tCdU0U
	4s19czlZdygWz/0TUD4B2LL97IZNw5ZxK5sMtNrm/MuJxY7u8wiVL0Cla6pxcgWvuw8Zl41aNHZ
	Ni4OhQXX0AynlbsJ5N9R0NYjz+x8/4QdTsVyCRCVGGJDdNjrxq0BnL7PZgUj/v7gawDT9VuDWH2
	yRIshF4gGOPKdoNi0eC1hIuiQqcfavTAPu6uOtYHlQR81i1aA
X-Received: by 2002:a17:903:32cb:b0:2a7:a5d5:7850 with SMTP id d9443c01a7336-2a870dc8fe1mr25312335ad.32.1769536147843;
        Tue, 27 Jan 2026 09:49:07 -0800 (PST)
X-Received: by 2002:a17:903:32cb:b0:2a7:a5d5:7850 with SMTP id d9443c01a7336-2a870dc8fe1mr25311925ad.32.1769536147192;
        Tue, 27 Jan 2026 09:49:07 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e5fb0sm110385ad.91.2026.01.27.09.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 09:49:06 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v5 3/5] Implement the Bluetooth Ranging Profile GATT server and client support as specified by the Bluetooth SIG:
Date: Tue, 27 Jan 2026 23:18:54 +0530
Message-Id: <20260127174856.3418323-4-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127174856.3418323-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260127174856.3418323-1-prathibha.madugonde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tRp6q_8Wc4B7NvCDWOZbA4F5XLTcfX4a
X-Authority-Analysis: v=2.4 cv=JZqxbEKV c=1 sm=1 tr=0 ts=6978fa95 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=qgqm4AZpxN9jBvWLah8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: tRp6q_8Wc4B7NvCDWOZbA4F5XLTcfX4a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0NSBTYWx0ZWRfX2xAXtS4IXXzl
 1xlT2jTO/XgA9d8sKOLP9olTZ95256sTBySWu+i7bKBsvLx/Jh/YRVgRXa2oBYWy/v/b+Qa5HbR
 7kHZUClXAbhkRdo9/JPJdv4TtnM2E/lGX2+7AC1FaYYSK+rX7iBHqI2zb+M/ZbPJDTcPjfDOQVc
 1ZDCucRP3/IoT0ICEQ7pVUpSiEEkbc3ZiI1e9EIb0lW4L77aYOGj0J24Fbr9KsvyQKw3XBjQyzW
 3/wfjX5g6lk9RRoH6CvIio5wPxFeL//0lBgpkJLQuXSDYlnqhI9BU4OxVayIVX0A5BcbSSc5Sjc
 uVcUQtp1u5XMRSGk4n9R0ti3iTzy1cu8hoHzV69ZRYW5rqwSU9go+OyIGdWStnLBPqlSuNppuI4
 lErTSRtS/0PEg02E3vCzfKWQU2irTiGvH9jlh7b6C6ltTonA+7jFJve2vMbAC+332dSaz9tQ5fB
 8Q4Ne6Z9YalW0+Rg88w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270145

Add RAS service, characteristics, and descriptors to the local GATT DB
Implement server-side callbacks for RAS Features, Procedure Data,
Data Ready and Data Overwritten characteristics
Add client-side session handling, notification registration and
ready callbacks
Wire RAS attachment/detachment to ATT/GATT client and server
---
 Makefile.am      |   4 +-
 src/shared/rap.c | 748 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/rap.h |  45 +++
 3 files changed, 796 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/rap.c
 create mode 100644 src/shared/rap.h

diff --git a/Makefile.am b/Makefile.am
index 2217bcf15..cff5cc034 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -248,7 +248,9 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/bap-defs.h \
 			src/shared/asha.h src/shared/asha.c \
 			src/shared/battery.h src/shared/battery.c \
-			src/shared/uinput.h src/shared/uinput.c
+			src/shared/uinput.h src/shared/uinput.c \
+			src/shared/rap.h src/shared/rap.c
+
 
 if READLINE
 shared_sources += src/shared/shell.c src/shared/shell.h
diff --git a/src/shared/rap.c b/src/shared/rap.c
new file mode 100644
index 000000000..39ef3f278
--- /dev/null
+++ b/src/shared/rap.c
@@ -0,0 +1,748 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * BlueZ - Bluetooth protocol stack for Linux
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#define _GNU_SOURCE
+#include <inttypes.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <errno.h>
+#include <glib.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
+
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+#include "src/shared/timeout.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/rap.h"
+
+#define DBG(_rap, fmt, arg...) \
+	rap_debug(_rap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
+
+#define RAS_UUID16			0x185B
+
+/* Total number of attribute handles reserved for the RAS service */
+#define RAS_TOTAL_NUM_HANDLES		18
+
+/* Ranging Service context */
+struct ras {
+	struct bt_rap_db *rapdb;
+
+	/* Service and characteristic attributes */
+	struct gatt_db_attribute *svc;
+	struct gatt_db_attribute *feat_chrc;
+	struct gatt_db_attribute *realtime_chrc;
+	struct gatt_db_attribute *realtime_chrc_ccc;
+	struct gatt_db_attribute *ondemand_chrc;
+	struct gatt_db_attribute *cp_chrc;
+	struct gatt_db_attribute *ready_chrc;
+	struct gatt_db_attribute *overwritten_chrc;
+};
+
+struct bt_rap_db {
+	struct gatt_db *db;
+	struct ras *ras;
+};
+
+struct bt_rap {
+	int ref_count;
+	struct bt_rap_db *lrapdb;
+	struct bt_rap_db *rrapdb;
+	struct bt_gatt_client *client;
+	struct bt_att *att;
+
+	unsigned int idle_id;
+
+	struct queue *notify;
+	struct queue *pending;
+	struct queue *ready_cbs;
+
+	bt_rap_debug_func_t debug_func;
+	bt_rap_destroy_func_t debug_destroy;
+	void *debug_data;
+	void *user_data;
+};
+
+static struct queue *rap_db;
+static struct queue *bt_rap_cbs;
+static struct queue *sessions;
+
+struct bt_rap_cb {
+	unsigned int id;
+	bt_rap_func_t attached;
+	bt_rap_func_t detached;
+	void *user_data;
+};
+
+struct bt_rap_ready {
+	unsigned int id;
+	bt_rap_ready_func_t func;
+	bt_rap_destroy_func_t destroy;
+	void *data;
+};
+
+static struct ras *rap_get_ras(struct bt_rap *rap)
+{
+	if (!rap)
+		return NULL;
+
+	if (rap->rrapdb->ras)
+		return rap->rrapdb->ras;
+
+	rap->rrapdb->ras = new0(struct ras, 1);
+	rap->rrapdb->ras->rapdb = rap->rrapdb;
+
+	return rap->rrapdb->ras;
+}
+
+static void rap_detached(void *data, void *user_data)
+{
+	struct bt_rap_cb *cb = data;
+	struct bt_rap *rap = user_data;
+
+	cb->detached(rap, cb->user_data);
+}
+
+void bt_rap_detach(struct bt_rap *rap)
+{
+	if (!queue_remove(sessions, rap))
+		return;
+
+	bt_gatt_client_idle_unregister(rap->client, rap->idle_id);
+	bt_gatt_client_unref(rap->client);
+	rap->client = NULL;
+
+	queue_foreach(bt_rap_cbs, rap_detached, rap);
+}
+
+static void rap_db_free(void *data)
+{
+	struct bt_rap_db *rapdb = data;
+
+	if (!rapdb)
+		return;
+
+	gatt_db_unref(rapdb->db);
+
+	free(rapdb->ras);
+	free(rapdb);
+}
+
+static void rap_ready_free(void *data)
+{
+	struct bt_rap_ready *ready = data;
+
+	if (ready->destroy)
+		ready->destroy(ready->data);
+
+	free(ready);
+}
+
+static void rap_free(void *data)
+{
+	struct bt_rap *rap = data;
+
+	bt_rap_detach(rap);
+
+	rap_db_free(rap->rrapdb);
+
+	queue_destroy(rap->notify, free);
+	queue_destroy(rap->pending, NULL);
+	queue_destroy(rap->ready_cbs, rap_ready_free);
+
+	free(rap);
+}
+
+bool bt_rap_set_user_data(struct bt_rap *rap, void *user_data)
+{
+	if (!rap)
+		return false;
+
+	rap->user_data = user_data;
+
+	return true;
+}
+
+static bool rap_db_match(const void *data, const void *match_data)
+{
+	const struct bt_rap_db *rapdb = data;
+	const struct gatt_db *db = match_data;
+
+	return rapdb->db == db;
+}
+
+struct bt_att *bt_rap_get_att(struct bt_rap *rap)
+{
+	if (!rap)
+		return NULL;
+
+	if (rap->att)
+		return rap->att;
+
+	return bt_gatt_client_get_att(rap->client);
+}
+
+struct bt_rap *bt_rap_ref(struct bt_rap *rap)
+{
+	if (!rap)
+		return NULL;
+
+	__sync_fetch_and_add(&rap->ref_count, 1);
+
+	return rap;
+}
+
+void bt_rap_unref(struct bt_rap *rap)
+{
+	if (!rap)
+		return;
+
+	if (__sync_sub_and_fetch(&rap->ref_count, 1))
+		return;
+
+	rap_free(rap);
+}
+
+static void rap_debug(struct bt_rap *rap, const char *format, ...)
+{
+	va_list ap;
+
+	if (!rap || !format || !rap->debug_func)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(rap->debug_func, rap->debug_data, format, ap);
+	va_end(ap);
+}
+
+bool bt_rap_set_debug(struct bt_rap *rap, bt_rap_debug_func_t func,
+			void *user_data, bt_rap_destroy_func_t destroy)
+{
+	if (!rap)
+		return false;
+
+	if (rap->debug_destroy)
+		rap->debug_destroy(rap->debug_data);
+
+	rap->debug_func = func;
+	rap->debug_destroy = destroy;
+	rap->debug_data = user_data;
+
+	return true;
+}
+
+static void ras_features_read_cb(struct gatt_db_attribute *attrib,
+				 unsigned int id, uint16_t offset,
+				 uint8_t opcode, struct bt_att *att,
+				 void *user_data)
+{
+	/*
+	 * Feature mask: bits 0-2 set:
+	 *  - Real-time ranging
+	 *  - Retrieve stored results
+	 *  - Abort operation
+	 */
+	uint8_t value[4] = { 0x01, 0x00, 0x00, 0x00 };
+
+	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
+}
+
+static void ras_ondemand_read_cb(struct gatt_db_attribute *attrib,
+				 unsigned int id, uint16_t offset,
+				 uint8_t opcode, struct bt_att *att,
+				 void *user_data)
+{
+	/* No static read data – on‑demand data is pushed via
+	 * notifications
+	 */
+	gatt_db_attribute_read_result(attrib, id, 0, NULL, 0);
+}
+
+/*
+ * Control point handler.
+ * Parses the opcode and acts on queued data (implementation TBD).
+ */
+static void ras_control_point_write_cb(struct gatt_db_attribute *attrib,
+				       unsigned int id, uint16_t offset,
+				       const uint8_t *value, size_t len,
+				       uint8_t opcode, struct bt_att *att,
+				       void *user_data)
+{
+	/* Control point handler - implementation TBD */
+}
+
+/* Data Ready – returns the latest ranging counter. */
+static void ras_data_ready_read_cb(struct gatt_db_attribute *attrib,
+				   unsigned int id, uint16_t offset,
+				   uint8_t opcode, struct bt_att *att,
+				   void *user_data)
+{
+	uint16_t counter = 0;
+	uint8_t value[2];
+
+	put_le16(counter, value);
+	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
+}
+
+/* Data Overwritten – indicates how many results were overwritten. */
+static void ras_data_overwritten_read_cb(struct gatt_db_attribute *attrib,
+					 unsigned int id, uint16_t offset,
+					 uint8_t opcode, struct bt_att *att,
+					 void *user_data)
+{
+	uint8_t value[2] = { 0x00, 0x00 };
+
+	gatt_db_attribute_read_result(attrib, id, 0, value, sizeof(value));
+}
+
+/* Service registration – store attribute pointers */
+static struct ras *register_ras_service(struct gatt_db *db)
+{
+	struct ras *ras;
+	struct gatt_db_attribute *service;
+	bt_uuid_t uuid;
+
+	if (!db)
+		return NULL;
+
+	ras = new0(struct ras, 1);
+	if (!ras)
+		return NULL;
+
+	/* Primary RAS service */
+	bt_uuid16_create(&uuid, RAS_UUID16);
+	service = gatt_db_add_service(db, &uuid, true, RAS_TOTAL_NUM_HANDLES);
+	if (!service) {
+		free(ras);
+		return NULL;
+	}
+
+	ras->svc = service;
+
+	/* RAS Features */
+	bt_uuid16_create(&uuid, RAS_FEATURES_UUID);
+		ras->feat_chrc =
+		gatt_db_service_add_characteristic(ras->svc, &uuid,
+						  BT_ATT_PERM_READ |
+						  BT_ATT_PERM_READ_ENCRYPT,
+						  BT_GATT_CHRC_PROP_READ,
+						  ras_features_read_cb,
+						  NULL, ras);
+
+	/* Real-time Ranging Data */
+	bt_uuid16_create(&uuid, RAS_REALTIME_DATA_UUID);
+	ras->realtime_chrc =
+		gatt_db_service_add_characteristic(ras->svc, &uuid,
+						  BT_ATT_PERM_READ |
+						  BT_ATT_PERM_READ_ENCRYPT,
+						  BT_GATT_CHRC_PROP_NOTIFY |
+						  BT_GATT_CHRC_PROP_INDICATE,
+						  NULL, NULL, ras);
+
+	ras->realtime_chrc_ccc =
+		gatt_db_service_add_ccc(ras->svc,
+					BT_ATT_PERM_READ |
+					BT_ATT_PERM_WRITE);
+
+	/* On-demand Ranging Data */
+	bt_uuid16_create(&uuid, RAS_ONDEMAND_DATA_UUID);
+	ras->ondemand_chrc =
+		gatt_db_service_add_characteristic(ras->svc, &uuid,
+						  BT_ATT_PERM_READ |
+						  BT_ATT_PERM_READ_ENCRYPT,
+						  BT_GATT_CHRC_PROP_NOTIFY |
+						  BT_GATT_CHRC_PROP_INDICATE,
+						  ras_ondemand_read_cb, NULL,
+						  ras);
+
+	gatt_db_service_add_ccc(ras->svc,
+				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	/* RAS Control Point */
+	bt_uuid16_create(&uuid, RAS_CONTROL_POINT_UUID);
+	ras->cp_chrc =
+		gatt_db_service_add_characteristic(ras->svc, &uuid,
+						  BT_ATT_PERM_WRITE |
+						  BT_ATT_PERM_WRITE_ENCRYPT,
+				BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP |
+						  BT_GATT_CHRC_PROP_INDICATE,
+						  NULL,
+						  ras_control_point_write_cb,
+						  ras);
+
+	gatt_db_service_add_ccc(ras->svc,
+				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	/* RAS Data Ready */
+	bt_uuid16_create(&uuid, RAS_DATA_READY_UUID);
+	ras->ready_chrc =
+		gatt_db_service_add_characteristic(ras->svc, &uuid,
+						  BT_ATT_PERM_READ |
+						  BT_ATT_PERM_READ_ENCRYPT,
+						  BT_GATT_CHRC_PROP_READ |
+						  BT_GATT_CHRC_PROP_NOTIFY |
+						  BT_GATT_CHRC_PROP_INDICATE,
+						  ras_data_ready_read_cb, NULL,
+						  ras);
+
+	gatt_db_service_add_ccc(ras->svc,
+				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	/* RAS Data Overwritten */
+	bt_uuid16_create(&uuid, RAS_DATA_OVERWRITTEN_UUID);
+	ras->overwritten_chrc =
+		gatt_db_service_add_characteristic(ras->svc, &uuid,
+						  BT_ATT_PERM_READ |
+						  BT_ATT_PERM_READ_ENCRYPT,
+						  BT_GATT_CHRC_PROP_READ |
+						  BT_GATT_CHRC_PROP_NOTIFY |
+						  BT_GATT_CHRC_PROP_INDICATE,
+						  ras_data_overwritten_read_cb,
+						  NULL, ras);
+
+	gatt_db_service_add_ccc(ras->svc,
+				BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	/* Activate the service */
+	gatt_db_service_set_active(ras->svc, true);
+
+	return ras;
+}
+
+static struct bt_rap_db *rap_db_new(struct gatt_db *db)
+{
+	struct bt_rap_db *rapdb;
+
+	if (!db)
+		return NULL;
+
+	rapdb = new0(struct bt_rap_db, 1);
+	if (!rapdb)
+		return NULL;
+
+	rapdb->db = gatt_db_ref(db);
+
+	if (!rap_db)
+		rap_db = queue_new();
+
+	rapdb->ras = register_ras_service(db);
+	if (rapdb->ras)
+		rapdb->ras->rapdb = rapdb;
+
+	queue_push_tail(rap_db, rapdb);
+
+	return rapdb;
+}
+
+static struct bt_rap_db *rap_get_db(struct gatt_db *db)
+{
+	struct bt_rap_db *rapdb;
+
+	rapdb = queue_find(rap_db, rap_db_match, db);
+	if (rapdb)
+		return rapdb;
+
+	return rap_db_new(db);
+}
+
+void bt_rap_add_db(struct gatt_db *db)
+{
+	rap_db_new(db);
+}
+
+unsigned int bt_rap_register(bt_rap_func_t attached, bt_rap_func_t detached,
+			     void *user_data)
+{
+	struct bt_rap_cb *cb;
+	static unsigned int id;
+
+	if (!attached && !detached)
+		return 0;
+
+	if (!bt_rap_cbs)
+		bt_rap_cbs = queue_new();
+
+	cb = new0(struct bt_rap_cb, 1);
+	cb->id = ++id ? id : ++id;
+	cb->attached = attached;
+	cb->detached = detached;
+	cb->user_data = user_data;
+
+	queue_push_tail(bt_rap_cbs, cb);
+
+	return cb->id;
+}
+
+static bool match_id(const void *data, const void *match_data)
+{
+	const struct bt_rap_cb *cb = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return cb->id == id;
+}
+
+bool bt_rap_unregister(unsigned int id)
+{
+	struct bt_rap_cb *cb;
+
+	cb = queue_remove_if(bt_rap_cbs, match_id, UINT_TO_PTR(id));
+	if (!cb)
+		return false;
+
+	free(cb);
+
+	return true;
+}
+
+struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb)
+{
+	struct bt_rap *rap;
+	struct bt_rap_db *rapdb;
+
+	if (!ldb)
+		return NULL;
+
+	rapdb = rap_get_db(ldb);
+	if (!rapdb)
+		return NULL;
+
+	rap = new0(struct bt_rap, 1);
+	rap->lrapdb = rapdb;
+	rap->pending = queue_new();
+	rap->ready_cbs = queue_new();
+	rap->notify = queue_new();
+
+	if (!rdb)
+		goto done;
+
+	rapdb = new0(struct bt_rap_db, 1);
+	rapdb->db = gatt_db_ref(rdb);
+
+	rap->rrapdb = rapdb;
+
+done:
+	bt_rap_ref(rap);
+
+	return rap;
+}
+
+static void foreach_rap_char(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_rap *rap = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid;
+	bt_uuid_t uuid_features;
+	bt_uuid_t uuid_realtime;
+	bt_uuid_t uuid_ondemand;
+	bt_uuid_t uuid_cp;
+	bt_uuid_t uuid_dataready;
+	bt_uuid_t uuid_overwritten;
+	struct ras *ras;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
+					     NULL, NULL, &uuid))
+		return;
+
+	bt_uuid16_create(&uuid_features, RAS_FEATURES_UUID);
+	bt_uuid16_create(&uuid_realtime, RAS_REALTIME_DATA_UUID);
+	bt_uuid16_create(&uuid_ondemand, RAS_ONDEMAND_DATA_UUID);
+	bt_uuid16_create(&uuid_cp, RAS_CONTROL_POINT_UUID);
+	bt_uuid16_create(&uuid_dataready, RAS_DATA_READY_UUID);
+	bt_uuid16_create(&uuid_overwritten, RAS_DATA_OVERWRITTEN_UUID);
+
+	if (!bt_uuid_cmp(&uuid, &uuid_features)) {
+		DBG(rap, "Features characteristic found: handle 0x%04x",
+		    value_handle);
+
+		ras = rap_get_ras(rap);
+		if (!ras || ras->feat_chrc)
+			return;
+
+		ras->feat_chrc = attr;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_realtime)) {
+		DBG(rap, "Real Time Data characteristic found: handle 0x%04x",
+		    value_handle);
+
+		ras = rap_get_ras(rap);
+		if (!ras || ras->realtime_chrc)
+			return;
+
+		ras->realtime_chrc = attr;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_ondemand)) {
+		DBG(rap, "On-demand Data characteristic found: handle 0x%04x",
+		    value_handle);
+
+		ras = rap_get_ras(rap);
+		if (!ras || ras->ondemand_chrc)
+			return;
+
+		ras->ondemand_chrc = attr;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_cp)) {
+		DBG(rap, "Control Point characteristic found: handle 0x%04x",
+		    value_handle);
+
+		ras = rap_get_ras(rap);
+		if (!ras || ras->cp_chrc)
+			return;
+
+		ras->cp_chrc = attr;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_dataready)) {
+		DBG(rap, "Data Ready characteristic found: handle 0x%04x",
+		    value_handle);
+
+		ras = rap_get_ras(rap);
+		if (!ras || ras->ready_chrc)
+			return;
+
+		ras->ready_chrc = attr;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_overwritten)) {
+		DBG(rap, "Overwritten characteristic found: handle 0x%04x",
+		    value_handle);
+
+		ras = rap_get_ras(rap);
+		if (!ras || ras->overwritten_chrc)
+			return;
+
+		ras->overwritten_chrc = attr;
+	}
+}
+
+static void foreach_rap_service(struct gatt_db_attribute *attr,
+				void *user_data)
+{
+	struct bt_rap *rap = user_data;
+	struct ras *ras = rap_get_ras(rap);
+
+	ras->svc = attr;
+
+	gatt_db_service_set_claimed(attr, true);
+
+	gatt_db_service_foreach_char(attr, foreach_rap_char, rap);
+}
+
+unsigned int bt_rap_ready_register(struct bt_rap *rap,
+				   bt_rap_ready_func_t func, void *user_data,
+				   bt_rap_destroy_func_t destroy)
+{
+	struct bt_rap_ready *ready;
+	static unsigned int id;
+
+	if (!rap)
+		return 0;
+
+	DBG(rap, "bt_rap_ready_register");
+
+	ready = new0(struct bt_rap_ready, 1);
+	ready->id = ++id ? id : ++id;
+	ready->func = func;
+	ready->destroy = destroy;
+	ready->data = user_data;
+
+	queue_push_tail(rap->ready_cbs, ready);
+
+	return ready->id;
+}
+
+static bool match_ready_id(const void *data, const void *match_data)
+{
+	const struct bt_rap_ready *ready = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return ready->id == id;
+}
+
+bool bt_rap_ready_unregister(struct bt_rap *rap, unsigned int id)
+{
+	struct bt_rap_ready *ready;
+
+	ready = queue_remove_if(rap->ready_cbs, match_ready_id,
+				UINT_TO_PTR(id));
+	if (!ready)
+		return false;
+
+	rap_ready_free(ready);
+
+	return true;
+}
+
+static struct bt_rap *bt_rap_ref_safe(struct bt_rap *rap)
+{
+	if (!rap || !rap->ref_count)
+		return NULL;
+
+	return bt_rap_ref(rap);
+}
+
+static void rap_notify_ready(struct bt_rap *rap)
+{
+	const struct queue_entry *entry;
+
+	if (!bt_rap_ref_safe(rap))
+		return;
+
+	for (entry = queue_get_entries(rap->ready_cbs); entry;
+	     entry = entry->next) {
+		struct bt_rap_ready *ready = entry->data;
+
+		ready->func(rap, ready->data);
+	}
+
+	bt_rap_unref(rap);
+}
+
+static void rap_idle(void *data)
+{
+	struct bt_rap *rap = data;
+
+	rap->idle_id = 0;
+	rap_notify_ready(rap);
+}
+
+bool bt_rap_attach(struct bt_rap *rap, struct bt_gatt_client *client)
+{
+	bt_uuid_t uuid;
+
+	if (!sessions)
+		sessions = queue_new();
+
+	queue_push_tail(sessions, rap);
+
+	if (!client)
+		return true;
+
+	if (rap->client)
+		return false;
+
+	rap->client = bt_gatt_client_clone(client);
+	if (!rap->client)
+		return false;
+
+	bt_gatt_client_idle_register(rap->client, rap_idle, rap, NULL);
+
+	bt_uuid16_create(&uuid, RAS_UUID16);
+
+	gatt_db_foreach_service(rap->lrapdb->db, &uuid,
+				foreach_rap_service, rap);
+
+	return true;
+}
diff --git a/src/shared/rap.h b/src/shared/rap.h
new file mode 100644
index 000000000..a1d1ff2ae
--- /dev/null
+++ b/src/shared/rap.h
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * BlueZ - Bluetooth protocol stack for Linux
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <stdbool.h>
+#include <inttypes.h>
+
+#include "src/shared/io.h"
+
+struct bt_rap;
+
+typedef void (*bt_rap_debug_func_t)(const char *str, void *user_data);
+typedef void (*bt_rap_ready_func_t)(struct bt_rap *rap, void *user_data);
+typedef void (*bt_rap_destroy_func_t)(void *user_data);
+typedef void (*bt_rap_func_t)(struct bt_rap *rap, void *user_data);
+
+struct bt_rap *bt_rap_ref(struct bt_rap *rap);
+void bt_rap_unref(struct bt_rap *rap);
+
+void bt_rap_add_db(struct gatt_db *db);
+
+bool bt_rap_attach(struct bt_rap *rap, struct bt_gatt_client *client);
+void bt_rap_detach(struct bt_rap *rap);
+
+struct bt_att *bt_rap_get_att(struct bt_rap *rap);
+
+bool bt_rap_set_user_data(struct bt_rap *rap, void *user_data);
+
+bool bt_rap_set_debug(struct bt_rap *rap, bt_rap_debug_func_t func,
+			void *user_data, bt_rap_destroy_func_t destroy);
+
+/* session related functions */
+unsigned int bt_rap_register(bt_rap_func_t attached, bt_rap_func_t detached,
+					void *user_data);
+unsigned int bt_rap_ready_register(struct bt_rap *rap,
+				bt_rap_ready_func_t func, void *user_data,
+				bt_rap_destroy_func_t destroy);
+bool bt_rap_ready_unregister(struct bt_rap *rap, unsigned int id);
+
+bool bt_rap_unregister(unsigned int id);
+
+struct bt_rap *bt_rap_new(struct gatt_db *ldb, struct gatt_db *rdb);
-- 
2.34.1


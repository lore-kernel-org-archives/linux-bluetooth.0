Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07535CB94
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529307; cv=none; b=jWs18DcOIHav/yX9AeQlBi8h8ms9o5PavvNhhYCLWHmScJDsWYOBtPjCFrfXgsQalD/7UoYr7KD+bG0wLcHQiffVkI0+KjwLFvV8+5+eMd5x6g3E1SOFzkTAWkN2HgPgacFiKMQEfmU3LrLMrLea+IySJjW5PIdKycqgTS6RrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529307; c=relaxed/simple;
	bh=rFCR0Q6otfvwEBlBjjjCIfPZccmRBswYZ/Eg//06Hww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idzSN+2TGLoPDNHJmoRY6H+VmX6I3HYobJ2szlYvy6+hrlaOBEDnns/2g/oY9Ncxl8y4rZ25+N50Hh9rmWxTUzcmGDV6+Sb5KvLSErDpKusl+IUwtkzZ3MCqLyR21Zw8jv1Dq7aBjiZTZehIsY6eUu5qaNh1U5HZUccNYWYx22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZCN30lXK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WZn5kExj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZCN30lXK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WZn5kExj"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBxgHv672239
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kfpKO+HFErr
	iKHGT2sfgfy0u+jiz5RvL6w5yDANUxdc=; b=ZCN30lXKTstl4XrDQz4Omuhqu6i
	yEtRa6M0+6p5ffvN6jfcs24omJpKqtF5+ZRbloxLFsHA+tRS2aP9D2UpdgiyGSRM
	JYtgvgSAQW2FtFWy8V3k7HVb7zlw8zFZUPPmJ9gAHmGSTo5YLFh8aNchRoMbj2n5
	ih65hB9UW1RCF4EGa0wfJeQ4liysMqI2anady1egSSKJZN9gOMrVxtVF9imUU3+B
	qxU0fsK9m8vhBLpx5lI5KRQl+Pvn1UtqoS+nR2Gds4oYS8b0Ojx/fgoa364FgXf4
	cZy7ZuTWDJYVJDf1+TKGwwug5gny6JpHMk1mzNebg+wNORRY+Hu1DMMwwPA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxffs39xq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:55:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso16072981a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769529303; x=1770134103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfpKO+HFErriKHGT2sfgfy0u+jiz5RvL6w5yDANUxdc=;
        b=WZn5kExjHOA+5A2XDF6nCpVZWRp0BjYalJjdRtRDlGFaRQHi9Kwxle0x5lP1F58zUf
         aRP7/7BrJkwMRHHXzlQ/27iRui616tkpZuRxRTr1ye2t485IUzhVOaESUY3q7ZWS4w4c
         6tlFO3xr7oRuHnB8pcREtkyTRJLLsGGJ7GiX74JDQ/Wi6/i1I8AfOSoTL5/R0tYgSLOE
         H+gDdCimjdEwQsB+lDO4yyXWwZidMbc4RooVAVXHyZq1iFuEJ11iX3Lb0FZldKgW+KZ1
         9AkuE9fFeqVDmQXer09mbAeh9/URGsi7RENM3u7fzNQ+0CvSB8p1No/tYMYCKHOeubDl
         aRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529303; x=1770134103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kfpKO+HFErriKHGT2sfgfy0u+jiz5RvL6w5yDANUxdc=;
        b=G5XEEm9PRHErmOVa0+4zB2Uqjhq2so/XLjXTLFpvKaT40f+vEupc6TKGQDMZF/CxsH
         Z3NlkQRzcZ9yX2HUoH/6KyE/To/3zQO6z8k3oVktXTANe9N/nCVuSIVZNGBhRGPPmAY+
         w85oQe6uviF/pUbdX8vWCYi2heW/wxL/jdQAvhRgiCQRpSB2qK2KVJ8rOj7+MJgQElLy
         nA10OxQFz9meDFLode2nasfVnw8+WusQys8WnsZg6yG1B/FjDYOjBKwPCgzw81N+YzxV
         AmOEIh1rOCnmznfwaGBsi9VQgG8yJdh5TgKCmwwWbCUzI2tV/9Tb91uB6z1/Hl5ls321
         czQw==
X-Gm-Message-State: AOJu0YxZfkpKuGNm7jQrVD6CJZ0T8l8XJUqQepTDzhk1Tc+F36r7iy5/
	vWsnNGU+jlQ9FKu00Y6zjkVIQy2VdS5+TsaGZGRskMAlpnQxFHkBB+ZJcSBZ/xzvPR1v5PnANKR
	j2xbQp9XYPHoRXyrVEsd1uV2yC98HamQmNu+tdgIHNSn5pv0oIMwihab5i/TCdKEnxgz5EbWUAS
	+5m5M=
X-Gm-Gg: AZuq6aJVtq8Ol5l1RHIfqhonhiSx8NVPu1GFIr4kokx3KR5vvBNnBOv0DC2lHM3CYRe
	04xwiBamyTMKm0BZplxJtpO/W9asljlIWf6QQJzCTqSaBPM8vlAsKCfM/YVr/WR8G2WKdcMNcoT
	LCAAShRSR8Ii3IR9Uy/ivurcabR3+ZBTupJyB/IXm0WTEFFeQuxmsewIqglRXS0CA9Jz3pwNsoe
	CDsyPgUivsdyQCKPafRHqknKFXSKQA5zb/LY/PO5VOkFyyrby1fphhpthXYIAygXADAS5IoylH3
	QWStQmiMKhFE/t5K1xvnwen1yBjBifmuO1CLNHKC9E9fBI/q1eDQMEFJ1F4Cm605zDN9mTdbtwC
	6R1DYPgnDmULNJ8/5NTiS5RzqEAktmQLCRhQh54FyAN6Dzjri
X-Received: by 2002:a17:902:ceca:b0:2a0:b066:3f55 with SMTP id d9443c01a7336-2a870d32ee4mr22564815ad.10.1769529302358;
        Tue, 27 Jan 2026 07:55:02 -0800 (PST)
X-Received: by 2002:a17:902:ceca:b0:2a0:b066:3f55 with SMTP id d9443c01a7336-2a870d32ee4mr22564545ad.10.1769529301697;
        Tue, 27 Jan 2026 07:55:01 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa719sm123292855ad.14.2026.01.27.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:55:01 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v4 4/5] unit: Add test cases for Ranging Profile (RAP)
Date: Tue, 27 Jan 2026 21:24:46 +0530
Message-Id: <20260127155447.3324706-5-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127155447.3324706-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260127155447.3324706-1-prathibha.madugonde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8UHRwHKMLVimN8MSVitkmyaLS2ZezPOL
X-Authority-Analysis: v=2.4 cv=YpcChoYX c=1 sm=1 tr=0 ts=6978dfd7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XA3xTWKml79YH-AOntAA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 8UHRwHKMLVimN8MSVitkmyaLS2ZezPOL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMCBTYWx0ZWRfX+UAQ1yjoU1Gd
 hOOZtkArkCHtSceHN1TF7j4cwcyAuSE9WyACljsrbqdmu48ivjHNCbNWvI9O0I/pxorYsrCxOAT
 cxNhRkHJc5zOolHF9oqvvTLMLKhX4M16vpaNfbYPxLgmob03yfNFe8Pt/reQWsEtBrJG/sbQWio
 lhat9a9dBkZQnIr8n+oKZTQjkhBTXChCf584Un06Co50IAZWQd2TQaGhza3qpE5Q/es06qL8tCK
 lYUmnbjoTvC+OjN06IiuG+9QpfC95WUvWl1NSvEcso6OcWDA+5eJYtwzo92SJW3r3nfrcxYqIdB
 xvKko2DMKSg8Mp5KUM9cbs88u838sJ8pPAJ83oNRUsr4qxM58LwKshVf4fV8c76DwrdKct7ds/0
 iym4o25Ohis6OSnKl2iy3Lo+gh2B+7M7UY4Vk7UnBpKiz0P0adKI2YhUtOFv6/hqr/3kyenCjCK
 qR3oBQ2903baVaZu2/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270130

This adds unit test cases for the Ranging Profile (RAP) 
implementation, specifically testing the Ranging Service (RAS) server
 functionality.

The test suite includes:
- RAS/SR/SGGIT/SER/BV-01-C: Service discovery test
- RAS/SR/SGGIT/CHA/BV-01-C: Characteristic GGIT -RAS Features
- RAS/SR/SGGIT/CHA/BV-02-C: Characteristic GGIT -Real-time Ranging Data
- RAS/SR/SGGIT/CHA/BV-03-C: Characteristic GGIT -On-demand Ranging Data
- RAS/SR/SGGIT/CHA/BV-04-C: Characteristic GGIT -RAS Control Point

These tests verify GATT server behavior for the Ranging Service,
including service discovery, characteristic discovery.

---
 Makefile.am     |   6 +
 unit/test-rap.c | 458 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 464 insertions(+)
 create mode 100644 unit/test-rap.c

diff --git a/Makefile.am b/Makefile.am
index cff5cc034..1f73a4fa0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -757,6 +757,12 @@ unit_test_battery_SOURCES = unit/test-battery.c
 unit_test_battery_LDADD = src/libshared-glib.la \
 				lib/libbluetooth-internal.la $(GLIB_LIBS)
 
+unit_tests += unit/test-rap
+
+unit_test_rap_SOURCES = unit/test-rap.c $(btio_sources)
+unit_test_rap_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la $(GLIB_LIBS)
+
 if MIDI
 unit_tests += unit/test-midi
 unit_test_midi_CPPFLAGS = $(AM_CPPFLAGS) $(ALSA_CFLAGS) -DMIDI_TEST
diff --git a/unit/test-rap.c b/unit/test-rap.c
new file mode 100644
index 000000000..843c5f409
--- /dev/null
+++ b/unit/test-rap.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * BlueZ - Bluetooth protocol stack for Linux
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <fcntl.h>
+
+
+#include <glib.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
+#include "src/shared/util.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/rap.h"
+
+struct test_data_ras {
+	struct gatt_db *db;
+	struct bt_gatt_server *server;
+	struct bt_gatt_client *client;
+	struct queue *ccc_states;
+	size_t iovcnt;
+	struct iovec *iov;
+	unsigned int ras_id;
+};
+
+struct test_data_rap {
+	struct gatt_db *db;
+	struct bt_rap *rap;
+	struct bt_gatt_client *client;
+	size_t iovcnt;
+	struct iovec *iov;
+};
+
+struct ccc_state {
+	uint16_t handle;
+	uint16_t value;
+};
+
+struct notify {
+	uint16_t handle, ccc_handle;
+	uint8_t *value;
+	uint16_t len;
+	bt_gatt_server_conf_func_t conf;
+	void *user_data;
+};
+
+#define RAP_GATT_CLIENT_MTU	64
+
+#define iov_data(args...) ((const struct iovec[]) { args })
+
+#define define_test_ras(name, function, args...)		\
+	do {							\
+		const struct iovec iov[] = { args };		\
+		static struct test_data_ras data;			\
+		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
+		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
+		tester_add(name, &data, NULL, function,	\
+				test_teardown_ras);			\
+	} while (0)
+
+static void print_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	if (tester_use_debug())
+		tester_debug("%s%s", prefix, str);
+}
+
+static void test_teardown_ras(const void *user_data)
+{
+	struct test_data_ras *data = (void *)user_data;
+
+	bt_gatt_server_unref(data->server);
+	util_iov_free(data->iov, data->iovcnt);
+	gatt_db_unref(data->db);
+	bt_rap_unregister(data->ras_id);
+
+	queue_destroy(data->ccc_states, free);
+
+	tester_teardown_complete();
+}
+
+static void test_teardown_rap(const void *user_data)
+{
+	struct test_data_rap *data = (void *)user_data;
+
+	bt_rap_unref(data->rap);
+	bt_gatt_client_unref(data->client);
+	util_iov_free(data->iov, data->iovcnt);
+	gatt_db_unref(data->db);
+
+	tester_teardown_complete();
+}
+
+static void test_complete_cb(const void *user_data)
+{
+	tester_test_passed();
+}
+
+static bool ccc_state_match(const void *a, const void *b)
+{
+	const struct ccc_state *ccc = a;
+	uint16_t handle = PTR_TO_UINT(b);
+
+	return ccc->handle == handle;
+}
+
+static struct ccc_state *find_ccc_state(struct test_data_ras *data,
+			uint16_t handle)
+{
+	return queue_find(data->ccc_states, ccc_state_match,
+				UINT_TO_PTR(handle));
+}
+
+static struct ccc_state *get_ccc_state(struct test_data_ras *data,
+			uint16_t handle)
+{
+	struct ccc_state *ccc;
+
+	ccc = find_ccc_state(data, handle);
+	if (ccc)
+		return ccc;
+
+	ccc = new0(struct ccc_state, 1);
+	ccc->handle = handle;
+	queue_push_tail(data->ccc_states, ccc);
+
+	return ccc;
+}
+
+static void gatt_notify_cb(struct gatt_db_attribute *attrib,
+					struct gatt_db_attribute *ccc,
+					const uint8_t *value, size_t len,
+					struct bt_att *att, void *user_data)
+{
+	struct test_data_ras *data = user_data;
+	struct notify notify;
+
+	memset(&notify, 0, sizeof(notify));
+
+	notify.handle = gatt_db_attribute_get_handle(attrib);
+	notify.ccc_handle = gatt_db_attribute_get_handle(ccc);
+	notify.value = (void *) value;
+	notify.len = len;
+
+	printf("%s: notify.value:%d notify->len:%d\n", __func__,
+		(int)*(notify.value), notify.len);
+	if (!bt_gatt_server_send_notification(data->server,
+			notify.handle, notify.value,
+			notify.len, false))
+		printf("%s: Failed to send notification\n", __func__);
+}
+
+static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct test_data_ras *data = user_data;
+	struct ccc_state *ccc;
+	uint16_t handle;
+	uint8_t ecode = 0;
+	const uint8_t *value = NULL;
+	size_t len = 0;
+
+	handle = gatt_db_attribute_get_handle(attrib);
+
+	ccc = get_ccc_state(data, handle);
+	if (!ccc) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto done;
+	}
+
+	len = sizeof(ccc->value);
+	value = (void *) &ccc->value;
+
+done:
+	gatt_db_attribute_read_result(attrib, id, ecode, value, len);
+}
+
+static void ras_attached(struct bt_rap *rap, void *user_data)
+{
+}
+
+static void ras_detached(struct bt_rap *rap, void *user_data)
+{
+	bt_rap_unref(rap);
+}
+
+static void test_server(const void *user_data)
+{
+	struct test_data_ras *data = (void *)user_data;
+	struct bt_att *att;
+	struct io *io;
+
+	io = tester_setup_io(data->iov, data->iovcnt);
+	g_assert(io);
+
+	tester_io_set_complete_func(test_complete_cb);
+
+	att = bt_att_new(io_get_fd(io), false);
+	g_assert(att);
+
+	bt_att_set_debug(att, BT_ATT_DEBUG, print_debug, "bt_att:", NULL);
+
+	data->db = gatt_db_new();
+	g_assert(data->db);
+
+	gatt_db_ccc_register(data->db, gatt_ccc_read_cb, NULL,
+					gatt_notify_cb, data);
+
+	bt_rap_add_db(data->db);
+
+	data->ras_id = bt_rap_register(ras_attached, ras_detached, NULL);
+
+	data->server = bt_gatt_server_new(data->db, att, 64, 0);
+	g_assert(data->server);
+
+	bt_gatt_server_set_debug(data->server, print_debug, "bt_gatt_server:",
+					NULL);
+
+	data->ccc_states = queue_new();
+
+	tester_io_send();
+
+	bt_att_unref(att);
+}
+
+/*
+ *  ATT: Exchange MTU Request (0x02) len 2
+ *       Client RX MTU: 64
+ *
+ *  ATT: Exchange MTU Response (0x03) len 2
+ *        Server RX MTU: 64
+ */
+#define ATT_EXCHANGE_MTU	IOV_DATA(0x02, 0x40, 0x00), \
+	IOV_DATA(0x03, 0x40, 0x00)
+
+/*
+ *  ATT: Read By Group Type Request (0x10) len 6
+ *       Handle range: 0x0001-0xffff
+ *       Attribute group type: Primary Service (0x2800)
+ *
+ *  ATT: Read By Group Type Response (0x11) len 7
+ *       Attribute data length: 6
+ *       Attribute group list: 1 entry
+ *       Handle range: 0x0001-0x0012
+ *       UUID: Ranging Service (0x185b)
+ *
+ *  ATT: Read By Group Type Request (0x10) len 6
+ *      Handle range: 0x0013-0xffff
+ *      Attribute group type: Primary Service (0x2800)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *      Read By Group Type Request (0x10)
+ *      Handle: 0x0013
+ *      Error: Attribute Not Found (0x0a)
+ */
+#define DISCOVER_PRIM_SERV_NOTIF \
+	IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28), \
+	IOV_DATA(0x11, 0x06, 0x01, 0x00, 0x12, 0x00, 0x5b, 0x18), \
+	IOV_DATA(0x10, 0x13, 0x00, 0xff, 0xff, 0x00, 0x28), \
+	IOV_DATA(0x01, 0x10, 0x13, 0x00, 0x0a)
+
+/*
+ *  ATT: Find By Type Value Request (0x06) len 8
+ *       Handle range: 0x0001-0xffff
+ *       Attribute type: Primary Service (0x2800)
+ *       UUID: Ranging Service (0x185b)
+ *
+ *  ATT: Find By Type Value Response (0x07) len 4
+ *       Handle range: 0x0001-0x0012
+ *
+ *  ATT: Find By Type Value Request (0x06) len 8
+ *       Handle range: 0x0013-0xffff
+ *       Attribute type: Primary Service (0x2800)
+ *       UUID: Ranging Service (0x185b)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Find By Type Value Request (0x06)
+ *       Handle: 0x0013
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define RAS_FIND_BY_TYPE_VALUE \
+	IOV_DATA(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x5b, 0x18), \
+	IOV_DATA(0x07, 0x01, 0x00, 0x12, 0x00), \
+	IOV_DATA(0x06, 0x13, 0x00, 0xff, 0xff, 0x00, 0x28, 0x5b, 0x18), \
+	IOV_DATA(0x01, 0x06, 0x13, 0x00, 0x0a)
+
+/*
+ *  ATT: Read By Type Request (0x08) len 6
+ *       Handle range: 0x0001-0x0012
+ *       Attribute type: Characteristic (0x2803)
+ *
+ *  ATT: Read By Type Response (0x09) len 44
+ *       Attribute data length: 7
+ *       Attribute data list: 6 entries
+ *       Handle: 0x0002 - RAS Features
+ *       Value: 020003142c
+ *       Handle: 0x0004 - Real-time Ranging Data
+ *       Value: 300005152c
+ *       Handle: 0x0007 - On-demand Ranging Data
+ *       Value: 300008162c
+ *       Handle: 0x000a - RAS Control Point
+ *       Value: 24000b172c
+ *       Handle: 0x000d - RAS Data Ready
+ *       Value: 32000e182c
+ *       Handle: 0x0010 - RAS Data Overwritten
+ *       Value: 320011192c
+ *
+ *  ATT: Read By Type Request (0x08) len 6
+ *       Handle range: 0x0011-0x0012
+ *       Attribute type: Characteristic (0x2803)
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Read By Type Request (0x08)
+ *       Handle: 0x0011
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define DISC_RAS_CHAR_AFTER_TYPE \
+	IOV_DATA(0x08, 0x01, 0x00, 0x12, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x09, 0x07, \
+		0x02, 0x00, 0x02, 0x03, 0x00, 0x14, 0x2c, \
+		0x04, 0x00, 0x30, 0x05, 0x00, 0x15, 0x2c, \
+		0x07, 0x00, 0x30, 0x08, 0x00, 0x16, 0x2c, \
+		0x0a, 0x00, 0x24, 0x0b, 0x00, 0x17, 0x2c, \
+		0x0d, 0x00, 0x32, 0x0e, 0x00, 0x18, 0x2c, \
+		0x10, 0x00, 0x32, 0x11, 0x00, 0x19, 0x2c), \
+	IOV_DATA(0x08, 0x11, 0x00, 0x12, 0x00, 0x03, 0x28), \
+	IOV_DATA(0x01, 0x08, 0x11, 0x00, 0x0a)
+
+/*
+ *  ATT: Find Information Request (0x04) len 4
+ *       Handle range: 0x0006-0x0012
+ *
+ *  ATT: Find Information Response (0x05) len 53
+ *       Format: UUID-16 (0x01)
+ *       Handle: 0x0006
+ *       UUID: Client Characteristic Configuration (0x2902)
+ *       Handle: 0x0007
+ *       UUID: Characteristic (0x2803)
+ *       Handle: 0x0008
+ *       UUID: On-demand Ranging Data (0x2c16)
+ *       Handle: 0x0009
+ *       UUID: Client Characteristic Configuration (0x2902)
+ *       Handle: 0x000a
+ *       UUID: Characteristic (0x2803)
+ *       Handle: 0x000b
+ *       UUID: RAS Control Point (0x2c17)
+ *       Handle: 0x000c
+ *       UUID: Client Characteristic Configuration (0x2902)
+ *       Handle: 0x000d
+ *       UUID: Characteristic (0x2803)
+ *       Handle: 0x000e
+ *       UUID: RAS Data Ready (0x2c18)
+ *       Handle: 0x000f
+ *       UUID: Client Characteristic Configuration (0x2902)
+ *       Handle: 0x0010
+ *       UUID: Characteristic (0x2803)
+ *       Handle: 0x0011
+ *       UUID: RAS Data Overwritten (0x2c19)
+ *       Handle: 0x0012
+ *       UUID: Client Characteristic Configuration (0x2902)
+ *
+ *  ATT: Find Information Request (0x04) len 4
+ *       Handle range: 0x0013-0x0013
+ *
+ *  ATT: Error Response (0x01) len 4
+ *       Find Information Request (0x04)
+ *       Handle: 0x0013
+ *       Error: Attribute Not Found (0x0a)
+ */
+#define RAS_FIND_INFO \
+	IOV_DATA(0x04, 0x06, 0x00, 0x12, 0x00), \
+	IOV_DATA(0x05, 0x01, \
+		0x06, 0x00, 0x02, 0x29, \
+		0x07, 0x00, 0x03, 0x28, \
+		0x08, 0x00, 0x16, 0x2c, \
+		0x09, 0x00, 0x02, 0x29, \
+		0x0a, 0x00, 0x03, 0x28, \
+		0x0b, 0x00, 0x17, 0x2c, \
+		0x0c, 0x00, 0x02, 0x29, \
+		0x0d, 0x00, 0x03, 0x28, \
+		0x0e, 0x00, 0x18, 0x2c, \
+		0x0f, 0x00, 0x02, 0x29, \
+		0x10, 0x00, 0x03, 0x28, \
+		0x11, 0x00, 0x19, 0x2c, \
+		0x12, 0x00, 0x02, 0x29), \
+	IOV_DATA(0x04, 0x13, 0x00, 0x13, 0x00), \
+	IOV_DATA(0x01, 0x04, 0x13, 0x00, 0x0a)
+
+
+#define RAS_SR_SGGIT_SER_BV_01_C \
+	ATT_EXCHANGE_MTU, \
+	DISCOVER_PRIM_SERV_NOTIF, \
+	RAS_FIND_BY_TYPE_VALUE
+
+#define RAS_SR_SGGIT_CHA_BV_01_C \
+	ATT_EXCHANGE_MTU, \
+	DISCOVER_PRIM_SERV_NOTIF, \
+	RAS_FIND_BY_TYPE_VALUE, \
+	DISC_RAS_CHAR_AFTER_TYPE
+
+#define RAS_SR_SGGIT_CHA_BV_02_C \
+	ATT_EXCHANGE_MTU, \
+	DISCOVER_PRIM_SERV_NOTIF, \
+	RAS_FIND_BY_TYPE_VALUE, \
+	DISC_RAS_CHAR_AFTER_TYPE, \
+	RAS_FIND_INFO
+
+#define RAS_SR_SGGIT_CHA_BV_03_C \
+	ATT_EXCHANGE_MTU, \
+	DISCOVER_PRIM_SERV_NOTIF, \
+	RAS_FIND_BY_TYPE_VALUE, \
+	DISC_RAS_CHAR_AFTER_TYPE, \
+	RAS_FIND_INFO
+
+#define RAS_SR_SGGIT_CHA_BV_04_C \
+	ATT_EXCHANGE_MTU, \
+	DISCOVER_PRIM_SERV_NOTIF, \
+	RAS_FIND_BY_TYPE_VALUE, \
+	DISC_RAS_CHAR_AFTER_TYPE, \
+	RAS_FIND_INFO
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	/* RAS Testcases */
+	define_test_ras("RAS/SR/SGGIT/SER/BV-01-C", test_server,
+					RAS_SR_SGGIT_SER_BV_01_C);
+	define_test_ras("RAS/SR/SGGIT/CHA/BV-01-C", test_server,
+					RAS_SR_SGGIT_CHA_BV_01_C);
+	define_test_ras("RAS/SR/SGGIT/CHA/BV-02-C", test_server,
+					RAS_SR_SGGIT_CHA_BV_02_C);
+	define_test_ras("RAS/SR/SGGIT/CHA/BV-03-C", test_server,
+					RAS_SR_SGGIT_CHA_BV_03_C);
+	define_test_ras("RAS/SR/SGGIT/CHA/BV-04-C", test_server,
+					RAS_SR_SGGIT_CHA_BV_04_C);
+
+	return tester_run();
+}
-- 
2.34.1


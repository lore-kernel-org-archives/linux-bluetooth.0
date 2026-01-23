Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F222F388
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769167874; cv=none; b=m42D8lPnpY569oa8kA9IwnO74wIC9dkUEqUC/fMz3MblLGMQ6vDeftRgH9/xyZinkTpSkBXQHQgT61HqEOD5uJ5naDmTmZlnKUSdAXvcBwWFR4GlDNhfk5hYTOv2AH63WW8ZnaLfOwGs01HWjebH+3/5hRBjIb0gMGGlS0vorLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769167874; c=relaxed/simple;
	bh=D4khdGRbPf+aT1WVFqdl1isewbT0NIAlHKCVDSX3bKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q8JvKldGv/KDACSscSEYJDC/n7vzo39F3btbkCQ8dArbccVnwHloCImjaxgQ0jYm5BkI0dLjKRK+u4lKDKOmqVKI7vEetQ06RoSQ+ZsqrkPg7tgoX7hBFUEPFj0HIOPrlFrQ4hbJqLPcdYxrEV+371eNIiv0RqHRA4AzIDVPuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gQaBqtlE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rly86qf8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gQaBqtlE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rly86qf8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N6MoP83504020
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1XlZNYwkyqFbKHo+lxBvM8hAm2zKbtjlSZE
	Q/KPSGGo=; b=gQaBqtlE0mzAAApZMSiVcUZjgXfY8xewB27nmfKtJWe0C7vg6YY
	0lftntk1J8d7ayd2m8U3ojNjCKM7dnOQi1QMzEeHuVnYm4wWpPkZEMxLYzXHyS+R
	tdv0JynEOScfaXL6pfgxIkOVqTDPynFJb604nt4Cmuu2wZXXz3b9U1BJMZ0B97L2
	pGJDJeHTQYszR7dYIFe6mYZ409mTBAP7ny6b2H08SDH9erqU7jcV7X+ei63dJWcY
	85Mc/z1B94xcXy181I4Kogd/9uXyK9eixZAKvAuCwRJf+qyAs3YwZFcps+aKi8/Q
	DblCiT9Sjw1N0BkGemM5P9VyiK34ORn+aWw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bus98369y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:31:11 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c52d37d346dso1079147a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 03:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769167870; x=1769772670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XlZNYwkyqFbKHo+lxBvM8hAm2zKbtjlSZEQ/KPSGGo=;
        b=Rly86qf8ICVUy7/VBi6hlP0zMVLb1EgrPcdaK1x7QWkDTVlnV7vb5WXPLleCQzzSUr
         MHxTIc8KyFA/bQd8MrrbGlK7iFAVxGRMuoIKLVtapOMFcgLdI07TjB6nR6Gs1wTVjLZ9
         MDxhRn+GjVdCgV9E4C2XE1RkreFP7py1uJ1IvwjJjV7yy32Tc1w7wD/OrjF07kwOgrkD
         XDHEC0WtRJwnEkQWEWSn2UbOhqhaMemIM0HSwL+yh3CZWpTSdEEGcGCOOENDqAbm8AzY
         zfkyLqXbGAUfMCwI7oP+CvROqsjBamjHkZFAJOEHS+yndr6rGftS9UNkP+LrEFKNSlER
         8Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769167870; x=1769772670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XlZNYwkyqFbKHo+lxBvM8hAm2zKbtjlSZEQ/KPSGGo=;
        b=ioYPo27xiH12vYP4s6eWBt6LtVtxaZ/DSyN9/N6tm55RzeDRU1qeWp1SqzCyqDwtE7
         DnXFfl8sGouOPkbovB0tvaRAdQTV9MXFOaEa/4ALKc2SAgRy5EwYnfm71JwSXyuA4FlC
         KiCkaJxHtZm8coBWAY0S3Oosj3nTnFJHfPC+fqngTHh3GmvlvFa5nL6mgptQkVymwJB+
         N0lmwxtAOdONJGS+dieew1d3nPNS5IGb2vxUJCO+BVW8kkHHIgTxxdFOJ+274S1A/NUn
         ER1Y59Pw0/d4RRhYYiFL1npE8g/0i6uIFnyuuycwOXNufamy8SbXvxaMNdhNbpFhP5bS
         x+oQ==
X-Gm-Message-State: AOJu0YyCjOpnn++WxkmEyEa9gpsvjN9DXKLjqC0rHEsv/3KUgZ2sQyO/
	ArDrShgFxm3Ry53nCxnRmt8KCG2wIBZXNqXej+EFq+mKmDr1ByEceqmOwZLulpekYszWAskC6zI
	RXuVUiVH8FyLNG9f4+0y05LZr89O2QWP7ZwmX0LcBW/1Yf02eGhf+lMFrH8fKIIbAYdSQ/aYHbI
	DWdfE=
X-Gm-Gg: AZuq6aLgddshvBaKhamZsjAn+L1gZfxGthrpPUIMiXaFaD4ZstP4hn+RPbbfhyXh17n
	fbBhjLeosMLe3zwwDQxX+QbpSJK6aO7aGrl6lxogttviq9V/X0X8EpuYd+0H16vWSGLICMIWcbv
	btieRH8YTYG5CElmEzNTAn0QClt+V+nDlEUVLJUgyY4XDcWHJmcz0GEIVwANPRjpFDNoFnAZIO+
	i70MxiUyr4ZUewo09kU/OfY+y76d1691gtn8BPrfyOBO6PtyiWa+BthUWKE4IRbSkXsjJw0uEF3
	ICaP5KTlRUxKW/5PHrFjKbJX4nrfwDePnKM757wWryW3BUjpt3xHAkwGWxbJkWe5RXRGOqJUuik
	Cd/BHPpv2ve+caNIVTPYOInelZx+2GraGiCbdg+R7k6T9bm23
X-Received: by 2002:a05:6a21:6e4c:b0:38c:4344:fc5 with SMTP id adf61e73a8af0-38e6f726361mr2794467637.30.1769167870237;
        Fri, 23 Jan 2026 03:31:10 -0800 (PST)
X-Received: by 2002:a05:6a21:6e4c:b0:38c:4344:fc5 with SMTP id adf61e73a8af0-38e6f726361mr2794428637.30.1769167869539;
        Fri, 23 Jan 2026 03:31:09 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a173d59sm1866067a12.16.2026.01.23.03.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 03:31:09 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ] unit: Add test cases for Ranging Profile (RAP) This adds unit test cases for the Ranging Profile (RAP) implementation, specifically testing the Ranging Service (RAS) server functionality.
Date: Fri, 23 Jan 2026 17:01:05 +0530
Message-Id: <20260123113105.551745-1-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5NCBTYWx0ZWRfXxBaa3zpcfRxw
 WV1qvP/pK9rKQxcy4mkO6ClssDL8fLCNBbGdCCEc1tfiBSNQ2oyplcV3iuwp/Rt65niTMBFkn5T
 T8mmJ3H9RDQqeuJ1dj5LANOgfvYvx+n1DsjtTZZ2SiiKULaiwSZPC+/pTdLnWP83wB0g332yFzi
 oF9NnYC898jh9XlWHZX0MweELh2zD7Ol3NRidVNhsPHfCSbbaOrlRh+R46jeTA6orLS46l6d+Qt
 WE3A0r3jfZdKX2chV8iziVOoBWLcanYOjhJWdrk0IVkiU0ZsdcGbNrQ4G+Ur2334+YcNKH/0naZ
 s5ggU+SyFFiO2lyEHrv4uiYCPORtAFm5atgHPBj/n7LJ7pfdSLTi87v+hvUc1ZXkfGSQNGXUhn2
 GEUCj9hqBMY4IGims3XpNAmVov9Ry0syoYj4OdTlznOhrBfXvXwkgYSsGwAwkpXzwhpLJPSlof6
 xiQb63HvV+Y0gd2DTlw==
X-Authority-Analysis: v=2.4 cv=JuX8bc4C c=1 sm=1 tr=0 ts=69735bff cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XA3xTWKml79YH-AOntAA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 3J_LZd10hittXvVd_v2Sq3LuirT0O_3I
X-Proofpoint-ORIG-GUID: 3J_LZd10hittXvVd_v2Sq3LuirT0O_3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230094

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
index 000000000..a0cb14f7e
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
+#include "src/shared/gatt-helpers.h"
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


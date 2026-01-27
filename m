Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA91F63CD
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508220; cv=none; b=bP9ezIgw1dQpI63HvaGdnbF7AAW+Upv4tO0IUCVDBy2Zf86IcAYDxXDt6uOtp9KlzaO/W1ju0tS2qVMlOhoCsilAZxlALPQtSuZfCZMz5UfWyYRM30eJy1CrhXtcGJW8WMygvaNgPAfISXkoAMFdXx/5OWfpnpCjo7Uc0l1l/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508220; c=relaxed/simple;
	bh=S4CWTPconQRsPOQZitpt6kvdZWXDBWxdC9m4eDehnjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cTIzf2a2eAmznnioV59s73LTIGQDLcKkcKqxI2sSmpFp5ygRVBkg2AfAx6H42F01CRYGvXK439BL/vuVqhvLkZg13AwlZfHZnlMjkrNgFzjyvh3eKacHZLluzcizX7ukiXtb/KdA2G5xDn37Ejb8zhBaikVJUc1CGs/u1Pzhx4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tm5qk8XE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QTdncy0v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tm5qk8XE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QTdncy0v"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R86vwp621204
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=a5zlzfeY9O9
	BtWUhcaXcJk+CitPtlA5QUiA0geh7SX4=; b=Tm5qk8XE83HwVhImP5i5P91Y6uH
	Q/8lACYXKsY9WvVntLKSDXRBjGIxPS/aJozJ6JsOFezECzzFEzr0y2fhscpadmPK
	SDtzYyPy/7f3Oivp8+vs4U0HIPA6/zXE/BJnmT56O74sswzMuOI8Hy8tQ6/5aScL
	PppcF8y4hu96Yowtk71d3jtIOycFIjKygHHdRhY6fpo7Z/VcgFjKKfvvEA9g+UX2
	hoMlyDDkAOgwozqHNjq5N/nxjHJnc4OtQDnVBdnL/DopDQKXgSKsAv0LWxJvK26i
	lkfPxO1fD6G0lbWzUBsqO0EeAdKY/5yFgHJ3jlUf6d8c/ukZ+NUeDkAwcBw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjegd3x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:03:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0f4822f77so129181155ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 02:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769508216; x=1770113016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5zlzfeY9O9BtWUhcaXcJk+CitPtlA5QUiA0geh7SX4=;
        b=QTdncy0vlNkVVW5UFnObwv60Njkoldun5JeowA8oaUnduZchcSS+MTVIV7wo30FjI0
         9DUZuLIDPc/YZSKekhfFdj6g19om1XoDD4lkClnA4qlA1IAWwbQ5vvF9rigN8xoaiM4L
         u3XcaVyW82BVcIfMHb82o6WfFU/sjYHN4s7tU02j1kcogsWJFiEj48makZX1H+CPK7+4
         pqSejKK1YlhpMaZfo8DfadjR8V0+Zdg/z0QglleNCuZh0pFQpmFS80ssnFGPjBzPChgv
         /x72C5BD4KG8VLQX7HtiEaf/aYq4SuCTxzbVQnh4VLO/ctwf0oixm20XO5823abpjWso
         y0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769508216; x=1770113016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a5zlzfeY9O9BtWUhcaXcJk+CitPtlA5QUiA0geh7SX4=;
        b=Q2z70Qjkn4bn7wyTX5dpuy9mKNJtVMwPYxKJxi8N3CASY2N0qbe0IIvuYSsnezp+lR
         Qz3Br2QAU33LFWFszkWaEO0VDBNOoUxlO7HPC7tR/00TZREQDNLDsdqT83GJL1cD0CAn
         tyNF1hIG8Wq5UXBNDQkmP6JN375HvhoCBGj73S682m23AYRoIYOfftDyi/h60tvSzGdd
         BU9QCLnEX69OOGk+QoibKYo6EX+jDXKVaG28nsL/AqdESSEhh4WnLJpvcuxQgd+dA+eJ
         EOy8YtG8nVskG1O+i86Y/RBPB6fWcWYOE/uSylYIAS0+Wnro3xUBaRW8Md1ih3cC8T1T
         Akgw==
X-Gm-Message-State: AOJu0Yw35jKa+gyUrDQMRvtq1dth5OhjVBiYn3W8YrEJmdVo87kIPaPx
	VdcmVIsJkStcHk7Ep9tvx4Rnc4Z+k4O3uUWJ1jHpkVyepPQjwhJ+zn+GLyOitUOQR5KS+AGpKTV
	E1CecTB8qpHkq0miQvfA9hzkF8LN2MT+gdKWDD+JZxtfKhUxyC5pazCb54LQvR+QQkxsbJOKq23
	2+L0Y=
X-Gm-Gg: AZuq6aJAD9g16z9FY05cdXPamRHuyl9gmEtBTMLoJ9/KO3fSbB9+Z/JR0vKQXLfDaNy
	yt4t4iyZwpzhH2huJx036Av02bUfCi3QmBrWMo/zrV7U0VFIFMslFz3GLEtJofqDsl+rZLZ6wqt
	LuhUZGxIS49tduWcU8+421GAewlcSrXtQbJBri5U+963LKoi/hO3DOf39zGC4mxASY+XU33bW3J
	BUXcZG4svdnuugAM2l/WOP9vNZRgdmhXnEserzzgDCuvrVclV0h90JvMw6QpRMhfB5s+HSpzfus
	N7zpCszSMxYBHydjCjx8k/P7KANxJs6jY+tRVjYDzLTzosFKCovHiXMaotRvbnDEfminXK3KsvL
	EJL8mujllMo1oHBDsCxBhuB0QmWLkb9bbdz7yWlpK7PodEv94
X-Received: by 2002:a17:903:2bcc:b0:2a7:d729:6a76 with SMTP id d9443c01a7336-2a870e1890emr11389825ad.60.1769508216477;
        Tue, 27 Jan 2026 02:03:36 -0800 (PST)
X-Received: by 2002:a17:903:2bcc:b0:2a7:d729:6a76 with SMTP id d9443c01a7336-2a870e1890emr11389565ad.60.1769508215821;
        Tue, 27 Jan 2026 02:03:35 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a87842538bsm7619455ad.60.2026.01.27.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:03:35 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v3 5/5] profiles: Add Ranging Profile (RAP) implementation
Date: Tue, 27 Jan 2026 15:33:20 +0530
Message-Id: <20260127100320.3055119-6-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127100320.3055119-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260127100320.3055119-1-prathibha.madugonde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA4MiBTYWx0ZWRfX/oJKz4rlKLq1
 lFyMKws1IBZEltYWh1tGt9UMUsmaI7SmAPnjSC5Xs1klveVD0JeJUtBq6kShRzX2vwOTL9ZpBsx
 MUGvmuWJR+wNda1avv6u3kaPvxx9BiShB9CHksMVEAYYrv1wnr6TDH09wRt7rl1496272pUcoFj
 qPIxEP/JPy5DVCqTS/EyyuwxJU3AAm7gjjxjvnS7O+BkolH9KiaQIY6l3XKzQq96cJvaK7ReCMt
 LqLMFOahNY95hJ/XYRGIKUAWc/UiYQ6VSofkdRM2+Lu8gzQx4uGM87sHmPtO8C29KrNCkOhG84o
 XTAuliXzpjnLDGVmK6Uqhb/y6Kxg/me1s7n9VSYZUaY3BGsL3rBSVXJAqDgUqYXO514Og6ZPPSU
 Ds6bve3gPM0EH7+UOG4Zer6CDhC2ATdaMkUYFLzako+VFR0wv3in38scHCWmYG6QcTUPAbVb63o
 aTA1t4N2td7tFHBvRag==
X-Authority-Analysis: v=2.4 cv=Qelrf8bv c=1 sm=1 tr=0 ts=69788d79 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3RD4Na1Ei-b115O2o2gA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 5NkjsFV7lZC-tJBSxJqfJagaUsbrWHfq
X-Proofpoint-GUID: 5NkjsFV7lZC-tJBSxJqfJagaUsbrWHfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270082

The profile is marked as experimental and requires D-Bus
experimental flag to be enabled.

---
 Makefile.plugins       |   3 +
 profiles/ranging/rap.c | 333 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 336 insertions(+)
 create mode 100644 profiles/ranging/rap.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 654936176..b83a28257 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -106,6 +106,9 @@ endif
 builtin_modules += battery
 builtin_sources += profiles/battery/battery.c
 
+builtin_modules += rap
+builtin_sources += profiles/ranging/rap.c
+
 if SIXAXIS
 builtin_modules += sixaxis
 builtin_sources += plugins/sixaxis.c
diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
new file mode 100644
index 000000000..f03454c72
--- /dev/null
+++ b/profiles/ranging/rap.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+#include <stdbool.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "gdbus/gdbus.h"
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/uuid.h"
+
+#include "src/plugin.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/gatt-database.h"
+#include "attrib/gattrib.h"
+#include "src/shared/util.h"
+#include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/rap.h"
+#include "attrib/att.h"
+#include "src/log.h"
+
+struct rap_data {
+	struct btd_device *device;
+	struct btd_service *service;
+	struct bt_rap *rap;
+	unsigned int ready_id;
+};
+
+static struct queue *sessions;
+
+static struct rap_data *rap_data_new(struct btd_device *device)
+{
+	struct rap_data *data;
+
+	data = new0(struct rap_data, 1);
+	data->device = device;
+
+	return data;
+}
+
+static void rap_debug(const char *str, void *user_data)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
+static void rap_data_add(struct rap_data *data)
+{
+	DBG("%p", data);
+
+	if (queue_find(sessions, NULL, data)) {
+		error("data %p already added", data);
+		return;
+	}
+
+	bt_rap_set_debug(data->rap, rap_debug, NULL, NULL);
+
+	if (!sessions)
+		sessions = queue_new();
+
+	queue_push_tail(sessions, data);
+
+	if (data->service)
+		btd_service_set_user_data(data->service, data);
+}
+
+static bool match_data(const void *data, const void *match_data)
+{
+	const struct rap_data *mdata = data;
+	const struct bt_rap *rap = match_data;
+
+	return mdata->rap == rap;
+}
+
+static void rap_data_free(struct rap_data *data)
+{
+	if (data->service) {
+		btd_service_set_user_data(data->service, NULL);
+		bt_rap_set_user_data(data->rap, NULL);
+	}
+
+	bt_rap_ready_unregister(data->rap, data->ready_id);
+	bt_rap_unref(data->rap);
+	free(data);
+}
+
+static void rap_data_remove(struct rap_data *data)
+{
+	DBG("%p", data);
+
+	if (!queue_remove(sessions, data))
+		return;
+
+	rap_data_free(data);
+
+	if (queue_isempty(sessions)) {
+		queue_destroy(sessions, NULL);
+		sessions = NULL;
+	}
+}
+
+static void rap_detached(struct bt_rap *rap, void *user_data)
+{
+	struct rap_data *data;
+
+	DBG("%p", rap);
+
+	data = queue_find(sessions, match_data, rap);
+	if (!data) {
+		error("unable to find session");
+		return;
+	}
+
+	rap_data_remove(data);
+}
+
+static void rap_ready(struct bt_rap *rap, void *user_data)
+{
+	DBG("%p", rap);
+}
+
+static void rap_attached(struct bt_rap *rap, void *user_data)
+{
+	struct rap_data *data;
+	struct bt_att *att;
+	struct btd_device *device;
+
+	DBG("%p", rap);
+
+	data = queue_find(sessions, match_data, rap);
+	if (data) {
+		DBG("data is already present");
+		return;
+	}
+
+	att = bt_rap_get_att(rap);
+	if (!att) {
+		error("Unable to get att");
+		return;
+	}
+
+	device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
+	if (!device) {
+		error("unable to find device");
+		return;
+	}
+
+	data = rap_data_new(device);
+	data->rap = rap;
+
+	rap_data_add(data);
+}
+
+static int rap_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct rap_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	/*Ignore, if we probed for this device already */
+	if (data) {
+		error("Profile probed twice for this device");
+		return -EINVAL;
+	}
+
+	data = rap_data_new(device);
+	data->service = service;
+
+	data->rap = bt_rap_new(btd_gatt_database_get_db(database),
+				btd_device_get_gatt_db(device));
+
+	if (!data->rap) {
+		error("unable to create RAP instance");
+		free(data);
+		return -EINVAL;
+	}
+
+	rap_data_add(data);
+
+	data->ready_id = bt_rap_ready_register(data->rap, rap_ready, service,
+								NULL);
+
+	bt_rap_set_user_data(data->rap, service);
+
+	return 0;
+}
+
+static void rap_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct rap_data *data;
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	data = btd_service_get_user_data(service);
+	if (!data) {
+		error("RAP Service not handled by profile");
+		return;
+	}
+
+	rap_data_remove(data);
+}
+
+static int rap_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
+	struct rap_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	if (!data) {
+		error("RAP Service not handled by profile");
+		return -EINVAL;
+	}
+
+	if (!bt_rap_attach(data->rap, client)) {
+		error("RAP unable to attach");
+		return -EINVAL;
+	}
+
+	btd_service_connecting_complete(service, 0);
+
+	return 0;
+}
+
+static int rap_disconnect(struct btd_service *service)
+{
+	DBG(" ");
+	btd_service_disconnecting_complete(service, 0);
+	return 0;
+}
+
+static int rap_connect(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	char addr[18];
+
+	ba2str(device_get_address(device), addr);
+	DBG("%s", addr);
+
+	return 0;
+}
+
+static int rap_server_probe(struct btd_profile *p,
+				  struct btd_adapter *adapter)
+{
+
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+
+	DBG("RAP path %s", adapter_get_path(adapter));
+
+	bt_rap_add_db(btd_gatt_database_get_db(database));
+
+	return 0;
+}
+
+static void rap_server_remove(struct btd_profile *p,
+					struct btd_adapter *adapter)
+{
+	DBG("");
+}
+/* Profile definition */
+static struct btd_profile rap_profile = {
+	.name		= "rap",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.remote_uuid	= GATT_UUID,
+	.local_uuid	= RAS_UUID,
+
+	.device_probe	= rap_probe,
+	.device_remove	= rap_remove,
+
+	.accept		= rap_accept,
+	.connect	= rap_connect,
+	.disconnect	= rap_disconnect,
+
+	.adapter_probe = rap_server_probe,
+	.adapter_remove = rap_server_remove,
+
+	.experimental	= true,
+};
+
+static unsigned int rap_id;
+/* Plugin init/exit */
+static int rap_init(void)
+{
+	DBG("");
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		DBG("D-Bus experimental not enabled");
+		return -ENOTSUP;
+	}
+
+	btd_profile_register(&rap_profile);
+	rap_id = bt_rap_register(rap_attached, rap_detached, NULL);
+
+	return 0;
+}
+
+static void rap_exit(void)
+{
+	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
+		btd_profile_unregister(&rap_profile);
+		bt_rap_unregister(rap_id);
+	}
+}
+
+/* Plugin definition */
+BLUETOOTH_PLUGIN_DEFINE(rap, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			rap_init, rap_exit)
-- 
2.34.1


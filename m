Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1B73559F8
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529308; cv=none; b=Qgviexk/ByNo/gvYuyU7LykmB5Mwmr6T6k4bQyUavNBGTsxp3I9YvYfyl5rqbI0lfg5HKvLvw9eWIiM6Odcf1hkIcHDZ2wFgZ0CgXmXQofHfaMxEof0j+GCJfSK4pNMVkedCZpxCZxiTH5z97Q0DbrV47fjNjQWIhCoFOA9w/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529308; c=relaxed/simple;
	bh=S4CWTPconQRsPOQZitpt6kvdZWXDBWxdC9m4eDehnjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O6lVkrLSTt4S9g1xN4MoUTFC8LmB2eRllMpYSqnRIpskelAXGSMb+XgUi8WLtPQ1uFJnUsfVZzp+ODNXCye0hW4TmMU5x/8u9zRdsV4DQoaziAukz6qoamoVYN04EttSPrb/HimpgXiV0xjiejQhtqzu0pxhHWIC/kj4aaiT4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LF7UwMVv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VFOI/++Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LF7UwMVv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VFOI/++Y"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RASCWJ1268876
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=a5zlzfeY9O9
	BtWUhcaXcJk+CitPtlA5QUiA0geh7SX4=; b=LF7UwMVvRf+ZnCC68WRFy8Kpmv/
	ORiH5nOLEe9fqX4u955v6ijhCTzgycgylNowI4Mj1SmE5Bk5oqTZwoqmehWo46T/
	toy8dJt2d7hZNKphxYsg4QqojAxVrpoEKoZKF571zsIaWLOXu2Nklx2qX52jHYY6
	aAHLPjL0DGMSYD016ZwT3kIJp33HJ4w7VGvkp1K7I/zCsnH+juNyCN3UbTmB2a6/
	9kkNLBwz2hMw53vWKg5wQ4Vu8nor7orw+TFIo6eOcpz0DdKloua0nCuBIyPsqEza
	Ipadn9ZFTF8QFP361pBiG5rjWl0bCLgy4sQpbiIXqLhxIQvUxKKI73eHkAw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxnyata4m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:55:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a784b2234dso18022425ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769529304; x=1770134104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5zlzfeY9O9BtWUhcaXcJk+CitPtlA5QUiA0geh7SX4=;
        b=VFOI/++YfO5c/tbyD+qFGcO7cV4XEiVVYOhdza/DvfRAOxYwxcHmdPyGCDuv3b8CWj
         vG9nv9qUNniGw5+Y432d8W+7NCc9eKRwa57BY6T0gaNCDQlMjM/R9H3eRnIWvDFBYaLs
         zNl77+UItAFaAy/TfYO121rdPa882K3NgovwnVmhwS9rYh8bOJo+wX6s21TG8wHxu6N9
         QUKDgvdVh5xbZY7L7D1Dt0PTw+i1Ti3K7TMYqh/0HAVZwPDFXKWWYntW7kZ8IvP0493N
         88tqhFUaC8SGgK0eJQyXZAjs6t5n0iFjNHbxDlehuDpJiaGob9mmFRdhgZv8IvX/idRX
         UUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529304; x=1770134104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a5zlzfeY9O9BtWUhcaXcJk+CitPtlA5QUiA0geh7SX4=;
        b=mZba1iDnELqI9dLBx+nmKf0pWxLmlJ+wdbKr8agqwXQD64pHqipxoCy+K7Xh5x80St
         Xq4NQXQQfegUoesd20g0XkAKUwu9u6h/cLXfS5IxsFlS8XsgAySsJwyfG3XBXFt5lycN
         fVwFbeDlsE+qXOF0yTJsUtJWL7F5faPmdqpHvewE0pzB2onZ9F7XTYxa7LeHNoSS14oe
         DV+4K1ff15B7rmXX1p5AKHzEeLfnSblRVSBcO//IpnKvKjKzOoDPVvBcr77hUaOsX+Sy
         cQo4MHUsk/Ix16qb77sOtjk5GMo0BywgpK0R3skywOoRyOq+mQ8ClGk50vwxNgC5N6hx
         LvvQ==
X-Gm-Message-State: AOJu0YyGZLuInIu4QBsXwoiQgVokJ3zWKOhQRgXKKWemUT7PObUihaAv
	ixhpIci/Skau2WJ0c+G9pO5iaDcubAnNKXqE5anQ0sRCY3swz2Tbv4XbWnc4Gc0UAKl/IXgS3mY
	uZfcv7YTF7/kOR90pvyDulnPPt/yWMvhhMPu0CZBPXbO68yDOXK1FIdmS6Ymmu1JtsA8KR17R6c
	qCqx8=
X-Gm-Gg: AZuq6aLvD5PyT/51kXqwLDTdvcfIf+n9uariY2bdly9ydQYbLAqJ+xJuoGwOoJYTa9J
	VJJcrGbRtYINS53z6vte+OrF/hniBYlBqKmjDjuUqdEi6+BNeIt1BfOKiceOHo0hSLZkGNrwKYD
	M9WrdzokLRTuRZWfyoqFvmSbC3FSyxckxL1fCoRDb9s62ul6GtywKrUh9RKoanSukK1JEWHzIxc
	hhkdS9+jHReTC0xgcMXXvAGFyI9Z5zKlUo/CHt93K9YO8rxqaIXCjYDlKN0uiBKBb38XqDiv6ny
	61YfA4DClGs9PrIj+kasH4jK6JcDugFdWymmS/4BxHcBUwskIBt70hDvT/8XFouEKRdWGPFHdnt
	Zz3rbqHGmmwkBru4Sx8EoHHQbSjR/tUYls72UTDezkcXfQLLN
X-Received: by 2002:a17:903:1a88:b0:2a0:f828:24a3 with SMTP id d9443c01a7336-2a870e18d4amr23328105ad.28.1769529304434;
        Tue, 27 Jan 2026 07:55:04 -0800 (PST)
X-Received: by 2002:a17:903:1a88:b0:2a0:f828:24a3 with SMTP id d9443c01a7336-2a870e18d4amr23327725ad.28.1769529303883;
        Tue, 27 Jan 2026 07:55:03 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa719sm123292855ad.14.2026.01.27.07.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:55:03 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v4 5/5] profiles: Add Ranging Profile (RAP) implementation
Date: Tue, 27 Jan 2026 21:24:47 +0530
Message-Id: <20260127155447.3324706-6-prathibha.madugonde@oss.qualcomm.com>
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
X-Proofpoint-GUID: j2ISdV6dKPDqp3D31laSpjTus5YZ4qCV
X-Authority-Analysis: v=2.4 cv=JZqxbEKV c=1 sm=1 tr=0 ts=6978dfd9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3RD4Na1Ei-b115O2o2gA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: j2ISdV6dKPDqp3D31laSpjTus5YZ4qCV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMCBTYWx0ZWRfX5RhXmVHVk2RO
 0/1L93PFGP79NphufXdQUYWn5rrEdW0y+rSpqaU4NFM1/2OTT26GF5UaR1+7g7+0HKKX3pKXxQL
 FV733LF6LHuRllJMMtmOx65HiRUdkb7cuMFhKZ1V+ThWEpnpjQGRPqheDjss8zHI2Xu5jKBgt8V
 eSF8c2gGsNxU76hJGnNA00ozQg2I43oxeu58fzdqRAVc/iGCXMoO7Psfr/W9reH9DhspUuMwVcK
 Q1DB3UKJIll9fp+94QT8KLKC//CJLHsuS1EJmNJjbtDRvZbi7kcAtibidP6w5qovSFwZSOFRd+i
 mHpl65+qjen+wATiTAA6Z866JVS2jP4GhbcMkVraeqxbDYY+YcI9ieVvy95k2kTy8HwwsIcV0HB
 WHKvazf0Uueu4B3rM8BKjGkDCmpM58EfBuXrYsKvs3SvAtQxsGejnLHfR/L8gksNRqOz13Bubfm
 6ZUZ75ObnsJ/bWHBU4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270130

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


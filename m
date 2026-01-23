Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F680287256
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168123; cv=none; b=fyTkEiAFB6/RDgyMKdJNCOUmDL1GLbo+Nw22yNlcUsvbhamdKbIPkLz+KUIwYy9FPGof/jIWYc1pXbpiR2mLvVV/IDfjYKjnfeZa7l4/CnHdDlR3qM7soYw3jgk0H90Ao6mOdVTmT6ZOXBeniIiXRs8I04AUpbOMMkTHHeoE3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168123; c=relaxed/simple;
	bh=Z4zGUXjdJdxAgrcgaPWjyJQ9+aUF+ZNGWcCAOE/VroM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gj5e/dXgdkcnF2Tx8P+fNJ9F2/WFdPpbuRpLlvQl0A6MB8dNckXGMPtYRxaGcCCGVluPojJ6zFHXJo3ooKUdRjedpgzBK2bJhxb9I74ZBmUmkKLS9LlzK9A5smvF42bqAH+fbniCv63T0YgT+iyApLWPBWM5d3sH7kLP5c0pdqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C511ofwC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dc2U32uP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C511ofwC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dc2U32uP"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N8IrW13648930
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=C2LKLAwnhGS6Op4r46HURgI4bNy8ihRV7WE
	iN9GSu4o=; b=C511ofwC2P/knUgLN8Q/X0gqmKLKoIIzHKTwnAa0DrJQ9IMoUFH
	jRemPWcEzdYcC5SZ3zv5whbu7WiSZ4YHgNAIpCh5JmQPiAQHOrkcSnk76hNV8ZuN
	8gKZGPbEaU7oekHYxpep2iq5B5F927EDWRhgDqEtNVzpNSwqsAHt5kIdwelE53/v
	q436BA0vlc7PNmmoNgZvhPEMOVh+d9bzH5R7wSNHCg9K9go9jeD7zZCLgMKqxsHL
	iDMSMaXUob7wFlVQpdLjSZNxK0sw3p9dwPaLsHAf66nRv4WPNnOB6CCrMm6lo7en
	BcwjqSWNOxeUI20DY+KB3YKIiWShSL5aLag==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buy4nt4s6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:35:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6133262e4eso1263613a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 03:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769168120; x=1769772920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2LKLAwnhGS6Op4r46HURgI4bNy8ihRV7WEiN9GSu4o=;
        b=dc2U32uPBp5ZqEkiU0STyegtbE9DwhOSPewBUugpFZ7Jl0ztTNDSWtlaxKnUk5Smxl
         1ET6aBgQarsqZlSUMr+mbK7ymp4omGCHUHltRh7g9oCRhVflaIoTmh1Xe02EoDAXlYaO
         IRJJks8AvN82j/pk/z0qalY802pL9/qe5bWuyL9T2uayzQpxTQikQdk+Zy5/pmhv90xQ
         uMjZw/Kl9joP2kZLfXm1O9q/r+yOo3bMpleRqIxskLN1fGiX62dL81o1aqBR3v5j/qWq
         O/koccQAhxG873XKoKHKw+lMQYnqA+8CkXvwMVMfJPZSk2W7NwgGH4KLz+7RpUZbY13P
         3r5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769168120; x=1769772920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2LKLAwnhGS6Op4r46HURgI4bNy8ihRV7WEiN9GSu4o=;
        b=oR44jpqUVJtop6yBlk/zBLXw8ZcJic1Vq3pQnFkaP8h0BozermeCKH1efC8uXD0XeS
         CZp0EktAxdbjz3t1QPaDYgB6q80hqiv4BfuJ9nuAbPJn+whuQO8PSEGvtyQx8FlYEUAN
         Y1TjTwOB0lV6A10RK2FO0qSaA2rqK5K68qV0Khun+rShPYdm3rp8XpnyQPol1lct+47H
         SK1KCBNH0C0O6nZAM4T/iWNUepSIN3owHgBXqvsYAL0YAPxqAqSru1UZBxadpADoHCZ3
         v6cccP1eur669Pxwtr1jS0G7udtHaELAwRIVZW9t3njmVZFW3z9DIbUReS//dJVcRVw+
         Gung==
X-Gm-Message-State: AOJu0YwPkLDJX8q+oHoqmZDHMHAKF36PirCLXtn4cRhMnNcs3ejCyHur
	StvGf24AxD8COj+q1DES7ZYHyKk6nLf0tkOg3FueV0PCy0SkZw+1i+qMMB3RabCqa6LoiS/Wv3+
	tVEnFzhvAUp4DNdHF+X3r5t20ecBKJWr8/Tl0uFw5HeM0KAI5Y91ZrbZu75u+XbBwCiOvpv1z10
	Z3Q0o=
X-Gm-Gg: AZuq6aIFHtxXEpM69v/fMgBFee9fhndvluTM5CSsNWJBgmOuPBk/gZRO8EuXotnEkZv
	8rZdwjgM7C20M8ybxZ5bUctILHlVkIHuxpB+7C13ZVm6Z5cZ4IKGHi0muZygmwbdInG0JcJbHnE
	Mhwg0qA1gOTEDQcC0APMP/0Bx2Esa+C7PbDdt4Ra0YVaZ4JPyDgueARqXjkq1n4hkjV+8uszlfq
	IMNFhdeJxoF6dMYaTUHJPBc3EcV1mMg4pey2qgT7suTYR6iURpFcALE4/iuQyiFb1LGxvckB1pq
	Y9xcUPp4XKMG3wpOAj7MRNHqUFmMaobqw//UOMTCrx7ZlKvnsxMRhUN29d/+U0TwRmDmKsi3mLT
	YyBk4LP1baBrMaBONhkuvnM07Lvyf0Dm9KmL4S86+ezDPs+le
X-Received: by 2002:a17:903:40d1:b0:297:c71d:851c with SMTP id d9443c01a7336-2a7fe626d72mr22899355ad.36.1769168119724;
        Fri, 23 Jan 2026 03:35:19 -0800 (PST)
X-Received: by 2002:a17:903:40d1:b0:297:c71d:851c with SMTP id d9443c01a7336-2a7fe626d72mr22899125ad.36.1769168119199;
        Fri, 23 Jan 2026 03:35:19 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802f978b8sm17959965ad.46.2026.01.23.03.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 03:35:18 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ] profiles: Add Ranging Profile (RAP) implementation The profile is marked as experimental and requires D-Bus experimental flag to be enabled.
Date: Fri, 23 Jan 2026 17:05:15 +0530
Message-Id: <20260123113515.552153-1-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NEDx0K1OG268o_D5vjatSWAi5BzhMQgQ
X-Authority-Analysis: v=2.4 cv=I5lohdgg c=1 sm=1 tr=0 ts=69735cf8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2oSb9aBAJkP9XwwK:21 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=3RD4Na1Ei-b115O2o2gA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: NEDx0K1OG268o_D5vjatSWAi5BzhMQgQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5NCBTYWx0ZWRfXwCKv3+fgOIWI
 Q7yfmLJigBKAGa8vFKVHA3ho8BgkdaHU7xyFPM0xUxl+bH0RFBroO28rAh8HjiC5S/pCSx7FQuU
 ZqJqXbtzBgnHw6s3NaxrHyajmzmJ++m6K6BPmUsu2xAXmH3jFyHFYGSmItk5RhAUrThPvzg4Ey9
 wlUMru8yWbuBa1kapYfV/iQMvq/RNWFg0xJ7fAafbWGyJztcvgNJUXyyfqhKrIWHJ7hNJYblN7d
 Y4lUGoTbf9igj0E87TWQkiMq+B4T6xhyGMAQsPyweYvm4Rs4ZXJCIVaaSH2hqM/PBUnfdHcCgc/
 tW9WZfAx3GT68LwUDc9xzgPAi48cKPFEOvwZsyS3e6lBNlbnEmwZB1b82kZrREYhft9MQy2Dssu
 ldYeBEn3oilN1vA59OdwE8JSnnqjxjVYsEOqubOR45rwYmfYucLjyR2o5XJsITmCh8R0j4Ojl64
 lIUOzVaBG+WmTLBUzvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230094

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


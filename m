Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4EB22D4C8
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496465; cv=none; b=W0iPu+g/+0bDZzkHPm2zClZkcw7JSoUweouSGyO6LfWYwDDPHPQoI1tbPcbmuzGeI5jI9AmatpIJcHaxGEhx/bm3qDOV7Ev3pOjtW1mMLbEJHpD1jQYaE2whKr+WaK2Yj08faKDHSulEZjNPRh3lIpAM7kCFiDgvkxpn3Zn/MRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496465; c=relaxed/simple;
	bh=S4CWTPconQRsPOQZitpt6kvdZWXDBWxdC9m4eDehnjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IC7WGzht64V/FSX+wL6PkgJI/hyQArGcsFlkvbc+12jO/vZ+Y79r+IQwapik3hBs0/L7+0svCGpbf7xPpfkgFBkCEC453yCNLgtG16Sdu3Vu5OP568YGTsPHnsqJT2NtkxKr7qfJ2pqel6gjk/NZnjspC7eaC4Z1Yxq5eVeoUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ETAG6BmD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iu9Uzo3R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ETAG6BmD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iu9Uzo3R"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4U8ih3914942
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 06:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=a5zlzfeY9O9
	BtWUhcaXcJk+CitPtlA5QUiA0geh7SX4=; b=ETAG6BmDwEFEYqBg+UV8C0A5hsU
	lNMkaCaxSIQT8Ehflmsqc4cepNq55dFFVMUa3obCYiwuVx33PwftQgg2P5HMWOQT
	8hO5Q1qmEN7KpIBVs8o04WTtnThTwTRb+ZjKVW0xm+x9iFxMrFLDbaaUXKn3q7cx
	hD4iz5gLfh31gI+UsPIDKUrSQTIN8bcO2adTrV9Clsj7MHWaLrfmIit4FtutlIjU
	90RY4r+egR4fULUcXYffSD+BCTZBVxzSCaeLylKiPg4gL5bPNpOXYJnbFs/fhK3p
	cNVyfriQ+bqPzLTIf93QH/jyFfb4oasOozJ1QlVNLJghqgaJZ6koour7lzg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bx2683y2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 06:47:42 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8216fece04cso4212288b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 22:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769496462; x=1770101262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5zlzfeY9O9BtWUhcaXcJk+CitPtlA5QUiA0geh7SX4=;
        b=iu9Uzo3R+iS6CFh5rA/ugMEb4LR3GlN+lbJIqTYT14R4ilXSpYmVKxhTd5JxQz2Cl9
         rqX9+qQEsksVMs3g/LUm7pliGQaHxdyXBPjPES1kSEi3a0NaGMaVnSYWjJ7uDJg8hVV/
         pzhC5yvkXR7jYR1cyfr9PRFbRLeKOxETOuofgmJ64bSCoCNi67O/Z0gQyRr/U3PlLEAS
         5WkKbbAZyeqDz5b+uYuU502sHkNUHWOlvP7CIooXDpDLMwH/fIUAJxwn+yX6qaC9/CLC
         fbgzrdYPCtP30mytZz9u7fvRrVQ0K0IXEqyfRwsoAirbcWQAxVsVCCEI+oxsb766M5Ez
         5DUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769496462; x=1770101262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a5zlzfeY9O9BtWUhcaXcJk+CitPtlA5QUiA0geh7SX4=;
        b=MRmIwd8P5weVqlJ2Qfszv1puoy+elsyJjRgVJZkcAMK5LdQ/Ib8WcQS8EfhvnStHiS
         kBDpU/QJdNG7s4Qh5NcKGoFBjQQmJ8Pli+8gkNA9fhbkond3leua/vYPjDlgaqSY910Z
         PY72+4OaFrRbvwJw/EqhC1eAdXJQeaXG+gVPgr/dOSQiPIb7HNolAsgVvGfTN8tKQtZ0
         j+Y+lfHmhiS7l3o21NFU23M4fH/cjFSgz8j0leFPmeUMJC3H/MDBgkHdrINm+BFuIfzy
         Pmooao92Edu6XnbW3G7VPWESBRM0Qzif2HhSVkUIiB08SPKmMscVxZpHqNPiXcybjMCy
         VhiQ==
X-Gm-Message-State: AOJu0YzHKUf1aH0P17hLr+qcTnIPdMQHW4UZRVN8UNi3mvLHRMHnDoC2
	LRW3aHrkoBdQZQnph0uzAbU8gkDz3bHke6Bb+G3J92w/VF6hTtowoeV4tpgpW2uRWK2T2OGXpBk
	8LYuiW87abFZw1wNnNu/KW+PqHom7GqQDV1nieyFkLp2jjw06DNxcxWnOKxvNR2ELLXzdazGgJ6
	bJAiA=
X-Gm-Gg: AZuq6aJQ4yrYHSQ0UCXyaxZq8rbfjQ4AIrQa4//nNXaKORkokactj2KiCr9R2xx0Mfc
	riXfzsqr6Gp5lZ5EEmOnoPp60tTob6fcYkJUHFNZ2rNsf2e+lzyD0bfxiHu3Z5yuT8PsDwGWMcZ
	EuSKZYQbbjI204f+9F4sXSeG08HM92evsAJ+N5Tz1lNT/DXG1r0GZvWYaO1DURrMIQId0IMSt/l
	ST6rQ2I1biJb3UlyM44wOQoHRbWmG6GKh3hCud3AcTymNiBp3BHd6sXQG+1X5x0uulrN5ww1n6D
	6UbhJvyNE+DiqWdh0ZPozhnYA/YQaX8QM1dG2Oo7XTKMQUoafXtit/SoXp1X8Hx149h4NWS5Cgl
	cqWHWL9Af7KlrYWphdamZw0k2FEC/Qy4a4//zTNqBP8oSKqGQ
X-Received: by 2002:a05:6a00:3e26:b0:81d:a508:f056 with SMTP id d2e1a72fcca58-8236a38c677mr813780b3a.18.1769496461475;
        Mon, 26 Jan 2026 22:47:41 -0800 (PST)
X-Received: by 2002:a05:6a00:3e26:b0:81d:a508:f056 with SMTP id d2e1a72fcca58-8236a38c677mr813732b3a.18.1769496460923;
        Mon, 26 Jan 2026 22:47:40 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876e5d0sm11032924b3a.61.2026.01.26.22.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 22:47:40 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v1 5/5] profiles: Add Ranging Profile (RAP) implementation.
Date: Tue, 27 Jan 2026 12:17:24 +0530
Message-Id: <20260127064724.2949465-6-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127064724.2949465-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260127064724.2949465-1-prathibha.madugonde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bIEb4f+Z c=1 sm=1 tr=0 ts=69785f8e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3RD4Na1Ei-b115O2o2gA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA1MyBTYWx0ZWRfXwPPrhsI+S+5j
 nrsAneZJdLXxA0PNeqwk06aahrrwG2cpdJuln1+tSB0Lp29cuTjBqDvht3zrhyFVoeOr3jooe+C
 0gx7d6g5n1HomHgxX4alWa+l7mQf+7YB9K8qguig+Ts9uUZgWI+R4pKcOCBPEb7aD0w81dHkwOf
 KLYpzWrlW7X9TQW5iDvwbgaS9ZpiZGeR6DmTL7f4x+v+zQk+LWWzsb0XQCHtngYB+IUnJcLbapN
 wby02z7xhrmgPhfBl/CFiqWbr7b8iSs9I9BZOTgFwm9C0JdAjcPhoNwthO6t8uBN3ROE2UCOYlu
 OykC2v6BkdPR7qd1059G4OzC9bQAhnr41sbWC9+NHAqKHN7P6amZoJSl6dXTr7Nl0tUyIhdJQqN
 J+8swnPFgxrQoFVYyKxRbx3XwYaDfWAKQrZAbGUyGqJQ6H7LjfcRqvhLwuB6+MX6htHEu/fz9gV
 u2GrHcxnwurws5Lpaeg==
X-Proofpoint-ORIG-GUID: e2Wm8HkTpNxDiIgs17B68JOXvhU_7Y61
X-Proofpoint-GUID: e2Wm8HkTpNxDiIgs17B68JOXvhU_7Y61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270053

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


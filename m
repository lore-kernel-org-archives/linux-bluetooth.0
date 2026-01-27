Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237712DE709
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769500083; cv=none; b=OnrwwbeiFBobpM0rDIvJR6BXdl+UC2gVMibW2ICz0xy5+QodtjwyFex6AZRxGzL6aMEdQNb+LXhPYlXEyAsGpVhbtLyyS53+OPw5rIVvAc8U+N6sJDZXoLqIKNg1IQnOf7ZByo2FeC6+pl0qlDw0GZi9lVQLwTIcs5d7K199n8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769500083; c=relaxed/simple;
	bh=S4CWTPconQRsPOQZitpt6kvdZWXDBWxdC9m4eDehnjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UBUsx8Rq1cafYSyPtjFD29OmdZUHGXRusjbXip+9Z34gs8nhgjjF5tJ3xMCjjrY6yFr2uD55yxrIORIwUXEyT+ZLrC+NLA7mvm/yQBxMSw3MxKGeQx0BmMgXbW1jVPw7h7M8m2j0414tuf1/yh7ehBDk75MA7lMJxFokAlFXncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=APgS05Sw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WeUJhTFe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="APgS05Sw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WeUJhTFe"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4U9vc3857955
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=a5zlzfeY9O9
	BtWUhcaXcJk+CitPtlA5QUiA0geh7SX4=; b=APgS05SwNAE2RMWp3ySNHg5b8f5
	whZIGIs9pYEkiYJPrMQfMQhE7CaoI7uJiulZdEKU3AoVT50dItW5IxvasAgxU6oH
	uEv49hGVEYXQoukhpPp/+vi+0ofQ0dM+E2pk3DbjMqjC64zvCr7vQf9VoVQWOZLF
	hp98WgPzT/q2514tfkZXdYaRlB6B4KusOx1puHwCvpGceI2w1h0DxOdy50aZBSf8
	naKhyYFScybbEdCmEKUAgNcgKjgu5sQiE+CbmhLY97VQ3ynO0FdF1BYQTI8w2uGv
	Kxf6XWeTGSQ95QEo3LUId5r+q3zsMWZfOpQJ8kfXPmeocfO+EtXJcuDZCWA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxffs1q5w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:48:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ac814f308so753283a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 23:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769500080; x=1770104880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5zlzfeY9O9BtWUhcaXcJk+CitPtlA5QUiA0geh7SX4=;
        b=WeUJhTFeKWokVc1uASoOhwSovBdi0R2OWT6EXDGLxchlsQPBl2GGCI+Hcrgn64XO1U
         ML5G9LKao3CZDmvslFBRuJxZ7rFq3zTvIwKec/7IjPpLK7yJLZYuKimnlEPMwyn9RN0p
         XUyHlPu7OV86m/RvFBaovQzFeqoHLu/AeUJ0x1ec75jY2u56+KD8BrqsXKMzFyjMNYcH
         XfQ/XC1ALEJkFZ0bEAWLiyR7IMJXJhzJaREEDFAEHq9ut0Im4AAACTWUX97TiBovY/07
         Bq/nn2o+mjJsF5Hz7TVvmiUzDQ9r2SH40/wqJaEcMTNCYdnBO+RBITtkQ8P2rj+9yYSl
         e17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769500080; x=1770104880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a5zlzfeY9O9BtWUhcaXcJk+CitPtlA5QUiA0geh7SX4=;
        b=a/F/QhSquhDkYv7N8V+leiqDg4Z/8zntsWp2kZdyjK/c75l7NhSwrUJJS12bwLsd/7
         g2AAPMDT+/AFP5lK+gEHqrAzQnnZZzLpJJfnkmn6AUs/crOlCxfLSFZrRlSnq+9H41xw
         bffDULwRXtGF3Rf7OXGY4eHwAa7nZN5CIfS8PD4bJ4QhI0UtoQhYVVVWpLaN+sEoURfP
         VClOjKh/2oREqac50CLCKWJ42VfjfWOlwEZVbnX1XXB48FkEXw6TioZErZDgGwRppwaV
         kXAoisyf8xisNr7AMGncK9eI8c6Z041GVlalYe9K6/BiaR8Tm/zlJ59saHoyJqqNCGG7
         e71g==
X-Gm-Message-State: AOJu0Yy23k5nvelM5WGVPNAorcsp9eT5mv+QTuhUj1k5SgMmcsUnxIRv
	5Dm1rkFXuHTUst/gRTuDxNiCekD5P3bVlm/Z7MYr7wNNoJAHEYvoWu4hznlqKPMYGLxlbMTPJfR
	Y75siXJmXqgkip+Wpk7cMKieqMIiAPDTzZ8T6FBM61mPM/qAx5mg9Zyg01VwxC7PohL0sDj0Wqw
	dz5/Y=
X-Gm-Gg: AZuq6aJ1Tyk6Cyu/YZ8HsG9tgP4zBNBOJA//+6JUD/jW9IJ2+O1S7A6+SBN5t0xIK46
	LL2Qo9a2Fap9a2k2kKOzp3PfHq45c7+d+wi7dOj8xXea0oARrBzglwUQj3M87XwARyfKMqLCSH6
	ks1c4ROTwNsXGuLlzEC4eYF3qjRdyyqcKEIUf7AT8Ux10x3CnChW8X1PWNvCAwpOCx/bw620JeZ
	0l5FyilYCnsaDzFXTCSSeZlVDBei5irZ4mivxNLpriQud42wkks9qUrFzjuu4xpVWzxIU6rI7CG
	vGBF1QszeeKhO8e/47g5R09Pi1DAR4aigqABYFntAs8fwu0tsi2HE3jA7EQrvWoq5N3ioNG9fDH
	mFaSHHPtn5na4LfHyd0diTC9sjahfCtwmD7NkVYp3fY5UIEjE
X-Received: by 2002:a17:903:2acd:b0:2a1:10f7:9718 with SMTP id d9443c01a7336-2a870e18919mr11075285ad.30.1769500079743;
        Mon, 26 Jan 2026 23:47:59 -0800 (PST)
X-Received: by 2002:a17:903:2acd:b0:2a1:10f7:9718 with SMTP id d9443c01a7336-2a870e18919mr11075135ad.30.1769500079180;
        Mon, 26 Jan 2026 23:47:59 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcfaf7sm109483675ad.34.2026.01.26.23.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 23:47:58 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v2 5/5] profiles: Add Ranging Profile (RAP) implementation.
Date: Tue, 27 Jan 2026 13:17:45 +0530
Message-Id: <20260127074745.2984874-6-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127074745.2984874-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260127074745.2984874-1-prathibha.madugonde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: voJrWsFY3aGI9HjBFrmsX5zUQiFfPhAS
X-Authority-Analysis: v=2.4 cv=YpcChoYX c=1 sm=1 tr=0 ts=69786db1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3RD4Na1Ei-b115O2o2gA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: voJrWsFY3aGI9HjBFrmsX5zUQiFfPhAS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA2MiBTYWx0ZWRfX+niQq7DH9kOB
 MYU8VFNCId2pfxHnze2t1M2BLQuNgbxCYcSiYzHaPjjH8V2szfYkGpVF6EygENabteqgI4IjasS
 BX1F7+kTXiJYnuodTvblHi3n5ASTIbeTkOz0o5XO0x7xI3nOYDmBeFCW7D82BX2F3ER9ZRhXT5e
 8yYtQind/TqnIgtH7wM9bRn3lvbEa1oeFgyIe6aSsBxVq2tj10wTHN5cOUyiF1AxIQgQZgUPcSb
 T71aPx60UpOfTdOjwLA28loNKUfydNEZetGO4g3e4bc9hgsn+Lu9lvteQqiJSB1MVI8gRcVt5l3
 n9Aq1jMf8qnj8B6fS3XgwPi6H2197DOc0qVbZFoHWlZ37/L9Y6rTkPRtMZAWed+3BfOCMMjCU5b
 QW/bu+edF2rwP73byRmvlRf2KJsLPUM267NwMCRwVPMkgcrooxHyEfo8L+nLGTNfWYY/vB1dlJh
 JSbkbKV6nSZGZFeH5dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270062

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


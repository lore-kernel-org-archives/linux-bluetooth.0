Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC9E15530C
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536157; cv=none; b=nsfjN/Y8PhAiF+Yc760XUQudbp8/EEn0Y+OLVC8NXOareuLRXgxC0k8QKdhpoWZfa0e1WsslPe5TdENq4UE+YTrrF79a/d6eWxqv6zVX0WTjebXCKon6Psx+vQYkOB6haggEpON136gqTpOGgqkCEfi8BxkwYB/MYLV/A4AQTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536157; c=relaxed/simple;
	bh=qGvOwUH0NcCgnT8FIOXQaEYEjmksgO+1CEbqh1h/wqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X3TqAWd94eRZvY8uPGnGNNHdZkJq06RkJru+4nQUd4WuHXfDuYsfnUATmawBb8bRcz3RcgvTuJhioblsQc+aMAB1a1by8runkl6oJme7M6gwf56mdCnYP4jcAnPW2LfG9vr2+11S7ncT18/89hC0y3M5Z5EejXWE3+z7PuO/wbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BI49aia/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V65l3VEB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BI49aia/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V65l3VEB"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RFMBkp621762
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=aBBmriJhwSz
	ybFP096kU83H3+3LWHpq1k6nL37mZKZM=; b=BI49aia/MDygtrta5z4I+YWy+0c
	mU40FZN/2WvLizkFQGPmZODFyxFtWi8ZJEefKfhPYaPe/QwdNBo5hwJ1jlXv7J2X
	TpTcLeVRV8uewYfFRP+ydCTLU/p9YXfQQ2adSQab5a/HWGLrTHNd1dh83ZdVPWjn
	Yjbu67FPAmVCWiOBbpfhXThGWIrU/uGO2v7zmZX+lF9nxyp2mFjYreLQcGNx+wlS
	4bdqmGqwXLcHlxKZwKXD2V1NP4BVQqXsAVTojb7F7iDDTaQZa2rtdMElBfYPtc8d
	qOGG7loB+9HpGpjBlK/vVhKn2VEssyvVkEr5Et3UmcT/tmbW9TK0BQvKktw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjehwv5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a7b7f04a11so25944475ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769536153; x=1770140953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBBmriJhwSzybFP096kU83H3+3LWHpq1k6nL37mZKZM=;
        b=V65l3VEBMzEp0MsAluc4Rx+bHjoyCFes3eTwaXapP4haaBwbHiPVuayaTIUZDONez8
         PS518Q+F7t9bApwPZO6jKE3qLTNYYastlpMrmZHrjDs92gjlKSckrtSHSTGm+icoBRZ/
         BPHtwlNKNd1Ou+YFE23Ikogv8QIp5AoW0nci4zBTEldIi0UV6PX0QBukIKC1FqfnLO8C
         +ZXKxIcbv6KkY9N3YB0LzSYVRuNcpEReCrK1pAANuSZlUL7PK/S4sSYLbHdPja2CcBQp
         WHVgE/I6o5U6UR/T9U+ZfsvedyoE3uitB6oBMs+fIP0VTJCOH5DOUvUtmd/grPmkmnEb
         WLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536153; x=1770140953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aBBmriJhwSzybFP096kU83H3+3LWHpq1k6nL37mZKZM=;
        b=MsTlkVQ5SOQBajPYsbmybt+umHKMcn+KT1AhphA6/xJPnOxUf5teCrcxS8WEhLzyWP
         bOFPiecBkav0hw2b3AIZBYNDnld9u3lL1fvzGuMV9xKzCGp5eO+aEGCw4Z/KZF+cezE/
         Sq8f1Ymqezx4Ii3WkdGGhKdeoyJEShORZb+oXaZS++wTkX1m6eN7nXcoMaYmntPorZ6K
         LK/hbVSgk2gu+2GGoKEHh20H6ScY314CcWlSS4lBgJGEawJUWw8gZOTrdJ78TPpY/fRg
         actaucQ450eKbiqNA7SZP4JRZOne47wWp6IONBV4CL4qghtTSGkK13qfmQ69qRxMR8zS
         K/jw==
X-Gm-Message-State: AOJu0YzLqd3i0v5NCJxF9ieTAB5dUNwDgVC5KR18+hi6YGbdUrdRJbjc
	JkIxWGSP73tWGt1iGH9isvWJuYBLV6mhdB7ItQZgb7443L/krUdBwxYgzQYaN4UPNF/hIHfWood
	toQk0PWIdWRQgCQ3yPKGHTUyAt0GZzGwMnAJA1E4jjgXhvl9LfU9iuCLxww1+5gD0fFF3HlokuR
	IiihE=
X-Gm-Gg: AZuq6aJwz/kVHPTSsePgLwuS4S7jlzR/TGllfjDSeyzaN7pQJqtL6v+5AGp7e4PGtT5
	jtDwlzc7Apjj2NkyS426NdxVeIG8gSmEKWSAMaPZaTrKM/LFRgGCNupFevvuCETC6uy0uN+dspg
	2igDG8LqX4xXnnBz7XCdXCR+2OQ6WeUpi7P7itbex4v7Hsbxf1uPcAWZAMOoovX2spc8Ra/T5JF
	Jupk1MsxLndnl2ynzoWMq/iigNka28393I4YY951EUuDeNuNlR0Rn5Mw/yVkQsSwMse31BLIJOb
	Sx+UuzSgqNY3PwWy00QzF3aHJr6gZ41vmFbvHUdeYCefDLZtcyW+E26XsI+q4MrfUQe+2Io9i8q
	KqFCXuFnmdSD9SQgJnDtKO1P2bV1nXmjJEJD5CGx24zMHnV6u
X-Received: by 2002:a17:902:ce82:b0:2a3:ec72:f462 with SMTP id d9443c01a7336-2a870db921emr22971115ad.25.1769536152500;
        Tue, 27 Jan 2026 09:49:12 -0800 (PST)
X-Received: by 2002:a17:902:ce82:b0:2a3:ec72:f462 with SMTP id d9443c01a7336-2a870db921emr22969855ad.25.1769536151613;
        Tue, 27 Jan 2026 09:49:11 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e5fb0sm110385ad.91.2026.01.27.09.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 09:49:11 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v5 5/5] profiles: Add Ranging Profile (RAP) implementation
Date: Tue, 27 Jan 2026 23:18:56 +0530
Message-Id: <20260127174856.3418323-6-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127174856.3418323-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260127174856.3418323-1-prathibha.madugonde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0NSBTYWx0ZWRfX7kuS5LyHPFXQ
 Gx1+oIDFoYRS4oyQMAdsV+bTLX//63K3uS0XhkWiDgX4KJiuItdnk6MRq/5tM733oylgXKE5WeI
 a7em5I+vUb5L6i8EpQ3/ka3XWK7zVnevo/FyaNNKCEjo/0Idk9+66Nh1YNHmL7TpnDbtLT8NWMP
 +M8Xqf4tmyiUKV4JJz+lz7ZTBR/BiYYgnWXOVJufcloiG08nFYUmkcTeX9V1Pmoj/hNi1sFkhP6
 enk0jH0Vr3YSyOJ+5Ivyzjayxe4Jyy2XMdOAhQYU5XdcrtT5qnkm0YnuwiZY9dldI5GfRoc5r8x
 QXdlgqYm0MG3s6r0d9/cIQeDRVI0tLtEZ++3o8+kkklaoPOQWNI4/RiOxwncFmXGac1w3ehGLNK
 38TEhgmwkpby8jlsH6xmc4lYtvoa6TcQQoeS6SgTT9aKHStOChD7ok8qVCCliQ2Blf/paeF3/0g
 9SjTK/jS3ZWYv/16Dyg==
X-Authority-Analysis: v=2.4 cv=Qelrf8bv c=1 sm=1 tr=0 ts=6978fa9a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3RD4Na1Ei-b115O2o2gA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: dEUzuwHVjfTFAeGBEmoX-dGO56ES2zL1
X-Proofpoint-GUID: dEUzuwHVjfTFAeGBEmoX-dGO56ES2zL1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270145

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


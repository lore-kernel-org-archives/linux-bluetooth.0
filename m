Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCD415F32
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529063; cv=none; b=YDqfMwYjdtqvD1juecrkHBLZkvSoJTqJlYD3Ckj/GYA2yXtQxDXLdH9U54T12Cc9r0chRqy1zD3Eh3uiBl5er61ekIvQls/wb0zR18s0Z0c5eH/wTvFLWbnSzRm1Zl/R17YVJCK5yfUfH5IKSEc+wF28A2Q0rtMcJ5bFYTtTTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529063; c=relaxed/simple;
	bh=4ryeJuDD/lwfs1QVuEGJromA8KckZT5au2r0yvNT3X4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lsFcYuSbQflx05wZ5Feb3lgmASfYQkUHLIArdThrWu9lqhKIVGjku0QyCqDaXuxQBNP7/J2neAZsmwTv5VjbeNB+TUatRBs39PR94PlQrVGZqjH6ZRKGkvXOqFhHB0VcPfWjKqwYkIj6VfYAkGrMnEQYtWidK8SCppuvT5Daxb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bbdFrh1S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f7VdZ6vV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bbdFrh1S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f7VdZ6vV"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C9g1VP385810
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=X349U5PYAju
	VkgYbrfbLIGdjM76T2umem2344Y3mlVQ=; b=bbdFrh1SnhvQiYG2pGdbNMMkNkO
	un/1dnQg9NF/v00kaSdA0zOfWbtT8zlIgTDG0mrzkVHlVPEYeIMZqfutpZuCUo4r
	QiS+EIgh+LxIvn2t+mXbOaC1DFoK1ha1o3LZnkqzPEdZglcxBE7tSzlPPE3W/bch
	JW45CDkHDCgDLehy7JTjrrxgnRDBGeSqmEYwvDXKQlMXx2mI8TJmI+5QaZeX3hUc
	SEJybFRkuZnP6vBgWWLpkJjxJ0disCz1iHxxSdP2FWJjQvEXG7j9k7vdCnW6sMUf
	2luKOLDjL50w+No8UFfTe5OGuQji691hhy3O9iHMkqQHaS17wBvV4zm62sw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nut8800-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:04:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e7621655eso1268971a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786529056; x=1787133856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X349U5PYAjuVkgYbrfbLIGdjM76T2umem2344Y3mlVQ=;
        b=f7VdZ6vVTrNAHJO9ROKbSTki/aJmU+1JcJLeBFA5auwrnlv3u09jI2g1xLQa/Mmtr6
         g31NgqHe1Xr7z16TeL8guARnab9dBxu2JsqatG+apCBZTpI8W4UaZiSPC9zCb6r5ddzN
         GWSNDeh/Vsl9Gpw/vzZUUccJHvGeP3oEEOF1VnyCEV9RWLDQSu7XjztNZZZ4RJ05SOze
         1nUrQ4ecdRSliGt68Z2XyltZqE66XFhor1c2I3QuBwgan54wCzhLI38lVHKp35ds0NE8
         YyL4FV9rn1B+XayjmsbRhsFeXP1vMTnqdAZHzn0Sb352LQOqH1E2TAh1EAaZ35lhnq3J
         1iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786529056; x=1787133856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X349U5PYAjuVkgYbrfbLIGdjM76T2umem2344Y3mlVQ=;
        b=GL9eUNa2rY9x1f90giysSYyBxlIB54uFh1vDbTuMUJZ4QPFBi6ZQWBSfiKVFa51pvj
         6hMey9XDM6GqaOQ4aWrPJX2+YfhdOiuKKYQFqQDOVUo7DmBhLi18mtYpXVfG97qcBC47
         4NMLkFnLMcuGGSx8lIIPawdMz4caiHlFx/d9LkfMBnsmZWzHFMNJEU/apIaVg1THbI0j
         TV3EolCoIKGCuyEivMhGulxb1jRp89wwDVrqX6sOl/IppMBoI8k5Lp2zRgbNEaKXEZy8
         nmelawFpyCIOHONCOWgBAYIR/FnPZjozbRTIUu3QnJDuawhdPTzKhVRD2iJdn3L1Xl0A
         RzKQ==
X-Gm-Message-State: AOJu0YyQcoXtIGpaxntGnk8TbB4fgfTuGRgjI4aPV5nnWxdMpQOTzRfk
	DOEd4FvZxJHXBZic1NuclKK0Fj1RIoIezGYjoeaNbfCwTImqDZevhX0T0FNYp6f7181Kqx8V2EY
	lZRe2q8YMq+spWuYzErT4HnjA00HB4U+8Pyn3Fj14hQcSTULC405pn2vXzs2YtrMX6nqgHTSQcL
	rTSTU=
X-Gm-Gg: AR+sD13B9mqRJ3TlSiLy94NMQQ41Hn9aBKiDzyAea/k3lm8CCQd2egJGxJms5oYV+ZT
	5NUrWK8LNk3iUE9fExyYP1J5PhJMAHbb3BZIyQ3z0pikvp9uYFZHgMkxteAGz9OeveVNxD4K5uK
	Hpkfj8ds/L3rH2PfisfckR6NRBaTsxbOM7rH7YEwXC/nbXx9WDc/laGG09+TLcpudQX2yVHe/4k
	R0LbykBnzd0qNiokNKPzUy5Y7HxFIoiJwv5B8596WN3o5KIooAAugQlK+/oj2/czmVSYc64yK3M
	qLj6NbwTsuJ+XDbzv+WhMswxhhAuQX+aI7HYSbfYbQcbQuqS0gxswr6/TBxH8iipKk2ScIp50cq
	/UZqiJmfPSndGiuZiD2yFfbYMy6sT/g==
X-Received: by 2002:a17:90b:4e8c:b0:381:11eb:d78e with SMTP id 98e67ed59e1d1-3930165f4c8mr4059928a91.14.1786529055756;
        Wed, 12 Aug 2026 03:04:15 -0700 (PDT)
X-Received: by 2002:a17:90b:4e8c:b0:381:11eb:d78e with SMTP id 98e67ed59e1d1-3930165f4c8mr4059828a91.14.1786529055176;
        Wed, 12 Aug 2026 03:04:15 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf628e2aasm11069961eec.14.2026.08.12.03.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:04:14 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <nakella@qti.qualcomm.com>
Subject: [PATCH BlueZ v2 4/5] rap: Add CS Distance provider D-Bus API
Date: Wed, 12 Aug 2026 15:33:44 +0530
Message-Id: <20260812100345.2956271-5-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812100345.2956271-1-naga.akella@oss.qualcomm.com>
References: <20260812100345.2956271-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfXxNWf6avdiREJ
 bwVTNU+hQyIH/jmWNalF5rNld1kENPG5MnjZ+l3eIjRJtr/50iY1wqvjoy1TiLenTrvK5Qc8Arw
 YW+TWjoBN+96LWyZ71eAgmk/2u4fU6w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4MCBTYWx0ZWRfX4jh2z64SVBVw
 xIR/oJfpo5yc3036LPEDFtomOtvva+3eeV/T4UTdEiFsIoSP5I8KbbZaqs1dHHTi1j2Ak+ZHB0a
 6KdJ1/UGzfXaoggHBsZawNo6TY++n5pQxVoSjM/WF3GKdfHXZr0ErgfTSd6vUn/URGqX7XnnQCx
 z5QuTyzsNygENaOlQd9PhgKogpmOg3FQpqsEaY/JqzSFY/xywMwg2RtVK0lOkV+cgF4vMil6MRl
 SidXDVg6KNJZCuR/fg9PG8ObuUsHwfZYumQrIhwlw3WV377e77ku1abXEHBafSvyjjkGRPqmjMq
 KbuM6jZQZtfQHqCrjGjIvtweVHZ2tFYICvQ0EtAJT62r8Ono+nGkOFHEuN9s3PzJVM6uFnxWF6B
 Gt4Jxel6w/c0qPTIDSbMlfMalOceGXYafIr69Y/Q7pq7w9TPSDKhnWOBV2qonp5/GdVoSvxvvpt
 hl6I7T0ku01g2XQnMSQ==
X-Proofpoint-ORIG-GUID: 8asxUeqBeItvjMi_-AE3CDRv7kJiayUF
X-Authority-Analysis: v=2.4 cv=POA/P/qC c=1 sm=1 tr=0 ts=6a7c4520 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=iAU4M8Ap3GhHlBsa1nUA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 8asxUeqBeItvjMi_-AE3CDRv7kJiayUF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120080

From: Naga Bhavani Akella <nakella@qti.qualcomm.com>

Introduce org.bluez.CSDistance1 and org.bluez.CSDistanceProvider1/
CSDistanceProviderManager1 D-Bus interfaces following the existing
Battery Provider design.

External providers can register a root path
via RegisterDistanceProvider and expose per-device
CSDistanceProvider1 objects; updates to their DistanceMeters
property are mirrored onto exported CSDistance1 objects via
btd_cs_distance_update(), emitting a PropertiesChanged signal.

The CS provider manager is wired into the adapter lifecycle,
created on adapter setup and destroyed on adapter
removal, mirroring how battery_provider_manager is handled.
---
 Makefile.am       |   1 +
 src/adapter.c     |  12 +
 src/cs_distance.c | 578 ++++++++++++++++++++++++++++++++++++++++++++++
 src/cs_distance.h |  23 ++
 4 files changed, 614 insertions(+)
 create mode 100644 src/cs_distance.c
 create mode 100644 src/cs_distance.h

diff --git a/Makefile.am b/Makefile.am
index f003b041c..b6ac8b866 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -332,6 +332,7 @@ bluetoothd_internal_sources = \
 			src/eir.h src/eir.c \
 			src/adv_monitor.h src/adv_monitor.c \
 			src/battery.h src/battery.c \
+			src/cs_distance.h src/cs_distance.c \
 			src/settings.h src/settings.c \
 			src/set.h src/set.c \
 			src/bearer.h src/bearer.c
diff --git a/src/adapter.c b/src/adapter.c
index c21b3e7fb..3b35c7ca0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -67,6 +67,7 @@
 #include "adv_monitor.h"
 #include "eir.h"
 #include "battery.h"
+#include "cs_distance.h"
 
 #define MODE_OFF		0x00
 #define MODE_CONNECTABLE	0x01
@@ -336,6 +337,8 @@ struct btd_adapter {
 
 	struct btd_battery_provider_manager *battery_provider_manager;
 
+	struct btd_cs_distance_provider_manager *cs_distance_provider_manager;
+
 	GHashTable *allowed_uuid_set;	/* Set of allowed service UUIDs */
 
 	gboolean initialized;
@@ -7196,6 +7199,7 @@ static void adapter_remove(struct btd_adapter *adapter)
 {
 	GSList *l;
 	struct gatt_db *db;
+	struct btd_cs_distance_provider_manager *cs_distance_manager;
 
 	DBG("Removing adapter %s", adapter->path);
 
@@ -7230,6 +7234,11 @@ static void adapter_remove(struct btd_adapter *adapter)
 	btd_battery_provider_manager_destroy(adapter->battery_provider_manager);
 	adapter->battery_provider_manager = NULL;
 
+	cs_distance_manager = adapter->cs_distance_provider_manager;
+
+	btd_cs_distance_provider_manager_destroy(cs_distance_manager);
+	adapter->cs_distance_provider_manager = NULL;
+
 	g_slist_free(adapter->pin_callbacks);
 	adapter->pin_callbacks = NULL;
 
@@ -9645,6 +9654,9 @@ static int adapter_register(struct btd_adapter *adapter)
 	adapter->battery_provider_manager =
 		btd_battery_provider_manager_create(adapter);
 
+	adapter->cs_distance_provider_manager =
+		btd_cs_distance_provider_manager_create(adapter);
+
 	/* Don't start GATT database and advertising managers on
 	 * non-LE controllers.
 	 */
diff --git a/src/cs_distance.c b/src/cs_distance.c
new file mode 100644
index 000000000..ac2fd1d9c
--- /dev/null
+++ b/src/cs_distance.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <glib.h>
+
+#include "gdbus/gdbus.h"
+#include "bluetooth/bluetooth.h"
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+#include "cs_distance.h"
+#include "dbus-common.h"
+#include "adapter.h"
+#include "device.h"
+#include "log.h"
+#include "error.h"
+
+#define CS_DISTANCE_INTERFACE "org.bluez.CSDistance1"
+#define CS_DISTANCE_PROVIDER_INTERFACE "org.bluez.CSDistanceProvider1"
+#define CS_DISTANCE_PROVIDER_MANAGER_INTERFACE \
+	"org.bluez.CSDistanceProviderManager1"
+
+struct btd_cs_distance {
+	char *path; /* D-Bus object path */
+	double meters; /* Estimated distance to the remote device */
+	bool has_value; /* false until the first estimate is reported */
+	char *provider_path; /* The provider root path, if any */
+};
+
+struct btd_cs_distance_provider_manager {
+	struct btd_adapter *adapter; /* Does not own pointer */
+	struct queue *providers;
+};
+
+struct cs_distance_provider {
+	struct btd_cs_distance_provider_manager *manager; /* Does not own */
+
+	char *owner; /* Owner D-Bus address */
+	char *path; /* D-Bus object path */
+
+	GDBusClient *client;
+};
+
+static struct queue *distances;
+
+static void provider_disconnect_cb(DBusConnection *conn, void *user_data);
+
+static void distance_add(struct btd_cs_distance *distance)
+{
+	if (!distances)
+		distances = queue_new();
+
+	queue_push_head(distances, distance);
+}
+
+static void distance_remove(struct btd_cs_distance *distance)
+{
+	queue_remove(distances, distance);
+	if (queue_isempty(distances)) {
+		queue_destroy(distances, NULL);
+		distances = NULL;
+	}
+}
+
+static bool match_path(const void *data, const void *user_data)
+{
+	const struct btd_cs_distance *distance = data;
+	const char *path = user_data;
+
+	return g_strcmp0(distance->path, path) == 0;
+}
+
+static struct btd_cs_distance *distance_new(const char *path,
+					    const char *provider_path)
+{
+	struct btd_cs_distance *distance;
+
+	distance = new0(struct btd_cs_distance, 1);
+	distance->path = g_strdup(path);
+	if (provider_path)
+		distance->provider_path = g_strdup(provider_path);
+
+	return distance;
+}
+
+static void distance_free(struct btd_cs_distance *distance)
+{
+	if (distance->path)
+		g_free(distance->path);
+
+	if (distance->provider_path)
+		g_free(distance->provider_path);
+
+	free(distance);
+}
+
+static gboolean property_distance_get(const GDBusPropertyTable *property,
+				      DBusMessageIter *iter, void *data)
+{
+	struct btd_cs_distance *distance = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_DOUBLE,
+				       &distance->meters);
+
+	return TRUE;
+}
+
+static gboolean property_distance_exists(const GDBusPropertyTable *property,
+					 void *data)
+{
+	struct btd_cs_distance *distance = data;
+
+	return distance->has_value;
+}
+
+static const GDBusPropertyTable cs_distance_properties[] = {
+	{ "DistanceMeters", "d", property_distance_get, NULL,
+	  property_distance_exists },
+	{}
+};
+
+struct btd_cs_distance *btd_cs_distance_register(const char *path,
+						 const char *provider_path)
+{
+	struct btd_cs_distance *distance;
+
+	DBG("path = %s", path);
+
+	if (queue_find(distances, match_path, path)) {
+		error("error registering CS distance: path exists");
+		return NULL;
+	}
+
+	if (!g_str_has_prefix(path, "/")) {
+		error("error registering CS distance: "
+		      "invalid D-Bus object path");
+		return NULL;
+	}
+
+	distance = distance_new(path, provider_path);
+	distance_add(distance);
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+				       distance->path, CS_DISTANCE_INTERFACE,
+				       NULL, NULL, cs_distance_properties,
+				       distance, NULL)) {
+		error("error registering D-Bus interface for %s",
+		      distance->path);
+
+		distance_remove(distance);
+		distance_free(distance);
+
+		return NULL;
+	}
+
+	DBG("registered CSDistance object: %s", distance->path);
+
+	return distance;
+}
+
+bool btd_cs_distance_unregister(struct btd_cs_distance *distance)
+{
+	DBG("path = %s", distance->path);
+
+	if (!queue_find(distances, NULL, distance)) {
+		error("error unregistering CS distance: "
+		      "distance %s is not registered",
+		      distance->path);
+		return false;
+	}
+
+	if (!g_dbus_unregister_interface(btd_get_dbus_connection(),
+					 distance->path,
+					 CS_DISTANCE_INTERFACE)) {
+		error("error unregistering CS distance %s from "
+		      "D-Bus interface", distance->path);
+		return false;
+	}
+
+	distance_remove(distance);
+	distance_free(distance);
+
+	return true;
+}
+
+bool btd_cs_distance_update(struct btd_cs_distance *distance, double meters)
+{
+	DBG("path = %s", distance->path);
+
+	if (!queue_find(distances, NULL, distance)) {
+		error("error updating CS distance: distance is not "
+		      "registered");
+		return false;
+	}
+
+	distance->meters = meters;
+	distance->has_value = true;
+
+	info("CS distance updated: path = %s, meters = %f", distance->path,
+	     meters);
+	fprintf(stderr, "CS distance updated: path = %s, meters = %f\n",
+		distance->path, meters);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				     distance->path, CS_DISTANCE_INTERFACE,
+				     "DistanceMeters");
+
+	return true;
+}
+
+static struct btd_cs_distance *find_distance_by_path(const char *path)
+{
+	return queue_find(distances, match_path, path);
+}
+
+static void provided_distance_property_changed_cb(GDBusProxy *proxy,
+						   const char *name,
+						   DBusMessageIter *iter,
+						   void *user_data)
+{
+	double meters = 0;
+	const char *export_path;
+	DBusMessageIter dev_iter;
+
+	if (g_dbus_proxy_get_property(proxy, "Device", &dev_iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&dev_iter, &export_path);
+
+	if (strcmp(name, "DistanceMeters") != 0)
+		return;
+
+	if (iter) {
+		if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_DOUBLE)
+			return;
+
+		dbus_message_iter_get_basic(iter, &meters);
+	}
+
+	DBG("CS distance changed on %s, meters = %f",
+	    g_dbus_proxy_get_path(proxy), meters);
+
+	btd_cs_distance_update(find_distance_by_path(export_path), meters);
+}
+
+static void provided_distance_added_cb(GDBusProxy *proxy, void *user_data)
+{
+	struct cs_distance_provider *provider = user_data;
+	struct btd_cs_distance *distance;
+	struct btd_device *device;
+	const char *path = g_dbus_proxy_get_path(proxy);
+	const char *export_path;
+	double meters;
+	DBusMessageIter iter;
+
+	if (strcmp(g_dbus_proxy_get_interface(proxy),
+		   CS_DISTANCE_PROVIDER_INTERFACE) != 0)
+		return;
+
+	if (g_dbus_proxy_get_property(proxy, "Device", &iter) == FALSE) {
+		warn("CS distance object %s does not specify device path",
+		     path);
+		return;
+	}
+
+	dbus_message_iter_get_basic(&iter, &export_path);
+
+	device = btd_adapter_find_device_by_path(provider->manager->adapter,
+						 export_path);
+	if (!device || device_is_temporary(device)) {
+		warn("Ignoring non-existent device path for CS distance %s",
+		     export_path);
+		return;
+	}
+
+	if (find_distance_by_path(export_path)) {
+		DBG("CS distance for %s is already provided, ignoring the "
+		    "new one", export_path);
+		return;
+	}
+
+	g_dbus_proxy_set_property_watch(proxy,
+		provided_distance_property_changed_cb, provider);
+
+	distance = btd_cs_distance_register(export_path, provider->path);
+
+	DBG("provided CS distance added %s", path);
+
+	/* DistanceMeters property may not be immediately available, that's
+	 * okay since we monitor changes to this property.
+	 */
+	if (g_dbus_proxy_get_property(proxy, "DistanceMeters", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &meters);
+
+	btd_cs_distance_update(distance, meters);
+}
+
+static void provided_distance_removed_cb(GDBusProxy *proxy, void *user_data)
+{
+	struct cs_distance_provider *provider = user_data;
+	struct btd_cs_distance *distance;
+	const char *export_path;
+	DBusMessageIter iter;
+
+	if (strcmp(g_dbus_proxy_get_interface(proxy),
+		   CS_DISTANCE_PROVIDER_INTERFACE) != 0)
+		return;
+
+	if (g_dbus_proxy_get_property(proxy, "Device", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &export_path);
+
+	DBG("provided CS distance removed %s", g_dbus_proxy_get_path(proxy));
+
+	distance = find_distance_by_path(export_path);
+	if (!distance)
+		return;
+
+	if (g_strcmp0(distance->provider_path, provider->path) != 0)
+		return;
+
+	g_dbus_proxy_set_property_watch(proxy, NULL, NULL);
+
+	btd_cs_distance_unregister(distance);
+}
+
+static bool match_provider_path(const void *data, const void *user_data)
+{
+	const struct cs_distance_provider *provider = data;
+	const char *path = user_data;
+
+	return strcmp(provider->path, path) == 0;
+}
+
+static void unregister_if_path_has_prefix(void *data, void *user_data)
+{
+	struct btd_cs_distance *distance = data;
+	struct cs_distance_provider *provider = user_data;
+
+	if (g_strcmp0(distance->provider_path, provider->path) == 0)
+		btd_cs_distance_unregister(distance);
+}
+
+static void cs_distance_provider_free(gpointer data)
+{
+	struct cs_distance_provider *provider = data;
+
+	/* Unregister distances under the root path of provider->path */
+	queue_foreach(distances, unregister_if_path_has_prefix, provider);
+
+	if (provider->owner)
+		g_free(provider->owner);
+
+	if (provider->path)
+		g_free(provider->path);
+
+	if (provider->client) {
+		g_dbus_client_set_disconnect_watch(provider->client, NULL,
+						   NULL);
+		g_dbus_client_set_proxy_handlers(provider->client, NULL, NULL,
+						 NULL, NULL);
+		g_dbus_client_unref(provider->client);
+	}
+
+	free(provider);
+}
+
+static struct cs_distance_provider *
+cs_distance_provider_new(DBusConnection *conn,
+			 struct btd_cs_distance_provider_manager *manager,
+			 const char *path, const char *sender)
+{
+	struct cs_distance_provider *provider;
+
+	provider = new0(struct cs_distance_provider, 1);
+	provider->manager = manager;
+	provider->owner = g_strdup(sender);
+	provider->path = g_strdup(path);
+
+	provider->client = g_dbus_client_new_full(conn, sender, path, path);
+
+	if (!provider->client) {
+		error("error creating D-Bus client %s", path);
+		cs_distance_provider_free(provider);
+		return NULL;
+	}
+
+	g_dbus_client_set_disconnect_watch(provider->client,
+					   provider_disconnect_cb, provider);
+
+	g_dbus_client_set_proxy_handlers(provider->client,
+					 provided_distance_added_cb,
+					 provided_distance_removed_cb, NULL,
+					 provider);
+
+	return provider;
+}
+
+static void provider_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct cs_distance_provider *provider = user_data;
+	struct btd_cs_distance_provider_manager *manager = provider->manager;
+
+	DBG("CS distance provider client disconnected %s root path %s",
+	    provider->owner, provider->path);
+
+	if (!queue_find(manager->providers, NULL, provider)) {
+		warn("Disconnection on a non-existing provider %s",
+		     provider->path);
+		return;
+	}
+
+	queue_remove(manager->providers, provider);
+	cs_distance_provider_free(provider);
+}
+
+static DBusMessage *register_distance_provider(DBusConnection *conn,
+						DBusMessage *msg,
+						void *user_data)
+{
+	struct btd_cs_distance_provider_manager *manager = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	DBusMessageIter args;
+	const char *path;
+	struct cs_distance_provider *provider;
+
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &path);
+
+	DBG("register CS distance provider path = %s", path);
+
+	if (!g_str_has_prefix(path, "/"))
+		return btd_error_invalid_args(msg);
+
+	if (queue_find(manager->providers, match_provider_path, path)) {
+		return dbus_message_new_error(msg,
+					      ERROR_INTERFACE ".AlreadyExists",
+					      "Provider already exists");
+	}
+
+	provider = cs_distance_provider_new(conn, manager, path, sender);
+	queue_push_head(manager->providers, provider);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_distance_provider(DBusConnection *conn,
+						  DBusMessage *msg,
+						  void *user_data)
+{
+	struct btd_cs_distance_provider_manager *manager = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	DBusMessageIter args;
+	const char *path;
+	struct cs_distance_provider *provider;
+
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &path);
+
+	DBG("unregister CS distance provider path = %s", path);
+
+	provider = queue_find(manager->providers, match_provider_path, path);
+	if (!provider || strcmp(provider->owner, sender) != 0) {
+		return dbus_message_new_error(msg,
+					      ERROR_INTERFACE ".DoesNotExist",
+					      "Provider does not exist");
+	}
+
+	queue_remove(manager->providers, provider);
+	cs_distance_provider_free(provider);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable methods[] = {
+	{ GDBUS_METHOD("RegisterDistanceProvider",
+				    GDBUS_ARGS({ "provider", "o" }), NULL,
+				    register_distance_provider) },
+	{ GDBUS_METHOD("UnregisterDistanceProvider",
+				    GDBUS_ARGS({ "provider", "o" }), NULL,
+				    unregister_distance_provider) },
+	{}
+};
+
+static struct btd_cs_distance_provider_manager *
+manager_new(struct btd_adapter *adapter)
+{
+	struct btd_cs_distance_provider_manager *manager;
+
+	DBG("");
+
+	manager = new0(struct btd_cs_distance_provider_manager, 1);
+	manager->adapter = adapter;
+	manager->providers = queue_new();
+
+	return manager;
+}
+
+static void manager_free(struct btd_cs_distance_provider_manager *manager)
+{
+	if (!manager)
+		return;
+
+	DBG("");
+
+	queue_destroy(manager->providers, cs_distance_provider_free);
+
+	free(manager);
+}
+
+struct btd_cs_distance_provider_manager *
+btd_cs_distance_provider_manager_create(struct btd_adapter *adapter)
+{
+	struct btd_cs_distance_provider_manager *manager;
+
+	if (!adapter)
+		return NULL;
+
+	manager = manager_new(adapter);
+	if (!manager)
+		return NULL;
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+				       adapter_get_path(manager->adapter),
+				       CS_DISTANCE_PROVIDER_MANAGER_INTERFACE,
+				       methods, NULL, NULL, manager, NULL)) {
+		error("error registering "
+		      CS_DISTANCE_PROVIDER_MANAGER_INTERFACE " interface");
+		manager_free(manager);
+		return NULL;
+	}
+
+	info("CS Distance Provider Manager created");
+
+	return manager;
+}
+
+void btd_cs_distance_provider_manager_destroy(struct
+	btd_cs_distance_provider_manager *manager)
+{
+	if (!manager)
+		return;
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				    adapter_get_path(manager->adapter),
+				    CS_DISTANCE_PROVIDER_MANAGER_INTERFACE);
+
+	info("CS Distance Provider Manager destroyed");
+
+	manager_free(manager);
+}
diff --git a/src/cs_distance.h b/src/cs_distance.h
new file mode 100644
index 000000000..b3cccd5cb
--- /dev/null
+++ b/src/cs_distance.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ *
+ */
+
+struct btd_adapter;
+struct btd_cs_distance;
+struct btd_cs_distance_provider_manager;
+
+struct btd_cs_distance *btd_cs_distance_register(const char *path,
+						 const char *provider_path);
+bool btd_cs_distance_unregister(struct btd_cs_distance *distance);
+bool btd_cs_distance_update(struct btd_cs_distance *distance, double meters);
+
+struct btd_cs_distance_provider_manager *
+btd_cs_distance_provider_manager_create(struct btd_adapter *adapter);
+void btd_cs_distance_provider_manager_destroy(struct
+	btd_cs_distance_provider_manager *manager);
-- 


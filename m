Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49189286881
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808073; cv=none; b=tlrqsrLLCH4UTvnEbuxfd/ZfXP6WXmyAYYesc34LDu0z46M2gQkmkcwbDaobla8pM5w+NfnHv/hqyPx5NOUDKJWSQeAZalnrr4VDybAxz6BJR3WyHE4D40tTYJZv6WLiosYeHiA1IjUWGgqpmiVwLypDzTSeoBTuZkX7znTLiPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808073; c=relaxed/simple;
	bh=FJtPaz9zLbE8LNyiiUCDotD+Dmmoz5ynvAIJpC18+OM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ciYf1JfB+Qrt0bPBMadUkMBjfBimNJqSuOofpzsjkVyAQgfsYYJxNb2P2kcruTtmyauiLHTAwEy6kFywvv5T9xllAACWT0BfTI3zYEMYbBpM+y7gCeAINAAr3B35Q/eSx0VRAm5Ay43WBiez+c82RJFnJZZKgOimVLIUlZz3ue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GWWqyZq4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HDo/cEsy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GWWqyZq4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HDo/cEsy"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3JXRk2863039
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JMtoRIEgeGi
	2FC70eTVI+ckuR8xik4Nu96X0a28ZcY4=; b=GWWqyZq42r+52NY3TKc9OT8hEhG
	SJbEdmiguq1PxYMwSMMvQFLjPNn3VyJvYnwc82btob8ZJ0a9GdGARLRV8647/76i
	ftSBpBA16LKMrSCzvIemBWXSpaSRLmEfAfL4o3nel7P6qqNDt3zrE7fncY7/GcTq
	+yjE8+3SemKn9I5AW1pEltVyyS46OcRjGjXMKL14Bt0aPCLo6mAyu9MPeqQiFt7I
	UJZpoZ1C7g/X1EOanxmP6DkxAZRnM9Xuk+/LhKIozX/6JP8v3VEVgLJ0YOVvZrTT
	MpVIbhNv3jIBHiaHafqx7Zf8EOHqGV1F+nZwRUFFs77AqIf+O6RYOPfoehA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga075ba3h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so2974337a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 22:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787808069; x=1788412869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JMtoRIEgeGi2FC70eTVI+ckuR8xik4Nu96X0a28ZcY4=;
        b=HDo/cEsyaPu4sSJ5K9D7ADulOTutag5XJabDIv93HOCfyGd5tNSO4kR9Kb3PW8s4W2
         RQdcdAOz2E/XVe2r8Q2vL5mHPVntEOPMYy0EJOZYQ9Gxih9baVC9gVpZc3weUEVoESYB
         rA3deNhJDF9g6xGpABm8T+NGMpXPqUpIozSjrBvWfaPvrhW8XkzgPONIgeseBYscQRrK
         zgoqKVVX7oChsda+kYybGqaxascIinAoZghtDKTYJZk5qljLJt+wWpwAwVqLA64bAPap
         rwtbEiT8U25wMCrCiJVqn5ZNIEg57s5X/JbrZh65ykyPdfQQLWtnYNfwSW7j6cIrRppo
         EfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787808069; x=1788412869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JMtoRIEgeGi2FC70eTVI+ckuR8xik4Nu96X0a28ZcY4=;
        b=cdbDKNdDiOLBxi6VS2k54vtbED8/r+v0elOnbso0msCrCPBRA1u30UYpT0VJSCF/At
         pqTUpG3nYZfHCeiuAmKtoNIPF8sMKXmgjpwN6xcZfk9MLGvNrRnvKpqLkwo0sYnT81ux
         mUKcIQcWkKc+fKSapeIAFF7Rt1FZZ2xLd1db9ykd9Y88PffV2rt2H5YWlJJTXvt73pSN
         J1t0B4TQ1PCnDAxc2Nlsb57ihf/mbrvBK4PnLc5fjAE5XVg0QuDTUEQaCb3oQ1nG66/U
         WMxczOdj03KcInvp/lC0cAmFrevsrBeZwq02HJPqa0sBC9q2mJTqNNpU7CTgwz7ogx01
         onlw==
X-Gm-Message-State: AFuF++lbHmz8lqYgv3SLkraJQtfD4a+ldWQOE04AsfT0lBSVG+5vxqZh
	LiyYxABtVEBZqlvvmXA7ehmw5kvuxoy+Ddh9Gm+xpQV6qNGxKdTEp14GRnAhdBNakca6vZu41uJ
	Cg4cRHWgUQbWIPjuLp/RgiMysb3mw6Gn4bFwhd9LUaj04bHSSiFVNd4QJkK1q2mt2PJIzSjP5zZ
	gzdY8=
X-Gm-Gg: AR+sD12b7l8D+Hd5b00LWxi9Kzr8UIzIGTPw5iKb0RV73PBP0ul9ysdfp2vdKtxGIjV
	n6xzsSetf41fyHVXyvpW18lqM1022W+NA4SXRCqSpjNSozp895fKHCuUlXok149Ot0WfSUUU9VV
	7H9qpfpalDDkdiXiS75lBG7TnTZYY1jRfOjRwQ8iPjlji2q9LG1270yGSijTKJ60OTILGD0Ch3D
	zlMmIPqHCQyWo0C6VY26DYFjWGTToYb3b2YFdEksvAXcwhSeFBB9lRxR/SvnxHRX9O9FoLCA907
	UKriHMC8T2zLx4Hw5DB9S9u7yDnBpYVACPMSdiCZ2ycvFfuE0AqqstLfU3fKN4r9mzodCKRTZPY
	jESSmDyoMkmeAnwl4Dxqb1hjtOCQeXg==
X-Received: by 2002:a17:90b:4a8d:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-3966d412ab2mr23346254a91.9.1787808068609;
        Wed, 26 Aug 2026 22:21:08 -0700 (PDT)
X-Received: by 2002:a17:90b:4a8d:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-3966d412ab2mr23346178a91.9.1787808068042;
        Wed, 26 Aug 2026 22:21:08 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9035c06sm11903265c88.10.2026.08.26.22.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:21:07 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 5/7] src: Add Ranging provider D-Bus API
Date: Thu, 27 Aug 2026 10:50:32 +0530
Message-Id: <20260827052034.1374180-6-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
References: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JO5QBtyQRBCyA6HfRGM2vz8AxkXTA42r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0MSBTYWx0ZWRfX7CUFhKPU7jte
 vj8OwkgETlVDaSxC3gPTSM2ssEF70YAA9Y0Se/kL5tQi+GlJqMmP20+PyZoON+NfSUWaJzlM/Wz
 Z1G8/bXZHrnKNtxVbcClifLVQVLE7i/w/EeTlPAeDD5WX0Yyo1dy4cbt1N3+DLPD6VIKE+Hvbji
 A9PTe3bAPQ/q7YwVKV9/xS4313mEVuCqMEi8nUYr7TBrN1ZfX8gMjVFKshpefsFm+eZzQvP1teE
 iffHm5HNjFvu1/fqkC1uZxZmexy4Cw6RsLHTpg5F8ig23WT6N2/N+urbAxDNddTitUaq12ORLJB
 xq9KHp44TCRKGX91Pa1vnNv4/XAx8RrDjCkNzdHH/sXzjS2fr2nLJ+uvjdvswiK0jaEApLmyprg
 VRJIGPdlU6UhZwU4mmRRaf7KJtWfXSj/+MqfWSLniVpW7x38LKT9hbw41mDG3SkG1QYsco19aud
 RqwCFMM6ii5iIhZGy0g==
X-Proofpoint-GUID: JO5QBtyQRBCyA6HfRGM2vz8AxkXTA42r
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0MSBTYWx0ZWRfX85nt5fEvT7PM
 /yjscrkEUQFTUKqt7mUEbvzNFiVqEsGo1arKWEqr2lAhdU0eYfkGLV5sqxCiSDlM3u9DoKhsQku
 XDgiw8F5xYv8N4vQ0nHU9GqRtrClZS8=
X-Authority-Analysis: v=2.4 cv=RPiD2Yi+ c=1 sm=1 tr=0 ts=6a8fc946 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=YlS2zcOLABNWsCZMhzQA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270041

Introduce org.bluez.Ranging1 and
org.bluez.RangingProvider1/ RangingProviderManager1
D-Bus interfaces

External providers can register a root path
via RegisterDistanceProvider and expose per-device
RangingProvider objects; updates to their Distance
property are mirrored onto exported Ranging objects via
btd_ranging_update(), emitting a PropertiesChanged signal.

The Ranging provider manager is wired into the adapter lifecycle,
created on adapter setup and destroyed on adapter
removal.
---
 Makefile.am   |   1 +
 src/adapter.c |  11 +
 src/ranging.c | 644 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ranging.h |  25 ++
 4 files changed, 681 insertions(+)
 create mode 100644 src/ranging.c
 create mode 100644 src/ranging.h

diff --git a/Makefile.am b/Makefile.am
index b3b7077fd..b85b2d8d9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -332,6 +332,7 @@ bluetoothd_internal_sources = \
 			src/eir.h src/eir.c \
 			src/adv_monitor.h src/adv_monitor.c \
 			src/battery.h src/battery.c \
+			src/ranging.h src/ranging.c \
 			src/settings.h src/settings.c \
 			src/set.h src/set.c \
 			src/bearer.h src/bearer.c
diff --git a/src/adapter.c b/src/adapter.c
index cf59db4aa..8c4678f07 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -67,6 +67,7 @@
 #include "adv_monitor.h"
 #include "eir.h"
 #include "battery.h"
+#include "ranging.h"
 
 #define MODE_OFF		0x00
 #define MODE_CONNECTABLE	0x01
@@ -336,6 +337,8 @@ struct btd_adapter {
 
 	struct btd_battery_provider_manager *battery_provider_manager;
 
+	struct btd_ranging_provider_manager *ranging_provider_manager;
+
 	GHashTable *allowed_uuid_set;	/* Set of allowed service UUIDs */
 
 	gboolean initialized;
@@ -7196,6 +7199,7 @@ static void adapter_remove(struct btd_adapter *adapter)
 {
 	GSList *l;
 	struct gatt_db *db;
+	struct btd_ranging_provider_manager *ranging_manager;
 
 	DBG("Removing adapter %s", adapter->path);
 
@@ -7230,6 +7234,10 @@ static void adapter_remove(struct btd_adapter *adapter)
 	btd_battery_provider_manager_destroy(adapter->battery_provider_manager);
 	adapter->battery_provider_manager = NULL;
 
+	ranging_manager = adapter->ranging_provider_manager;
+	btd_ranging_provider_manager_destroy(ranging_manager);
+	adapter->ranging_provider_manager = NULL;
+
 	g_slist_free(adapter->pin_callbacks);
 	adapter->pin_callbacks = NULL;
 
@@ -9645,6 +9653,9 @@ static int adapter_register(struct btd_adapter *adapter)
 	adapter->battery_provider_manager =
 		btd_battery_provider_manager_create(adapter);
 
+	adapter->ranging_provider_manager =
+		btd_ranging_provider_manager_create(adapter);
+
 	/* Don't start GATT database and advertising managers on
 	 * non-LE controllers.
 	 */
diff --git a/src/ranging.c b/src/ranging.c
new file mode 100644
index 000000000..c25381779
--- /dev/null
+++ b/src/ranging.c
@@ -0,0 +1,644 @@
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
+#include <stdbool.h>
+#include <stdint.h>
+#include <glib.h>
+
+#include "gdbus/gdbus.h"
+#include "bluetooth/bluetooth.h"
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+#include "ranging.h"
+#include "dbus-common.h"
+#include "adapter.h"
+#include "device.h"
+#include "log.h"
+#include "error.h"
+
+#define RANGING_INTERFACE "org.bluez.Ranging1"
+#define RANGING_PROVIDER_INTERFACE "org.bluez.RangingProvider1"
+#define RANGING_PROVIDER_MANAGER_INTERFACE \
+	"org.bluez.RangingProviderManager1"
+
+struct btd_ranging {
+	struct btd_ranging_provider_manager *manager; /* Does not own pointer */
+	char *path; /* D-Bus object path */
+	uint32_t distance_millimeters; /* Estimated distance to remote device */
+	bool has_value; /* false until the first estimate is reported */
+	char *provider_path; /* The provider root path, if any */
+};
+
+struct btd_ranging_provider_manager {
+	struct btd_adapter *adapter; /* Does not own pointer */
+	struct queue *providers;
+	struct queue *rangings;
+};
+
+struct ranging_provider {
+	struct btd_ranging_provider_manager *manager; /* Does not own */
+
+	char *owner; /* Owner D-Bus address */
+	char *path; /* D-Bus object path */
+
+	GDBusClient *client;
+};
+
+static void provider_disconnect_cb(DBusConnection *conn, void *user_data);
+
+static void ranging_add(struct btd_ranging *ranging)
+{
+	queue_push_head(ranging->manager->rangings, ranging);
+}
+
+static void ranging_remove(struct btd_ranging *ranging)
+{
+	queue_remove(ranging->manager->rangings, ranging);
+}
+
+static bool match_path(const void *data, const void *user_data)
+{
+	const struct btd_ranging *ranging = data;
+	const char *path = user_data;
+
+	return g_strcmp0(ranging->path, path) == 0;
+}
+
+static struct btd_ranging *ranging_new(
+	struct btd_ranging_provider_manager *manager,
+	const char *path, const char *provider_path)
+{
+	struct btd_ranging *ranging;
+
+	ranging = new0(struct btd_ranging, 1);
+	ranging->manager = manager;
+	ranging->path = g_strdup(path);
+	if (provider_path)
+		ranging->provider_path = g_strdup(provider_path);
+
+	return ranging;
+}
+
+static void ranging_free(struct btd_ranging *ranging)
+{
+	g_free(ranging->path);
+	g_free(ranging->provider_path);
+
+	free(ranging);
+}
+
+static gboolean property_distance_get(const GDBusPropertyTable *property,
+				      DBusMessageIter *iter, void *data)
+{
+	struct btd_ranging *ranging = data;
+
+	return dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+					      &ranging->distance_millimeters);
+}
+
+static gboolean property_distance_exists(const GDBusPropertyTable *property,
+					 void *data)
+{
+	struct btd_ranging *ranging = data;
+
+	return ranging->has_value;
+}
+
+static const GDBusPropertyTable ranging_properties[] = {
+	{ "Distance", "u", property_distance_get, NULL,
+	  property_distance_exists },
+	{}
+};
+
+struct btd_ranging *btd_ranging_register(
+	struct btd_ranging_provider_manager *manager,
+	const char *path, const char *provider_path)
+{
+	struct btd_ranging *ranging;
+
+	DBG("path = %s", path);
+
+	if (queue_find(manager->rangings, match_path, path)) {
+		error("error registering ranging: path exists");
+		return NULL;
+	}
+
+	if (!g_str_has_prefix(path, "/")) {
+		error("error registering ranging: "
+		      "invalid D-Bus object path");
+		return NULL;
+	}
+
+	ranging = ranging_new(manager, path, provider_path);
+	ranging_add(ranging);
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+				       ranging->path, RANGING_INTERFACE,
+				       NULL, NULL, ranging_properties,
+				       ranging, NULL)) {
+		error("error registering D-Bus interface for %s",
+		      ranging->path);
+
+		ranging_remove(ranging);
+		ranging_free(ranging);
+
+		return NULL;
+	}
+
+	DBG("registered Ranging object: %s", ranging->path);
+
+	return ranging;
+}
+
+bool btd_ranging_unregister(struct btd_ranging *ranging)
+{
+	bool ret = true;
+
+	DBG("path = %s", ranging->path);
+
+	if (!queue_find(ranging->manager->rangings, NULL, ranging)) {
+		error("error unregistering ranging: "
+		      "ranging %s is not registered",
+		      ranging->path);
+		return false;
+	}
+
+	if (!g_dbus_unregister_interface(btd_get_dbus_connection(),
+					 ranging->path,
+					 RANGING_INTERFACE)) {
+		error("error unregistering ranging %s from "
+		      "D-Bus interface", ranging->path);
+		ret = false;
+	}
+
+	ranging_remove(ranging);
+	ranging_free(ranging);
+
+	return ret;
+}
+
+bool btd_ranging_update(struct btd_ranging *ranging,
+	uint32_t distance_millimeters)
+{
+	DBG("path = %s", ranging->path);
+
+	if (!queue_find(ranging->manager->rangings, NULL, ranging)) {
+		error("error updating ranging: ranging is not "
+		      "registered");
+		return false;
+	}
+
+	ranging->distance_millimeters = distance_millimeters;
+	ranging->has_value = true;
+
+	DBG("Ranging distance updated: path = %s, millimeters = %u",
+	     ranging->path, distance_millimeters);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				     ranging->path, RANGING_INTERFACE,
+				     "Distance");
+
+	return true;
+}
+
+static struct btd_ranging *find_ranging_by_path(
+	struct btd_ranging_provider_manager *manager, const char *path)
+{
+	return queue_find(manager->rangings, match_path, path);
+}
+
+static void provider_distance_property_changed_cb(GDBusProxy *proxy,
+						   const char *name,
+						   DBusMessageIter *iter,
+						   void *user_data)
+{
+	struct ranging_provider *provider = user_data;
+	struct btd_ranging *ranging;
+	uint32_t distance_millimeters = 0;
+	const char *export_path;
+	const char *path = g_dbus_proxy_get_path(proxy);
+	DBusMessageIter dev_iter;
+
+	if (strcmp(name, "Distance") != 0)
+		return;
+
+	if (iter) {
+		if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32) {
+			warn("Ignoring Distance update on %s: "
+			     "expected type uint32", path);
+			return;
+		}
+
+		dbus_message_iter_get_basic(iter, &distance_millimeters);
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "Device", &dev_iter) == FALSE) {
+		warn("Ignoring Distance update on %s: "
+		     "no Device property", path);
+		return;
+	}
+
+	if (dbus_message_iter_get_arg_type(&dev_iter) !=
+			DBUS_TYPE_OBJECT_PATH) {
+		warn("Ignoring Distance update on %s: "
+		     "invalid Device property type", path);
+		return;
+	}
+
+	dbus_message_iter_get_basic(&dev_iter, &export_path);
+
+	DBG("Ranging distance changed on %s, millimeters = %u",
+	    path, distance_millimeters);
+
+	ranging = find_ranging_by_path(provider->manager, export_path);
+	if (!ranging)
+		return;
+
+	btd_ranging_update(ranging, distance_millimeters);
+}
+
+static void provider_distance_added_cb(GDBusProxy *proxy, void *user_data)
+{
+	struct ranging_provider *provider = user_data;
+	struct btd_ranging *ranging;
+	struct btd_device *device;
+	const char *path = g_dbus_proxy_get_path(proxy);
+	const char *export_path;
+	uint32_t distance_millimeters;
+	DBusMessageIter iter;
+
+	if (strcmp(g_dbus_proxy_get_interface(proxy),
+		   RANGING_PROVIDER_INTERFACE) != 0)
+		return;
+
+	if (!g_str_has_prefix(path, provider->path)) {
+		warn("Ignoring ranging object %s outside provider root %s",
+		     path, provider->path);
+		return;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "Device", &iter) == FALSE) {
+		warn("Ranging object %s does not specify device path",
+		     path);
+		return;
+	}
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH) {
+		warn("Ranging object %s has invalid Device property type",
+		     path);
+		return;
+	}
+
+	dbus_message_iter_get_basic(&iter, &export_path);
+
+	device = btd_adapter_find_device_by_path(provider->manager->adapter,
+						 export_path);
+	if (!device || device_is_temporary(device)) {
+		warn("Ignoring non-existent device path for ranging %s",
+		     export_path);
+		return;
+	}
+
+	if (find_ranging_by_path(provider->manager, export_path)) {
+		DBG("Ranging for %s is already provided, ignoring the "
+		    "new one", export_path);
+		return;
+	}
+
+	ranging = btd_ranging_register(provider->manager, export_path,
+					provider->path);
+	if (!ranging)
+		return;
+
+	g_dbus_proxy_set_property_watch(proxy,
+		provider_distance_property_changed_cb, provider);
+
+	DBG("provided ranging added %s", path);
+
+	/* Distance property may not be immediately available,
+	 * that's okay since we monitor changes to this property.
+	 */
+	if (g_dbus_proxy_get_property(proxy, "Distance",
+				      &iter) == FALSE)
+		return;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT32) {
+		warn("Ignoring Distance property on %s: "
+		     "expected type uint32", path);
+		return;
+	}
+
+	dbus_message_iter_get_basic(&iter, &distance_millimeters);
+
+	btd_ranging_update(ranging, distance_millimeters);
+}
+
+static void provider_distance_removed_cb(GDBusProxy *proxy, void *user_data)
+{
+	struct ranging_provider *provider = user_data;
+	struct btd_ranging *ranging;
+	const char *export_path;
+	DBusMessageIter iter;
+
+	if (strcmp(g_dbus_proxy_get_interface(proxy),
+		   RANGING_PROVIDER_INTERFACE) != 0)
+		return;
+
+	if (g_dbus_proxy_get_property(proxy, "Device", &iter) == FALSE)
+		return;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &export_path);
+
+	DBG("provided ranging removed %s", g_dbus_proxy_get_path(proxy));
+
+	ranging = find_ranging_by_path(provider->manager, export_path);
+	if (!ranging)
+		return;
+
+	if (g_strcmp0(ranging->provider_path, provider->path) != 0)
+		return;
+
+	g_dbus_proxy_set_property_watch(proxy, NULL, NULL);
+
+	btd_ranging_unregister(ranging);
+}
+
+static bool match_provider_path(const void *data, const void *user_data)
+{
+	const struct ranging_provider *provider = data;
+	const char *path = user_data;
+
+	return strcmp(provider->path, path) == 0;
+}
+
+static bool match_ranging_provider_path(const void *data,
+					const void *user_data)
+{
+	const struct btd_ranging *ranging = data;
+	const struct ranging_provider *provider = user_data;
+
+	return g_strcmp0(ranging->provider_path, provider->path) == 0;
+}
+
+static void ranging_destroy(void *data)
+{
+	struct btd_ranging *ranging = data;
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				    ranging->path, RANGING_INTERFACE);
+	ranging_free(ranging);
+}
+
+static void ranging_destroy_warn(void *data)
+{
+	struct btd_ranging *ranging = data;
+
+	warn("Ranging %s still registered at manager destroy",
+	     ranging->path);
+
+	ranging_destroy(data);
+}
+
+static void ranging_provider_free(gpointer data)
+{
+	struct ranging_provider *provider = data;
+
+	/* Unregister rangings under the root path of provider->path */
+	queue_remove_all(provider->manager->rangings,
+			 match_ranging_provider_path, provider,
+			 ranging_destroy);
+
+	g_free(provider->owner);
+	g_free(provider->path);
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
+static struct ranging_provider *
+ranging_provider_new(DBusConnection *conn,
+		     struct btd_ranging_provider_manager *manager,
+		     const char *path, const char *sender)
+{
+	struct ranging_provider *provider;
+
+	provider = new0(struct ranging_provider, 1);
+	provider->manager = manager;
+	provider->owner = g_strdup(sender);
+	provider->path = g_strdup(path);
+
+	provider->client = g_dbus_client_new_full(conn, sender, path, path);
+
+	if (!provider->client) {
+		error("error creating D-Bus client %s", path);
+		ranging_provider_free(provider);
+		return NULL;
+	}
+
+	g_dbus_client_set_disconnect_watch(provider->client,
+					   provider_disconnect_cb, provider);
+
+	g_dbus_client_set_proxy_handlers(provider->client,
+					 provider_distance_added_cb,
+					 provider_distance_removed_cb, NULL,
+					 provider);
+
+	return provider;
+}
+
+static void provider_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct ranging_provider *provider = user_data;
+	struct btd_ranging_provider_manager *manager = provider->manager;
+
+	DBG("Ranging provider client disconnected %s root path %s",
+	    provider->owner, provider->path);
+
+	if (!queue_find(manager->providers, NULL, provider)) {
+		warn("Disconnection on a non-existing provider %s",
+		     provider->path);
+		return;
+	}
+
+	queue_remove(manager->providers, provider);
+	ranging_provider_free(provider);
+}
+
+static DBusMessage *register_ranging_provider(DBusConnection *conn,
+						DBusMessage *msg,
+						void *user_data)
+{
+	struct btd_ranging_provider_manager *manager = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	DBusMessageIter args;
+	const char *path;
+	struct ranging_provider *provider;
+
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &path);
+
+	DBG("register ranging provider path = %s", path);
+
+	if (!g_str_has_prefix(path, "/"))
+		return btd_error_invalid_args(msg);
+
+	/* Only one ranging provider may be registered at a time: allowing
+	 * concurrent providers means whichever claims a device first wins,
+	 * silently locking out any other provider for that device. Reject
+	 * up front instead, with a clear error, regardless of which side
+	 * (bluetoothctl's reference provider or a real ranging daemon)
+	 * registered first.
+	 */
+	if (!queue_isempty(manager->providers)) {
+		return dbus_message_new_error(msg,
+					      ERROR_INTERFACE ".AlreadyExists",
+					      "Provider already exists");
+	}
+
+	provider = ranging_provider_new(conn, manager, path, sender);
+	if (!provider)
+		return btd_error_failed(msg, "failed to create provider");
+
+	queue_push_head(manager->providers, provider);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_ranging_provider(DBusConnection *conn,
+						  DBusMessage *msg,
+						  void *user_data)
+{
+	struct btd_ranging_provider_manager *manager = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	DBusMessageIter args;
+	const char *path;
+	struct ranging_provider *provider;
+
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &path);
+
+	DBG("unregister ranging provider path = %s", path);
+
+	provider = queue_find(manager->providers, match_provider_path, path);
+	if (!provider || strcmp(provider->owner, sender) != 0) {
+		return dbus_message_new_error(msg,
+					      ERROR_INTERFACE ".DoesNotExist",
+					      "Provider does not exist");
+	}
+
+	queue_remove(manager->providers, provider);
+	ranging_provider_free(provider);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable methods[] = {
+	{ GDBUS_METHOD("RegisterRangingProvider",
+				    GDBUS_ARGS({ "provider", "o" }), NULL,
+				    register_ranging_provider) },
+	{ GDBUS_METHOD("UnregisterRangingProvider",
+				    GDBUS_ARGS({ "provider", "o" }), NULL,
+				    unregister_ranging_provider) },
+	{}
+};
+
+static struct btd_ranging_provider_manager *
+manager_new(struct btd_adapter *adapter)
+{
+	struct btd_ranging_provider_manager *manager;
+
+	DBG("");
+
+	manager = new0(struct btd_ranging_provider_manager, 1);
+	manager->adapter = adapter;
+	manager->providers = queue_new();
+	manager->rangings = queue_new();
+
+	return manager;
+}
+
+static void manager_free(struct btd_ranging_provider_manager *manager)
+{
+	if (!manager)
+		return;
+
+	DBG("");
+
+	queue_destroy(manager->providers, ranging_provider_free);
+	queue_destroy(manager->rangings, ranging_destroy_warn);
+
+	free(manager);
+}
+
+struct btd_ranging_provider_manager *
+btd_ranging_provider_manager_create(struct btd_adapter *adapter)
+{
+	struct btd_ranging_provider_manager *manager;
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
+				       RANGING_PROVIDER_MANAGER_INTERFACE,
+				       methods, NULL, NULL, manager, NULL)) {
+		error("error registering "
+		      RANGING_PROVIDER_MANAGER_INTERFACE " interface");
+		manager_free(manager);
+		return NULL;
+	}
+
+	info("Ranging Provider Manager created");
+
+	return manager;
+}
+
+void btd_ranging_provider_manager_destroy(
+	struct btd_ranging_provider_manager *manager)
+{
+	if (!manager)
+		return;
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				    adapter_get_path(manager->adapter),
+				    RANGING_PROVIDER_MANAGER_INTERFACE);
+
+	info("Ranging Provider Manager destroyed");
+
+	manager_free(manager);
+}
diff --git a/src/ranging.h b/src/ranging.h
new file mode 100644
index 000000000..79ff6cc41
--- /dev/null
+++ b/src/ranging.h
@@ -0,0 +1,25 @@
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
+struct btd_ranging;
+struct btd_ranging_provider_manager;
+
+struct btd_ranging *btd_ranging_register(
+	struct btd_ranging_provider_manager *manager,
+	const char *path, const char *provider_path);
+bool btd_ranging_unregister(struct btd_ranging *ranging);
+bool btd_ranging_update(struct btd_ranging *ranging,
+	uint32_t distance_millimeters);
+
+struct btd_ranging_provider_manager *
+btd_ranging_provider_manager_create(struct btd_adapter *adapter);
+void btd_ranging_provider_manager_destroy(
+	struct btd_ranging_provider_manager *manager);
-- 


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A832D97B7
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354602; cv=none; b=nJC6mJ/sIvz5mmQY7VwMHZTxA29Pmjk3yjdbBoBP2269O4UAxmMZBE+bhkGlZ7XVTQGbgLn8GFe0mWbCL+7Kt8YS/eusX6Ta+TMlcm00qeRIBw/+cc559CEwgAIZmCnpZlLaa82pV3//jotRmzIT4RP4AgEbYxMXToY/2MdLtWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354602; c=relaxed/simple;
	bh=CY6oaaDun69LPrFNypgjvM52G6XjAk6fkqlQxR2mecE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAt9srGlQupxd6HLlI6qkz2gQkStQdOkbI9ozbfd2WfhEZHYu/S7e8zE9siKwL4ph/8O0Vx7X9iHZUTG/boXxBZMo784SbRXuDDImGdBuhaej1vjNU32hDkxfPhlgu5SDZX2H3BTA19d3M6c4RoUG4IS3Wi7Ny//Is6JqVt9P4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jjTIle8U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XP6+m94Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jjTIle8U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XP6+m94Z"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF66Z990233
	for <linux-bluetooth@vger.kernel.org>; Mon, 6 Jul 2026 16:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4H3EkDXLAo1Phdf+8a+kuQPpvl34JkmBaHGmnMDvqiw=; b=jjTIle8UnL6Zy1b3
	3QcCO7m6up+cB7hY7r2DUVBqWRiiDrlNbT8GXl/9XMi7/4M2RlXAu0sf1t3rxKW+
	tQ2pwTEy5ntsdrK86SIvjpGmADTOFEmHmJJ2MlFWOwTh2J64oyM/FOaWzhu7Fm9E
	jNKsbVq1CtdPh8PsFOIwjQKSC7PTgfeI5ZLedW909e7Nj7YTAOJcxGCzNVd58pxa
	tJ0zTMNw5Gi/4lE3JE9TFZAXp3yp92N2L859PlPNKdQWv9b/2unoxwnJKJuM8iX6
	AgmQgdmCv4axpJyN8/yCPjQn0NxjIZMIFwxdneaAnWQgVfPyygh1yujaKssxskFt
	EicHuA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gsrn1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 16:16:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3810960140eso5109881a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 09:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783354598; x=1783959398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4H3EkDXLAo1Phdf+8a+kuQPpvl34JkmBaHGmnMDvqiw=;
        b=XP6+m94ZPvjBCdB9IpvorlycP36K+2kcnI47F6Q5WVlnW1zX4K8P0INDzAt/jtuJFn
         Jr3HqlZriOhhJ7zKWezTMzleIlODzAoHo8XjSml/boZbXicjkNswQK/VkaEjTz+dCeMk
         zCDbRi1Xmwm7I4H3ucs+VwnUKGTLVMuUsbmK3t6stmztJogbJG0n6vOROLXUyMGd02M/
         uPKhPQQWqO+Q/RrkLJeZuc9iz9GRZmxn/SmTkoMM0A9Eege3Gfj+5kRIOKqDoRg0TxHn
         fdIfjctf7oMopxVB5ztAwDRomjxubHe8PE+Nmq5lhE+8KK2XQuroRYmxhBgRc6EgvWFY
         S81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354598; x=1783959398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4H3EkDXLAo1Phdf+8a+kuQPpvl34JkmBaHGmnMDvqiw=;
        b=MdjCMgqVFzbhlY6Cz27ASrXNjKWTa3bFEE1AHaZv/jBmh6uIdbv36BLSEFwXBQVRjy
         G96mNU68/ePyhDXjjBcb7oFfDmhskt/jjRnStvlF2kx5ATKzjQxDj85DyP36K5JXl8hb
         zUdOOBKtwbF1qEzZLvp1VeFuW5vXdu2Eg2SAPikZCjmXFgQIeOEYvXxwUDxfHLsBWU3Z
         U3GQtz9iZAUG2WDXzEFDn6B2ARm+gpl2CALZCzxMirSHxTRi7RWLn/n5qYwUwYcYhWc8
         Dfi317sFCTd9oNuBt9MI4SXE1WoyDdoBcg7EJNBY0UXj3uj+dWzo5K3V+lEiyP8WK2bW
         5mBg==
X-Gm-Message-State: AOJu0YxpmMckZiHkro6537250DeIjHVSZU5LytyEE1C69rbUbr5as4G2
	jKe3KUwNvLvwC5KLXe5OLlgVaUBKMb3v6OFEyADvafD/wQScnJEGOC/fHQwPFNwU7EuMby0QmZo
	G0mHdF7m1chVsEgWlWJlM3x8Yv5SfeShF+cc6uueDCbP/oPER1kPCCsrqk++hZd9DLSSCPLG5+S
	zmjWM=
X-Gm-Gg: AfdE7cmltxKfOoV45SVJUQPC9GikBZw9Vz40siqqwDzLElGHdWk2Z5VqlcSY48TOg29
	57Ur8ygqmvnkLOyP6IrcMr9VJEXvRIogb1W8RGEFwqdKgFc4l/dQM41wp/bLDGiMo/YXU7ddCXB
	55quWenpqvlyFLdJZU1BeQ61j4HC7Euv4rCHIBK8CmEjKGrLtsgeGMSX4RnP2vgPJbJ98N8pBN0
	crjUG4gEHYoRTHE9yTiNSXilNaFP6RzqPk3cjStXK6RsUuxt+NHZwngKNKoX29mDeF6wCeE+jrc
	wLjOp77sbDMuWqAyDkMWGiO39Suk0HQfkcObqfET5LOjFq18DQsJdvJ3/CzIRWw3AOZMfnK6D7B
	Xpvk0d2bkSXXgWx3MnIazvoara3WuwcEyiLHLU+5C
X-Received: by 2002:a17:90b:3890:b0:381:41e9:32a4 with SMTP id 98e67ed59e1d1-38756030381mr1275380a91.13.1783354595858;
        Mon, 06 Jul 2026 09:16:35 -0700 (PDT)
X-Received: by 2002:a17:90b:3890:b0:381:41e9:32a4 with SMTP id 98e67ed59e1d1-38756030381mr1275319a91.13.1783354594887;
        Mon, 06 Jul 2026 09:16:34 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f31e7a2a8sm40022434eec.25.2026.07.06.09.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:16:34 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 5/5] client: Add Channel Sounding shell submenu
Date: Mon,  6 Jul 2026 21:46:03 +0530
Message-Id: <20260706161603.2744459-6-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706161603.2744459-1-naga.akella@oss.qualcomm.com>
References: <20260706161603.2744459-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AsI0XhcTX7YOEotTtmdRX4wlIwo77i-_
X-Proofpoint-ORIG-GUID: AsI0XhcTX7YOEotTtmdRX4wlIwo77i-_
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4bd4e7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=RyHYz8-hu8DRwSw9KSYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfXzQwpBkO8VEnk
 AszQuytZT28HMCHEwjsvdajgOFN+y1LIk5pVq8q7WhO8sLvz2DrCUOSOAA7s7HqHnOiilRrZ6fM
 gdp6fuf4hOeSUONAh9IFe1uM5ORen275q0hJ/QvuBXPVl9rh1DWO5W0uZyxUbCTnZ7zAILmTfeH
 uTfaAiHT/xSYam/uvyclLFfHAxfquuPoN1odKwTP88RjaExgRirWlWXkZRDZyG56wQNMS6qcwt9
 yoC35oKGG4xUlV3ADxKUgnP7WiZ7ISQEGFW3Uafa6khzqC7TNYUe7B3Pl9fBWiSicEhw7JGvrK4
 DpLOY0SJhOi1xiMBSFW0wUjJhjlGQ9hq83RM0tchUotMBD6qjQvYIXW6uU0eUahgQ9b2Z/LfgmP
 1jDQfi39aqPpeCYRiKSC0kOwNwq71suTr0MoLzSkGNRdDnpY9GGY/TQS3ZYKcisqzt7EoLhVpqH
 DQMF7DOdBpB8zfqkjbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfX8K7VJh6MDA0f
 AJfaVyzVZm9OKMCb17qa5lRI0azzH5IDX8rAAIRPXNLHAkfPEG3Q9/hHdfav1d4do78HNdAkOWt
 15oScD3zWPJU9kCea+49rSSQFNqACco=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060165

Add a cs bt_shell submenu for controlling
org.bluez.ChannelSounding1, supporting measurement start/stop,
default-setting configuration, and session status display.
Maintain reusable validated CS parameters and
track active sessions via D-Bus Active state,
replies, and disconnects.
Integrate with client/main.c to manage per-adapter
ChannelSounding proxies, device resolution,
property updates, and session cleanup.
---
 Makefile.tools |   3 +-
 client/cs.c    | 981 +++++++++++++++++++++++++++++++++++++++++++++++++
 client/cs.h    |  18 +
 client/main.c  |  73 +++-
 4 files changed, 1073 insertions(+), 2 deletions(-)
 create mode 100644 client/cs.c
 create mode 100644 client/cs.h

diff --git a/Makefile.tools b/Makefile.tools
index 6188449f1..b5f7ef8da 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -16,7 +16,8 @@ client_bluetoothctl_SOURCES = client/main.c \
 					client/mgmt.h client/mgmt.c \
 					client/assistant.h client/assistant.c \
 					client/hci.h client/hci.c \
-					client/telephony.h client/telephony.c
+					client/telephony.h client/telephony.c \
+					client/cs.h client/cs.c
 client_bluetoothctl_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la src/libshared-glib.la \
 			$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
diff --git a/client/cs.c b/client/cs.c
new file mode 100644
index 000000000..00b64cb77
--- /dev/null
+++ b/client/cs.c
@@ -0,0 +1,981 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+
+#include <glib.h>
+
+#include "gdbus/gdbus.h"
+#include "src/shared/shell.h"
+#include "cs.h"
+
+static GList *cs_proxies;
+static GList **cs_device_list;
+
+/* ---- Per-device active session ---- */
+
+struct cs_session {
+	GDBusProxy *proxy;
+};
+
+static GList *cs_sessions;
+
+static struct cs_session *cs_find_session(GDBusProxy *proxy);
+
+/* ---- Parameter state (used to build the StartMeasurement dict) ---- */
+
+static uint8_t cs_role        = 0x03;
+static uint8_t cs_sync_ant    = 0xFF;
+static int8_t  cs_max_tx_power = 0x14;
+
+static struct {
+	uint8_t config_id;
+	uint8_t main_mode_type;
+	uint8_t sub_mode_type;
+	uint8_t main_mode_min_steps;
+	uint8_t main_mode_max_steps;
+	uint8_t main_mode_repetition;
+	uint8_t mode0_steps;
+	uint8_t role;
+	uint8_t rtt_types;
+	uint8_t cs_sync_phy;
+	uint8_t channel_map[10];
+	uint8_t channel_map_repetition;
+	uint8_t channel_selection_type;
+	uint8_t channel_shape;
+	uint8_t channel_jump;
+	uint8_t companion_signal_enable;
+} cs_cfg = {
+	.config_id               = 0x00,
+	.main_mode_type          = 0x01,
+	.sub_mode_type           = 0xFF,
+	.main_mode_min_steps     = 0x02,
+	.main_mode_max_steps     = 0x03,
+	.main_mode_repetition    = 0x01,
+	.mode0_steps             = 0x02,
+	.role                    = 0x00,
+	.rtt_types               = 0x00,
+	.cs_sync_phy             = 0x01,
+	.channel_map             = { 0xFC, 0xFF, 0x7F, 0xFC, 0xFF,
+				     0xFF, 0xFF, 0xFF, 0xFF, 0x1F },
+	.channel_map_repetition  = 0x01,
+	.channel_selection_type  = 0x00,
+	.channel_shape           = 0x00,
+	.channel_jump            = 0x02,
+	.companion_signal_enable = 0x00,
+};
+
+static struct {
+	uint16_t max_procedure_duration;
+	uint16_t min_period_between_procedures;
+	uint16_t max_period_between_procedures;
+	uint16_t max_procedure_count;
+	uint8_t  min_sub_event_len[3];
+	uint8_t  max_sub_event_len[3];
+	uint8_t  tone_antenna_config_selection;
+	uint8_t  phy;
+	uint8_t  tx_power_delta;
+	uint8_t  preferred_peer_antenna;
+	uint8_t  snr_control_initiator;
+	uint8_t  snr_control_reflector;
+} cs_freq = {
+	.max_procedure_duration        = 0x0640,
+	.min_period_between_procedures = 0x001E,
+	.max_period_between_procedures = 0x0096,
+	.max_procedure_count           = 0x0000,
+	.min_sub_event_len             = { 0x00, 0x20, 0x00 },
+	.max_sub_event_len             = { 0x03, 0x20, 0x00 },
+	.tone_antenna_config_selection = 0x07,
+	.phy                           = 0x01,
+	.tx_power_delta                = 0x80,
+	.preferred_peer_antenna        = 0x03,
+	.snr_control_initiator         = 0xFF,
+	.snr_control_reflector         = 0xFF,
+};
+
+void cs_proxy_added(GDBusProxy *proxy)
+{
+	cs_proxies = g_list_append(cs_proxies, proxy);
+}
+
+void cs_proxy_removed(GDBusProxy *proxy)
+{
+	struct cs_session *s;
+	GList *list;
+
+	cs_proxies = g_list_remove(cs_proxies, proxy);
+
+	for (list = g_list_first(cs_sessions); list;
+	     list = g_list_next(list)) {
+		s = list->data;
+
+		if (s->proxy == proxy) {
+			cs_sessions = g_list_remove(cs_sessions, s);
+			g_free(s);
+			break;
+		}
+	}
+}
+
+/* Drop any active CS session for a device proxy path on disconnect. */
+void cs_device_disconnected(const char *dev_path)
+{
+	struct cs_session *s;
+	GList *list;
+
+	for (list = g_list_first(cs_sessions); list;
+	     list = g_list_next(list)) {
+		s = list->data;
+
+		if (!strcmp(g_dbus_proxy_get_path(s->proxy), dev_path)) {
+			bt_shell_printf("Measurement stopped (disconnected)"
+					" on %s\n", dev_path);
+			cs_sessions = g_list_remove(cs_sessions, s);
+			g_free(s);
+			break;
+		}
+	}
+}
+
+/* Drop active CS session when the daemon reports the measurement stopped. */
+void cs_measurement_stopped(GDBusProxy *proxy)
+{
+	struct cs_session *s = cs_find_session(proxy);
+
+	if (!s)
+		return;
+
+	bt_shell_printf("Measurement stopped (timer expired) on %s\n",
+			g_dbus_proxy_get_path(proxy));
+	cs_sessions = g_list_remove(cs_sessions, s);
+	g_free(s);
+}
+
+/* Record a measurement started by the remote side (Reflector role). */
+void cs_measurement_started(GDBusProxy *proxy)
+{
+	struct cs_session *s;
+
+	if (cs_find_session(proxy))
+		return;
+
+	s = g_new0(struct cs_session, 1);
+	s->proxy = proxy;
+	cs_sessions = g_list_append(cs_sessions, s);
+
+	bt_shell_printf("Measurement started on %s\n",
+			g_dbus_proxy_get_path(proxy));
+}
+
+void cs_set_device_list(GList **devices)
+{
+	cs_device_list = devices;
+}
+
+/* Resolve a Bluetooth address to the device's D-Bus object path. */
+static const char *cs_resolve_address(const char *address)
+{
+	GDBusProxy *proxy;
+	DBusMessageIter iter;
+	const char *str;
+	GList *list;
+
+	if (!cs_device_list) {
+		bt_shell_printf("DBG: cs_device_list is NULL\n");
+		return NULL;
+	}
+
+	if (!*cs_device_list) {
+		bt_shell_printf("DBG: *cs_device_list is empty\n");
+		return NULL;
+	}
+
+	for (list = g_list_first(*cs_device_list); list;
+	     list = g_list_next(list)) {
+		proxy = list->data;
+
+		if (!g_dbus_proxy_get_property(proxy, "Address", &iter)) {
+			bt_shell_printf("DBG: proxy %s has no Address\n",
+					g_dbus_proxy_get_path(proxy));
+			continue;
+		}
+
+		dbus_message_iter_get_basic(&iter, &str);
+
+		if (!strcasecmp(str, address))
+			return g_dbus_proxy_get_path(proxy);
+	}
+
+	return NULL;
+}
+
+/* Find the ChannelSounding1 proxy for the device at the given object path. */
+static GDBusProxy *cs_find_proxy(const char *dev_path)
+{
+	GDBusProxy *proxy;
+	const char *path;
+	GList *list;
+
+	if (!cs_proxies) {
+		bt_shell_printf("DBG: cs_proxies is empty\n");
+		return NULL;
+	}
+
+	for (list = g_list_first(cs_proxies); list;
+	     list = g_list_next(list)) {
+		proxy = list->data;
+		path = g_dbus_proxy_get_path(proxy);
+
+		if (!strcmp(path, dev_path))
+			return proxy;
+	}
+
+	return NULL;
+}
+
+static struct cs_session *cs_find_session(GDBusProxy *proxy)
+{
+	struct cs_session *s;
+	GList *list;
+
+	for (list = g_list_first(cs_sessions); list;
+	     list = g_list_next(list)) {
+		s = list->data;
+
+		if (s->proxy == proxy)
+			return s;
+	}
+
+	return NULL;
+}
+
+/* ---- dict helpers ---- */
+
+static void dict_append_byte(DBusMessageIter *dict, const char *key,
+			     uint8_t val)
+{
+	DBusMessageIter entry, variant;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+					 NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+					 DBUS_TYPE_BYTE_AS_STRING, &variant);
+	dbus_message_iter_append_basic(&variant, DBUS_TYPE_BYTE, &val);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void dict_append_uint16(DBusMessageIter *dict, const char *key,
+			       uint16_t val)
+{
+	DBusMessageIter entry, variant;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+					 NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+					 "q", &variant);
+	dbus_message_iter_append_basic(&variant, DBUS_TYPE_UINT16, &val);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void dict_append_uint32(DBusMessageIter *dict, const char *key,
+			       uint32_t val)
+{
+	DBusMessageIter entry, variant;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+					 NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+					 "u", &variant);
+	dbus_message_iter_append_basic(&variant, DBUS_TYPE_UINT32, &val);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void dict_append_byte_array(DBusMessageIter *dict, const char *key,
+				   const uint8_t *bytes, int len)
+{
+	DBusMessageIter entry, variant, array;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+					 NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+					 "ay", &variant);
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+					 DBUS_TYPE_BYTE_AS_STRING, &array);
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+					     &bytes, len);
+	dbus_message_iter_close_container(&variant, &array);
+	dbus_message_iter_close_container(&entry, &variant);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+/* ---- start ---- */
+
+static uint32_t pending_duration_secs;
+static const char *pending_dev_path;
+
+static void start_measurement_setup(DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter dict;
+	uint8_t tx = (uint8_t)cs_max_tx_power;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					 "{sv}", &dict);
+
+	/* timing */
+	dict_append_uint32(&dict, "duration_secs", pending_duration_secs);
+
+	/* default settings */
+	dict_append_byte(&dict, "role",            cs_role);
+	dict_append_byte(&dict, "cs_sync_ant_sel", cs_sync_ant);
+	dict_append_byte(&dict, "max_tx_power",    tx);
+
+	/* CS config */
+	dict_append_byte(&dict, "config_id",
+			 cs_cfg.config_id);
+	dict_append_byte(&dict, "main_mode_type",
+			 cs_cfg.main_mode_type);
+	dict_append_byte(&dict, "sub_mode_type",
+			 cs_cfg.sub_mode_type);
+	dict_append_byte(&dict, "main_mode_min_steps",
+			 cs_cfg.main_mode_min_steps);
+	dict_append_byte(&dict, "main_mode_max_steps",
+			 cs_cfg.main_mode_max_steps);
+	dict_append_byte(&dict, "main_mode_repetition",
+			 cs_cfg.main_mode_repetition);
+	dict_append_byte(&dict, "mode0_steps",
+			 cs_cfg.mode0_steps);
+	dict_append_byte(&dict, "rtt_types",
+			 cs_cfg.rtt_types);
+	dict_append_byte(&dict, "cs_sync_phy",
+			 cs_cfg.cs_sync_phy);
+	dict_append_byte_array(&dict, "channel_map",
+			       cs_cfg.channel_map, 10);
+	dict_append_byte(&dict, "channel_map_repetition",
+			 cs_cfg.channel_map_repetition);
+	dict_append_byte(&dict, "channel_selection_type",
+			 cs_cfg.channel_selection_type);
+	dict_append_byte(&dict, "channel_shape",
+			 cs_cfg.channel_shape);
+	dict_append_byte(&dict, "channel_jump",
+			 cs_cfg.channel_jump);
+	dict_append_byte(&dict, "companion_signal_enable",
+			 cs_cfg.companion_signal_enable);
+
+	/* CS frequency */
+	dict_append_uint16(&dict, "max_procedure_duration",
+			   cs_freq.max_procedure_duration);
+	dict_append_uint16(&dict, "min_period_between_procedures",
+			   cs_freq.min_period_between_procedures);
+	dict_append_uint16(&dict, "max_period_between_procedures",
+			   cs_freq.max_period_between_procedures);
+	dict_append_uint16(&dict, "max_procedure_count",
+			   cs_freq.max_procedure_count);
+	dict_append_byte_array(&dict, "min_sub_event_len",
+			       cs_freq.min_sub_event_len, 3);
+	dict_append_byte_array(&dict, "max_sub_event_len",
+			       cs_freq.max_sub_event_len, 3);
+	dict_append_byte(&dict, "tone_antenna_config_selection",
+			 cs_freq.tone_antenna_config_selection);
+	dict_append_byte(&dict, "phy",
+			 cs_freq.phy);
+	dict_append_byte(&dict, "tx_power_delta",
+			 cs_freq.tx_power_delta);
+	dict_append_byte(&dict, "preferred_peer_antenna",
+			 cs_freq.preferred_peer_antenna);
+	dict_append_byte(&dict, "snr_control_initiator",
+			 cs_freq.snr_control_initiator);
+	dict_append_byte(&dict, "snr_control_reflector",
+			 cs_freq.snr_control_reflector);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+/* ---- cs_set_param: apply name=value to the local parameter state ---- */
+
+static bool cs_set_param(const char *name, const char *valstr)
+{
+	uint8_t map[10];
+	uint8_t buf[3];
+	const char *str;
+	char *endptr;
+	unsigned long uval;
+	long sval;
+	int i;
+
+	/* Byte-array: channel_map — 10 colon-separated hex bytes */
+	if (strcmp(name, "channel_map") == 0) {
+		str = valstr;
+		i = 0;
+
+		while (i < 10) {
+			uval = strtoul(str, &endptr, 16);
+			if (endptr == str || uval > 0xFF) {
+				bt_shell_printf("channel_map: invalid byte"
+						" at index %d\n", i);
+				return false;
+			}
+			map[i++] = (uint8_t)uval;
+			if (*endptr == '\0')
+				break;
+			if (*endptr != ':') {
+				bt_shell_printf("channel_map: expected ':'"
+						" separator\n");
+				return false;
+			}
+			str = endptr + 1;
+		}
+		if (i != 10) {
+			bt_shell_printf("channel_map: need exactly 10"
+					" colon-separated hex bytes\n");
+			return false;
+		}
+		memcpy(cs_cfg.channel_map, map, 10);
+		return true;
+	}
+
+	/* Byte-array: min/max_sub_event_len — 3 colon-separated hex bytes */
+	if (strcmp(name, "min_sub_event_len") == 0 ||
+	    strcmp(name, "max_sub_event_len") == 0) {
+		str = valstr;
+		i = 0;
+
+		while (i < 3) {
+			uval = strtoul(str, &endptr, 16);
+			if (endptr == str || uval > 0xFF) {
+				bt_shell_printf("%s: invalid byte at index"
+						" %d\n", name, i);
+				return false;
+			}
+			buf[i++] = (uint8_t)uval;
+			if (*endptr == '\0')
+				break;
+			if (*endptr != ':') {
+				bt_shell_printf("%s: expected ':' separator\n",
+						name);
+				return false;
+			}
+			str = endptr + 1;
+		}
+		if (i != 3) {
+			bt_shell_printf("%s: need exactly 3 colon-separated"
+					" hex bytes\n", name);
+			return false;
+		}
+		if (strcmp(name, "min_sub_event_len") == 0)
+			memcpy(cs_freq.min_sub_event_len, buf, 3);
+		else
+			memcpy(cs_freq.max_sub_event_len, buf, 3);
+		return true;
+	}
+
+	/* max_tx_power is signed (-127 to +20 dBm) */
+	if (strcmp(name, "max_tx_power") == 0) {
+		sval = strtol(valstr, &endptr, 0);
+
+		if (*endptr != '\0' || sval < -127 || sval > 20) {
+			bt_shell_printf("max_tx_power: valid range -127"
+					" to 20 dBm\n");
+			return false;
+		}
+		cs_max_tx_power = (int8_t)sval;
+		return true;
+	}
+
+	/* All remaining parameters are unsigned */
+	uval = strtoul(valstr, &endptr, 0);
+	if (*endptr != '\0') {
+		bt_shell_printf("%s: invalid value '%s'\n", name, valstr);
+		return false;
+	}
+
+	if (strcmp(name, "role") == 0) {
+		if (uval < 0x01 || uval > 0x03) {
+			bt_shell_printf("role: 0x01=Initiator 0x02=Reflector"
+					" 0x03=Both\n");
+			return false;
+		}
+		cs_role = (uint8_t)uval;
+	} else if (strcmp(name, "cs_sync_ant_sel") == 0) {
+		cs_sync_ant = (uint8_t)uval;
+	} else if (strcmp(name, "config_id") == 0) {
+		cs_cfg.config_id = (uint8_t)uval;
+	} else if (strcmp(name, "main_mode_type") == 0) {
+		cs_cfg.main_mode_type = (uint8_t)uval;
+	} else if (strcmp(name, "sub_mode_type") == 0) {
+		cs_cfg.sub_mode_type = (uint8_t)uval;
+	} else if (strcmp(name, "main_mode_min_steps") == 0) {
+		cs_cfg.main_mode_min_steps = (uint8_t)uval;
+	} else if (strcmp(name, "main_mode_max_steps") == 0) {
+		cs_cfg.main_mode_max_steps = (uint8_t)uval;
+	} else if (strcmp(name, "main_mode_repetition") == 0) {
+		cs_cfg.main_mode_repetition = (uint8_t)uval;
+	} else if (strcmp(name, "mode0_steps") == 0) {
+		cs_cfg.mode0_steps = (uint8_t)uval;
+	} else if (strcmp(name, "rtt_types") == 0) {
+		cs_cfg.rtt_types = (uint8_t)uval;
+	} else if (strcmp(name, "cs_sync_phy") == 0) {
+		if (uval != 0x01 && uval != 0x02) {
+			bt_shell_printf("cs_sync_phy: 0x01=LE 1M"
+					" 0x02=LE 2M\n");
+			return false;
+		}
+		cs_cfg.cs_sync_phy = (uint8_t)uval;
+	} else if (strcmp(name, "channel_map_repetition") == 0) {
+		cs_cfg.channel_map_repetition = (uint8_t)uval;
+	} else if (strcmp(name, "channel_selection_type") == 0) {
+		cs_cfg.channel_selection_type = (uint8_t)uval;
+	} else if (strcmp(name, "channel_shape") == 0) {
+		cs_cfg.channel_shape = (uint8_t)uval;
+	} else if (strcmp(name, "channel_jump") == 0) {
+		cs_cfg.channel_jump = (uint8_t)uval;
+	} else if (strcmp(name, "companion_signal_enable") == 0) {
+		if (uval > 1) {
+			bt_shell_printf("companion_signal_enable: 0 or 1\n");
+			return false;
+		}
+		cs_cfg.companion_signal_enable = (uint8_t)uval;
+	} else if (strcmp(name, "max_procedure_duration") == 0) {
+		cs_freq.max_procedure_duration = (uint16_t)uval;
+	} else if (strcmp(name, "min_period_between_procedures") == 0) {
+		cs_freq.min_period_between_procedures = (uint16_t)uval;
+	} else if (strcmp(name, "max_period_between_procedures") == 0) {
+		cs_freq.max_period_between_procedures = (uint16_t)uval;
+	} else if (strcmp(name, "max_procedure_count") == 0) {
+		cs_freq.max_procedure_count = (uint16_t)uval;
+	} else if (strcmp(name, "tone_antenna_config_selection") == 0) {
+		cs_freq.tone_antenna_config_selection = (uint8_t)uval;
+	} else if (strcmp(name, "phy") == 0) {
+		if (uval != 0x01 && uval != 0x02) {
+			bt_shell_printf("phy: 0x01=LE 1M  0x02=LE 2M\n");
+			return false;
+		}
+		cs_freq.phy = (uint8_t)uval;
+	} else if (strcmp(name, "tx_power_delta") == 0) {
+		cs_freq.tx_power_delta = (uint8_t)uval;
+	} else if (strcmp(name, "preferred_peer_antenna") == 0) {
+		cs_freq.preferred_peer_antenna = (uint8_t)uval;
+	} else if (strcmp(name, "snr_control_initiator") == 0) {
+		cs_freq.snr_control_initiator = (uint8_t)uval;
+	} else if (strcmp(name, "snr_control_reflector") == 0) {
+		cs_freq.snr_control_reflector = (uint8_t)uval;
+	} else {
+		bt_shell_printf("Unknown parameter: %s\n", name);
+		return false;
+	}
+
+	return true;
+}
+
+static void start_measurement_reply(DBusMessage *message, void *user_data)
+{
+	GDBusProxy *proxy = user_data;
+	struct cs_session *s;
+	DBusError error;
+
+	dbus_error_init(&error);
+	if (dbus_set_error_from_message(&error, message)) {
+		bt_shell_printf("StartMeasurement failed: %s\n", error.message);
+		dbus_error_free(&error);
+		return;
+	}
+
+	s = g_new0(struct cs_session, 1);
+	s->proxy    = proxy;
+	cs_sessions = g_list_append(cs_sessions, s);
+
+	bt_shell_printf("Measurement started on %s\n",
+			g_dbus_proxy_get_path(proxy));
+}
+
+static void cmd_cs_start(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	char name[64];
+	char *endptr;
+	char *eq;
+	size_t nlen;
+	unsigned long val;
+	int positional = 0;
+	int i;
+
+	pending_duration_secs = 0;
+	pending_dev_path = NULL;
+
+	for (i = 1; i < argc; i++) {
+		eq = strchr(argv[i], '=');
+
+		if (eq) {
+			nlen = (size_t)(eq - argv[i]);
+
+			if (nlen == 0 || nlen >= sizeof(name)) {
+				bt_shell_printf("Invalid param: %s\n", argv[i]);
+				return;
+			}
+			memcpy(name, argv[i], nlen);
+			name[nlen] = '\0';
+			if (!cs_set_param(name, eq + 1))
+				return;
+		} else {
+			if (positional == 0) {
+				pending_dev_path = cs_resolve_address(argv[i]);
+				if (!pending_dev_path) {
+					bt_shell_printf("Device %s not"
+							" found\n", argv[i]);
+					return;
+				}
+			} else if (positional == 1) {
+				val = strtoul(argv[i], &endptr, 0);
+
+				if (*endptr != '\0') {
+					bt_shell_printf("Invalid duration:"
+							" %s\n", argv[i]);
+					return;
+				}
+				pending_duration_secs = (uint32_t)val;
+			} else {
+				bt_shell_printf("Too many positional"
+						" arguments\n");
+				return;
+			}
+			positional++;
+		}
+	}
+
+	if (pending_dev_path) {
+		proxy = cs_find_proxy(pending_dev_path);
+		if (!proxy) {
+			bt_shell_printf("No ChannelSounding1 interface for"
+					" that device\n");
+			return;
+		}
+	} else {
+		if (!cs_proxies) {
+			bt_shell_printf("No ChannelSounding1 interface"
+					" available\n");
+			return;
+		}
+		proxy = cs_proxies->data;
+	}
+
+	if (cs_find_session(proxy)) {
+		bt_shell_printf("Measurement already active on %s\n",
+				g_dbus_proxy_get_path(proxy));
+		return;
+	}
+
+	if (!g_dbus_proxy_method_call(proxy, "StartMeasurement",
+				      start_measurement_setup,
+				      start_measurement_reply, proxy, NULL))
+		bt_shell_printf("Failed to send StartMeasurement\n");
+}
+
+/* ---- defset ---- */
+
+static void defset_setup(DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter dict;
+	uint8_t tx = (uint8_t)cs_max_tx_power;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+	dict_append_byte(&dict, "role",            cs_role);
+	dict_append_byte(&dict, "cs_sync_ant_sel", cs_sync_ant);
+	dict_append_byte(&dict, "max_tx_power",    tx);
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static void defset_reply(DBusMessage *message, void *user_data)
+{
+	GDBusProxy *proxy = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+	if (dbus_set_error_from_message(&error, message)) {
+		bt_shell_printf("SetDefaultSettings failed: %s\n",
+				error.message);
+		dbus_error_free(&error);
+		return;
+	}
+
+	bt_shell_printf("Default settings applied on %s\n",
+			g_dbus_proxy_get_path(proxy));
+}
+
+static void cmd_cs_defset(int argc, char *argv[])
+{
+	const char *dev_path;
+	GDBusProxy *proxy;
+	char name[64];
+	size_t nlen;
+	char *eq;
+	int i;
+
+	/* First positional arg (no '=') is an optional device address. */
+	i = 1;
+	if (i < argc && !strchr(argv[i], '=')) {
+		dev_path = cs_resolve_address(argv[i]);
+
+		if (!dev_path) {
+			bt_shell_printf("Device %s not found\n", argv[i]);
+			return;
+		}
+		proxy = cs_find_proxy(dev_path);
+		if (!proxy) {
+			bt_shell_printf("No ChannelSounding1 interface for"
+					" that device\n");
+			return;
+		}
+		i++;
+	} else {
+		if (!cs_proxies) {
+			bt_shell_printf("No ChannelSounding1 interface"
+					" available\n");
+			return;
+		}
+		proxy = cs_proxies->data;
+	}
+
+	/* Remaining args must be param=value for the three default-settings
+	 * fields: role, cs_sync_ant_sel, max_tx_power.
+	 */
+	for (; i < argc; i++) {
+		eq = strchr(argv[i], '=');
+
+		if (!eq) {
+			bt_shell_printf("Expected param=value, got: %s\n",
+					argv[i]);
+			return;
+		}
+		nlen = (size_t)(eq - argv[i]);
+		if (nlen == 0 || nlen >= sizeof(name)) {
+			bt_shell_printf("Invalid param: %s\n", argv[i]);
+			return;
+		}
+		memcpy(name, argv[i], nlen);
+		name[nlen] = '\0';
+
+		if (strcmp(name, "role") != 0 &&
+		    strcmp(name, "cs_sync_ant_sel") != 0 &&
+		    strcmp(name, "max_tx_power") != 0) {
+			bt_shell_printf("defset: unknown param '%s' "
+					"(role, cs_sync_ant_sel, max_tx_power)\n",
+					name);
+			return;
+		}
+		if (!cs_set_param(name, eq + 1))
+			return;
+	}
+
+	if (!g_dbus_proxy_method_call(proxy, "SetDefaultSettings",
+				      defset_setup, defset_reply, proxy, NULL))
+		bt_shell_printf("Failed to send SetDefaultSettings\n");
+}
+
+/* ---- stop ---- */
+
+static void stop_measurement_reply(DBusMessage *message, void *user_data)
+{
+	struct cs_session *s = user_data;
+	DBusError error;
+
+	dbus_error_init(&error);
+	if (dbus_set_error_from_message(&error, message)) {
+		bt_shell_printf("StopMeasurement failed: %s\n", error.message);
+		dbus_error_free(&error);
+		return;
+	}
+
+	bt_shell_printf("Measurement stopped on %s\n",
+			g_dbus_proxy_get_path(s->proxy));
+	cs_sessions = g_list_remove(cs_sessions, s);
+	g_free(s);
+}
+
+static void cmd_cs_stop(int argc, char *argv[])
+{
+	const char *dev_path;
+	struct cs_session *s;
+	GDBusProxy *proxy;
+
+	if (argc >= 2) {
+		dev_path = cs_resolve_address(argv[1]);
+
+		if (!dev_path) {
+			bt_shell_printf("Device %s not found\n", argv[1]);
+			return;
+		}
+		proxy = cs_find_proxy(dev_path);
+		if (!proxy) {
+			bt_shell_printf("No ChannelSounding1 interface for"
+					" that device\n");
+			return;
+		}
+		s = cs_find_session(proxy);
+		if (!s) {
+			bt_shell_printf("No active measurement on %s\n",
+					argv[1]);
+			return;
+		}
+	} else {
+		if (!cs_sessions) {
+			bt_shell_printf("No active measurements\n");
+			return;
+		}
+		if (g_list_length(cs_sessions) > 1) {
+			bt_shell_printf("Multiple active measurements —"
+					" specify device address\n");
+			return;
+		}
+		s = cs_sessions->data;
+	}
+
+	if (!g_dbus_proxy_method_call(s->proxy, "StopMeasurement",
+				      NULL,
+				      stop_measurement_reply, s, NULL))
+		bt_shell_printf("Failed to send StopMeasurement\n");
+}
+
+/* ---- show ---- */
+
+static void cmd_cs_show(int argc, char *argv[])
+{
+	struct cs_session *s;
+	size_t j;
+	GList *list;
+
+	bt_shell_printf("Active measurements:\n");
+	if (!cs_sessions) {
+		bt_shell_printf("  none\n");
+	} else {
+		for (list = g_list_first(cs_sessions); list;
+		     list = g_list_next(list)) {
+			s = list->data;
+
+			bt_shell_printf("  %s\n",
+					g_dbus_proxy_get_path(s->proxy));
+		}
+	}
+
+	bt_shell_printf("\n=== Default Settings ===\n");
+	bt_shell_printf("  role           : %u"
+			" (1=Initiator 2=Reflector 3=Both)\n", cs_role);
+	bt_shell_printf("  cs_sync_ant_sel: 0x%02x\n", cs_sync_ant);
+	bt_shell_printf("  max_tx_power   : %d dBm\n", cs_max_tx_power);
+
+	bt_shell_printf("\n=== CS Config Params ===\n");
+	bt_shell_printf("  config_id               : %u\n",
+			cs_cfg.config_id);
+	bt_shell_printf("  main_mode_type          : 0x%02x\n",
+			cs_cfg.main_mode_type);
+	bt_shell_printf("  sub_mode_type           : 0x%02x\n",
+			cs_cfg.sub_mode_type);
+	bt_shell_printf("  main_mode_min_steps     : %u\n",
+			cs_cfg.main_mode_min_steps);
+	bt_shell_printf("  main_mode_max_steps     : %u\n",
+			cs_cfg.main_mode_max_steps);
+	bt_shell_printf("  main_mode_repetition    : %u\n",
+			cs_cfg.main_mode_repetition);
+	bt_shell_printf("  mode0_steps             : %u\n",
+			cs_cfg.mode0_steps);
+	bt_shell_printf("  role                    : %u\n",
+			cs_cfg.role);
+	bt_shell_printf("  rtt_types               : %u\n",
+			cs_cfg.rtt_types);
+	bt_shell_printf("  cs_sync_phy             : %u\n",
+			cs_cfg.cs_sync_phy);
+	bt_shell_printf("  channel_map             :");
+	for (j = 0; j < 10; j++)
+		bt_shell_printf(" %02x", cs_cfg.channel_map[j]);
+	bt_shell_printf("\n");
+	bt_shell_printf("  channel_map_repetition  : %u\n",
+			cs_cfg.channel_map_repetition);
+	bt_shell_printf("  channel_selection_type  : %u\n",
+			cs_cfg.channel_selection_type);
+	bt_shell_printf("  channel_shape           : %u\n",
+			cs_cfg.channel_shape);
+	bt_shell_printf("  channel_jump            : %u\n",
+			cs_cfg.channel_jump);
+	bt_shell_printf("  companion_signal_enable : %u\n",
+			cs_cfg.companion_signal_enable);
+
+	bt_shell_printf("\n=== CS Frequency Params ===\n");
+	bt_shell_printf("  max_procedure_duration        : %u\n",
+			cs_freq.max_procedure_duration);
+	bt_shell_printf("  min_period_between_procedures : %u\n",
+			cs_freq.min_period_between_procedures);
+	bt_shell_printf("  max_period_between_procedures : %u\n",
+			cs_freq.max_period_between_procedures);
+	bt_shell_printf("  max_procedure_count           : %u\n",
+			cs_freq.max_procedure_count);
+	bt_shell_printf("  min_sub_event_len             : %02x %02x %02x\n",
+			cs_freq.min_sub_event_len[0],
+			cs_freq.min_sub_event_len[1],
+			cs_freq.min_sub_event_len[2]);
+	bt_shell_printf("  max_sub_event_len             : %02x %02x %02x\n",
+			cs_freq.max_sub_event_len[0],
+			cs_freq.max_sub_event_len[1],
+			cs_freq.max_sub_event_len[2]);
+	bt_shell_printf("  tone_antenna_config_selection : 0x%02x\n",
+			cs_freq.tone_antenna_config_selection);
+	bt_shell_printf("  phy                           : 0x%02x\n",
+			cs_freq.phy);
+	bt_shell_printf("  tx_power_delta                : 0x%02x\n",
+			cs_freq.tx_power_delta);
+	bt_shell_printf("  preferred_peer_antenna        : 0x%02x\n",
+			cs_freq.preferred_peer_antenna);
+	bt_shell_printf("  snr_control_initiator         : 0x%02x\n",
+			cs_freq.snr_control_initiator);
+	bt_shell_printf("  snr_control_reflector         : 0x%02x\n",
+			cs_freq.snr_control_reflector);
+}
+
+static const struct bt_shell_menu cs_menu = {
+	.name = "cs",
+	.desc = "Channel Sounding Submenu",
+	.entries = {
+	{ "start",  "[dev_addr [duration_secs]] [param=value ...]",
+				cmd_cs_start,
+				"Set param and start distance measurement" },
+	{ "defset", "[param=value ...]",
+				cmd_cs_defset,
+				"Set CS default settings (role, cs_sync_ant_sel,"
+				" max_tx_power) without starting a measurement;"
+				" required for reflector role" },
+	{ "stop",   "[dev_addr]",
+				cmd_cs_stop,
+				"Stop the active distance measurement;"
+				" address required when multiple are active" },
+	{ "show",   NULL,
+				cmd_cs_show,
+				"Show active session id and current"
+				" CS parameters" },
+	{ } },
+};
+
+void cs_add_submenu(void)
+{
+	bt_shell_add_submenu(&cs_menu);
+}
+
+void cs_remove_submenu(void)
+{
+}
diff --git a/client/cs.h b/client/cs.h
new file mode 100644
index 000000000..8902c8143
--- /dev/null
+++ b/client/cs.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "gdbus/gdbus.h"
+
+void cs_add_submenu(void);
+void cs_remove_submenu(void);
+
+void cs_proxy_added(GDBusProxy *proxy);
+void cs_proxy_removed(GDBusProxy *proxy);
+void cs_device_disconnected(const char *dev_path);
+void cs_measurement_started(GDBusProxy *proxy);
+void cs_measurement_stopped(GDBusProxy *proxy);
+void cs_set_device_list(GList **devices);
diff --git a/client/main.c b/client/main.c
index 9d9ac8b14..80bba4ec5 100644
--- a/client/main.c
+++ b/client/main.c
@@ -39,6 +39,7 @@
 #include "assistant.h"
 #include "hci.h"
 #include "telephony.h"
+#include "cs.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -60,6 +61,7 @@ struct adapter {
 	GList *devices;
 	GList *sets;
 	GList *bearers;
+	GList *cs_proxies;
 };
 
 static struct adapter *default_ctrl;
@@ -124,6 +126,7 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 	battery_proxies = NULL;
 
 	default_ctrl = NULL;
+	cs_set_device_list(NULL);
 }
 
 static void print_adapter(GDBusProxy *proxy, const char *description)
@@ -391,8 +394,10 @@ static struct adapter *adapter_new(GDBusProxy *proxy)
 
 	ctrl_list = g_list_append(ctrl_list, adapter);
 
-	if (!default_ctrl)
+	if (!default_ctrl) {
 		default_ctrl = adapter;
+		cs_set_device_list(&adapter->devices);
+	}
 
 	return adapter;
 }
@@ -525,6 +530,31 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		bearer_added(proxy);
 	} else if (!strcmp(interface, "org.bluez.Bearer.LE1")) {
 		bearer_added(proxy);
+	} else if (!strcmp(interface, "org.bluez.ChannelSounding1")) {
+		const char *cs_path = g_dbus_proxy_get_path(proxy);
+		GList *list;
+
+		for (list = g_list_first(ctrl_list); list;
+		     list = g_list_next(list)) {
+			struct adapter *a = list->data;
+			const char *ap;
+			size_t ap_len;
+
+			if (!a->proxy)
+				continue;
+
+			ap = g_dbus_proxy_get_path(a->proxy);
+			ap_len = strlen(ap);
+
+			if (!strncmp(cs_path, ap, ap_len) &&
+						cs_path[ap_len] == '/') {
+				a->cs_proxies = g_list_append(
+							a->cs_proxies, proxy);
+				break;
+			}
+		}
+
+		cs_proxy_added(proxy);
 	}
 }
 
@@ -577,6 +607,7 @@ static void adapter_removed(GDBusProxy *proxy)
 			g_list_free(adapter->devices);
 			g_list_free(adapter->sets);
 			g_list_free(adapter->bearers);
+			g_list_free(adapter->cs_proxies);
 			g_free(adapter);
 			g_list_free(ll);
 			return;
@@ -656,6 +687,30 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		bearer_removed(proxy);
 	} else if (!strcmp(interface, "org.bluez.Bearer.LE1")) {
 		bearer_removed(proxy);
+	} else if (!strcmp(interface, "org.bluez.ChannelSounding1")) {
+		const char *cs_path = g_dbus_proxy_get_path(proxy);
+		GList *list;
+
+		for (list = g_list_first(ctrl_list); list;
+		     list = g_list_next(list)) {
+			struct adapter *a = list->data;
+			const char *ap;
+			size_t ap_len;
+
+			if (!a->proxy)
+				continue;
+
+			ap = g_dbus_proxy_get_path(a->proxy);
+			ap_len = strlen(ap);
+
+			if (!strncmp(cs_path, ap, ap_len) &&
+						cs_path[ap_len] == '/') {
+				a->cs_proxies = g_list_remove(
+							a->cs_proxies, proxy);
+				break;
+			}
+		}
+		cs_proxy_removed(proxy);
 	}
 }
 
@@ -729,6 +784,10 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 				else if (!connected && default_dev == proxy)
 					set_default_device(NULL, NULL);
 
+				if (!connected)
+					cs_device_disconnected(
+						g_dbus_proxy_get_path(proxy));
+
 				/* If the device is connected and the filter
 				 * is auto_connect and it matches the pattern,
 				 * stop discovery.
@@ -821,6 +880,16 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 			print_iter(str, name, iter);
 			g_free(str);
 		}
+	} else if (!strcmp(interface, "org.bluez.ChannelSounding1")) {
+		if (!strcmp(name, "Active")) {
+			dbus_bool_t active;
+
+			dbus_message_iter_get_basic(iter, &active);
+			if (active)
+				cs_measurement_started(proxy);
+			else
+				cs_measurement_stopped(proxy);
+		}
 	}
 }
 
@@ -1090,6 +1159,7 @@ static void cmd_select(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	default_ctrl = adapter;
+	cs_set_device_list(&adapter->devices);
 	print_adapter(adapter->proxy, NULL);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -4003,6 +4073,7 @@ int main(int argc, char *argv[])
 	assistant_add_submenu();
 	hci_add_submenu();
 	telephony_add_submenu();
+	cs_add_submenu();
 	bt_shell_set_prompt(PROMPT_OFF, NULL);
 
 	bt_shell_handle_non_interactive_help();
-- 


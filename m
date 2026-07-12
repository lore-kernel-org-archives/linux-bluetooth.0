Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1741230EF80
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783858712; cv=none; b=CK1qIOGu3nWKPxbavnf9+o5K2JfqyZUYJN8hi0bbuF1Tlou6dKRVOGYyy6OKIDuAkSxscRcL3trE/2H8QJAKcXR9gSd9bO3NuV6zmX3kZxo5H1PlaabnK9yFVbQIIJM6KpvDI+oEYJdeXNe1aStipvhudEOU4urgZlx+zvU5INg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783858712; c=relaxed/simple;
	bh=sqVBHbNIX4sA8I7HNeZkVA9ekbS+Ya2wzHioOI7pNm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jb/G9z5l4+MxNmw4MK2fGDj19wyPAZ3c2LF+iLOocDQH2a64QhMBZzEldbKhahRl28ND0umpkc+UqjTngenTRr9Ochqr+VlJT49QY1YQ1GSwUBY9bGzWiix8antrdwEGYOzkvKCS5AjPi1BIYkyqZUqZiK0EhNbANf7bwNBE0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f3no/yOh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FbZnFqiE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f3no/yOh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FbZnFqiE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CAdkvw2290776
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s97CR8F8YkthtziY0JtqEapDqfBCvbizxchHlEAplRw=; b=f3no/yOhiXUNdEcW
	uA0rg8hFv9mmmhKjmhZAz0jzQd5RveO6enU12/bKbdMI40vFstpZK/rZWOjGkOy+
	HjMpNn8c5Q8NzAjO33qIjysOYU6t1CqJpVTVILrTWRwepcLBQTQOi6Z43sbuQOfb
	wo2RPhikBL74jmOAt5ktyz9uRSNlbK3Dgdn4CcNWxX5Zjc8z4Fo4sGf2tBfUqUiS
	sKTOB5ya874EPDZrsYtkQcS65DWSXBL6nsdzf66YwyXw/L241OrWDmKPk9GkDfjz
	DAftVG5O6PxQPwlQmP6xieti7MT+mLrgb49d80VICtbeyBK1+j4Fd/+Qnzf0ocEl
	+j+ehw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe912rnn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:18:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c860544c077so3219262a12.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 05:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783858707; x=1784463507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s97CR8F8YkthtziY0JtqEapDqfBCvbizxchHlEAplRw=;
        b=FbZnFqiEMaC7lnnekSCrtfj0IM0VtcF0aKnPT5vuU/C/wjR/JvqhT7pVCcwBOzPEfu
         cqc1h2aJ1jDQcS2uu44PaCfKCS0H1wy+tFGV+ZkkcgRmxV+Zo6DUbeRAAbmCbi62uG5H
         5IFpgeDf7SSU3nihsZKKrDYk570DHSl2aquN2cqr2FDUny2HIdW6MNORyOGm0bI6HpSr
         ztW0JKJnObhxuUWBApGNIuo7x1SoSst0U1Pa6JD6++XqT/UvJvh3Kc5P+KaolEjJIpfX
         c6aUGnkL4v0/X82i94txOzBYUH77RN8QaZfTbWfk0ht5BiYTuAcjN6ITXPHXbq8PSAcA
         KIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783858707; x=1784463507;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s97CR8F8YkthtziY0JtqEapDqfBCvbizxchHlEAplRw=;
        b=JVQQnhshEeMvBCeQUAzBBPQjw7MqXlfOPZZ44FrjPkg0aofX7osHlI54UajhhO8Dpf
         ffR7atMW/BePaHDm/dGVvs9LQXPDsYN2An4YgEDaYvcG6noqgCI2b5PdrIPhclxtDr2U
         42M6Ko2SWzGYJMLhkd8Py7DukQOhONdoChgntaTEOyToG+CB2y+bra/SS3qkiTzPv3YS
         uRmIeEsmhXGnghVGta4kxEc7d+k7TMeO9Cg45QhiWPMHZk77EVvkyHONtil1ztBeinGj
         wUPDPV7Hz6SICp5nidL9V5MrYuR3tc/qWy43SHzzL8FqzIvoWtuEiVJi6Ea3gBF6tG0c
         naVA==
X-Gm-Message-State: AOJu0YxdOo6tGl2T41BFnhWFgAZaTILYR1G5byN/gAiiTMLHBT7QLy9g
	fLKkudFuYY/oYs4MBp8mCUSUqI9FIWM7OGV0LY1/JV6zhAczozvQYulOh/TYKOtsmX+S7VkUJ/I
	+5W5xditgpqdZbLRF88tF4oVQIpI2b0wot1hZ/C3wsdiVlxc/FAgwbBK6WjMFZxMDTY7u0vGHCK
	NCOqQ=
X-Gm-Gg: AfdE7cntUsgEJcuLI8x75Ovl4AEHKLfMsuWjqxzWLSCQdAxUYaTMnQiA8VwNnKubKWx
	W61rGRfFdHjDlViqdQQGZbLPOAIWS+W0icguQDeMsXqKrld5+ww+fryoMqSwmdLSp+GUGInDJ5j
	n3FYKtefu7rzGdNJqy5hNw3zAjoiUu/5+Z/xW7Oajdjm/JC/rc4yx/UjqGDWtnwfQHdqPAPoGVJ
	nlDTyeru7SpBZccx6pyNJfTP6Ivx1lbgaeCDjp24eiGqil8sODSpjcsNrjEDPhT2MbmoANBzZFE
	RbLdh8IZRHxeqtCxA3Es/0iIBjE5nTz7ukYduLvZs07KvTW6wVH3Q7pVuVqxwMgcDNAiGP8iKgI
	8e+GSOahNrLygHLBAk+cLlXe0eruosa3mOeNZYcfO
X-Received: by 2002:a05:6a20:7350:b0:3c0:9c1b:d0c0 with SMTP id adf61e73a8af0-3c110a5070emr6056813637.75.1783858706563;
        Sun, 12 Jul 2026 05:18:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:7350:b0:3c0:9c1b:d0c0 with SMTP id adf61e73a8af0-3c110a5070emr6056780637.75.1783858705793;
        Sun, 12 Jul 2026 05:18:25 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm29061040c88.1.2026.07.12.05.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 05:18:25 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 4/4] client: Add Channel Sounding shell submenu
Date: Sun, 12 Jul 2026 17:47:43 +0530
Message-Id: <20260712121743.2842547-5-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260712121743.2842547-1-naga.akella@oss.qualcomm.com>
References: <20260712121743.2842547-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a538615 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=BNXz1j1ro0pgg1kRGjgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDEyOSBTYWx0ZWRfX86fMWrIeKxpO
 CjOzcdoeDU1H8q4DAi7KmUSK+Iq84EsYCqRTashulbLFoXmGuRStoq/aecXbyi95hiM9WL3IEFZ
 1611ZUG4Fa7bm7BcgoH1gOqT4j5WuBY=
X-Proofpoint-GUID: qXLz_B2Qb0enLNrJBfH8tAFuChYyt8tD
X-Proofpoint-ORIG-GUID: qXLz_B2Qb0enLNrJBfH8tAFuChYyt8tD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDEyOSBTYWx0ZWRfXwGSycMPVxKLp
 RwmAfRkaS+5kzm3TrIC0BLA8H/waxtRlxRF/toKpxLEbDPuDBx1W6qvvK9LCtaCumDVBbfVxB39
 f8iiGrOYptnr6Z0k+w3PAwkEOdkdFtidF6YmpUrAHRiJz7Dk8R3N40lneaf91s5ezhl9WA0jc+3
 bWa5zmKp+N46dsG7ldUmLZJHjmY9IHzCwb/tikgFx5jqf31b+kJCZyFP+k+ZraDm7P6DPnHnogJ
 5OQu6Id5PABnOpp7VVHjxvoDxKNrSuLm6bO4GTHvPYLpI/KlGjM0HzCElKRx3oYhNXGc985K1Wk
 nCO/eLOkH3TtMEVrcLovtHO8oV2YrJS90cng3zaG/aMj80XYJyxTMN5SKErsGpzg/4NkjpTVBlr
 z/wBqNBjqgQ5Bv54vBvOh10j2jl0RwsJg9FZVVjUeDXfc4+WS/cLO3pELA/2BaOZ3eFijzaCSA5
 pvHqE3guSSeqZ3UGh6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120129

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
 Makefile.tools |    3 +-
 client/cs.c    | 1157 ++++++++++++++++++++++++++++++++++++++++++++++++
 client/cs.h    |   18 +
 client/main.c  |   27 +-
 4 files changed, 1203 insertions(+), 2 deletions(-)
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
index 000000000..89251b502
--- /dev/null
+++ b/client/cs.c
@@ -0,0 +1,1157 @@
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
+#include "src/shared/util.h"
+#include "cs.h"
+
+static GList * cs_proxies;
+static GList **cs_device_list;
+static DBusConnection *dbus_conn;
+
+#define RANGING_INTERFACE "org.bluez.ChannelSoundingRanging1"
+#define RANGE_ESTIMATE     "RangeEstimate"
+
+/* One signal watch per device proxy, so each device's RangeEstimate
+ * watch can be independently added/removed instead of clobbering a
+ * single shared handle.
+ */
+struct cs_watch {
+	GDBusProxy *proxy;
+	guint watch_id;
+};
+
+static GList *cs_watches;
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
+enum cs_param_type {
+	CS_PARAM_U8,
+	CS_PARAM_U8_RANGE,
+	CS_PARAM_U16,
+};
+
+struct cs_param_desc {
+	const char *name;
+	enum cs_param_type type;
+	void *field;
+	unsigned long min;
+	unsigned long max;
+	const char *range_error;
+};
+
+static const struct cs_param_desc cs_param_table[] = {
+	{ .name = "sync_ant_sel", .type = CS_PARAM_U8, .field = &cs_sync_ant },
+	{ .name = "config_id", .type = CS_PARAM_U8,
+		.field = &cs_cfg.config_id },
+	{ .name = "main_mode_type", .type = CS_PARAM_U8,
+		.field = &cs_cfg.main_mode_type },
+	{ .name = "sub_mode_type", .type = CS_PARAM_U8,
+		.field = &cs_cfg.sub_mode_type },
+	{ .name = "main_mode_min_steps", .type = CS_PARAM_U8,
+		.field = &cs_cfg.main_mode_min_steps },
+	{ .name = "main_mode_max_steps", .type = CS_PARAM_U8,
+		.field = &cs_cfg.main_mode_max_steps },
+	{ .name = "main_mode_repetition", .type = CS_PARAM_U8,
+		.field = &cs_cfg.main_mode_repetition },
+	{ .name = "mode0_steps", .type = CS_PARAM_U8,
+		.field = &cs_cfg.mode0_steps },
+	{ .name = "rtt_types", .type = CS_PARAM_U8,
+		.field = &cs_cfg.rtt_types },
+	{ .name = "role", .type = CS_PARAM_U8_RANGE, .field = &cs_role,
+		.min = 0x01, .max = 0x03,
+		.range_error = "role: 01=Initiator 02=Reflector 03=Both\n" },
+	{ .name = "sync_phy", .type = CS_PARAM_U8_RANGE,
+		.field = &cs_cfg.cs_sync_phy, .min = 0x01, .max = 0x02,
+		.range_error = "sync_phy: 0x01=LE 1M 0x02=LE 2M\n" },
+	{ .name = "channel_map_repetition", .type = CS_PARAM_U8,
+		.field = &cs_cfg.channel_map_repetition },
+	{ .name = "channel_selection_type", .type = CS_PARAM_U8,
+		.field = &cs_cfg.channel_selection_type },
+	{ .name = "channel_shape", .type = CS_PARAM_U8,
+		.field = &cs_cfg.channel_shape },
+	{ .name = "channel_jump", .type = CS_PARAM_U8,
+		.field = &cs_cfg.channel_jump },
+	{ .name = "companion_signal_enable", .type = CS_PARAM_U8_RANGE,
+		.field = &cs_cfg.companion_signal_enable, .min = 0, .max = 1,
+		.range_error = "companion_signal_enable: 0 or 1\n" },
+	{ .name = "max_procedure_duration", .type = CS_PARAM_U16,
+		.field = &cs_freq.max_procedure_duration },
+	{ .name = "min_period_between_procedures", .type = CS_PARAM_U16,
+		.field = &cs_freq.min_period_between_procedures },
+	{ .name = "max_period_between_procedures", .type = CS_PARAM_U16,
+		.field = &cs_freq.max_period_between_procedures },
+	{ .name = "max_procedure_count", .type = CS_PARAM_U16,
+		.field = &cs_freq.max_procedure_count },
+	{ .name = "tone_antenna_config_selection", .type = CS_PARAM_U8,
+		.field = &cs_freq.tone_antenna_config_selection },
+	{ .name = "phy", .type = CS_PARAM_U8_RANGE, .field = &cs_freq.phy,
+		.min = 0x01, .max = 0x02,
+		.range_error = "phy: 0x01=LE 1M  0x02=LE 2M\n" },
+	{ .name = "tx_power_delta", .type = CS_PARAM_U8,
+		.field = &cs_freq.tx_power_delta },
+	{ .name = "preferred_peer_antenna", .type = CS_PARAM_U8,
+		.field = &cs_freq.preferred_peer_antenna },
+	{ .name = "snr_control_initiator", .type = CS_PARAM_U8,
+		.field = &cs_freq.snr_control_initiator },
+	{ .name = "snr_control_reflector", .type = CS_PARAM_U8,
+		.field = &cs_freq.snr_control_reflector },
+};
+
+static gboolean range_estimate_cb(DBusConnection *connection,
+					DBusMessage *msg, void *user_data)
+{
+	GDBusProxy *proxy = user_data;
+	DBusMessageIter iter;
+	double distance;
+	uint8_t confidence;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return TRUE;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_DOUBLE)
+		return TRUE;
+
+	dbus_message_iter_get_basic(&iter, &distance);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BYTE)
+		return TRUE;
+
+	dbus_message_iter_get_basic(&iter, &confidence);
+
+	bt_shell_printf("[CS] %s Distance: %.3f m  Confidence: %u%%\n",
+			g_dbus_proxy_get_path(proxy), distance, confidence);
+
+	return TRUE;
+}
+
+static struct cs_watch *cs_find_watch(GDBusProxy *proxy)
+{
+	struct cs_watch *w;
+	GList *list;
+
+	for (list = g_list_first(cs_watches); list; list = g_list_next(list)) {
+		w = list->data;
+
+		if (w->proxy == proxy)
+			return w;
+	}
+
+	return NULL;
+}
+
+void cs_proxy_added(GDBusProxy *proxy)
+{
+	struct cs_watch *w;
+
+	cs_proxies = g_list_append(cs_proxies, proxy);
+
+	if (!dbus_conn)
+		dbus_conn = bt_shell_get_env("DBUS_CONNECTION");
+
+	if (!dbus_conn)
+		return;
+
+	w = g_new0(struct cs_watch, 1);
+	w->proxy = proxy;
+	w->watch_id = g_dbus_add_signal_watch(dbus_conn, NULL,
+					g_dbus_proxy_get_path(proxy),
+					RANGING_INTERFACE, RANGE_ESTIMATE,
+					range_estimate_cb, proxy, NULL);
+	cs_watches = g_list_append(cs_watches, w);
+}
+
+void cs_proxy_removed(GDBusProxy *proxy)
+{
+	struct cs_session *s;
+	struct cs_watch *w;
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
+
+	w = cs_find_watch(proxy);
+	if (w) {
+		g_dbus_remove_watch(dbus_conn, w->watch_id);
+		cs_watches = g_list_remove(cs_watches, w);
+		g_free(w);
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
+	dict_append_byte(&dict, "sync_ant_sel", cs_sync_ant);
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
+	dict_append_byte(&dict, "sync_phy",
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
+static bool parse_hex_bytes(const char *name, const char *valstr,
+					uint8_t *out, unsigned int count)
+{
+	const char *str = valstr;
+	char *endptr;
+	unsigned long uval;
+	unsigned int i = 0;
+
+	while (i < count) {
+		uval = strtoul(str, &endptr, 16);
+		if (endptr == str || uval > 0xFF) {
+			bt_shell_printf("%s: invalid byte at index %u\n",
+					name, i);
+			return false;
+		}
+		out[i++] = (uint8_t)uval;
+		if (*endptr == '\0')
+			break;
+		if (*endptr != ':') {
+			bt_shell_printf("%s: expected ':' separator\n", name);
+			return false;
+		}
+		str = endptr + 1;
+	}
+
+	if (i != count) {
+		bt_shell_printf("%s: need exactly %u colon-separated hex"
+				" bytes\n", name, count);
+		return false;
+	}
+
+	return true;
+}
+
+static const struct cs_param_desc *cs_find_param_desc(const char *name)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(cs_param_table); i++) {
+		if (!strcmp(cs_param_table[i].name, name))
+			return &cs_param_table[i];
+	}
+
+	return NULL;
+}
+
+static bool cs_set_param(const char *name, const char *valstr)
+{
+	const struct cs_param_desc *desc;
+	char *endptr;
+	unsigned long uval;
+	long sval;
+
+	/* Byte-array: channel_map — 10 colon-separated hex bytes */
+	if (strcmp(name, "channel_map") == 0) {
+		if (!parse_hex_bytes(name, valstr, cs_cfg.channel_map, 10))
+			return false;
+		return true;
+	}
+
+	/* Byte-array: min/max_sub_event_len — 3 colon-separated hex bytes */
+	if (strcmp(name, "min_sub_event_len") == 0)
+		return parse_hex_bytes(name, valstr,
+					cs_freq.min_sub_event_len, 3);
+	if (strcmp(name, "max_sub_event_len") == 0)
+		return parse_hex_bytes(name, valstr,
+					cs_freq.max_sub_event_len, 3);
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
+	desc = cs_find_param_desc(name);
+	if (!desc) {
+		bt_shell_printf("Unknown parameter: %s\n", name);
+		return false;
+	}
+
+	/* All remaining parameters are unsigned */
+	uval = strtoul(valstr, &endptr, 0);
+	if (*endptr != '\0') {
+		bt_shell_printf("%s: invalid value '%s'\n", name, valstr);
+		return false;
+	}
+
+	if (desc->type == CS_PARAM_U8_RANGE &&
+			(uval < desc->min || uval > desc->max)) {
+		bt_shell_printf("%s", desc->range_error);
+		return false;
+	}
+
+	if (desc->type == CS_PARAM_U16)
+		*(uint16_t *)desc->field = (uint16_t)uval;
+	else
+		*(uint8_t *)desc->field = (uint8_t)uval;
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
+	if (cs_role == 0x02) {
+		bt_shell_printf("Default settings applied on %s;"
+				" Reflector role does not start a local"
+				" measurement\n",
+				g_dbus_proxy_get_path(proxy));
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
+static void cs_print_role_hint(uint8_t role)
+{
+	if (role == 0x02)
+		bt_shell_printf("Note: Reflector role only uses"
+				" role/cs_sync_ant_sel/max_tx_power;"
+				" other CS config/frequency parameters"
+				" are ignored.\n");
+	else
+		bt_shell_printf("Note: Initiator role requires dev_addr"
+				" and duration_secs; CS config/frequency"
+				" parameters configure the measurement"
+				" procedure.\n");
+}
+
+/* Generic handler for the per-parameter set commands (cs.role,
+ * cs.main_mode_type, ...); argv[0] is the parameter name (the command
+ * itself), argv[1] is the value.
+ */
+static void cmd_cs_set(int argc, char *argv[])
+{
+	if (argc < 2) {
+		bt_shell_printf("Usage: %s <value>\n", argv[0]);
+		return;
+	}
+
+	if (!cs_set_param(argv[0], argv[1]))
+		return;
+
+	if (!strcmp(argv[0], "role"))
+		cs_print_role_hint(cs_role);
+}
+
+/* Tab completion for params whose only legal values are a small fixed
+ * enum, so users don't need to consult documentation to know what's
+ * valid.
+ */
+static char *cs_value_generator(const char *text, int state,
+					const char * const values[])
+{
+	static unsigned int index, len;
+	const char *value;
+
+	if (!state) {
+		index = 0;
+		len = strlen(text);
+	}
+
+	while ((value = values[index])) {
+		index++;
+
+		if (!strncmp(value, text, len))
+			return strdup(value);
+	}
+
+	return NULL;
+}
+
+static const char * const cs_role_values[] = { "0x01", "0x02", "0x03", NULL };
+
+static char *cs_role_generator(const char *text, int state)
+{
+	return cs_value_generator(text, state, cs_role_values);
+}
+
+static const char * const cs_main_mode_type_values[] = { "1", "2", "3", NULL };
+
+static char *cs_main_mode_type_generator(const char *text, int state)
+{
+	return cs_value_generator(text, state, cs_main_mode_type_values);
+}
+
+static const char * const cs_phy_values[] = { "0x01", "0x02", NULL };
+
+static char *cs_phy_generator(const char *text, int state)
+{
+	return cs_value_generator(text, state, cs_phy_values);
+}
+
+static const char * const cs_bool_values[] = { "0", "1", NULL };
+
+static char *cs_bool_generator(const char *text, int state)
+{
+	return cs_value_generator(text, state, cs_bool_values);
+}
+
+static const char * const cs_sub_mode_type_values[] = { "0x01", "0x02",
+							"0x03", "0xFF", NULL };
+
+static char *cs_sub_mode_type_generator(const char *text, int state)
+{
+	return cs_value_generator(text, state, cs_sub_mode_type_values);
+}
+
+static void cmd_cs_start(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	char *endptr;
+	unsigned long val;
+
+	pending_duration_secs = 0;
+	pending_dev_path = NULL;
+
+	if (argc >= 2) {
+		pending_dev_path = cs_resolve_address(argv[1]);
+		if (!pending_dev_path) {
+			bt_shell_printf("Device %s not found\n", argv[1]);
+			return;
+		}
+	}
+
+	if (argc >= 3) {
+		val = strtoul(argv[2], &endptr, 0);
+
+		if (*endptr != '\0') {
+			bt_shell_printf("Invalid duration: %s\n", argv[2]);
+			return;
+		}
+		pending_duration_secs = (uint32_t)val;
+	}
+
+	if (argc > 3) {
+		bt_shell_printf("Too many arguments\n");
+		return;
+	}
+
+	cs_print_role_hint(cs_role);
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
+	bt_shell_printf("  sync_ant_sel   : 0x%02x\n", cs_sync_ant);
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
+	bt_shell_printf("  configured role         : %u\n",
+			cs_cfg.role);
+	bt_shell_printf("  rtt_types               : %u\n",
+			cs_cfg.rtt_types);
+	bt_shell_printf("  sync_phy                : %u\n",
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
+	{ "start",  "[dev_addr] [duration_secs]",
+				cmd_cs_start,
+				"Start distance measurement using the"
+				" current parameters (see cs.<param>"
+				" commands below).\n"
+				"\t\t\t\t\t\tInitiator (role 0x01/0x03): requires"
+				" dev_addr and duration_secs.\n"
+				"\t\t\t\t\t\tReflector (role 0x02): dev_addr/"
+				"duration_secs are ignored, and no local"
+				" measurement is started.",
+				NULL },
+	{ "stop",   "[dev_addr]",
+				cmd_cs_stop,
+				"Stop the active distance measurement;"
+				" address required when multiple are active" },
+	{ "show",   NULL,
+				cmd_cs_show,
+				"Show active session id and current"
+				" CS parameters" },
+	{ "role", "<0x01|0x02|0x03>", cmd_cs_set,
+				"CS role: 0x01 Initiator, 0x02 Reflector,"
+				" 0x03 Both (default 0x03)",
+				cs_role_generator },
+	{ "sync_ant_sel", "<value>", cmd_cs_set,
+				"CS sync antenna selection; 0xFE/0xFF"
+				" reserved (default 0xFF)" },
+	{ "max_tx_power", "<-127..20>", cmd_cs_set,
+				"Max TX power in dBm, signed (default 20)" },
+	{ "config_id", "<value>", cmd_cs_set,
+				"CS configuration identifier (default 0)" },
+	{ "main_mode_type", "<1|2|3>", cmd_cs_set,
+				"1 Mode 1 (RTT), 2 Mode 2 (PBR), 3 Both"
+				" (default 1)",
+				cs_main_mode_type_generator },
+	{ "sub_mode_type", "<0x01|0x02|0x03|0xFF>", cmd_cs_set,
+				"Sub-mode within main mode; 0xFF = unused"
+				" (default 0xFF)",
+				cs_sub_mode_type_generator },
+	{ "main_mode_min_steps", "<value>", cmd_cs_set,
+				"Min CS main mode steps per subevent"
+				" (default 2)" },
+	{ "main_mode_max_steps", "<value>", cmd_cs_set,
+				"Max CS main mode steps per subevent"
+				" (default 3)" },
+	{ "main_mode_repetition", "<value>", cmd_cs_set,
+				"Times main mode steps are repeated in a"
+				" subevent (default 1)" },
+	{ "mode0_steps", "<value>", cmd_cs_set,
+				"CS Mode 0 steps at the beginning of each"
+				" subevent (default 2)" },
+	{ "rtt_types", "<value>", cmd_cs_set,
+				"RTT measurement types bitmask (default 0)" },
+	{ "sync_phy", "<0x01|0x02>", cmd_cs_set,
+				"PHY for CS sync: 0x01 LE 1M, 0x02 LE 2M"
+				" (default 0x01)",
+				cs_phy_generator },
+	{ "channel_map", "<10 colon-separated hex bytes>", cmd_cs_set,
+				"10-byte channel map bitmap"
+				" (default FC:FF:7F:FC:FF:FF:FF:FF:FF:1F)" },
+	{ "channel_map_repetition", "<value>", cmd_cs_set,
+				"Consecutive repetitions of the channel map"
+				" (default 1)" },
+	{ "channel_selection_type", "<value>", cmd_cs_set,
+				"CS channel selection algorithm (default 0)" },
+	{ "channel_shape", "<value>", cmd_cs_set,
+				"Shape used in channel selection algorithm"
+				" (default 0)" },
+	{ "channel_jump", "<value>", cmd_cs_set,
+				"Channel jump size (default 2)" },
+	{ "companion_signal_enable", "<0|1>", cmd_cs_set,
+				"1 to transmit companion signal, 0 to disable"
+				" (default 0)",
+				cs_bool_generator },
+	{ "min_sub_event_len", "<3 colon-separated hex bytes>", cmd_cs_set,
+				"Min CS subevent length, 3-byte LE"
+				" (default 00:20:00)" },
+	{ "max_sub_event_len", "<3 colon-separated hex bytes>", cmd_cs_set,
+				"Max CS subevent length, 3-byte LE"
+				" (default 03:20:00)" },
+	{ "max_procedure_duration", "<value>", cmd_cs_set,
+				"Maximum duration of one CS measurement"
+				" procedure (default 1600)" },
+	{ "min_period_between_procedures", "<value>", cmd_cs_set,
+				"Minimum time between consecutive procedures"
+				" (default 30)" },
+	{ "max_period_between_procedures", "<value>", cmd_cs_set,
+				"Maximum time between consecutive procedures"
+				" (default 150)" },
+	{ "max_procedure_count", "<value>", cmd_cs_set,
+				"Max number of procedures; 0 = no limit"
+				" (default 0)" },
+	{ "tone_antenna_config_selection", "<value>", cmd_cs_set,
+				"Antenna config for CS tone exchanges"
+				" (default 0x07)" },
+	{ "phy", "<0x01|0x02>", cmd_cs_set,
+				"PHY for CS procedures: 0x01 LE 1M, 0x02 LE 2M"
+				" (default 0x01)",
+				cs_phy_generator },
+	{ "tx_power_delta", "<value>", cmd_cs_set,
+				"Remote vs local TX power delta; 0x80 = not"
+				" applicable (default 0x80)" },
+	{ "preferred_peer_antenna", "<value>", cmd_cs_set,
+				"Preferred antenna for the peer device"
+				" (default 0x03)" },
+	{ "snr_control_initiator", "<value>", cmd_cs_set,
+				"SNR control for initiator; 0xFF = no"
+				" preference (default 0xFF)" },
+	{ "snr_control_reflector", "<value>", cmd_cs_set,
+				"SNR control for reflector; 0xFF = no"
+				" preference (default 0xFF)" },
+	{ NULL } },
+};
+
+void cs_add_submenu(void)
+{
+	bt_shell_add_submenu(&cs_menu);
+}
+
+void cs_remove_submenu(void)
+{
+	g_list_free_full(cs_sessions, g_free);
+	cs_sessions = NULL;
+
+	while (cs_watches) {
+		struct cs_watch *w = cs_watches->data;
+
+		g_dbus_remove_watch(dbus_conn, w->watch_id);
+		cs_watches = g_list_remove(cs_watches, w);
+		g_free(w);
+	}
+
+	g_list_free(cs_proxies);
+	cs_proxies = NULL;
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
index 9d9ac8b14..b5cad8afc 100644
--- a/client/main.c
+++ b/client/main.c
@@ -39,6 +39,7 @@
 #include "assistant.h"
 #include "hci.h"
 #include "telephony.h"
+#include "cs.h"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
@@ -124,6 +125,7 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 	battery_proxies = NULL;
 
 	default_ctrl = NULL;
+	cs_set_device_list(NULL);
 }
 
 static void print_adapter(GDBusProxy *proxy, const char *description)
@@ -391,8 +393,10 @@ static struct adapter *adapter_new(GDBusProxy *proxy)
 
 	ctrl_list = g_list_append(ctrl_list, adapter);
 
-	if (!default_ctrl)
+	if (!default_ctrl) {
 		default_ctrl = adapter;
+		cs_set_device_list(&adapter->devices);
+	}
 
 	return adapter;
 }
@@ -525,6 +529,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		bearer_added(proxy);
 	} else if (!strcmp(interface, "org.bluez.Bearer.LE1")) {
 		bearer_added(proxy);
+	} else if (!strcmp(interface, "org.bluez.ChannelSounding1")) {
+		cs_proxy_added(proxy);
 	}
 }
 
@@ -656,6 +662,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		bearer_removed(proxy);
 	} else if (!strcmp(interface, "org.bluez.Bearer.LE1")) {
 		bearer_removed(proxy);
+	} else if (!strcmp(interface, "org.bluez.ChannelSounding1")) {
+		cs_proxy_removed(proxy);
 	}
 }
 
@@ -729,6 +737,10 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 				else if (!connected && default_dev == proxy)
 					set_default_device(NULL, NULL);
 
+				if (!connected)
+					cs_device_disconnected(
+						g_dbus_proxy_get_path(proxy));
+
 				/* If the device is connected and the filter
 				 * is auto_connect and it matches the pattern,
 				 * stop discovery.
@@ -821,6 +833,16 @@ static void property_changed(GDBusProxy *proxy, const char *name,
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
 
@@ -1090,6 +1112,7 @@ static void cmd_select(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
 	default_ctrl = adapter;
+	cs_set_device_list(&adapter->devices);
 	print_adapter(adapter->proxy, NULL);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -4003,6 +4026,7 @@ int main(int argc, char *argv[])
 	assistant_add_submenu();
 	hci_add_submenu();
 	telephony_add_submenu();
+	cs_add_submenu();
 	bt_shell_set_prompt(PROMPT_OFF, NULL);
 
 	bt_shell_handle_non_interactive_help();
@@ -4044,6 +4068,7 @@ int main(int argc, char *argv[])
 	assistant_remove_submenu();
 	hci_remove_submenu();
 	telephony_remove_submenu();
+	cs_remove_submenu();
 
 	g_dbus_client_unref(client);
 
-- 


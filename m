Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD393A4F4A
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783858699; cv=none; b=cr75B8TBdGoURpHgCXms3fdpaK0inCErsjhX9NfcvxjYjD9Ei9DZ3zZvrqiaMjNmxvidh77MiaicxRJDhJ36N3quIEAtxq25xFNr7+Wq5r/XvBmjvX39kfYRkiGVPuNn2FwslvboJSF20o42IE1ZiCYJH3UBrsKduWBst44S2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783858699; c=relaxed/simple;
	bh=1+VQv1HmzPrh6LbO/+FD5IdLV8Zp6wVBhlzD9xjX5UI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6+6rNSPD5+vOwWDxwQLGIWdGPWdJhcpMCkZ4vxW5jYmDFRRCw/tGF9oF17Bmu7rG2xG3qVhJTn1RGjHGJdPkjaEXEeIKydr5g+IRobxvSCT8LQSIrsCwrV4HmmFyYQqQSQ6oNlzQDXmvHvgJjDnVNVnGixwBe3g8HXXAkpJVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GmejIUr0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jgbTnhd5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GmejIUr0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jgbTnhd5"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CAc5hW2287838
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L2nq432WzGARMSW3b3FF1aOp2Q3pw9oedSSQv61hENI=; b=GmejIUr0qgNcElVq
	YiaVex3AoXi7b/LY5mGGzmJHfG5NnxNb6CnHOR945L05Rm013RevgST3sfjlAW7E
	CfWRPJMkTgP+C5XOgvRE6tbjXZTtMcXK2cNRqpzu8guotaT9Tz2cYlxjwDm63BY4
	rRTZCnpUND4c/qZLh5YmaEoh0lAxJVg1mHrriPbqel/a5vWld32dp7qHdKNEydu+
	0vr+t5TkmpbMW4QVxsdbxLK4d14IVb6Rnnsbdst1PbLD2JCuoM805VuwygHryi5c
	5rvUJ13OPLjHBMEp79DjgxjeJS9Tpc9GkJ0cFz8ct6rgUkmC6TfdSvsyHV2CMnoa
	qxy19w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe912rn3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 12:18:15 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8482fd61e83so4642676b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2026 05:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783858694; x=1784463494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L2nq432WzGARMSW3b3FF1aOp2Q3pw9oedSSQv61hENI=;
        b=jgbTnhd5t2T50MrOzYiJRDHNmOJa/9X/HgHvSNmZkpaWOsEOE6xfhnYNMU/G+aXIR6
         Vrirr6q5GLKwBncQeu3uiatuz2MX6XUrzuy7gDEBs5DNCQ38rFQGYyjRNARdB2LcTrkn
         1ZYnCqSBOUWREctkmapYXcsSg5heKXwaiHF0GJUTgZ6Ajpws383DEj7hx2qgt3GngBcl
         EQpdDF7j/mKAO8FtQ5ymrMEkJ9KZOzYJpRKuy36MWQN4rLtlqkqT8tQIOXSBez0q+CiY
         JwaaTmZRpMgd5kZycEYlLC+5QXepadBQWvz+CqIv6uvzZGP47BvpuaN9A/qHgybxbzcq
         BOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783858694; x=1784463494;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2nq432WzGARMSW3b3FF1aOp2Q3pw9oedSSQv61hENI=;
        b=JFYoTmWc5zSYbpXV4Zom5vIAlu8zoBfkrOSPfyc9H/CUIXwV93eZPazz++LUmBoOAa
         IUijlFQg221+y5vxNKXcwbzdE+t8fJyA/mNNMWEXwu6jmR4lAk0oRNG95yHjZSMsGUri
         8MjcsBfRMpLgW89e/rzaeX0YfgnTnNKNCPWCPd7vg/uNry1vLx9RMc0Sr7u02UeuBb0C
         VTd9vdAMPEGcpyohq3SASqZqY2LR8gIysQvA5+UXraLv1HwzSc/ahY0hdbho9cC3Z5T7
         WTCqOVi7bO5r9fyFlKklCSFAZcfWFLCtoQLJBoO9CKJv/U/a7YAit7ok9N6UeSZEXhRv
         GR2Q==
X-Gm-Message-State: AOJu0YwMgr+RQNqhXDlIgNj6yugXXSr5CvO622WfPEks0yBRxcL2lffZ
	RVsWCPHSRU6PTrO0TV0er8dewSF5e1Rqq5/VawIgEA/5Hztxxfc4t897qbBjt6pocP8vqavL3tb
	WiYpktnpGmr99pTJiTQUqz/tQPfM5TgYEeihM+EeE/ucUWrkUGbMKPHtmEZ5kpwEUtPLmWPwm9I
	QpgMI=
X-Gm-Gg: AfdE7cnwff3AordLLThi3PSRHQjitFGm0vymS4r5QFNCKDEdArF6CaLakUYK5KiEEaL
	WFNb8UNj/TDPDW6hQAk+k6hoEA/IXUTVD/fx7302D+VZBP8dLIGtCYVlBRiupnGMLS4Dv2+uFzf
	ZrrXcRd+a3hLF//0PbQG5GTniPHKqEakAP9U3n1c7A6YOpTq4ojfb0iFrgXva8DPjsUJcbE5fya
	TOjeUIqFgfzOT0+vGHO6hpRLdFqqbldsNbDuTn0+97VT6RzvSEUBOlBdyZfzBEWjwx4L6dxS8Ie
	zESqhF+uYCHwvboU0SNsFm89+rnbYabvAJJoO9FvvX7DzM/0SAMFj+nbjsEqS7rfbVUdMQkuYyp
	pOra+4vIJP0vW5kGgoXmXe/rX6FVNExzvAPJSZ6xg
X-Received: by 2002:a05:6a20:4322:b0:398:9379:d04d with SMTP id adf61e73a8af0-3c110a6e39fmr5530507637.24.1783858694009;
        Sun, 12 Jul 2026 05:18:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:4322:b0:398:9379:d04d with SMTP id adf61e73a8af0-3c110a6e39fmr5530469637.24.1783858693265;
        Sun, 12 Jul 2026 05:18:13 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm29061040c88.1.2026.07.12.05.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 05:18:12 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 3/4] profiles: Add D-Bus Channel Sounding control APIs
Date: Sun, 12 Jul 2026 17:47:42 +0530
Message-Id: <20260712121743.2842547-4-naga.akella@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a538607 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gyo3rhEH3o3uM01JGDwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDEyOSBTYWx0ZWRfXy51zcS9Dt/pl
 QhQ0LTW0B+AmJprZeliFUs9CgKC55ZBFV1c2qODUO2OxAYkrhz6GD9v5dOqbitcIQ7OOkZRT3FW
 OjBcuvNjqt9Q4doUcgXOyt9cBSmVINs=
X-Proofpoint-GUID: JqoR39hDctepV_yrWzWeKTixoeFte0Xw
X-Proofpoint-ORIG-GUID: JqoR39hDctepV_yrWzWeKTixoeFte0Xw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDEyOSBTYWx0ZWRfX/ULv1kihqUeH
 4S3waqQD8PYNQvZsJUnZzHCuIiva0QkLqHAELb7aOISvyTuUl838MRc07lMS0B+0kMFBbonSPIb
 zYAEDcka2E8i4sY1iVZ0h7YAnGPO1IHPBecAP9S0uj8BslrG8Q+6f68ZaJeSxzpzfXg3WDvddJC
 t0t5RVUSTzurCabqpnsPLQLIaEWOSo7+iIgTw4skoTzZ7mE/9es6Xek0V82ynAXb1jzDI6j2LPW
 rJtSpoeBOfkE+GFhT7fs+Sfs05IN6BWC43dOt/rUl76G6HFi/D29Z0Y5/rnaJCGG/R1WJbO8iOI
 i3w0a6n4wyONlNQWs3VNiiAv3v1BUZekb8KT6Sh9ligYOBWKIrQ3MNlMxIWNBk5qyahgWbQ58sv
 66Nwu5KB0AKD5l6gggiDdeC6bKqpIRqauGeXe7eOwDCawhE8ow0CrdFqiGkActAY+MiV6Q6ufRX
 UlYJEqTRUnDsZI51AVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120129

Expose org.bluez.ChannelSounding1 on the device path,
adding SetDefaultSettings, StartMeasurement, and StopMeasurement methods
and an Active property to let external clients configure and
control CS ranging sessions.

Replace hardcoded CS configuration values with configurable HCI accessors
(bt_rap_{get,set}_cs_config_params, bt_rap_{get,set}_cs_freq_params,
bt_rap_{get,set}_default_settings_params).
Add measurement control APIs (bt_rap_start_measurement,
bt_rap_stop_measurement) with optional timeout-based auto-stop
and callbacks for timeout and procedure-state changes,
allowing DBus Active state to reflect actual controller procedure status.
---
 profiles/ranging/rap.c     | 350 +++++++++++++++++++++++-
 profiles/ranging/rap_hci.c | 531 +++++++++++++++++++++++++------------
 2 files changed, 702 insertions(+), 179 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index fa3e27328..3ffc0da76 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -10,6 +10,7 @@
 #endif
 
 #include <stdbool.h>
+#include <stddef.h>
 #include <errno.h>
 
 #include <glib.h>
@@ -35,7 +36,11 @@
 #include "src/shared/rap.h"
 #include "attrib/att.h"
 #include "src/log.h"
+#include "src/shared/cs-types.h"
 #include "src/btd.h"
+#include "src/dbus-common.h"
+
+#define CS_INTERFACE "org.bluez.ChannelSounding1"
 
 struct rap_adapter_data {
 	struct btd_adapter *adapter;
@@ -43,6 +48,14 @@ struct rap_adapter_data {
 	int ref_count;  /* Number of devices using this adapter */
 };
 
+struct cs_session {
+	bool active;
+	uint32_t duration_secs;
+	struct bt_rap_le_cs_default_settings settings;
+	struct bt_rap_le_cs_config    cfg;
+	struct bt_rap_le_cs_frequency freq;
+};
+
 struct rap_data {
 	struct btd_device *device;
 	struct btd_service *service;
@@ -50,6 +63,8 @@ struct rap_data {
 	unsigned int ready_id;
 	struct rap_adapter_data *adapter_data;  /* Shared adapter-level HCI */
 	void *hci_sm;  /* Per-device HCI state machine */
+	uint16_t conn_handle;  /* Last known connection handle */
+	struct cs_session active_session;  /* active==false when idle */
 };
 
 static struct queue *sessions;
@@ -293,6 +308,306 @@ static void rap_attached(struct bt_rap *rap, void *user_data)
 	rap_data_add(data);
 }
 
+enum cs_dict_target {
+	CS_TARGET_SETTINGS,
+	CS_TARGET_CFG,
+	CS_TARGET_FREQ,
+};
+
+struct cs_dict_param_desc {
+	const char *key;
+	enum cs_dict_target target;
+	int vtype;
+	size_t offset;
+};
+
+#define CS_SETTINGS_FIELD(_key, _field) \
+	{ _key, CS_TARGET_SETTINGS, DBUS_TYPE_BYTE, \
+		offsetof(struct bt_rap_le_cs_default_settings, _field) }
+#define CS_CFG_FIELD(_key, _field) \
+	{ _key, CS_TARGET_CFG, DBUS_TYPE_BYTE, \
+		offsetof(struct bt_rap_le_cs_config, _field) }
+#define CS_FREQ_U8_FIELD(_key, _field) \
+	{ _key, CS_TARGET_FREQ, DBUS_TYPE_BYTE, \
+		offsetof(struct bt_rap_le_cs_frequency, _field) }
+#define CS_FREQ_U16_FIELD(_key, _field) \
+	{ _key, CS_TARGET_FREQ, DBUS_TYPE_UINT16, \
+		offsetof(struct bt_rap_le_cs_frequency, _field) }
+
+static const struct cs_dict_param_desc cs_dict_param_table[] = {
+	CS_SETTINGS_FIELD("role", role),
+	CS_SETTINGS_FIELD("sync_ant_sel", cs_sync_ant_sel),
+	CS_CFG_FIELD("config_id", config_id),
+	CS_CFG_FIELD("main_mode_type", main_mode_type),
+	CS_CFG_FIELD("sub_mode_type", sub_mode_type),
+	CS_CFG_FIELD("main_mode_min_steps", main_mode_min_steps),
+	CS_CFG_FIELD("main_mode_max_steps", main_mode_max_steps),
+	CS_CFG_FIELD("main_mode_repetition", main_mode_repetition),
+	CS_CFG_FIELD("mode0_steps", mode0_steps),
+	CS_CFG_FIELD("rtt_types", rtt_types),
+	CS_CFG_FIELD("sync_phy", cs_sync_phy),
+	CS_CFG_FIELD("channel_map_repetition", channel_map_repetition),
+	CS_CFG_FIELD("channel_selection_type", channel_selection_type),
+	CS_CFG_FIELD("channel_shape", channel_shape),
+	CS_CFG_FIELD("channel_jump", channel_jump),
+	CS_CFG_FIELD("companion_signal_enable", companion_signal_enable),
+	CS_FREQ_U16_FIELD("max_procedure_duration", max_procedure_duration),
+	CS_FREQ_U16_FIELD("min_period_between_procedures",
+				min_period_between_procedures),
+	CS_FREQ_U16_FIELD("max_period_between_procedures",
+				max_period_between_procedures),
+	CS_FREQ_U16_FIELD("max_procedure_count", max_procedure_count),
+	CS_FREQ_U8_FIELD("tone_antenna_config_selection",
+				tone_antenna_config_selection),
+	CS_FREQ_U8_FIELD("phy", phy),
+	CS_FREQ_U8_FIELD("tx_power_delta", tx_power_delta),
+	CS_FREQ_U8_FIELD("preferred_peer_antenna", preferred_peer_antenna),
+	CS_FREQ_U8_FIELD("snr_control_initiator", snr_control_initiator),
+	CS_FREQ_U8_FIELD("snr_control_reflector", snr_control_reflector),
+};
+
+static const struct cs_dict_param_desc *cs_find_dict_param_desc(
+							const char *key)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(cs_dict_param_table); i++) {
+		if (!strcmp(cs_dict_param_table[i].key, key))
+			return &cs_dict_param_table[i];
+	}
+
+	return NULL;
+}
+
+static DBusMessage *start_measurement(DBusConnection *conn,
+				DBusMessage *msg, void *user_data)
+{
+	struct rap_data *data = user_data;
+	struct bt_rap_le_cs_config cfg = { 0 };
+	struct bt_rap_le_cs_frequency freq = { 0 };
+	struct bt_rap_le_cs_default_settings settings = { 0 };
+	uint32_t duration_secs = 0;
+	DBusMessageIter iter = { 0 }, dict = { 0 };
+	DBusMessageIter entry = { 0 }, variant = { 0 };
+	const char *key = NULL;
+	int vtype = 0;
+	const struct cs_dict_param_desc *desc = NULL;
+	void *base = NULL;
+
+	if (data->active_session.active)
+		return g_dbus_create_error(msg,
+					"org.bluez.Error.InProgress",
+					"Measurement already active");
+
+	/* Seed locals from current state-machine defaults */
+	bt_rap_get_cs_config_params(data->hci_sm, &cfg);
+	bt_rap_get_cs_freq_params(data->hci_sm, &freq);
+	bt_rap_get_default_settings_params(data->hci_sm, &settings);
+
+	dbus_message_iter_init(msg, &iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+					   "Expected a{sv} dictionary");
+
+	dbus_message_iter_recurse(&iter, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_DICT_ENTRY) {
+		dbus_message_iter_recurse(&dict, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &variant);
+		vtype = dbus_message_iter_get_arg_type(&variant);
+
+		if (strcmp(key, "duration_secs") == 0) {
+			if (vtype != DBUS_TYPE_UINT32)
+				goto bad_type;
+			dbus_message_iter_get_basic(&variant, &duration_secs);
+		} else if (strcmp(key, "max_tx_power") == 0) {
+			uint8_t bval = 0;
+
+			if (vtype != DBUS_TYPE_BYTE)
+				goto bad_type;
+			dbus_message_iter_get_basic(&variant, &bval);
+			settings.max_tx_power = (int8_t)bval;
+		} else if (strcmp(key, "channel_map") == 0) {
+			DBusMessageIter array = { 0 };
+			uint8_t *bytes = NULL;
+			int len = 0;
+
+			if (vtype != DBUS_TYPE_ARRAY)
+				goto bad_type;
+			dbus_message_iter_recurse(&variant, &array);
+			dbus_message_iter_get_fixed_array(&array, &bytes, &len);
+			if (len != 10)
+				return g_dbus_create_error(msg,
+						DBUS_ERROR_INVALID_ARGS,
+						"channel_map must be 10 bytes");
+			memcpy(cfg.channel_map, bytes, 10);
+		} else if (strcmp(key, "min_sub_event_len") == 0 ||
+			   strcmp(key, "max_sub_event_len") == 0) {
+			DBusMessageIter array = { 0 };
+			uint8_t *bytes = NULL;
+			int len = 0;
+
+			if (vtype != DBUS_TYPE_ARRAY)
+				goto bad_type;
+			dbus_message_iter_recurse(&variant, &array);
+			dbus_message_iter_get_fixed_array(&array, &bytes, &len);
+			if (len != 3)
+				return g_dbus_create_error(msg,
+						DBUS_ERROR_INVALID_ARGS,
+						"sub_event_len must be 3 bytes");
+			if (strcmp(key, "min_sub_event_len") == 0)
+				memcpy(freq.min_sub_event_len, bytes, 3);
+			else
+				memcpy(freq.max_sub_event_len, bytes, 3);
+		} else {
+			desc = cs_find_dict_param_desc(key);
+			if (!desc)
+				goto bad_type;
+
+			if (vtype != desc->vtype)
+				goto bad_type;
+
+			switch (desc->target) {
+			case CS_TARGET_CFG:
+				base = &cfg;
+				break;
+			case CS_TARGET_FREQ:
+				base = &freq;
+				break;
+			case CS_TARGET_SETTINGS:
+				base = &settings;
+				break;
+			default:
+				base = &settings;
+				break;
+			}
+
+			if (desc->vtype == DBUS_TYPE_UINT16)
+				dbus_message_iter_get_basic(&variant,
+					(uint16_t *)((uint8_t *)base +
+								desc->offset));
+			else
+				dbus_message_iter_get_basic(&variant,
+					(uint8_t *)base + desc->offset);
+		}
+
+		dbus_message_iter_next(&dict);
+		continue;
+bad_type:
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+					   "Unexpected variant type for key");
+	}
+
+	if (data->conn_handle == 0)
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+					   "Device not connected");
+
+	if (!bt_rap_set_default_settings_params(data->hci_sm, &settings))
+		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
+					   "Set default settings failed");
+
+	if (!bt_rap_set_cs_config_params(data->hci_sm, &cfg))
+		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
+					   "Set CS config params failed");
+
+	if (!bt_rap_set_cs_freq_params(data->hci_sm, &freq))
+		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
+					   "Set CS freq params failed");
+
+	/* Reflector never initiates a CS procedure locally: apply the
+	 * settings so the controller is ready to respond to the remote
+	 * Initiator, but do not arm a local measurement session.
+	 */
+	if (settings.role == 0x02)
+		return dbus_message_new_method_return(msg);
+
+	if (!bt_rap_start_measurement(data->hci_sm, data->conn_handle,
+							duration_secs))
+		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
+					   "Start measurement failed");
+
+	data->active_session.active        = true;
+	data->active_session.duration_secs = duration_secs;
+	data->active_session.settings      = settings;
+	data->active_session.cfg           = cfg;
+	data->active_session.freq          = freq;
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *stop_measurement(DBusConnection *conn,
+				DBusMessage *msg, void *user_data)
+{
+	struct rap_data *data = user_data;
+
+	if (!data->active_session.active)
+		return g_dbus_create_error(msg,
+					"org.bluez.Error.NotConnected",
+					"No active measurement");
+
+	if (!bt_rap_stop_measurement(data->hci_sm))
+		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
+					"Stop measurement failed");
+
+	memset(&data->active_session, 0, sizeof(data->active_session));
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				device_get_path(data->device),
+				CS_INTERFACE, "Active");
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable cs_dbus_methods[] = {
+	{ GDBUS_METHOD("StartMeasurement",
+			GDBUS_ARGS({ "params", "a{sv}" }),
+			NULL,
+			start_measurement) },
+	{ GDBUS_METHOD("StopMeasurement",
+			NULL,
+			NULL,
+			stop_measurement) },
+	{ }
+};
+
+static gboolean cs_property_get_active(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct rap_data *data = user_data;
+	dbus_bool_t active = data->active_session.active ||
+				bt_rap_is_procedure_active(data->hci_sm);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &active);
+	return TRUE;
+}
+
+static const GDBusPropertyTable cs_dbus_properties[] = {
+	{ "Active", "b", cs_property_get_active, NULL, NULL, 0 },
+	{ }
+};
+
+static void rap_measurement_timeout_cb(void *user_data)
+{
+	struct rap_data *data = user_data;
+
+	memset(&data->active_session, 0, sizeof(data->active_session));
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				device_get_path(data->device),
+				CS_INTERFACE, "Active");
+}
+
+static void rap_proc_active_changed(bool active, void *user_data)
+{
+	struct rap_data *data = user_data;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				device_get_path(data->device),
+				CS_INTERFACE, "Active");
+}
+
 static int rap_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -347,6 +662,10 @@ static void rap_remove(struct btd_service *service)
 		return;
 	}
 
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				    device_get_path(device),
+				    CS_INTERFACE);
+
 	rap_data_remove(data);
 }
 
@@ -395,6 +714,11 @@ static int rap_accept(struct btd_service *service)
 			return -EINVAL;
 		}
 		DBG("HCI state machine attached successfully for device");
+
+		bt_rap_set_timeout_cb(data->hci_sm, rap_measurement_timeout_cb,
+					data);
+		bt_rap_set_proc_active_cb(data->hci_sm, rap_proc_active_changed,
+					data);
 	}
 
 	if (!bt_rap_attach(data->rap, client)) {
@@ -411,8 +735,7 @@ static int rap_accept(struct btd_service *service)
 		if (bt_hci_get_conn_handle(data->adapter_data->hci,
 					(const uint8_t *) bdaddr, &handle)) {
 			DBG("Found conn handle 0x%04X for %s", handle, addr);
-			DBG("Setting up handle mapping: handle=0x%04X",
-				handle);
+			data->conn_handle = handle;
 			bt_rap_set_conn_hndl(data->hci_sm,
 					data->rap, handle,
 					(const uint8_t *) bdaddr,
@@ -426,12 +749,33 @@ static int rap_accept(struct btd_service *service)
 
 	btd_service_connecting_complete(service, 0);
 
+	g_dbus_register_interface(btd_get_dbus_connection(),
+				  device_get_path(data->device),
+				  CS_INTERFACE, cs_dbus_methods,
+				  NULL, cs_dbus_properties, data, NULL);
+
 	return 0;
 }
 
 static int rap_disconnect(struct btd_service *service)
 {
-	DBG(" ");
+	struct rap_data *data = btd_service_get_user_data(service);
+	char addr[18];
+
+	ba2str(device_get_address(btd_service_get_device(service)), addr);
+	DBG("%s", addr);
+	if (!data) {
+		error("RAP Service not handled by profile");
+		return -EINVAL;
+	}
+
+	if (data && data->hci_sm && data->conn_handle) {
+		bt_rap_clear_conn_handle(data->hci_sm, data->conn_handle);
+		data->conn_handle = 0;
+	}
+
+	memset(&data->active_session, 0, sizeof(data->active_session));
+
 	btd_service_disconnecting_complete(service, 0);
 	return 0;
 }
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 13f1365f3..e57f967a2 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -21,6 +21,8 @@
 #include "lib/bluetooth/bluetooth.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/shared/timeout.h"
+#include "src/shared/cs-types.h"
 #include "src/shared/rap.h"
 #include "src/shared/att.h"
 #include "src/log.h"
@@ -60,19 +62,28 @@ _Static_assert(ARRAY_SIZE(state_names) == CS_STATE_UNSPECIFIED + 1,
 typedef void (*cs_callback_t)(uint16_t length,
 			const void *param, void *user_data);
 
-/* State Machine Context */
+typedef void (*cs_timeout_func_t)(void *user_data);
+
 struct cs_state_machine {
 	enum cs_state current_state;
 	enum cs_state old_state;
 	struct bt_hci *hci;
 	struct bt_rap *rap;
 	struct queue *event_ids;
+	unsigned int measurement_timeout_id;
 	bool initiator;
 	bool procedure_active;
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
 	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
 	struct queue *conn_mappings;  /* Per-instance connection mappings */
+	uint16_t active_conn_handle;  /* current measurement handle */
 	struct timespec last_chan_class_time;  /* For 1-second rate limit */
+	struct bt_rap_le_cs_config   cs_config;
+	struct bt_rap_le_cs_frequency cs_frequency;
+	cs_timeout_func_t timeout_func;
+	void *timeout_data;
+	void (*proc_active_func)(bool active, void *user_data);
+	void *proc_active_data;
 };
 
 /* Connection Handle Mapping */
@@ -85,7 +96,83 @@ struct rap_conn_mapping {
 	struct bt_rap *rap;
 };
 
-/* Connection Mapping Helper Functions */
+bool bt_rap_set_cs_config_params(void *hci_sm,
+				 const struct bt_rap_le_cs_config *config)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm || !config)
+		return false;
+
+	sm->cs_config = *config;
+	return true;
+}
+
+bool bt_rap_set_cs_freq_params(void *hci_sm,
+			       const struct bt_rap_le_cs_frequency *frequency)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm || !frequency)
+		return false;
+
+	sm->cs_frequency = *frequency;
+	return true;
+}
+
+bool bt_rap_set_default_settings_params(void *hci_sm,
+			const struct bt_rap_le_cs_default_settings *settings)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm || !settings)
+		return false;
+
+	sm->role_enable            = settings->role;
+	sm->cs_opt.role            = settings->role;
+	sm->cs_opt.cs_sync_ant_sel = settings->cs_sync_ant_sel;
+	sm->cs_opt.max_tx_power    = settings->max_tx_power;
+	return true;
+}
+
+bool bt_rap_get_cs_config_params(void *hci_sm,
+				 struct bt_rap_le_cs_config *config)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm || !config)
+		return false;
+
+	*config = sm->cs_config;
+	return true;
+}
+
+bool bt_rap_get_cs_freq_params(void *hci_sm,
+			       struct bt_rap_le_cs_frequency *frequency)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm || !frequency)
+		return false;
+
+	*frequency = sm->cs_frequency;
+	return true;
+}
+
+bool bt_rap_get_default_settings_params(void *hci_sm,
+			struct bt_rap_le_cs_default_settings *settings)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm || !settings)
+		return false;
+
+	settings->role            = sm->cs_opt.role;
+	settings->cs_sync_ant_sel = sm->cs_opt.cs_sync_ant_sel;
+	settings->max_tx_power    = sm->cs_opt.max_tx_power;
+	return true;
+}
+
 static void mapping_free(void *data)
 {
 	struct rap_conn_mapping *mapping = data;
@@ -173,6 +260,11 @@ static void cs_state_machine_init(struct cs_state_machine *sm,
 				uint8_t role, uint8_t cs_sync_ant_sel,
 				int8_t max_tx_power)
 {
+	static const uint8_t ch_map[10] = {
+		0xFC, 0xFF, 0x7F, 0xFC, 0xFF,
+		0xFF, 0xFF, 0xFF, 0xFF, 0x1F
+	};
+
 	if (!sm)
 		return;
 
@@ -185,15 +277,44 @@ static void cs_state_machine_init(struct cs_state_machine *sm,
 
 	/* Store role_enable for HCI commands (1, 2, or 3 from config) */
 	sm->role_enable = role;
-
-	/* Initialize per-instance CS options
-	 * Note: cs_opt.role will be overwritten with actual role (0x00 or 0x01)
-	 * from config complete event, but role_enable preserves the HCI value
-	 */
-	sm->cs_opt.role = role;
+	sm->cs_opt.role            = role;
 	sm->cs_opt.cs_sync_ant_sel = cs_sync_ant_sel;
-	sm->cs_opt.max_tx_power = max_tx_power;
-	sm->cs_opt.rtt_type = 0;  /* Will be set from config complete event */
+	sm->cs_opt.max_tx_power    = max_tx_power;
+	sm->cs_opt.rtt_type        = 0;
+
+	sm->cs_config.config_id              = 0;
+	sm->cs_config.main_mode_type         = 0x01;
+	sm->cs_config.sub_mode_type          = 0xFF;
+	sm->cs_config.main_mode_min_steps    = 0x02;
+	sm->cs_config.main_mode_max_steps    = 0x03;
+	sm->cs_config.main_mode_repetition   = 0x01;
+	sm->cs_config.mode0_steps            = 0x02;
+	sm->cs_config.role                   = 0x00;
+	sm->cs_config.rtt_types              = 0x00;
+	sm->cs_config.cs_sync_phy            = 0x01;
+	memcpy(sm->cs_config.channel_map, ch_map, 10);
+	sm->cs_config.channel_map_repetition = 0x01;
+	sm->cs_config.channel_selection_type = 0x00;
+	sm->cs_config.channel_shape          = 0x00;
+	sm->cs_config.channel_jump           = 0x02;
+	sm->cs_config.companion_signal_enable = 0x00;
+
+	sm->cs_frequency.max_procedure_duration        = 0x0640;
+	sm->cs_frequency.min_period_between_procedures = 0x001E;
+	sm->cs_frequency.max_period_between_procedures = 0x0096;
+	sm->cs_frequency.max_procedure_count           = 0x0000;
+	sm->cs_frequency.min_sub_event_len[0]          = 0x00;
+	sm->cs_frequency.min_sub_event_len[1]          = 0x20;
+	sm->cs_frequency.min_sub_event_len[2]          = 0x00;
+	sm->cs_frequency.max_sub_event_len[0]          = 0x03;
+	sm->cs_frequency.max_sub_event_len[1]          = 0x20;
+	sm->cs_frequency.max_sub_event_len[2]          = 0x00;
+	sm->cs_frequency.tone_antenna_config_selection = 0x07;
+	sm->cs_frequency.phy                           = 0x01;
+	sm->cs_frequency.tx_power_delta                = 0x80;
+	sm->cs_frequency.preferred_peer_antenna        = 0x03;
+	sm->cs_frequency.snr_control_initiator         = 0xFF;
+	sm->cs_frequency.snr_control_reflector         = 0xFF;
 }
 
 /* State Transition Logic */
@@ -228,7 +349,15 @@ static enum cs_state cs_get_current_state(struct cs_state_machine *sm)
 
 static bool is_initiator_role(const struct cs_state_machine *sm)
 {
-	return sm->role_enable == 0x01 || sm->role_enable == 0x03;
+	return sm->role_enable == 0x01;
+}
+
+/* For role_enable=0x03 (Both), Central acts as Initiator and Peripheral as
+ * Reflector — the link layer topology determines the CS role assignment.
+ */
+static bool is_both_role(const struct cs_state_machine *sm)
+{
+	return sm->role_enable == 0x03;
 }
 
 /* Helper function to send read remote capabilities for all connections */
@@ -262,20 +391,6 @@ static bool bt_rap_read_remote_supported_capabilities(void *hci_sm,
 	return true;
 }
 
-/* Helper function to send read remote capabilities for all connections */
-static void send_read_remote_cap_for_mapping(void *data, void *user_data)
-{
-	struct rap_conn_mapping *mapping = data;
-	struct cs_state_machine *sm = user_data;
-
-	if (!mapping || !sm)
-		return;
-
-	DBG("Sending read remote capabilities for handle 0x%04X",
-		mapping->handle);
-	bt_rap_read_remote_supported_capabilities(sm, mapping->handle);
-}
-
 /* HCI Event Callbacks */
 static void rap_rd_loc_supp_cap_done_cb(const void *data, uint8_t size,
 					void *user_data)
@@ -324,12 +439,9 @@ static void rap_rd_loc_supp_cap_done_cb(const void *data, uint8_t size,
 	/* Transition to INIT state before reading remote capabilities */
 	cs_set_state(sm, CS_STATE_INIT);
 
-	/* Send read remote capabilities for all connected devices */
-	if (sm->conn_mappings) {
-		DBG("Sending read remote capabilities for all connections");
-		queue_foreach(sm->conn_mappings,
-				send_read_remote_cap_for_mapping, sm);
-	}
+	DBG("Sending read remote capabilities for handle 0x%04X",
+		sm->active_conn_handle);
+	bt_rap_read_remote_supported_capabilities(sm, sm->active_conn_handle);
 }
 
 static void rap_send_hci_cs_create_config_command(struct cs_state_machine *sm,
@@ -338,11 +450,6 @@ static void rap_send_hci_cs_create_config_command(struct cs_state_machine *sm,
 	struct bt_hci_cmd_le_cs_create_config cmd;
 	unsigned int status;
 
-	uint8_t channel_map[10] = {
-		0xFC, 0xFF, 0x7F, 0xFC, 0xFF,
-		0xFF, 0xFF, 0xFF, 0xFF, 0x1F
-	};
-
 	if (!sm || !sm->hci) {
 		error("CS Create Config: sm or hci is null");
 		return;
@@ -352,23 +459,23 @@ static void rap_send_hci_cs_create_config_command(struct cs_state_machine *sm,
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.handle = cpu_to_le16(handle);
-	cmd.create_context = 1;
-	/* Default values, will change to pick user given values later */
-	cmd.config_id              = 0x00;
-	cmd.main_mode_type         = 0x01;
-	cmd.sub_mode_type          = 0xFF;
-	cmd.min_main_mode_steps    = 0x02;
-	cmd.max_main_mode_steps    = 0x03;
-	cmd.main_mode_repetition   = 0x01;
-	cmd.mode_0_steps           = 0x02;
-	cmd.role                   = 0x00;
-	cmd.rtt_type               = 0x00;
-	cmd.cs_sync_phy            = 0x01;
-	memcpy(cmd.channel_map, channel_map, 10);
-	cmd.channel_map_repetition = 0x01;
-	cmd.channel_selection_type = 0x00;
-	cmd.ch3c_shape             = 0x00;
-	cmd.ch3c_jump              = 0x02;
+	cmd.create_context = 0x01; /* Initiates cs config procedure */
+
+	cmd.config_id              = sm->cs_config.config_id;
+	cmd.main_mode_type         = sm->cs_config.main_mode_type;
+	cmd.sub_mode_type          = sm->cs_config.sub_mode_type;
+	cmd.min_main_mode_steps    = sm->cs_config.main_mode_min_steps;
+	cmd.max_main_mode_steps    = sm->cs_config.main_mode_max_steps;
+	cmd.main_mode_repetition   = sm->cs_config.main_mode_repetition;
+	cmd.mode_0_steps           = sm->cs_config.mode0_steps;
+	cmd.role                   = sm->cs_config.role;
+	cmd.rtt_type               = sm->cs_config.rtt_types;
+	cmd.cs_sync_phy            = sm->cs_config.cs_sync_phy;
+	memcpy(cmd.channel_map, sm->cs_config.channel_map, 10);
+	cmd.channel_map_repetition = sm->cs_config.channel_map_repetition;
+	cmd.channel_selection_type = sm->cs_config.channel_selection_type;
+	cmd.ch3c_shape             = sm->cs_config.channel_shape;
+	cmd.ch3c_jump              = sm->cs_config.channel_jump;
 	cmd.reserved               = 0x00;
 
 	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_CREATE_CONFIG,
@@ -388,6 +495,7 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 {
 	const struct bt_hci_rsp_le_cs_set_def_settings *rp;
 	struct cs_state_machine *sm = user_data;
+	struct rap_conn_mapping *m;
 
 	if (!sm || !data || size < sizeof(*rp))
 		return;
@@ -403,14 +511,24 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 	}
 
 	if (rp->status == 0) {
-		/* Success - proceed to configuration */
 		cs_set_state(sm, CS_STATE_WAIT_CONFIG_CMPLT);
 
-		/* If role is initiator, send CS Create Config command */
-		if (is_initiator_role(sm))
+		/* Send CS Create Config if we are (or will act as) Initiator.
+		 * For role_enable=Both, Central acts as Initiator.
+		 */
+		if (is_initiator_role(sm)) {
 			rap_send_hci_cs_create_config_command(sm, rp->handle);
-		else
+		} else if (is_both_role(sm)) {
+			m = find_mapping_by_handle(sm, rp->handle);
+
+			if (m && m->is_central)
+				rap_send_hci_cs_create_config_command(sm,
+								rp->handle);
+			else
+				DBG("Both role: Wait for CS Config Cmpl");
+		} else {
 			DBG("Reflector role: Waiting for CS Config Completed");
+		}
 	} else {
 		/* Error - transition to stopped */
 		error("CS Set default setting failed with status 0x%02X",
@@ -434,7 +552,7 @@ static void rap_send_hci_cs_remove_config_command(struct cs_state_machine *sm,
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.handle = cpu_to_le16(handle);
-	cmd.config_id = 0x00;  /* Default config ID */
+	cmd.config_id = sm->cs_config.config_id;
 
 	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_REMOVE_CONFIG,
 				&cmd, sizeof(cmd), NULL, sm, NULL);
@@ -481,13 +599,6 @@ static bool rap_send_hci_cs_set_procedure_parameters(
 {
 	struct bt_hci_cmd_le_cs_set_proc_params cmd;
 	unsigned int status;
-	uint8_t min_sub_event_len[3] = {
-		0x00, 0x20, 0x00
-	};
-
-	uint8_t max_sub_event_len[3] = {
-		0x03, 0x20, 0x00
-	};
 
 	if (!sm || !sm->hci) {
 		error("CS Set Procedure Parameters: sm or hci is null");
@@ -498,20 +609,25 @@ static bool rap_send_hci_cs_set_procedure_parameters(
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.handle = cpu_to_le16(handle);
-	/* Default values, will change to pick user given values later */
-	cmd.config_id = 0x00;
-	cmd.max_procedure_len = 0x0640;
-	cmd.min_procedure_interval = 0x1E;
-	cmd.max_procedure_interval = 0x96;
-	cmd.max_procedure_count = 0x00;
-	memcpy(cmd.min_subevent_len, min_sub_event_len, 3);
-	memcpy(cmd.max_subevent_len, max_sub_event_len, 3);
-	cmd.tone_antenna_config_selection = 0x07;
-	cmd.phy                    = 0x01;
-	cmd.tx_power_delta         = 0x80;
-	cmd.preferred_peer_antenna = 0x03;
-	cmd.snr_control_initiator  = 0xFF;
-	cmd.snr_control_reflector  = 0xFF;
+
+	cmd.config_id = sm->cs_config.config_id;
+	cmd.max_procedure_len =
+		cpu_to_le16(sm->cs_frequency.max_procedure_duration);
+	cmd.min_procedure_interval =
+		cpu_to_le16(sm->cs_frequency.min_period_between_procedures);
+	cmd.max_procedure_interval =
+		cpu_to_le16(sm->cs_frequency.max_period_between_procedures);
+	cmd.max_procedure_count =
+		cpu_to_le16(sm->cs_frequency.max_procedure_count);
+	memcpy(cmd.min_subevent_len, sm->cs_frequency.min_sub_event_len, 3);
+	memcpy(cmd.max_subevent_len, sm->cs_frequency.max_sub_event_len, 3);
+	cmd.tone_antenna_config_selection =
+		sm->cs_frequency.tone_antenna_config_selection;
+	cmd.phy                    = sm->cs_frequency.phy;
+	cmd.tx_power_delta         = sm->cs_frequency.tx_power_delta;
+	cmd.preferred_peer_antenna = sm->cs_frequency.preferred_peer_antenna;
+	cmd.snr_control_initiator  = sm->cs_frequency.snr_control_initiator;
+	cmd.snr_control_reflector  = sm->cs_frequency.snr_control_reflector;
 
 	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_SET_PROC_PARAMS,
 				&cmd, sizeof(cmd), NULL, sm, NULL);
@@ -541,7 +657,7 @@ static bool rap_send_hci_cs_procedure_enable(struct cs_state_machine *sm,
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.handle = cpu_to_le16(handle);
-	cmd.config_id = 0x00; /* Default config Id */
+	cmd.config_id = sm->cs_config.config_id;
 	cmd.enable = enable_proc ? 0x01 : 0x00;
 
 	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_PROC_ENABLE,
@@ -591,6 +707,8 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 {
 	struct cs_state_machine *sm = (struct cs_state_machine *) user_data;
 	const struct bt_hci_evt_le_cs_rd_rem_fae_complete *evt;
+	struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete tmp_ev;
+	struct rap_conn_mapping *m;
 	struct iovec iov;
 	int i;
 
@@ -598,11 +716,9 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 		size < sizeof(struct bt_hci_evt_le_cs_rd_rem_fae_complete))
 		return;
 
-	/* Initialize iovec with the event data */
 	iov.iov_base = (void *) data;
 	iov.iov_len = size;
 
-	/* Pull the entire structure at once */
 	evt = util_iov_pull_mem(&iov, sizeof(*evt));
 
 	if (!evt) {
@@ -612,21 +728,20 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 
 	DBG("status=0x%02X, handle=0x%04X", evt->status, evt->handle);
 
-	/* Check status */
 	if (evt->status != 0) {
 		/* Status 0x11 (Unsupported Feature or Parameter Value) means
 		 * the remote has zero FAE, the procedure continues
 		 * to the Default Settings step.
 		 */
 		if (evt->status == 0x11) {
-			DBG("Remote FAE=0 (No_FAE), proceed to Def Settings");
-			if (is_initiator_role(sm)) {
-				struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete
-								tmp_ev;
+			m = find_mapping_by_handle(sm, evt->handle);
 
+			DBG("Remote FAE=0 (No_FAE), proceed to Def Settings");
+			if (is_initiator_role(sm) ||
+			    (is_both_role(sm) && m && m->is_central)) {
 				memset(&tmp_ev, 0, sizeof(tmp_ev));
 				tmp_ev.handle = evt->handle;
-				DBG("Initiator: send def settings (No_FAE)");
+				DBG("Init/Both: send def settings (No_FAE)");
 				rap_send_hci_def_settings_command(sm, &tmp_ev);
 			} else {
 				DBG("Reflector role: continuing after No_FAE");
@@ -651,13 +766,13 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 	}
 
 	/* After receiving FAE Table, send default settings */
-	/* Local capabilities already read before this event */
-	if (is_initiator_role(sm)) {
-		struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete tmp_ev;
+	m = find_mapping_by_handle(sm, evt->handle);
 
+	if (is_initiator_role(sm) ||
+	    (is_both_role(sm) && m && m->is_central)) {
 		memset(&tmp_ev, 0, sizeof(tmp_ev));
 		tmp_ev.handle = evt->handle;
-		DBG("Initiator role: send def settings after FAE table");
+		DBG("Init/Both: send def settings after FAE");
 		rap_send_hci_def_settings_command(sm, &tmp_ev);
 	} else {
 		DBG("Reflector role: Proceeding after FAE Table");
@@ -698,6 +813,7 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 {
 	struct cs_state_machine *sm = user_data;
 	const struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *evt;
+	struct rap_conn_mapping *m;
 	struct iovec iov;
 	uint16_t subfeatures_supported;
 
@@ -745,9 +861,11 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	/* Local capabilities already read before this event */
-	if (is_initiator_role(sm)) {
-		DBG("Initiator role: send def settings cmd for handle 0x%04X",
+	m = find_mapping_by_handle(sm, evt->handle);
+
+	if (is_initiator_role(sm) ||
+	    (is_both_role(sm) && m && m->is_central)) {
+		DBG("Init/Both: send def settings for 0x%04X",
 			evt->handle);
 		rap_send_hci_def_settings_command(sm, evt);
 	} else {
@@ -763,6 +881,7 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 	struct cs_state_machine *sm = user_data;
 	const struct bt_hci_evt_le_cs_config_complete *evt;
 	struct rap_ev_cs_config_cmplt rap_ev;
+	struct rap_conn_mapping *mapping;
 	struct iovec iov;
 
 	if (!sm || !data || size < sizeof(*evt))
@@ -855,9 +974,6 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
 	/* CS Security Enable may only be issued by the BLE Central */
 	if (rap_ev.role == 0x00) {
-		/* Initiator role */
-		struct rap_conn_mapping *mapping;
-
 		mapping = find_mapping_by_handle(sm, evt->handle);
 		if (!mapping || !mapping->is_central) {
 			error("CS Security Enable skipped: not BLE Central");
@@ -980,8 +1096,8 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
 
 	DBG("size=0x%02X", size);
 
-	/* State Check */
-	if (cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT) {
+	if ((cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT) &&
+		(cs_get_current_state(sm) != CS_STATE_STARTED)) {
 		DBG("Event received in Wrong State!! ");
 		DBG("Expected : CS_STATE_WAIT_PROC_CMPLT");
 		return;
@@ -1002,6 +1118,8 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
 			evt->status);
 		cs_set_state(sm, CS_STATE_STOPPED);
 		sm->procedure_active = false;
+		if (sm->proc_active_func)
+			sm->proc_active_func(false, sm->proc_active_data);
 		return;
 	}
 
@@ -1030,9 +1148,13 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
 	if (rap_ev.state == 0x01) {
 		cs_set_state(sm, CS_STATE_STARTED);
 		sm->procedure_active = true;
+		if (sm->proc_active_func)
+			sm->proc_active_func(true, sm->proc_active_data);
 	} else if (rap_ev.state == 0x00) {
 		cs_set_state(sm, CS_STATE_STOPPED);
 		sm->procedure_active = false;
+		if (sm->proc_active_func)
+			sm->proc_active_func(false, sm->proc_active_data);
 	}
 
 	/* Send callback to RAP Profile */
@@ -1080,7 +1202,7 @@ static void parse_mode_zero_data(struct iovec *iov,
 	util_iov_pull_u8(iov, &mode_data->packet_ant);
 	DBG("CS Step mode 0");
 
-	if (cs_role == CS_INITIATOR && iov->iov_len >= 4) {
+	if (cs_role == CS_INITIATOR && iov->iov_len >= 2) {
 		util_iov_pull_le16(iov, &freq_offset);
 		mode_data->init_measured_freq_offset = freq_offset;
 	}
@@ -1171,7 +1293,6 @@ static void parse_mode_three_data(struct iovec *iov,
 				uint8_t cs_role, uint8_t cs_rtt_type,
 				uint8_t max_paths)
 {
-	uint8_t k;
 	struct cs_mode_one_data *mode_one = &mode_data->mode_one_data;
 	struct cs_mode_two_data *mode_two = &mode_data->mode_two_data;
 
@@ -1186,21 +1307,7 @@ static void parse_mode_three_data(struct iovec *iov,
 	parse_mode_one_data(iov, mode_one, cs_role, cs_rtt_type);
 
 	/* Parse Mode 2 portion */
-	if (iov->iov_len >= 1) {
-		util_iov_pull_u8(iov, &mode_two->ant_perm_index);
-		for (k = 0; k < max_paths; k++) {
-			int16_t i_val, q_val;
-
-			if (iov->iov_len < 4)
-				break;
-			parse_i_q_sample(iov, &i_val, &q_val);
-			mode_two->tone_pct[k].i_sample = i_val;
-			mode_two->tone_pct[k].q_sample = q_val;
-
-			util_iov_pull_u8(iov,
-					 &mode_two->tone_quality_indicator[k]);
-		}
-	}
+	parse_mode_two_data(iov, mode_two, max_paths);
 }
 
 /* Parse a single CS step */
@@ -1537,8 +1644,27 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 			uint8_t role, uint8_t cs_sync_ant_sel,
 			int8_t max_tx_power)
 {
+	static const struct {
+		uint8_t subevent;
+		bt_hci_callback_func_t callback;
+	} subevents[] = {
+		{ BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE,
+					rap_rd_rmt_supp_cap_cmplt_evt },
+		{ BT_HCI_EVT_LE_CS_RD_REM_FAE_COMPLETE,
+					rap_rd_rem_fae_cmplt_evt },
+		{ BT_HCI_EVT_LE_CS_CONFIG_COMPLETE,
+					rap_cs_config_cmplt_evt },
+		{ BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE,
+					rap_cs_sec_enable_cmplt_evt },
+		{ BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE,
+					rap_cs_proc_enable_cmplt_evt },
+		{ BT_HCI_EVT_LE_CS_SUBEVENT_RESULT,
+					rap_cs_subevt_result_evt },
+		{ BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
+					rap_cs_subevt_result_cont_evt },
+	};
 	struct cs_state_machine *sm;
-	unsigned int id;
+	unsigned int i;
 
 	if (!rap || !hci) {
 		error("rap or hci null");
@@ -1564,78 +1690,95 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 	}
 
 	/* Register each LE Meta subevent individually */
-	id = bt_hci_register_subevent(hci,
-			BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE,
-			rap_rd_rmt_supp_cap_cmplt_evt, sm, NULL);
-	if (!id)
-		goto fail;
+	for (i = 0; i < ARRAY_SIZE(subevents); i++) {
+		unsigned int id = bt_hci_register_subevent(hci,
+						subevents[i].subevent,
+						subevents[i].callback,
+						sm, NULL);
+		if (!id) {
+			error("Failed to register hci le meta subevents");
+			queue_foreach(sm->event_ids, unregister_event_id, hci);
+			queue_destroy(sm->event_ids, NULL);
+			queue_destroy(sm->conn_mappings, mapping_free);
+			free(sm);
+			return NULL;
+		}
 
-	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+		queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+	}
 
-	id = bt_hci_register_subevent(hci,
-		BT_HCI_EVT_LE_CS_RD_REM_FAE_COMPLETE,
-		rap_rd_rem_fae_cmplt_evt, sm, NULL);
+	DBG("HCI state machine attached (role=%u, ant=0x%02x, power=%d)",
+		sm->role_enable, sm->cs_opt.cs_sync_ant_sel,
+		sm->cs_opt.max_tx_power);
 
-	if (!id)
-		goto fail;
+	return sm;
+}
 
-	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+static bool measurement_timeout_cb(void *user_data)
+{
+	struct cs_state_machine *sm = user_data;
 
-	id = bt_hci_register_subevent(hci,
-			BT_HCI_EVT_LE_CS_CONFIG_COMPLETE,
-			rap_cs_config_cmplt_evt, sm, NULL);
-	if (!id)
-		goto fail;
+	sm->measurement_timeout_id = 0;
 
-	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+	DBG("Measurement duration expired, stopping CS procedure");
+	bt_rap_stop_measurement(sm);
 
-	id = bt_hci_register_subevent(hci,
-			BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE,
-			rap_cs_sec_enable_cmplt_evt, sm, NULL);
-	if (!id)
-		goto fail;
+	if (sm->timeout_func)
+		sm->timeout_func(sm->timeout_data);
 
-	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+	return false;
+}
 
-	id = bt_hci_register_subevent(hci,
-			BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE,
-			rap_cs_proc_enable_cmplt_evt, sm, NULL);
-	if (!id)
-		goto fail;
+bool bt_rap_start_measurement(void *hci_sm, uint16_t conn_handle,
+			      uint32_t duration_secs)
+{
+	struct cs_state_machine *sm = hci_sm;
 
-	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+	if (!sm || !sm->hci)
+		return false;
 
-	id = bt_hci_register_subevent(hci,
-			BT_HCI_EVT_LE_CS_SUBEVENT_RESULT,
-			rap_cs_subevt_result_evt, sm, NULL);
-	if (!id)
-		goto fail;
+	if (!find_mapping_by_handle(sm, conn_handle)) {
+		error("start_measurement: hndl 0x%04X not found", conn_handle);
+		return false;
+	}
 
-	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+	sm->active_conn_handle = conn_handle;
 
-	id = bt_hci_register_subevent(hci,
-			BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
-			rap_cs_subevt_result_cont_evt, sm, NULL);
-	if (!id)
-		goto fail;
+	if (sm->measurement_timeout_id) {
+		timeout_remove(sm->measurement_timeout_id);
+		sm->measurement_timeout_id = 0;
+	}
 
-	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
+	if (!bt_rap_read_local_supported_capabilities(sm))
+		return false;
 
-	DBG("CS options: role=%u, cs_sync_ant_sel=%u, max_tx_power=%d",
-		role, cs_sync_ant_sel, max_tx_power);
+	if (duration_secs > 0)
+		sm->measurement_timeout_id = timeout_add_seconds(duration_secs,
+					measurement_timeout_cb, sm, NULL);
 
-	/* place holder, need DBus API to be called */
-	bt_rap_read_local_supported_capabilities(sm);
+	return true;
+}
 
-	return sm;
+bool bt_rap_stop_measurement(void *hci_sm)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm || !sm->hci)
+		return false;
+
+	if (sm->measurement_timeout_id) {
+		timeout_remove(sm->measurement_timeout_id);
+		sm->measurement_timeout_id = 0;
+	}
 
-fail:
-	error("Failed to register hci le meta subevents");
-	queue_foreach(sm->event_ids, unregister_event_id, hci);
-	queue_destroy(sm->event_ids, NULL);
-	queue_destroy(sm->conn_mappings, mapping_free);
-	free(sm);
-	return NULL;
+	if (!find_mapping_by_handle(sm, sm->active_conn_handle)) {
+		error("stop_measurement: handle 0x%04X not found",
+		      sm->active_conn_handle);
+		return false;
+	}
+
+	return rap_send_hci_cs_procedure_enable(sm, sm->active_conn_handle,
+						false);
 }
 
 bool bt_rap_set_conn_hndl(void *hci_sm, struct bt_rap *rap,
@@ -1672,6 +1815,40 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 
 	DBG("Clearing connection mapping: handle=0x%04X", handle);
 	remove_conn_mapping(sm, handle);
+	sm->procedure_active = false;
+}
+
+bool bt_rap_is_procedure_active(void *hci_sm)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm)
+		return false;
+
+	return sm->procedure_active;
+}
+
+void bt_rap_set_timeout_cb(void *hci_sm, void (*func)(void *), void *user_data)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm)
+		return;
+
+	sm->timeout_func = func;
+	sm->timeout_data = user_data;
+}
+
+void bt_rap_set_proc_active_cb(void *hci_sm, void (*func)(bool, void *),
+				void *user_data)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm)
+		return;
+
+	sm->proc_active_func = func;
+	sm->proc_active_data = user_data;
 }
 
 void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm)
@@ -1690,12 +1867,14 @@ void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm)
 			queue_foreach(sm->event_ids, unregister_event_id,
 								sm->hci);
 
+		if (sm->measurement_timeout_id) {
+			timeout_remove(sm->measurement_timeout_id);
+			sm->measurement_timeout_id = 0;
+		}
+
 		queue_destroy(sm->event_ids, NULL);
 
-		/* Clean up per-instance connection mappings.
-		 * Each state machine owns its own conn_mappings queue;
-		 * this destroys all mappings for this instance only.
-		 */
+		/* destroys mappings for this instance only */
 		queue_destroy(sm->conn_mappings, mapping_free);
 
 		/* Free the state machine */
-- 


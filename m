Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493A414DDB
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354597; cv=none; b=akur3udkNBkjU279+f6Z4mRbICA3i5X/XrNpl7o9vK7odMVdU4kvUDgmRyt+qqsDM14SkHO03MUBBD/Pn+NFabcBFEm9CdSmWtEzYvhKGCZafNYaoXckAHHBr0uom9d7VJuOApAJp/YsD+vB01kWpupzZTEe3MKcTTwETGAXkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354597; c=relaxed/simple;
	bh=Z3vwiOAItWkAQAqpSQZ6dMIZKgULwq9jO/94fYgIVv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6Iqr2rEoOomoMSDaaOQt+RNn61v1234m91KxyKgMo+EVg2FTT2ZubKhEzttUnFycl9AvTsQaFkd6GHx/U1w3IsQnPq6NjDhFXnQ5Grtvdz7wZVdR995kDd4/lfzBD6QLkxh+ZrRaELn4pPxmW9qRXy5bfg9TRNoBWyo8RZ8MlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PanFUYVj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YnFB0+BM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PanFUYVj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YnFB0+BM"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFBoo958653
	for <linux-bluetooth@vger.kernel.org>; Mon, 6 Jul 2026 16:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nECjUFVLckNxoDMjtq6J78n+blr7vv9CJPHKf2hzqjQ=; b=PanFUYVjeCAWIaMU
	wjdGEWV8tAD2ag0NjDnGQ+e8tOjgOSsqKEP9M6dGQGrrzHqAxv1hooRZGkTr0eTw
	Qn/PAqn1BF6z4XGAbh1FLoeT08WRpH4Of1Si3BZnXA/AnU11C++sF48kneAEajGZ
	ypd5qOmsVgBjTQFuHY8JFJEZAzQ0X6XJySsCrg1N9mnBrQXKJezvptPAP34O4yVl
	JfwCKckRxO9tHWMrTVtmy1ciNFik1UtP6PtPV012j5LaXjAiladcbK9nrFA1DOnK
	LRhWJb4RGUhcA0C6Wn+ftyEZCgiNUR+jN9kg72I/liDM79/0Yb6Kch62E8HygK+q
	k+wN7g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9a87q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 16:16:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-381250979d5so3128559a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783354592; x=1783959392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nECjUFVLckNxoDMjtq6J78n+blr7vv9CJPHKf2hzqjQ=;
        b=YnFB0+BM/R0sn+oRz9bO/7AtaV3lvTn2eteN7a/xpUhKqv5Rbp+RnfDR8P/Ih7fXzq
         +/l6+PvXzBtykr1hlbtjA6IPZywusUSt4FiXglNUHZZJJnMV+Tih7IfB5HADTI+p+28d
         LnHECshglgjGmojyiRXJ+8/d/66IYjZl5conFeE3dAsZtXyIQc0lGgfiQlRQaSGvZVp7
         mc9CC62kGkY4jZr5ukJk1YJqRKjjt2e5rDoQwSW5Qr6vopsUdyKzwDZ9AgbvMzdOcmP3
         rPZKVnULD3YS2z5/mhrA3UHfktAk1TuSZl9eJ0ITZPfB3T/O9PJW9JvC7mGt2oDEGney
         lD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783354592; x=1783959392;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nECjUFVLckNxoDMjtq6J78n+blr7vv9CJPHKf2hzqjQ=;
        b=KvSQu1QUIo6WdMq2owKyo1ESuiIoVV6kT2g9rfePX3mKjVf71FcT3I9SIG2bcmFFbX
         iLQz8C+K9FZqHX1nMWLOQEWG4Kb6cf1C3/F0/ryXNnMEw7mZAJiR5Eo0xOoL0FA4IOyL
         ZJArbII+4Fsxd9BH0SXKGnLHcUFx/YUpqPmTBgwVEAqvrpQdnfCWqtnMm7DOz8N+3Ltz
         0hnjtfy8F/OCPy6Rwch+UI1M0j9Wq7EkElY3c9++bNOPL9o/nXEAO7FioLEK5etMxKCJ
         l2vQqC1wOjhfm95rHYNQrwGaFd+tfu8lg4lQXKUjceiFicRlNTRmqocaO82cYxPPMhLI
         NZbQ==
X-Gm-Message-State: AOJu0YyaxCWOgnWwUCUuRrrKznqNOcpcYz5Y9CDPXLwwhVxTlZURvdA4
	RIGIkWe0lwfOu4dt+m+/5xekbo1oieXV1x+tpL9NzF5Cwz6i0W5eBMmy3VS76S+OL7KQMilSwrJ
	9QS1Djx4uu0GGxbJ42P9hkZCEDBAXtC+N2nZ210Gye96MPbxaoXod+mrMhgwi9MAkc+6qO7iD2I
	TQqhw=
X-Gm-Gg: AfdE7ckeqedfmvYLmO4zT/LQ4HE4yB5Uj09erp6V42wX+Y0k8HQ/5uJAoucmgXb9nNv
	Cy71ZGIoRu/bq0NH7IQhcil5wqd574tx+NqDKdfyehnZqD88hpLic7R1pUQ6C4dFvVA1Wc3FBzm
	mwutlrCXclm0glREa3OCK21YsSYJ1SeEc1MRUSWo463LTHntXKPEm2H0YgL3uArIsSkZA+tJwZT
	FGLpLLc1Ah7JuFrrMvXZyYmQ0xEcF5JeDnNWtXCkXr0g3qtKhEvBDDcoaaKZMc6c1HCDTj5cweT
	Vie4kmpZ6bhek4F/p2eQA4jOuq2T349fpaaeU7mtpryPemM5kqfiTXSyVq5LGhu7/hUyEyLgxFW
	wJp+oLeFm4J32/4TT95s4SwmMefsle9iDYm88WEVw
X-Received: by 2002:a17:90b:55cd:b0:36d:5d1c:c4ad with SMTP id 98e67ed59e1d1-38755478040mr1143280a91.9.1783354591116;
        Mon, 06 Jul 2026 09:16:31 -0700 (PDT)
X-Received: by 2002:a17:90b:55cd:b0:36d:5d1c:c4ad with SMTP id 98e67ed59e1d1-38755478040mr1143211a91.9.1783354590211;
        Mon, 06 Jul 2026 09:16:30 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f31e7a2a8sm40022434eec.25.2026.07.06.09.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:16:29 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 4/5] profiles: Add D-Bus Channel Sounding control API
Date: Mon,  6 Jul 2026 21:46:02 +0530
Message-Id: <20260706161603.2744459-5-naga.akella@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: G7AZsYIwgZQQ4e7KnyrInPxWzxLCeecL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfX7zS55rKf6W3e
 jYWPkeDPRaE/C2SHSkjctKMYigs7R3/e5JPlVBzw6h1WLRoNQRNUuWy0f0axOc4lkrbfBAptnnR
 RTMZ0ZkBTiTQR2MRS0tTs48Wrj3c8UI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2NSBTYWx0ZWRfX6pQwp/207qye
 59HnEx7W+75Lie3Y/lV9L4KIaevm8FhF6Qh7QI9riNVsl6JumgiNCx/8UVogf4fKl7TppSloNEW
 PC5HGuoWa/UbX51KD6c8wBUA2+AYJaV4pRR+M0htRarzVktsDBzXED4uO49ivF6ds8Jbxmnty/C
 StbAttjhiMuTWocyzNcU6tqG7azP2nD7ZftMLm9d08nTjPi4epXxadJv3Y2peZgSpA9n1wMc377
 uB/9P2mDKNa56VpRFfcPFpy4KXWZQtViX19iDn5XocM0u5bePQXrMQCVdnCzk8mB05tGBxr8QIf
 pwVgMdpyy2TGZxj1GTWFGb9yigYYgcgxLJfWfAEhh+rOQmBRhQ6JYdkODLxxy48XNHRvtvS+5Pc
 njyj9J7UMZgfU9hwOCq+23UKyva9aa0UzfV5VnCuRSo2fJwBupZFgiOWIpd+0SQfcwoRD0kuetB
 gmqDDkfx3tKD4eKJSVw==
X-Proofpoint-GUID: G7AZsYIwgZQQ4e7KnyrInPxWzxLCeecL
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4bd4e1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=4jpyLtET5F4ua5H85VEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060165

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
 profiles/ranging/rap.c     | 405 ++++++++++++++++++++++++++++++---
 profiles/ranging/rap_hci.c | 454 +++++++++++++++++++++++++++----------
 2 files changed, 712 insertions(+), 147 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index fa3e27328..deb03b139 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -35,7 +35,11 @@
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
@@ -43,6 +47,14 @@ struct rap_adapter_data {
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
@@ -50,6 +62,8 @@ struct rap_data {
 	unsigned int ready_id;
 	struct rap_adapter_data *adapter_data;  /* Shared adapter-level HCI */
 	void *hci_sm;  /* Per-device HCI state machine */
+	uint16_t conn_handle;  /* Last known connection handle */
+	struct cs_session active_session;  /* active==false when idle */
 };
 
 static struct queue *sessions;
@@ -293,6 +307,335 @@ static void rap_attached(struct bt_rap *rap, void *user_data)
 	rap_data_add(data);
 }
 
+static DBusMessage *set_default_settings(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct rap_data *data = user_data;
+	struct bt_rap_le_cs_default_settings settings;
+	DBusMessageIter iter, dict;
+
+	bt_rap_get_default_settings_params(data->hci_sm, &settings);
+
+	dbus_message_iter_init(msg, &iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+					"Expected a{sv} dictionary");
+
+	dbus_message_iter_recurse(&iter, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter entry, variant;
+		const char *key;
+		int vtype;
+
+		dbus_message_iter_recurse(&dict, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &variant);
+		vtype = dbus_message_iter_get_arg_type(&variant);
+
+		if (strcmp(key, "role") == 0) {
+			if (vtype != DBUS_TYPE_BYTE)
+				goto bad_type;
+			dbus_message_iter_get_basic(&variant, &settings.role);
+		} else if (strcmp(key, "cs_sync_ant_sel") == 0) {
+			if (vtype != DBUS_TYPE_BYTE)
+				goto bad_type;
+			dbus_message_iter_get_basic(&variant,
+						    &settings.cs_sync_ant_sel);
+		} else if (strcmp(key, "max_tx_power") == 0) {
+			uint8_t bval;
+
+			if (vtype != DBUS_TYPE_BYTE)
+				goto bad_type;
+			dbus_message_iter_get_basic(&variant, &bval);
+			settings.max_tx_power = (int8_t)bval;
+		}
+
+		dbus_message_iter_next(&dict);
+		continue;
+bad_type:
+		return g_dbus_create_error(msg, DBUS_ERROR_INVALID_ARGS,
+					"Unexpected variant type for key");
+	}
+
+	if (!bt_rap_set_default_settings_params(data->hci_sm, &settings))
+		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
+					"Set default settings failed");
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *start_measurement(DBusConnection *conn,
+				DBusMessage *msg, void *user_data)
+{
+	struct rap_data *data = user_data;
+	struct bt_rap_le_cs_config cfg;
+	struct bt_rap_le_cs_frequency freq;
+	struct bt_rap_le_cs_default_settings settings;
+	uint32_t duration_secs = 0;
+	DBusMessageIter iter, dict;
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
+		DBusMessageIter entry, variant;
+		const char *key;
+		int vtype;
+
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
+		} else if (strcmp(key, "role") == 0 &&
+			   vtype == DBUS_TYPE_BYTE) {
+			dbus_message_iter_get_basic(&variant, &settings.role);
+		} else if (strcmp(key, "cs_sync_ant_sel") == 0 &&
+			   vtype == DBUS_TYPE_BYTE) {
+			dbus_message_iter_get_basic(&variant,
+						    &settings.cs_sync_ant_sel);
+		} else if (strcmp(key, "max_tx_power") == 0 &&
+			   vtype == DBUS_TYPE_BYTE) {
+			uint8_t bval;
+
+			dbus_message_iter_get_basic(&variant, &bval);
+			settings.max_tx_power = (int8_t)bval;
+		} else if (strcmp(key, "channel_map") == 0) {
+			DBusMessageIter array;
+			uint8_t *bytes;
+			int len;
+
+			if (vtype != DBUS_TYPE_ARRAY)
+				goto bad_type;
+			dbus_message_iter_recurse(&variant, &array);
+			dbus_message_iter_get_fixed_array(&array, &bytes, &len);
+			if (len != 10)
+				return g_dbus_create_error(msg,
+						DBUS_ERROR_INVALID_ARGS,
+						"channel_map must be 10 bytes");
+			memcpy(cfg.channel_map[0], bytes, 10);
+		} else if (strcmp(key, "min_sub_event_len") == 0 ||
+			   strcmp(key, "max_sub_event_len") == 0) {
+			DBusMessageIter array;
+			uint8_t *bytes;
+			int len;
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
+				memcpy(freq.min_sub_event_len[0], bytes, 3);
+			else
+				memcpy(freq.max_sub_event_len[0], bytes, 3);
+		} else if (strcmp(key, "max_procedure_duration") == 0 ||
+			   strcmp(key, "min_period_between_procedures") == 0 ||
+			   strcmp(key, "max_period_between_procedures") == 0 ||
+			   strcmp(key, "max_procedure_count") == 0) {
+			uint16_t u16val;
+
+			if (vtype != DBUS_TYPE_UINT16)
+				goto bad_type;
+			dbus_message_iter_get_basic(&variant, &u16val);
+
+			if (strcmp(key, "max_procedure_duration") == 0)
+				freq.max_procedure_duration[0] = u16val;
+			else if (strcmp(key,
+					"min_period_between_procedures") == 0)
+				freq.min_period_between_procedures[0] = u16val;
+			else if (strcmp(key,
+					"max_period_between_procedures") == 0)
+				freq.max_period_between_procedures[0] = u16val;
+			else
+				freq.max_procedure_count[0] = u16val;
+		} else {
+			/* All remaining keys expect a byte variant */
+			uint8_t bval;
+
+			if (vtype != DBUS_TYPE_BYTE)
+				goto bad_type;
+			dbus_message_iter_get_basic(&variant, &bval);
+
+			if (strcmp(key, "config_id") == 0)
+				cfg.config_id[0] = bval;
+			else if (strcmp(key, "main_mode_type") == 0)
+				cfg.main_mode_type[0] = bval;
+			else if (strcmp(key, "sub_mode_type") == 0)
+				cfg.sub_mode_type[0] = bval;
+			else if (strcmp(key, "main_mode_min_steps") == 0)
+				cfg.main_mode_min_steps[0] = bval;
+			else if (strcmp(key, "main_mode_max_steps") == 0)
+				cfg.main_mode_max_steps[0] = bval;
+			else if (strcmp(key, "main_mode_repetition") == 0)
+				cfg.main_mode_repetition[0] = bval;
+			else if (strcmp(key, "mode0_steps") == 0)
+				cfg.mode0_steps[0] = bval;
+			else if (strcmp(key, "rtt_types") == 0)
+				cfg.rtt_types[0] = bval;
+			else if (strcmp(key, "cs_sync_phy") == 0)
+				cfg.cs_sync_phy[0] = bval;
+			else if (strcmp(key, "channel_map_repetition") == 0)
+				cfg.channel_map_repetition[0] = bval;
+			else if (strcmp(key, "channel_selection_type") == 0)
+				cfg.channel_selection_type[0] = bval;
+			else if (strcmp(key, "channel_shape") == 0)
+				cfg.channel_shape[0] = bval;
+			else if (strcmp(key, "channel_jump") == 0)
+				cfg.channel_jump[0] = bval;
+			else if (strcmp(key, "companion_signal_enable") == 0)
+				cfg.companion_signal_enable[0] = bval;
+			else if (strcmp(key,
+					"tone_antenna_config_selection") == 0)
+				freq.tone_antenna_config_selection[0] = bval;
+			else if (strcmp(key, "phy") == 0)
+				freq.phy[0] = bval;
+			else if (strcmp(key, "tx_power_delta") == 0)
+				freq.tx_power_delta[0] = bval;
+			else if (strcmp(key, "preferred_peer_antenna") == 0)
+				freq.preferred_peer_antenna[0] = bval;
+			else if (strcmp(key, "snr_control_initiator") == 0)
+				freq.snr_control_initiator[0] = bval;
+			else if (strcmp(key, "snr_control_reflector") == 0)
+				freq.snr_control_reflector[0] = bval;
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
+	{ GDBUS_METHOD("SetDefaultSettings",
+			GDBUS_ARGS({ "params", "a{sv}" }),
+			NULL,
+			set_default_settings) },
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
@@ -329,6 +672,10 @@ static int rap_probe(struct btd_service *service)
 
 	bt_rap_set_user_data(data->rap, service);
 
+	bt_rap_set_timeout_cb(data->hci_sm, rap_measurement_timeout_cb, data);
+
+	bt_rap_set_proc_active_cb(data->hci_sm, rap_proc_active_changed, data);
+
 	return 0;
 }
 
@@ -347,13 +694,16 @@ static void rap_remove(struct btd_service *service)
 		return;
 	}
 
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				    device_get_path(device),
+				    CS_INTERFACE);
+
 	rap_data_remove(data);
 }
 
 static int rap_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct btd_adapter *adapter = device_get_adapter(device);
 	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
 	struct rap_data *data = btd_service_get_user_data(service);
 	struct bt_att *att;
@@ -370,33 +720,6 @@ static int rap_accept(struct btd_service *service)
 		return -EINVAL;
 	}
 
-	/* init shared adapter HCI channel */
-	if (!data->adapter_data) {
-		data->adapter_data = rap_adapter_data_ref(adapter);
-		if (!data->adapter_data) {
-			error("Failed to get adapter HCI channel");
-			return -EINVAL;
-		}
-		DBG("Using shared HCI channel for adapter (ref_count=%d)",
-			data->adapter_data->ref_count);
-	}
-
-	/* per-device HCI state machine */
-	if (!data->hci_sm) {
-		data->hci_sm = bt_rap_attach_hci(data->rap,
-					data->adapter_data->hci,
-					btd_opts.defaults.bcs.role,
-					btd_opts.defaults.bcs.cs_sync_ant_sel,
-					btd_opts.defaults.bcs.max_tx_power);
-		if (!data->hci_sm) {
-			error("Failed to attach HCI state machine for device");
-			rap_adapter_data_unref(data->adapter_data);
-			data->adapter_data = NULL;
-			return -EINVAL;
-		}
-		DBG("HCI state machine attached successfully for device");
-	}
-
 	if (!bt_rap_attach(data->rap, client)) {
 		error("RAP unable to attach");
 		return -EINVAL;
@@ -411,8 +734,7 @@ static int rap_accept(struct btd_service *service)
 		if (bt_hci_get_conn_handle(data->adapter_data->hci,
 					(const uint8_t *) bdaddr, &handle)) {
 			DBG("Found conn handle 0x%04X for %s", handle, addr);
-			DBG("Setting up handle mapping: handle=0x%04X",
-				handle);
+			data->conn_handle = handle;
 			bt_rap_set_conn_hndl(data->hci_sm,
 					data->rap, handle,
 					(const uint8_t *) bdaddr,
@@ -426,12 +748,33 @@ static int rap_accept(struct btd_service *service)
 
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
index 13f1365f3..daae66359 100644
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
@@ -173,6 +260,12 @@ static void cs_state_machine_init(struct cs_state_machine *sm,
 				uint8_t role, uint8_t cs_sync_ant_sel,
 				int8_t max_tx_power)
 {
+	static const uint8_t ch_map[10] = {
+		0xFC, 0xFF, 0x7F, 0xFC, 0xFF,
+		0xFF, 0xFF, 0xFF, 0xFF, 0x1F
+	};
+	uint8_t i;
+
 	if (!sm)
 		return;
 
@@ -185,15 +278,50 @@ static void cs_state_machine_init(struct cs_state_machine *sm,
 
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
+	sm->cs_config.num_configs = BT_RAP_CS_MAX_CONFIGS;
+	for (i = 0; i < BT_RAP_CS_MAX_CONFIGS; i++) {
+		sm->cs_config.config_id[i]              = i;
+		sm->cs_config.main_mode_type[i]         = 0x01;
+		sm->cs_config.sub_mode_type[i]          = 0xFF;
+		sm->cs_config.main_mode_min_steps[i]    = 0x02;
+		sm->cs_config.main_mode_max_steps[i]    = 0x03;
+		sm->cs_config.main_mode_repetition[i]   = 0x01;
+		sm->cs_config.mode0_steps[i]            = 0x02;
+		sm->cs_config.role[i]                   = 0x00;
+		sm->cs_config.rtt_types[i]              = 0x00;
+		sm->cs_config.cs_sync_phy[i]            = 0x01;
+		memcpy(sm->cs_config.channel_map[i], ch_map, 10);
+		sm->cs_config.channel_map_repetition[i] = 0x01;
+		sm->cs_config.channel_selection_type[i] = 0x00;
+		sm->cs_config.channel_shape[i]          = 0x00;
+		sm->cs_config.channel_jump[i]           = 0x02;
+		sm->cs_config.companion_signal_enable[i] = 0x00;
+	}
+
+	sm->cs_frequency.num_durations = BT_RAP_CS_MAX_FREQ_SETS;
+	for (i = 0; i < BT_RAP_CS_MAX_FREQ_SETS; i++) {
+		sm->cs_frequency.max_procedure_duration[i]        = 0x0640;
+		sm->cs_frequency.min_period_between_procedures[i] = 0x001E;
+		sm->cs_frequency.max_period_between_procedures[i] = 0x0096;
+		sm->cs_frequency.max_procedure_count[i]           = 0x0000;
+		sm->cs_frequency.min_sub_event_len[i][0]          = 0x00;
+		sm->cs_frequency.min_sub_event_len[i][1]          = 0x20;
+		sm->cs_frequency.min_sub_event_len[i][2]          = 0x00;
+		sm->cs_frequency.max_sub_event_len[i][0]          = 0x03;
+		sm->cs_frequency.max_sub_event_len[i][1]          = 0x20;
+		sm->cs_frequency.max_sub_event_len[i][2]          = 0x00;
+		sm->cs_frequency.tone_antenna_config_selection[i] = 0x07;
+		sm->cs_frequency.phy[i]                           = 0x01;
+		sm->cs_frequency.tx_power_delta[i]                = 0x80;
+		sm->cs_frequency.preferred_peer_antenna[i]        = 0x03;
+		sm->cs_frequency.snr_control_initiator[i]         = 0xFF;
+		sm->cs_frequency.snr_control_reflector[i]         = 0xFF;
+	}
 }
 
 /* State Transition Logic */
@@ -228,10 +356,17 @@ static enum cs_state cs_get_current_state(struct cs_state_machine *sm)
 
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
 
-/* Helper function to send read remote capabilities for all connections */
 static bool bt_rap_read_remote_supported_capabilities(void *hci_sm,
 		uint16_t handle)
 {
@@ -262,20 +397,6 @@ static bool bt_rap_read_remote_supported_capabilities(void *hci_sm,
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
@@ -324,12 +445,9 @@ static void rap_rd_loc_supp_cap_done_cb(const void *data, uint8_t size,
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
@@ -338,11 +456,6 @@ static void rap_send_hci_cs_create_config_command(struct cs_state_machine *sm,
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
@@ -353,22 +466,22 @@ static void rap_send_hci_cs_create_config_command(struct cs_state_machine *sm,
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.handle = cpu_to_le16(handle);
 	cmd.create_context = 1;
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
+
+	cmd.config_id              = sm->cs_config.config_id[0];
+	cmd.main_mode_type         = sm->cs_config.main_mode_type[0];
+	cmd.sub_mode_type          = sm->cs_config.sub_mode_type[0];
+	cmd.min_main_mode_steps    = sm->cs_config.main_mode_min_steps[0];
+	cmd.max_main_mode_steps    = sm->cs_config.main_mode_max_steps[0];
+	cmd.main_mode_repetition   = sm->cs_config.main_mode_repetition[0];
+	cmd.mode_0_steps           = sm->cs_config.mode0_steps[0];
+	cmd.role                   = sm->cs_config.role[0];
+	cmd.rtt_type               = sm->cs_config.rtt_types[0];
+	cmd.cs_sync_phy            = sm->cs_config.cs_sync_phy[0];
+	memcpy(cmd.channel_map, sm->cs_config.channel_map[0], 10);
+	cmd.channel_map_repetition = sm->cs_config.channel_map_repetition[0];
+	cmd.channel_selection_type = sm->cs_config.channel_selection_type[0];
+	cmd.ch3c_shape             = sm->cs_config.channel_shape[0];
+	cmd.ch3c_jump              = sm->cs_config.channel_jump[0];
 	cmd.reserved               = 0x00;
 
 	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_CREATE_CONFIG,
@@ -388,6 +501,7 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 {
 	const struct bt_hci_rsp_le_cs_set_def_settings *rp;
 	struct cs_state_machine *sm = user_data;
+	struct rap_conn_mapping *m;
 
 	if (!sm || !data || size < sizeof(*rp))
 		return;
@@ -403,14 +517,24 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
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
@@ -434,7 +558,7 @@ static void rap_send_hci_cs_remove_config_command(struct cs_state_machine *sm,
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.handle = cpu_to_le16(handle);
-	cmd.config_id = 0x00;  /* Default config ID */
+	cmd.config_id = sm->cs_config.config_id[0];
 
 	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_REMOVE_CONFIG,
 				&cmd, sizeof(cmd), NULL, sm, NULL);
@@ -481,13 +605,6 @@ static bool rap_send_hci_cs_set_procedure_parameters(
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
@@ -498,20 +615,25 @@ static bool rap_send_hci_cs_set_procedure_parameters(
 
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
+	cmd.config_id = sm->cs_config.config_id[0];
+	cmd.max_procedure_len =
+		cpu_to_le16(sm->cs_frequency.max_procedure_duration[0]);
+	cmd.min_procedure_interval =
+		cpu_to_le16(sm->cs_frequency.min_period_between_procedures[0]);
+	cmd.max_procedure_interval =
+		cpu_to_le16(sm->cs_frequency.max_period_between_procedures[0]);
+	cmd.max_procedure_count =
+		cpu_to_le16(sm->cs_frequency.max_procedure_count[0]);
+	memcpy(cmd.min_subevent_len, sm->cs_frequency.min_sub_event_len[0], 3);
+	memcpy(cmd.max_subevent_len, sm->cs_frequency.max_sub_event_len[0], 3);
+	cmd.tone_antenna_config_selection =
+		sm->cs_frequency.tone_antenna_config_selection[0];
+	cmd.phy                    = sm->cs_frequency.phy[0];
+	cmd.tx_power_delta         = sm->cs_frequency.tx_power_delta[0];
+	cmd.preferred_peer_antenna = sm->cs_frequency.preferred_peer_antenna[0];
+	cmd.snr_control_initiator  = sm->cs_frequency.snr_control_initiator[0];
+	cmd.snr_control_reflector  = sm->cs_frequency.snr_control_reflector[0];
 
 	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_SET_PROC_PARAMS,
 				&cmd, sizeof(cmd), NULL, sm, NULL);
@@ -541,7 +663,7 @@ static bool rap_send_hci_cs_procedure_enable(struct cs_state_machine *sm,
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.handle = cpu_to_le16(handle);
-	cmd.config_id = 0x00; /* Default config Id */
+	cmd.config_id = sm->cs_config.config_id[0];
 	cmd.enable = enable_proc ? 0x01 : 0x00;
 
 	status = bt_hci_send(sm->hci, BT_HCI_CMD_LE_CS_PROC_ENABLE,
@@ -591,6 +713,8 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 {
 	struct cs_state_machine *sm = (struct cs_state_machine *) user_data;
 	const struct bt_hci_evt_le_cs_rd_rem_fae_complete *evt;
+	struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete tmp_ev;
+	struct rap_conn_mapping *m;
 	struct iovec iov;
 	int i;
 
@@ -598,11 +722,9 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 		size < sizeof(struct bt_hci_evt_le_cs_rd_rem_fae_complete))
 		return;
 
-	/* Initialize iovec with the event data */
 	iov.iov_base = (void *) data;
 	iov.iov_len = size;
 
-	/* Pull the entire structure at once */
 	evt = util_iov_pull_mem(&iov, sizeof(*evt));
 
 	if (!evt) {
@@ -612,21 +734,20 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
 
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
@@ -651,13 +772,13 @@ static void rap_rd_rem_fae_cmplt_evt(const void *data, uint8_t size,
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
@@ -698,17 +819,16 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 {
 	struct cs_state_machine *sm = user_data;
 	const struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete *evt;
+	struct rap_conn_mapping *m;
 	struct iovec iov;
 	uint16_t subfeatures_supported;
 
 	if (!sm || !data || size < sizeof(*evt))
 		return;
 
-	/* Initialize iovec with the event data */
 	iov.iov_base = (void *) data;
 	iov.iov_len = size;
 
-	/* Pull the entire structure at once */
 	evt = util_iov_pull_mem(&iov, sizeof(*evt));
 
 	if (!evt) {
@@ -718,7 +838,6 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 
 	DBG("status=0x%02X, handle=0x%04X", evt->status, evt->handle);
 
-	/* Check status */
 	if (evt->status != 0) {
 		error("Remote capabilities failed with status 0x%02X",
 			evt->status);
@@ -738,16 +857,17 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 	subfeatures_supported = le16_to_cpu(evt->subfeatures_supported);
 	DBG("subfeatures_supported=0x%04X", subfeatures_supported);
 
-	/* Check Bit 1 of subfeatures_supported (0x0002) */
 	if (!(subfeatures_supported & 0x0002)) {
 		DBG("Bit 1 not set, sending Read Remote FAE Table");
 		bt_rap_read_remote_fae_table(sm, evt->handle);
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
@@ -763,25 +883,23 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 	struct cs_state_machine *sm = user_data;
 	const struct bt_hci_evt_le_cs_config_complete *evt;
 	struct rap_ev_cs_config_cmplt rap_ev;
+	struct rap_conn_mapping *mapping;
 	struct iovec iov;
 
 	if (!sm || !data || size < sizeof(*evt))
 		return;
 
-	/* Initialize iovec with the event data */
 	iov.iov_base = (void *) data;
 	iov.iov_len = size;
 
 	DBG("size=0x%02X", size);
 
-	/* State Check */
 	if (cs_get_current_state(sm) != CS_STATE_WAIT_CONFIG_CMPLT) {
 		DBG("Event received in Wrong State!! ");
 		DBG("Expected : CS_STATE_WAIT_CONFIG_CMPLT");
 		return;
 	}
 
-	/* Pull the entire structure at once */
 	evt = util_iov_pull_mem(&iov, sizeof(*evt));
 	if (!evt) {
 		error("Failed to pull config complete struct");
@@ -855,9 +973,6 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 
 	/* CS Security Enable may only be issued by the BLE Central */
 	if (rap_ev.role == 0x00) {
-		/* Initiator role */
-		struct rap_conn_mapping *mapping;
-
 		mapping = find_mapping_by_handle(sm, evt->handle);
 		if (!mapping || !mapping->is_central) {
 			error("CS Security Enable skipped: not BLE Central");
@@ -980,8 +1095,8 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
 
 	DBG("size=0x%02X", size);
 
-	/* State Check */
-	if (cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT) {
+	if ((cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT) &&
+		(cs_get_current_state(sm) != CS_STATE_STARTED)) {
 		DBG("Event received in Wrong State!! ");
 		DBG("Expected : CS_STATE_WAIT_PROC_CMPLT");
 		return;
@@ -1002,6 +1117,8 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
 			evt->status);
 		cs_set_state(sm, CS_STATE_STOPPED);
 		sm->procedure_active = false;
+		if (sm->proc_active_func)
+			sm->proc_active_func(false, sm->proc_active_data);
 		return;
 	}
 
@@ -1030,9 +1147,13 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
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
@@ -1621,11 +1742,9 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 
 	queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
 
-	DBG("CS options: role=%u, cs_sync_ant_sel=%u, max_tx_power=%d",
-		role, cs_sync_ant_sel, max_tx_power);
-
-	/* place holder, need DBus API to be called */
-	bt_rap_read_local_supported_capabilities(sm);
+	DBG("HCI state machine attached (role=%u, ant=0x%02x, power=%d)",
+		sm->role_enable, sm->cs_opt.cs_sync_ant_sel,
+		sm->cs_opt.max_tx_power);
 
 	return sm;
 
@@ -1638,6 +1757,73 @@ fail:
 	return NULL;
 }
 
+static bool measurement_timeout_cb(void *user_data)
+{
+	struct cs_state_machine *sm = user_data;
+
+	sm->measurement_timeout_id = 0;
+
+	DBG("Measurement duration expired, stopping CS procedure");
+	bt_rap_stop_measurement(sm);
+
+	if (sm->timeout_func)
+		sm->timeout_func(sm->timeout_data);
+
+	return false;
+}
+
+bool bt_rap_start_measurement(void *hci_sm, uint16_t conn_handle,
+			      uint32_t duration_secs)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm || !sm->hci)
+		return false;
+
+	if (!find_mapping_by_handle(sm, conn_handle)) {
+		error("start_measurement: hndl 0x%04X not found", conn_handle);
+		return false;
+	}
+
+	sm->active_conn_handle = conn_handle;
+
+	if (sm->measurement_timeout_id) {
+		timeout_remove(sm->measurement_timeout_id);
+		sm->measurement_timeout_id = 0;
+	}
+
+	if (!bt_rap_read_local_supported_capabilities(sm))
+		return false;
+
+	if (duration_secs > 0)
+		sm->measurement_timeout_id = timeout_add_seconds(duration_secs,
+					measurement_timeout_cb, sm, NULL);
+
+	return true;
+}
+
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
+
+	if (!find_mapping_by_handle(sm, sm->active_conn_handle)) {
+		error("stop_measurement: handle 0x%04X not found",
+		      sm->active_conn_handle);
+		return false;
+	}
+
+	return rap_send_hci_cs_procedure_enable(sm, sm->active_conn_handle,
+						false);
+}
+
 bool bt_rap_set_conn_hndl(void *hci_sm, struct bt_rap *rap,
 		uint16_t handle, const uint8_t *bdaddr, uint8_t bdaddr_type,
 		bool is_central)
@@ -1672,6 +1858,40 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 
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
@@ -1690,12 +1910,14 @@ void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm)
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


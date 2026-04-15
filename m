Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80E379998
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252341; cv=none; b=HhvAZRc1ppk72u+DT9aQE4iIUoaFWavlVglnIpPSfk2abiwIlNPG0Yq43V/dYMC7rBs4iqNDu5MqqYmrrIKknDvr3LRYfNVcIehbSNcDv1JE3jL8P3P87umjZYc3dqleWETGniO5hVFm30VhSvSgsnZpyz2P+ZyZMaPPsei1gBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252341; c=relaxed/simple;
	bh=U4MxHtbAeqF9Q4+34BzCuoKWR23VkonlqjYGKhprHng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RafgkV0TBC9Mj1i4KpqbcXJjJFo07y9Q1+f0we5ijAH4EILwqyjYRAizzvFnTuZJzkFY/3fmz31jjKJBOGWJJ8ID/ETZCjVOtjifIq3xVQ94BE+kS9wjKfcfZDm7R4czWn80HZODqK4gvf6nH2Ibe1fQgqiPCiecHZh7Vm/NAXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jKO1fGrg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZQbRvC1b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jKO1fGrg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZQbRvC1b"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F9ghUP1778923
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kbLfTAfE3+X
	/+gZscjE7eSI5mFC+Nk3lv7lRIwJZv70=; b=jKO1fGrgHYybOA00o2ggawXMGeN
	uO0IKb3GfVIx70jG8iB4dspk5CvLUSRwa7afHx26YXFnlFCCX9GKxMGY7HKJYkY8
	5oa4b1SEt4RnV1kv7kk19XALnTIzSU2jH3AbkEM7ODJsxJYRfOmXaFvtm0ULOATd
	blbewcHETFx5Fs46BgHNpcCyv80VmQe7gtvL2Oa8G5abrtd+//0gDh29A0yRJuv5
	5pA0a5sOuh+f2ozzf6V6PQTSyun0S+w+UKq7rFvFZl42uvcwVe0ftUKiDg6wresW
	xh71Je+u1fYyW8U8SC0gdYHaZUHvdaP277dL2Z3uZT2zMI83wG2PDL+E7vQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrw03bed-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:25:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82d40278103so4384193b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 04:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776252338; x=1776857138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbLfTAfE3+X/+gZscjE7eSI5mFC+Nk3lv7lRIwJZv70=;
        b=ZQbRvC1bWE7mXcsSI7zvwX/TMQ8b+RK/SEVbvS5MgpEbudHXJrTOKuWwTlxPFLRfzI
         Ifh8JBL+3h6OmCkrXzn/1eTf3+komXme+XphZ8bozzZDwOoJY3nYoH9ZqY/TD9Kj6Dm3
         KeM+Jw3LZPr/vDiTc0lV3Y4haSGiJjmjPDB6sEfNBhvovMkdTZy+vP5eT7dijBHVLhqx
         gxY6jnsm+Z/I54ALJPjJKaUM/eqwMn7wlQTVBElev6qTImx4xtS/p41A3W9TEb7OAPOY
         KtyONZrPrePc7yNQzhOO+SnfVwmV5vNCzQHPA/WPg0MeTmMsdZXCnjnjetJEIWELJHEC
         yuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252338; x=1776857138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kbLfTAfE3+X/+gZscjE7eSI5mFC+Nk3lv7lRIwJZv70=;
        b=R8rUSHfPWRXsofvcqw4hZx9FapmflEmsAKxhj9fcTdtSWVfV7PQ78mwKF1kX6Inn/G
         +9X5TLJ1JTDTVCJJVNWpp1NBuHRHif5sRNiX/YWxiwY9YdkTw2Y4bfFeQ5FQFNQSgCYM
         R/zf5bomHeJP2z9lUX9IuPOWdSSOCblcvcMZBFiXNq7FdFdZMjdGSf9mlyAxAN/svMGS
         zuSMUCHL3+4QgQCmlqjlLig1Iakaf3I8yEI318YvjSQVW1pP9XUDwVJJHUkrRlnrk9lm
         oRtcVsrQmXDbgWLkNXO35qyrg/c4HH4E7GjXhDRFlOjXRqlbshRHEnTvAg21Z30VIn2C
         zhiA==
X-Gm-Message-State: AOJu0YwWsp6ozKMRBAnpU6/XxZYCKnIXjJPb30E2mD8jOPnSBJriEm2b
	yn58NgdjgXl1nPae/fW6Wq09VGh8DaiUWoZJdXYY/+SuQcDXfFvFL62HGkg/ZeEGhiudD4j6wk/
	H01sApfi8VljdMF48N7EUjJFySiO5U8M82UFoGM6BONI+AQUKhH1orIJS9piuYAFFMrkJZsLBw3
	WEw/U=
X-Gm-Gg: AeBDieu6sJT2k4QtnTEbcsmAJ08KcOMXEBPPRx60oIGseM9AhbTkBWAeBODrYjpGN3u
	OINgIczj8QraQi+XLO/WLZxz6nN/fyxK3TSbepwXCxxifwzODOXncrVlyKakd0Y+ZQHOToyqAxS
	viq78P21DCiyR3xh4osxY/CiV6CZHr8bBnvN6vZV5CCyrHY7ZJcSp0Slx9BSeU/vmsTmKFONR1V
	gtiErV5OVxeui1afLSe8oGt8Iffu8+NJifVxtXcbefVHhQxFt5n4xYlKec5MNOmEtCCAfwe+EM/
	B3Yz2JRtXfjb3Ek/z9Swywi/NlAuXcIYwxw5VWOTe8eUY9X3TaQRApoAirLtM6EzXC3XwQdUwqE
	2tdZF1Ce31+Xp0WedW5op2HM5+Q1n8RgNRTSoQ5ZSwNecPq2JP0g=
X-Received: by 2002:a05:6a00:39a8:b0:82c:ed02:a242 with SMTP id d2e1a72fcca58-82f0c404ec2mr19401922b3a.52.1776252338104;
        Wed, 15 Apr 2026 04:25:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:39a8:b0:82c:ed02:a242 with SMTP id d2e1a72fcca58-82f0c404ec2mr19401887b3a.52.1776252337512;
        Wed, 15 Apr 2026 04:25:37 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f69ef0b79sm1492172b3a.36.2026.04.15.04.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:25:37 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v7 2/3] main.conf: Add Channel Sounding config parsing  support
Date: Wed, 15 Apr 2026 16:55:09 +0530
Message-Id: <20260415112510.195491-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415112510.195491-1-naga.akella@oss.qualcomm.com>
References: <20260415112510.195491-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5ZIR6te_W_gRAWrzJx6GYMvNZDbNRfOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwNSBTYWx0ZWRfX7lEx+3xw9zzf
 B28nX2mtKI7a+9Y6cWYLHJ4lGft+p7Ydfasrh4auVbAaW2JrkIiq+V0OWNMwIiTeXIcBwuhIHMG
 J7Qnd9EpZL+2XzRBTGGxB4iscI9QfT4bA7/YcGQ6mWRLjH/dd6T1BD8YULIuo9uskULlYQ2fyc1
 t2dgK7KRCIdtoG+WWvFyi6XimBST7QIUbzkFFvv4JKKms7kGsBy9XB2TLd69Y1Ppsbj1yBC8sFG
 exwhLAJ3eUm3pC2sI6sc7HgkEYxMOzCAL/cT5oh4VyMFCbyubghv0wNsVjn3OkCrciS503+S9it
 i9l4btwrPSupcfkf/RwG1rSGeSj/ydvhRltuLrGQmKbUytokN/IVIZn/feHa9hu7dMLSgoS/Nj7
 szmVG913hootYQ6n8xJVV56+Z4PPPAxYnewhPd0LBGBq3MJ9MuX1uilBiqjM0MfTM3FvIgdfcJ9
 Cuwt+Lu0XW1nYsgOBZQ==
X-Proofpoint-ORIG-GUID: 5ZIR6te_W_gRAWrzJx6GYMvNZDbNRfOR
X-Authority-Analysis: v=2.4 cv=YMGvDxGx c=1 sm=1 tr=0 ts=69df75b3 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=IZGhllgqU5eGhMH6-2IA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150105

Add support for parsing Channel Sounding (CS) configuration options
from the configuration file.

Add CAP_NET_RAW to CapabilityBoundingSet in bluetooth.service.
bluetoothd requires CAP_NET_RAW to receive and process HCI LE events
when running under a constrained systemd capability bounding set
---
 src/bluetooth.service.in |   2 +-
 src/btd.h                |   7 +++
 src/main.c               | 132 ++++++++++++++++++++++++++++++++++++++-
 src/main.conf            |  24 +++++++
 4 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 8ebe89bec..8dcbde236 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -10,7 +10,7 @@ ExecStart=@PKGLIBEXECDIR@/bluetoothd
 NotifyAccess=main
 #WatchdogSec=10
 #Restart=on-failure
-CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
+CapabilityBoundingSet=CAP_NET_RAW CAP_NET_ADMIN CAP_NET_BIND_SERVICE
 LimitNPROC=1
 
 # Filesystem lockdown
diff --git a/src/btd.h b/src/btd.h
index c84a600d1..db2e81239 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -94,11 +94,18 @@ struct btd_le_defaults {
 	uint8_t		enable_advmon_interleave_scan;
 };
 
+struct btd_le_bcs {
+	uint8_t role;
+	uint8_t cs_sync_ant_sel;
+	int8_t max_tx_power;
+};
+
 struct btd_defaults {
 	uint16_t	num_entries;
 
 	struct btd_br_defaults br;
 	struct btd_le_defaults le;
+	struct btd_le_bcs bcs;
 };
 
 struct btd_csis {
diff --git a/src/main.c b/src/main.c
index 818f7c06e..32fc2c97d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -156,6 +156,13 @@ static const char *gatt_options[] = {
 	NULL
 };
 
+static const char *const bcs_options[] = {
+	"Role",
+	"CsSyncAntennaSel",
+	"MaxTxPower",
+	NULL
+};
+
 static const char *csip_options[] = {
 	"SIRK",
 	"Encryption",
@@ -183,7 +190,7 @@ static const char *advmon_options[] = {
 
 static const struct group_table {
 	const char *name;
-	const char **options;
+	const char * const *options;
 } valid_groups[] = {
 	{ "General",	supported_options },
 	{ "BR",		br_options },
@@ -193,6 +200,7 @@ static const struct group_table {
 	{ "CSIS",	csip_options },
 	{ "AVDTP",	avdtp_options },
 	{ "AVRCP",	avrcp_options },
+	{ "ChannelSounding",	bcs_options },
 	{ "AdvMon",	advmon_options },
 	{ }
 };
@@ -356,7 +364,7 @@ static enum jw_repairing_t parse_jw_repairing(const char *jw_repairing)
 
 
 static void check_options(GKeyFile *config, const char *group,
-						const char **options)
+						const char * const *options)
 {
 	char **keys;
 	int i;
@@ -492,6 +500,46 @@ static bool parse_config_int(GKeyFile *config, const char *group,
 	return true;
 }
 
+static bool parse_config_signed_int(GKeyFile *config, const char *group,
+					const char *key, int8_t *val,
+					size_t min, size_t max)
+{
+	char *str = NULL;
+	char *endptr = NULL;
+	long tmp;
+	bool result = false;
+
+	str = g_key_file_get_string(config, group, key, NULL);
+	if (!str)
+		return false;
+
+	tmp = strtol(str, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		warn("%s.%s = %s is not integer", group, key, str);
+		goto cleanup;
+	}
+
+	if (tmp < (long)min) {
+		warn("%s.%s = %ld is out of range (< %zu)", group, key, tmp,
+			min);
+		goto cleanup;
+	}
+
+	if (tmp > (long)max) {
+		warn("%s.%s = %ld is out of range (> %zu)", group, key, tmp,
+									max);
+		goto cleanup;
+	}
+
+	if (val)
+		*val = (int8_t)tmp;
+	result = true;
+
+cleanup:
+	g_free(str);
+	return result;
+}
+
 struct config_param {
 	const char * const val_name;
 	void * const val;
@@ -1184,6 +1232,81 @@ static void parse_csis(GKeyFile *config)
 					0, UINT8_MAX);
 }
 
+static bool parse_cs_role(GKeyFile *config, const char *group,
+					const char *key, uint8_t *val)
+{
+	GError *err = NULL;
+	char *str = NULL;
+	char *endptr = NULL;
+	int numeric_val;
+
+	/* Try to read as string first */
+	str = g_key_file_get_string(config, group, key, &err);
+	if (err) {
+		if (err->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
+			DBG("%s", err->message);
+		g_error_free(err);
+		return false;
+	}
+
+	DBG("%s.%s = %s", group, key, str);
+
+	/* Check if it's a string value */
+	if (!strcmp(str, "Initiator") || !strcmp(str, "initiator")) {
+		if (val)
+			*val = 1;
+		g_free(str);
+		return true;
+	} else if (!strcmp(str, "Reflector") || !strcmp(str, "reflector")) {
+		if (val)
+			*val = 2;
+		g_free(str);
+		return true;
+	} else if (!strcmp(str, "Both") || !strcmp(str, "both")) {
+		if (val)
+			*val = 3;
+		g_free(str);
+		return true;
+	}
+
+	/* Try to parse as numeric value */
+	numeric_val = strtol(str, &endptr, 0);
+
+	if (!endptr || *endptr != '\0') {
+		error("%s.%s = %s is not a valid value. "
+			"Expected: 1/Initiator, 2/Reflector, or 3/Both",
+			group, key, str);
+		g_free(str);
+		return false;
+	}
+
+	if (numeric_val < 1 || numeric_val > 3) {
+		warn("%s.%s = %d is out of range. "
+			"Valid values: 1 (Initiator), 2 (Reflector), 3 (Both)",
+			group, key, numeric_val);
+		g_free(str);
+		return false;
+	}
+
+	if (val)
+		*val = numeric_val;
+
+	g_free(str);
+	return true;
+}
+
+static void parse_le_cs_config(GKeyFile *config)
+{
+	parse_cs_role(config, "ChannelSounding", "Role",
+			&btd_opts.defaults.bcs.role);
+	parse_config_u8(config, "ChannelSounding", "CsSyncAntennaSel",
+			&btd_opts.defaults.bcs.cs_sync_ant_sel,
+			0x01, 0xFF);
+	parse_config_signed_int(config, "ChannelSounding",
+			"MaxTxPower", &btd_opts.defaults.bcs.max_tx_power,
+			INT8_MIN, INT8_MAX);
+}
+
 static void parse_avdtp_session_mode(GKeyFile *config)
 {
 	char *str = NULL;
@@ -1262,6 +1385,7 @@ static void parse_config(GKeyFile *config)
 	parse_csis(config);
 	parse_avdtp(config);
 	parse_avrcp(config);
+	parse_le_cs_config(config);
 	parse_advmon(config);
 }
 
@@ -1313,6 +1437,10 @@ static void init_defaults(void)
 
 	btd_opts.advmon.rssi_sampling_period = 0xFF;
 	btd_opts.csis.encrypt = true;
+
+	btd_opts.defaults.bcs.role = 0x03;
+	btd_opts.defaults.bcs.cs_sync_ant_sel = 0xFF;
+	btd_opts.defaults.bcs.max_tx_power = 0x14;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index d31dd1b8f..fc0138bbf 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -299,6 +299,30 @@
 # Default = auto
 # Security = auto
 
+[ChannelSounding]
+# Current role of the device
+# Possible values:
+#   1 or "Initiator" - CS Initiator role,
+#   Generally, CS Initiator acts as Client (Gatt role) and Central (Gap role)
+#   2 or "Reflector" - CS Reflector role,
+#   Generally, CS Reflector acts as Server (Gatt role) and Peripheral (Gap role)
+#   3 or "Both"      - Both Initiator and Reflector roles
+# Default: 3 (Both)
+#Role = 3
+
+# Antenna Identifier to be used
+# Possible values:
+# 0x01-0x04 (antenna identifier to be used),
+# 0xFE - Antennas to be used in repetetive order,
+# 0xFF - Host doen't have recommendation
+# Default: 0xFF (Host doesn't have recommendation)
+#CsSyncAntennaSel = 0xFF
+
+# Maximum Transmit power
+# Possible values: 0x7F-0x14 (-127dBm to 20dBm)
+# Default: 0x14 (Max Power possible)
+#MaxTxPower = 0x14
+
 [CSIS]
 # SIRK - Set Identification Resolution Key which is common for all the
 # sets. They SIRK key is used to identify its sets. This can be any
-- 


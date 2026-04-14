Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24473DA5DA
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179314; cv=none; b=XxkzbvbFVz7l6AFsz8BHp+DbzAcJA3C2lByiyChC0FD+OjTjDwv5Uear/zmk0SXVEIymTbR08tEcaqF8wtndUizZGwZrCvEqtavOyRdGMmghppefZwuYlCk+yJ6vyOuLB3fg9kxC4kt1kAlOLA6Rj8+uobQBt+oXXCLVL6aXVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179314; c=relaxed/simple;
	bh=Lrud2Z0tGGhl+VnCuJ1LlC8xsqXINEr+qSBF9ZE+7pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XSG2/EwQJvW/64I3RebKxb2TR7q5OL3GIlEFtv8daS2wtGgC5780RzXjm49I/qDK6JOddIT3D90DT9AKGXvUB8U2ipX8FYfL9KPiJnoqoRqUJy+02gQZyq6P2JqZ/Q9JinwNnLkwHpnzZk52YA1cpMKJ6BNk3jKOe6Wyh4Suqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o0NA/EmT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YQA3u7xE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o0NA/EmT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YQA3u7xE"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EBlGgs2633494
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dvvuScVK2b2
	/eF2Gcyoy/wJNo8yVtoSIJIFXCZVtXyA=; b=o0NA/EmTiJ44w4jv7DfRQ2Z+jbK
	50hkIk0F9yM4G0UWCxMV84ILHqw/RkmCBpJQ2bPypyWCFDEn2EtZ7BNz9ACHpbi9
	P0V8telm5Didq1ljzU3WurXfWxHmGONaOK37mtRoLfSnr+8Q12vejkP1G7ijkh4T
	qkUqHKfgvT9ehXAFF3A6h914EKyECiLzEOV/zMjV/uaYVm0sVKiDEpi3QdwMJA9b
	HR8hZCTH6ZjO4Pm1sFcLW0MMfs+ips3eG0RWR9L2HMqXJGin0B6TV8m/O7POTDrV
	EvTIXbzQ62A9ahbeAVMIzxqj1mKcy/BuPtWkCQhg0QiNryLtNizUQgSP6/w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86cb943-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:08:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2497cc190so28499085ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776179311; x=1776784111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvvuScVK2b2/eF2Gcyoy/wJNo8yVtoSIJIFXCZVtXyA=;
        b=YQA3u7xEZrvyTH/N6H2VH03kKXHNHBBqQIUSs8qJaqszuuUTtjT/xTCUtGMHCRlHgc
         jBEahJqAkL7sLLhObDfBFFFVidPV/RhG5R3bmZOJ0yzKbGBhEpCYrHnNMNFt+w4/SAQC
         5GkLFt8+SL+4v6twQgmCrU0OJEsSGd/qHcblB248FoXAkDEc1tmVNrttNt9KgivbdNtv
         kxDKisBqBhWFuCcGgNgeLFJZ20QsPMkAznWCBdhbuuTPwyOK60jZ9UuYYpUZ2t3TW54v
         G8KHY+zlZWJgF7+xU3FmUV/TZHXcQg2/6Q+KWDOc9pgRrg0v1qHMpr21hQfjTliShngz
         1ZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179311; x=1776784111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dvvuScVK2b2/eF2Gcyoy/wJNo8yVtoSIJIFXCZVtXyA=;
        b=K1gmhkRKBXcNGd+OSxAhdPWlDy4nJeto0U2Mi47j0MF8dNHZPQBP7JklWkfMf0D4PL
         8TbjEFemSQY47sKN2S0MkQEc6X0xLTUfg/TDbsPrm6P/mwS3sMl1RfEWjdplAI54vGkF
         ZvK9jpU4vobDHWCpTaXiOn8CmcqiW8bZ5XcQvxky0lqGw8ms7WY2RD80NJtKhbKlk1RH
         /g2D4+IQvbAC56H8yBw5VtvkiOPLvT7O2cJ36qTZTb+FdYud5h5aNNbBHhuJqb0MsTKp
         mMwX1AxUnL1lUuYsy46NqoBuRi8LYQfSRdNcAmiKiukPMqo9V0jT5jexpeJs0p/iplBV
         kBYw==
X-Gm-Message-State: AOJu0Yyg/8575tOGkC5JyOS3tGwncZEE1JEX+OFDplSDSEPXPLtScJTh
	z9NELEo0tnLLSw7rKuWOpzF5A5Iw7hqGYnBZwx5pFvJtZdYlJGYy2cMu6BWrrH5k+d7aelgTS9i
	IN6tF0giximLO1IwJcVTOKHDHQ7yXI6iJUG1c/cmBFkPlH6yNW/MS8hnN/HyUp0Y9c1KhZHB5Mo
	tmPJw=
X-Gm-Gg: AeBDietTEUlsfVqpzPG82AV3126uMYEDDfJ2zT/1B8kAjkxNYE+ynN92vEg4eZ9utJq
	rcjBeEJ8vaVEfTlYnmNTq3CqYOJV3SnSHVY9Pqc62itVZoZHfK48Eptm8nXOsv3SfI4e4R4CbwT
	OTlNh+8rlrwQwVI8xCRi0KUuxgowoNmZIUW0SkkJy6hyoJv8sIUYxIvuuV8juSE6APgHlZPTm9H
	vnI6m3bcbsSEDEMw0LabDeJnBfZN1zCbmQIByZZRSIx2qON7XI0a+A/grknUdmAKE7T2v3dNZzo
	5zwPVTAiXrdGtgH+ctclR/Ej6j/u4xlKfRr9TQcLZSGvCfcldVOce0ovqFDT7KCYHtSJ6EOwHg7
	+o6hAZAOemqkI/fiwc8MMZseW/X9EWTwW93t5MTNXtixsLUwmcOE=
X-Received: by 2002:a17:902:db0c:b0:2b4:5f36:44fa with SMTP id d9443c01a7336-2b45f3654f0mr75026955ad.15.1776179311105;
        Tue, 14 Apr 2026 08:08:31 -0700 (PDT)
X-Received: by 2002:a17:902:db0c:b0:2b4:5f36:44fa with SMTP id d9443c01a7336-2b45f3654f0mr75026425ad.15.1776179310433;
        Tue, 14 Apr 2026 08:08:30 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45d1d0554sm74476175ad.53.2026.04.14.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:08:30 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v5 2/3] main.conf: Add Channel Sounding config parsing  support
Date: Tue, 14 Apr 2026 20:38:05 +0530
Message-Id: <20260414150806.3135253-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414150806.3135253-1-naga.akella@oss.qualcomm.com>
References: <20260414150806.3135253-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ADvAhVmTRY7Od0W66z1YQ3mLejr5Ehjy
X-Authority-Analysis: v=2.4 cv=RoH16imK c=1 sm=1 tr=0 ts=69de5870 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=FW10I0WjtUwoV23t3qsA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0MiBTYWx0ZWRfXzRTXUOrv2nul
 eZAW2zbeIvdN5lrUJmMsi/LASOqQJjX5XLQ2w3YenuUaa9Q9QWqSNNTl4vJEKHQViGCQkkWQsxc
 gUdsheDjoS2sP0BPcCQODGibv5uKpeNBohrF7sB2RIXp2psjIWoqd5W9tRclUbkEdYK5PoFZRiA
 Flk8605PtOiloWx3A2o/98bHowRmxpmmZ7Mo8dUTZpUsJQ65aKCpmA3uG1X+qjU9g2DvMAjtVH3
 Di9MIE1obShCY43t2IaG0qZBy0WdLEboG0bvREAdUmab+hfQA5se+MlMtTbk7SuVMkk3LHbVJhE
 iWy+A4k++uPvfNyyQRcHhLY2Jj4HuBcKfctQkzM24HWbKV+TZHfRQuTxgLpq3SSLIV2rcdkhm65
 KbZZ/Oq+i4wNMSeGvf0z2clAW2pdYiqLDuWow7pU0oJbGJgx7qeJEpFrETBmkI1WF0Skfr5KExW
 VBBl7RcXkvklWkYRn8w==
X-Proofpoint-GUID: ADvAhVmTRY7Od0W66z1YQ3mLejr5Ehjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140142

Add support for parsing Channel Sounding (CS) configuration options
from the configuration file.

Add CAP_NET_RAW to CapabilityBoundingSet in bluetooth.service.
bluetoothd requires CAP_NET_RAW to receive and process HCI LE events
when running under a constrained systemd capability bounding set
---
 src/bluetooth.service.in |   2 +-
 src/btd.h                |   7 +++
 src/main.c               | 129 +++++++++++++++++++++++++++++++++++++++
 src/main.conf            |  24 ++++++++
 4 files changed, 161 insertions(+), 1 deletion(-)

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
index 818f7c06e..d3a2528e3 100644
--- a/src/main.c
+++ b/src/main.c
@@ -156,6 +156,13 @@ static const char *gatt_options[] = {
 	NULL
 };
 
+static const char *bcs_options[] = {
+	"Role",
+	"CsSyncAntennaSel",
+	"MaxTxPower",
+	NULL
+};
+
 static const char *csip_options[] = {
 	"SIRK",
 	"Encryption",
@@ -193,6 +200,7 @@ static const struct group_table {
 	{ "CSIS",	csip_options },
 	{ "AVDTP",	avdtp_options },
 	{ "AVRCP",	avrcp_options },
+	{ "ChannelSounding",	bcs_options },
 	{ "AdvMon",	advmon_options },
 	{ }
 };
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
@@ -1184,6 +1232,82 @@ static void parse_csis(GKeyFile *config)
 					0, UINT8_MAX);
 }
 
+static bool parse_cs_role(GKeyFile *config, const char *group,
+					const char *key, uint8_t *val)
+{
+	GError *err = NULL;
+	char *str = NULL;
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
+	char *endptr = NULL;
+
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
@@ -1262,6 +1386,7 @@ static void parse_config(GKeyFile *config)
 	parse_csis(config);
 	parse_avdtp(config);
 	parse_avrcp(config);
+	parse_le_cs_config(config);
 	parse_advmon(config);
 }
 
@@ -1313,6 +1438,10 @@ static void init_defaults(void)
 
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


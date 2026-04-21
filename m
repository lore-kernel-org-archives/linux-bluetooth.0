Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D9B1632DD
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771126; cv=none; b=LIDpwBs5UeQRJ5dCw16tQGux3H5Y3i2AWs+BX2FmGR9/CvLazsd1tCDQesAwUJJfIKX5725Uqc4S/f9z68+Oo80EsridjgrmNSEkmX5XWsPuDfINGAlJ04qPwrMUeRdt8xbNdgR8hIDvBCRA2mL523LbSfagR9pa1LFihRUy3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771126; c=relaxed/simple;
	bh=eErapPiGo3unNFhIkS5yHfwYmolwatwxMFotBdjXbqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tIoz2eSVC5a1B3YyYw6rIhewLnerI5Nj8cnPCR23esOCNZJJVjq9g7s565enAI0D5+/sRnd0ucueXDBjRW7iB5eFZDrFuYuuUhtqpK1J4HPdiX6U9+tLns0IFbs5udOI03HlI7dVgCAFMz/OxOxghZDE8XUxcFHnFCPetLnx2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D/cz68JP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cVIC1/D2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D/cz68JP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cVIC1/D2"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L6eP4x3574148
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sYOV/mf6XU1
	FzAg3X2G0pu7aCyh51IrHAs74XqzGews=; b=D/cz68JPPT2ujBMaqw3ghGd+Yyc
	3kUClnuxDtVvP4oRL76RGYOdTPRO+iKzOj7kxGGpiYiydWpYmAG0AVdVEY5SZ7Rq
	6Ck5TpbvLHKafvrnBJhDwHoJkfEJjfXlOi+6XDi0T2Nf+hJRJ2FQgOq8uij7DyMd
	cLUKRY3r8jWs6HP5hQvlQbbU9siwAmdzWCiHcUBqoASxvVyI9uTHbbJIJLOKgHQm
	mjYX6ShnfauoKq6W92Ds+YqjbyfaIdlrf3xoOuRk4I5I3IxEWRN7tMTReTkhklA3
	Yqo8xZgl5b8v5g5LoCSizlC+pDeSGjRPj6cJpRGRPGjOJeotXuw6Hsq1Fqw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp465h2dj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:32:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35daf3d3030so4486734a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 04:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776771123; x=1777375923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYOV/mf6XU1FzAg3X2G0pu7aCyh51IrHAs74XqzGews=;
        b=cVIC1/D2uVjPMw8McqpVFnO9+hfR/an050IcHfOXZSkf7+CGR4Ad2qXS4sv+wd/Ees
         7+bu0EBLJn1+Aqarn7etJyYjFydW5Y6ymaN8sgyYVOycIwb0T8geZp50N80cnCI1YJBz
         Z7kgmWLMkGtvrdeTAEwsLfUgD7wMKexCE1dTs/I7e2A/YOTtiiTRrkGWlpEZuiUJTt/R
         mwAeLXWcuZhXNKTJcDgjtpXCIoWKx6hdZAjKtwJF9rEH9p6+1ApSDyKLRYFvxAdJTI4r
         J/RWicU0hGiy4ss0xzVUrmp7W88ihCBIRs/4j5jwjz+SSN3a9Lyp8A81dwocyvp2V8Qv
         y2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776771123; x=1777375923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sYOV/mf6XU1FzAg3X2G0pu7aCyh51IrHAs74XqzGews=;
        b=d21gNqvfyxYH14TUk0QaPCIU3YeAhHcAQaBLV1U2E1OO2sLk2jtn8B7JplHTqi7ehh
         p/wptWimm9FUV+ZIis5q4vhCrnJSSidXpgq3gqM7x6PkAZJm5G4BjAgsgN13+x9M+4QC
         wtc4WrACn7F+kVb9vBYHARmBC50aHzMJTYiFKXEhc6+ayTk3jtmu7cICIHQFvO5R9Y4x
         JmMGY80MOnB4wFrb79XYtCRq7dYIJra+ck/n9puRnSYa3T+vkRjCZgQDEfsS4fd3c9w5
         sWnH6w8akZIxlysPqqR05X+4ZatY4XeVmuoI7beK1zZtcZ6S0a5+q2+qookDUquHWm2Z
         GjGQ==
X-Gm-Message-State: AOJu0YyH7l+L8xJiCXI+huo9OxPQlXVIhq/FImfUh/XuY8B2bECv0qNH
	UfA0zcr/P1aKPJLWvR+8Qinu/yzDuy5DsgMfJCDLhGNUJP8+JgpoXcaB5ReKm27avQ0+2Gocyo+
	1k/nnUP4FW1NWthj4Mbd31BgtvkySOjTNE4hxq10SntEM95z80GvF/3QTfAzAbjYkkZ8EQ2964C
	A4BhU=
X-Gm-Gg: AeBDievgxPnq1S1Ot7vFfaME7qZdRV9VZpjQPtYr+6uBQhtFtL0AACdrT76KqpLvJG+
	Nm6OTWBaZORdYohDCvgbz15SA4yJKYat+Vq76OGqaWFN0ytgGfsMdPx3iLL3YN4qt6OYTtBw684
	GnirZ7kbirGQTKlTx5k+Ayi8lDwBTIf4uCJGorqZWP3gm3GSgsn4vMXV9GS0zsCZ6jx2vo4tfGw
	4EGQTkdaUEHdCi4voqMPtXi24pO+/1QSRd/hnPXx5wVYyjJCwj53HZqY3EDYndgtj9qLhNCWtk6
	fK8ozao7idLzbSSoolh3XtVzige888Uf6IRhCh8yeWMQTm/iYjTKlXEhuXmADNB4PfRhrTYixA5
	sWzkTLH6883heUJlaiGTqWMSW7renugavLEsZ2fpUpfS3W5eyBPgUiQJggrBJBA==
X-Received: by 2002:a17:90b:270a:b0:35d:a8d9:3b4 with SMTP id 98e67ed59e1d1-361403c35b5mr17118899a91.4.1776771123347;
        Tue, 21 Apr 2026 04:32:03 -0700 (PDT)
X-Received: by 2002:a17:90b:270a:b0:35d:a8d9:3b4 with SMTP id 98e67ed59e1d1-361403c35b5mr17118868a91.4.1776771122737;
        Tue, 21 Apr 2026 04:32:02 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703059fsm10334903a12.24.2026.04.21.04.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:32:02 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v11 2/3] main.conf: Add Channel Sounding config parsing  support
Date: Tue, 21 Apr 2026 17:01:47 +0530
Message-Id: <20260421113148.3809176-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421113148.3809176-1-naga.akella@oss.qualcomm.com>
References: <20260421113148.3809176-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMyBTYWx0ZWRfXxmSaeno3HrSM
 nd3oCF3YaKIiuueCcjJgZRa+PDRPdvBnm6VlpaCLnzV2NzotsOjgwLLwENcddsOeFDGgkcUp3AR
 MNzdjtRfip6BaQlP5d4ku7h1TVuE/P8qO7CbNPpLgnOPucFCvUzbzG4w//nmUQGQgMMGN2DvnAq
 u4uXGUKOGNg0Dyjn9NVPnX2iJUDKA0wJm+eEEHuDyNoIjHkDnMU6w79BMCPkFTdSFaw4Np/a4FY
 dAmuv8IObkhtz8FV/VrxzFA85or5I13+VNOK6tbBsaHb15vNvGkdVCQ02M4QWR5xnBajHZck6Am
 f8g9JgvazGdeixhNI33Rvw4L86fUW7q/j7hPSCyanQH0qHdRWeboA73PF0OS9qAxCiUwwilo64K
 0cAjQ++9GBRgfSAXcJfXTETMT1UEK3dn3YAWacZE1c/J8b/VmZzf4jbIZEjb7/7xbOT646rK26K
 P1m2hF7rP0n0JF4sH4w==
X-Proofpoint-ORIG-GUID: Q7B4VoOFmAL3ZacGq_w0wYgt1SXmKZXF
X-Authority-Analysis: v=2.4 cv=YOSvDxGx c=1 sm=1 tr=0 ts=69e76034 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=IZGhllgqU5eGhMH6-2IA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Q7B4VoOFmAL3ZacGq_w0wYgt1SXmKZXF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210113

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
index 818f7c06e..9a3d2da25 100644
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
+					long min, long max)
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
+	if (tmp < min) {
+		warn("%s.%s = %ld is out of range (< %ld)", group, key, tmp,
+			min);
+		goto cleanup;
+	}
+
+	if (tmp > max) {
+		warn("%s.%s = %ld is out of range (> %ld)", group, key, tmp,
+									max);
+		goto cleanup;
+	}
+
+	if (val)
+		*val = (int8_t) tmp;
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
+		warn("%s.%s = %s is not a valid value. "
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
index d31dd1b8f..5846ef92d 100644
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
+# 0xFE - Antennas to be used in repetitive order,
+# 0xFF - Host doesn't have recommendation
+# Default: 0xFF (Host doesn't have recommendation)
+#CsSyncAntennaSel = 0xFF
+
+# Maximum Transmit power
+# Possible values: 0x81-0x14 (-127dBm to 20dBm)
+# Default: 0x14 (Max Power possible)
+#MaxTxPower = 0x14
+
 [CSIS]
 # SIRK - Set Identification Resolution Key which is common for all the
 # sets. They SIRK key is used to identify its sets. This can be any
-- 


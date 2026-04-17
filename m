Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E10371876
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434196; cv=none; b=b1bP12T2m9MqRUjhZUEyJnGkzqfN4yPhGjhqXWl801NY2OEQ1ICaXFHVMZ2M1xWNwPVdKYvQ3zLJlp70uenDqxmTiFfGIzxKKiN+c8BnKH3SKPuXL06c8QiB1bCS8EWT+7wthhiOAtdgJlV5EIEzvjwiO8SgprLrfpXJqAu1LE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434196; c=relaxed/simple;
	bh=3tE+weYWOu7MItcpOCIRS5aGF9nqB+yNXYlQMKfKln4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBBP7Q3BMgjcYXSy7t2o36ZV+RCpqyPLoHGOh5xqdRVFMBTM0n2vu/IjOZ80+g+Fm6NEOfiBkJLm3CjwN6o1ND4a9b1uwrG03CXwPJoyA48cwYeiYWWT4XqoY+fyRRBHuwZKRXq0StUSsu+VjldjRMS6HHwdLrXRsDIFWw9HbfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QjREFdRh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JV4q2cQ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QjREFdRh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JV4q2cQ3"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H8tjWl1971847
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 13:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=G7Zuwb0taFZ
	B/ngByP/PYj3gbRIwMuwHYZB02Pz1K18=; b=QjREFdRhNu7MyWKZQwee3T9Ljck
	r7lQashTQ1EhOJQgo924GKTUdZbEjmR09Rwtg7tyix35YOiOk3o4l0K7G7Ws72DP
	WHJheFZlKMXJKlcRgUKFiiUjgjJ4ShWW/qD5jTrERU4/Dg9aVxmIT/Yk60/mi/jg
	FHGTmaBFav92SvaO6E0Ky48UoU+elaMgBYRbvObAFHnLshkuaQ6CJuyLOJLYmvWH
	8/UT4A62+RQCq1vAXW0NkF2JdR6BIO5yuRxamQ1odZnCIC1L1uP1G0KsxZ1alcUp
	LOPA4rbS3VZz3znKTmhLVWXkn8bBNJ4UQfwx/Y3ZHrm66QIlZ+mIPg3qzow==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhsh927e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 13:56:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82cf8dcd079so539717b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776434194; x=1777038994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7Zuwb0taFZB/ngByP/PYj3gbRIwMuwHYZB02Pz1K18=;
        b=JV4q2cQ32qV89t1qPGwtdEUmlgvOdIaVHfeiUVL/CNu6aNljbbUvHHedyE2Wn5AqUc
         VoECHF9vlv+mBSGz/QDVqb2iQpuBl5TIfFxD+2yRn49AWf6JKle7O3wGawEC/l/jeBU5
         RKscRKeeQaq14fJGrkEoKmYucOYlJucDJSVlpc54sBJs7FgIr4ahQyahRH2lRsrERxqW
         sbsKdmLFBjBs4GzUbW7rRrZjjvOplYV+GkhofdQpeVcqEeFTUrhQt3bH7zIHoitY6MM5
         eg5yH7+MnnbF6jRTyXbMl3M+H8bnsVyGHnkQbQrZqmUMVH0gK9/fmEHSJ2MsPnd+jMt8
         b/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776434194; x=1777038994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G7Zuwb0taFZB/ngByP/PYj3gbRIwMuwHYZB02Pz1K18=;
        b=ggr8zlKSTHauy/vJ/t9059s4nZTPeDGGiwzwR6mTk3ZWuf/FcXOLrI6UCFgrNgWd0D
         fHZYcwtbRvXPoppzgs9JbwBTPVf9brpXrTWJqSNAFUERYx4REwXW7mUfzQKdWolqTH/e
         QczJXCMFj8FhOejXi+lVjLxHmrs/B8TGnY+/ZF2V3j+Kl6Y71ZDj94QNVuWhq3MlyOsH
         NpBI4peuxbrnQQTFTiFAbXormDWwMaRtPDZRD6t5ZqEUFb02f3QJXnAxWP1R6JL7bmKT
         ZnrQnVj1QG1ZZ6XDUz+TjgL1mzERkLCaRzlwYwPbXMgglKLHSQOJMGR3WDMyX1Qd6tIt
         D3zw==
X-Gm-Message-State: AOJu0Yy/WRgCUugllD1+Rl49s/ReCt+/dDlsh3UW8F5NX7khnFnF1eC8
	LUbUiLap48BYMy9jWqTzWPH7r69ous/CabuVV4NhZXQUWWKSlwt5up2Ksz/DdZBPmVjXVkthBl/
	EuaUkKCtXo/GslUsqKLWzUbiSmrISFBPHudLb8t7N85o6V+ehf2fUCiS+iBxVeSnBnb6XzRkVu1
	WwX1k=
X-Gm-Gg: AeBDies+xtrW4yeHqMJ7v+kgNheqqrfZz1MzGt1F8boWhD/qvbvI8yBqHBlcW09KomK
	gGAcNYjY4zRgw4l1g5GZe4CF6ySbe3FCdJwRG1mvP3TwIrCDClYsZGoO0NIlunpkZjzW02WF8qJ
	jvocXyUOUWlRiSW/ALGDxVMFuJiwMIDySjki1/Ka+6KsifQR8ZEJh6s37/9sfvWRPivUx7c+k48
	HB3cNr3IgB7vAkP19D8dMYM4MC+84Vd9AwlgMw7s/LSA8usbHU8MSDrtrfbbsXBXk6Gxfyj96QJ
	xCLVfIysDZHK5VNxTP3eO5M1YxjWFILGMwZfktfy3xpmGmpFje0VgVvm3V2FwZ1BF2KKVpF9bl0
	44PKG/Kd+AkvArWelpq1It3aC8hpSkhgESD8Wg4fiWhqd1mwwSntX22rxWazoaw==
X-Received: by 2002:a05:6a00:2d1f:b0:82c:e19d:cabd with SMTP id d2e1a72fcca58-82f8c7ee387mr2939981b3a.10.1776434193691;
        Fri, 17 Apr 2026 06:56:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d1f:b0:82c:e19d:cabd with SMTP id d2e1a72fcca58-82f8c7ee387mr2939932b3a.10.1776434193042;
        Fri, 17 Apr 2026 06:56:33 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c12sm2652375b3a.6.2026.04.17.06.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:56:32 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v10 2/3] main.conf: Add Channel Sounding config parsing  support
Date: Fri, 17 Apr 2026 19:26:03 +0530
Message-Id: <20260417135604.3044630-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417135604.3044630-1-naga.akella@oss.qualcomm.com>
References: <20260417135604.3044630-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d6/FDxjE c=1 sm=1 tr=0 ts=69e23c12 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=IZGhllgqU5eGhMH6-2IA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 4sV_Dcj4S_6BzXZkvdE-FVVCq1HPRR7E
X-Proofpoint-ORIG-GUID: 4sV_Dcj4S_6BzXZkvdE-FVVCq1HPRR7E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0MCBTYWx0ZWRfX8V9k+IWhbX4g
 nZokNjeKIK2TaufQ/rjgZLnx0Jf8OKmzWQzVQNT+zMy0VMiq8bqyqYjrT4+AT/t9fHpvjLeYCCN
 VOdM5WT4pgg4Ky9XPczzG7/XOMJKXmzHBMEf3zvRaH7BB6y0T8gBzLZvmMn7Bv7JZ+8Mx1BoUC9
 ER7m0rnuZZeZ7JX8/qpoH3OnENQ6AisXVPgJxWmZME/vsc6LHAsnr3EtXx7sUR1u8irnVfKPeD9
 XileSsbIT7+/HzgeXl65YK6h5r6CzDXRedG7cpUdw+DoeosSv9PVV7tswB4nJwlGoksUl7PXNDw
 V691loLr1G5eifHwSX3LOtcSqFSdz3cMFFkPckjsxNVkZ1EnYGEsC711xGrUy/gbIjbogmF2sia
 CNBJFhj4SlP6lvt067oEcV++nK5PPmNoKBoE10I1xkvT5PMUo7UcSxtwxC+6zJ14GbbrcocmVha
 H4cwp8ZXky0Bs4UYZWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170140

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
index 818f7c06e..f44e8b906 100644
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


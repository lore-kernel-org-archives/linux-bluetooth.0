Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68B156C6A
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 04:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776313238; cv=none; b=WR38d8UYObUFrX0au7YQ2syvkykesie51mqWAYa3Euv7D5N0JH/lisc6bIjmbCCAeFNPUP9c1Cyx/uh9GKkKyU5Ejk+vemnIdM9flaW6yYaaPfheVBdiVbTANRshGFuI039TPZ1l3L2158crO43DmmyLtBPu0Wnb8hK2BpRC7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776313238; c=relaxed/simple;
	bh=U4MxHtbAeqF9Q4+34BzCuoKWR23VkonlqjYGKhprHng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1YG2boL2sNEsRXaR/eiE7GERfCxOl6lRmHJou39x4t9EUWrVCeauYVZxzg1v+w5LcCc+Qy0YTTFaah9kl8rpGyZHJl9YNlX33XxvzNHG/VP8gnNiEtx0TjUJLkq98g2a/2ddmZbtAqmEyfuHmKXpMKcCrEK849l9eVo1gXyEJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XY0Mp3Ie; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SV/oa/nm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XY0Mp3Ie";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SV/oa/nm"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G2NrKr1792421
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 04:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kbLfTAfE3+X
	/+gZscjE7eSI5mFC+Nk3lv7lRIwJZv70=; b=XY0Mp3Ie/oLGaETaqCE+TCszv1D
	INC2Zm/kqe7qdhLpR5eZelIuPgVlyfAg5S911JlxznnxYmptfKigmyRtx1oyWhc/
	9GIs6ueyDnFnSWxfi5+rl5TSDBAC6H1fkj3BGQnOcHsAUZZZp9/EfYKYshsrV9dr
	dEEA8NWE6P66sx/EddIUIj5edfmKT9yECvVMnhuw/JdWNMzqbz7d6JrMUGH+ltUE
	XG1vJ0zESVBDsWxlxsvMgQ/V2V9tBXsMd0yk7Ke/A6WGVucufGwKJltyBAoq+Hxv
	E4QJ63XIEFbAw+RcnXdizNLrfreJ5q3MkskNg3x7eO66izfUeehmwBoXCfw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djd5pt5we-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 04:20:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b241be0126so151082365ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776313235; x=1776918035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbLfTAfE3+X/+gZscjE7eSI5mFC+Nk3lv7lRIwJZv70=;
        b=SV/oa/nmAWWJLjG9+vLO+cR6Z3uYaT8voxTlAMtuhiHoe5pWJKna2XlWJ63L072wI5
         x46UmwWP9LZBM4LHxvv3ScDYLBPxrgWmq4LUoNtZAn+yJQ0E+fxtXKKYJox3jcuQHJxJ
         lYYko4ZJW6F4fkm+KYwP7o7TNF24UFxaSFdbPwAO/SyMrh1aKe2b5JSNvmMboiDpnWNm
         lOrMHjSNtNFr87OI1hba9xl2BnWtyrC6pPjH7n8gU+8em8uCwLaDBv9GhTpF+99ZlNQp
         R+Gfx+LNJWLSSzh6FOj4C/Y+OcNYBLjKhpAJagB6VZdtlgYsn591AVzt1jko/Vkpq+CV
         5R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776313235; x=1776918035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kbLfTAfE3+X/+gZscjE7eSI5mFC+Nk3lv7lRIwJZv70=;
        b=GXsMNFSbUA8eJV3M17YmhrwVq8QTY1/wkcDZXyddc0qgZzTDc9absMvNfs6aqnT9qz
         IlAAOuz0PgdaYEdJXrvH+tXcd6KP/+M/ZePQXG2LC+oMn4aSBulmUkESxPleS6U8R4+K
         AtD28dHDuduxCohTxrdMUDy8PwPZvvJbFOg04hqinAGnahDX88SNnLfjK78zOq980W0y
         VquJxyaIoNdWnzeOtW/uGLxJNVdjYGP+RWrJUB/fYWoCBPnZi3LCfLcNTosinbcjZFjW
         OKIiSUN3nOSrkZQ0IhfXnRQhGtdqCDRnbKcCA2e/tRCtjYEDDXa6azzJjROeMT9hEAgp
         i0sw==
X-Gm-Message-State: AOJu0Yys/+4PCh/x9NTu51+NIIu7UnJe3dCjll08VGoCf5zMHAiQJXL4
	QHO33WHBHBz7fjiiUQNZFsUI7desSqgnOGP7UjnyEYRIMgVHYRor3sfPpdCCEwcMkoL3YDmHBv9
	iM2/aLZYBSVFlDZS4GBASIZig0ogJPs6+OaUW4KKSKTPZePDGt0v0hbJJwycA3FSURqb0ahjTw7
	4m8To=
X-Gm-Gg: AeBDietDc/s1d4nhK32Ljxj+P3ZZRoxpipkIuPa183c3o8lqyGkPev8jFqGZlYKwIW9
	twOonWv/recW/NYhkA6ecvq4qZBre8BDwtn1Pf2Rw8B59yeXL02DJpaMEhH+SQlQNLZiDcTC6vM
	5KRfpLf5B91MOXiOkCzO9HKPQWHaFZ6/pk1T8PUX1xi33pQtmJ3uLUyvIZCsXVVBQphnYKCyKl8
	OmMdNunV3npslA5CgstXQi/a/t/+aZg6pROdmRit8jyweGKNTeB8XBE/GI0VAWOtLVNgP/EZLF1
	IdLrVRA5xCROrQOrwRWNrcO6Flu2B1UjYy39ya0AdDMtvvnb3/rfxAngywiVRSafHLzpc5OrXQ6
	OFF0Dfku7gGE/pN6vCKIMuPYS6Plf1TLQcpLLR0p7DTx4XjIn5g8=
X-Received: by 2002:a17:903:2f08:b0:2b0:5923:5194 with SMTP id d9443c01a7336-2b2d5a45e89mr261522655ad.27.1776313234782;
        Wed, 15 Apr 2026 21:20:34 -0700 (PDT)
X-Received: by 2002:a17:903:2f08:b0:2b0:5923:5194 with SMTP id d9443c01a7336-2b2d5a45e89mr261522355ad.27.1776313234329;
        Wed, 15 Apr 2026 21:20:34 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782abd6csm37208465ad.63.2026.04.15.21.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 21:20:34 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v9 2/3] main.conf: Add Channel Sounding config parsing  support
Date: Thu, 16 Apr 2026 09:50:11 +0530
Message-Id: <20260416042012.1204688-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416042012.1204688-1-naga.akella@oss.qualcomm.com>
References: <20260416042012.1204688-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: isKkXZZpn4FaIJJcU6qy24M9udhS9x_i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDAzNyBTYWx0ZWRfX2EBAs8WL+Wvx
 KFCMGtbpH5DBafqjiZvpHknjf38d9BFy7aEmBPMPewCQpFneLzSfc1tSqU63Lv1C/NmwlbopXAJ
 058OegioL26h4gbmjyhdx8JSUTCAJ3oN4d4z0YS2E8OdWzeZOSdQiw7dBkxkEJRuwf+kXOffPRV
 s3G2RyCSBNPusyCKp55mficWtXiuwtYZWVWQE/8mREzbZ/WsqX5uGE1vmZG7JSdm197/fTJnqlO
 60q6XjEWcIvNIpmhXxZLfr5VOwsJ3wn7rPIMV9G/PXP5kQkLy+MsU09iIAxRM/gifmu+bdc99gG
 5vjNRaRuvXK0T0AleQjfmPpEin4ueNYsvHmETj/s2czB77QnPsJWl2tHNKz0e4B0TFCs6jczJF2
 YqJTT0MikWosqXfVGies5V9epscjnR+54WynfnH2cFjccF5LhhR+ORQDu0i727T10quDzcXlPFS
 2TNoLIWTND4tcWvtceg==
X-Authority-Analysis: v=2.4 cv=AcmB2XXG c=1 sm=1 tr=0 ts=69e06394 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=IZGhllgqU5eGhMH6-2IA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: isKkXZZpn4FaIJJcU6qy24M9udhS9x_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160037

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


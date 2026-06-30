Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E33EBF0C
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814347; cv=none; b=YArPZy3nB5HU6QtoD6839uA8FHL6mzGsUVrok2YZPwOE2Ft1XZ+4w3RH3Ry3WLq7IGfhMIxg3F6l/Kl8hNviHb2WyR++/OGEQgnPpMOG4iy05/ALEQRhGQ3aITg1iOalU80qft6rRFL3852ypTjsB400UkdGOdhy9Q1tA+wLgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814347; c=relaxed/simple;
	bh=NPh+PZD2MvFkKp9n7C27/n+RpwcNqNpwyaaQoEnORL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D4nT3jFBq+sEuXZYNhqvRgwHHOrwY866JhdOO/ov1nQX6xR3d0cdGaOfpNPgUpHkaI7aX31RlaMpaSRTL16nMH8lK3gZY/IDfR7s+QvYB+zOIfmQg2/F1FbLAUvNusWMb9xwG5I4c/BFwP0JG1wOS7BNDuvyobn4C3TmPtiwVac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jLp2qNCr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IWmuKj8s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jLp2qNCr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IWmuKj8s"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nD9s1590639
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=16LuCl2imlQ
	eOTKFOwcHVd5SYWEo5aMO9Xd+Idys0E8=; b=jLp2qNCrogmjEifQVa4JUDhAncI
	pUYeEsmpkzADqCsdSDVQe4CZduqJvRPpfrdrChuqrXyrDifBH2Euy3iSVN2tB26q
	8BFhxslmdsnrZko0u7iJbdO+JLA24g+7Fqa9ZF/nyb+cfNvwIeNaKK5XufGjeS1M
	tZuxU1GyQScQD3WckRrOxODVQKb07frsVxgrp2veJyEIH1efwO7I8ur4MUBK3UId
	seYhHusdnClQ8qNm3H4bN2LTlpXOnFRC3YDujR3dVwdO2CFOM4QSTSFTskJ/LqzR
	55+z12C2y+PHfzyAsZ6rUqkEzKi5JOmmX7PmiAGu+McFj8/UBflYbbqdfCw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9k2wvp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 10:12:25 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-13980b6561dso13215213c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782814344; x=1783419144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16LuCl2imlQeOTKFOwcHVd5SYWEo5aMO9Xd+Idys0E8=;
        b=IWmuKj8scDSnL0yUB/eOg6KgDHmeqpYUyomHmqvwvgy1YhCk6sIgqblMdaF06onMFS
         64X37Ks3E0FFFXhNDp+hT89PODUOrEDYSDVfQaXGKM/mr9glejdz4sUqXYR2qECalr5G
         6mxgPwJFrkEcN8DbFWjVvJPRE25hniLK1Vw34WI5XrdthH28FnYvcwWd7znl1IoppkEr
         NdGMxnDUK/pigZBCoqig3pXpIoU8xVdfiykCkNJWma9n6eXmnP+gCFxJpQW4S7c4P5wG
         4aUry7Iywec3bLirfMZiYkF9IrnaqC/ae6VE9kzgjBlZY38xBSR9eZj4seO0jTQRYJZ8
         LyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814344; x=1783419144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=16LuCl2imlQeOTKFOwcHVd5SYWEo5aMO9Xd+Idys0E8=;
        b=E4tnt9y4oKbKWWt+AWRI4QZVs3EtUzOWZ7RXE931O0PZYInp09QRxfKlgigedppoWu
         sFI1mEGDwvP1cvZlc5ECtUckkhiPzfqOeJOo6Y4eZ/j5bkbRU4yCBOhXeQQp/oyje/ZE
         PWOBK53HV+cY7oT2E8dlE+X4Rpnxc/ImAcNGKh/E/a84TWoDhe9AxODGb8eZ9z6uFWD4
         7OdFibZWzx34d/Z+EOakMMJZLoWDCbMoz4c/Dx3H0KP8lh+E9U/FyxCF1IyGD7J0z7sj
         hij8t12psVkHWa1fFwPjHXQsmb1iW3A85SMqzoaawtBLcOph7xq/hxKvHy3nljtJjX6y
         BNsQ==
X-Gm-Message-State: AOJu0YwP0FBM/j/q3URulQcKkxPWSwAi45KWyPagdjNzr/F2g+WAXgEC
	k+Hr4F0+Ox6TmNtJIT0YR41AHujNNGpbMqhvnMjwvcUW28s7NEduKP41M7OO4JWEijdyZX7z9HK
	X9ExeUwQQHJdBuUqOaRnCUQhXpb6YNW86a9LXT0J35KjE8VP56RhPHMePvvOB/4Vd7GxumZCS16
	pyzM4=
X-Gm-Gg: AfdE7clgvYPCzxylSKDH3GM5GrzPP2USJ/djdok6czb3eSBR7c4/9fzKIQfqHzyQKKO
	wE3hwqvGDzPS1ugYSBK+ukofDWiLrYTWwIKF+MCUqXLREMQ/DKutMf3tidPHINtUGidg3SkNVp3
	xXm6wb+Z5Nc6ZDMxuQmZzgHwrNazHTUTqMuWEM470On6n9AZSYZbNcW59aD3r0Of4msTpnIugIr
	iWNUICu7faWR8X+5Unmk1qsv3/CQVyzMH7vKcJUSLfcPH8WvG0W65JIEQESnFfNmvwg95ssable
	RwZIT/E/p354qi85xoSDtKIF2pHO96cCJZmbtd/D/vrKw6a9Eb8rxhB/X/l2/SxWZIsA4O1gNry
	kBpEvl+VQwHT3YZOcdQ0Z9CESPnIVFKytA7RAnHyX
X-Received: by 2002:a05:7022:ec2:b0:139:ed5d:3a6 with SMTP id a92af1059eb24-13b2a1ebd39mr1806684c88.43.1782814344437;
        Tue, 30 Jun 2026 03:12:24 -0700 (PDT)
X-Received: by 2002:a05:7022:ec2:b0:139:ed5d:3a6 with SMTP id a92af1059eb24-13b2a1ebd39mr1806665c88.43.1782814343912;
        Tue, 30 Jun 2026 03:12:23 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2aba6fe2sm5670060c88.9.2026.06.30.03.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:12:23 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 3/6] rap: remove CS default settings from main.conf
Date: Tue, 30 Jun 2026 15:41:55 +0530
Message-Id: <20260630101158.2239682-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630101158.2239682-1-naga.akella@oss.qualcomm.com>
References: <20260630101158.2239682-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfX2m3XNHVdEcWE
 CiU1DqGjeuoB40LRBLAVPdHIb6a/gBXoIDqPfRKb/msDmhGOcIW7t6dLvgEAJ9ku7T5pX2NLaQT
 0wESauXXXIX/HBTZRxiNDmY8p0/KUn8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MSBTYWx0ZWRfX5+C/CuYGynaf
 ySSmppZkoP1L+j604lhlWU+WdioOGDt7eoFnQDyH6lxWnKvP2oOONxEJLaGZeSvSyAYEf2MIubH
 EF6zwmK6iL9ayQ+4ObryNtnUOGdqk670iR296R2VcvTWcoiTQU8BfbuLU1FDdtchnakSgWSrIfT
 NiHNDDbVE5SDWJbWkWwFWmxzxTC8h2U7XKU370cQ8lH3WCm+3+eOOUQcJBMmzh32hIfLLFKn1mF
 qhW7sCKwnQLrjhSuHLUGIsKay1YEt5WT6blpaql7XjZDj98m2G2M+1NgpfVvZxNMFDdrkq4dHpp
 IwZAKron1l85sbwCTpWLXkR1rzTg7LTQ22T2r9L+tSo1bmbR2+aMHcLZlJrJ5CRhYo7vM9M3VOf
 aAVttKHjx+udYQXNvkXl6hu9f/KSasJrmsx3S6aUw7gw8iN3ADnZF4sa5ANoV4i5VVcp/8NVr3r
 3wJ+oCdBcB2UuQK8RNA==
X-Proofpoint-ORIG-GUID: 5krRvByv7nj2DnHPcoB_HqB9jY_VLeTh
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a439689 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=S3gPwdNGb3drqcT6-gUA:9
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: 5krRvByv7nj2DnHPcoB_HqB9jY_VLeTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300091

role, cs_sync_ant_sel and max_tx_power were configurable in main.conf
and parsed in main.c, but these are per-measurement parameters that
callers supply via StartMeasurement
---
 src/btd.h     |   7 ---
 src/main.c    | 127 +-------------------------------------------------
 src/main.conf |  24 ----------
 3 files changed, 1 insertion(+), 157 deletions(-)

diff --git a/src/btd.h b/src/btd.h
index db2e81239..c84a600d1 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -94,18 +94,11 @@ struct btd_le_defaults {
 	uint8_t		enable_advmon_interleave_scan;
 };
 
-struct btd_le_bcs {
-	uint8_t role;
-	uint8_t cs_sync_ant_sel;
-	int8_t max_tx_power;
-};
-
 struct btd_defaults {
 	uint16_t	num_entries;
 
 	struct btd_br_defaults br;
 	struct btd_le_defaults le;
-	struct btd_le_bcs bcs;
 };
 
 struct btd_csis {
diff --git a/src/main.c b/src/main.c
index 8aa19a3e3..53f3f784f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -156,12 +156,6 @@ static const char *gatt_options[] = {
 	NULL
 };
 
-static const char *const bcs_options[] = {
-	"Role",
-	"CsSyncAntennaSel",
-	"MaxTxPower",
-	NULL
-};
 
 static const char *csip_options[] = {
 	"SIRK",
@@ -200,7 +194,7 @@ static const struct group_table {
 	{ "CSIS",	csip_options },
 	{ "AVDTP",	avdtp_options },
 	{ "AVRCP",	avrcp_options },
-	{ "ChannelSounding",	bcs_options },
+
 	{ "AdvMon",	advmon_options },
 	{ }
 };
@@ -496,46 +490,6 @@ static bool parse_config_int(GKeyFile *config, const char *group,
 	return true;
 }
 
-static bool parse_config_signed_int(GKeyFile *config, const char *group,
-					const char *key, int8_t *val,
-					long min, long max)
-{
-	char *str = NULL;
-	char *endptr = NULL;
-	long tmp;
-	bool result = false;
-
-	str = g_key_file_get_string(config, group, key, NULL);
-	if (!str)
-		return false;
-
-	tmp = strtol(str, &endptr, 0);
-	if (!endptr || *endptr != '\0') {
-		warn("%s.%s = %s is not integer", group, key, str);
-		goto cleanup;
-	}
-
-	if (tmp < min) {
-		warn("%s.%s = %ld is out of range (< %ld)", group, key, tmp,
-			min);
-		goto cleanup;
-	}
-
-	if (tmp > max) {
-		warn("%s.%s = %ld is out of range (> %ld)", group, key, tmp,
-									max);
-		goto cleanup;
-	}
-
-	if (val)
-		*val = (int8_t) tmp;
-	result = true;
-
-cleanup:
-	g_free(str);
-	return result;
-}
-
 struct config_param {
 	const char * const val_name;
 	void * const val;
@@ -1228,80 +1182,6 @@ static void parse_csis(GKeyFile *config)
 					0, UINT8_MAX);
 }
 
-static bool parse_cs_role(GKeyFile *config, const char *group,
-					const char *key, uint8_t *val)
-{
-	GError *err = NULL;
-	char *str = NULL;
-	char *endptr = NULL;
-	int numeric_val;
-
-	/* Try to read as string first */
-	str = g_key_file_get_string(config, group, key, &err);
-	if (err) {
-		if (err->code != G_KEY_FILE_ERROR_KEY_NOT_FOUND)
-			DBG("%s", err->message);
-		g_error_free(err);
-		return false;
-	}
-
-	DBG("%s.%s = %s", group, key, str);
-
-	/* Check if it's a string value */
-	if (!strcmp(str, "Initiator") || !strcmp(str, "initiator")) {
-		if (val)
-			*val = 1;
-		g_free(str);
-		return true;
-	} else if (!strcmp(str, "Reflector") || !strcmp(str, "reflector")) {
-		if (val)
-			*val = 2;
-		g_free(str);
-		return true;
-	} else if (!strcmp(str, "Both") || !strcmp(str, "both")) {
-		if (val)
-			*val = 3;
-		g_free(str);
-		return true;
-	}
-
-	/* Try to parse as numeric value */
-	numeric_val = strtol(str, &endptr, 0);
-
-	if (!endptr || *endptr != '\0') {
-		warn("%s.%s = %s is not a valid value. "
-			"Expected: 1/Initiator, 2/Reflector, or 3/Both",
-			group, key, str);
-		g_free(str);
-		return false;
-	}
-
-	if (numeric_val < 1 || numeric_val > 3) {
-		warn("%s.%s = %d is out of range. "
-			"Valid values: 1 (Initiator), 2 (Reflector), 3 (Both)",
-			group, key, numeric_val);
-		g_free(str);
-		return false;
-	}
-
-	if (val)
-		*val = numeric_val;
-
-	g_free(str);
-	return true;
-}
-
-static void parse_le_cs_config(GKeyFile *config)
-{
-	parse_cs_role(config, "ChannelSounding", "Role",
-			&btd_opts.defaults.bcs.role);
-	parse_config_u8(config, "ChannelSounding", "CsSyncAntennaSel",
-			&btd_opts.defaults.bcs.cs_sync_ant_sel,
-			0x01, 0xFF);
-	parse_config_signed_int(config, "ChannelSounding",
-			"MaxTxPower", &btd_opts.defaults.bcs.max_tx_power,
-			INT8_MIN, INT8_MAX);
-}
 
 static void parse_avdtp_session_mode(GKeyFile *config)
 {
@@ -1381,7 +1261,6 @@ static void parse_config(GKeyFile *config)
 	parse_csis(config);
 	parse_avdtp(config);
 	parse_avrcp(config);
-	parse_le_cs_config(config);
 	parse_advmon(config);
 }
 
@@ -1433,10 +1312,6 @@ static void init_defaults(void)
 
 	btd_opts.advmon.rssi_sampling_period = 0xFF;
 	btd_opts.csis.encrypt = true;
-
-	btd_opts.defaults.bcs.role = 0x03;
-	btd_opts.defaults.bcs.cs_sync_ant_sel = 0xFF;
-	btd_opts.defaults.bcs.max_tx_power = 0x14;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index 5846ef92d..d31dd1b8f 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -299,30 +299,6 @@
 # Default = auto
 # Security = auto
 
-[ChannelSounding]
-# Current role of the device
-# Possible values:
-#   1 or "Initiator" - CS Initiator role,
-#   Generally, CS Initiator acts as Client (Gatt role) and Central (Gap role)
-#   2 or "Reflector" - CS Reflector role,
-#   Generally, CS Reflector acts as Server (Gatt role) and Peripheral (Gap role)
-#   3 or "Both"      - Both Initiator and Reflector roles
-# Default: 3 (Both)
-#Role = 3
-
-# Antenna Identifier to be used
-# Possible values:
-# 0x01-0x04 (antenna identifier to be used),
-# 0xFE - Antennas to be used in repetitive order,
-# 0xFF - Host doesn't have recommendation
-# Default: 0xFF (Host doesn't have recommendation)
-#CsSyncAntennaSel = 0xFF
-
-# Maximum Transmit power
-# Possible values: 0x81-0x14 (-127dBm to 20dBm)
-# Default: 0x14 (Max Power possible)
-#MaxTxPower = 0x14
-
 [CSIS]
 # SIRK - Set Identification Resolution Key which is common for all the
 # sets. They SIRK key is used to identify its sets. This can be any
-- 


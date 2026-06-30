Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0203655DB
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826805; cv=none; b=NziBo87qEC7dHdYW5c1uBeL3Dac15FGPMlJFzUXnhlLC8bQq2nUY9hvZWJfPiIWpphErhuIhiyhwnM+Fwh00Y6VrAM0Hu28pHVFCw5enGEFfDezQDbOaBrDVgJUQfBkjcP9FL063r8czzHBfVrRZh7+wI63ehuLoVnbsUcuaxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826805; c=relaxed/simple;
	bh=NPh+PZD2MvFkKp9n7C27/n+RpwcNqNpwyaaQoEnORL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LjEpSfL2SO5vEkU7UwBQRqkq1PnQ9dMnz3GAaVKz03Uauq9mAcmX6V9+HnZ/xzZtLcIZEbSOYh+D63uZ0SJgezCpMCw3HuyzF+0R74rQDRD1w7MM5VdUlvS1mPqT114V1UgfUh46D9+wKutwRYAKDso2e19Pw9Dy4n6jMCIysSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BX0+UQ5p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J6mrz2Hl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BX0+UQ5p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J6mrz2Hl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mxUk1612151
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=16LuCl2imlQ
	eOTKFOwcHVd5SYWEo5aMO9Xd+Idys0E8=; b=BX0+UQ5pSdUN5rJhUlMWgxSWhz8
	HlmkGC1dfxMsQLAYge6eRp2AB/ddwWs1PNbA1RvoeS6wIojwCqh6/STHDOF4NrdK
	s/0NrXhKVU1M+kdJeMz78B9OuFYIw2yTwriGOP/2Yv7bOuenL6VSvXxALz+R4XcB
	qjOunM9K0D4OHmMvbzkuxvRbzS0YeFKfsBxyVqXavBcwboCXgLpDl3DgYyc/eC+A
	wHttzlyTSrHGGGrSlSgpXnxGUv6mPsio4L4yYt0T8Qa3hCX22NOAau4JRhheTPNK
	thxJE4GJPdY60oG2dLcMfGD9YCnxgWXlQ2Ynelmm18X2tGi1+gJbh1D/GFg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f441gtvre-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 13:40:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30eefcf4a1fso277358eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782826802; x=1783431602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16LuCl2imlQeOTKFOwcHVd5SYWEo5aMO9Xd+Idys0E8=;
        b=J6mrz2HlPXurXrFWQ2flyTbLwKv+RCTXdJAYnhIUDLQxsbhkO0eQgE8KPtekelcslG
         jaLU8N7Mj27G2GyI7Eghr6aaakPj4Q1N5RCon4RkSMDcQWFdAf2iEUXtanAbSn2wAZPI
         cGgzJPdUejVBybkcwV1cUd5DB6MzN6nxCRG3dzWHQ7Y4uZDHCtnBSkJ9gqRLQi0SHVok
         8CzTkMVK0DeINnFh4Kk/+oW0wBUz3phQtVpgqwmICo5BC/tCXOYDtN3HBm7CjM78qYcS
         eexs4unZYz8k2QkERBnxWbxa1rxFIzp6MUZ2JlGisnGmuDBe8uLzUOVe8RISMsj4uPLg
         vKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826802; x=1783431602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=16LuCl2imlQeOTKFOwcHVd5SYWEo5aMO9Xd+Idys0E8=;
        b=ceuuQfYaWUWfAYe/TYwaYxm8fpj1LHKRnc+nIfcikne2gqTh375eolJyD7FigCPD2W
         rPSrOkth6g7Fbi+HNXyAgeA7eaMOdg8oh6fSZXk+UX7lN+fYzRUsKcL2vrL+I9cFxTxw
         ui7BJZmbAu2WFi6opKEhTkyoz204Pexn5K/Kst60iL7ghbjFjC4DO9j266XlLHCYYq0H
         stMC7qYojABpTzPhq02Vy2l4OexRLoC7OXnST9Z8j/UQD4rVwf6YyAK7BJjlzNdP3onW
         DNnGj/2raRTEySaRfaPo1Qm8G5kky0nqLBvwnRYYPkeWPg6tN481TgPKdi++eHBwsnMD
         qtHg==
X-Gm-Message-State: AOJu0YyvSp0/bpYJ/+0WVPwJc8ervhJ/kEvTLeIjEBVK/ooTyV/aFLVh
	tSp/hpKa8/zdFZ8eqLzgVo9ptjW6q3Dd/KvImKlmRXzPpw6ZhEJXIJUtxpz8kPSjc/HUXid8lQY
	itwl9t3TwiRJpSvMs1oqcaN0D6upl5hcqV375hBdeQaAMRPwt08S7T6Tf+gBV6BjYitj/StXXzs
	ROD88=
X-Gm-Gg: AfdE7clHjankpMAc1vJNT0svUM9b3jEKdzHy0rtn7W6xT2q9COffq/3Ho2n+P87uKtf
	s6S3Se5qkm5eYtppRPeuV1rhDba5OW0YKvjZZk4xC8tQDmpj3cLXmJEVLrUWommSEmYdsPNEVo7
	SB+AFXsYz3pE7yZOwTVYZHW7kfaRvlFCqF7HctsO0VI0GkInEve7wpQsenQZfwh86WvwiCpMg7D
	9qToAm2Ov2VTClEV2GBlETWEnek7VquPdWNIUHs8jSR7JQovWtxKUyGPqbTRkTbEmklasYBUfYp
	nhNp2oHMlKYhxqcku4ziAspRcWLSi1VD7e4Mm4Co4ls1c3NntioOzHv+Alpgbu7D7Xm2aMjENRJ
	ycI6U82FBKBrMRhocGDitfvgWHPVNYuZLQkA/FzjU
X-Received: by 2002:a05:7300:6919:b0:30c:6018:4993 with SMTP id 5a478bee46e88-30ee11ad6aamr2523454eec.7.1782826802474;
        Tue, 30 Jun 2026 06:40:02 -0700 (PDT)
X-Received: by 2002:a05:7300:6919:b0:30c:6018:4993 with SMTP id 5a478bee46e88-30ee11ad6aamr2523431eec.7.1782826801950;
        Tue, 30 Jun 2026 06:40:01 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5e4dcsm8704158eec.5.2026.06.30.06.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:40:01 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 3/6] rap: remove CS default settings from main.conf
Date: Tue, 30 Jun 2026 19:09:37 +0530
Message-Id: <20260630133940.2461816-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630133940.2461816-1-naga.akella@oss.qualcomm.com>
References: <20260630133940.2461816-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfXy6esdLS3nZrU
 YAV6MNZd3uz2NXwhRz2V4ysFFoEkemCo4bFliqKaMuZtxl40c5lcKGMVW1K714XCm0I+3FhwjPq
 LCa9D359GKpuAomyp9NkWTLE4pI0+G0=
X-Proofpoint-ORIG-GUID: WePlREZkAW_uMD39kzaJt4MkOJBscb1t
X-Authority-Analysis: v=2.4 cv=F8dnsKhN c=1 sm=1 tr=0 ts=6a43c733 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=S3gPwdNGb3drqcT6-gUA:9
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyNyBTYWx0ZWRfX49/g/Hl1B92K
 1463qYKob3i9Pjp3iPxR46r9tA/dt+h3JuMejwUnp9hyHl7SiwHFkdMmNBWHeefgU4JUUPGBTeh
 3N3MDbX4srt7/k3CCiKc75YfGmJ+jNIK0aX0cvBGd1ccfHZU0spgpkOs5JLnSm6Xbr1skOJ+kpf
 t/g5V9Ls59sgwZbNIqp/3SfyBVFBYVULfkizgWZH35hPAxfwI7nIUHj4FrJaltawW6EF49Bvj4X
 cguudpzRGBAhyq7ss27KWE0jecFhhkSrlnqvHthV/flzI5FhFNuoKOaG8YsajlE9lKnh5eJ9ARk
 ltoSIauEzUM1D14MbWfzTXDMEHLtqGUP6v2uIMLJeicF+u++zTdup3CRmRzzOldz7unkTGmTBlG
 YrmzCCPZiWdihnTyNcNdMQyO/FBiBeZ3hikI5FpDADmPhp3eZXrYINXRPOkyrEKZQF4iHOrW9Lk
 Q0cOZQIO7WGyro0jtFw==
X-Proofpoint-GUID: WePlREZkAW_uMD39kzaJt4MkOJBscb1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300127

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


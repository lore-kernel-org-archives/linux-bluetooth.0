Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB035F163
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558159; cv=none; b=Gjx3EdeTUTbcXqrYQzn196TJdO9um5yPr1WFgR06beQojFOeOuiM4WG0rk5EV1u5J6B11aY5BmXxrMSfqM1Bb2W81x9whAWaPpdEzKc4TW/DmBF0NjsKL+X2nREFyrKf38Nn0LcUc7VNDPx7Rd/l5lt8fEy+g0rwtuQu+1HWiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558159; c=relaxed/simple;
	bh=8Oue+X/XSwGnNvM28kIaii2RPIwqQgZgCG37FXKjtU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vj8uIMqAT7JoDK7abTZ3dn/yvqp+oF3RofUhciK2jimhkdsLmve+ehefYHz6v6u5utYEzI8W5prl3BP0VtU2hGrTbfCWKnpcG6aKCoxi8HZh8muPqmpLUhNo/jev32VzSkhIWKpaCnzhyd54M6+ACALFeE5coHarQmZ/5BdbHvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZzENbjx8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aW78iDdx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZzENbjx8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aW78iDdx"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376Wjoe3402384
	for <linux-bluetooth@vger.kernel.org>; Tue, 7 Apr 2026 10:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PKB1MTJ/6T8
	2iVNLXST100+wtHRuIrk+ed+jlX3cMyQ=; b=ZzENbjx8N23toepUT91ejVh6RT1
	Z+wc1Lmz97CntXSgp3goyosMuzLAZPRKClukIOLi747jhCXt06k0nCwjsvw7STCv
	/l2fjYt6C6jDpYEtrEYTUKj4ccppCTdpCc2/FqKk6qUYiBt2BGR9xLEtvg2mAmhb
	nOgd+s6WhdcVQQEpcllCXyviqV/B0PZdqtm3MZ93JJ5M4iR1M+5pie5938zqc8RS
	zkMt5I6btUcsR8LaYepUUrVlCVKNu6SDDzLtyTUCzyghbg6QAA+Iox/2pgx/0zJR
	Bz+A/T9yhMXjBUxsYLJo3b15WUQbXWAbRfeQQfWSFrKLWXBuFjPEllC9Hag==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrht9w5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 10:35:56 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82c70d1f65aso2833053b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 03:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775558155; x=1776162955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKB1MTJ/6T82iVNLXST100+wtHRuIrk+ed+jlX3cMyQ=;
        b=aW78iDdxeMZBHkAFeFI8Rg8pWPnNSUUfzpGzEj+Y1WemNjmS2HHzWsKJ+bdsy0HX0A
         xZ60YU5B/vj0NylieWFkCfBA5lnhwEqd69A+pel862XpC3sTSnb8zI9F3vuM4Fv3ZEIa
         HHekHL61Spm9cTR2xT7QHi0IoRr/xlQ6A/GL169BD4BlG68NJ0NGhxxV0cNgpy92lYwY
         v9yJ99GT7CVpK/wOaNvdrb7I2/Z5cwmlFvkexSfQcfHMqqgVeoEsUXIWjsbbu0VdztdV
         IKBgGozuZ9iMXScAOM5JZ6stTFVcCceTFB1ZlpEkLr61qSE7FF6QK5BN5kf4tBAXO3Vo
         OjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775558155; x=1776162955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PKB1MTJ/6T82iVNLXST100+wtHRuIrk+ed+jlX3cMyQ=;
        b=abahNf25mMcXN02Dwi+YSzvQekW0/UFC29i0iRwCnkJfYe1AyobxtLD19zMo5iw9yB
         9z8A0nsmYnihfSD6DhSGd5XCoLIVWIW3hioKi7kmvMpOPX29xTHEvAUoBXFjrnzPS9vH
         Bp0oN1+lZwFuzjq3iGPyZ3RsOdf9/R59mj4e3rNtRDrC1yX5oNBTR9YanAEXKVDAdfyX
         58Owr5SiNv3CjG/ORHPp617/Z/NY3wFyYk/52q68SjxKTlxAXFF0+ZAACLLpjVuuyvg3
         +TgQ/JdPhryUvKYjx+PHbvCkltVXW5lj498hvIWWumHeBhrXQZsT9PXyRe8MuJBnO1dg
         0yag==
X-Gm-Message-State: AOJu0YxpucIhtY7SzjuaMQLqV5avqhzeBBwIk2eSh0u/Dc6YcEcT8Iz+
	/1c3IPEbT2sQWrhI/QOEUq2Fwf2P0JSVjMrXqYujgTUo7EjQWsjwa8z5q1tKB0npRa6LsQAi+VH
	j7t0UEctWzXauqVTD/r35D7qBBDZgqhNLham2MfbH0mmM4WivBd/m12fznbxKGRyCkbFO7pikpc
	/V7S0=
X-Gm-Gg: AeBDietHxgiMzdQr3VIRQXqgIuETzPZdkrOHxzx3J4mCjecflYOzMCCt2nM23usfHPh
	o0mUfwSKNZX86htZBposTERwgIFU3eIy4Dgl+MmkzvNol/Z/c4iVa0GVh4usKNv5mG4xS725pQg
	NgC4PJGZoGPdmbM4Nc4g9NbR4urGsExP6QwriSUXvn8uBw8duP9Nqys+BFPoaff76csDiX9EfsS
	UZ9tKhmo7/kCaVc/BKBrZ6muqlXEOk9FcvnK0TvXRIDPR6LHwvKqymJY6m3Xcg/do2mKK3R42Qy
	Z1hlxEn/CF8g3ftCRp5BLCsCZ49jPp5SZl8fC2D/SEKD14okabMlVwlzKWWDudiYkUZc1DgBY6G
	ew/JZdQtO/yKOh6D/hmGGux/mgi4+aJGJjpWPOErAXNknu4qsjQY=
X-Received: by 2002:a05:6a00:198d:b0:827:2eff:a29e with SMTP id d2e1a72fcca58-82d0db72b9fmr16887648b3a.34.1775558155354;
        Tue, 07 Apr 2026 03:35:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:198d:b0:827:2eff:a29e with SMTP id d2e1a72fcca58-82d0db72b9fmr16887608b3a.34.1775558154785;
        Tue, 07 Apr 2026 03:35:54 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca14b3sm19575136b3a.54.2026.04.07.03.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 03:35:54 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 2/3] bluetooth: Add Channel Sounding config parsing  support
Date: Tue,  7 Apr 2026 16:05:15 +0530
Message-Id: <20260407103516.2371804-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407103516.2371804-1-naga.akella@oss.qualcomm.com>
References: <20260407103516.2371804-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5OCBTYWx0ZWRfX2PCI8ohEZm1S
 WhaC+6XmlyB3ONrO6WCAUEi6DHAJgP8U//06VyS7AdQVCmE1PXvvImXtHNJZqWcgYXdSx8jrZ5x
 GSdwEtaGBpfUheVitlbNE+dIN9J4gETsL9HtTj/QZ9UJpZe5vuiWsOf+n2gjTW5kSHJ00pvrLhO
 r6Tx0aQ1D6tgmcKu3oCu0+2iCgcVujxxbd2JMPqoP8iXoZ9YD0jh3vPbx0iM0O32fnNZ6Jhk+i9
 Go9GsHr3nyxlZtECg1PetN7iBWGcMVBlmN4JoBnXDo6yESdOKvJX/lwrz0NFrqYL2aCp8CFtCNn
 wmMeRVGqh5msKQHZOmNU8TGCw76sw1BloBVp5bWhHmnx0DH60SCzlaw+WYjN3N6kUv0/0+Q4JeC
 BN4KQMMx98GwYD/fCulANhu0t6AekyJr4cbn6hmg84D1Y2OqCPziM7hTOE0oEJssAUN1lIORjHp
 vJUOnxiOfFf2QjMs8dA==
X-Proofpoint-GUID: WCfFMLbbM83oIwuRyLnzTRTUnFDjgmDV
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d4de0c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=FW10I0WjtUwoV23t3qsA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: WCfFMLbbM83oIwuRyLnzTRTUnFDjgmDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070098

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
index 1b521706d..0ec08d622 100644
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
index 59df0ad4c..92734edd3 100644
--- a/src/main.c
+++ b/src/main.c
@@ -155,6 +155,13 @@ static const char *gatt_options[] = {
 	NULL
 };
 
+static const char *bcs_options[] = {
+	"Role",
+	"CcSyncAntennaSel",
+	"MaxTxPower",
+	NULL
+};
+
 static const char *csip_options[] = {
 	"SIRK",
 	"Encryption",
@@ -192,6 +199,7 @@ static const struct group_table {
 	{ "CSIS",	csip_options },
 	{ "AVDTP",	avdtp_options },
 	{ "AVRCP",	avrcp_options },
+	{ "ChannelSounding",	bcs_options },
 	{ "AdvMon",	advmon_options },
 	{ }
 };
@@ -491,6 +499,46 @@ static bool parse_config_int(GKeyFile *config, const char *group,
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
@@ -1150,6 +1198,82 @@ static void parse_csis(GKeyFile *config)
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
+	parse_config_u8(config, "ChannelSounding", "CcSyncAntennaSel",
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
@@ -1228,6 +1352,7 @@ static void parse_config(GKeyFile *config)
 	parse_csis(config);
 	parse_avdtp(config);
 	parse_avrcp(config);
+	parse_le_cs_config(config);
 	parse_advmon(config);
 }
 
@@ -1278,6 +1403,10 @@ static void init_defaults(void)
 
 	btd_opts.advmon.rssi_sampling_period = 0xFF;
 	btd_opts.csis.encrypt = true;
+
+	btd_opts.defaults.bcs.role = 0x03;
+	btd_opts.defaults.bcs.cs_sync_ant_sel = 0xFF;
+	btd_opts.defaults.bcs.max_tx_power = 0x14;
 }
 
 static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
diff --git a/src/main.conf b/src/main.conf
index 724c4b44f..84fd28f5b 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -291,6 +291,30 @@
 # Default: read-only
 #ExportClaimedServices = read-only
 
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
+#CcSyncAntennaSel = 0xFF
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


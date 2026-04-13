Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9941D6195
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067248; cv=none; b=g2Kx44E5E8o19eSKL/WeBil5YbaSPhD43DR40Qp8klaAyk0EZOb0OseOPifTzctaqw0n6/o8UD1koyB8t0WGJOF1eUJeC6qNuzennX09igof7+WXuZuywShQCHe6US4hgBnz/yRl+7RMdDbESyqzvEN7LyXrny7Ov/DsyN9F17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067248; c=relaxed/simple;
	bh=Lrud2Z0tGGhl+VnCuJ1LlC8xsqXINEr+qSBF9ZE+7pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HLMg859BCVsGSrCkQvqzs14VgwHQePTFYZHz95WQTi9qBWqxu1nXvcL9A+9j70g3vpktCzQNJw1B+5IG0/fP0VMbN6vKM1ScZESlxUpV/jYROat4BgxakGbeJVuJdFwick6iNDuoLtVihXqhVsG+syU/TzcmVshQfQR2INA7FRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jnd4EC2V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TG4DfrkE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jnd4EC2V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TG4DfrkE"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D794Ef479974
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 08:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dvvuScVK2b2
	/eF2Gcyoy/wJNo8yVtoSIJIFXCZVtXyA=; b=Jnd4EC2VkNuwlxH3Iu3u1N99rYH
	DmpS/6nWHi5FK+pySePfPlBJuF12YQ+ykDmC1T+EQRtA7QH2BxQ34upSh6d3Gm/4
	af2aeGM9LpHk6B/R3kKnIRKege8hl1+gpw/7qemTN2hJcyALs92zEFNsZfPJn4ua
	24Xyno6rSRWG9Agm6F7KCtvmK2mPp89+qmN+TrzJXCzBTTBTqqG8dUA7pllHIlDr
	psy0M3LdEwCeKc8/aFmcRhCXgO1BgiNV6CdzdWosFlyyGpmqI16LEGxV/qHcUtv3
	HHHe2y25oL1RXb8ROLwxQtD90e9UDi14uqt4/gk2GoQtuiG91z/dHzC0b9g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dguuj8599-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 08:00:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b249975139so80553905ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776067246; x=1776672046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvvuScVK2b2/eF2Gcyoy/wJNo8yVtoSIJIFXCZVtXyA=;
        b=TG4DfrkELKHf8EjBITFl8vIl9EIYAPJqwPybvPATJFUQ8ldyrt0G+wNDVByMH13I9L
         o3d3BatDGDS0mjdOsKSlZec08ebG5Shc0/LakorwuYGoS4vYZseI9tVwJWdJhlH6ouD3
         25OYDG+g+h5AK92zZ0yA8ULJ4totu0QgSkV0utUKdLOP5FyVhuU4cTfCW7Ags2yU0Bu/
         tPys+sRKIGp9PoPytYNyhfFs7NW+karoRed06J50fmU/aBTESLvAFJ8SNJtD7W/rTIXQ
         cTx7GTC6Yj3UjndAKHmh/vFbUsymkpdMSHxcvXlYr3juzKew7bmsAC3c0XqKVMQZMb1G
         AeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067246; x=1776672046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dvvuScVK2b2/eF2Gcyoy/wJNo8yVtoSIJIFXCZVtXyA=;
        b=pci3AyjpqjK82YRbAtJzXhvYWad8M1SJpIC7KRnwQKSnzqi/lDfkI6eZRit8raOH83
         Ra6f68TM12s3pQ+86Fdd1UJlDYQnbnDnVlqFDuTSEtzQIAZNPrCJCRliKg/6IYaUxNen
         BUvFKNest4lHUx2zvJyz2l/tq87dCxm7zLHObzqeib1hYVaTggpeqaUOW3krPq4wd/Fd
         BDHWULDvNMTsfAitRBMvyKEL9tRLaQlg1DmGdtmzPgxyxeSonjyJnGFCFw2e2pqmCk+t
         sZrY7ACO7B/NhS0s1UWY4X7Uj5OTpVNEB/ZCxreolWWsZKKQjOnsRMyMBT9yFHuT0cDA
         f0Kw==
X-Gm-Message-State: AOJu0YwuzT2C8PRfspM9XMWcrYPuHym5Bfjg6OMTmnzJtmbrHYtyVl2g
	2zADqPmOI+IDKz+oPIwY16GnvpCMhNuMPJDlLcqXqJidkRe1iiIEMXc69pc0tnau73Kn2rM+K5B
	vT7u9ZC7jwTsJlUlONl0chRuJbrYYQ8ypZtxheMO11cmy+obwmCzdsImEkkkQja+VSOhAwsriJB
	DwLEk=
X-Gm-Gg: AeBDievAPbgHWbWH5j2ia2bxTFqEhFkxZgSguo3lhC2n1uUH8mfYi9rDjdW8T097DoR
	QMfUtKAKkJDlSSSo7u39K8QZnve3ctJcaQjFsQgYPDqBmvYFfJ+sEoYvA6X8qIqXLcTK5Je9qlA
	2Yw5YacqlKKg1VAgqxz2g7jY4Ws5xTWLCDz4UjzwKY1MtTXJ5aOZSaHCHKNeGYufYZH4UI5iZBC
	y+Fx9qOaZPIUIpbUU5rueZuo7h5sD9DpWf42xX0D9GmBS+vgAJh5Id3nHlBElONsjetihEU0ySn
	zT29PCAcxw8kJCpyz0SrPaCpztggXhiKthgDI1y0gIxEBD+ZQbr35nd5fhYH/Ekp5Mx+xesfmRt
	CEBnr0zuWPFWefsqx8YE9S5z4HdAVAKEiBAkiMdh/8FelRvcNSss=
X-Received: by 2002:a17:902:d510:b0:2ae:ced7:4650 with SMTP id d9443c01a7336-2b2d5a450b6mr138752995ad.24.1776067245632;
        Mon, 13 Apr 2026 01:00:45 -0700 (PDT)
X-Received: by 2002:a17:902:d510:b0:2ae:ced7:4650 with SMTP id d9443c01a7336-2b2d5a450b6mr138752255ad.24.1776067244869;
        Mon, 13 Apr 2026 01:00:44 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f0adbbsm107930475ad.46.2026.04.13.01.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:00:44 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 2/3] bluetooth: Add Channel Sounding config parsing  support
Date: Mon, 13 Apr 2026 13:30:22 +0530
Message-Id: <20260413080023.1455582-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413080023.1455582-1-naga.akella@oss.qualcomm.com>
References: <20260413080023.1455582-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA3NyBTYWx0ZWRfX5CBYXWyI4XxK
 6FVM/bSzAfgP4qKtSfBJFQ25jVbEuS1ou0KQLVQnGpx1LN8cxuLX4AuQSYOhHAcc3xjOqz/aUry
 KieBTJGiNpOzCFJcaBqcS96hsd/S6FBTJ3FEyBcHmmapT+OKEUc0AYxMwKA5X1H4+mJBX4dVNFO
 oNZRRyrCr7UiEfMdfMT0VeVBOGvU4Aq02I0RUyZdciyjPpJFXNFk9tgFfgmNncvQsYb/l6dJGnj
 2YwOjdUPAlAUlN5BsWIGGV4kLwIN8S6pYuNPKwUjD6xqzYuZhSfoVcgjQjfDkezQJ8fDPA83rRH
 2Cop3FKuuKPUftSWSswYY98/znegpGpfpNmemWzdM3Ry6HGKEivrSPtYKHnvKqfOW4JI0ZuTSzS
 wWHJ8DaIBE6hMy0RPbPzrNmXjZo/yWY72fuopIJTrBdd6osGVguF9NDMF1i3MQnLd6Deso57pVF
 QEw08FTmkEX81qCYzZA==
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=69dca2ae cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=FW10I0WjtUwoV23t3qsA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 281M95BKDiSnfXRVlFf6BgFgbSyEd5ss
X-Proofpoint-ORIG-GUID: 281M95BKDiSnfXRVlFf6BgFgbSyEd5ss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130077

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


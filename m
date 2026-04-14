Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DE3EBF39
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180837; cv=none; b=HaYiAnepMpM88vJBlbSf+aOihQ8bONqPy7RNM2BkLUqSXQ8aDvu+YUeb9BjWCMuGskypH1YIrZ3gA+8kGr+KM5Zn+S0mjJByHQw7weuP4+7NSD5t9/quH5erGVfryf0/ZoBwnSuJKgaSCWRVyYq/HzxZUEwgAIWbTlUZJiFISiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180837; c=relaxed/simple;
	bh=Lrud2Z0tGGhl+VnCuJ1LlC8xsqXINEr+qSBF9ZE+7pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ws2y3XN0U9NfHgdjFZtUif8iJSDFMUk/QE220nDXOxkIyD3vcrpaUTBKkGAUlvhejoVqzuChxjuSypQ0vaTSwr8hyIGtAr2sm+w/1Li1Lm8EPH8Wzw/wi80n1KQw6IPiZ7u+QLh2i9WwveVrmw8nZMiTwGwtbbzWUaRe5yIrxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OXJhwK+W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hf49wfzE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OXJhwK+W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hf49wfzE"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EBrt3X3681505
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dvvuScVK2b2
	/eF2Gcyoy/wJNo8yVtoSIJIFXCZVtXyA=; b=OXJhwK+WZ5kKQOrJ7Hc2dDcS296
	1iPIvcDt7j+ZRyeIHUfaqt6SWI/3aL8wM/46dJe9CzuqsYWlaLfY8s21EsYcurDC
	SjNMiySI3opZxIIo3XM/wMBrgKVi4Ya4Bsub1Unnu/Q8YOXlHbt4SPXb4ej7M8vf
	EwS5Mqm6PE9agrj71gk0VHBVRi0hX2N4fGdPD7vu1OQPHwbtnFqzbEicgF7zCeQO
	vc0ABHN4IPJbF4n75k15XcJcCOaOf1XvX7j71CbTVGQSyix5gClGU0MZWmTL6sOT
	HfLrg8UBogD9rjIDl8h9WTeorEWYQuvq2xNcBvfUhRSGD2GIx/lQPKGlGmw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87d3ams-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:33:55 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f5f48458eso155249b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776180834; x=1776785634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvvuScVK2b2/eF2Gcyoy/wJNo8yVtoSIJIFXCZVtXyA=;
        b=hf49wfzEYv3biJ8LP1CiozBVBLuuEUeqTk3wMWrVpy5yelRD1DAV/7bU4D1ZpTQukM
         3nC/hrDLLvWumUZJBigGgeb+jux5esTbgxscOgO3RkF/4C1McSLVcg0BB2XD3lgjr3/F
         L7Fd+eW6AVpO2dHNgeVCMmk1Wogsb0RzlRR4OIA+bBnv+xRJ0fke92lWL6Lyr87I9+/x
         3Qx+CJGKKBc0qSRuKTIOv8cLD+RN1naoNd3c6BNasyTryuKFgUmRorqbAmj+LwfsoxuR
         FsHFOJWyYn5uAglRyCMOM63cUlAeLvr6unj4W6IngXGi4GWmle//uPFUP7oVDJ04cVNb
         hPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776180834; x=1776785634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dvvuScVK2b2/eF2Gcyoy/wJNo8yVtoSIJIFXCZVtXyA=;
        b=SsvqmJLfs3ytzxZYof/IHOIzamokXFjj2FQuAbcDFdrUdEhDfOpiNjkua80UOAxQ7e
         hmVOPwRbp3AJspBnaWWnzW/wtsTAXmXa0hlz+nVu6jvSgeVERl8tWRTv4WlXUibHckdZ
         Py2f5aaqtC7mZhijKQc3eqEULYimeamRNnmdydEpfOOt/45yOpu1buX+gWTpRk55KDfH
         7mf31jUg1ckXUbI3bbSOkwtZZP9gmNrFXlC/LlqaAx20zOL4V0YcV7WdVgkaUkX5ItQa
         pTDDvLYvXceVny0ARO0LdmJHcIUEK7k3A8+Lf5uZqVqvlaYM7ggEDNo2KBEon58L0Iea
         IyWw==
X-Gm-Message-State: AOJu0Yw77VvUOT70O6caETgPC4oJ/jF26YANpRiWQenYqoh/2ORr6Wc2
	55TUIc7bdWOoHBg5uBUbk530Zt7rmPuersN88Rg14CmErZA5YwOZS+Q1A3NnsOuIEUUYvy+tF0T
	kHPqyds+yFetYDgRRr2kh2xa5rCCr8TXtW006BxZHuwtSuKrr+YwS+rsDYzy80niMEDtNBmtBlP
	wLs3Q=
X-Gm-Gg: AeBDietlCmaHGCLNQfg6Ue1wL1ocCtmQUMymxAlbN/t5D/J/1KHEiy5deOcvBu2pQYe
	OMm3CZa0hJH+AUdO2E8Ji8ggMHFib01T28EWHS6pq3YzHYdx6uhiWdNEr1MLAudjAdCW8haC69O
	llLyL7e/tVV3h3Alv7soa6mvt9bdGe/Obkf+WeMExLZI0tZyFDPi9zyg4oO3PHaFTUENrVu407F
	wsU5dWrLaU69h929HxZD7lBBYGM9DO8EVaVVIiMlgzMJ1p95xIkrpipl+3gsfqON9VkCNZ2awYF
	8sZwHhair/o9tOj7eY5p75voEx59HS1WDeS451mBFBHL6DpySW1Qj0UK/P7bx8Iw4xbceS4qZjV
	UkZAfhdXkSNrxBXeF96eUlwuep0Omz17VgrR1asTExKJGsCXIm74=
X-Received: by 2002:a05:6a00:2e9d:b0:82f:48e:2421 with SMTP id d2e1a72fcca58-82f0c29c84amr17856592b3a.24.1776180833624;
        Tue, 14 Apr 2026 08:33:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e9d:b0:82f:48e:2421 with SMTP id d2e1a72fcca58-82f0c29c84amr17856557b3a.24.1776180833053;
        Tue, 14 Apr 2026 08:33:53 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4e182csm15025163b3a.45.2026.04.14.08.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:33:52 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com, prathibha.madugonde@oss.qualcomm.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v6 2/3] main.conf: Add Channel Sounding config parsing  support
Date: Tue, 14 Apr 2026 21:03:34 +0530
Message-Id: <20260414153335.3169542-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414153335.3169542-1-naga.akella@oss.qualcomm.com>
References: <20260414153335.3169542-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0NSBTYWx0ZWRfX7vrsMxjgQfZS
 Sl/NJsID323j9UHu1PwIdA0pNjpxDX8OclURvCws2d4675pH9CiyM4FMoU1/lvs6cHMUDjWzB84
 5CraZnc6CejXw8hz3WZoSWretY9gx7AolGnR6WWVaOXnhdDmIpsC7IEBrO/CStwDUYbxi+6VA3z
 N+15/SZ1tX59ECp3Ups2xvcwpbJ+aamZPi8yIir+IcpDPDIaU9F2uQWoZrGpr4zTuyJ/VXW+1lt
 +E+SY3x8z9agGi8BVbsbvppyt8KF0QS4G6bfyfh8R2puokCzbW9SRUDfTqvCeTWsBTevSLo156p
 VuNnv+AOGa4viKJCRZudpWoBbDkjr7JwqZfSPy6QNnGyQKaoyz1qhiPi/mPDIV1FjXal7EYlOQM
 GcxGafHTZMSrayOxRO6tiFMrVxdZMRCdUxsKBTxHyCp87qdRxWPnramnxCkwgqCp77GH7+DjSd8
 +ggkNKiFx0/kz8egzPQ==
X-Authority-Analysis: v=2.4 cv=N+8Z0W9B c=1 sm=1 tr=0 ts=69de5e63 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=FW10I0WjtUwoV23t3qsA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: rxGuJT928kKWc25wMZyKlnX3fEne_CHi
X-Proofpoint-ORIG-GUID: rxGuJT928kKWc25wMZyKlnX3fEne_CHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140145

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


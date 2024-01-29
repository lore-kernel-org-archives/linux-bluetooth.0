Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C284D3F9F9
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560931; cv=none; b=UdcNp9fZ8SBST4s22BRTAUDYvSb2wbvfrdmgMWdla4DVt3QJlFyERwrjl4OCeMYhPc+XdaZVgPy5bPEbPFwGzdhxsWgaXWrVZdnOY4A9hhAQ0+PqdgqcAcat6k8KNpnFj4W2C3EhdQ6QHvLvootIzH1CLFvWmiOlBfUa7TeTM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560931; c=relaxed/simple;
	bh=bpFX5NtAy6aVkXxXYEuUxzk6G9DtcHhIqyqdsiJ2TK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyggizK5zg2yHvCuw5BxZ9Nir8jsCX8WqlMDnyuoBnAIecLEgAfkYWOA3jpG0Y/UyJSsQdu7YslNtenjOxHut5ceWkRWixdWyHI+TrC6lwX5ZOjRixh4LUuROX8lIXRlcxZAuQgxUVZzk3wGO6Rk08tUfBGKCpLkjVySWF7p+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=fyqry+/7; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="fyqry+/7"
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 00A2F12000F;
	Mon, 29 Jan 2024 23:42:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 00A2F12000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706560925;
	bh=fynVx2HmIEQSm859yCYpKea9okrihWm33TI3vGvnScs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=fyqry+/70tbxwaeJNgcyluR40uHbmyApfcFB/HOKfdR1wKpZh1xJ9wqaQ2UmEDT/W
	 8+rX1ZG+EhI92s8k3akpgskIlSkmo8vyb1OiAtEQftNgEeLZjhUiI7F7Ccu5CRGWbw
	 3XvHcNmOkZtujKIiGSAIcX+U66rwipNisn8yhAqrxuofZC1EUwiNuwIKVyLMRsuCMw
	 DnNTcgA+N8bjDBp0zgptCdH/FoUQpmB2hikzAvsiJBEBpml3ISZn9kds/c4O+DEV18
	 yxZc2e8OBrB53QxqWbu0mamClbCiJg3pxBs+P3I8HfD6bWIhLtVPiH+dEb6xxVGy0U
	 RW7JSfiQReXWw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 29 Jan 2024 23:42:04 +0300 (MSK)
Received: from cab-wsm-0026722.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 23:42:04 +0300
From: Victor Pushkarev <VAnPushkarev@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <VAnPushkarev@salutedevices.com>, <sdfw_system_team@salutedevices.com>,
	<corvinus.v@gmail.com>
Subject: [PATCH BlueZ v1 1/2] main.conf: Introduce option to limit A2DP channels
Date: Mon, 29 Jan 2024 23:41:53 +0300
Message-ID: <20240129204154.95773-2-VAnPushkarev@salutedevices.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240129204154.95773-1-VAnPushkarev@salutedevices.com>
References: <20240129204154.95773-1-VAnPushkarev@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183024 [Jan 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: vanpushkarev@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/29 16:27:00 #23447558
X-KSMG-AntiVirus-Status: Clean, skipped

This introduces Channels which can be used to
limit the number of A2DP channels.

For new option this also adds a new group A2DP to config.

Signed-off-by: Victor Pushkarev <VAnPushkarev@salutedevices.com>
---
 src/btd.h     |  6 ++++++
 src/main.c    | 16 ++++++++++++++++
 src/main.conf |  5 +++++
 3 files changed, 27 insertions(+)

diff --git a/src/btd.h b/src/btd.h
index b7e7ebd61..3372bd7f5 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -104,6 +104,10 @@ struct btd_avdtp_opts {
 	uint8_t  stream_mode;
 };
 
+struct btd_a2dp_opts {
+	uint8_t		channels;
+};
+
 struct btd_advmon_opts {
 	uint8_t		rssi_sampling_period;
 };
@@ -148,6 +152,8 @@ struct btd_opts {
 
 	enum jw_repairing_t jw_repairing;
 
+	struct btd_a2dp_opts	a2dp;
+
 	struct btd_advmon_opts	advmon;
 
 	struct btd_csis csis;
diff --git a/src/main.c b/src/main.c
index b1339c230..7e74b9728 100644
--- a/src/main.c
+++ b/src/main.c
@@ -162,6 +162,11 @@ static const char *avdtp_options[] = {
 	NULL
 };
 
+static const char *a2dp_options[] = {
+	"Channels",
+	NULL
+};
+
 static const char *advmon_options[] = {
 	"RSSISamplingPeriod",
 	NULL
@@ -178,6 +183,7 @@ static const struct group_table {
 	{ "GATT",	gatt_options },
 	{ "CSIS",	csip_options },
 	{ "AVDTP",	avdtp_options },
+	{ "A2DP",	a2dp_options },
 	{ "AdvMon",	advmon_options },
 	{ }
 };
@@ -1130,6 +1136,13 @@ static void parse_avdtp(GKeyFile *config)
 	parse_avdtp_stream_mode(config);
 }
 
+static void parse_a2dp(GKeyFile *config)
+{
+	parse_config_u8(config, "A2DP", "Channels",
+				&btd_opts.a2dp.channels,
+				0, UINT8_MAX);
+}
+
 static void parse_advmon(GKeyFile *config)
 {
 	parse_config_u8(config, "AdvMon", "RSSISamplingPeriod",
@@ -1153,6 +1166,7 @@ static void parse_config(GKeyFile *config)
 	parse_gatt(config);
 	parse_csis(config);
 	parse_avdtp(config);
+	parse_a2dp(config);
 	parse_advmon(config);
 }
 
@@ -1194,6 +1208,8 @@ static void init_defaults(void)
 	btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
 	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
 
+	btd_opts.a2dp.channels = 0;
+
 	btd_opts.advmon.rssi_sampling_period = 0xFF;
 	btd_opts.csis.encrypt = true;
 }
diff --git a/src/main.conf b/src/main.conf
index 085c81a46..caeb82504 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -296,6 +296,11 @@
 # streaming: Use L2CAP Streaming Mode
 #StreamMode = basic
 
+[A2DP]
+# Maximum number of A2DP channels
+# Defaults to 0 (unlimited)
+#Channels = 0
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
2.39.3 (Apple Git-145)

